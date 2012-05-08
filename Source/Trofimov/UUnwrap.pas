unit UUnwrap;

interface

uses Windows, UType, URATool, UFill, UMask, ULinAlg;

{
  Описание : Сшивка фазы по методу наименьших квадратов
  Вход     : up_begin, up_steps - значение начала и шаг сшивки по производной,
             x_begin, y_begin - точка начала сшивки
             Size_X, Size_Y - размер всех массивов
             Matrix_WFaza - массив с несшитой фазой обязательно в диапазоне от 0 до 2 пи
             Matrix_Videlenie - область для сшивки
  Выход    : Matrix_FinalPicture - массив с сшитой фазой
            !!! выходные массивы создаются вызывающей функцией !!!
  Источник : Исходники Сухорукова К
}
procedure UnWrapPhase(up_begin, up_steps : TReal;
                      fd, sd : boolean;
                      x_begin, y_begin,
                      size_x, size_y : Integer;
                      var Matrix_WFaza, Matrix_FinalPicture: TRealArray;
                      var Matrix_Videlenie: tbtarr {TRealArray});

procedure FindResidue(W, H : integer; Porog, Porog1 : TReal;
                     var MIn, MOut : TRealArray);

function UnWrapDelta(R1, R2, rThreshold : TReal) : TReal;

procedure UnWrapArray(var A, T : TRealArray ; N : Integer; Tr : TReal);

procedure UnWrapPhaseSt(x_begin, y_begin,
                        size_x, size_y : Integer;
                        var Matrix_WFaza, Matrix_FinalPicture: TRealArray;
                        var Matrix_Videlenie  : TBtArr);

procedure UnwrapPhaseSomeArea(iW, iH : Integer;
                              var raPhase, raMask, raPhaseUnwrap : TrealArray); overload;

procedure UnwrapPhaseSomeArea(iW, iH : Integer;
                              var raPhase, raPhaseUnwrap: TrealArray;
                              var raMask: TBtArr); overload;


{
Описание : Осуществляет сшивку фазы по алгоритму описанному в статье
           используется алгоритм Гарнера для восстановления целого числа по
           остаткам
Вход     : W , H  - размеры массивов по Х и по Y
           Phase1 - фаза первого ракурса в радианах
           Phase1Pi - фаза первого ракурса в радианах сдвинутая на пи
           Phase2 - фаза второго ракурса в радианах
           Phase2Pi - фаза второго ракурса в радианах сдвинутая на пи
Выход    : PhaseOut - сшитая фаза в радианах
           BadPoints - плохие точки
           !!! Выходные массивы создаются вызывающей программой
Источник : Статья такеды ;)
}
procedure UnWrapPhaseBy2ViewGarner(W, H, R1, R2 : Integer;
                                   var Phase1, Phase1Pi, Phase2, Phase2Pi,
                                   PhaseOut, BadPoints : TRealArray);

procedure UnwrapPhaseAll(iW, iH, iBX, iBY : Integer;
                         var raPhase, raPhaseUnwrap : TrealArray);
                                   
procedure UnwrapPhaseMask(iW, iH, iBX, iBY : Integer;
                          var raPhase: TrealArray;
                          var raMask: TBtArr;
                          var raPhaseUnwrap: TrealArray);

implementation

procedure UnWrapPhaseBy2ViewGarner(W, H, R1, R2 : Integer;
                                   var Phase1, Phase1Pi, Phase2, Phase2Pi,
                                   PhaseOut, BadPoints : TRealArray);
var
  X, XPi, D1, D1Pi, D2, D2Pi, H1, H1Pi, H2, H2Pi : TReal;
  M, R, RPi : PIntegerArray1;
  I, J : Integer;
  PointsToShift : PByteArray;
begin
  // Выделяем память
  GetMem(PointsToShift, W * H);
  GetMem(M, 2 * SizeOf(Integer));
  GetMem(R, 2 * SizeOf(Integer));
  GetMem(RPi, 2 * SizeOf(Integer));
  // Инициализация
  M^[1] := R1;
  M^[2] := R2;
  // сшивка
  for I := 0 to H - 1 do
    for J := 0 to W - 1 do begin
      // По обычной фазе
      H1 := (Phase1[I * W + J] + 0) / (2 * Pi) * R1;
      H2 := (Phase2[I * W + J] + 0) / (2 * Pi) * R2;
      D1 := Frac(H1);
      D2 := Frac(H2);
      R^[1] := Trunc(H1);
      R^[2] := Trunc(H2);
      X := FindByRemaindersGarner(2, R^, M^);
      // По сдвинутой на пи
      H1Pi := (Phase1Pi[I * W + J] + 0) / (2 * Pi) * R1;
      H2Pi := (Phase2Pi[I * W + J] + 0) / (2 * Pi) * R2;
      D1Pi := Frac(H1Pi);
      D2Pi := Frac(H2Pi);
      RPi^[1] := Trunc(H1Pi);
      RPi^[2] := Trunc(H2Pi);
      XPi := FindByRemaindersGarner(2, RPi^, M^);
      // Ищем неудачные точки
      PointsToShift^[I * W + J] := 0;
      if (Abs(D1 - 0.5) > 0.35) then PointsToShift^[I * W + J] := PointsToShift^[I * W + J] + 1;
      if (Abs(D2 - 0.5) > 0.35) then PointsToShift^[I * W + J] := PointsToShift^[I * W + J] + 2;
      // Взависимости от того какая точка - считаем фазу
      if (PointsToShift^[I * W + J] > 0) then
        PhaseOut[I * W + J] := XPi + D1Pi - 0.5
      else PhaseOut[I * W + J] := X + D1;
      if (Abs(D1Pi - 0.5) > 0.35) then PointsToShift^[I * W + J] := PointsToShift^[I * W + J] + 4;
      if (Abs(D2Pi - 0.5) > 0.35) then PointsToShift^[I * W + J] := PointsToShift^[I * W + J] + 8;
    end;
  // Ищем ошибочные скачки
  // освобождаем память
  FreeMem(PointsToShift, W * H);
  FreeMem(M, 2 * SizeOf(Integer));
  FreeMem(R, 2 * SizeOf(Integer));
  FreeMem(RPi, 2 * SizeOf(Integer));
end;

procedure UnwrapPhaseAll(iW, iH, iBX, iBY : Integer;
                         var raPhase, raPhaseUnwrap : TrealArray);
var
  praTempMask : PBtArr;
//  iBX, iBY,
  iX, iY : Integer;
begin
  // выделяем память
  GetMem(praTempMask, iW * iH * SizeOf(tbt));
  // Убираем края чтобы можно было сшивать по краям на 2 пиксела
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      if (iY < 1) or (iX < 1) or
         (iY > iH - 2) or (iX > iW - 2) then praTempMask^[iY * iW + iX] := 0
      else praTempMask^[iY * iW + iX] := 1;
//  FindMaskCenter(iW, iH, praTempMask^, iBX, iBY);
  UnWrapPhaseSt(iBX, iBY, iW, iH, raPhase, raPhaseUnwrap, praTempMask^);
end;

procedure UnwrapPhaseMask(iW, iH, iBX, iBY : Integer;
                          var raPhase: TRealArray;
                          var raMask: TBtArr;
                          var raPhaseUnwrap : TRealArray);
var
  iT, iX, iY : Integer;
begin
  // Убираем края чтобы можно было сшивать по краям на 2 пиксела
  iT := 5;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      if (iY < iT) or (iX < iT) or
         (iY > iH - 1 - iT) or (iX > iW - 1 - iT) then raMask[iY * iW + iX] := 0;
  UnWrapPhaseSt(iBX, iBY, iW, iH, raPhase, raPhaseUnwrap, raMask);
end;


procedure UnwrapPhaseSomeArea(iW, iH : Integer;
                              var raPhase, raPhaseUnwrap: TrealArray;
                              var raMask: TBtArr); overload;
var
  iX, iY, iBX, iBY : Integer;
  praTemp, praTempMask : PBtArr;
  praTempPhase: PRealArray;
begin
  // выделяем память
  GetMem(praTempMask, iW * iH * SizeOf(tbt));
  GetMem(praTempPhase, iW * iH * SizeOf(treal));
  GetMem(praTemp, iW * iH * SizeOf(tbt));
  // временная маска
  CopyMemory(praTempMask, Addr(raMask), iW * iH * SizeOf(tbt));
  // Убираем края чтобы можно было сшивать по краям на 2 пиксела
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      if (iY < 1) or (iX < 1) or (iY > iH - 2) or (iX > iW - 2) then begin
        praTempMask^[iY * iW + iX] := 0;
        raMask[iY * iW + iX] := 0;
      end;
      raPhaseUnwrap[iY * iW + iX] := 0;
    end;
  // Ищем и заливаем область
  while FindNextNum(iW, iH, 1, praTempMask^, iBX, iBY) do begin
    FillArea(iBX, iBY, iW, iH, True, praTempMask^, praTemp^);
    // Ищем центр области
//    FindMaskCenter(iW, iH, praTemp^, iBX, iBY);
    // Сшиваем область
    UnWrapPhaseSt(iBX, iBY, iW, iH, raPhase, praTempPhase^, praTemp^);
    // перекидываем сшитую фазу на выход и обновляем маску
    for iY := 0 to iH - 1 do
      for iX := 0 to iW - 1 do
        if praTemp^[iY * iW + iX] = 1 then begin
          raPhaseUnwrap[iY * iW + iX] := praTempPhase^[iY * iW + iX];
          praTempPhase^[iY * iW + iX] := 0;
          praTempMask^[iY * iW + iX] := 0;
          praTemp^[iY * iW + iX] := 0;
        end;
  end;
  // освобождаем память
  FreeMem(praTempMask, iW * iH * SizeOf(Tbt));
  FreeMem(praTempPhase, iW * iH * SizeOf(TReal));
  FreeMem(praTemp, iW * iH * SizeOf(Tbt));
end;


procedure UnwrapPhaseSomeArea(iW, iH : Integer;
                              var raPhase, raMask, raPhaseUnwrap : TrealArray);
var
  iX, iY, iBX, iBY : Integer;
  praTemp, praTempMask : PBtArr;
  praTempPhase: PRealArray;
begin
  // выделяем память
  GetMem(praTempMask, iW * iH * SizeOf(tbt));
  GetMem(praTempPhase, iW * iH * SizeOf(treal));
  GetMem(praTemp, iW * iH * SizeOf(tbt));
  // временная маска
  CopyMemory(praTempMask, Addr(raMask), iW * iH * SizeOf(TReal));
  // Убираем края чтобы можно было сшивать по краям на 2 пиксела
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      if (iY < 1) or (iX < 1) or (iY > iH - 2) or (iX > iW - 2) then begin
        praTempMask^[iY * iW + iX] := 0;
        raMask[iY * iW + iX] := 0;
      end;
      raPhaseUnwrap[iY * iW + iX] := 0;
    end;
  // Ищем и заливаем область
  while FindNextNum(iW, iH, 1, praTempMask^, iBX, iBY) do begin
    FillArea(iBX, iBY, iW, iH, True, praTempMask^, praTemp^);
    // Ищем центр области
//    FindMaskCenter(iW, iH, praTemp^, iBX, iBY);
    // Сшиваем область
    UnWrapPhaseSt(iBX, iBY, iW, iH, raPhase, praTempPhase^, praTemp^);
    // перекидываем сшитую фазу на выход и обновляем маску
    for iY := 0 to iH - 1 do
      for iX := 0 to iW - 1 do
        if praTemp^[iY * iW + iX] = 1 then begin
          raPhaseUnwrap[iY * iW + iX] := praTempPhase^[iY * iW + iX];
          praTempPhase^[iY * iW + iX] := 0;
          praTempMask^[iY * iW + iX] := 0;
          praTemp^[iY * iW + iX] := 0;
        end;
  end;
  // освобождаем память
  FreeMem(praTempMask, iW * iH * SizeOf(Tbt));
  FreeMem(praTempPhase, iW * iH * SizeOf(TReal));
  FreeMem(praTemp, iW * iH * SizeOf(Tbt));
end;

function Hodilnik(size_x, size_y,
                  x_vid_min, x_vid_max, y_vid_min, y_vid_max : integer;
                  kriterii : TReal;
                  kateg : integer;
                  var Matrix_Proizv, Matrix_horosh, Matrix_WFaza, Matrix_Faza,
                  Matrix_Shitosti, Matrix_BadPoints: TRealArray;
                  var Matrix_Videlenie: TBtArr;
                  var Matrix_FinalPicture : TRealArray) : integer;
var
  min_kateg : TReal;
  min_proizv, _x_, _y_, x, y, shit_points : integer;
begin
  shit_points := 0;
  for y := y_vid_min to y_vid_max do
    for x := x_vid_min to x_vid_max do begin
      if Matrix_Proizv[x*2 + y*size_x*2] > kriterii then
	Matrix_horosh[x + y*size_x] := 1 //плохая точка
      else Matrix_horosh[x + y*size_x] := 0; //хорошая точка
      if (Matrix_BadPoints[x + y*size_x] = 0) and
	 (Matrix_Videlenie[x + y*size_x] = 1) and
	 (Matrix_Shitosti[x*2 + y*size_x*2] = 0) then begin
	if Matrix_horosh[x + y*size_x] = 0 then begin
	  min_kateg := 10000;
	  min_proizv := 10000;
	  //(x)(y-1)
	  if (Matrix_Shitosti[x*2 + 1 + (y - 1)*size_x*2] > 0) and
             (min_kateg > Matrix_Shitosti[x*2 + 1 + (y - 1)*size_x*2]) then begin
            min_kateg := Matrix_Shitosti[x*2 + 1 + (y - 1)*size_x*2];
	    _x_ := x;
	    _y_ := y - 1;
          end;
	  //(x+1)y
	  if (Matrix_Shitosti[(x + 1)*2 + 1 + y*size_x*2] > 0) and
             (min_kateg > Matrix_Shitosti[(x + 1)*2 + 1 + y*size_x*2]) then begin
            min_kateg := Matrix_Shitosti[(x + 1)*2 + 1 + y*size_x*2];
	    _x_ := x + 1;
	    _y_ := y;
          end;
	  //x(y+1)
	  if (Matrix_Shitosti[x*2 + 1 + (y + 1)*size_x*2] > 0) and
             (min_kateg > Matrix_Shitosti[x*2 + 1 + (y + 1)*size_x*2]) then begin
            min_kateg := Matrix_Shitosti[x*2 + 1 + (y + 1)*size_x*2];
	    _x_ := x;
	    _y_ := y + 1;
          end;
	  //(x-1)y
	  if (Matrix_Shitosti[(x - 1)*2 + 1 + y*size_x*2] > 0) and
             (min_kateg > Matrix_Shitosti[(x - 1)*2 + 1 + y*size_x*2]) then begin
            min_kateg := Matrix_Shitosti[(x - 1)*2 + 1 + y*size_x*2];
	    _x_ := x - 1;
	    _y_ := y;
          end;
          //проверка по второй производной
	  //(x)(y-1)
	  if (Matrix_Shitosti[x*2 + 1 + (y - 1)*size_x*2] > 0) and
             (Matrix_Shitosti[x*2 + 1 + (y - 1)*size_x*2] = min_kateg) and
             (min_proizv > Matrix_Proizv[x*2 + 1 + (y - 1)*size_x*2]) then begin
            min_kateg := Matrix_Shitosti[x*2 + 1 + (y - 1)*size_x*2];
	    _x_ := x;
	    _y_ := y - 1;
          end;
	  //(x+1)y
	  if (Matrix_Shitosti[(x + 1)*2 + 1 + y*size_x*2] > 0) and
             (Matrix_Shitosti[(x + 1)*2 + 1 + y*size_x*2] = min_kateg) and
             (min_proizv > Matrix_Proizv[(x + 1)*2 + 1 + y*size_x*2]) then begin
            min_kateg := Matrix_Shitosti[(x + 1)*2 + 1 + y*size_x*2];
	    _x_ := x + 1;
	    _y_ := y;
          end;
	  //x(y+1)
	  if (Matrix_Shitosti[x*2 + 1 + (y + 1)*size_x*2] > 0) and
             (Matrix_Shitosti[x*2 + 1 + (y + 1)*size_x*2] = min_kateg) and
             (min_proizv > Matrix_Proizv[x*2 + 1 + (y + 1)*size_x*2]) then begin
            min_kateg := Matrix_Shitosti[x*2 + 1 + (y + 1)*size_x*2];
	    _x_ := x;
	    _y_ := y + 1;
          end;
	  //(x-1)y
	  if (Matrix_Shitosti[(x - 1)*2 + 1 + y*size_x*2] > 0) and
             (Matrix_Shitosti[(x - 1)*2 + 1 + y*size_x*2] = min_kateg) and
             (min_proizv > Matrix_Proizv[(x - 1)*2 + 1 + y*size_x*2]) then begin
            min_kateg := Matrix_Shitosti[(x - 1)*2 + 1 + y*size_x*2];
	    _x_ := x - 1;
	    _y_ := y;
          end;
	  if min_kateg <> 10000 then begin
            if abs(Matrix_WFaza[x + y*size_x] -
                   Matrix_WFaza[_x_ + _y_*size_x] + 2*pi) < pi - pi/20 then
	      Matrix_Faza[x + y*size_x] := Matrix_Faza[_x_ + _y_*size_x]+
                                           (Matrix_WFaza[x + y*size_x] -
                                            Matrix_WFaza[_x_ + _y_*size_x]) +
                                           2*pi
            else if abs(Matrix_WFaza[x + y*size_x] -
                        Matrix_WFaza[_x_ + _y_*size_x] - 2*pi) < pi - pi/20 then
	           Matrix_Faza[x + y*size_x] := Matrix_Faza[_x_ + _y_*size_x] +
                                                (Matrix_WFaza[x + y*size_x] -
                                                 Matrix_WFaza[_x_ + _y_*size_x]) -
                                               2*pi
		 else Matrix_Faza[x + y*size_x] := Matrix_Faza[_x_ + _y_*size_x] +
                                                   (Matrix_WFaza[x + y*size_x] -
                                                    Matrix_WFaza[_x_ + _y_*size_x]);
	    Matrix_FinalPicture[x + y*size_x] := Matrix_Faza[x + y*size_x];
	    Matrix_Shitosti[x*2 + y*size_x*2] := 1; //сшитая
	    Matrix_Shitosti[x*2 + 1 + y*size_x*2] := kateg; //категория
	    Inc(shit_points);
          end;
	end;
      end;
      //обратный ход
      if Matrix_Proizv[(size_x - x)*2 + (size_y - y)*size_x*2] > kriterii then
	Matrix_horosh[size_x - x + (size_y - y)*size_x] := 1 //плохая точка
      else Matrix_horosh[size_x - x + (size_y - y)*size_x] := 0; //хорошая точка
      if (Matrix_BadPoints[size_x - x + (size_y - y)*size_x] = 0) and
	 (Matrix_Videlenie[size_x - x + (size_y - y)*size_x] = 1) and
	 (Matrix_Shitosti[(size_x - x)*2 + (size_y - y)*size_x*2] = 0) then begin
	if Matrix_horosh[size_x - x + (size_y - y)*size_x] = 0 then begin
	  min_kateg := 10000;
	  min_proizv := 10000;
	  //(x)(y-1)
	  if (Matrix_Shitosti[(size_x - x)*2 + 1 + (size_y - y - 1)*size_x*2] > 0) and
             (min_kateg > Matrix_Shitosti[(size_x - x)*2 + 1 + (size_y - y - 1)*size_x*2]) then begin
            min_kateg := Matrix_Shitosti[(size_x - x)*2 + 1 + (size_y - y - 1)*size_x*2];
	    _x_ := size_x - x;
	    _y_ := size_y - y - 1;
          end;
	  //(x+1)y
	  if (Matrix_Shitosti[(size_x - x + 1)*2 + 1 + (size_y - y)*size_x*2] > 0) and
             (min_kateg > Matrix_Shitosti[(size_x - x + 1)*2 + 1 + (size_y - y)*size_x*2]) then begin
            min_kateg := Matrix_Shitosti[(size_x - x + 1)*2 + 1 + (size_y - y)*size_x*2];
	    _x_ := size_x - x + 1;
	    _y_ := size_y - y;
          end;
	  //x(y+1)
	  if (Matrix_Shitosti[(size_x - x)*2 + 1 + (size_y - y + 1)*size_x*2] > 0) and
             (min_kateg > Matrix_Shitosti[(size_x - x)*2 + 1 + (size_y - y + 1)*size_x*2]) then begin
            min_kateg := Matrix_Shitosti[(size_x - x)*2 + 1 + (size_y - y + 1)*size_x*2];
	    _x_ := size_x - x;
	    _y_ := size_y - y + 1;
          end;
	  //(x-1)y
	  if (Matrix_Shitosti[(size_x - x - 1)*2 + 1 + (size_y - y)*size_x*2] > 0) and
             (min_kateg > Matrix_Shitosti[(size_x - x - 1)*2 + 1 + (size_y - y)*size_x*2]) then begin
            min_kateg := Matrix_Shitosti[(size_x - x - 1)*2 + 1 + (size_y - y)*size_x*2];
	    _x_ := size_x - x - 1;
	    _y_ := size_y - y;
          end;
          //проверка по второй производной
	  //(x)(y-1)
	  if (Matrix_Shitosti[(size_x - x)*2 + 1 + (size_y - y - 1)*size_x*2] > 0) and
             (Matrix_Shitosti[(size_x - x)*2 + 1 + (size_y - y - 1)*size_x*2] = min_kateg) and
             (min_proizv > Matrix_Proizv[(size_x - x)*2 + 1 + (size_y - y - 1)*size_x*2]) then begin
            min_kateg := Matrix_Shitosti[(size_x - x)*2 + 1 + (size_y - y - 1)*size_x*2];
	    _x_ := size_x - x;
	    _y_ := size_y - y - 1;
          end;
	  //(x+1)y
	  if (Matrix_Shitosti[(size_x - x + 1)*2 + 1 + (size_y - y)*size_x*2] > 0) and
             (Matrix_Shitosti[(size_x - x + 1)*2 + 1 + (size_y - y)*size_x*2] = min_kateg) and
             (min_proizv > Matrix_Proizv[(size_x - x + 1)*2 + 1 + (size_y - y)*size_x*2]) then begin
            min_kateg := Matrix_Shitosti[(size_x - x + 1)*2 + 1 + (size_y - y)*size_x*2];
	    _x_ := size_x - x + 1;
	    _y_ := size_y - y;
          end;
	  //x(y+1)
	  if (Matrix_Shitosti[(size_x - x)*2 + 1 + (size_y - y + 1)*size_x*2] > 0) and
             (Matrix_Shitosti[(size_x - x)*2 + 1 + (size_y - y + 1)*size_x*2] = min_kateg) and
             (min_proizv > Matrix_Proizv[(size_x - x)*2 + 1 + (size_y - y + 1)*size_x*2]) then begin
            min_kateg := Matrix_Shitosti[(size_x - x)*2 + 1 + (size_y - y + 1)*size_x*2];
	    _x_ := size_x - x;
	    _y_ := size_y - y + 1;
          end;
	  //(x-1)y
	  if (Matrix_Shitosti[(size_x - x - 1)*2 + 1 + (size_y - y)*size_x*2] > 0) and
             (Matrix_Shitosti[(size_x - x - 1)*2 + 1 + (size_y - y)*size_x*2] = min_kateg) and
             (min_proizv > Matrix_Proizv[(size_x - x - 1)*2 + 1 + (size_y - y)*size_x*2]) then begin
            min_kateg := Matrix_Shitosti[(size_x - x - 1)*2 + 1 + (size_y - y)*size_x*2];
	    _x_ := size_x - x - 1;
	    _y_ := size_y - y;
          end;
	  if min_kateg <> 10000 then begin
            if abs(Matrix_WFaza[size_x - x + (size_y - y)*size_x] -
                   Matrix_WFaza[_x_ + _y_*size_x] + 2*pi) < pi - pi/20 then
	      Matrix_Faza[size_x - x + (size_y - y)*size_x] := Matrix_Faza[_x_ + _y_*size_x]+
                                           (Matrix_WFaza[size_x - x + (size_y - y)*size_x] -
                                            Matrix_WFaza[_x_ + _y_*size_x]) +
                                           2*pi
            else if abs(Matrix_WFaza[size_x - x + (size_y - y)*size_x] -
                        Matrix_WFaza[_x_ + _y_*size_x] - 2*pi) < pi - pi/20 then
	           Matrix_Faza[size_x - x + (size_y - y)*size_x] := Matrix_Faza[_x_ + _y_*size_x] +
                                                (Matrix_WFaza[size_x - x + (size_y - y)*size_x] -
                                                 Matrix_WFaza[_x_ + _y_*size_x]) -
                                               2*pi
		 else Matrix_Faza[size_x - x + (size_y - y)*size_x] := Matrix_Faza[_x_ + _y_*size_x] +
                                                   (Matrix_WFaza[size_x - x + (size_y - y)*size_x] -
                                                    Matrix_WFaza[_x_ + _y_*size_x]);
	    Matrix_FinalPicture[size_x - x + (size_y - y)*size_x] := Matrix_Faza[size_x - x + (size_y - y)*size_x];
	    Matrix_Shitosti[(size_x - x)*2 + (size_y - y)*size_x*2] := 1; //сшитая
	    Matrix_Shitosti[(size_x - x)*2 + 1 + (size_y - y)*size_x*2] := kateg; //категория
	    Inc(shit_points);
          end;
	end;
      end;
    end;
  Hodilnik := shit_points;
end;

{
  Описание : Сшивка фазы по методу наименьших квадратов
  Вход     : up_begin, up_steps - значение начала и шаг сшивки по производной,
             x_begin, y_begin - точка начала сшивки
             Size_X, Size_Y - размер всех массивов
             Matrix_WFaza - массив с несшитой фазой обязательно в диапазоне от 0 до 2 пи
             Matrix_Videlenie - область для сшивки
  Выход    : Matrix_FinalPicture - массив с сшитой фазой
            !!! выходные массивы создаются вызывающей функцией !!!
  Источник : Исходники Сухорукова К
}
procedure UnWrapPhase(up_begin, up_steps : TReal;
                     fd, sd : boolean;
                     x_begin, y_begin,
                     size_x, size_y : Integer;
                     var Matrix_WFaza, Matrix_FinalPicture: TRealArray;
                     var Matrix_Videlenie  : {TRealArray}TBtArr);
var
  Matrix_Proizv, Matrix_horosh, Matrix_Faza,
  Matrix_Shitosti, Matrix_BadPoints : PRealArray;
  i, j, kateg, y, x, cout : integer;
  kriterii, max_proizv, proizv, temp : TReal;
  x_vid_min, x_vid_max, y_vid_min, y_vid_max : integer;
  matrix_temp : array[0..3] of TReal;
  summa, max1, po_x, po_y : TReal;
begin
  // создаем временные массивы
  GetMem(Matrix_Faza, size_x*size_y*SizeOf(TReal));
  GetMem(Matrix_horosh, size_x*size_y*SizeOf(TReal));
  GetMem(Matrix_BadPoints, size_x*size_y*SizeOf(TReal));
  GetMem(Matrix_Proizv, size_x*size_y*SizeOf(TReal)*2);
  GetMem(Matrix_Shitosti, size_x*size_y*SizeOf(TReal)*2);
  // заполняем временные массивы и находим прямоугольную область сшивки по маске
  ZeroMemory(Matrix_Faza, size_x*size_y*SizeOf(TReal));
  ZeroMemory(Matrix_horosh, size_x*size_y*SizeOf(TReal));
  ZeroMemory(Matrix_BadPoints, size_x*size_y*SizeOf(TReal));
  ZeroMemory(Addr(Matrix_FinalPicture), size_x*size_y*SizeOf(TReal));
  ZeroMemory(Matrix_Proizv, size_x*size_y*SizeOf(TReal)*2);
  ZeroMemory(Matrix_Shitosti, size_x*size_y*SizeOf(TReal)*2);
  // находим прямоугольную область сшивки по маске и заполняем badpoints
  x_vid_min := size_x - 1;
  x_vid_max := 0;
  y_vid_min := size_y - 1;
  y_vid_max := 0;
  for I := 0 to size_y - 1 do
    for J := 0 to size_x - 1 do begin
      Matrix_Faza^[I*size_x + J] := Matrix_WFaza[I*size_x + J];
      if Matrix_Videlenie[I*size_x + J] <> 0 then Matrix_BadPoints^[I*size_x + J] := 0.0
      else Matrix_BadPoints^[I*size_x + J] := 1.0;
      if (Matrix_Videlenie[I*size_x + J] <> 0) and (I < y_vid_min) then
        y_vid_min := I;
      if (Matrix_Videlenie[I*size_x + J] <> 0) and (I > y_vid_max) then
        y_vid_max := I;
      if (Matrix_Videlenie[I*size_x + J] <> 0) and (J < x_vid_min) then
        x_vid_min := J;
      if (Matrix_Videlenie[I*size_x + J] <> 0) and (J > x_vid_max) then
        x_vid_max := J;
      // по краям на 2 пиксела не сшиваем
      if (I < 1) or (J < 1) or
         (I > size_y - 2) or (J > size_x - 2) then Matrix_BadPoints^[I*size_x + J] := 1.0;

    end;
  // по краям на 2 пиксела не сшиваем
  if y_vid_min < 1 then y_vid_min := 1;
  if x_vid_min < 1 then x_vid_min := 1;
  if y_vid_max > Size_y - 2 then y_vid_max := size_y - 2;
  if x_vid_max > Size_x - 2 then x_vid_max := size_x - 2;
  //заполняем матрицу производных
  max_proizv := 0;
  proizv := 0;
  if fd or sd then for y := 1 to size_y-2 do
    for x := 1 to size_x-2 do begin
      //+2pi
      //i,j-1
      if abs(Matrix_WFaza[x + y*size_x] - Matrix_WFaza[x + (y - 1)*size_x] + 2*pi) < pi then
        matrix_temp[1] := abs(Matrix_WFaza[x + y*size_x] - Matrix_WFaza[x + (y - 1)*size_x] + 2*pi)
      else
        matrix_temp[1] := abs(Matrix_WFaza[x + y*size_x] - Matrix_WFaza[x + (y - 1)*size_x]);
      //i-1,j
      if abs(Matrix_WFaza[x + y*size_x] - Matrix_WFaza[x - 1 + y*size_x] + 2*pi) < pi then
        matrix_temp[0] := abs(Matrix_WFaza[x + y*size_x] - Matrix_WFaza[x - 1 + y*size_x] + 2*pi)
      else
        matrix_temp[0] := abs(Matrix_WFaza[x + y*size_x] - Matrix_WFaza[x - 1 + y*size_x]);
      //i+1,j
      if abs(Matrix_WFaza[x + y*size_x] - Matrix_WFaza[x + 1 + y*size_x] + 2*pi) < pi then
        matrix_temp[2] := abs(Matrix_WFaza[x + y*size_x] - Matrix_WFaza[x + 1 + y*size_x] + 2*pi)
      else
        matrix_temp[2] := abs(Matrix_WFaza[x + y*size_x] - Matrix_WFaza[x + 1 + y*size_x]);
      //i,j+1
      if abs(Matrix_WFaza[x + y*size_x] - Matrix_WFaza[x + (y + 1)*size_x] + 2*pi) < pi then
        matrix_temp[3] := abs(Matrix_WFaza[x + y*size_x] - Matrix_WFaza[x + (y + 1)*size_x] + 2*pi)
      else
        matrix_temp[3] := abs(Matrix_WFaza[x + y*size_x] - Matrix_WFaza[x + (y + 1)*size_x]);
      //-2pi
      //i,j-1
      if abs(Matrix_WFaza[x + y*size_x] - Matrix_WFaza[x + (y - 1)*size_x] - 2*pi) < pi then
        matrix_temp[1] := abs(Matrix_WFaza[x + y*size_x] - Matrix_WFaza[x + (y - 1)*size_x] - 2*pi);
      //i-1,j
      if abs(Matrix_WFaza[x + y*size_x] - Matrix_WFaza[x - 1 + y*size_x] - 2*pi) < pi then
        matrix_temp[0] := abs(Matrix_WFaza[x + y*size_x] - Matrix_WFaza[x - 1 + y*size_x] - 2*pi);
      //i+1,j
      if abs(Matrix_WFaza[x + y*size_x] - Matrix_WFaza[x + 1 + y*size_x] - 2*pi) < pi then
        matrix_temp[2] := abs(Matrix_WFaza[x + y*size_x] - Matrix_WFaza[x + 1 + y*size_x] - 2*pi);
      //i,j+1
      if abs(Matrix_WFaza[x + y*size_x] - Matrix_WFaza[x + (y + 1)*size_x] - 2*pi) < pi then
        matrix_temp[3] := abs(Matrix_WFaza[x + y*size_x] - Matrix_WFaza[x + (y + 1)*size_x] - 2*pi);      //первая производная
      if fd then begin
        // цикл какой то
        max1 := 0;
        for i := 0 to 3 do
          if max1 < matrix_temp[i] then max1 := matrix_temp[i];
        Matrix_Proizv^[x*2 + y*size_x*2] := max1;
      end;
      if sd then begin
        po_x := abs(2*Matrix_WFaza[x + y*size_x] - matrix_temp[0] - matrix_temp[2]);
        po_y := abs(2*Matrix_WFaza[x + y*size_x] - matrix_temp[1] - matrix_temp[3]);
        if not(fd) then begin
      	  if po_x > po_y then Matrix_Proizv^[x*2 + y*size_x*2] := po_x
      	  else Matrix_Proizv^[x*2 + y*size_x*2] := po_y;
        end
        else begin
      	  if po_x > po_y then Matrix_Proizv^[x*2 + 1 + y*size_x*2] := po_x
      	  else Matrix_Proizv^[x*2 + 1 + y*size_x*2] := po_y;
        end;
      end;
      // возвращаем
      if fd and sd then proizv := 0 else proizv := Matrix_Proizv^[x*2 + y*size_x*2];
      if max_proizv < proizv then max_proizv := proizv;
    end;
  //находим начальную точку разворота
  Matrix_Shitosti^[x_begin*2 + y_begin*size_x*2] := 1; //сшитая начальная точка
  Matrix_Shitosti^[x_begin*2 + 1 + y_begin*size_x*2] := 1; //первая категория
  Matrix_FinalPicture[x_begin + y_begin*size_x] := Matrix_WFaza[x_begin + y_begin*size_x];
  //первый цикл разворачивания
  kateg := 1;
  kriterii := up_begin;
  while kriterii < 1 do begin
    while Hodilnik(size_x, size_y, x_vid_min, x_vid_max, y_vid_min, y_vid_max,
                   kriterii, kateg, Matrix_Proizv^, Matrix_horosh^, Matrix_WFaza,
                   Matrix_Faza^, Matrix_Shitosti^, Matrix_BadPoints^,
                   Matrix_Videlenie, Matrix_FinalPicture) <> 0 do;
    Inc(kateg);
    kriterii := kriterii + up_steps;
  end;
  //второй цикл разворачивания по увеличенным шагам
  kriterii := 1;
  while kriterii <= 4 do begin
    while Hodilnik(size_x, size_y, x_vid_min, x_vid_max, y_vid_min, y_vid_max,
                   kriterii, kateg, Matrix_Proizv^, Matrix_horosh^, Matrix_WFaza,
                   Matrix_Faza^, Matrix_Shitosti^, Matrix_BadPoints^,
                   Matrix_Videlenie, Matrix_FinalPicture) <> 0 do;
    Inc(kateg);
    kriterii := kriterii + up_steps;
  end;
  //заполняем запрещенные точки
  for y := 1 to size_y - 2 do
    for x := 1 to size_x - 2 do if Matrix_BadPoints^[x + y*size_x] = 1 then begin
      cout := 0;
      summa := 0.0;
      if Matrix_BadPoints^[x - 1 + (y - 1)*size_x] = 0 then begin
        summa := summa + Matrix_FinalPicture[x - 1 + (y - 1)*size_x];
        Inc(cout);
      end;
      if Matrix_BadPoints^[x + (y - 1)*size_x] = 0 then begin
        summa := summa + Matrix_FinalPicture[x + (y - 1)*size_x];
        Inc(cout);
      end;
      if Matrix_BadPoints^[x + 1 + (y - 1)*size_x] = 0 then begin
        summa := summa + Matrix_FinalPicture[x + 1 + (y - 1)*size_x];
        Inc(cout);
      end;
      if Matrix_BadPoints^[x - 1 + (y + 1)*size_x] = 0 then begin
        summa := summa + Matrix_FinalPicture[x - 1 + (y + 1)*size_x];
        Inc(cout);
      end;
      if Matrix_BadPoints^[x + (y + 1)*size_x] = 0 then begin
        summa := summa + Matrix_FinalPicture[x + (y + 1)*size_x];
        Inc(cout);
      end;
      if Matrix_BadPoints^[x + 1 + (y + 1)*size_x] = 0 then begin
        summa := summa + Matrix_FinalPicture[x + 1 + (y + 1)*size_x];
        Inc(cout);
      end;
      if Matrix_BadPoints^[x - 1 + y*size_x] = 0 then begin
        summa := summa + Matrix_FinalPicture[x - 1 + y*size_x];
        Inc(cout);
      end;
      if Matrix_BadPoints^[x + 1 + y*size_x] = 0 then begin
        summa := summa + Matrix_FinalPicture[x + 1 + y*size_x];
        Inc(cout);
      end;
      if cout <> 0 then Matrix_FinalPicture[x + y*size_x] := summa/cout
      else Matrix_FinalPicture[x + y*size_x] := 0;
    end;
  // освобождаем временные массивы
  FreeMem(Matrix_Faza, size_x*size_y*SizeOf(TReal));
  FreeMem(Matrix_horosh, size_x*size_y*SizeOf(TReal));
  FreeMem(Matrix_BadPoints, size_x*size_y*SizeOf(TReal));
  FreeMem(Matrix_Proizv, size_x*size_y*SizeOf(TReal)*2);
  FreeMem(Matrix_Shitosti, size_x*size_y*SizeOf(TReal)*2);
end;

procedure FindResidue(W, H : integer; Porog, Porog1 : TReal;
                     var MIn, MOut : TRealArray);
var
  I , J : Integer;
  S : TReal;
  temp, temp1 : PRealArray;
begin
  GetMem(temp, 4 * SizeOf(TReal));
  GetMem(temp1, 4 * SizeOf(TReal));
  for I := 0 to H - 1 do
    for J := 0 to W - 1 do MOut[I * W + J] := 0;
  for I := 0 to H - 2 do
    for J := 0 to W - 2 do begin
      temp^[0] := MIn[I * W + J];
      temp^[1] := MIn[I * W + J + 1];
      temp^[2] := MIn[(I + 1) * W + J + 1];
      temp^[3] := MIn[(I + 1) * W + J];
      UnWrapArray(temp^, temp1^, 4, Porog);
      S := temp1^[0] + temp1^[1] + temp1^[2] + temp1^[3];
      if Abs(S) < Porog1 then MOut[I * W + J] := 0
      else begin
        if S > 0 then MOut[I * W + J] := S;
        if S < 0 then MOut[I * W + J] := S;
      end;
    end;
  FreeMem(temp, 4 * SizeOf(TReal));
  FreeMem(temp1, 4 * SizeOf(TReal));
end;

function UnWrapDelta(R1, R2, rThreshold : TReal) : TReal;
begin
  if Abs(R1 - R2) > rThreshold then begin
    if R1 - R2 > 0 then UnWrapDelta := Abs(R1 - R2 - 2 * Pi)
    else UnwrapDelta := Abs(R1 - R2 + 2 * Pi);
  end else UnWrapDelta := Abs(R1 - R2);
end;

procedure UnWrapArray(var A, T : TRealArray ; N : Integer; Tr : TReal);
var
  I : Integer;
begin
  for I := 0 to N - 2 do begin
    if Abs(A[I] - A[I + 1]) > Tr then begin
      if A[I] - A[I + 1] > 0 then t[I] := A[I] - A[I + 1] - 2 * Pi
      else t[I] := A[I] - A[I + 1] + 2 * Pi;
    end else t[I] := A[I] - A[I + 1];
  end;
  if Abs(A[N - 1] - A[0]) > Tr then begin
    if A[N - 1] - A[0] > 0 then t[n - 1] := A[n - 1] - A[0] - 2 * Pi
    else t[N - 1] := A[n - 1] - A[0] + 2 * Pi;
  end else t[N - 1] := A[n - 1] - A[0];
end;

procedure UnWrapPhaseSt(x_begin, y_begin,
                        size_x, size_y : Integer;
                        var Matrix_WFaza, Matrix_FinalPicture: TRealArray;
                        var Matrix_Videlenie  : {TRealArray}TBtArr);
begin
  UnWrapPhase(0.05, 0.08, True, True, x_begin, y_begin, size_x, size_y,
              Matrix_WFaza, Matrix_FinalPicture, Matrix_Videlenie);
end;

end.
