unit UFiltr;

interface

uses Windows, Math, UType, UFFT, URATool, Graphics;

procedure RAFilterHistoThreshold(iW, iH, iProcentmin, iProcentMax : Integer;
                                 var raIn, raOut : TRealArray);

procedure RAFilterGaussianMaskOutBad(iW, iH, iWinSize : Integer;
                                     rSigma : TReal;
                                      var raIn, raMask, raOut : TRealArray); overload;
procedure RAFilterGaussianMaskOutBad(iW, iH, iWinSize: Integer;
                                     rSigma: TReal;
                                     var raIn, raOut: TRealArray;
                                     var raMask: TBtArr); overload;

procedure RAFilterGaussianMaskOutBadFloodFill(w, h, _w: Integer;
                                              rSigma: TReal;
                                              var raIn, raOut: TRealArray;
                                              var raMask: TBtArr);

procedure RAFilterLinearMask(iW, iH, iWinSize : Integer;
                             var raIn, raMask, raOut : TRealArray);

procedure RAFilterHistoRaiseLocal(iW, iH, iWinSize : Integer;
                                  var raIn, raOut, raMask : TRealArray); overload;

procedure RAFilterHistoRaiseLocal(iW, iH, iWinSize : Integer;
                                  var raIn, raOut: TRealArray; var raMask: TBtArr); overload;


procedure RAFilterMedianSqrMask(iW, iH, iWinSize : Integer;
                                var raIn, raOut, raMask : TRealArray); overload;

procedure RAFilterMedianSqrMask(iW, iH, iWinSize : Integer;
                                var raIn, raOut: TRealArray;
                                var raMask: TBtArr); overload;

procedure RAFilterMedianMask(iW, iH, iWinSize : Integer;
                             var raIn, raOut, raMask : TRealArray);

procedure RAFilterGaussianMask(iW, iH, iWinSize : Integer;
                               rSigma : TReal;
                               var raIn, raMask, raOut : TRealArray);

procedure RAFilterGaussian(iW, iH, iWinSize : Integer;
                           rSigma : TReal;
                           var raIn, raOut : TRealArray);


procedure FilterDiffSobel(iW, iH : Integer;
                          var raIn, raOut : TRealArray);

// Амплитудная фильтрация
procedure MaskAmplFilt(size_x, size_y : integer;
                       MinZ, MaxZ : TReal;
                       var Matrix : TRealArray;
                       var Matrix_FinalPicture : TRealArray);

// Амплитудная фильтрация
procedure MaskAmplFiltMod(size_x, size_y : integer;
                          MinZ, MaxZ : TReal;
                          var Matrix : TRealArray;
                          var Matrix_FinalPicture : TRealArray);

// Гауссов фильтр
procedure DiffFiltration(size_x, size_y, windowtype : integer;
                         var Matrix, Matrix_FinalPicture : TRealArray);

procedure ExtremalFiltration(size_x, size_y, filtersizex, filtersizey, windowtype : integer;
                             var Matrix, Matrix_FinalPicture : TRealArray);

// Обратная Гамма коррекция
procedure GammaCorrection(size_x, size_y : integer;
                          PowerNum : TReal;
                          var PRAInput, PRAOutput : TRealArray); overload;
procedure GammaCorrection(size_x, size_y : integer;
                          PowerNum : TReal;
                          var PRAInput: TBtArr; var PRAOutput : TRealArray); overload;




// Тригонометрический фильтр для фильтрации несшитой фазы
procedure TrigonometricFiltration(size_x, size_y,
                                  filtersizex, filtersizey,
                                  RepeatNum,
                                  FilterType : integer;
                                  var PRAInput, PRAOutput : TRealArray);

procedure MedianFiltration(size_x, size_y, filtersizex, filtersizey : integer;
                           var Matrix, Matrix_FinalPicture : TRealArray);

procedure GaussianFiltration(size_x, size_y, filtersizex, filtersizey : integer;
                             var Matrix, Matrix_FinalPicture : TRealArray);

// Линейная двухмерная фильтрация прямоугольником
procedure LinearFiltration(size_x, size_y, filtersizex, filtersizey : integer;
                           var Matrix, Matrix_FinalPicture : TRealArray);

// Амплитудная фильтрация
procedure AmplitudeFiltration(size_x, size_y : integer;
                              MinZ, MaxZ : TReal;
                              var Matrix, Matrix_FinalPicture : TRealArray);

procedure FurierFiltration(iW, iH, iWinSize : Integer;
                           var raIn, raOut : TRealArray);

procedure EdgePrepare(iW, iH : Integer;
                      var raIn, raOut : TRealArray);

procedure FurierFiltrationSharp(iW, iH, iWinSize : Integer;
                                var raIn, raOut : TRealArray);

procedure LogarithmFltr(iW, iH : Integer; var raIn, raOut : TRealArray);

procedure RAFiltMedianMask(size_x, size_y, filtersizex, filtersizey : integer;
                           var Matrix, Matrix_FinalPicture, raMask : TRealArray);

procedure ApodisFltr(iW, iH : Integer; var raIn, raOut : TRealArray);

implementation

uses UUnwrap;

const
  // 1/6
  Previtt13x3 : array [0..8] of Integer = (-1, -1, -1,
                                          0, 0, 0,
                                          1, 1, 1);
  // 1/6
  Previtt23x3 : array [0..8] of Integer = (-1, 0, 1,
                                          -1, 0, 1,
                                          -1, 0, 1);
  Sobel13x3 : array [0..8] of Integer = (-1, -2, -1,
                                          0, 0, 0,
                                          1, 2, 1);
  Sobel23x3 : array [0..8] of Integer = (-1, 0, 1,
                                          -2, 0, 2,
                                          -1, 0, 1);
  Laplacian13x3 : array [0..8] of Integer = (0, 1, 0,
                                             1, -4, 1,
                                             0, 1, 0);
  // 1/3
  Laplacian23x3 : array [0..8] of Integer = (2, -1, 2,
                                             -1, -4, -1,
                                             2, -1, 2);

procedure RAFilterHistoThreshold(iW, iH, iProcentmin, iProcentMax : Integer;
                                 var raIn, raOut : TRealArray);
var
  piaHistogram : PIntegerArray;
  iMax, iCount : Integer;
  rMaxIN, rMinIn, rNum, rMax, rMin  : Treal;
begin
  FindMaxMinRealArray(iW, iH, raIn, rMaxIn, rMinIn);
  if rMaxIn - rMinIn <> 0 then begin
    GetMem(piaHistogram, 256 * SizeOf(Integer));
    // Ищем гистограмму
//    RAGetHistogram(iW, iH, raIn, piaHistogram^);
    // Ищем края на гистограмме
    iMax := 0;
    for iCount := 0 to 255 do begin
      piaHistogram^[iCount] := Round(Ln(piaHistogram^[iCount] + 1));
      if iMax < piaHistogram^[iCount] then iMax := piaHistogram^[iCount];
    end;
    rNum := iMax * iProcentMin / 100;
    iCount := 0;
    while (piaHistogram^[iCount] < rNum) and (iCount < 255) do Inc(iCount);
    rMin := iCount * (rMaxIn - rMinIn) / 255 + rMinIn;
    rNum := iMax * iProcentMax / 100;
    iCount := 1;
    while (piaHistogram^[iCount] < rNum) and (iCount > 0) do Dec(iCount);
    rMax := iCount * (rMaxIn - rMinIn) / 255 + rMinIn;
    // обрезаем по найденным краям
    for iCount := 0 to iW * iH - 1 do begin
      raOut[iCount] := raIn[iCount];
      if raIn[iCount] < rMin then raOut[iCount] := rMin;
      if raIn[iCount] > rMax then raOut[iCount] := rMax;
    end;
    FreeMem(piaHistogram, 256 * SizeOf(Integer));
  end;
end;

procedure RAFilterHistoRaiseLocal(iW, iH, iWinSize : Integer;
                                  var raIn, raOut, raMask : TRealArray);
var
  iWS2, iX, iY, iWinX, iWinY, iCount : Integer;
  rK, rB, rMax, rMin, rMinGlobal, rMaxGlobal, rTemp : TReal;
  praOut : pRealarray;
begin
  if iWinSize < 3 then Exit;
  if iWinSize mod 2 = 0 then Dec(iWinSize);
  // создаем временные массивы
  GetMem(praOut, iW * iH * SizeOf(TReal));
  // заполняем временные массивы
  CopyMemory(praOut, Addr(raIn[0]), iW * iH * SizeOf(TReal));
  // Ищем Максимум минимум входного массива
  FindMaxMinRealArray(iW, iH, raIn, rMaxGlobal, rMinGlobal);
  if rMaxGlobal - rMinGlobal = 0 then Exit;
  // Фильтруем
  iWS2 := iWinSize div 2;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do if raMask[iX + iY * iW] = 1 then begin
      // Переносим попавшее в окно вов временный массив
      rMin := MaxDouble;
      rMax := -MaxDouble;
      iCount := 0;
      for iWinY := -iWS2 to iWS2 do
        for iWinX := -iWS2 to iWS2 do
          if (iX + iWinX + (iY + iWinY) * iW > 0) and
             (iX + iWinX + (iY + iWinY) * iW < iW * iH - 1) then
            if raMask[iX + iWinX + (iY + iWinY) * iW] = 1 then begin
              rTemp := raIn[iX + iWinX + (iY + iWinY) * iW];
              if rTemp < rMin then rMin := rTemp;
              if rTemp > rMax then rMax := rTemp;
              Inc(iCount);
            end;
      // Растягиваем
      if (iCount > 0) then begin
        if (rMax - rMin <> 0) then begin
          rK := (rMaxGlobal - rMinGlobal) / (rMax - rMin);
          rB := rMaxGlobal - rK * rMax;
          praOut^[iX + iY * iW] := rK * raIn[iX + iY * iW] + rB;
//        for iWinY := -iWS2 to iWS2 do
//          for iWinX := -iWS2 to iWS2 do
//            if (iX + iWinX + (iY + iWinY) * iW > 0) and
//               (iX + iWinX + (iY + iWinY) * iW < iW * iH - 1) then
//              if raMask[iX + iWinX + (iY + iWinY) * iW] = 1 then begin
//                praOut^[iX + iWinX + (iY + iWinY) * iW] := rK *
//                  raIn[iX + iWinX + (iY + iWinY) * iW] + rB;
//              end;
        end
        else praOut^[iX + iY * iW] := rMaxGlobal;
      end;
    end;
  CopyMemory(Addr(raOut[0]), praOut, iW * iH * SizeOf(TReal));
  // освобождаем временные массивы
  FreeMem(praOut, iW * iH * SizeOf(TReal));
end;

procedure RAFilterHistoRaiseLocal(iW, iH, iWinSize : Integer;
                                  var raIn, raOut: TRealArray; var raMask: TBtArr); overload;
var
  iWS2, iX, iY, iWinX, iWinY, iCount : Integer;
  rK, rB, rMax, rMin, rMinGlobal, rMaxGlobal, rTemp : TReal;
  praOut : pRealarray;
begin
  if iWinSize < 3 then Exit;
  if iWinSize mod 2 = 0 then Dec(iWinSize);
  // создаем временные массивы
  GetMem(praOut, iW * iH * SizeOf(TReal));
  // заполняем временные массивы
  CopyMemory(praOut, Addr(raIn[0]), iW * iH * SizeOf(TReal));
  // Ищем Максимум минимум входного массива
  FindMaxMinRealArray(iW, iH, raIn, rMaxGlobal, rMinGlobal);
  if rMaxGlobal - rMinGlobal = 0 then Exit;
  // Фильтруем
  iWS2 := iWinSize div 2;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do if raMask[iX + iY * iW] = 1 then begin
      // Переносим попавшее в окно вов временный массив
      rMin := MaxDouble;
      rMax := -MaxDouble;
      iCount := 0;
      for iWinY := -iWS2 to iWS2 do
        for iWinX := -iWS2 to iWS2 do
          if (iX + iWinX + (iY + iWinY) * iW > 0) and
             (iX + iWinX + (iY + iWinY) * iW < iW * iH - 1) then
            if raMask[iX + iWinX + (iY + iWinY) * iW] = 1 then begin
              rTemp := raIn[iX + iWinX + (iY + iWinY) * iW];
              if rTemp < rMin then rMin := rTemp;
              if rTemp > rMax then rMax := rTemp;
              Inc(iCount);
            end;
      // Растягиваем
      if (iCount > 0) then begin
        if (rMax - rMin <> 0) then begin
          rK := (rMaxGlobal - rMinGlobal) / (rMax - rMin);
          rB := rMaxGlobal - rK * rMax;
          praOut^[iX + iY * iW] := rK * raIn[iX + iY * iW] + rB;
//        for iWinY := -iWS2 to iWS2 do
//          for iWinX := -iWS2 to iWS2 do
//            if (iX + iWinX + (iY + iWinY) * iW > 0) and
//               (iX + iWinX + (iY + iWinY) * iW < iW * iH - 1) then
//              if raMask[iX + iWinX + (iY + iWinY) * iW] = 1 then begin
//                praOut^[iX + iWinX + (iY + iWinY) * iW] := rK *
//                  raIn[iX + iWinX + (iY + iWinY) * iW] + rB;
//              end;
        end
        else praOut^[iX + iY * iW] := rMaxGlobal;
      end;
    end;
  CopyMemory(Addr(raOut[0]), praOut, iW * iH * SizeOf(TReal));
  // освобождаем временные массивы
  FreeMem(praOut, iW * iH * SizeOf(TReal));
end;

procedure LogarithmFltr(iW, iH : Integer; var raIn, raOut : TRealArray);
var
  rMin, rMax : TReal;
  iY, iX : Integer;
begin
  // Ищем Максимум минимум входного массива без нулей
  FindMaxMinRealArrayNonZero(iW, iH, raIn, rMax, rMin);
  // ежели отрицательный - поднимаем
  if rMin < 0 then NormRealArray(iW, iH, raOut, Abs(rMin), Abs(rMax));
  // значение в нулях
  if rMin <> 0 then rMin := Ln(Abs(rMin));
  // Логарифмируем
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      if raIn[iY * iW + iX] <> 0 then
        raOut[iY * iW + iX] := Ln(raIn[iY * iW + iX])
      else raOut[iY * iW + iX] := rMin;
  // нуль порядок      
  raOut[(iH div 2) * iW + (iW div 2)] := rMin;
  // Нормируем временный массив в диапазон 0..255
  NormRealArray(iW, iH, raOut, 0.0, 255.0);
end;

procedure ApodisFltr(iW, iH : Integer; var raIn, raOut : TRealArray);
var
  rR, rMin, rMax : TReal;
  iDX, iWX, iDY, iWY, iY, iX, dx_left, dx_right, dy_top, dy_bottom: Integer;
begin
  iDX := iW div 20;
  iDY := iH div 20;
  dx_left:=0;
  dx_right:=0;
  dy_top:=0;
  dy_bottom:=0;
  // Ищем Максимум минимум входного массива
//  FindMaxMinRealArray(iW, iH, raIn, rMax, rMin);
  // Фильтруем
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      rR := Sqrt(0.6*Sqr(iX - iW / 2) + 0.7*Sqr(iY - iH / 2){ * Sqr(iW / iH / 1.3)}) -
        iW / 2 + 2*iDX;
     // rR := Power(Power(iX - iW / 2, 2) + Power((iY - iH / 2) * (iW / iH), 2),
      //  1 / 2) - iW / 2 + iDX;
      if rR > 0 then raOut[iY * iW + iX] := raIn[iY * iW + iX] *
          FltWin(Round(rR), 2 * iDX, fwHann)
      else raOut[iY * iW + iX] := raIn[iY * iW + iX];
{      raOut[iY * iW + iX] := raIn[iY * iW + iX] *
        FltWin(Abs(iY - (iH div 2)), iH, fwHemming) *
        FltWin(Abs(iX - (iW div 2)), iW, fwHemming);}

     if ix < dx_left then
        iwx:=idx
      else
        if ix < (dx_left+idx) then
          iwx:=idx+dx_left-ix
        else
          if ix < (iw-1-idx-dx_right) then
            iwx:=0
          else
            if ix < (iw-1-dx_right) then
              iwx:=iw-1-dx_right-ix-idx
            else
              iwx:=idx;

      if iy < dy_top then
        iwy:=idy
      else
        if iy < (dy_top+idy) then
          iwy:=idy+dy_top-iy
        else
          if iy < (ih-1-idy-dy_bottom) then
            iwy:=0
          else
            if iy < (ih-1-dy_bottom) then
              iwy:=ih-1-dy_bottom-iy-idy
            else
              iwy:=idy;



    {  if iX < iDX then iWX := iDX - iX
      else if iX < iW - 1 - iDX then iWX := 0
        else iWX := iW - 1 - iX - iDX;}
      {if iY < iDY then iWY := iDY - iY
      else if iY < iH - 1 - iDY then iWY := 0
        else iWY := iH - 1 - iY - iDY;       }
      raOut[iY * iW + iX] := raIn[iY * iW + iX] *
        FltWin(iWX, 2*iDX, fwHann) * FltWin(iWY, 2*iDY, fwHann);
{
      raOut[iY * iW + iX] := raIn[iY * iW + iX] *
        FltWin(Abs(iY - (iH div 2)), iH, fwBartlett) *
        FltWin(Abs(iX - (iW div 2)), iW, fwBartlett);    }

    end;
  // Нормируем временный массив в диапазон 0..255
//  NormRealArray(iW, iH, raOut, rMin, rMax);
end;

procedure FurierFiltrationSharp(iW, iH, iWinSize : Integer;
                                var raIn, raOut : TRealArray);
var
  pcaFilt1 : PRealArray;
  iX, iY : Integer;
  rWindowMax, rR : TReal;
begin
  rWindowMax := 10;
  // выделяем память
  GetMem(pcaFilt1, iW * iH * 2 * SizeOf(TReal));
  // Прямое Фурье
  Forward2dFFTReal(iW, iH, raIn, pcaFilt1^);
  // фильтруем
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      rR := Sqrt(Sqr(iX - (iW div 2)) + Sqr(iY - (iH div 2)));
      if rR < 0.9 * iWinSize then begin
        pcaFilt1^[(iY * iW + iX) * 2] := pcaFilt1^[(iY * iW + iX) * 2] *
          Sqr(rR) * rWindowMax / Sqr(0.9 * iWinSize);
        pcaFilt1^[(iY * iW + iX) * 2 + 1] := pcaFilt1^[(iY * iW + iX) * 2 + 1] *
          Sqr(rR) * rWindowMax / Sqr(0.9 * iWinSize);
      end
      else begin
        pcaFilt1^[(iY * iW + iX) * 2] := pcaFilt1^[(iY * iW + iX) * 2]
          * FltWin(rR - 0.9 * iWinSize, Round(0.2 * iWinSize), fwHann) * rWindowMax;
        pcaFilt1^[(iY * iW + iX) * 2 + 1] := pcaFilt1^[(iY * iW + iX) * 2 + 1]
          * FltWin(rR - 0.9 * iWinSize, Round(0.2 * iWinSize), fwHann) * rWindowMax;
      end;
    end;
  // Обратное Фурье
  Backward2dFFT(iW, iH, pcaFilt1^, pcaFilt1^);
  Complex2RealArray(iW, iH, pcaFilt1^, raOut, 1, True);
  RAAdd(iW, iH, raIn, raOut, raOut);
  // освобождаем память
  FreeMem(pcaFilt1, iW * iH * 2 * SizeOf(TReal));
end;


procedure EdgePrepare(iW, iH : Integer;
                      var raIn, raOut : TRealArray);
const
  Edge3x3 : array [0..8] of Integer = (-1, -1, -1, -1, 9, -1, -1, -1, -1);
  LoG11x11 : array [0..120] of Integer =
    (0, 0, 0, -1, -1, -2, -1, -1, 0, 0, 0,
     0, 0, -2, -4, -8, -9, -8, -4, -2, 0, 0,
     0, -2, -7, -15, -22, -23, -22, -15, -7, -2, 0,
     -1, -4, -15, -24, -14, -1, -14, -24, -15, -4, -1,
     -1, -8, -22, -14, 52, 103, 52, -14, -22, -8, -1,
     -2, -9, -23, -1, 103, 181, 103, -1, -23, -9, -2,
     -1, -8, -22, -14, 52, 103, 52, -14, -22, -8, -1,
     -1, -4, -15, -24, -14, -1, -14, -24, -15, -4, -1,
     0, -2, -7, -15, -22, -23, -22, -15, -7, -2, 0,
     0, 0, -2, -4, -8, -9, -8, -4, -2, 0, 0,
     0, 0, 0, -1, -1, -2, -1, -1, 0, 0, 0);
var
  rWindowK, rSum : TReal;
  iWindowSize, iHalfWindow, iX, iY, iX2, iY2, iWindowIndex : Integer;
  piaWindow : PIntegerArray;
begin
  // заполняем временные массивы
  FillMemory(Addr(raOut[0]), iW * iH * SizeOf(TReal), 0);
  // Параметры окна
  piaWindow := Addr(Laplacian13x3);
  iWindowSize := 3;
  rWindowK := 1;
  // Фильтруем
  iHalfWindow := iWindowSize div 2;
  for iY := iHalfWindow to iH - 1 - iHalfWindow do
    for iX := iHalfWindow to iW - 1 - iHalfWindow do begin
      rSum := 0.0;
      iWindowIndex := 0;
      for iY2 := iY - iHalfWindow to iY + iHalfWindow do
        for iX2 := iX - iHalfWindow to iX + iHalfWindow do begin
          rSum := rSum + piaWindow^[iWindowIndex] * raIn[iY2 * iW + iX2];
          Inc(iWindowIndex);
        end;
      raOut[iY * iW + iX] := - rSum / rWindowK * 50 + raIn[iY * iW + iX];
    end;

{  piaWindow := Addr(Previtt23x3);
  iWindowSize := 3;
  rWindowK := 1;
  // Фильтруем
  iHalfWindow := iWindowSize div 2;
  for iY := iHalfWindow to iH - 1 - iHalfWindow do
    for iX := iHalfWindow to iW - 1 - iHalfWindow do begin
      rSum := 0.0;
      iWindowIndex := 0;
      for iY2 := iY - iHalfWindow to iY + iHalfWindow do
        for iX2 := iX - iHalfWindow to iX + iHalfWindow do begin
          rSum := rSum + piaWindow^[iWindowIndex] * raIn[iY2 * iW + iX2];
          Inc(iWindowIndex);
        end;
      raOut[iY * iW + iX] := raOut[iY * iW + iX] + rSum / rWindowK;
    end;}


end;

procedure FurierFiltration(iW, iH, iWinSize : Integer;
                           var raIn, raOut : TRealArray);
var
  pcaFilt1 : PRealArray;
  iX, iY : Integer;
begin
  // выделяем память
  GetMem(pcaFilt1, iW * iH * 2 * SizeOf(TReal));
  // Прямое Фурье
  Forward2dFFTReal(iW, iH, raIn, pcaFilt1^);
  // фильтруем
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      pcaFilt1^[(iY * iW + iX) * 2] := pcaFilt1^[(iY * iW + iX) * 2]
        * FltWin(Sqrt(Sqr(iX - (iW div 2)) + Sqr(iY - (iH div 2))), iWinSize, fwHann);
      pcaFilt1^[(iY * iW + iX) * 2 + 1] := pcaFilt1^[(iY * iW + iX) * 2 + 1]
        * FltWin(Sqrt(Sqr(iX - (iW div 2)) + Sqr(iY - (iH div 2))), iWinSize, fwHann);
    end;
  // Обратное Фурье
  Backward2dFFT(iW, iH, pcaFilt1^, pcaFilt1^);
  Complex2RealArray(iW, iH, pcaFilt1^, raOut, 1, True);
  // освобождаем память
  FreeMem(pcaFilt1, iW * iH * 2 * SizeOf(TReal));
end;

// Амплитудная фильтрация
procedure MaskAmplFilt(size_x, size_y : integer;
                       MinZ, MaxZ : TReal;
                       var Matrix : TRealArray;
                       var Matrix_FinalPicture : TRealArray);
var
  x, y : integer;
begin
  // Фильтруем
  for y := 0 to size_y - 1 do
    for x := 0 to size_x - 1 do
      if (Matrix[x + y*size_x] < MinZ) or (Matrix[x + y*size_x] > MaxZ) then
        Matrix_FinalPicture[x + y*size_x] := 0
      else Matrix_FinalPicture[x + y*size_x] := 1;
end;

// Амплитудная фильтрация
procedure MaskAmplFiltMod(size_x, size_y : integer;
                          MinZ, MaxZ : TReal;
                          var Matrix : TRealArray;
                          var Matrix_FinalPicture : TRealArray);
var
  x, y : integer;
begin
  // Фильтруем
  for y := 0 to size_y - 1 do
    for x := 0 to size_x - 1 do
      if (Abs(Matrix[x + y*size_x]) < MinZ) or (Abs(Matrix[x + y*size_x]) > MaxZ) then
        Matrix_FinalPicture[x + y*size_x] := 0
      else Matrix_FinalPicture[x + y*size_x] := 1;
end;

procedure MedianFiltration(size_x, size_y, filtersizex, filtersizey : integer;
                           var Matrix, Matrix_FinalPicture : TRealArray);
var
  schet, x, y, J, I : integer;
  temp_ : TReal;
  temp : pRealarray;
begin
  // создаем временные массивы
  GetMem(temp, filtersizex*filtersizey*SizeOf(TReal));
  // заполняем временные массивы
  for y := 0 to size_y - 1 do
    for x := 0 to size_x - 1 do
      Matrix_FinalPicture[y * size_x + x] := Matrix[y * size_x + x];
  // Фильтруем
  for y := filtersizey div 2 to size_y - 1 - (filtersizey div 2) do
    for x := filtersizex div 2 to size_x - 1 - (filtersizex div 2) do begin
      schet := 0;
      temp_ := 0;
      for J := y - (filtersizey div 2) to y + (filtersizey div 2) do
        for I := x - (filtersizex div 2) to x + (filtersizex div 2) do begin
          temp^[schet] := Matrix[i + j*size_x];
          Inc(schet);
        end;
      for J := 0 to schet - 2 do
        for I := 0 to schet - 2 do
          if temp^[i] > temp^[i+1] then begin
            temp_ := temp^[i];
            temp^[i] := temp^[i + 1];
            temp^[i + 1] := temp_;
          end;
      Matrix_FinalPicture[x + y*size_x] := temp^[(schet div 2) + 1];
    end;
  // освобождаем временные массивы
  FreeMem(temp, filtersizex*filtersizey*SizeOf(TReal));
end;

procedure RAFiltMedianMask(size_x, size_y, filtersizex, filtersizey : integer;
                           var Matrix, Matrix_FinalPicture, raMask : TRealArray);
var
  schet, x, y, J, I : integer;
  temp_ : TReal;
  praOut, temp : pRealarray;
begin
  if filtersizex < 3 then Exit;
  if filtersizey < 3 then Exit;
  if filtersizey mod 2 = 0 then Dec(filtersizey);
  if filtersizex mod 2 = 0 then Dec(filtersizex);  
  // создаем временные массивы
  GetMem(temp, filtersizex*filtersizey*SizeOf(TReal));
  GetMem(praOut, size_x * size_y * SizeOf(TReal));
  // заполняем временные массивы
  for y := 0 to size_y - 1 do
    for x := 0 to size_x - 1 do
      Matrix_FinalPicture[y * size_x + x] := Matrix[y * size_x + x];
  // Фильтруем
  for y := filtersizey div 2 to size_y - 1 - (filtersizey div 2) do
    for x := filtersizex div 2 to size_x - 1 - (filtersizex div 2) do
      if raMask[x + y*size_x] = 1 then begin
        schet := 0;
        temp_ := 0;
        for J := y - (filtersizey div 2) to y + (filtersizey div 2) do
          for I := x - (filtersizex div 2) to x + (filtersizex div 2) do begin
            temp^[schet] := Matrix[i + j*size_x];
            Inc(schet);
          end;
        for J := 0 to schet - 2 do
          for I := 0 to schet - 2 do
            if temp^[i] > temp^[i+1] then begin
              temp_ := temp^[i];
              temp^[i] := temp^[i + 1];
              temp^[i + 1] := temp_;
            end;
        praOut^[x + y*size_x] := temp^[(schet div 2) + 1];
      end;

  CopyMemory(Addr(Matrix_FinalPicture[0]), praOut, size_x * size_y * SizeOf(TReal));
  // освобождаем временные массивы
  FreeMem(temp, filtersizex*filtersizey*SizeOf(TReal));
  FreeMem(praOut, size_x * size_y * SizeOf(TReal));
end;

procedure RAFilterMedianMask(iW, iH, iWinSize : Integer;
                             var raIn, raOut, raMask : TRealArray);
var
  iWS2, iX, iY, iWinX, iWinY, iCount, iCount1, iCount2 : Integer;
  rTemp : TReal;
  praOut, praTemp : pRealarray;
begin
  if iWinSize < 3 then Exit;
  if iWinSize mod 2 = 0 then Dec(iWinSize);
  // создаем временные массивы
  GetMem(praTemp, Sqr(iWinSize) * SizeOf(TReal));
  GetMem(praOut, iW * iH * SizeOf(TReal));
  // заполняем временные массивы
  CopyMemory(praOut, Addr(raIn[0]), iW * iH * SizeOf(TReal));
  // Фильтруем
  iWS2 := iWinSize div 2;
 for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do if raMask[iX + iY * iW] = 1 then begin
      // Переносим попавшее в окно вов временный массив
      iCount := 0;
      for iWinY := -iWS2 to iWS2 do
        for iWinX := -iWS2 to iWS2 do
          if {(iX + iWinX + (iY + iWinY) * iW in [0..iW * iH - 1])}
            (ix+iwinx >= 0) and (ix+iwinx < iw) and (iy+iwiny >= 0) and (iy+iwiny < ih)
            then
            if raMask[iX + iWinX + (iY + iWinY) * iW] = 1 then begin
              praTemp^[iCount] := raIn[iX + iWinX + (iY + iWinY) * iW];
              Inc(iCount);
            end;
      // Упорядочиваем временный массив
      for iCount1 := 0 to iCount - 2 do
        for iCount2 := 0 to iCount - 2 do
          if praTemp^[iCount2] > praTemp^[iCount2 + 1] then begin
            rTemp := praTemp^[iCount2];
            praTemp^[iCount2] := praTemp^[iCount2 + 1];
            praTemp^[iCount2 + 1] := rTemp;
          end;
      // Медиану на выход
      praOut^[iX + iY * iW] := praTemp^[(iCount div 2) + 1];
    end;
  CopyMemory(Addr(raOut[0]), praOut, iW * iH * SizeOf(TReal));
  // освобождаем временные массивы
  FreeMem(praTemp, Sqr(iWinSize) * SizeOf(TReal));
  FreeMem(praOut, iW * iH * SizeOf(TReal));
end;

procedure RAFilterMedianSqrMask(iW, iH, iWinSize : Integer;
                                var raIn, raOut: TRealArray;
                                var raMask: TBtArr); overload;
var
  iWS2, iX, iY, iWinX, iWinY, iCount, iCount1, iCount2 : Integer;
  rTemp : TReal;
  praOut, praTemp : pRealarray;
begin
  if iWinSize < 3 then Exit;
  if iWinSize mod 2 = 0 then Dec(iWinSize);
  // создаем временные массивы
  GetMem(praTemp, Sqr(iWinSize) * SizeOf(TReal));
  GetMem(praOut, iW * iH * SizeOf(TReal));
  // заполняем временные массивы
  CopyMemory(praOut, Addr(raIn[0]), iW * iH * SizeOf(TReal));
  // Фильтруем
  iWS2 := iWinSize div 2;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do if raMask[iX + iY * iW] = 1 then begin
      // Переносим попавшее в окно во временный массив
      iCount := 0;
      iWinY := 0;
      for iWinX := -iWS2 to iWS2 do
        if (iX + iWinX + (iY + iWinY) * iW > 0) and
           (iX + iWinX + (iY + iWinY) * iW < iW * iH - 1) then
          if raMask[iX + iWinX + (iY + iWinY) * iW] = 1 then begin
            praTemp^[iCount] := raIn[iX + iWinX + (iY + iWinY) * iW];
            Inc(iCount);
          end;
      iWinX := 0;
      for iWinY := -iWS2 to -1 do
        if (iX + iWinX + (iY + iWinY) * iW > 0) and
           (iX + iWinX + (iY + iWinY) * iW < iW * iH - 1) then
          if raMask[iX + iWinX + (iY + iWinY) * iW] = 1 then begin
            praTemp^[iCount] := raIn[iX + iWinX + (iY + iWinY) * iW];
            Inc(iCount);
          end;
      for iWinY := 1 to iWS2 do
        if (iX + iWinX + (iY + iWinY) * iW > 0) and
           (iX + iWinX + (iY + iWinY) * iW < iW * iH - 1) then
          if raMask[iX + iWinX + (iY + iWinY) * iW] = 1 then begin
            praTemp^[iCount] := raIn[iX + iWinX + (iY + iWinY) * iW];
            Inc(iCount);
          end;
      // Упорядочиваем временный массив
      for iCount1 := 0 to iCount - 2 do
        for iCount2 := 0 to iCount - 2 do
          if praTemp^[iCount2] > praTemp^[iCount2 + 1] then begin
            rTemp := praTemp^[iCount2];
            praTemp^[iCount2] := praTemp^[iCount2 + 1];
            praTemp^[iCount2 + 1] := rTemp;
          end;
      // Медиану на выход
      praOut^[iX + iY * iW] := praTemp^[(iCount div 2) + 1];
    end;
  CopyMemory(Addr(raOut[0]), praOut, iW * iH * SizeOf(TReal));
  // освобождаем временные массивы
  FreeMem(praTemp, Sqr(iWinSize) * SizeOf(TReal));
  FreeMem(praOut, iW * iH * SizeOf(TReal));
end;


procedure RAFilterMedianSqrMask(iW, iH, iWinSize : Integer;
                                var raIn, raOut, raMask : TRealArray);
var
  iWS2, iX, iY, iWinX, iWinY, iCount, iCount1, iCount2 : Integer;
  rTemp : TReal;
  praOut, praTemp : pRealarray;
begin
  if iWinSize < 3 then Exit;
  if iWinSize mod 2 = 0 then Dec(iWinSize);
  // создаем временные массивы
  GetMem(praTemp, Sqr(iWinSize) * SizeOf(TReal));
  GetMem(praOut, iW * iH * SizeOf(TReal));
  // заполняем временные массивы
  CopyMemory(praOut, Addr(raIn[0]), iW * iH * SizeOf(TReal));
  // Фильтруем
  iWS2 := iWinSize div 2;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do if raMask[iX + iY * iW] = 1 then begin
      // Переносим попавшее в окно во временный массив
      iCount := 0;
      iWinY := 0;
      for iWinX := -iWS2 to iWS2 do
        if (iX + iWinX + (iY + iWinY) * iW > 0) and
           (iX + iWinX + (iY + iWinY) * iW < iW * iH - 1) then
          if raMask[iX + iWinX + (iY + iWinY) * iW] = 1 then begin
            praTemp^[iCount] := raIn[iX + iWinX + (iY + iWinY) * iW];
            Inc(iCount);
          end;
      iWinX := 0;
      for iWinY := -iWS2 to -1 do
        if (iX + iWinX + (iY + iWinY) * iW > 0) and
           (iX + iWinX + (iY + iWinY) * iW < iW * iH - 1) then
          if raMask[iX + iWinX + (iY + iWinY) * iW] = 1 then begin
            praTemp^[iCount] := raIn[iX + iWinX + (iY + iWinY) * iW];
            Inc(iCount);
          end;
      for iWinY := 1 to iWS2 do
        if (iX + iWinX + (iY + iWinY) * iW > 0) and
           (iX + iWinX + (iY + iWinY) * iW < iW * iH - 1) then
          if raMask[iX + iWinX + (iY + iWinY) * iW] = 1 then begin
            praTemp^[iCount] := raIn[iX + iWinX + (iY + iWinY) * iW];
            Inc(iCount);
          end;
      // Упорядочиваем временный массив
      for iCount1 := 0 to iCount - 2 do
        for iCount2 := 0 to iCount - 2 do
          if praTemp^[iCount2] > praTemp^[iCount2 + 1] then begin
            rTemp := praTemp^[iCount2];
            praTemp^[iCount2] := praTemp^[iCount2 + 1];
            praTemp^[iCount2 + 1] := rTemp;
          end;
      // Медиану на выход
      praOut^[iX + iY * iW] := praTemp^[(iCount div 2) + 1];
    end;
  CopyMemory(Addr(raOut[0]), praOut, iW * iH * SizeOf(TReal));
  // освобождаем временные массивы
  FreeMem(praTemp, Sqr(iWinSize) * SizeOf(TReal));
  FreeMem(praOut, iW * iH * SizeOf(TReal));
end;

procedure RAFilterGaussian(iW, iH, iWinSize : Integer;
                           rSigma : TReal;
                           var raIn, raOut : TRealArray);
var
  iWS2, iX, iY, iWinX, iWinY : Integer;
  praOut, praWinK : PRealArray;
  rK, rMax, rMin, rTemp, rWinSum : TReal;
begin
  if rSigma = 0 then Exit;
  if iWinSize < 3 then Exit;
  if iWinSize mod 2 = 0 then Dec(iWinSize);
  // Формируем окно
  GetMem(praWinK, Sqr(iWinSize) * SizeOf(TReal));
  GetMem(praOut, iW * iH * SizeOf(TReal));
  iWS2 := iWinSize div 2;
  rWinSum := 0.0;
  rK := 2 * Pi * Sqr(rSigma) * Exp(Sqr(iWinSize) / Sqr(rSigma));
  for iWinX := -iWS2 to iWS2 do
    for iWinY := -iWS2 to iWS2 do begin
      praWinK^[iWinX + iWS2 + (iWinY + iWS2) * iWinSize] := Exp((Sqr(iWinX) +
        Sqr(iWinY)) / (2 * Sqr(rSigma))) / (2 * Pi * Sqr(rSigma)) * rK;
      rWinSum := rWinSum + praWinK^[iWinX + iWS2 + (iWinY + iWS2) * iWinSize];
    end;
  if rWinSum = 0 then Exit;
  CopyMemory(praOut, Addr(raIn[0]), iW * iH * SizeOf(TReal));
  // Фильтруем
  for iY := iWS2 to iH - 1 - iWS2 do
    for iX := iWS2 to iW - 1 - iWS2 do begin
      rTemp := 0.0;
      for iWinY := -iWS2 to iWS2 do
        for iWinX := -iWS2 to iWS2 do
          if (iX + iWinX + (iY + iWinY) * iW > 0) and
             (iX + iWinX + (iY + iWinY) * iW < iW * iH - 1) then
            rTemp := rTemp + raIn[(iWinY + iY) * iW + iW + iWinX] *
               praWinK^[iWinX + iWS2 + (iWinY + iWS2) * iWinSize];
      praOut^[iY * iW + iX] := rTemp / rWinSum;
    end;
  CopyMemory(Addr(raOut[0]), praOut, iW * iH * SizeOf(TReal));
  // Очищаем память
  FreeMem(praWinK, Sqr(iWinSize) * SizeOf(TReal));
  FreeMem(praOut, iW * iH * SizeOf(TReal));
end;

procedure RAFilterGaussianMask(iW, iH, iWinSize : Integer;
                               rSigma : TReal;
                               var raIn, raMask, raOut : TRealArray);
var
  iWS2, iX, iY, iWinX, iWinY : Integer;
  praOut, praWinK : PRealArray;
  rK, rMax, rMin, rTemp, rWinSum, rMaxWinSum : TReal;
begin
  if rSigma = 0 then Exit;
  if iWinSize < 3 then Exit;
  if iWinSize mod 2 = 0 then Dec(iWinSize);
  // Формируем окно
  GetMem(praWinK, Sqr(iWinSize) * SizeOf(TReal));
  GetMem(praOut, iW * iH * SizeOf(TReal));
  iWS2 := iWinSize div 2;
  rMaxWinSum := 0.0;
  rK := 2 * Pi * Sqr(rSigma) * Exp(Sqr(iWS2) / Sqr(rSigma));
  for iWinX := -iWS2 to iWS2 do
    for iWinY := -iWS2 to iWS2 do begin
      praWinK^[iWinX + iWS2 + (iWinY + iWS2) * iWinSize] := Exp(- (Sqr(iWinX) +
        Sqr(iWinY)) / (2 * Sqr(rSigma))) / (2 * Pi * Sqr(rSigma)) * rK;
      rMaxWinSum := rMaxWinSum + praWinK^[iWinX + iWS2 + (iWinY + iWS2) * iWinSize];
    end;
  if rMaxWinSum = 0 then Exit;
  CopyMemory(praOut, Addr(raIn[0]), iW * iH * SizeOf(TReal));
  // Фильтруем
  for iY := iWS2 to iH - 1 - iWS2 do
    for iX := iWS2 to iW - 1 - iWS2 do if raMask[iY * iW + iX] = 1 then begin
      rTemp := 0.0;
      rWinSum := 0.0;
      for iWinY := -iWS2 to iWS2 do
        for iWinX := -iWS2 to iWS2 do
          if (iX + iWinX > 0) and (iX + iWinX < iW) and
             (iY + iWinY > 0) and (iY + iWinY < iH) then
            if raMask[(iWinY + iY) * iW + iX + iWinX] = 1 then begin
              rTemp := rTemp + raIn[(iWinY + iY) * iW + iX + iWinX] *
                 praWinK^[iWinX + iWS2 + (iWinY + iWS2) * iWinSize];
              rWinSum := rWinSum +
                praWinK^[iWinX + iWS2 + (iWinY + iWS2) * iWinSize];
            end;
      if rWinSum = rMaxWinSum then praOut^[iY * iW + iX] := rTemp / rWinSum;
    end;
  CopyMemory(Addr(raOut[0]), praOut, iW * iH * SizeOf(TReal));
  // Очищаем память
  FreeMem(praWinK, Sqr(iWinSize) * SizeOf(TReal));
  FreeMem(praOut, iW * iH * SizeOf(TReal));
end;

procedure RAFilterGaussianMaskOutBadFloodFill(w, h, _w: Integer;
                                              rSigma: TReal;
                                              var raIn, raOut: TRealArray;
                                              var raMask: TBtArr);
var
  w0, i, j, k, l: Integer;
  praOut, praWinK : PRealArray;
  rK, rMax, rMin, rTemp, rWinSum, rMaxWinSum : TReal;
  bmp: TBitmap;
  Flood: boolean;
  pb: PByteArray;
begin
  if rSigma = 0 then Exit;
  if _w < 3 then Exit;
  if _w mod 2 = 0 then Dec(_w);

  GetMem(praWinK, sqr(_w)*SizeOf(TReal));
  GetMem(praOut, w*h*sizeof(treal));
  bmp:=TBitmap.Create;
  bmp.Width:=_w;
  bmp.Height:=_w;
  bmp.PixelFormat:=pf8bit;
  bmp.Canvas.Brush.Color:=32768;
  w0:=_w div 2;
  rMaxWinSum:=0;
  rK:=2*Pi*Sqr(rSigma)*Exp(Sqr(w0)/Sqr(rSigma));

  for i:= -w0 to w0 do
    for j:= -w0 to w0 do
    begin
      praWinK^[i+w0+(j+w0)*_w]:=Exp(-(Sqr(j)+Sqr(i))/(2*Sqr(rSigma)))/(2*Pi*Sqr(rSigma))*rK;
      rMaxWinSum:=rMaxWinSum+praWinK^[i+w0+(j+w0)*_w];
    end;
  if rMaxWinSum = 0 then Exit;

  CopyMemory(praOut, @(raIn[0]), w*h*sizeof(treal));
  for i:=w0 to h-1-w0 do
    for j:=w0 to w-1-w0 do
      if raMask[i*w+j] = 1 then
      begin
        rTemp:=0;
        rWinSum:=0;
        flood:=false;
        for k:=-w0 to w0 do
        begin
          pb:=bmp.ScanLine[k+w0];
          for l:=-w0 to w0 do
          begin
            pb^[l+w0]:=raMask[(k+i)*w+j+l];
            if pb^[l+w0] = 0 then
              flood:=true;
          end;
        end;
        if flood then
        begin
           bmp.Canvas.FloodFill(w0, w0, 0, fsBorder);
           for k:=-w0 to w0 do
           begin
             pb:=bmp.ScanLine[k+w0];
             for l:=-w0 to w0 do
               if pb^[l+w0] = 2 then
               begin
                 rTemp:=rTemp+raIn[(k+i)*w+l+j]*praWinK^[k+w0+(l+w0)*_w];
                 rWinSum:=rWinSum+praWinK^[k+w0+(l+w0)*_w];
               end;
           end;
           if rWinSum <> 0 then
             rTemp:=rTemp/rWinSum;
        end
        else
        //if not flood then
        begin
          for k:=-w0 to w0 do
            for l:=-w0 to w0 do
              rTemp:=rTemp+raIn[(k+i)*w+l+j]*praWinK^[k+w0+(l+w0)*_w];
          rTemp:=rTemp/rMaxWinSum;
        end;
        praOut^[i*w+j]:=rTemp;
      end;

  CopyMemory(@(raOut[0]), praOut, w*h*sizeof(treal));

  FreeMem(praWinK, sqr(_w)*sizeof(treal));
  FreeMem(praOut, w*h*sizeof(treal));
  bmp.Destroy;


end;


procedure RAFilterGaussianMaskOutBad(iW, iH, iWinSize: Integer;
                                     rSigma: TReal;
                                     var raIn, raOut: TRealArray;
                                     var raMask: TBtArr); overload;
var
  iWS2, iX, iY, iWinX, iWinY : Integer;
  praOut, praWinK : PRealArray;
  rK, rMax, rMin, rTemp, rWinSum, rMaxWinSum : TReal;
begin
  if rSigma = 0 then Exit;
  if iWinSize < 3 then Exit;
  if iWinSize mod 2 = 0 then Dec(iWinSize);
  // Формируем окно
  GetMem(praWinK, Sqr(iWinSize) * SizeOf(TReal));
  GetMem(praOut, iW * iH * SizeOf(TReal));
  iWS2 := iWinSize div 2;
  rMaxWinSum := 0.0;
  rK := 2 * Pi * Sqr(rSigma) * Exp(Sqr(iWS2) / Sqr(rSigma));
  for iWinX := -iWS2 to iWS2 do
    for iWinY := -iWS2 to iWS2 do begin
      praWinK^[iWinX + iWS2 + (iWinY + iWS2) * iWinSize] := Exp(- (Sqr(iWinX) +
        Sqr(iWinY)) / (2 * Sqr(rSigma))) / (2 * Pi * Sqr(rSigma)) * rK;
      rMaxWinSum := rMaxWinSum + praWinK^[iWinX + iWS2 + (iWinY + iWS2) * iWinSize];
    end;

  if rMaxWinSum = 0 then Exit;
  CopyMemory(praOut, Addr(raIn[0]), iW * iH * SizeOf(TReal));
  // Фильтруем
  for iY := iWS2 to iH - 1 - iWS2 do
    for iX := iWS2 to iW - 1 - iWS2 do
      if raMask[iY * iW + iX] = 1 then
      begin
        rTemp := 0.0;
        rWinSum := 0.0;
        for iWinY := -iWS2 to iWS2 do
          for iWinX := -iWS2 to iWS2 do
           {if (iX + iWinX > 0) and (iX + iWinX < iW) and
             (iY + iWinY > 0) and (iY + iWinY < iH) then}

            if raMask[(iWinY + iY) * iW + iX + iWinX] = 1 then
            begin
              rTemp := rTemp + raIn[(iWinY + iY) * iW + iX + iWinX] *
                 praWinK^[iWinX + iWS2 + (iWinY + iWS2) * iWinSize];
              rWinSum := rWinSum +
                praWinK^[iWinX + iWS2 + (iWinY + iWS2) * iWinSize];
            end;

//      if rWinSum = rMaxWinSum then praOut^[iY * iW + iX] := rTemp / rWinSum;
        if rWinSum <> 0 then
     //     if rWinSum = rMaxWinSum then
            praOut^[iY * iW + iX] := rTemp / rWinSum;
    end;

  CopyMemory(Addr(raOut[0]), praOut, iW * iH * SizeOf(TReal));
  // Очищаем память
  FreeMem(praWinK, Sqr(iWinSize) * SizeOf(TReal));
  FreeMem(praOut, iW * iH * SizeOf(TReal));
end;


procedure RAFilterGaussianMaskOutBad(iW, iH, iWinSize : Integer;
                                     rSigma : TReal;
                                      var raIn, raMask, raOut : TRealArray);
var
  iWS2, iX, iY, iWinX, iWinY : Integer;
  praOut, praWinK : PRealArray;
  rK, rMax, rMin, rTemp, rWinSum, rMaxWinSum : TReal;
begin
  if rSigma = 0 then Exit;
  if iWinSize < 3 then Exit;
  if iWinSize mod 2 = 0 then Dec(iWinSize);
  // Формируем окно
  GetMem(praWinK, Sqr(iWinSize) * SizeOf(TReal));
  GetMem(praOut, iW * iH * SizeOf(TReal));
  iWS2 := iWinSize div 2;
  rMaxWinSum := 0.0;
  rK := 2 * Pi * Sqr(rSigma) * Exp(Sqr(iWS2) / Sqr(rSigma));
  for iWinX := -iWS2 to iWS2 do
    for iWinY := -iWS2 to iWS2 do begin
      praWinK^[iWinX + iWS2 + (iWinY + iWS2) * iWinSize] := Exp(- (Sqr(iWinX) +
        Sqr(iWinY)) / (2 * Sqr(rSigma))) / (2 * Pi * Sqr(rSigma)) * rK;
      rMaxWinSum := rMaxWinSum + praWinK^[iWinX + iWS2 + (iWinY + iWS2) * iWinSize];
    end;
  if rMaxWinSum = 0 then Exit;
  CopyMemory(praOut, Addr(raIn[0]), iW * iH * SizeOf(TReal));
  // Фильтруем
  for iY := iWS2 to iH - 1 - iWS2 do
    for iX := iWS2 to iW - 1 - iWS2 do if raMask[iY * iW + iX] = 1 then begin
      rTemp := 0.0;
      rWinSum := 0.0;
      for iWinY := -iWS2 to iWS2 do
        for iWinX := -iWS2 to iWS2 do
          if (iX + iWinX > 0) and (iX + iWinX < iW) and
             (iY + iWinY > 0) and (iY + iWinY < iH) then
            if raMask[(iWinY + iY) * iW + iX + iWinX] = 1 then begin
              rTemp := rTemp + raIn[(iWinY + iY) * iW + iX + iWinX] *
                 praWinK^[iWinX + iWS2 + (iWinY + iWS2) * iWinSize];
              rWinSum := rWinSum +
                praWinK^[iWinX + iWS2 + (iWinY + iWS2) * iWinSize];
            end;
//      if rWinSum = rMaxWinSum then praOut^[iY * iW + iX] := rTemp / rWinSum;
      if rWinSum <> 0 then praOut^[iY * iW + iX] := rTemp / rWinSum;
    end;
  CopyMemory(Addr(raOut[0]), praOut, iW * iH * SizeOf(TReal));
  // Очищаем память
  FreeMem(praWinK, Sqr(iWinSize) * SizeOf(TReal));
  FreeMem(praOut, iW * iH * SizeOf(TReal));
end;

procedure RAFilterLinearMask(iW, iH, iWinSize : Integer;
                             var raIn, raMask, raOut : TRealArray);
var
  iWS2, iX, iY, iWinX, iWinY : Integer;
  praOut : PRealArray;
  rTemp, rWinSum : TReal;
begin
  if iWinSize < 3 then Exit;
  if iWinSize mod 2 = 0 then Dec(iWinSize);
  // Формируем окно
  GetMem(praOut, iW * iH * SizeOf(TReal));
  iWS2 := iWinSize div 2;
  CopyMemory(praOut, Addr(raIn[0]), iW * iH * SizeOf(TReal));
  // Фильтруем
  for iY := iWS2 to iH - 1 - iWS2 do
    for iX := iWS2 to iW - 1 - iWS2 do begin
      rTemp := 0.0;
      rWinSum := 0.0;
      for iWinY := -iWS2 to iWS2 do
        for iWinX := -iWS2 to iWS2 do
          if (iX + iWinX > 0) and (iX + iWinX < iW) and
             (iY + iWinY > 0) and (iY + iWinY < iH) then
            if raMask[(iWinY + iY) * iW + iX + iWinX] = 1 then begin
              rTemp := rTemp + raIn[(iWinY + iY) * iW + iX + iWinX];
              rWinSum := rWinSum + 1;
            end;
      if rWinSum <> 0 then praOut^[iY * iW + iX] := rTemp / rWinSum
    end;
  CopyMemory(Addr(raOut[0]), praOut, iW * iH * SizeOf(TReal));
  // Очищаем память
  FreeMem(praOut, iW * iH * SizeOf(TReal));
end;

// Гауссов фильтр
procedure GaussianFiltration(size_x, size_y, filtersizex, filtersizey : integer;
                             var Matrix, Matrix_FinalPicture : TRealArray);
var
  Schet2, schet, x, y, J, I : integer;
  temp_ : TReal;
const
  Gauss3x3 : array [0..8] of Integer = (1, 2, 1,
                                        2, 4, 2,
                                        1, 2, 1);
  Gauss5x5 : array [0..24] of Integer = (1, 1, 1, 1, 1,
                                         1, 2, 2, 2, 1,
                                         1, 2, 4, 2, 1,
                                         1, 2, 2, 2, 1,
                                         1, 1, 1, 1, 1);
  Gauss11x11 : array [0..120] of Integer = (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
                                            1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
                                            1, 2, 3, 3, 3, 3, 3, 3, 3, 2, 1,
                                            1, 2, 3, 4, 4, 4, 4, 4, 3, 2, 1,
                                            1, 2, 3, 4, 5, 5, 5, 4, 3, 2, 1,
                                            1, 2, 3, 4, 5, 6, 5, 4, 3, 2, 1,
                                            1, 2, 3, 4, 5, 5, 5, 4, 3, 2, 1,
                                            1, 2, 3, 4, 4, 4, 4, 4, 3, 2, 1,
                                            1, 2, 3, 3, 3, 3, 3, 3, 3, 2, 1,
                                            1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
                                            1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
  Gauss19x19 : array [0..360] of Integer =
    (1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1,
     1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
     1, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 1,
     1, 2, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 2, 1,
     1, 2, 3, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 4, 3, 2, 1,
     1, 2, 3, 4, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 5, 4, 3, 2, 1,
     1, 2, 3, 4, 5, 6, 7, 7, 7, 7, 7, 7, 7, 6, 5, 4, 3, 2, 1,
     1, 2, 3, 4, 5, 6, 7, 8, 8, 8, 8, 8, 7, 6, 5, 4, 3, 2, 1,
     1, 2, 3, 4, 5, 6, 7, 8, 9, 9, 9, 8, 7, 6, 5, 4, 3, 2, 1,
     1, 2, 3, 4, 5, 6, 7, 8, 9,10, 9, 8, 7, 6, 5, 4, 3, 2, 1,
     1, 2, 3, 4, 5, 6, 7, 8, 9, 9, 9, 8, 7, 6, 5, 4, 3, 2, 1,
     1, 2, 3, 4, 5, 6, 7, 8, 8, 8, 8, 8, 7, 6, 5, 4, 3, 2, 1,
     1, 2, 3, 4, 5, 6, 7, 7, 7, 7, 7, 7, 7, 6, 5, 4, 3, 2, 1,
     1, 2, 3, 4, 5, 6, 6, 6, 6, 6, 6, 6, 6, 6, 5, 4, 3, 2, 1,
     1, 2, 3, 4, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 4, 3, 2, 1,
     1, 2, 3, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 3, 2, 1,
     1, 2, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 2, 1,
     1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1,
     1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1);
begin
  // заполняем временные массивы
  for y := 0 to size_y - 1 do
    for x := 0 to size_x - 1 do
      Matrix_FinalPicture[y * size_x + x] := Matrix[y * size_x + x];
  // Фильтруем
  for y := filtersizey div 2 to size_y - 1 - (filtersizey div 2) do
    for x := filtersizex div 2 to size_x - 1 - (filtersizex div 2) do begin
      schet := 0;
      temp_ := 0;
      Schet2 := 0;
      // В зависимости от размера фильтра используем различные
      // массивы с константами
      case filtersizex of
        3 : begin
              for J := y - (filtersizey div 2) to y + (filtersizey div 2) do
                for I := x - (filtersizex div 2) to x + (filtersizex div 2) do begin
            	    temp_ := temp_ + Gauss3x3[schet]*Matrix[i + j*size_x];
              	  Inc(schet);
              	end;
              temp_ := temp_/16;
            end;
        5 : begin
              for J := y - (filtersizey div 2) to y + (filtersizey div 2) do
                for I := x - (filtersizex div 2) to x + (filtersizex div 2) do begin
            	    temp_ := temp_ + Gauss5x5[schet]*Matrix[i + j*size_x];
              	  Inc(schet);
              	end;
              temp_ := temp_/33;
            end;
        11 : begin
              for J := y - (filtersizey div 2) to y + (filtersizey div 2) do
                for I := x - (filtersizex div 2) to x + (filtersizex div 2) do begin
            	    temp_ := temp_ + Gauss11x11[schet]*Matrix[i + j*size_x];
                  Schet2 := Schet2 + Gauss11x11[schet];
              	  Inc(schet);
              	end;
              temp_ := temp_/Schet2;
            end;
        19 : begin
              for J := y - (filtersizey div 2) to y + (filtersizey div 2) do
                for I := x - (filtersizex div 2) to x + (filtersizex div 2) do begin
            	    temp_ := temp_ + Gauss19x19[schet]*Matrix[i + j*size_x];
                  Schet2 := Schet2 + Gauss19x19[schet];
              	  Inc(schet);
              	end;
              temp_ := temp_/Schet2;
            end;
        else Exit;
      end;
      Matrix_FinalPicture[x + y*size_x] := temp_;
    end;
end;

// Линейная двухмерная фильтрация прямоугольником
procedure LinearFiltration(size_x, size_y, filtersizex, filtersizey : integer;
                           var Matrix, Matrix_FinalPicture : TRealArray);

var
  x, y, J, I : integer;
  schet : TReal;
begin
  // заполняем временные массивы
  for y := 0 to size_y - 1 do
    for x := 0 to size_x - 1 do
      Matrix_FinalPicture[y * size_x + x] := Matrix[y * size_x + x];
  // Фильтруем
  for y := filtersizey div 2 to size_y - 1 - (filtersizey div 2) do
    for x := filtersizex div 2 to size_x - 1 - (filtersizex div 2) do begin
      schet := 0;
      for J := y - (filtersizey div 2) to y + (filtersizey div 2) do
        for I := x - (filtersizex div 2) to x + (filtersizex div 2) do
      	  schet := Schet + Matrix[i + j*size_x];
      Matrix_FinalPicture[x + y*size_x] := schet/filtersizex/filtersizey;
  end;
end;

// Амплитудная фильтрация
procedure AmplitudeFiltration(size_x, size_y : integer;
                              MinZ, MaxZ : TReal;
                              var Matrix, Matrix_FinalPicture : TRealArray);
var
  x, y : integer;
begin
  // Фильтруем
  for y := 0 to size_y - 1 do
    for x := 0 to size_x - 1 do
      if (Matrix[x + y*size_x] < MinZ) then Matrix_FinalPicture[x + y*size_x] := MinZ
      else
        if (Matrix[x + y*size_x] > MaxZ) then Matrix_FinalPicture[x + y*size_x] := MaxZ
        else Matrix_FinalPicture[x + y*size_x] := Matrix[x + y*size_x];
end;

// Тригонометрический фильтр для фильтрации несшитой фазы
procedure TrigonometricFiltration(size_x, size_y,
                                  filtersizex, filtersizey,
                                  RepeatNum,
                                  FilterType : integer;
                                  var PRAInput, PRAOutput : TRealArray);
var
  K, I, J : INteger;
  PRASin, PRACos, PRASinFltr, PRACosFltr : PRealArray;
begin
  // Создаем массив дествительных чисел для входных данных и не только
  GetMem(PRASin, Size_X*Size_Y*SizeOf(TReal));
  GetMem(PRACos, Size_X*Size_Y*SizeOf(TReal));
  GetMem(PRASinFltr, Size_X*Size_Y*SizeOf(TReal));
  GetMem(PRACosFltr, Size_X*Size_Y*SizeOf(TReal));
  // Инициализируем данные
  for I := 0 to size_y - 1 do
    for J := 0 to size_x - 1 do
      PRAOutput[i * size_x + j] := PRAInput[i * size_x + j];
  // Прогоняем нужное количество раз
  for K := 0 to RepeatNum - 1 do begin
    // берем синусы и косинусы от входного массива
    for I := 0 to Size_Y - 1 do
      for J := 0 to Size_X - 1 do begin
        PRASin^[I*Size_X + J] := Sin(PRAOutput[I*Size_X + J]);
        PRACos^[I*Size_X + J] := Cos(PRAOutput[I*Size_X + J]);
      end;
    // фильтруем
    case FilterType of
      0 : begin
            LinearFiltration(Size_X, Size_Y, filtersizex, filtersizey,
                             PRASin^, PRASinFltr^);
            LinearFiltration(Size_X, Size_Y, filtersizex, filtersizey,
                             PRACos^, PRACosFltr^);
          end;
      1 : begin
            MedianFiltration(Size_X, Size_Y, filtersizex, filtersizey,
                             PRASin^, PRASinFltr^);
            MedianFiltration(Size_X, Size_Y, filtersizex, filtersizey,
                             PRACos^, PRACosFltr^);
          end;
      2 : begin
            GaussianFiltration(Size_X, Size_Y, filtersizex, filtersizey,
                               PRASin^, PRASinFltr^);
            GaussianFiltration(Size_X, Size_Y, filtersizex, filtersizey,
                               PRACos^, PRACosFltr^);
          end;
    end;
    // берем арктангенс
    for I := 0 to Size_Y - 1 do
      for J := 0 to Size_X - 1 do
        if PRACos^[I*Size_X + J] <> 0 then
          PRAOutput[I*Size_X + J] := ArcTan2(PRASin^[I*Size_X + J],
                                                     PRACos^[I*Size_X + J]);
  end;
  FreeMem(PRASin, Size_X*Size_Y*SizeOf(TReal));
  FreeMem(PRACos, Size_X*Size_Y*SizeOf(TReal));
  FreeMem(PRASinFltr, Size_X*Size_Y*SizeOf(TReal));
  FreeMem(PRACosFltr, Size_X*Size_Y*SizeOf(TReal));
end;

// Обратная Гамма коррекция
procedure GammaCorrection(size_x, size_y : integer;
                          PowerNum : TReal;
                          var PRAInput, PRAOutput : TRealArray);
var
  I, J : INteger;
begin
  CopyMemory(Addr(praOutput), Addr(praInput), size_x * size_y * SizeOf(TReal));
  NormRealArray(size_x, size_y, praOutput, 1, 256);
  // корректируем
  for I := 0 to Size_Y - 1 do
    for J := 0 to Size_X - 1 do
      PRAOutPut[I * Size_X + J] := Exp(PowerNum * Ln(PRAOutput[I * Size_X + J]));
  NormRealArray(size_x, size_y, praOutput, 0, 255);
end;

procedure GammaCorrection(size_x, size_y: integer;
                          PowerNum: TReal;
                          var PRAInput: TBtArr; var PRAOutput: TRealArray); overload;
var
  I, J : INteger;
begin
  for I := 0 to Size_Y - 1 do
    for J := 0 to Size_X - 1 do
      PRAOutPut[I * Size_X + J]:=praInput[I * Size_X + J];
//  CopyMemory(Addr(praOutput), Addr(praInput), size_x * size_y * SizeOf(TReal));
  NormRealArray(size_x, size_y, praOutput, 1, 256);
  // корректируем
  for I := 0 to Size_Y - 1 do
    for J := 0 to Size_X - 1 do
      PRAOutPut[I * Size_X + J] := Exp(PowerNum * Ln(PRAOutput[I * Size_X + J]));
  NormRealArray(size_x, size_y, praOutput, 0, 255);
end;

procedure ExtremalFiltration(size_x, size_y, filtersizex, filtersizey, windowtype : integer;
                             var Matrix, Matrix_FinalPicture : TRealArray);
var
  schet, x, y, J, I : integer;
  temp_ : TReal;
  temp : pRealarray;
begin
  // создаем временные массивы
  GetMem(temp, filtersizex*filtersizey*SizeOf(TReal));
  // заполняем временные массивы
  for y := 0 to size_y - 1 do
    for x := 0 to size_x - 1 do
      Matrix_FinalPicture[y * size_x + x] := Matrix[y * size_x + x];
  // Фильтруем
  for y := filtersizey div 2 to size_y - 1 - (filtersizey div 2) do
    for x := filtersizex div 2 to size_x - 1 - (filtersizex div 2) do begin
      schet := 0;
      temp_ := 0;
      for J := y - (filtersizey div 2) to y + (filtersizey div 2) do
        for I := x - (filtersizex div 2) to x + (filtersizex div 2) do begin
      	  temp^[schet] := Matrix[i + j*size_x];
      	  Inc(schet);
      	end;
      for J := 0 to schet - 2 do
        for I := 0 to schet - 2 do
          if temp^[i] > temp^[i+1] then begin
            temp_ := temp^[i];
            temp^[i] := temp^[i + 1];
            temp^[i + 1] := temp_;
          end;
      case windowtype of
        1 : begin
              if (Matrix[x + y * size_x] - temp^[0]) <
                 (temp^[schet - 1] - Matrix[x + y * size_x]) then
                 Matrix_FinalPicture[x + y*size_x] := temp^[0]
              else Matrix_FinalPicture[x + y*size_x] := temp^[schet - 1];
            end;
        2 : Matrix_FinalPicture[x + y*size_x] := temp^[schet - 1];
        3 : Matrix_FinalPicture[x + y*size_x] := temp^[0];
      end;
    end;
  // освобождаем временные массивы
  FreeMem(temp, filtersizex*filtersizey*SizeOf(TReal));
end;




procedure FilterDiffSobel(iW, iH : Integer;
                          var raIn, raOut : TRealArray);
var
  praTemp : PRealArray;
  iCount, iX, iY, iX2, iY2 : Integer;
  rNum, rTemp : TReal;
begin
  GetMem(praTemp, iW * iH * SizeOf(treal));
  CopyMemory(praTemp, Addr(raIn[0]), iW * iH * SizeOf(treal));
  FillRealArrayNum(iW, iH, raOut, 0);
  for iY := 1 to iH - 2 do
    for iX := 1 to iW - 2 do begin
      rTemp := 0;
      iCount := 0;
      for iY2 := iY - 1 to iY + 1 do
        for iX2 := iX - 1 to iX + 1 do begin
//          rNum := UnwrapDelta(raIn[iY * iW + iX], raIn[iY2 * iW + iX2], Pi);
          rNum := praTemp^[iY2 * iW + iX2];
          rTemp := rTemp + Sobel13x3[iCount] * rNum + Sobel23x3[iCount] * rNum;
//          rTemp := rTemp + Laplacian13x3[iCount] * rNum;
//          rTemp := rTemp + Previtt13x3[iCount] * rNum + Previtt23x3[iCount] * rNum;
          Inc(iCount);
        end;
      raOut[iX + iY * iW] := rTemp;
    end;
  FreeMem(praTemp, iW * iH * SizeOf(treal));
end;

// Гауссов фильтр
procedure DiffFiltration(size_x, size_y, windowtype : integer;
                         var Matrix, Matrix_FinalPicture : TRealArray);
var
  filtersizey, filtersizex, schet, x, y, J, I : integer;
  temp_ : TReal;
begin
  // заполняем временные массивы
  for y := 0 to size_y - 1 do
    for x := 0 to size_x - 1 do
      Matrix_FinalPicture[y * size_x + x] := Matrix[y * size_x + x];
  filtersizex := 3;
  filtersizey := 3;
  // Фильтруем
  case windowtype of
    1 : for y := filtersizey div 2 to size_y - 1 - (filtersizey div 2) do
          for x := filtersizex div 2 to size_x - 1 - (filtersizex div 2) do begin
            schet := 0;
            temp_ := 0;
            // В зависимости от размера фильтра используем различные
            // массивы с константами
             for J := y - (filtersizey div 2) to y + (filtersizey div 2) do
               for I := x - (filtersizex div 2) to x + (filtersizex div 2) do begin
                  temp_ := temp_ + Previtt13x3[schet]*Matrix[i + j*size_x];
                  Inc(schet);
                end;
            Matrix_FinalPicture[x + y*size_x] := temp_/6;
          end;
    2 : for y := filtersizey div 2 to size_y - 1 - (filtersizey div 2) do
          for x := filtersizex div 2 to size_x - 1 - (filtersizex div 2) do begin
            schet := 0;
            temp_ := 0;
            // В зависимости от размера фильтра используем различные
            // массивы с константами
             for J := y - (filtersizey div 2) to y + (filtersizey div 2) do
               for I := x - (filtersizex div 2) to x + (filtersizex div 2) do begin
                  temp_ := temp_ + Previtt23x3[schet]*Matrix[i + j*size_x];
                  Inc(schet);
                end;
            Matrix_FinalPicture[x + y*size_x] := temp_/6;
          end;
    3 : for y := filtersizey div 2 to size_y - 1 - (filtersizey div 2) do
          for x := filtersizex div 2 to size_x - 1 - (filtersizex div 2) do begin
            schet := 0;
            temp_ := 0;
            // В зависимости от размера фильтра используем различные
            // массивы с константами
             for J := y - (filtersizey div 2) to y + (filtersizey div 2) do
               for I := x - (filtersizex div 2) to x + (filtersizex div 2) do begin
                  temp_ := temp_ + Sobel13x3[schet]*Matrix[i + j*size_x];
                  Inc(schet);
                end;
            Matrix_FinalPicture[x + y*size_x] := temp_;
          end;
    4 : for y := filtersizey div 2 to size_y - 1 - (filtersizey div 2) do
          for x := filtersizex div 2 to size_x - 1 - (filtersizex div 2) do begin
            schet := 0;
            temp_ := 0;
            // В зависимости от размера фильтра используем различные
            // массивы с константами
             for J := y - (filtersizey div 2) to y + (filtersizey div 2) do
               for I := x - (filtersizex div 2) to x + (filtersizex div 2) do begin
                  temp_ := temp_ + Sobel23x3[schet]*Matrix[i + j*size_x];
                  Inc(schet);
                end;
            Matrix_FinalPicture[x + y*size_x] := temp_;
          end;
    5 : for y := filtersizey div 2 to size_y - 1 - (filtersizey div 2) do
          for x := filtersizex div 2 to size_x - 1 - (filtersizex div 2) do begin
            schet := 0;
            temp_ := 0;
            // В зависимости от размера фильтра используем различные
            // массивы с константами
             for J := y - (filtersizey div 2) to y + (filtersizey div 2) do
               for I := x - (filtersizex div 2) to x + (filtersizex div 2) do begin
                  temp_ := temp_ + laplacian13x3[schet]*Matrix[i + j*size_x];
                  Inc(schet);
                end;
            Matrix_FinalPicture[x + y*size_x] := temp_;
          end;
    6 : for y := filtersizey div 2 to size_y - 1 - (filtersizey div 2) do
          for x := filtersizex div 2 to size_x - 1 - (filtersizex div 2) do begin
            schet := 0;
            temp_ := 0;
            // В зависимости от размера фильтра используем различные
            // массивы с константами
             for J := y - (filtersizey div 2) to y + (filtersizey div 2) do
               for I := x - (filtersizex div 2) to x + (filtersizex div 2) do begin
                  temp_ := temp_ + laplacian23x3[schet]*Matrix[i + j*size_x];
                  Inc(schet);
                end;
            Matrix_FinalPicture[x + y*size_x] := temp_/3;
          end;
    else Exit;
  end;
end;

end.
 