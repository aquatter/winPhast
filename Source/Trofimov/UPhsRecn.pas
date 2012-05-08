unit UPhsRecn;

interface

uses SysUtils, Dialogs, Math, UType, UFFT, URATool, ULinAlg, UCATool, UUnwrap, UFiltr, UFill,
     UMask, UBadPts, UIntPreP, UPhsToH;

var
  bCutLines, bChangeMax, bMoveMax, bIsSector : Boolean;
  rKWinX, rKWinY : TReal;

procedure PhaseByFFT1View(iW, iH : Integer;
                          var raInt1,
                          raSpectrum, raSpectrumFilt,
                          caOut : TRealArray);

//procedure FFTSynthesis3View(iW, iH : Integer;
//                            var caIn1, caIn2, caIn3, raMask, caOut : TRealArray);

procedure PhaseByFFTSub1View(iW, iH : Integer;
                             var raGrayObject, raInt1,
                             raSpectrum, raSpectrumSub, raSpectrumFilt,
                             caOut : TRealArray);

//procedure PhaseByFFTBaseSub1View(iW, iH : Integer;
//                                 var raGrayObject, raInt1,
//                                 raGrayBase, raBase1,
//                                 raSpectrum, raSpectrumSub, raSpectrumFilt,
//                                 caOut, raMask : TRealArray);

//procedure FFTSynthesis2View(iW, iH : Integer;
//                            var caIn1, caIn2, raMask, caOut : TRealArray);

//procedure PhaseByFFT1ViewRAShift(iW, iH : Integer;
//                                 rShift : TReal;
//                                 var raInt1,
//                                 raSpectrum, raSpectrumFilt,
//                                 raPhase, raAmp : TRealArray);

//procedure PhaseByFFTBaseSub2ViewFSRA(iW, iH : Integer;
//                                   var raGrayObject, raInt1, raInt2,
//                                   raGrayBase, raBase1, raBase2,
//                                   raSpectrum, raSpectrumSub, raSpectrumFilt,
//                                   raPhase, raAmp, raPhase1, raPhase2 : TRealArray);

//procedure PhaseByFFTBaseSub1ViewRA(iW, iH : Integer;
//                                   var raGrayObject, raInt1,
//                                   raGrayBase, raBase1,
//                                   raSpectrum, raSpectrumSub, raSpectrumFilt,
//                                   raPhase, raAmp : TRealArray);

//procedure PhaseByFFTBase1ViewRA(iW, iH : Integer;
//                                var raInt1, raBase1,
//                                raSpectrum, raSpectrumFilt,
//                                raPhase, raAmp : TRealArray);

//procedure PhaseByFFT1ViewRA(iW, iH : Integer;
//                            var raInt1,
//                            raSpectrum, raSpectrumFilt,
//                            raPhase, raAmp : TRealArray);

//procedure FFT2ViewFSAmpMask(iW, iH : Integer;
//                            var raGrayObject, raInt1, raInt2,
//                            raGrayBase, raBase1, raBase2,
//                            raBadPts : TRealArray);

{procedure BaseByFFT(XSIze, YSize, W1, W2, W3 : Integer;
                    var PIn, PBase, PSpectr  : TRealArray);

procedure PhaseByFFT(XSIze, YSize, WX, WY : Integer;
                     var PIn, POut, PAmpl, PSpectrDo, PSpectrPosle : TRealArray);
procedure PhaseByFFTAuto(XSIze, YSize : Integer;
                         var PIn, POut, PAmpl, PSpectrDo, PSpectrPosle : TRealArray);

procedure PhaseByFFT_BaseAuto(XSIze, YSize : Integer;
                              var PIn, PBase, POut, PAmpl,
                              PSpectrDo, PSpectrPosle  : TRealArray);

procedure PhaseByFFT_BaseAuto_ShiftMax(XSIze, YSize : Integer;
                                       N : TReal;
                                       var FX : INteger;
                                       var PIn, PBase, POut, PAmpl : TRealArray);

procedure PhaseByFFT_BaseAuto_Other(XSIze, YSize : Integer;
                                    var PIn, PBase, POut, PAmpl,
                                    PSpectrDo, PSpectrPosle  : TRealArray);}

//procedure PhaseByFFTBaseSub(iW, iH : Integer;
//                            var raGrayObject, raInt1, raInt2,
//                            raGrayBase, raBase1, raBase2,
//                            raSpectrum, raSpectrumSub, raSpectrumFilt,
//                            raPhase, raAmplitude,
//                            raBadPts, raPhaseUnwrap : TRealArray);

//procedure PhaseByFFTBaseSub2ViewUnwrap(iW, iH, R1, R2 : Integer;
//                                       var raGrayObject, raInt1, raInt2,
//                                       raGrayBase, raBase1, raBase2,
//                                       raSpectrum, raSpectrumSub, raSpectrumFilt,
//                                       raPhase, raAmplitude,
//                                       raBadPts, raPhaseUnwrap : TRealArray);

procedure ShiftPhase(iW, iH : Integer; var raIn, raMask, raOut : TRealArray);
procedure CAFilterSector(XSize, YSize : Integer; var PC, PCFilt : TRealArray);

implementation

procedure ShiftPhase(iW, iH : Integer; var raIn, raMask, raOut : TRealArray);
var
  rMax, rMin : TReal;
begin
  FindMaxMinRealArrayMask(iW, iH, raIn, raMask, rMax, rMin);
  while rMax + rMin > 2 * Pi do begin
    RAAddNum(iW, iH, raIn, raIn, - 2 * Pi);
    FindMaxMinRealArrayMask(iW, iH, raIn, raMask, rMax, rMin);
  end;
  while rMax + rMin < - 2 * Pi do begin
    RAAddNum(iW, iH, raIn, raIn, 2 * Pi);
    FindMaxMinRealArrayMask(iW, iH, raIn, raMask, rMax, rMin);
  end;
end;

{procedure CAFilterSector(XSize, YSize : Integer;
                         var PC, PCFilt : TRealArray;
                         bToChange : Boolean;
                         var raMask : TRealArray);
var
  I, J, CurX, CurY : Integer;
  MaxX, MAxY : Integer;
  YMax2, XMax2, rR, Fi, XMax1, YMax1 : TReal;
  praTEmp : PRealArray;
begin
  GetMem(praTemp, XSize*YSize*SizeOf(TReal));
  // Переводим данные в выходной массив из комплексного считая его модуль
  Complex2RealArray(xSize, YSize, PC, praTemp^, 4, True);
  // Ищем локальный максимум - первый порядок
  FindLocalMaxRealArray(xSize, YSize, praTemp^,
                        10, Sqrt(Sqr(XSize div 2) + Sqr(YSize div 2)),
                        MaxX, MaxY);
  if bToChange then begin
    // меняем
    MaxY := - MaxY;
    MaxX := - MaxX;
  end;
  rR := Sqrt(Sqr(MaxX) + Sqr(MaxY));
  // Выводим значения
//  ShowMessage(' X = ' + IntToStr(MaxX) +  ' Y = ' + IntToStr(MaxY) +
//              ' R = ' + FloatToStrF(rR, ffGeneral, 8, 2));
  // Угол наклона координатных осей и расстояние до первого порядка
  Fi := Arctan2(MaxY, MaxX);
  // Перемещаем первый порядок в нулевой
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do begin
      // Текущие координаты относительно центра экрана
      CurX := J - (XSize div 2);
      CurY := (YSize div 2) - I;
      // Координаты в системе координат связанной с первым порядком
      YMax1 := (CurY - MaxY) * Cos(Fi) - (CurX - MaxX) * Sin(Fi);
      XMax1 := (CurY - MaxY) * Sin(Fi) + (CurX - MaxX) * Cos(Fi);
      XMax2 := (CurY - 2 * MaxY) * Sin(Fi) + (CurX - 2 * MaxX) * Cos(Fi);
      YMax2 := (CurY - 2 * MaxY) * Cos(Fi) - (CurX - 2 * MaxX) * Sin(Fi);
      raMask[I * XSize + J] := 0.0;
      // Выделяем область и переносим ее в выходной массив
      //Убираем ненужное
      if (Sqrt(Sqr(CurX) + Sqr(CurY)) > 0.4 * rR) and
         (Sqrt(Sqr(CurX) + Sqr(CurY)) < 5 * rR) and
//         ((Abs(CurX) > 1) and (Abs(CurY) > 1)) and
//         ((Abs(CurX + MaxX) > 1) and (Abs(CurY + MaxY) > 1)) and
         (XMax1 > - rR / 2) //and
//         not ((XMax2 > - 0.2 * rR) and (Abs(YMax2) < XMax2 + 0.2 * rR)) and
//         (Sqrt(Sqr(YMax2) + Sqr(XMax2)) > 0.4 * rR) and
//         ((XMax1 < rR) or (Abs(YMax1) > 0.2 * rR))
        then begin
        if (J - MaxX < XSize) and (J - MaxX > 0) and
          (I + MaxY < YSize) and (I + MaxY > 0) then begin
          PCFilt[((I + MaxY) * XSize + J - MaxX) * 2] := PC[(I * XSize + J) * 2]
            * FltWin(Sqrt(Sqr(XMax1) + Sqr(YMax1)), 10 * rR, fwHann);
          PCFilt[((I + MaxY) * XSize + J - MaxX) * 2 + 1] := PC[(I * XSize + J) * 2 + 1]
            * FltWin(Sqrt(Sqr(XMax1) + Sqr(YMax1)), 10 * rR, fwHann);
          raMask[(I + MaxY) * XSize + J - MaxX] := 1.0;
        end;
      end
    end;
end;}

procedure CAFilterSector(XSize, YSize : Integer;
                         var PC, PCFilt : TRealArray);
var
  I, J, CurX, CurY : Integer;
  MaxX, MAxY : Integer;
  rK, YMax2, XMax2, rR, Fi, XMax1, YMax1 : TReal;
  praTEmp : PRealArray;
  bIsOnSector : Boolean;
begin
  GetMem(praTemp, XSize*YSize*SizeOf(TReal));
  // Переводим данные в выходной массив из комплексного считая его модуль
  Complex2RealArray(xSize, YSize, PC, praTemp^, 4, True);
  // Ищем локальный максимум - первый порядок
  FindLocalMaxRealArray(xSize, YSize, praTemp^,
                        25, 170,//Sqrt(Sqr(XSize div 2) + Sqr(YSize div 2)),
                        MaxX, MaxY);
  if bChangeMax then begin
    // меняем
    MaxY := - MaxY;
    MaxX := - MaxX;
  end;
  rR := Sqrt(Sqr(MaxX) + Sqr(MaxY));
  // Угол наклона координатных осей и расстояние до первого порядка
  Fi := Arctan2(MaxY, MaxX);
  // Перемещаем первый порядок в нулевой
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do begin
      // Текущие координаты относительно центра экрана
      CurX := J - (XSize div 2);
      CurY := (YSize div 2) - I;
      // Координаты в системе координат связанной с первым порядком
      YMax1 := (CurY - MaxY) * Cos(Fi) - (CurX - MaxX) * Sin(Fi);
      XMax1 := (CurY - MaxY) * Sin(Fi) + (CurX - MaxX) * Cos(Fi);
      XMax2 := (CurY - 2 * MaxY) * Sin(Fi) + (CurX - 2 * MaxX) * Cos(Fi);
      YMax2 := (CurY - 2 * MaxY) * Cos(Fi) - (CurX - 2 * MaxX) * Sin(Fi);
//      raMask[I * XSize + J] := 0.0;
      // Выделяем область и переносим ее в выходной массив
      //Убираем ненужное
      if bIsSector then begin
        bIsOnSector := (Sqrt(Sqr(CurX) + Sqr(CurY)) > 0.4 * rR) and // ноль порядок
//          (Sqrt(Sqr(CurX) + Sqr(CurY)) < 5 * rR) and // все поле
//          (Sqr(XMax1) + Sqr(YMax1) < Sqr(1.5 * rR)) and // все поле
          (XMax1 > - rR) and // полуплоскость
          // остальные максимумы
          not ((XMax2 > - 0.2 * rR) and (Abs(YMax2) < XMax2 + 0.2* rR)) and
          (Sqrt(Sqr(YMax2) + Sqr(XMax2)) >= 0.3 * rR); //and  // второй максимум
//          ((XMax1 < rR) or (Abs(YMax1) > 0.2 * rR)); // остальные максимумы
        if bCutLines then bIsOnSector := bIsOnSector and
          ((Abs(CurX) > 1) and
          ((Abs(CurX - MaxX) < 3) or (Abs(CurY) > 1))) and
          ((Abs(CurX + MaxX) > 1) and
            ((Abs(CurX - MaxX) < 3) or (Abs(CurY + MaxY) > 1))) and
          ((Abs(CurX - 2 * MaxX) > 1) and
            ((Abs(CurY - 2 * MaxY) > 1) or (Abs(CurX - MaxX) < 3)));
      end else bIsOnSector := True;
      if bIsOnSector then begin
        if bIsSector then
          rK := FltWin(Sqrt(Sqr(XMax1) + Sqr(YMax1)), 10 * rR, fwHann)
//          rK := FltWin(Sqrt(Sqr(XMax1) + Sqr(YMax1)), 5 * rR, fwHann)
        else
          rK := FltWin(Abs(YMax1), rKWinY * rR, fwHann) *
            FltWin(Abs(XMax1), rKWinX * rR, fwHann);
        if bMoveMax then begin
          if (J - MaxX < XSize) and (J - MaxX > 0) and
            (I + MaxY < YSize) and (I + MaxY > 0) then begin
            PCFilt[((I + MaxY) * XSize + J - MaxX) * 2] :=
              PC[(I * XSize + J) * 2] * rK;
            PCFilt[((I + MaxY) * XSize + J - MaxX) * 2 + 1] :=
              PC[(I * XSize + J) * 2 + 1] * rK;
//            raMask[(I + MaxY) * XSize + J - MaxX] := 1;
          end
        end
        else
        begin
          PCFilt[I * XSize + J]:=(PCFilt[I * XSize + J]+1)*rK;

          {PCFilt[(I * XSize + J) * 2] :=
            (PCFilt[(I * XSize + J) * 2] +1)* rK;
          PCFilt[(I * XSize + J) * 2 + 1] :=
            (PCFilt[(I * XSize + J) * 2 + 1] +1)* rK;}
//          raMask[I * XSize + J] := 1;
        end;
      end
    end;
  FreeMem(praTemp, XSize*YSize*SizeOf(TReal));
end;

{procedure CAFilterSectorHilbert(XSize, YSize : Integer;
                                var PC, PCFilt : TRealArray);
var
  I, J, CurX, CurY : Integer;
  MaxX, MAxY : Integer;
  rRe, rIm, Fi1, YMax21, XMax21, XMax11, YMax11, YMax2, XMax2, rR, Fi, XMax1,
    YMax1 : TReal;
  praTEmp : PRealArray;
begin
  GetMem(praTemp, XSize*YSize*SizeOf(TReal));
  // Переводим данные в выходной массив из комплексного считая его модуль
  Complex2RealArray(xSize, YSize, PC, praTemp^, 4, True);
  // Ищем локальный максимум - первый порядок
  FindLocalMaxRealArray(xSize, YSize, praTemp^,
                        10, Sqrt(Sqr(XSize div 2) + Sqr(YSize div 2)),
                        MaxX, MaxY);
  rR := Sqrt(Sqr(MaxX) + Sqr(MaxY));
  // Угол наклона координатных осей и расстояние до первого порядка
  Fi := Arctan2(MaxY, MaxX);
  Fi1 := Arctan2(-MaxY, -MaxX);
  // Перемещаем первый порядок в нулевой
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do begin
      // Текущие координаты относительно центра экрана
      CurX := J - (XSize div 2);
      CurY := (YSize div 2) - I;
      // Координаты в системе координат связанной с первым порядком
      YMax1 := (CurY - MaxY) * Cos(Fi) - (CurX - MaxX) * Sin(Fi);
      XMax1 := (CurY - MaxY) * Sin(Fi) + (CurX - MaxX) * Cos(Fi);
      XMax2 := (CurY - 2 * MaxY) * Sin(Fi) + (CurX - 2 * MaxX) * Cos(Fi);
      YMax2 := (CurY - 2 * MaxY) * Cos(Fi) - (CurX - 2 * MaxX) * Sin(Fi);
      YMax11 := (CurY + MaxY) * Cos(Fi1) - (CurX + MaxX) * Sin(Fi1);
      XMax11 := (CurY + MaxY) * Sin(Fi1) + (CurX + MaxX) * Cos(Fi1);
      XMax21 := (CurY + 2 * MaxY) * Sin(Fi1) + (CurX + 2 * MaxX) * Cos(Fi1);
      YMax21 := (CurY + 2 * MaxY) * Cos(Fi1) - (CurX + 2 * MaxX) * Sin(Fi1);
      // Выделяем область и переносим ее в выходной массив
      //Убираем ненужное
      if (Sqrt(Sqr(CurX) + Sqr(CurY)) > 0.4 * rR) and
        (Sqrt(Sqr(CurX) + Sqr(CurY)) < 5 * rR) and
        ((Abs(CurX) > 1) and (Abs(CurY) > 1)) and
        ((Abs(CurX + MaxX) > 1) and (Abs(CurY + MaxY) > 1)) and
        (XMax1 > - rR) and
        not ((XMax2 > - 0.2 * rR) and (Abs(YMax2) < XMax2 + 0.2 * rR)) and
        (Sqrt(Sqr(YMax2) + Sqr(XMax2)) > 0.4 * rR) and
        ((XMax1 < rR) or (Abs(YMax1) > 0.2 * rR)) then begin
          PCFilt[(I * XSize + J) * 2] := PC[(I * XSize + J) * 2]
            * FltWin(Sqrt(Sqr(XMax1) + Sqr(YMax1)), 10 * rR, fwHann);
          PCFilt[(I * XSize + J) * 2 + 1] := PC[(I * XSize + J) * 2 + 1]
            * FltWin(Sqrt(Sqr(XMax1) + Sqr(YMax1)), 10 * rR, fwHann);
      end;
      if (Sqrt(Sqr(CurX) + Sqr(CurY)) > 0.4 * rR) and // круг в нулевом порядке
        (Sqrt(Sqr(CurX) + Sqr(CurY)) < 5 * rR) and // круг вокруг всего
        ((Abs(CurX) > 1) and (Abs(CurY) > 1)) and // полосы на осях
        ((Abs(CurX - MaxX) > 1) and (Abs(CurY - MaxY) > 1)) and // полосы на первом порядке
        (XMax11 > - rR) and // полуплоскость в координатах порядка
        not ((XMax21 > - 0.2 * rR) and (Abs(YMax21) < XMax21 + 0.2 * rR)) and // сектор от второго порядка
        (Sqrt(Sqr(YMax21) + Sqr(XMax21)) > 0.4 * rR) and // круг на втором порядке
        ((XMax11 < rR) or (Abs(YMax11) > 0.2 * rR)) then begin // полосы на 3 и выше порядки
          PCFilt[(I * XSize + J) * 2] := PC[(I * XSize + J) * 2]
            * FltWin(Sqrt(Sqr(XMax11) + Sqr(YMax11)), 10 * rR, fwHann);
          PCFilt[(I * XSize + J) * 2 + 1] := PC[(I * XSize + J) * 2 + 1]
            * FltWin(Sqrt(Sqr(XMax11) + Sqr(YMax11)), 10 * rR, fwHann);
      end
    end;
  // гильберт
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do begin
      // Текущие координаты относительно центра экрана
      CurX := J - (XSize div 2);
      CurY := (YSize div 2) - I;
      YMax1 := (CurY) * Cos(Fi) - (CurX) * Sin(Fi);
      XMax1 := (CurY) * Sin(Fi) + (CurX) * Cos(Fi);
      rRe := PC[(I * XSize + J) * 2];
      rIm := PC[((YSize - 1 - I) * XSize + XSize -1 - J) * 2];
      PCFilt[(I * XSize + J) * 2] :=  (- rIm + rRe) / 2;
//      rRe := PCFilt[(I * XSize + J) * 2 + 1];
//      rIm := PCFilt[((YSize - I - 1) * XSize + XSize - J - 1) * 2];
//      PCFilt[(I * XSize + J) * 2 + 1] :=  (rIm + rRe) / 2;
      PCFilt[(I * XSize + J) * 2 + 1] :=  0.0;
//      if (XMax1 > 0) then begin
//        PCFilt[(I * XSize + J) * 2] :=  (rIm + rRe) / 2;
//        PCFilt[(I * XSize + J) * 2 + 1] := 0.0;
//      end
//      else begin
//        if (XMax1 < 0) then begin
//          PCFilt[(I * XSize + J) * 2] := rIm;
//          PCFilt[(I * XSize + J) * 2 + 1] := - rRe;
//        end
//        else begin
//          PCFilt[(I * XSize + J) * 2] := rRe;
//          PCFilt[(I * XSize + J) * 2 + 1] := rIm;
//        end;
//      end;
  end;
end;}

{procedure CAFilterMove(XSize, YSize, MaxX, MaxY, WX, WY, WindowTYpe : Integer;
                       var PC, PCFilt : TRealArray);
var
  I, J, CurX, CurY : Integer;
  rR, Fi, XMax1, YMax1 : TReal;
begin
  MaxY := - MaxY;
  MaxX := - MaxX;
  rR := Sqrt(Sqr(MaxX) + Sqr(MaxY));
  // Угол наклона координатных осей и расстояние до первого порядка
  Fi := Arctan2(MaxY, MaxX);
  // Перемещаем первый порядок в нулевой
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do begin
      // Текущие координаты относительно центра экрана
      CurX := J - (XSize div 2);
      CurY := (YSize div 2) - I;
      // Координаты в системе координат связанной с первым порядком
      YMax1 := (CurY - MaxY) * Cos(Fi) - (CurX - MaxX) * Sin(Fi);
      XMax1 := (CurY - MaxY) * Sin(Fi) + (CurX - MaxX) * Cos(Fi);
      // Выделяем область и переносим ее в выходной массив
      if (Abs(XMax1) < WX) and (Abs(YMax1) < WY) then begin
        if (J - MaxX < XSize) and (J - MaxX > 0) and
           (I + MaxY < YSize) and (I + MaxY > 0) then begin
          PCFilt[((I + MaxY) * XSize + J - MaxX) * 2] := PC[(I * XSize + J)*2] *
            FltWin(XMax1, 2 * WX, WindowType) *
            FltWin(YMax1, 2 * WY, WindowType);
          PCFilt[((I + MaxY) * XSize + J - MaxX) * 2 + 1] := PC[(I * XSize + J)*2 + 1] *
            FltWin(XMax1, 2 * WX, WindowType) *
            FltWin(YMax1, 2 * WY, WindowType);
        end;
      end
    end;
end;}

{procedure CAFilter(XSize, YSize, MaxX, MaxY, WX, WY, WindowTYpe : Integer;
                   var PC, PCFilt : TRealArray);
var
  I, J, CurX, CurY : Integer;
  Fi, XMax1, YMax1 : TReal;
begin
  MaxY := - MaxY;
  MaxX := - MaxX;
  // Угол наклона координатных осей и расстояние до первого порядка
  Fi := Arctan2(MaxY, MaxX);
  // Перемещаем первый порядок в нулевой
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do begin
      // Текущие координаты относительно центра экрана
      CurX := J - (XSize div 2);
      CurY := (YSize div 2) - I;
      // Координаты в системе координат связанной с первым порядком
      YMax1 := (CurY - MaxY) * Cos(Fi) - (CurX - MaxX) * Sin(Fi);
      XMax1 := (CurY - MaxY) * Sin(Fi) + (CurX - MaxX) * Cos(Fi);
      // Выделяем область и переносим ее в выходной массив
      if (Abs(XMax1) <= WX) and (Abs(YMax1) <= WY) then begin
        PCFilt[(I * XSize + J) * 2] := PC[(I * XSize + J) * 2] *
          FltWin(XMax1, 2 * WX, WindowType) *
          FltWin(YMax1, 2 * WY, WindowType);
        PCFilt[(I * XSize + J) * 2 + 1] := PC[(I * XSize + J) * 2 + 1] *
          FltWin(XMax1, 2 * WX, WindowType) *
          FltWin(YMax1, 2 * WY, WindowType);
      end;
    end;
end;}

{procedure CAFilterAuto(XSize, YSize, MaxX, MaxY, WindowTYpe : Integer;
                       var PC, PCFilt : TRealArray);
var
  R : TReal;
  WX, WY : Integer;
begin
  // параметры окна
  R := Sqrt(Sqr(MaxX) + Sqr(MaxY));
  WY := Round(R / 2.22);
  WX := Round(R / 1.67);
  CAFilter(XSize, YSize, MaxX, MaxY, WX, WY, WindowType, PC, PCFilt);
end;}

{procedure CAFilterMoveAuto(XSize, YSize, MaxX, MaxY, WindowTYpe : Integer;
                           var PC, PCFilt : TRealArray);
var
  R : TReal;
  WX, WY : Integer;
begin
  // параметры окна
  R := Sqrt(Sqr(MaxX) + Sqr(MaxY));
  WY := Round(R / 2.22);
  WX := Round(R / 1.67);
  CAFilterMove(XSize, YSize, MaxX, MaxY, WX, WY, WindowType, PC, PCFilt);
end;}

{procedure BaseByFFT(XSIze, YSize, W1, W2, W3 : Integer;
                    var PIn, PBase, PSpectr  : TRealArray);
var
  PC, PCFilt : PRealArray;
  MaxX, MaxY : Integer;
begin
  // Создаем временные массивы
  GetMem(PC, XSize*YSize*2*SizeOf(TReal));
  GetMem(PCFilt, XSize*YSize*2*SizeOf(TReal));
  // БПФ
  Forward2dFFTReal(XSize, YSize, PIn, PC^);
  // Переводим данные в выходной массив из комплексного считая его модуль
  Complex2RealArray(XSize, YSize, PC^, PSpectr, 4, True);
  // Ищем локальный максимум - первый порядок
  FindLocalMaxRealArray(XSize, YSize, PSpectr,
                        10, Sqrt(Sqr(XSize div 2) + Sqr(YSize div 2)),
                        MaxX, MaxY);
  // Зануляем выходной массив и инициализируемся
  FillRealArrayNum(2 * XSize, YSize, PCFilt^, 0.0);
  // Фильтруем
  CAFilter(XSize, YSize, MaxX, MaxY, W1, W1, fwHemming, PC^, PCFilt^);
  CAFilter(XSize, YSize, - MaxX, - MaxY, W2, W2, fwHemming, PC^, PCFilt^);
  CAFilter(XSize, YSize, 0, 0, W3, W3, fwHemming, PC^, PCFilt^);
  // Обратное БПФ
  Backward2dFFT(XSize, YSize, PCFilt^, PC^);
  // Переводим данные в выходной массив из комплексного считая его модуль
  Complex2RealArray(XSize, YSize, PC^, PBase, 4, True);
  // Нормируем базу
  NormRealArray(XSize, YSize, PBase, 0, 255);
  // Освобождаем память
  FreeMem(PC, XSize*YSize*2*SizeOf(TReal));
  FreeMem(PCFilt, XSize*YSize*2*SizeOf(TReal));
end;

procedure PhaseByFFT(XSIze, YSize, WX, WY : Integer;
                     var PIn, POut, PAmpl, PSpectrDo, PSpectrPosle : TRealArray);
var
  PC, PCFilt : PRealArray;
  MaxX, MaxY : Integer;
begin
  // Создаем временные массивы
  GetMem(PC, XSize*YSize*2*SizeOf(TReal));
  GetMem(PCFilt, XSize*YSize*2*SizeOf(TReal));
  // БПФ
  Forward2dFFTReal(XSize, YSize, PIn, PC^);
  // Переводим данные в выходной массив из комплексного считая его модуль
  Complex2RealArray(XSize, YSize, PC^, PSpectrDo, 4, True);
  // Ищем локальный максимум - первый порядок
  FindLocalMaxRealArray(XSize, YSize, PSpectrDo,
                        10, Sqrt(Sqr(XSize div 2) + Sqr(YSize div 2)),
                        MaxX, MaxY);
//  R := Sqrt(Sqr(MaxX) + Sqr(MaxY));
//  ShowMessage('Расстояние до максимума - ' + FloatToStr(R));
  // Зануляем выходной массив и инициализируемся
  FillRealArrayNum(2 * XSize, YSize, PCFilt^, 0.0);
  // Фильтруем с переносом
  CAFilterMove(XSize, YSize, MaxX, MaxY, WX, WY, fwHemming, PC^, PCFilt^);
  // Переводим данные в выходной массив из комплексного считая его модуль
  Complex2RealArray(XSize, YSize, PCFilt^, PSpectrPosle, 4, True);
  // Обратное БПФ
  Backward2dFFT(XSize, YSize, PCFilt^, PC^);
  // Переводим данные в выходной массив из комплексного считая его фазу
  Complex2RealArray(XSize, YSize, PC^, POut, 8, False);
  Complex2RealArray(XSize, YSize, PC^, PAmpl, 4, True);
  // Освобождаем память
  FreeMem(PC, XSize*YSize*2*SizeOf(TReal));
  FreeMem(PCFilt, XSize*YSize*2*SizeOf(TReal));
end;

procedure PhaseByFFT_BaseAuto(XSIze, YSize : Integer;
                              var PIn, PBase, POut, PAmpl,
                              PSpectrDo, PSpectrPosle  : TRealArray);
var
  PC2, PC, PCFilt : PRealArray;
  MaxX, MaxY : Integer;
begin
  // Создаем временные массивы
  GetMem(PC, XSize*YSize*2*SizeOf(TReal));
  GetMem(PC2, XSize*YSize*2*SizeOf(TReal));
  GetMem(PCFilt, XSize*YSize*2*SizeOf(TReal));
  // БПФ
  Forward2dFFTReal(XSize, YSize, PIn, PC^);
  // Переводим данные в выходной массив из комплексного считая его модуль
  Complex2RealArray(XSize, YSize, PC^, PSpectrDo, 4, True);
  // Ищем локальный максимум - первый порядок
  FindLocalMaxRealArray(XSize, YSize, PSpectrDo,
                        10, Sqrt(Sqr(XSize div 2) + Sqr(YSize div 2)),
                        MaxX, MaxY);
  // Зануляем выходной массив и инициализируемся
  FillRealArrayNum(2 * XSize, YSize, PCFilt^, 0.0);
  // Фильтруем
  CAFilterAuto(XSize, YSize, MaxX, MaxY, fwHemming, PC^, PCFilt^);
  // Обратное БПФ
  Backward2dFFT(XSize, YSize, PCFilt^, PC^);
  // То же самое для базы
  Forward2dFFTReal(XSize, YSize, PBase, PC2^);
  FillRealArrayNum(2 * XSize, YSize, PCFilt^, 0.0);
  CAFilterAuto(XSize, YSize, MaxX, MaxY, fwHemming, PC2^, PCFilt^);
  Backward2dFFT(XSize, YSize, PCFilt^, PC2^);
  // Умножаем инт на комплексно сопряженное от базы
  CAMulAdjoint(XSize, YSize, PC^, PC2^, PCFilt^);
  // Переводим данные в выходной массив из комплексного считая его фазу
  Complex2RealArray(XSize, YSize, PCFilt^, POut, 8, False);
  Complex2RealArray(XSize, YSize, PCFilt^, PAmpl, 4, True);
  NormRealArray(XSize, YSize, PAmpl, 0, 255);
  // Освобождаем память
  FreeMem(PC, XSize*YSize*2*SizeOf(TReal));
  FreeMem(PC2, XSize*YSize*2*SizeOf(TReal));
  FreeMem(PCFilt, XSize*YSize*2*SizeOf(TReal));
end;

procedure PhaseByFFT_BaseAuto_Other(XSIze, YSize : Integer;
                                    var PIn, PBase, POut, PAmpl,
                                    PSpectrDo, PSpectrPosle  : TRealArray);
var
  PC2, PC, PCFilt : PRealArray;
  MaxX, MaxY : Integer;
begin
  // Создаем временные массивы
  GetMem(PC, XSize*YSize*2*SizeOf(TReal));
  GetMem(PC2, XSize*YSize*2*SizeOf(TReal));
  GetMem(PCFilt, XSize*YSize*2*SizeOf(TReal));
  // БПФ
  Forward2dFFTReal(XSize, YSize, PIn, PC^);
  // Переводим данные в выходной массив из комплексного считая его модуль
  Complex2RealArray(XSize, YSize, PC^, PSpectrDo, 4, True);
  // Ищем локальный максимум - первый порядок
  FindLocalMaxRealArray(XSize, YSize, PSpectrDo,
                        10, Sqrt(Sqr(XSize div 2) + Sqr(YSize div 2)),
                        MaxX, MaxY);
  // Зануляем выходной массив и инициализируемся
  FillRealArrayNum(2 * XSize, YSize, PCFilt^, 0.0);
  // Фильтруем
  CAFilterAuto(XSize, YSize, -MaxX, -MaxY, fwHemming, PC^, PCFilt^);
  // Обратное БПФ
  Backward2dFFT(XSize, YSize, PCFilt^, PC^);
  // То же самое для базы
  Forward2dFFTReal(XSize, YSize, PBase, PC2^);
  FillRealArrayNum(2 * XSize, YSize, PCFilt^, 0.0);
  CAFilterAuto(XSize, YSize, -MaxX, -MaxY, fwHemming, PC2^, PCFilt^);
  Backward2dFFT(XSize, YSize, PCFilt^, PC2^);
  // Умножаем инт на комплексно сопряженное от базы
  CAMulAdjoint(XSize, YSize, PC^, PC2^, PCFilt^);
  // Переводим данные в выходной массив из комплексного считая его фазу
  Complex2RealArray(XSize, YSize, PCFilt^, POut, 8, False);
  Complex2RealArray(XSize, YSize, PCFilt^, PAmpl, 4, True);
  NormRealArray(XSize, YSize, PAmpl, 0, 255);
  // Освобождаем память
  FreeMem(PC, XSize*YSize*2*SizeOf(TReal));
  FreeMem(PC2, XSize*YSize*2*SizeOf(TReal));
  FreeMem(PCFilt, XSize*YSize*2*SizeOf(TReal));
end;

procedure PhaseByFFT_BaseAuto_ShiftMax(XSIze, YSize : Integer;
                                       N : TReal;
                                       var FX : INteger;
                                       var PIn, PBase, POut, PAmpl : TRealArray);
var
  PTemp, PC2, PC, PCFilt : PRealArray;
  MaxX, MaxY : Integer;
begin
  // Создаем временные массивы
  GetMem(PTemp, XSize*YSize*SizeOf(TReal));
  GetMem(PC, XSize*YSize*2*SizeOf(TReal));
  GetMem(PC2, XSize*YSize*2*SizeOf(TReal));
  GetMem(PCFilt, XSize*YSize*2*SizeOf(TReal));
  // БПФ
  Forward2dFFTReal(XSize, YSize, PIn, PC^);
  // Переводим данные в выходной массив из комплексного считая его модуль
  Complex2RealArray(XSize, YSize, PC^, PTemp^, 4, True);
  // Ищем локальный максимум - первый порядок
  FindLocalMaxRealArray(XSize, YSize, PTemp^,
                        10, Sqrt(Sqr(XSize div 2) + Sqr(YSize div 2)),
                        MaxX, MaxY);
  FX := MaxY;
  // Зануляем выходной массив и инициализируемся
  FillRealArrayNum(2 * XSize, YSize, PCFilt^, 0.0);
  // Фильтруем
  CAFilterAuto(XSize, YSize, MaxX, MaxY, fwHemming, PC^, PCFilt^);
  // Умножаем для сдвига
  CAMulCNum(XSIze, YSize, PCFilt^, PCFilt^, Cos(N), Sin(N));
  // Обратное БПФ
  Backward2dFFT(XSize, YSize, PCFilt^, PC^);
  // Тоже для базы
  Forward2dFFTReal(XSize, YSize, PBase, PC2^);
  FillRealArrayNum(2 * XSize, YSize, PCFilt^, 0.0);
  CAFilterAuto(XSize, YSize, MaxX, MaxY, fwHemming, PC2^, PCFilt^);
  Backward2dFFT(XSize, YSize, PCFilt^, PC2^);
  // Умножаем инт на комплексно сопряженное от базы
  CAMulAdjoint(XSize, YSize, PC^, PC2^, PCFilt^);
  // Переводим данные в выходной массив из комплексного считая его фазу
  Complex2RealArray(XSize, YSize, PCFilt^, POut, 8, False);
  Complex2RealArray(XSize, YSize, PCFilt^, PAmpl, 4, False);
  NormRealArray(XSize, YSize, PAmpl, 0, 255);
  // Освобождаем память
  FreeMem(PC, XSize*YSize*2*SizeOf(TReal));
  FreeMem(PC2, XSize*YSize*2*SizeOf(TReal));
  FreeMem(PCFilt, XSize*YSize*2*SizeOf(TReal));
  FreeMem(PTemp, XSize*YSize*SizeOf(TReal));
end;

procedure PhaseByFFTAuto(XSIze, YSize : Integer;
                         var PIn, POut, PAmpl, PSpectrDo, PSpectrPosle : TRealArray);
var
  PC, PCFilt : PRealArray;
  MaxX, MaxY : Integer;
begin
  // Создаем временные массивы
  GetMem(PC, XSize*YSize*2*SizeOf(TReal));
  GetMem(PCFilt, XSize*YSize*2*SizeOf(TReal));
  // БПФ
  Forward2dFFTReal(XSize, YSize, PIn, PC^);
  // Переводим данные в выходной массив из комплексного считая его модуль
  Complex2RealArray(XSize, YSize, PC^, PSpectrDo, 4, True);
  // Ищем локальный максимум - первый порядок
  FindLocalMaxRealArray(XSize, YSize, PSpectrDo,
                        10, Sqrt(Sqr(XSize div 2) + Sqr(YSize div 2)),
                        MaxX, MaxY);
  // Зануляем выходной массив и инициализируемся
  FillRealArrayNum(2 * XSize, YSize, PCFilt^, 0.0);
  // Фильтруем с переносом
  CAFilterMoveAuto(XSize, YSize, MaxX, MaxY, fwHemming, PC^, PCFilt^);
  // Переводим данные в выходной массив из комплексного считая его модуль
  Complex2RealArray(XSize, YSize, PCFilt^, PSpectrPosle, 4, True);
  // Обратное БПФ
  Backward2dFFT(XSize, YSize, PCFilt^, PC^);
  // Переводим данные в выходной массив из комплексного считая его фазу
  Complex2RealArray(XSize, YSize, PC^, POut, 8, False);
  Complex2RealArray(XSize, YSize, PC^, PAmpl, 4, True);
  // Освобождаем память
  FreeMem(PC, XSize*YSize*2*SizeOf(TReal));
  FreeMem(PCFilt, XSize*YSize*2*SizeOf(TReal));
end;

procedure CAFillZeroMaxProcentRA(iW, iH : Integer;
                                 var caIn : TRealArray;
                                 iProcent : Integer;
                                 bToChange : Boolean);
var
  rMin, rMax : TReal;
  iBX, iBY, iCount : Integer;
  praSpectr, praMask : PRealArray;
  bIsFound : Boolean;
begin
  GetMem(praMAsk, iW * iH * SizeOf(TReal));
  GetMem(praSpectr, iW * iH * SizeOf(TReal));
  Complex2RealArray(iW, iH, caIn, praSpectr^, 4, True);
  FindLocalMaxRealArray(iW, iH, praSpectr^, 10, Sqrt(Sqr(iW div 2) +
    Sqr(iH div 2)), iBX, iBY);
  if bToChange then begin
    // меняем
    iBY := (iH div 2) + iBY;
    iBX := (iW div 2) - iBX;
  end
  else begin
    iBY := (iH div 2) - iBY;
    iBX := (iW div 2) + iBX;
  end;
  LogarithmFltr(iW, iH, praSpectr^, praSpectr^);
  FindMaxMinRealArray(iW, iH, praSpectr^, rMax, rMin);
  for iCount := 0 to iW * iH - 1 do
    if praSpectr^[iCount] < rMax * iProcent / 100 then praMask^[iCount] := 0
    else praMask^[iCount] := 1;

  DestroyHoles(iW, iH, 20, praMask^, praMask^);

  for iCount := 0 to iW * iH - 1 do if praMask^[iCount] = 0 then begin
    caIn[iCount * 2] := 0;
    caIn[iCount * 2 + 1] := 0;
  end;
  FreeMem(praMAsk, iW * iH * SizeOf(TReal));
  FreeMem(praSpectr, iW * iH * SizeOf(TReal));
end;}

// !!!! Далее процедуры восстановления с новым окном - сектором

procedure PhaseByFFT1View(iW, iH : Integer;
                          var raInt1,
                          raSpectrum, raSpectrumFilt,
                          caOut : TRealArray);
var
  pcaFilt1 : PRealArray;
begin
  // выделяем память
  GetMem(pcaFilt1, iW * iH * 2 * SizeOf(TReal));
  // БПФ
  Forward2dFFTReal(iW, iH, raInt1, caOut);
  // На выход
  Complex2RealArray(iW, iH, caOut, raSpectrum, 4, True);
  // Зануляем массивы с фильтрованными спектрами
  FillRealArrayNum(2 * iW, iH, pcaFilt1^, 0.0);
  // Фильтруем
//  if bMoveMax then
  CAFilterSector(iW, iH, caOut, pcaFilt1^);
//  else CAFilterMoveSector(iW, iH, caOut, pcaFilt1^, bSpectrumMax, raMask);
  // На выход
  Complex2RealArray(iW, iH, pcaFilt1^, raSpectrumFilt, 4, True);

//  CAFillZeroMaxProcentRA(iW, iH, pcaFilt1^, 80, bSpectrumMax);

  // Обратное БПФ
  Backward2dFFT(iW, iH, pcaFilt1^, caOut);
  // освобождаем память
  FreeMem(pcaFilt1, iW * iH * 2 * SizeOf(TReal));
end;

{procedure PhaseByFFT1ViewRA(iW, iH : Integer;
                            var raInt1,
                            raSpectrum, raSpectrumFilt,
                            raPhase, raAmp : TRealArray);
var
  pcaFilt1, praMask, pcaOut : PRealArray;
begin
  // выделяем память
  GetMem(pcaOut, iW * iH * 2 * SizeOf(TReal));
  GetMem(praMask, iW * iH * SizeOf(TReal));
  GetMem(pcaFilt1, iW * iH * 2 * SizeOf(TReal));
  // БПФ
  Forward2dFFTReal(iW, iH, raInt1, pcaOut^);
  // На выход
  Complex2RealArray(iW, iH, pcaOut^, raSpectrum, 4, True);
  // Зануляем массивы с фильтрованными спектрами
  FillRealArrayNum(2 * iW, iH, pcaFilt1^, 0.0);
  // Фильтруем
  CAFilterSector(iW, iH, pcaOut^, pcaFilt1^, True, praMask^);
  // На выход
  Complex2RealArray(iW, iH, pcaFilt1^, raSpectrumFilt, 4, True);
  // Обратное БПФ
  Backward2dFFT(iW, iH, pcaFilt1^, pcaOut^);
  // Получаем по нему фазу и амплитуду
  Complex2RealArray(iW, iH, pcaOut^, raPhase, 8, True);
  Complex2RealArray(iW, iH, pcaOut^, raAmp, 4, True);
  // освобождаем память
  FreeMem(pcaFilt1, iW * iH * 2 * SizeOf(TReal));
  FreeMem(pcaOut, iW * iH * 2 * SizeOf(TReal));
  FreeMem(praMask, iW * iH * SizeOf(TReal));
end;}

{procedure PhaseByFFT1ViewRAShift(iW, iH : Integer;
                                 rShift : TReal;
                                 var raInt1,
                                 raSpectrum, raSpectrumFilt,
                                 raPhase, raAmp : TRealArray);
var
  pcaFilt2, pcaFilt1, praMask, pcaOut : PRealArray;
  rR : TReal;
  iMaxX, iMaxY, iCurX, iCurY, iX, iY : Integer;
begin
  // выделяем память
  GetMem(pcaOut, iW * iH * 2 * SizeOf(TReal));
  GetMem(praMask, iW * iH * SizeOf(TReal));
  GetMem(pcaFilt1, iW * iH * 2 * SizeOf(TReal));
  GetMem(pcaFilt2, iW * iH * 2 * SizeOf(TReal));
  // БПФ
  Forward2dFFTReal(iW, iH, raInt1, pcaOut^);
  // На выход
  Complex2RealArray(iW, iH, pcaOut^, raSpectrum, 4, True);
  // Зануляем массивы с фильтрованными спектрами
  FillRealArrayNum(2 * iW, iH, pcaFilt1^, 0.0);
  // Фильтруем
  CAFilterMoveSector(iW, iH, pcaOut^, pcaFilt1^, True, praMask^);
  // Умножаем для сдвига
  CAMulCNum(iW, iH, pcaFilt1^, pcaFilt1^, Cos(rShift), Sin(rShift));
  // Фильтруем
//  CAFilterMoveSector(iW, iH, pcaOut^, pcaFilt2^, False, praMask^);
  // Умножаем для сдвига
//  CAMulCNum(iW, iH, pcaFilt2^, pcaFilt2^, -Cos(rShift), -Sin(rShift));
//  CAAdd(iW, iH, pcaFilt1^, pcaFilt2^, pcaFilt1^);

  // Ищем локальный максимум - первый порядок
  FindLocalMaxRealArray(iW, iH, raSpectrum, 10, 10000, iMaxX, iMaxY);
  rR := Sqrt(Sqr(iMaxX) + Sqr(iMaxY));
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      // Текущие координаты относительно центра экрана
      iCurX := iX - (iW div 2);
      iCurY := (iH div 2) - iY;
      if (Sqrt(Sqr(iCurX) + Sqr(iCurY)) < 0.4 * rR) then begin
        pcaFilt1^[(iY * iW + iX) * 2] := pcaOut^[(iY * iW + iX) * 2];
        pcaFilt1^[(iY * iW + iX) * 2 + 1] := pcaOut^[(iY * iW + iX) * 2 + 1];
      end;
    end;

  // Обратное БПФ
  Backward2dFFT(iW, iH, pcaFilt1^, pcaOut^);
  // Получаем по нему фазу и амплитуду
  Complex2RealArray(iW, iH, pcaOut^, raPhase, 8, True);
  Complex2RealArray(iW, iH, pcaOut^, raAmp, 4, True);
  // освобождаем память
  FreeMem(pcaFilt1, iW * iH * 2 * SizeOf(TReal));
  FreeMem(pcaFilt2, iW * iH * 2 * SizeOf(TReal));
  FreeMem(pcaOut, iW * iH * 2 * SizeOf(TReal));
  FreeMem(praMask, iW * iH * SizeOf(TReal));
end;}

procedure PhaseByFFTSub1View(iW, iH : Integer;
                             var raGrayObject, raInt1,
                             raSpectrum, raSpectrumSub, raSpectrumFilt,
                             caOut : TRealArray);
var
  praInt, praObject, pcaTemp4, pcaFilt1 : PRealArray;
begin
  // выделяем память
  GetMem(pcaTemp4, iW * iH * 2 * SizeOf(TReal));
//  GetMem(pcaFilt1, iW * iH * 2 * SizeOf(TReal));
//  GetMem(praInt, iW * iH * SizeOf(TReal));
//  GetMem(praObject, iW * iH * SizeOf(TReal));
  // Нормировка Энергетическая
//  MakeEnergyNorm(iW, iH, raInt1, praInt^);
//  MakeEnergyNorm(iW, iH, raGrayObject, praObject^);
  // БПФ
//  Forward2dFFTReal(iW, iH, praInt^, caOut);
//  Forward2dFFTReal(iW, iH, praObject^, pcaTemp4^);
  Forward2dFFTReal(iW, iH, raInt1, caOut);
  Forward2dFFTReal(iW, iH, raGrayObject, pcaTemp4^);

//  Complex2RealArray(iW, iH, pcaTemp4^, raSpectrumSub, 4, True);

  // На выход
  Complex2RealArray(iW, iH, caOut, raSpectrum, 4, True);
  Complex2RealArray(iW, iH, pcaTemp4^, raSpectrumSub, 4, True);
  // вычитаем в спектре

  CASub(iW, iH, caOut, pcaTemp4^, caOut);

  // Зануляем массивы с фильтрованными спектрами
  FillRealArrayNum(2 * iW, iH, pcaTemp4^, 0.0);
  // Фильтруем
  //if bMoveMax then
  CAFilterSector(iW, iH, caOut, pcaTemp4^);

//  bChangeMax := not(bChangeMax);
//  CAMulCNum(iW, iH, pcaFilt1^, pcaFilt1^, Cos(Pi / 4), Sin(Pi / 4));

//  CAFilterSector(iW, iH, caOut, pcaTemp4^, raMask);
//  bChangeMax := not(bChangeMax);
//  CAMulCNum(iW, iH, pcaTemp4^, pcaTemp4^, Cos(- Pi / 4), Sin(- Pi / 4));
//  CAAdd(iW, iH, pcaTemp4^, pcaFilt1^, pcaFilt1^);

//  else CAFilterMoveSector(iW, iH, caOut, pcaFilt1^, bSpectrumMax, raMask);
  // На выход

//  CAFillZeroMaxProcentRA(iW, iH, pcaFilt1^, 80, bSpectrumMax);
  Complex2RealArray(iW, iH, pcaTemp4^, raSpectrumFilt, 4, True);

  // Обратное БПФ
  Backward2dFFT(iW, iH, pcaTemp4^, caOut);

  // Попробуем вычитание амплитуды
//  Complex2RealArray(iW, iH, caOut, raGrayObject, 4, True);
//  Forward2dFFTReal(iW, iH, raInt1, caOut);
//  Forward2dFFTReal(iW, iH, raGrayObject, pcaTemp4^);
//  CASub(iW, iH, caOut, pcaTemp4^, caOut);
//  Complex2RealArray(iW, iH, pcaTemp4^, raSpectrumSub, 4, True);
//  FillRealArrayNum(2 * iW, iH, pcaFilt1^, 0.0);
//  CAFilterSector(iW, iH, caOut, pcaFilt1^, raMask);
//  Complex2RealArray(iW, iH, pcaFilt1^, raSpectrumFilt, 4, True);
//  Backward2dFFT(iW, iH, pcaFilt1^, caOut);



  // освобождаем память
  FreeMem(pcaTemp4, iW * iH * 2 * SizeOf(TReal));
//  FreeMem(pcaFilt1, iW * iH * 2 * SizeOf(TReal));
//  FreeMem(praInt, iW * iH * SizeOf(TReal));
//  FreeMem(praObject, iW * iH * SizeOf(TReal));
end;

{procedure PhaseByFFTBaseSub1View(iW, iH : Integer;
                                 var raGrayObject, raInt1,
                                 raGrayBase, raBase1,
                                 raSpectrum, raSpectrumSub, raSpectrumFilt,
                                 caOut, raMask : TRealArray);
var
  pcaInt, pcaBase : PRealArray;
begin
  // выделяем память
  GetMem(pcaInt, iW * iH * 2 * SizeOf(TReal));
  GetMem(pcaBase, iW * iH * 2 * SizeOf(TReal));
  // Восстанавливаем
  PhaseByFFTSub1View(iW, iH, raGrayBase, raBase1, raSpectrum, raSpectrumSub,
                     raSpectrumFilt, pcaBase^, raMask);
  PhaseByFFTSub1View(iW, iH, raGrayObject, raInt1, raSpectrum, raSpectrumSub,
                     raSpectrumFilt, pcaInt^, raMask, True);
  // Умножаем инт на комплексно сопряженное от базы
  CAMulAdjoint(iW, iH, pcaInt^, pcaBase^, caOut);
  // освобождаем память
  FreeMem(pcaInt, iW * iH * 2 * SizeOf(TReal));
  FreeMem(pcaBase, iW * iH * 2 * SizeOf(TReal));
end;}

{procedure PhaseByFFTBaseSub1ViewRA(iW, iH : Integer;
                                   var raGrayObject, raInt1,
                                   raGrayBase, raBase1,
                                   raSpectrum, raSpectrumSub, raSpectrumFilt,
                                   raPhase, raAmp : TRealArray);
var
  pcaOut, praMask, pcaInt, pcaBase : PRealArray;
begin
  // выделяем память
  GetMem(pcaInt, iW * iH * 2 * SizeOf(TReal));
  GetMem(pcaBase, iW * iH * 2 * SizeOf(TReal));
  GetMem(pcaOut, iW * iH * 2 * SizeOf(TReal));
  GetMem(praMask, iW * iH * SizeOf(TReal));
  // Восстанавливаем
  PhaseByFFTSub1View(iW, iH, raGrayBase, raBase1, raSpectrum, raSpectrumSub,
                     raSpectrumFilt, pcaBase^, praMask^, True);
  PhaseByFFTSub1View(iW, iH, raGrayObject, raInt1, raSpectrum, raSpectrumSub,
                     raSpectrumFilt, pcaInt^, praMask^, True);
  // Умножаем инт на комплексно сопряженное от базы
  CAMulAdjoint(iW, iH, pcaInt^, pcaBase^, pcaOut^);
  // Получаем по нему фазу и амплитуду
  Complex2RealArray(iW, iH, pcaOut^, raPhase, 8, True);
  Complex2RealArray(iW, iH, pcaOut^, raAmp, 4, True);
  // освобождаем память
  FreeMem(pcaInt, iW * iH * 2 * SizeOf(TReal));
  FreeMem(pcaBase, iW * iH * 2 * SizeOf(TReal));
  FreeMem(pcaOut, iW * iH * 2 * SizeOf(TReal));
  FreeMem(praMask, iW * iH * SizeOf(TReal));
end; }

{procedure PhaseByFFTBase1ViewRA(iW, iH : Integer;
                                var raInt1, raBase1,
                                raSpectrum, raSpectrumFilt,
                                raPhase, raAmp : TRealArray);
var
  pcaOut, praMask, pcaInt, pcaBase : PRealArray;
begin
  // выделяем память
  GetMem(pcaInt, iW * iH * 2 * SizeOf(TReal));
  GetMem(pcaBase, iW * iH * 2 * SizeOf(TReal));
  GetMem(pcaOut, iW * iH * 2 * SizeOf(TReal));
  GetMem(praMask, iW * iH * SizeOf(TReal));
  // Восстанавливаем
  PhaseByFFT1View(iW, iH, raBase1, raSpectrum, raSpectrumFilt, pcaBase^, praMask^, True);
  PhaseByFFT1View(iW, iH, raInt1, raSpectrum, raSpectrumFilt, pcaInt^, praMask^, True);
  // Умножаем инт на комплексно сопряженное от базы
  CAMulAdjoint(iW, iH, pcaInt^, pcaBase^, pcaOut^);
  // Получаем по нему фазу и амплитуду
  Complex2RealArray(iW, iH, pcaOut^, raPhase, 8, True);
  Complex2RealArray(iW, iH, pcaOut^, raAmp, 4, True);
  // освобождаем память
  FreeMem(pcaInt, iW * iH * 2 * SizeOf(TReal));
  FreeMem(pcaBase, iW * iH * 2 * SizeOf(TReal));
  FreeMem(pcaOut, iW * iH * 2 * SizeOf(TReal));
  FreeMem(praMask, iW * iH * SizeOf(TReal));
end;}

{procedure PhaseByFFTBaseSub1ViewShift(iW, iH : Integer;
                                      N : TReal;
                                      var raGrayObject, raInt1,
                                      raGrayBase, raBase1,
                                      raSpectrum, raSpectrumSub, raSpectrumFilt,
                                      caOut, raMask : TRealArray);
var
  pcaInt, pcaBase : PRealArray;
begin
  // выделяем память
  GetMem(pcaInt, iW * iH * 2 * SizeOf(TReal));
  GetMem(pcaBase, iW * iH * 2 * SizeOf(TReal));
  // Восстанавливаем
  PhaseByFFTSub1View(iW, iH, raGrayBase, raBase1, raSpectrum, raSpectrumSub,
                     raSpectrumFilt, pcaBase^, raMask, True);
  PhaseByFFTSub1View(iW, iH, raGrayObject, raInt1, raSpectrum, raSpectrumSub,
                     raSpectrumFilt, pcaInt^, raMask, True);
  // Сдвигаем путем умножения на число
  CAMulCNum(iW, iH, pcaInt^, pcaInt^, Cos(N), Sin(N));
  // Умножаем инт на комплексно сопряженное от базы
  CAMulAdjoint(iW, iH, pcaInt^, pcaBase^, caOut);
  // освобождаем память
  FreeMem(pcaInt, iW * iH * 2 * SizeOf(TReal));
  FreeMem(pcaBase, iW * iH * 2 * SizeOf(TReal));
end;}

{procedure FFTSynthesis2View(iW, iH : Integer;
                            var caIn1, caIn2, raMask, caOut : TRealArray);
var
  pcaFilt1, pcaFilt2 : PRealArray;
begin
  // выделяем память
  GetMem(pcaFilt1, iW * iH * 2 * SizeOf(TReal));
  GetMem(pcaFilt2, iW * iH * 2 * SizeOf(TReal));
  // Прямое Фурье
  Forward2dFFTComplex(iW, iH, caIn2, pcaFilt2^);
  Forward2dFFTComplex(iW, iH, caIn1, pcaFilt1^);
  // Складываем спектры
  CAMiddle(iW, iH, pcaFilt1^, pcaFilt2^, pcaFilt1^);
  // Делим на маску весовых коэффициентов
//  CADivRA(iW, iH, pcaFilt1^, raMask, pcaFilt1^);
  // Обратное Фурье
  Backward2dFFT(iW, iH, pcaFilt1^, caOut);
  // освобождаем память
  FreeMem(pcaFilt1, iW * iH * 2 * SizeOf(TReal));
  FreeMem(pcaFilt2, iW * iH * 2 * SizeOf(TReal));
end;}

{procedure FFTSynthesis3View(iW, iH : Integer;
                            var caIn1, caIn2, caIn3, raMask, caOut : TRealArray);
var
  pcaFilt1, pcaFilt2, pcaFilt3 : PRealArray;
begin
  // выделяем память
  GetMem(pcaFilt1, iW * iH * 2 * SizeOf(TReal));
  GetMem(pcaFilt2, iW * iH * 2 * SizeOf(TReal));
  GetMem(pcaFilt3, iW * iH * 2 * SizeOf(TReal));
  // Прямое Фурье
  Forward2dFFTComplex(iW, iH, caIn2, pcaFilt2^);
  Forward2dFFTComplex(iW, iH, caIn1, pcaFilt1^);
  Forward2dFFTComplex(iW, iH, caIn3, pcaFilt3^);
  // Складываем спектры
  CAMiddle3(iW, iH, pcaFilt1^, pcaFilt2^, pcaFilt3^,pcaFilt1^);
  // Делим на маску весовых коэффициентов
//  CADivRA(iW, iH, pcaFilt1^, raMask, pcaFilt1^);
  // Обратное Фурье
  Backward2dFFT(iW, iH, pcaFilt1^, caOut);
  // освобождаем память
  FreeMem(pcaFilt1, iW * iH * 2 * SizeOf(TReal));
  FreeMem(pcaFilt2, iW * iH * 2 * SizeOf(TReal));
  FreeMem(pcaFilt3, iW * iH * 2 * SizeOf(TReal));
end;}

{procedure PhaseByFFTBaseSub2ViewFS(iW, iH : Integer;
                                   var raGrayObject, raInt1, raInt2,
                                   raGrayBase, raBase1, raBase2,
                                   raSpectrum, raSpectrumSub, raSpectrumFilt,
                                   caOut : TRealArray);
var
  pcaOut1, pcaOut2, praMask1, praMask2 : PRealArray;
begin
  // Выделяем память
  GetMem(pcaOut1, iW * iH * 2 * SizeOf(TReal));
  GetMem(pcaOut2, iW * iH * 2 * SizeOf(TReal));
  GetMem(praMask1, iW * iH * SizeOf(TReal));
  GetMem(praMask2, iW * iH * SizeOf(TReal));
  // для первого ракурса
  PhaseByFFTBaseSub1View(iW, iH, raGrayObject, raInt1, raGrayBase, raBase1,
                         raSpectrum, raSpectrumSub, raSpectrumFilt,
                         pcaOut1^, praMask1^);
  // То же самое для второго ракурса
  PhaseByFFTBaseSub1View(iW, iH, raGrayObject, raInt2, raGrayBase, raBase2,
                         raSpectrum, raSpectrumSub, raSpectrumFilt,
                         pcaOut2^, praMask2^);
  // Формируем маску весовых коэффициентов
  RAAdd(iW, iH, praMask1^, praMask2^, praMask1^);
  // Фурье синтез
  FFTSynthesis2View(iW, iH, pcaOut1^, pcaOut2^, praMask1^, caOut);
  // освобождаем память
  FreeMem(pcaOut1, iW * iH * 2 * SizeOf(TReal));
  FreeMem(pcaOut2, iW * iH * 2 * SizeOf(TReal));
  FreeMem(praMask1, iW * iH * SizeOf(TReal));
  FreeMem(praMask2, iW * iH * SizeOf(TReal));
end;}

{procedure PhaseByFFTBaseSub2ViewFSRA(iW, iH : Integer;
                                   var raGrayObject, raInt1, raInt2,
                                   raGrayBase, raBase1, raBase2,
                                   raSpectrum, raSpectrumSub, raSpectrumFilt,
                                   raPhase, raAmp, raPhase1, raPhase2 : TRealArray);
var
  pcaOut1, pcaOut2, praMask1, praMask2, pcaOut : PRealArray;
begin
  // Выделяем память
  GetMem(pcaOut, iW * iH * 2 * SizeOf(TReal));
  GetMem(pcaOut1, iW * iH * 2 * SizeOf(TReal));
  GetMem(pcaOut2, iW * iH * 2 * SizeOf(TReal));
  GetMem(praMask1, iW * iH * SizeOf(TReal));
  GetMem(praMask2, iW * iH * SizeOf(TReal));
  // Восстанавливаем
  // для первого ракурса
  PhaseByFFTBaseSub1View(iW, iH, raGrayObject, raInt1, raGrayBase, raBase1,
                         raSpectrum, raSpectrumSub, raSpectrumFilt,
                         pcaOut1^, praMask1^);
  // То же самое для второго ракурса
  PhaseByFFTBaseSub1View(iW, iH, raGrayObject, raInt2, raGrayBase, raBase2,
                         raSpectrum, raSpectrumSub, raSpectrumFilt,
                         pcaOut2^, praMask2^);
  // Формируем маску весовых коэффициентов
  RAAdd(iW, iH, praMask1^, praMask2^, praMask1^);
  // Фурье синтез
  FFTSynthesis2View(iW, iH, pcaOut1^, pcaOut2^, praMask1^, pcaOut^);
  // Получаем по нему фазу и амплитуду
  Complex2RealArray(iW, iH, pcaOut^, raPhase, 8, True);
  Complex2RealArray(iW, iH, pcaOut^, raAmp, 4, True);
  Complex2RealArray(iW, iH, pcaOut1^, raPhase1, 8, True);
  Complex2RealArray(iW, iH, pcaOut2^, raPhase2, 8, True);
  // освобождаем память
  FreeMem(pcaOut, iW * iH * 2 * SizeOf(TReal));
  FreeMem(pcaOut1, iW * iH * 2 * SizeOf(TReal));
  FreeMem(pcaOut2, iW * iH * 2 * SizeOf(TReal));
  FreeMem(praMask1, iW * iH * SizeOf(TReal));
  FreeMem(praMask2, iW * iH * SizeOf(TReal));
end;}

{procedure FFT2ViewFSAmpMask(iW, iH : Integer;
                            var raGrayObject, raInt1, raInt2,
                            raGrayBase, raBase1, raBase2,
                            raBadPts : TRealArray);
var
  pcaOut, praTemp : PRealArray;
begin
  // Выделяем память
  GetMem(pcaOut, iW * iH * 2 * SizeOf(TReal));
  GetMem(praTemp, iW * iH * SizeOf(TReal));
  // Восстанавливаем
  PhaseByFFTBaseSub2ViewFS(iW, iH, raGrayObject, raInt1, raInt2, raGrayBase,
                           raBase1, raBase2, praTemp^, praTemp^, praTemp^, pcaOut^);
  // Ищем маску
  MaskByAmp(iW, iH, pcaOut^, raBadPts);
  // освобождаем память
  FreeMem(pcaOut, iW * iH * 2 * SizeOf(TReal));
  FreeMem(praTemp, iW * iH * SizeOf(TReal));
end;}

{procedure FFT2ViewFSGradeMask(iW, iH : Integer;
                              var raGrayObject, raInt1, raInt2,
                              raGrayBase, raBase1, raBase2,
                              raBadPts : TRealArray);
var
  pcaOut, praTemp : PRealArray;
begin
  // Выделяем память
  GetMem(pcaOut, iW * iH * 2 * SizeOf(TReal));
  GetMem(praTemp, iW * iH * SizeOf(TReal));
  // Восстанавливаем
  PhaseByFFTBaseSub2ViewFS(iW, iH, raGrayObject, raInt1, raInt2, raGrayBase,
                           raBase1, raBase2, praTemp^, praTemp^, praTemp^, pcaOut^);
  // Ищем маску
  Complex2RealArray(iW, iH, pcaOut^, praTemp^, 4, True);
  // Фильтруем
  GaussianFiltration(iW, iH, 19, 19, praTemp^, raBadPts);
  BadPhaseGrade(iW, iH, 0.1, 5, raBadPts, raBadPts);
  // освобождаем память
  FreeMem(pcaOut, iW * iH * 2 * SizeOf(TReal));
  FreeMem(praTemp, iW * iH * SizeOf(TReal));
end;}

{procedure PhaseByFFTBaseSub(iW, iH : Integer;
                            var raGrayObject, raInt1, raInt2,
                            raGrayBase, raBase1, raBase2,
                            raSpectrum, raSpectrumSub, raSpectrumFilt,
                            raPhase, raAmplitude,
                            raBadPts, raPhaseUnwrap : TRealArray);
var
  praInt1, praInt2, praBase1, praBase2, pcaOut : PRealArray;
begin
  // Выделяем память
  GetMem(pcaOut, iW * iH * 2 * SizeOf(TReal));
  GetMem(praInt1, iW * iH * SizeOf(TReal));
  GetMem(praInt2, iW * iH * SizeOf(TReal));
  GetMem(praBase1, iW * iH * SizeOf(TReal));
  GetMem(praBase2, iW * iH * SizeOf(TReal));
  // Ищем маску
  FFT2ViewFSAmpMask(iW, iH, raGrayObject, raInt1, raInt2, raGrayBase, raBase1,
                    raBase2, raBadPts);
  // предобработка интерферрограмм
//  IntPreProcess(iW, iH, raGrayObject, raInt1, raGrayBase, raBase1, raBadPts,
//                praInt1^, praBase1^);
//  IntPreProcess(iW, iH, raGrayObject, raInt2, raGrayBase, raBase2, raBadPts,
//                praInt2^, praBase2^);
  // Восстанавливаем
//  PhaseByFFTBaseSub2ViewFS(iW, iH, raGrayObject, praInt1^, praInt2^, raGrayBase,
//                           praBase1^, praBase2^, raSpectrum, raSpectrumSub,
//                           raSpectrumFilt, pcaOut^);
  PhaseByFFTBaseSub2ViewFS(iW, iH, raGrayObject, raInt1, raInt2, raGrayBase,
                           raBase1, raBase2, raSpectrum, raSpectrumSub,
                           raSpectrumFilt, pcaOut^);
  // Переводим данные в выходной массив из комплексного
  Complex2RealArray(iW, iH, pcaOut^, raPhase, 8, False);
  Complex2RealArray(iW, iH, pcaOut^, raAmplitude, 4, True);
  NormRealArray(iW, iH, raAmplitude, 0, 255);
  // Зануляем массивы
  FillRealArrayNum(iW, iH, pcaOut^, 0.0);
  FillRealArrayNum(iW, iH, raPhaseUnwrap, 0.0);
  // Сшиваем
//  UnwrapPhaseSomeArea(iW, iH, raPhase, raBadPts, pcaOut^);
  // Фильтруем
//  GaussianFiltration(iW, iH, 19, 19, pcaOut^, raPhaseUnwrap);
  UnwrapPhaseSomeArea(iW, iH, raPhase, raBadPts, raPhaseUnwrap);
  // освобождаем память
  FreeMem(pcaOut, iW * iH * 2 * SizeOf(TReal));
  FreeMem(praInt1, iW * iH * SizeOf(TReal));
  FreeMem(praInt2, iW * iH * SizeOf(TReal));
  FreeMem(praBase1, iW * iH * SizeOf(TReal));
  FreeMem(praBase2, iW * iH * SizeOf(TReal));
end;}

{procedure PhaseByFFTBaseSub2ViewUnwrap(iW, iH, R1, R2 : Integer;
                                       var raGrayObject, raInt1, raInt2,
                                       raGrayBase, raBase1, raBase2,
                                       raSpectrum, raSpectrumSub, raSpectrumFilt,
                                       raPhase, raAmplitude,
                                       raBadPts, raPhaseUnwrap : TRealArray);
var
  praInt1, praInt2, praBase1, praBase2, pcaOut1, pcaOut2, praMask1, praMask2,
  praPhase2 : PRealArray;
begin
  // Выделяем память
  GetMem(praInt1, iW * iH * SizeOf(TReal));
  GetMem(praInt2, iW * iH * SizeOf(TReal));
  GetMem(praBase1, iW * iH * SizeOf(TReal));
  GetMem(praBase2, iW * iH * SizeOf(TReal));
  GetMem(pcaOut1, iW * iH * 2 * SizeOf(TReal));
  GetMem(pcaOut2, iW * iH * 2 * SizeOf(TReal));
  GetMem(praMask1, iW * iH * SizeOf(TReal));
  GetMem(praMask2, iW * iH * SizeOf(TReal));
  GetMem(praPhase2, iW * iH * SizeOf(TReal));
  // Ищем маску
//  FFT2ViewFSAmpMask(iW, iH, raGrayObject, raInt1, raInt2, raGrayBase, raBase1,
//                    raBase2, raBadPts);
  // предобработка интерферрограмм
//  IntPreProcess(iW, iH, raGrayObject, raInt1, raGrayBase, raBase1, raBadPts,
//                praInt1^, praBase1^);
//  IntPreProcess(iW, iH, raGrayObject, raInt2, raGrayBase, raBase2, raBadPts,
//                praInt2^, praBase2^);
  // для первого ракурса
  PhaseByFFTBaseSub1View(iW, iH, raGrayObject, raInt1, raGrayBase, raBase1,
                         raSpectrum, raSpectrumSub, raSpectrumFilt,
                         pcaOut1^, praMask1^);
  // То же самое для второго ракурса
  PhaseByFFTBaseSub1View(iW, iH, raGrayObject, raInt2, raGrayBase, raBase2,
                         raSpectrum, raSpectrumSub, raSpectrumFilt,
                         pcaOut2^, praMask2^);
  // Переводим данные в выходной массив из комплексного
  Complex2RealArray(iW, iH, pcaOut1^, raPhase, 8, False);
  Complex2RealArray(iW, iH, pcaOut2^, praPhase2^, 8, False);
  Complex2RealArray(iW, iH, pcaOut1^, raAmplitude, 4, True);
  NormRealArray(iW, iH, raAmplitude, 0, 255);
  // Восстанавливаем со сдвигом на пи
  PhaseByFFTBaseSub1ViewShift(iW, iH, Pi / R1, raGrayObject, raInt1, raGrayBase, raBase1,
                         raSpectrum, raSpectrumSub, raSpectrumFilt,
                         pcaOut1^, praMask1^);
  PhaseByFFTBaseSub1ViewShift(iW, iH, Pi / R2, raGrayObject, raInt2, raGrayBase, raBase2,
                         raSpectrum, raSpectrumSub, raSpectrumFilt,
                         pcaOut2^, praMask2^);
  // Переводим данные в выходной массив из комплексного
  Complex2RealArray(iW, iH, pcaOut1^, praMask1^, 8, False);
  Complex2RealArray(iW, iH, pcaOut2^, praMask2^, 8, False);
  // Сшиваем
//  UnWrapPhaseBy2ViewGarner(iW, iH, R1, R2, raPhase, praMask1^, praPhase2^,
//                           praMask2^, praInt1^, raBadPts);
  UnWrapPhaseBy2ViewGarner(iW, iH, R1, R2, raPhase, praMask1^, praPhase2^,
                           praMask2^, raPhaseUnwrap, raBadPts);
  // Фильтруем
//  GaussianFiltration(iW, iH, 19, 19, praInt1^, raPhaseUnwrap);
  // освобождаем память
  FreeMem(pcaOut1, iW * iH * 2 * SizeOf(TReal));
  FreeMem(pcaOut2, iW * iH * 2 * SizeOf(TReal));
  FreeMem(praMask1, iW * iH * SizeOf(TReal));
  FreeMem(praMask2, iW * iH * SizeOf(TReal));
  FreeMem(praInt1, iW * iH * SizeOf(TReal));
  FreeMem(praInt2, iW * iH * SizeOf(TReal));
  FreeMem(praBase1, iW * iH * SizeOf(TReal));
  FreeMem(praBase2, iW * iH * SizeOf(TReal));
  FreeMem(praPhase2, iW * iH * SizeOf(TReal));
end;}

end.
