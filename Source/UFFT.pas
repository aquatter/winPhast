unit UFFT;

interface

uses Windows, Math, UType;

const
  FFTW_FORWARD        = -1;
  FFTW_BACKWARD        = 1;
  FFTW_UNALIGNED       = 2;
  FFTW_ESTIMATE        = 64;

// ������� �������� - Double !!!
procedure fftw_destroy_plan(plan : Pointer); cdecl; external 'FFTW3.DLL';
procedure fftw_execute(plan : Pointer); cdecl; external 'FFTW3.DLL';
function fftw_plan_dft_2d(ny, nx : Integer;
                          inData, outData : pointer;
                          sign : Integer;
                          flags : Longword) : Pointer; cdecl; external 'FFTW3.DLL';
function fftw_plan_dft_1d(n : Integer;
                          inData, outData : PDouble;
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
  {  ���� ����  }
  fwHemming  = 100; {  ���� ��������  }
  fwHann     = 101; {  ���� �����  }
  fwBartlett = 102; {  ���� ���������  }
  fwBlackMen = 103; {  ���� ��������  }
  fwRect     = 104; {  ������������� ����  }

{  �������� : ������� ������� ���������� ���� ��� �����. ���� ���������
              �� 0 �� WindowWidth - 1 � ���������� �� ��������.
   �������� : �. �����, "�������� ��������� �����������"  }
function FltWin(X, WindowWidth : TReal ; WindowType : Integer) : TReal;

procedure FindEnergy(iW, iH, iR : Integer;
                     var raArray : TRealArray;


procedure MakeEnergyNorm(iW, iH : Integer;
                         var raArrayIn, raArrayOut : TRealArray);

procedure Backward2dFFT(iW, iH : Integer; var raIn, raOut : TRealArray);
procedure Forward2dFFTReal(iW, iH : Integer; var raIn, raOut : TRealArray);
procedure Forward2dFFTComplex(iW, iH : Integer; var raIn, raOut : TRealArray);

procedure MakeMiddleNorm(iW, iH : Integer;
                         var raArrayIn, raArrayOut : TRealArray);

implementation

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
    4 : for I := 0 to YSize - 1 do
          for J := 0 to XSize - 1 do
            P[I * XSize + J] := Sqrt(Sqr(PC[(I * XSize + J)*2]) +
                                     Sqr(PC[(I * XSize + J)*2 + 1])) * K;
    8 :  for I := 0 to YSize - 1 do
          for J := 0 to XSize - 1 do
            P[I * XSize + J] := ArcTan2(PC[(I * XSize + J)*2 + 1], PC[(I * XSize + J)*2]) + Pi;
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

{  �������� : ������� ������� ���������� ���� ��� �����. ���� ���������
              �� 0 �� WindowWidth - 1 � ���������� �� ��������.
   �������� : �. �����, "�������� ��������� �����������"  }
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







































procedure MakeMiddleNorm(iW, iH : Integer;
                         var raArrayIn, raArrayOut : TRealArray);

















procedure Forward2dFFTReal(iW, iH : Integer; var raIn, raOut : TRealArray);
var
  plan : Pointer;
begin
  // ��������� ������� ������ � ����������� �������� ������ ������������� �����
  Real2ComplexArray(iW, iH, raOut, raIn, 1);
  // ������� ������ � ����� - ����� ������ ���� ���������� ���
  PrepareComplexArray4FFT(iW, iH, raOut);
  // ��������� ���� ��� �����
  plan := fftw_plan_dft_2d(iH, iW, Addr(raOut[0]), Addr(raOut[0]),
                           FFTW_FORWARD, FFTW_ESTIMATE);
  // ��������� �����
  fftw_execute(plan);
  // ���������� ����
  fftw_destroy_plan(plan);
end;

procedure Forward2dFFTComplex(iW, iH : Integer; var raIn, raOut : TRealArray);
var
  plan : Pointer;
begin
  CopyMemory(Addr(raOut[0]), Addr(raIn[0]), iW * iH * 2 * SizeOf(TReal));
  // ������� ������ � ����� - ����� ������ ���� ���������� ���
  PrepareComplexArray4FFT(iW, iH, raOut);
  // ��������� ���� ��� �����
  plan := fftw_plan_dft_2d(iH, iW, Addr(raOut[0]), Addr(raOut[0]),
                           FFTW_FORWARD, FFTW_ESTIMATE);
  // ��������� �����
  fftw_execute(plan);
  // ���������� ����
  fftw_destroy_plan(plan);
end;


procedure Backward2dFFT(iW, iH : Integer; var raIn, raOut : TRealArray);
var
  plan : Pointer;
begin
  // ��������� ���� ��� �����
  plan := fftw_plan_dft_2d(iH, iW, Addr(raIn[0]), Addr(raOut[0]),
                           FFTW_BACKWARD, FFTW_ESTIMATE);
  // ��������� �����
  fftw_execute(plan);
  // ���������� ����
  fftw_destroy_plan(plan);
  // ������� ������ ����� ����� - ����� ����������� ����� ���������� ���
  PrepareComplexArray4FFT(iW, iH, raOut);
end;

end.
 