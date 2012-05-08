unit UIntRecn;

interface

uses Math, UType, UPhsRecn, ULinAlg, UBadPts, UFill, UUnwrap, URATool;

procedure FindAbsoletePhase(W, H, R1, R2, Teta : Integer;
                            var Int1, Base1, Int2, Base2, PhaseOut, Mask : TRealArray);

procedure PhaseAbsByLessSense(iW, iH : Integer;
                              var raInt1, raBase1, raInt2, raBase2,
                              raPhase1, raPhase2, raBadPts1, raBadPts2,
                              raPhaseAbs : TRealArray);

implementation

procedure FindAbsoletePhase(W, H, R1, R2, Teta : Integer;
                            var Int1, Base1, Int2, Base2, PhaseOut, Mask : TRealArray);
var
  Alfa, LastX, X, D1, D2, H1, H2 : TReal;
  M, R : PIntegerArray1;
  FX1, FX2, I, J : Integer;
  Amp1, Amp2, Mask1, Mask2, Phase1, Phase2, P1, P2 : PRealArray;
  PointsToShift : PByteArray;
begin
  GetMem(P1, W*H*2*SizeOf(TReal));
  GetMem(P2, W*H*2*SizeOf(TReal));
  GetMem(Phase1, W*H*SizeOf(TReal));
  GetMem(Phase2, W*H*SizeOf(TReal));
  GetMem(Mask1, W*H*SizeOf(TReal));
  GetMem(Mask2, W*H*SizeOf(TReal));
  GetMem(Amp1, W*H*SizeOf(TReal));
  GetMem(Amp2, W*H*SizeOf(TReal));
  GetMem(PointsToShift, W*H);
  GetMem(M, 2 * SizeOf(Integer));
  GetMem(R, 2 * SizeOf(Integer));
  M^[1] := R1;
  M^[2] := R2;
  Alfa := 1 / R1 / FX1 / Tan(Pi * Teta / 180);
  // Восстанавливаем по базе и интерферрограмме 2 ракурса
  PhaseByFFT_BaseAuto_ShiftMax(W, H, 0, FX1, Int1, Base1, Phase1^, Amp1^);
  PhaseByFFT_BaseAuto_ShiftMax(W, H, 0, FX2, Int2, Base2, Phase2^, Amp2^);
  // Первый проход сшивки
  for I := 0 to H - 1 do
    for J := 0 to W - 1 do begin
      H1 := (Phase1[I * W + J] + 0) / (2 * Pi) * R1;
      H2 := (Phase2[I * W + J] + 0) / (2 * Pi) * R2;
      D1 := Frac(H1);
      D2 := Frac(H2);
      R^[1] := Trunc(H1);
      R^[2] := Trunc(H2);
      X := FindByRemaindersGarner(2, R^, M^);
      PhaseOut[I * W + J] := (X + D1);
      PointsToShift^[I * W + J] := 0;
      if (Abs(D1 - 0.5) > 0.35) then PointsToShift^[I * W + J] := PointsToShift^[I * W + J]  + 1;
      if (Abs(D2 - 0.5) > 0.35) then PointsToShift^[I * W + J] := PointsToShift^[I * W + J]  + 2;
    end;
  BadPhaseGrade(W, H, 0.1, 5, Amp1^, Mask1^);
{  MaskGoodPhase(W, H, Amp2^, Mask2^);
  for I := 0 to H - 1 do
    for J := 0 to W - 1 do
      if (Mask1^[I * W + J] = 0) and (Mask2^[I * W + J] = 0) then Mask2^[I * W + J] := 0
      else Mask2^[I * W + J] := 1;}
  DestroyHoles(W, H, 3000, Mask1^, Mask);
  // Сдвигаем плохие точки
  PhaseByFFT_BaseAuto_ShiftMax(W, H, Pi / R1, FX1, Int1, Base1, Phase1^, Amp1^);
  PhaseByFFT_BaseAuto_ShiftMax(W, H, Pi / R2, FX2, Int2, Base2, Phase2^, Amp2^);
  // Второй проход сшивки и вычитаем сдвиг в плохих точках
  for I := 0 to H - 1 do
    for J := 0 to W - 1 do begin
      H1 := (Phase1[I * W + J] + 0) / (2 * Pi) * R1;
      H2 := (Phase2[I * W + J] + 0) / (2 * Pi) * R2;
      D1 := Frac(H1);
      D2 := Frac(H2);
      R^[1] := Trunc(H1);
      R^[2] := Trunc(H2);
      X := FindByRemaindersGarner(2, R^, M^);
      if Mask[I * W + J] <> 0 then begin
        if (PointsToShift^[I * W + J] > 0) then PhaseOut[I * W + J] := X + D1 - 0.5
      end else PhaseOut[I * W + J] := 0;
    end;
  // Ищем ошибочные скачки
{  for I := 0 to H - 1 do
    for J := 0 to W - 1 do begin
      if J > 0 then begin
        if Mask[I * W + J - 1] <> 0 then LastX := PhaseOut[I * W + J - 1]
        else LastX := -10000;
      end
      else if I > 0 then begin
         if Mask[(I - 1) * W + J] <> 0 then LastX := PhaseOut[(I - 1) * W + J]
         else LastX := -10000;
        end
        else LastX := - 10000;
      case Abs(Trunc(PhaseOut[I * W + J]) - Trunc(LastX)) of
        0,1,4,5,6,9,10 : Mask[I * W + J] := 25;
      end;
    end;}
  FreeMem(P1, W*H*2*SizeOf(TReal));
  FreeMem(P2, W*H*2*SizeOf(TReal));
  FreeMem(Phase1, W*H*SizeOf(TReal));
  FreeMem(Phase2, W*H*SizeOf(TReal));
  FreeMem(PointsToShift, W*H);
  FreeMem(Mask1, W*H*SizeOf(TReal));
  FreeMem(Mask2, W*H*SizeOf(TReal));
  FreeMem(M, 2 * SizeOf(Integer));
  FreeMem(R, 2 * SizeOf(Integer));
  FreeMem(Amp1, W*H*SizeOf(TReal));
  FreeMem(Amp2, W*H*SizeOf(TReal));
end;

procedure CalcAbsHeight(iW, iH : Integer;
                        var raPhase1, raPhase2 : TRealArray;
                        iX1, iY1, iX2, iY2, iX3, iY3, iX0, iY0 : Integer;
                        var rZ : TReal;
                        var iNPi : Integer);
var
  rX1, rX2, rY1, rY2, rK, rB : TReal;
begin
  // Рассчитываем коэффициенты перевода фазы
  rX1 := raPhase2[iY1 * iW + iX1];
  rX2 := raPhase2[iY2 * iW + iX2];
  rY1 := raPhase1[iY1 * iW + iX1];
  rY2 := raPhase1[iY2 * iW + iX2];
  rK := (rY2 - rY1) / (rX2 - rX1);
  rB := rY1 - rK * rX1;
  // Рассчитываем фазу
  rZ := raPhase2[iY0 * iW + iX0] * rK + rB;
  // Рассчитываем количество Пи
  iNPi := Round(rZ - (raPhase1[iY0 * iW + iX0]) / Pi);
end;

procedure CalcAbsHeight3(iW, iH : Integer;
                         var raPhase1, raPhase2 : TRealArray;
                         iX1, iY1, iX2, iY2 : Integer;
                         var rZ : TReal;
                         var iNPi : Integer);
var
  rX1, rX2, rX3, rY1, rY2, rY3, rA, rB, rC : TReal;
begin
  // Рассчитываем коэффициенты перевода фазы
  rX1 := raPhase2[iY2 * iW + iX2];
  rX2 := raPhase2[iY2 * iW + iX2 + 1];
  rX3 := raPhase2[iY2 * iW + iX2 + 2];
  rY1 := raPhase1[iY2 * iW + iX2];
  rY2 := raPhase1[iY2 * iW + iX2 + 1];
  rY3 := raPhase1[iY2 * iW + iX2 + 2];
  rA := ((rX2 - rX1) * (rY3 - rY1) - (rX3 - rX1) * (rY2 - rY1)) /
        ((rX2 - rX1) * (Sqr(rX3) - Sqr(rX1)) - (rX3 - rX1) * (Sqr(rX2) - Sqr(rX1)));
  rB :=  (rY2 - rY1 - rA * (Sqr(rX2) - Sqr(rX1))) / (rX2 - rX1);
  rC := rY1 - rA * Sqr(rX1) - rB * rX1;
  // Рассчитываем фазу
  rZ := Sqr(raPhase2[iY1 * iW + iX1]) * rA + rB * raPhase2[iY1 * iW + iX1] + rC;
  // Рассчитываем количество Пи
  iNPi := Round((raPhase1[iY1 * iW + iX1] - rZ) / Pi);
end;

procedure CalcAbsHeight1(iW, iH : Integer;
                         var raPhase1, raPhase2 : TRealArray;
                         iX1, iY1, iX2, iY2 : Integer;
                         var rZ : TReal;
                         var iNPi : Integer);
var
  rX1, rY1, rB : TReal;
begin
  // Рассчитываем коэффициенты перевода фазы
  rX1 := raPhase2[iY2 * iW + iX2];
  rY1 := raPhase1[iY2 * iW + iX2];
  rB :=  rY1 - rX1;
  // Рассчитываем фазу
  rZ := raPhase2[iY1 * iW + iX1] + rB;
  // Рассчитываем количество Пи
  iNPi := Round((raPhase1[iY1 * iW + iX1] - rZ) / Pi);
end;

procedure PhaseAbsByLessSense(iW, iH : Integer;
                              var raInt1, raBase1, raInt2, raBase2,
                              raPhase1, raPhase2, raBadPts1, raBadPts2,
                              raPhaseAbs : TRealArray);
var
  praAmp, praTemp : PRealArray;
  iNewPi, iX, iY : Integer;
  rNewZ : TReal;
begin
  // выделяем память
  GetMem(praAmp, iW * iH * SizeOf(TReal));
  GetMem(praTemp, iW * iH * SizeOf(TReal));
  // Фурье восстановление
  PhaseByFFT_BaseAuto(iW, iH, raBase1, raInt1, raPhase1,
                      raBadPts1, praTemp^, praTemp^);
  PhaseByFFT_BaseAuto(iW, iH, raInt2, raBase2, raPhase2,
                      raBadPts2, praTemp^, praTemp^);
  // Маска плохой фазы и Убираем дыры в маске
  BadPhaseGrade(iW, iH, 0.1, 5, raBadPts1, raPhaseAbs);
  DestroyHoles(iW, iH, 3000, raPhaseAbs, raBadPts1);
  BadPhaseGrade(iW, iH, 0.1, 5, raBadPts2, raPhaseAbs);
  DestroyHoles(iW, iH, 3000, raPhaseAbs, raBadPts2);
  // Зануляем
  FillRealArrayNum(iW, iH, raBase1, 0.0);
  FillRealArrayNum(iW, iH, raBase2, 0.0);
  // Сшиваем первую и вторую фазу
  UnwrapPhaseSomeArea(iW, iH, raPhase1, raBadPts1, raBase1);
  UnwrapPhaseSomeArea(iW, iH, raPhase2, raBadPts2, raBase2);
  // Ищем предположительную высоту
  CalcAbsHeight(iW, iH, raBase1, raBase2,
                340, 340, 440, 110, 490, 380, 450, 240, rNewZ, iNewPi);
  // Поднимаем область              
  AreaIncNum(iW, iH, 450, 240, raBase1, raBadPts1, raBase1, iNewPi * Pi);
  // Освобождаем память
  FreeMem(praAmp, iW * iH * SizeOf(TReal));
  FreeMem(praTemp, iW * iH * SizeOf(TReal));
end;

end.
