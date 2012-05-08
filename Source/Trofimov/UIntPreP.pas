unit UIntPreP;

interface

uses Windows, UType, UMask, UFFT, UFiltr, URATool;

procedure IntPreProcess(iW, iH : Integer;
                        var raGrayObject, raInt, raGrayBase, raBase, raMask,
                        raOut, raOutBase : TRealArray);

procedure IntHomoMorph(iW, iH : Integer ; var raGray, raIn, raOut : TRealArray);
procedure IntGrayScaleNorm(iW, iH : Integer;
                           var raGray, raIn, raOut : TRealArray);

procedure InterferogramPreprocessGershberg(iW, iH : Integer;
                                           var raIn, raMask,
                                           raSpectrum, raFiltSpectrum,
                                           raOut : TRealArray);

implementation

uses Math;

procedure RAFillMask(iW, iH : Integer;
                     var raIn, raIn2, raMask, raOut : TRealArray);
var
  iCount : Integer;
begin
  for iCount := 0 to iW * iH - 1 do
    if raMask[iCount] = 0 then raOut[iCount] := raIn2[iCount]
    else raOut[iCount] := raIn[iCount];
end;

procedure CAFilterMaxLine(iW, iH, iLineWidth : Integer;
                          var caIn, caOut : TRealArray);
var
  iMax1X, iMax1Y, iMax_1X, iMAx_1Y, iCurX, iCurY, iMaxX, iMaxY, iX, iY,
    iRealArraySize : Integer;
  rFi, rK : TReal;
  praTemp : PRealArray;
  bToOut : Boolean;
begin
  iRealArraySize := iW * iH * SizeOf(TReal);
  GetMem(praTemp, iRealArraySize);
  Complex2RealArray(iW, iH, caIn, praTemp^, 4, True);
  FindLocalMaxRealArray(iW, iH, praTemp^, 30, 60, iMaxX, iMaxY);
  FreeMem(praTemp, iRealArraySize);
  rK := iMaxY / iMaxX;
  rFi := Arctan2(iMaxY, iMaxX);
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      // Текущие координаты относительно центра экрана
      iCurX := iX - (iW div 2);
      iCurY := (iH div 2) - iY;
//      iMax1Y := Round((iCurY - iMaxY) * Cos(rFi) - (iCurX - iMaxX) * Sin(rFi));
//      iMax1X := Round((iCurY - iMaxY) * Sin(rFi) + (iCurX - iMaxX) * Cos(rFi));
//      iMax_1Y := Round((iCurY + iMaxY) * Cos(rFi) - (iCurX + iMaxX) * Sin(rFi));
//      iMax_1X := Round((iCurY + iMaxY) * Sin(rFi) + (iCurX + iMaxX) * Cos(rFi));
      bToOut := False;
//      if (Abs(iCurX) < iLineWidth) and
//         (Abs(iCurY) < iLineWidth) then bToOut := True;
//      if (Abs(iMax1X) < iLineWidth) and
//         (Abs(iMax1Y) < iLineWidth) then bToOut := True;
//      if (Abs(iMax_1X) < iLineWidth) and
//         (Abs(iMax_1Y) < iLineWidth) then bToOut := True;
      if (Round(Abs(iCurX * rK - iCurY)) <= iLineWidth) then bToOut := True;
      if bToOut then begin
        caOut[(iY * iW + iX) * 2] := caIn[(iY * iW + iX)* 2];
        caOut[(iY * iW + iX) * 2 + 1] := caIn[(iY * iW + iX)* 2 + 1];
      end
      else begin
        caOut[(iY * iW + iX) * 2] := 0.0;
        caOut[(iY * iW + iX) * 2 + 1] := 0.0;
      end;
    end;
end;

procedure InterferogramPreprocessGershberg(iW, iH : Integer;
                                           var raIn, raMask,
                                           raSpectrum, raFiltSpectrum,
                                           raOut : TRealArray);
var
  iRealArraySize, iComplexArraySize : Integer;
  praNewInterferogram, pcaSpectrum : PRealArray;
begin
  iRealArraySize := iW * iH * SizeOf(TReal);
  iComplexArraySize := 2 * iW * iH * SizeOf(TReal);
  // выделяем память
  GetMem(praNewInterferogram, iRealArraySize);
  GetMem(pcaSpectrum, iComplexArraySize);
  // БПФ
  Forward2dFFTReal(iW, iH, raIn, pcaSpectrum^);
  // На выход
  Complex2RealArray(iW, iH, pcaSpectrum^, raSpectrum, 4, True);
  CAFilterMaxLine(iW, iH, 3, pcaSpectrum^, pcaSpectrum^);
  Complex2RealArray(iW, iH, pcaSpectrum^, raFiltSpectrum, 4, True);
  // Обратное БПФ
  Backward2dFFT(iW, iH, pcaSpectrum^, pcaSpectrum^);
  Complex2RealArray(iW, iH, pcaSpectrum^, praNewInterferogram^, 4, True);
  RAFillMinNotMask(iW, iH, praNewInterferogram^, raMask);
  NormRealArray(iW, iH, praNewInterferogram^, 0, 255);
  RAFillMask(iW, iH, raIn, praNewInterferogram^, raMask, raOut);
  // освобождаем память
  FreeMem(praNewInterferogram, iRealArraySize);
  FreeMem(pcaSpectrum, iComplexArraySize);
end;

procedure IntGrayScaleNorm(iW, iH : Integer;
                           var raGray, raIn, raOut : TRealArray);
var
  praOut : PRealArray;
  iY, iX : Integer;
  rK : TReal;
  rR1, rR2 : TReal;
begin
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      raOut[iY * iW + iX] := raIn[iY * iW + iX];
  NormRealArray(iW, iH, raOut, 0, 255);
  rR1 := 1.8;
  rR2 := 0.05;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      if raGray[iY * iW + iX] > 0 then
        raOut[iY * iW + iX] := raOut[iY * iW + iX] / raGray[iY * iW + iX]
      else raOut[iY * iW + iX] := rR1;
      if raOut[iY * iW + iX] > rR1 then raOut[iY * iW + iX] := rR1;
      if raOut[iY * iW + iX] < rR2 then raOut[iY * iW + iX] := rR2;
    end;
  NormRealArray(iW, iH, raOut, 0, 255);
end;

procedure IntHomoMorph(iW, iH : Integer ; var raGray, raIn, raOut : TRealArray);
var
  praOut : PRealArray;
  iY, iX : Integer;
  rK : TReal;
begin
  // Коэффициент
  rK := 1;
  // Выделяем память
  GetMem(praOut, iW * iH * SizeOf(TReal));
  // Передаем в выходной массив
  CopyMemory(Addr(raOut[0]), Addr(raIn[0]), iW * iH * SizeOf(TReal));
  CopyMemory(Addr(praOut^[0]), Addr(raGray[0]), iW * iH * SizeOf(TReal));
  // Нормируем для логарифма
  NormRealArray(iW, iH, raOut, 1, 256);
  NormRealArray(iW, iH, praOut^, 1, 256);
  // Логарифмируем Вычитаем и экспоненцируем
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      raOut[iY * iW + iX] := Exp(Ln(raOut[iY * iW + iX]) -
        rK * Ln(praOut^[iY * iW + iX]));
      if raOut[iY * iW + iX] > 1.005 then raOut[iY * iW + iX] := 1.005;
    end;
  // Нормируем
  NormRealArray(iW, iH, raOut, 0, 255);
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      if raGray[iY * iW + iX] < 10 then raOut[iY * iW + iX] := 128;
    end;
  // Освобождаем память
  FreeMem(praOut, iW * iH * SizeOf(TReal));
end;

procedure IntPreProcess(iW, iH : Integer;
                        var raGrayObject, raInt, raGrayBase, raBase, raMask,
                        raOut, raOutBase : TRealArray);
var
  praInt, praBase : PRealArray;
begin
  // Выделяем память
  GetMem(praInt, iW * iH * SizeOf(TReal));
  GetMem(praBase, iW * iH * SizeOf(TReal));
  // Временный массив с видимой частью объекта
  FillRealArrayNum(iW, iH, praBase^, 0.0);
  CopyMemory(Addr(praInt^[0]), Addr(raInt[0]), iW * iH * SizeOf(TReal));
  AddByMask(iW, iH, raInt, raBase, raMask, praInt^);
  // Гомоморфная обработка
  IntHomoMorph(iW, iH, raGrayObject, praInt^, praInt^);
  IntHomoMorph(iW, iH, raGrayBase, raBase, praBase^);
  // Энергетическая нормировка для уменьшения нулевого порядка
  MakeMiddleNorm(iW, iH, praInt^, raOut);
  MakeMiddleNorm(iW, iH, praBase^, raOutBase);
{  // НЧ фильтрация
  GaussianFiltration(iW, iH, 5, 5, raOut, praInt^);}
  // Освобождаем память
  FreeMem(praInt, iW * iH * SizeOf(TReal));
  FreeMem(praBase, iW * iH * SizeOf(TReal));
end;

end.
