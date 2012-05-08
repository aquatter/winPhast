unit UBadPts;

interface

uses Windows, UType, UFiltr, URATool, UUnwrap, UFill, UFFT, UMask;

function FindBadPoints3(var Int1, Int2, Int3, BadPoints : TRealArray;
                        Porog  : TReal;
                        SizeX, SizeY : Integer) : Integer; cdecl;

function FindBadPoints2(var Int1, Int2, BadPoints : TRealArray;
                        Porog  : TReal;
                        SizeX, SizeY : Integer) : Integer; cdecl;

function FindBadPoints5Unwrap(var Int1, Int2, Int3, Int4, Int5, BadPoints : TRealArray;
                              Porog, Porog2 : TReal;
                              SizeX, SizeY : Integer) : Integer; cdecl;

{
  Описание : находит плохие точки на интерферрограмме считая сумму квадратов
             разностей между соседними интерферрограммами, то есть
             (1-2)^2 + (2-3)^2 + (3-4)^2,
             если енто число меньше порога - то точка плохая, средний порог - 240
  Вход     : Int1, Int2, Int3, Int4 - массивы с интерферрограммами
             SizeX, SizeY - размер всех массивов
             Porog - порог для нахождения плохих точек
  Выход    : BadPoints - плохие точки (точки в которых расчет невозможен)
             !!! выходные массивы создаются вызывающей функцией !!!
  Источник : Выкладки мои
}
procedure FindBadPoints4(var Int1, Int2, Int3, Int4,
                        BadPoints : TRealArray;
                        Porog : TReal;
                        SizeX, SizeY : Integer);

{
  Описание : находит плохие точки на интерферрограмме считая сумму квадратов
             разностей между соседними интерферрограммами, то есть
             (1-2)^2 + (2-3)^2 + (3-4)^2 + (4-5)^2,
             если енто число меньше порога - то точка плохая, средний порог - 240
  Вход     : Int1, Int2, Int3, Int4, Int5 - массивы с интерферрограммами
             SizeX, SizeY - размер всех массивов
             Porog - порог для нахождения плохих точек
  Выход    : BadPoints - плохие точки (точки в которых расчет невозможен)
             !!! выходные массивы создаются вызывающей функцией !!!
  Источник : Выкладки мои
}
procedure FindBadPoints5(var Int1, Int2, Int3, Int4, Int5,
                        BadPoints : TRealArray;
                        Porog : TReal;
                        SizeX, SizeY : Integer);
{
  Описание : находит плохие точки на интерферрограмме считая сумму квадратов
             разностей между соседними интерферрограммами, то есть
             (1-2)^2 + (2-3)^2 + (3-4)^2 + (4-5)^2 + (5-6)^2,
             если енто число меньше порога - то точка плохая, средний порог - 240
  Вход     : Int1, Int2, Int3, Int4, Int5, Int6 - массивы с интерферрограммами
             SizeX, SizeY - размер всех массивов
             Porog - порог для нахождения плохих точек
  Выход    : BadPoints - плохие точки (точки в которых расчет невозможен)
             !!! выходные массивы создаются вызывающей функцией !!!
  Источник : Выкладки мои
}
procedure FindBadPoints6(var Int1, Int2, Int3, Int4, Int5, Int6,
                         BadPoints : TRealArray;
                         Porog : TReal;
                         SizeX, SizeY : Integer);

{
  Описание : находит плохие точки на интерферрограмме считая сумму квадратов
             разностей между соседними интерферрограммами, то есть
             (1-2)^2 + (2-3)^2 + (3-4)^2 + (4-5)^2 + (5-6)^2 + (6-7)^2,
             если енто число меньше порога - то точка плохая, средний порог - 240
  Вход     : Int1, Int2, Int3, Int4, Int5, Int6 - массивы с интерферрограммами
             SizeX, SizeY - размер всех массивов
             Porog - порог для нахождения плохих точек
  Выход    : BadPoints - плохие точки (точки в которых расчет невозможен)
             !!! выходные массивы создаются вызывающей функцией !!!
  Источник : Выкладки мои
}
procedure FindBadPoints7(var Int1, Int2, Int3, Int4, Int5, Int6, Int7,
                         BadPoints : TRealArray;
                         Porog : TReal;
                         SizeX, SizeY : Integer);


procedure MaskByAmpR(iW, iH : Integer; var  raIn, raFF, raMaskHoles, raViewMask : TRealArray);

// ОПРЕДЕЛЕНИЕ МАСКИ С ВЫСОКИМИ ГРАДИЕНТАМИ
// Вход - амплитуда   0.1 5
procedure BadPhaseGrade(W, H : Integer;
                        rThreshOld1, rThreshold2 : TReal;
                        var Amp, Mask : TRealArray);

procedure BadPhaseWindow(iW, iH, iWX, iWY, iWXInc, iWYInc : Integer;
                         rThreshold : TReal;
                         var raInt, raPhase0, raPhase1, raPhase2,
                         raPhase3, raPhase4, raBadPoints : TRealArray);

procedure MaskByAmp(iW, iH : Integer; var  caIn, raViewMask : TRealArray);

procedure MaskByThrGrFF(iW, iH : Integer;
                        var raIn,
                        raFF, raMaskHoles, raMaskShadow : TRealArray);

procedure MaskByThrGrFF3(iW, iH : Integer;
                         var raIn1, raIn2, raIn3,
                         raMask1, raMask2, raMask3, raMaskAllShadow : TRealArray);

procedure MaskForBestEdge(iW, iH : Integer;
                          var raIn,
                          raMask : TRealArray);

implementation

uses UPhsRecn;

procedure MaskForBestEdge(iW, iH : Integer;
                          var raIn,
                          raMask : TRealArray);
var
  iTemp, iX, iY, iX2, iY2, iSum : Integer;
begin
  iTemp := 5;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do raMask[iY * iW + iX] := 0;
  for iY := 1 to iH - 2 do
    for iX := 1 to iW - 2 do begin
      iSum := Round(raIn[(iY - 1) * iW + iX - 1] + raIn[(iY - 1) * iW + iX] +
              raIn[(iY - 1) * iW + iX + 1] + raIn[iY * iW + iX - 1] +
              raIn[iY * iW + iX] + raIn[iY * iW + iX + 1] +
              raIn[(iY + 1) * iW + iX - 1] + raIn[(iY + 1) * iW + iX] +
              raIn[(iY + 1) * iW + iX + 1]);
      if (iSum > 0) and (iSum < 9) then
        for iY2 := -iTemp to iTemp do
          for iX2 := -iTemp to iTemp do begin
            iSum := (iY + iY2) * iW + iX + iX2;
            if (iSum > 0) and (iSum < iW * iH - 1) then raMask[iSum] := 1;
          end; 
    end;
end;

procedure MaskByThrGrFF3(iW, iH : Integer;
                         var raIn1, raIn2, raIn3,
                         raMask1, raMask2, raMask3, raMaskAllShadow : TRealArray);
var
  praTemp : PRealArray;
begin
  // выделяем память
  GetMem(praTemp, iW * iH * SizeOf(TReal));
  // находим маски для изображений
  MaskByThrGrFF(iW, iH, raIn1, praTemp^, praTemp^, raMask1);
  MaskByThrGrFF(iW, iH, raIn2, praTemp^, praTemp^, raMask2);
  MaskByThrGrFF(iW, iH, raIn3, praTemp^, praTemp^, raMask3);
  // складываем маски
  MaskAnd3(iW, iH, raMask1, raMask2, raMask3, raMaskAllShadow);
  // освобождаем память
  FreeMem(praTemp, iW * iH * SizeOf(TReal));
end;

procedure MaskByThrGrFF(iW, iH : Integer;
                        var raIn,
                        raFF, raMaskHoles, raMaskShadow : TRealArray);
begin
  // Фильтруем чтобы убрат все шумы
  FurierFiltration(iW, iH, iW div 10, raIn, raFF);
  // Ищем маску
  BadPhaseGrade(iW, iH, 0.1, 50, raFF, raMaskHoles);
  // Убираем маленькие дырки - маска с тенями
  DestroyHoles(iW, iH, 10000, raMaskHoles, raMaskShadow);
end;

procedure MaskByAmp(iW, iH : Integer; var  caIn, raViewMask : TRealArray);
var
  praTemp : PRealArray;
begin
  GetMem(praTemp, iW * iH * SizeOf(TReal));
  Complex2RealArray(iW, iH, caIn, praTemp^, 4, True);
  // Фильтруем
  GaussianFiltration(iW, iH, 19, 19, praTemp^, raViewMask);
  NormRealArray(iW, iH, raViewMask, 0, 255);
  MaskAmplFilt(iW, iH, 10, 255, raViewMask, raViewMask);
  DestroyHoles(iW, iH, 30000, raViewMask, raViewMask);
  FreeMem(praTemp, iW * iH * SizeOf(TReal));
end;

procedure MaskByAmpR(iW, iH : Integer; var  raIn, raFF, raMaskHoles, raViewMask : TRealArray);
begin
  // Фильтруем чтобы убрат все шумы
  FurierFiltration(iW, iH, iW div 10, raIn, raFF);
  NormRealArray(iW, iH, raFF, 0, 255);
  // Ищем маску
  MaskAmplFilt(iW, iH, 30, 255, raFF, raMaskHoles);
  // Убираем маленькие дырки - маска с тенями
  DestroyHoles(iW, iH, 50000, raMaskHoles, raViewMask);
end;

procedure BadPhaseWindow(iW, iH, iWX, iWY, iWXInc, iWYInc : Integer;
                         rThreshold : TReal;
                         var raInt, raPhase0, raPhase1, raPhase2,
                         raPhase3, raPhase4, raBadPoints : TRealArray);
var
  praTemp : PRealArray;
begin
  // Выделяем память
  GetMem(praTemp, iW * iH * SizeOf(TReal));
  // Фурье восстановление
  PhaseByFFT(iW, iH, iWX + iWXInc * 0, iWY + iWYInc * 0, raInt, raPhase0,
             praTemp^, praTemp^, praTemp^);
  PhaseByFFT(iW, iH, iWX + iWXInc * 1, iWY + iWYInc * 1, raInt, raPhase1,
             praTemp^, praTemp^, praTemp^);
  PhaseByFFT(iW, iH, iWX + iWXInc * 2, iWY + iWYInc * 2, raInt, raPhase2,
             praTemp^, praTemp^, praTemp^);
  PhaseByFFT(iW, iH, iWX + iWXInc * 3, iWY + iWYInc * 3, raInt, raPhase3,
             praTemp^, praTemp^, praTemp^);
  PhaseByFFT(iW, iH, iWX + iWXInc * 4, iWY + iWYInc * 4, raInt, raPhase4,
             praTemp^, praTemp^, praTemp^);
  // Рассчиьываем плохие точки
  FindBadPoints5Unwrap(raPhase0, raPhase1, raPhase2, raPhase3, raPhase4,
                       raBadPoints, rThreshold, Pi, iW, iH);
  // Освобождаем память
  FreeMem(praTemp, iW * iH * SizeOf(TReal));
end;

function FindBadPoints3(var Int1, Int2, Int3, BadPoints : TRealArray;
                        Porog  : TReal;
                        SizeX, SizeY : Integer) : Integer; cdecl;
var
  I, J : Integer;
  t : TReal;
begin
  // находим плохие точки
  for I := 0 to SizeY - 1 do
    for J := 0 to SizeX - 1 do begin
      t:= Sqrt(Sqr(Int2[I*SizeX + J] - Int1[I*SizeX + J]) +
               Sqr(Int3[I*SizeX + J] - Int2[I*SizeX + J]));
      if t < Porog then BadPoints[I*SizeX + J] := 0
      else BadPoints[I*SizeX + J] := 1;
    end;
end;

function FindBadPoints2(var Int1, Int2, BadPoints : TRealArray;
                        Porog  : TReal;
                        SizeX, SizeY : Integer) : Integer; cdecl;
var
  I, J : Integer;
  t : TReal;
begin
  // находим плохие точки
  for I := 0 to SizeY - 1 do
    for J := 0 to SizeX - 1 do begin
      t:= Sqrt(Sqr(Int2[I*SizeX + J] - Int1[I*SizeX + J]));
      if t < Porog then BadPoints[I*SizeX + J] := 0
      else BadPoints[I*SizeX + J] := 1;
    end;
end;

function FindBadPoints5Unwrap(var Int1, Int2, Int3, Int4, Int5, BadPoints : TRealArray;
                              Porog, Porog2 : TReal;
                              SizeX, SizeY : Integer) : Integer; cdecl;
var
  I, J : Integer;
  t : TReal;
begin
  // находим плохие точки
  for I := 0 to SizeY - 1 do
    for J := 0 to SizeX - 1 do begin
      t:= Sqrt(Sqr(UnwrapDelta(Int2[I*SizeX + J], Int1[I*SizeX + J], Porog2)) +
               Sqr(UnwrapDelta(Int3[I*SizeX + J], Int2[I*SizeX + J], Porog2)) +
               Sqr(UnwrapDelta(Int4[I*SizeX + J], Int3[I*SizeX + J], Porog2)) +
               Sqr(UnwrapDelta(Int5[I*SizeX + J], Int4[I*SizeX + J], Porog2))) / 4;
      if t < Porog then BadPoints[I*SizeX + J] := 0
      else BadPoints[I*SizeX + J] := 1;
    end;
end;

// ОПРЕДЕЛЕНИЕ МАСКИ С ВЫСОКИМИ ГРАДИЕНТАМИ
// Вход - амплитуда   0.1 5
procedure BadPhaseGrade(W, H : Integer;
                        rThreshOld1, rThreshold2 : TReal;
                        var Amp, Mask : TRealArray);
var
  K, L : Integer;
  P0, P1, P2, P3 : PRealArray;
begin
  // выделяем память
  GetMem(P0, W * H * SizeOf(TReal));
  GetMem(P1, W * H * SizeOf(TReal));
  GetMem(P2, W * H * SizeOf(TReal));
  GetMem(P3, W * H * SizeOf(TReal));
  // Сохраняем для себя
  CopyMemory(P0, Addr(Amp), W * H * SizeOf(TReal));
  // Нормируем
  NormRealArray(W, H, P0^, 0, 255);
  // Лапласиан от амплитуды
  DiffFiltration(W, H, 5, P0^, P1^);
  // Пороговая фильтрация производной
  MaskAmplFilt(W, H, rThreshold1, 500000000, P1^, P2^);
  // Пороговая фильтрация амплитуды
  MaskAmplFilt(W, H, rThreshold2, 5000000000, P0^, P3^);
  // Вычитаем маски
  for K := 0 to H - 1 do
    for L := 0 to W - 1 do
      if P2^[K * W + L] = 1 then Mask[K * W + L] := 0
      else Mask[K * W + L] := P3^[K * W + L];
  FreeMem(P0, W * H * SizeOf(TReal));
  FreeMem(P1, W * H * SizeOf(TReal));
  FreeMem(P2, W * H * SizeOf(TReal));
  FreeMem(P3, W * H * SizeOf(TReal));
end;

procedure FindBadPoints4(var Int1, Int2, Int3, Int4,
                        BadPoints : TRealArray;
                        Porog : TReal;
                        SizeX, SizeY : Integer);
var
  I, J : Integer;
  t : TReal;
begin
  // находим плохие точки
  for I := 0 to SizeY - 1 do
    for J := 0 to SizeX - 1 do begin
      t:= Sqrt(Sqr(Int2[I*SizeX + J] - Int1[I*SizeX + J]) +
               Sqr(Int3[I*SizeX + J] - Int2[I*SizeX + J]) +
               Sqr(Int4[I*SizeX + J] - Int3[I*SizeX + J])) / 3;
      if t < Porog then BadPoints[I*SizeX + J] := 0
      else BadPoints[I*SizeX + J] := 1;
    end;
end;

procedure FindBadPoints5(var Int1, Int2, Int3, Int4, Int5,
                        BadPoints : TRealArray;
                        Porog : TReal;
                        SizeX, SizeY : Integer);
var
  I, J : Integer;
  t : TReal;
begin
  // находим плохие точки
  for I := 0 to SizeY - 1 do
    for J := 0 to SizeX - 1 do begin
      t:= Sqrt(Sqr(Int2[I*SizeX + J] - Int1[I*SizeX + J]) +
               Sqr(Int3[I*SizeX + J] - Int2[I*SizeX + J]) +
               Sqr(Int4[I*SizeX + J] - Int3[I*SizeX + J]) +
               Sqr(Int5[I*SizeX + J] - Int4[I*SizeX + J])) / 4;
      if t < Porog then BadPoints[I*SizeX + J] := 0
      else BadPoints[I*SizeX + J] := 1;
    end;
end;

procedure FindBadPoints6(var Int1, Int2, Int3, Int4, Int5, Int6,
                         BadPoints : TRealArray;
                         Porog : TReal;
                         SizeX, SizeY : Integer);
var
  I, J : Integer;
  t : TReal;
begin
  // находим плохие точки
  for I := 0 to SizeY - 1 do
    for J := 0 to SizeX - 1 do begin
      t:= Sqrt(Sqr(Int2[I*SizeX + J] - Int1[I*SizeX + J]) +
               Sqr(Int3[I*SizeX + J] - Int2[I*SizeX + J]) +
               Sqr(Int4[I*SizeX + J] - Int3[I*SizeX + J]) +
               Sqr(Int5[I*SizeX + J] - Int4[I*SizeX + J]) +
               Sqr(Int6[I*SizeX + J] - Int5[I*SizeX + J])) / 5;
      if t < Porog then BadPoints[I*SizeX + J] := 0
      else BadPoints[I*SizeX + J] := 1;
    end;
end;

procedure FindBadPoints7(var Int1, Int2, Int3, Int4, Int5, Int6, Int7,
                         BadPoints : TRealArray;
                         Porog : TReal;
                         SizeX, SizeY : Integer);
var
  I, J : Integer;
  t : TReal;  
begin
  // находим плохие точки
  for I := 0 to SizeY - 1 do
    for J := 0 to SizeX - 1 do begin
      t:= Sqrt(Sqr(Int2[I*SizeX + J] - Int1[I*SizeX + J]) +
               Sqr(Int3[I*SizeX + J] - Int2[I*SizeX + J]) +
               Sqr(Int4[I*SizeX + J] - Int3[I*SizeX + J]) +
               Sqr(Int5[I*SizeX + J] - Int4[I*SizeX + J]) +
               Sqr(Int6[I*SizeX + J] - Int5[I*SizeX + J]) +
               Sqr(Int7[I*SizeX + J] - Int6[I*SizeX + J])) / 6;
      if t < Porog then BadPoints[I*SizeX + J] := 0
      else BadPoints[I*SizeX + J] := 1;
    end;
end;

end.
