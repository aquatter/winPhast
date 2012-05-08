unit URAVis;

interface

uses Windows, Math, Graphics, UType, UPalette, URATool;

var
  iPaletteType : Integer;
  iPaletteBit : Integer;

procedure MatrixReal2BitmapLn(iW, iH : Integer;
                              var raIn : TRealArray;
                              var btOut : TBitmap);

procedure MatrixReal2Bitmap(iW, iH : Integer;
                            var raIn : TRealArray;
                            var btOut : TBitmap);

procedure MatrixReal2BitmapTreshold(iW, iH : Integer;
                                    var raIn : TRealArray;
                                    var btOut : TBitmap;
                                    rUpThr, rLoThr : TReal;
                                    bShowUpThr, bShowLoThr : Boolean;
                                    var raHisto : TIntegerArray);

procedure MakePalette(var bitmapPalette : TBitmap);

{
Описание : Осуществляет изменение яркости и контраста в битмапе
Вход     : iW , iH - размеры битмапа по Х и по Y
           bitmapIn - битмап для изменения
           iBrightness, iContrast - новые значения яркости и контраста
Выход    : bitmapIn - с измененными параметрами
Источник : -
}
procedure ChangeBitmapBrCon(iW, iH : Integer;
                            var bitmapIn : TBitmap;
                            iBrightness, iContrast : Integer;
                            bShowThreshold : Boolean);

procedure GetHistogram(iW, iH : Integer; var bitmapIn : TBitmap;
                       var iaHistogram : TIntegerArray);
                            
implementation

procedure GetHistogram(iW, iH : Integer; var bitmapIn : TBitmap;
                       var iaHistogram : TIntegerArray);
var
  iX, iY, iNum : Integer;
  pbaTemp : PByteArray;
begin
  FillMemory(Addr(iaHistogram[0]), 256 * SizeOf(Integer), 0);
  for iY := 0 to iH - 1 do begin
    pbaTemp := bitmapIn.ScanLine[iY];
    for iX := 0 to iW - 1 do begin
      if (pbaTemp^[iX * 3 + 0] = 0) and (pbaTemp^[iX * 3 + 2] = 0) and
        (pbaTemp^[iX * 3 + 1] = 255) then iNum := 255
      else iNum := (pbaTemp^[iX * 3 + 0] * 11 + pbaTemp^[iX * 3 + 1] * 59 +
        pbaTemp^[iX * 3 + 2] * 30) div 100;
      Inc(iaHistogram[iNum]);
    end;
  end;
end;

procedure ChangeBitmapBrCon(iW, iH : Integer;
                            var bitmapIn : TBitmap;
                            iBrightness, iContrast : Integer;
                            bShowThreshold : Boolean);
var
  iX, iY, iNum : Integer;
  pbaTemp : PByteArray;
  ppeaPalette : ^TPaletteEntryArray;
begin
  case iPaletteType of
    1 : ppeaPalette := Addr(peaSpectr);
    2 : ppeaPalette := Addr(peaTermo);
    else ppeaPalette := Addr(peaBW);
  end;
  for iY := 0 to iH - 1 do begin
    pbaTemp := bitmapIn.ScanLine[iY];
    for iX := 0 to iW - 1 do begin
      if (pbaTemp^[iX * 3 + 0] = 0) and (pbaTemp^[iX * 3 + 2] = 0) and
        (pbaTemp^[iX * 3 + 1] = 255) then iNum := 255
      else iNum := (pbaTemp^[iX * 3 + 0] * 11 + pbaTemp^[iX * 3 + 1] * 59 +
        pbaTemp^[iX * 3 + 2] * 30) div 100;
      if iContrast < 128 then
        iNum := Round((iNum + iBrightness - 127) * (iContrast * 0.007843 -  0.003937) + 127)
      else
        iNum := Round((iNum + iBrightness - 127) * Power(256, (iContrast - 128) / 128) + 127);
      if iNum > 255 then iNum := 255;
      if iNum < 0 then iNum := 0;
      if (iNum = 255) and (bShowThreshold) then begin
        pbaTemp^[iX * 3 + 0] := 0;
        pbaTemp^[iX * 3 + 2] := 0;
        pbaTemp^[iX * 3 + 1] := 255;
      end
      else begin
        iNum := (iNum div (256 div iPaletteBit)) * (256 div iPaletteBit);
        pbaTemp^[iX * 3 + 0] := ppeaPalette^[iNum].peBlue;
        pbaTemp^[iX * 3 + 1] := ppeaPalette^[iNum].peGreen;
        pbaTemp^[iX * 3 + 2] := ppeaPalette^[iNum].peRed;
      end;
    end;
  end;
end;

procedure MatrixReal2BitmapLn(iW, iH : Integer;
                              var raIn : TRealArray;
                              var btOut : TBitmap);
var
  iX, iY, iNum : Integer;
  rMax, rMin : TReal;
  pbaTemp : PByteArray;
  praTemp : PRealArray;
begin
  // Временный массив
  GetMem(praTemp, iW * iH * SizeOf(TReal));

  // !!!!!!
  raIn[(iH div 2) * iW + (iW div 2)] := 0.0;

  // Ищем Максимум минимум входного массива
  FindMaxMinRealArrayNonZero(iW, iH, raIn, rMax, rMin);
  // Логарифмируем
  if rMin < MinDouble then
    // Если есть отрицательные значения -
    // то поднимаем чтобы массив был больше нуля
    for iY := 0 to iH - 1 do
      for iX := 0 to iW - 1 do
        praTemp^[iY * iW + iX] := Ln(raIn[iY * iW + iX] - rMin + MinDouble)
  else
    for iY := 0 to iH - 1 do
      for iX := 0 to iW - 1 do
        if raIn[iY * iW + iX] <> 0.0 then praTemp^[iY * iW + iX] := Ln(raIn[iY * iW + iX])
        else praTemp^[iY * iW + iX] := Ln(rMin);
  // Нормируем временный массив в диапазон 0..255
  NormRealArray(iW, iH, praTemp^, 0.0, 255.0);
  // Проверяем чего мы там на нормировали
  FindMaxMinRealArray(iW, iH, praTemp^, rMax, rMin);
  // Создаем Bitmap и переводим в него массив
  btOut := TBitmap.Create;
  btOut.Height := iH;
  btOut.Width := iW;
  btOut.PixelFormat := pf8bit;
  case iPaletteType of
    1 : btOut.Palette := CreateSpectrPalette;
    2 : btOut.Palette := CreateTermoPalette;
    else btOut.Palette := CreateBWPalette;
  end;
  if rMax - rMin <> 0 then
    for iY := 0 to iH - 1 do begin
      pbaTemp := btOut.ScanLine[iY];
      for iX := 0 to iW - 1 do begin
        iNum := Round(praTemp^[iY * iW + iX]);
        pbaTemp^[iX] := iNum;
      end;
   end;
  // Освобождаем память
  FreeMem(praTemp, iW * iH * SizeOf(TReal));
end;

procedure MatrixReal2Bitmap(iW, iH : Integer;
                            var raIn : TRealArray;
                            var btOut : TBitmap);
var
  iX, iY, iNum : Integer;
  pbaTemp : PByteArray;
  praTemp : PRealArray;
begin
  // Временный массив
  GetMem(praTemp, iW * iH * SizeOf(TReal));
  // Пеебрасываем для нормировки
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      praTemp^[iY * iW + iX] := raIn[iY * iW + iX];
  // Нормируем временный массив в диапазон 0..255
  NormRealArray(iW, iH, praTemp^, 0.0, 255.0);
  // Создаем Bitmap и переводим в него массив
  btOut := TBitmap.Create;
  btOut.Height := iH;
  btOut.Width := iW;
  btOut.PixelFormat := pf8bit;
  case iPaletteType of
    1 : btOut.Palette := CreateSpectrPalette;
    2 : btOut.Palette := CreateTermoPalette;
    else btOut.Palette := CreateBWPalette;
  end;
  for iY := 0 to iH - 1 do begin
    pbaTemp := btOut.ScanLine[iY];
    for iX := 0 to iW - 1 do begin
      iNum := Round(praTemp^[iY * iW + iX]);
      pbaTemp^[iX] := iNum;
    end;
  end;
  // Освобождаем память
  FreeMem(praTemp, iW * iH * SizeOf(TReal));
end;

procedure MatrixReal2BitmapTreshold(iW, iH : Integer;
                                    var raIn : TRealArray;
                                    var btOut : TBitmap;
                                    rUpThr, rLoThr : TReal;
                                    bShowUpThr, bShowLoThr : Boolean;
                                    var raHisto : TIntegerArray);
var
  iX, iY, iNum : Integer;
  pbaTemp : PByteArray;
  praTemp : PRealArray;
  ppeaPalette : ^TPaletteEntryArray;
  rNum : TReal;
begin
  // Временный массив
  GetMem(praTemp, iW * iH * SizeOf(TReal));
  CopyMemory(praTemp, Addr(raIn[0]), iW * iH * SizeOf(TReal));
  // Нормируем временный массив в диапазон 0..255
  NormRealArray(iW, iH, praTemp^, 0.0, 255.0);
  for iX := 0 to 255 do raHisto[iX] := 0;
  // Пеебрасываем для нормировки
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      rNum := praTemp^[iY * iW + iX];
      if rNum < rUpThr then begin
        if rNum > rLoThr then praTemp^[iY * iW + iX] := (rNum - rLoThr) /
          (rUpThr - rLoThr) * 255
        else praTemp^[iY * iW + iX] := 0;
      end
      else praTemp^[iY * iW + iX] := 255;
      iNum := Round(praTemp^[iY * iW + iX]);
      raHisto[iNum] := raHisto[iNum] + 1;
    end;
  // Создаем Bitmap и переводим в него массив
  btOut := TBitmap.Create;
  btOut.Height := iH;
  btOut.Width := iW;
  btOut.PixelFormat := pf24bit;
  case iPaletteType of
    1 : ppeaPalette := Addr(peaSpectr);
    2 : ppeaPalette := Addr(peaTermo);
    3 : ppeaPalette := Addr(peaSasha);
    else ppeaPalette := Addr(peaBW);
  end;
  for iY := 0 to iH - 1 do begin
    pbaTemp := btOut.ScanLine[iY];
    for iX := 0 to iW - 1 do begin
      iNum := Round(praTemp^[iY * iW + iX]);
      iNum := (iNum div (256 div iPaletteBit)) * (256 div iPaletteBit);
      pbaTemp^[iX * 3 + 0] := ppeaPalette^[iNum].peBlue;
      pbaTemp^[iX * 3 + 1] := ppeaPalette^[iNum].peGreen;
      pbaTemp^[iX * 3 + 2] := ppeaPalette^[iNum].peRed;
      if bShowLoThr and (iNum = 0) then begin
        pbaTemp^[iX * 3 + 0] := 255;
        pbaTemp^[iX * 3 + 2] := 0;
        pbaTemp^[iX * 3 + 1] := 0;
      end;
      if bShowUpThr and (iNum = 255) then begin
        pbaTemp^[iX * 3 + 0] := 0;
        pbaTemp^[iX * 3 + 2] := 255;
        pbaTemp^[iX * 3 + 1] := 0;
      end;
    end;
  end;
  // Освобождаем память
  FreeMem(praTemp, iW * iH * SizeOf(TReal));
end;

procedure MakePalette(var bitmapPalette : TBitmap);
var
  iX, iY, iNum : Integer;
  pbaTemp : PByteArray;
  ppeaPalette : ^TPaletteEntryArray;
begin
  // Создаем Bitmap и переводим в него массив
  bitmapPalette := TBitmap.Create;
  bitmapPalette.Height := 20;
  bitmapPalette.Width := 255;
  bitmapPalette.PixelFormat := pf24bit;
  case iPaletteType of
    1 : ppeaPalette := Addr(peaSpectr);
    2 : ppeaPalette := Addr(peaTermo);
    3 : ppeaPalette := Addr(peaSasha);    
    else ppeaPalette := Addr(peaBW);
  end;
  for iY := 0 to bitmapPalette.Height - 1 do begin
    pbaTemp := bitmapPalette.ScanLine[iY];
    for iX := 0 to bitmapPalette.Width - 1 do begin
      iNum := (iX div (256 div iPaletteBit)) * (256 div iPaletteBit);
      pbaTemp^[iX * 3 + 0] := ppeaPalette^[iNum].peBlue;
      pbaTemp^[iX * 3 + 1] := ppeaPalette^[iNum].peGreen;
      pbaTemp^[iX * 3 + 2] := ppeaPalette^[iNum].peRed;
    end;
  end;
end;

begin
  iPaletteType := 0;
  iPaletteBit := 256;
end.
