unit UFFT;

interface

uses Windows, Math, UType;

const
  FFTW_FORWARD         = -1;
  FFTW_BACKWARD        = 1;
  FFTW_UNALIGNED       = 2;
  FFTW_ESTIMATE        = 64;
  FFTW_EXHAUSTIVE      = 1 shl 3;
  FFTW_MEASURE         = 0;
  FFTW_WISDOM_ONLY     = 1 shl 21;
  FFTW_PATIENT         = 1 shl 5;


// Двойная точность - Double !!!

procedure fftw_forget_wisdom; cdecl; external 'FFTW3.DLL';
function fftw_export_wisdom_to_string: PChar; cdecl; external 'FFTW3.DLL';
function fftw_import_wisdom_from_string(input_string: PChar): integer; cdecl; external 'FFTW3.DLL';

procedure fftw_export_wisdom_to_file(var output_file: file); cdecl; external 'FFTW3.DLL';
procedure fftw_import_wisdom_from_file(var input_file: file); cdecl; external 'FFTW3.DLL';

procedure fftw_destroy_plan(plan : Pointer); cdecl; external 'FFTW3.DLL';
procedure fftw_execute(plan : Pointer); cdecl; external 'FFTW3.DLL';
function fftw_plan_dft_2d(ny, nx : Integer;
                          inData, outData : pointer;
                          sign : Integer;
                          flags : Longword) : Pointer; cdecl; external 'FFTW3.DLL';
function fftw_plan_dft_1d(n : Integer;
                          inData, outData : pointer;
                          sign : Integer;
                          flags : Longword) : Pointer; cdecl; external 'FFTW3.DLL';

// Одинарная точность - Single !!!
procedure fftwf_destroy_plan(plan : Pointer); cdecl; external 'FFTW3.DLL';
procedure fftwf_execute(plan : Pointer); cdecl; external 'FFTW3.DLL';
function fftwf_plan_dft_2d(ny, nx : Integer;
                           inData, outData : PSingle;
                           sign : Integer;
                           flags : Longword) : Pointer; cdecl; external 'FFTW3.DLL';
function fftwf_plan_dft_1d(n : Integer;
                           inData, outData : PSingle;
                           sign : Integer;
                           flags : Longword) : Pointer; cdecl; external 'FFTW3.DLL';


procedure Complex2RealArray(XSize, YSize : Integer;
                            var PC, P : TRealArray;
                            HowTo : Integer;
                            MakeNorm : Boolean);

procedure Real2ComplexArray(XSize, YSize : Integer;
                            var PC, P : TRealArray;
                            HowTo : Integer);

procedure PrepareComplexArray4FFT(XSize, YSize : Integer;
                                  var PC : TRealArray);

const
  {  Типы окон  }
  fwHemming  = 100; {  Окно Хэмминга  }
  fwHann     = 101; {  Окно Ханна  }
  fwBartlett = 102; {  Окно Бартлетта  }
  fwBlackMen = 103; {  Окно Блэкмена  }
  fwRect     = 104; {  Прямоугольное окно  }

{  Описание : Весовые функции рпазличных окон для фурье. Окно меняеться
              от 0 до WindowWidth - 1 с максимумом по середине.
   Источник : У. Прэтт, "Цифровая обработка изображений"  }
function FltWin(X, WindowWidth : TReal ; WindowType : Integer) : TReal;

procedure FindEnergy(iW, iH, iR : Integer;
                     var raArray : TRealArray;
                     var rEnergy : TReal);

procedure MakeEnergyNorm(iW, iH : Integer;
                         var raArrayIn, raArrayOut : TRealArray); overload;

procedure MakeEnergyNorm(iW, iH : Integer;
                         var raArrayIn, raArrayOut : TBtArr); overload;

procedure Backward2dFFT(iW, iH : Integer; var raIn, raOut : TRealArray);
procedure Forward2dFFTReal(iW, iH : Integer; var raIn, raOut : TRealArray);
procedure Forward2dFFTComplex(iW, iH : Integer; var raIn, raOut : TRealArray);

procedure MakeMiddleNorm(iW, iH : Integer;
                         var raArrayIn, raArrayOut : TRealArray);
                     
implementation

uses UCATool;

procedure Complex2RealArray(XSize, YSize : Integer;
                            var PC, P : TRealArray;
                            HowTo : Integer;
                            MakeNorm : Boolean);
var
  I, J : Integer;
  K : TReal;
begin
  if MakeNorm then K := 1 / XSize /YSize else K := 1;
  case HowTo of
    1 : for I := 0 to YSize - 1 do
          for J := 0 to XSize - 1 do
            P[I * XSize + J] := PC[(I * XSize + J)*2] * K;
    2 : for I := 0 to YSize - 1 do
          for J := 0 to XSize - 1 do
            P[I * XSize + J] := PC[(I * XSize + J)*2 + 1] * K;
    4 : begin
          for I := 0 to YSize - 1 do
            for J := 0 to XSize - 1 do
              P[I * XSize + J] := Sqrt(Sqr(PC[(I * XSize + J)*2]) +
                Sqr(PC[(I * XSize + J)*2 + 1])) * K;
        end;
    8 :  for I := 0 to YSize - 1 do
          for J := 0 to XSize - 1 do
            P[I * XSize + J] := ArcTan2(PC[(I * XSize + J)*2 + 1],
              PC[(I * XSize + J)*2]);
  end;
end;

procedure Real2ComplexArray(XSize, YSize : Integer;
                            var PC, P : TRealArray;
                            HowTo : Integer);
var
  I, J : Integer;
begin
  case HowTo of
    1 : for I := 0 to YSize - 1 do
          for J := 0 to XSize - 1 do begin
            PC[(I * XSize + J)*2] := P[I * XSize + J];
            PC[(I * XSize + J)*2 + 1] := 0;
          end;
    2 :  for I := 0 to YSize - 1 do
          for J := 0 to XSize - 1 do begin
            PC[(I * XSize + J)*2 + 1] := P[I * XSize + J];
            PC[(I * XSize + J)*2] := 0;
          end;
  end;
end;

procedure PrepareComplexArray4FFT(XSize, YSize : Integer;
                                  var PC : TRealArray);
var
  I, J : Integer;
begin
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do begin
      PC[(I * XSize + J)*2] := PC[(I * XSize + J)*2]*Power(-1, I + J);
      PC[(I * XSize + J)*2 + 1] := PC[(I * XSize + J)*2 + 1]*Power(-1, I + J);
    end;
end;

{  Описание : Весовые функции рпазличных окон для фурье. Окно меняеться
              от 0 до WindowWidth - 1 с максимумом по середине.
   Источник : У. Прэтт, "Цифровая обработка изображений"  }
function FltWin(X, WindowWidth : TReal ; WindowType : Integer) : TReal;
var
  N : TReal;
begin
  if (Abs(X) > WinDowWidth / 2) then FltWin := 0
  else begin
    N := X + WindowWidth / 2;
    case WindowType of
      fwHemming  : FltWin := 0.54 - 0.46 * Cos(2 * Pi * N / (WindowWidth - 1));
      fwHann     : FltWin := 0.5 * (1 - Cos(2 * Pi * N / (WindowWidth - 1)));
      fwBartlett : if (N <= WindowWidth / 2) then FltWin := 2 * N / (WindowWidth - 1)
                   else FltWin := 2 - 2 * N / (WindowWidth - 1);
      fwBlackMen : FltWin := 0.42 - 0.5 * Cos(2 * Pi * N / (WindowWidth - 1)) +
                             0.08 * Cos(4 * Pi * N / (WindowWidth - 1));
      fwRect     : FltWin := 1;
    end;
  end;
end;

procedure FindEnergy(iW, iH, iR : Integer;
                     var raArray : TRealArray;
                     var rEnergy : TReal);
var
  iCenX, iCenY, iY, iX : Integer;
begin
  iCenX := iW div 2;
  iCenY := iH div 2;
  rEnergy := 0.0;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      if Sqrt(Sqr(iX - iCenX) + Sqr(iY - iCenY)) <= iR then
        rEnergy := rEnergy + raArray[iY * iW + iX];
end;

procedure MakeEnergyNorm(iW, iH : Integer;
                         var raArrayIn, raArrayOut : TBtArr); overload;
var
  iY, iX : Integer;
  rIntegral, rIntegralSqr : TReal;
begin
  // Ищем интеграл квадрата
  rIntegralSqr := 0;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      rIntegralSqr := rIntegralSqr + Sqr(raArrayIn[iY * iW + iX]);
  // Мало ли
  if rIntegralSqr = 0 then Exit;
  // делим на него и параллельно ищем интеграл простой
  rIntegral := 0;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      raArrayOut[iY * iW + iX] := round(raArrayIn[iY * iW + iX] / Sqrt(rIntegralSqr));
      rIntegral := rIntegral + raArrayOut[iY * iW + iX];
    end;
  // вычитаем простой интеграл
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      raArrayOut[iY * iW + iX] := raArrayOut[iY * iW + iX] - round(rIntegral);
end;


procedure MakeEnergyNorm(iW, iH : Integer;
                         var raArrayIn, raArrayOut : TRealArray);
var
  iY, iX : Integer;
  rIntegral, rIntegralSqr : TReal;
begin
  // Ищем интеграл квадрата
  rIntegralSqr := 0;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      rIntegralSqr := rIntegralSqr + Sqr(raArrayIn[iY * iW + iX]);
  // Мало ли
  if rIntegralSqr = 0 then Exit;
  // делим на него и параллельно ищем интеграл простой
  rIntegral := 0;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      raArrayOut[iY * iW + iX] := raArrayIn[iY * iW + iX] / Sqrt(rIntegralSqr);
      rIntegral := rIntegral + raArrayOut[iY * iW + iX];
    end;
  // вычитаем простой интеграл
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      raArrayOut[iY * iW + iX] := raArrayOut[iY * iW + iX] - rIntegral;
end;

procedure MakeMiddleNorm(iW, iH : Integer;
                         var raArrayIn, raArrayOut : TRealArray);
var
  iY, iX : Integer;
  rIntegral, rIntegralSqr : TReal;
begin
  // Ищем интеграл квадрата
  rIntegral := 0;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      rIntegral := rIntegral + raArrayIn[iY * iW + iX];
  // Мало ли
  if rIntegral = 0 then Exit;
  // вычитаем его
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      raArrayOut[iY * iW + iX] := raArrayIn[iY * iW + iX] - rIntegral;
end;

procedure Forward2dFFTReal(iW, iH : Integer; var raIn, raOut : TRealArray);
var
  plan : Pointer;
begin
  // Переводим входной массив в комплексный заполняя только дествительную часть
  Real2ComplexArray(iW, iH, raOut, raIn, 1);
  // Готовим массив к фурье - чтобы спектр имел нормальный вид
  PrepareComplexArray4FFT(iW, iH, raOut);
  case SizeOf(TReal) of
    4 : begin
          // Формируем план для фурье
          plan := fftwf_plan_dft_2d(iH, iW, Addr(raOut[0]), Addr(raOut[0]),
                                   FFTW_FORWARD, FFTW_ESTIMATE);
          // Выполняем фурье
          fftwf_execute(plan);
          // Уничтожаем план
          fftwf_destroy_plan(plan);
        end;
    8 : begin
          // Формируем план для фурье
          plan := fftw_plan_dft_2d(iH, iW, Addr(raOut[0]), Addr(raOut[0]),
                                   FFTW_FORWARD, FFTW_ESTIMATE);
          // Выполняем фурье
          fftw_execute(plan);
          // Уничтожаем план
          fftw_destroy_plan(plan);
        end;
  end;
end;

procedure Forward2dFFTComplex(iW, iH : Integer; var raIn, raOut : TRealArray);
var
  plan : Pointer;
begin
  CopyMemory(Addr(raOut[0]), Addr(raIn[0]), iW * iH * 2 * SizeOf(TReal));
  // Готовим массив к фурье - чтобы спектр имел нормальный вид
  PrepareComplexArray4FFT(iW, iH, raOut);
  case SizeOf(TReal) of
    4 : begin
          // Формируем план для фурье
          plan := fftwf_plan_dft_2d(iH, iW, Addr(raOut[0]), Addr(raOut[0]),
                                   FFTW_FORWARD, FFTW_ESTIMATE);
          // Выполняем фурье
          fftwf_execute(plan);
          // Уничтожаем план
          fftwf_destroy_plan(plan);
        end;
    8 : begin
          // Формируем план для фурье
          plan := fftw_plan_dft_2d(iH, iW, Addr(raOut[0]), Addr(raOut[0]),
                                   FFTW_FORWARD, FFTW_ESTIMATE);
          // Выполняем фурье
          fftw_execute(plan);
          // Уничтожаем план
          fftw_destroy_plan(plan);
        end;
  end;
end;


procedure Backward2dFFT(iW, iH : Integer; var raIn, raOut : TRealArray);
var
  plan : Pointer;
begin
  case SizeOf(TReal) of
    4 : begin
          // Формируем план для фурье
          plan := fftwf_plan_dft_2d(iH, iW, Addr(raIn[0]), Addr(raOut[0]),
                                   FFTW_BACKWARD, FFTW_ESTIMATE);
          // Выполняем фурье
          fftwf_execute(plan);
          // Уничтожаем план
          fftwf_destroy_plan(plan);
        end;
    8 : begin
          // Формируем план для фурье
          plan := fftw_plan_dft_2d(iH, iW, Addr(raIn[0]), Addr(raOut[0]),
                                   FFTW_BACKWARD, FFTW_ESTIMATE);
          // Выполняем фурье
          fftw_execute(plan);
          // Уничтожаем план
          fftw_destroy_plan(plan);
        end;
  end;
  // Готовим массив после фурье - чтобы изображение имело нормальный вид
  PrepareComplexArray4FFT(iW, iH, raOut);
end;

end.
 