unit UPhsToH;

interface

uses SysUtils, Windows, UType;

procedure TransformHeightMask(iW, iH : Integer;
                              rA, rB : TReal;
                              var raIn, raMaskIn, raOut, raMaskOut : TRealArray); overload;

procedure TransformHeightMask(iW, iH : Integer;
                              rA, rB : TReal;
                              var raIn: TRealArray; var raMaskIn: TBtArr;
                              var raOut: TRealArray; var raMaskOut: TBtArr); overload;

procedure TransformHeightMask(iW, iH: integer;
                              ax, bx, ay, by, OriginX, OriginY: treal;
                              var raIn: TRealArray; var raMaskIn: TBtArr;
                              var raOut: TRealArray; var raMaskOut: TBtArr); overload;


procedure TransformMask(iCounter : Integer;
                        var paIn, paOut : TPointArray;
                        iW, iH : Integer;
                        rA, rB : TReal;
                        var raHeight : TRealArray);

{
Описание : Осуществляет преобразование фазы в радианах в высоту в милиметрах
           для зубной камеры с учетом искажения координат из-за веерной схемы
Вход     : iW , iH  - размеры массивов по Х и по Y
           rA1, rA2, rA3 - коэффициенты преобразования фазы
           rA, rB - коэффициенты преобразования координат
           rXCCD, rYCCD - размер ПЗС матрицы
           raPhase - фаза в радианах
Выход    : raHeight - высота в милиметрах
           !!! Выходные массивы создаются вызывающей программой
Источник : Диссертация Сухорукова К.
}
procedure PhaseToHeight(iW, iH : Integer;
                        rA1, rA2, rA3 : TReal;
                        var raPhase, raHeight : TRealArray);

procedure TransformHeight(iW, iH : Integer;
                          rA, rB : TReal;
                          var raHeight, raTrHeight : TRealArray);


//function Transform_Coord(var Matrix : TRealArray;
//                         w, h : Integer;
//                         A, B : Double;
//                         var Mask : TByteArray) : Integer; cdecl; external 'Transofrmation_Dll.dll';

procedure PhaseToHeightArray(iW, iH : Integer;
                             var ra1, ra2, ra3, raPhase, raHeight : TRealArray);


procedure RAOpticTransform(iW, iH : Integer;
                           rA, rB : TReal;
                           var raHeight, raTrHeight : TRealArray);
                             
implementation

uses Math, ULinAlg, URATool, Dialogs;

procedure PhaseToHeight(iW, iH : Integer;
                        rA1, rA2, rA3 : TReal;
                        var raPhase, raHeight : TRealArray);
var
  iX, iY : Integer;
begin
  // Ищем высоту в милиметрах и преобразуем координаты
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      raHeight[iY * iW + iX] := rA1 * Sqr(raPhase[iY * iW + iX]) +
        rA2 * raPhase[iY * iW + iX] + rA3;
end;

procedure PhaseToHeightArray(iW, iH : Integer;
                             var ra1, ra2, ra3, raPhase, raHeight : TRealArray);
var
  iX, iY : Integer;
begin
  // Ищем высоту в милиметрах и преобразуем координаты
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      raHeight[iY * iW + iX] := rA1[iY * iW + iX] * Sqr(raPhase[iY * iW + iX]) +
        rA2[iY * iW + iX] * raPhase[iY * iW + iX] + rA3[iY * iW + iX];
end;

type
  TPointsArray = array [0..2] of Integer;

procedure FindPoint(iW, iH : Integer;
                    var raZ, raX, raY : TRealArray;
                    var points : TPointsArray;
                    iPX, iPY, iCount : Integer;
                    var raUsed : TByteArray;
                    rx, ry : TReal;
                    var iaWin : TIntegerArray);
var
  iWinX, iWinY, iBX, iBY, iEX, iEY, iIndex, iTemp, iX, iY : Integer;
  rTemp2, rMax, rTemp : TReal;
  b3IsGood, bIsExist : Boolean;
begin
  rMax := MaxDouble;
  iWinX := iaWin[(iPY * iW + iPX) * 2];
  iWinY := iaWin[(iPY * iW + iPX) * 2 + 1];
  if iPX > iWinX then iBX := iPX - iWinX else iBX := 0;
  if iPX < iW - iWinX - 1 then iEX := iPX + iWinX else iEX := iW - 1;
  if iPY > iWinY then iBY := iPY - iWinY else iBY := 0;
  if iPY < iH - iWinY - 1 then iEY := iPY + iWinY else iEY := iH - 1;
  iIndex := -1;
  for iY := iBY to iEY do
    for iX := iBX to iEX do begin
      rTemp := Sqrt(Sqr(raX[iY * iW + iX] - rX) + Sqr(raY[iY * iW + iX] - rY));
//      for iTemp := 0 to iCount - 1 do rTemp := rTemp + Sqrt(Sqr(raX[iY * iW + iX] -
//        raX[Points[iTemp]]) + Sqr(raY[iY * iW + iX] - raY[Points[iTemp]]));
      if iCount = 2 then begin
        if Abs((raX[Points[1]] - raX[Points[0]]) *
          (raY[iY * iW + iX] - raY[Points[0]]) - (raY[Points[1]] - raY[Points[0]]) *
          (raX[iY * iW + iX] - raX[Points[0]])) < 0.05 then  b3IsGood := False
        else b3IsGood := True;
      end  
      else b3IsGood := True;
//      b3IsGood := False;
//      if iCount = 2 then begin
//        if (Abs(raX[Points[1]] - raX[iY * iW + iX]) > 0.5) and
//          (Abs(raY[Points[1]] - raY[iY * iW + iX]) > 0.5) then
//          b3IsGood := True;
//      end else b3IsGood := True;
      if (rTemp < rMax) and (raUsed[iY * iW + iX] <> 1) and (b3IsGood) then begin
        rMax := rTemp;
        iIndex := iY * iW + iX;
      end;
    end;
  Points[iCount] := iIndex;
  if iIndex <> - 1 then raUsed[iIndex] := 1;
end;

procedure FindPoints(iW, iH : Integer;
                     var raX, raY : TRealArray;
                     var paOut : TIntegerArray;
                     var iCount : Integer;
                     iPX, iPY : Integer;
                     rx, ry : TReal;
                     var iaWin : TIntegerArray;
                     var baBad : TByteArray);

var
  iWinX, iWinY, iBX, iBY, iEX, iEY, iX, iY : Integer;
  rTemp : TReal;
  rD : array[0..2] of TReal;

procedure SwapPoints(N1 , N2 : Integer);
var
  iTemp : Integer;
  rTemp2 : TReal;
begin
  iTemp := paOut[N1];
  rTemp2 := rD[N1];
  paOut[N1] := paOut[N2];
  rD[N1] := rD[N2];
  paOut[N2] := iTemp;
  rD[N2] := rTemp2;
end;

begin
  iWinX := iaWin[(iPY * iW + iPX) * 2];
  iWinY := iaWin[(iPY * iW + iPX) * 2 + 1];
  if iPX > iWinX then iBX := iPX - iWinX else iBX := 0;
  if iPX < iW - iWinX - 1 then iEX := iPX + iWinX else iEX := iW - 1;
  if iPY > iWinY then iBY := iPY - iWinY else iBY := 0;
  if iPY < iH - iWinY - 1 then iEY := iPY + iWinY else iEY := iH - 1;
  iCount := 0;
  for iY := iBY to iEY do
    for iX := iBX to iEX do if baBad[iY * iW + iX] = 0 then begin
      rTemp := Sqrt(Sqr(raX[iY * iW + iX] - rX) + Sqr(raY[iY * iW + iX] - rY));
      case iCount of
        0 : begin
          paOut[0] := iY * iW + iX;
          rD[0] := rTemp;
          Inc(iCount);
        end;
        1 : begin
          paOut[1] := iY * iW + iX;
          rD[1] := rTemp;
          Inc(iCount);
          if rD[1] < rD[0] then SwapPoints(0, 1);
        end;
        2 : begin
          paOut[2] := iY * iW + iX;
          rD[2] := rTemp;
          Inc(iCount);
          if rD[2] < rD[1] then SwapPoints(1, 2);
          if rD[1] < rD[0] then SwapPoints(0, 1);
        end;
        3 : if rTemp < rD[2] then begin
          paOut[2] := iY * iW + iX;
          rD[2] := rTemp;
          if rD[2] < rD[1] then SwapPoints(1, 2);
          if rD[1] < rD[0] then SwapPoints(0, 1);
        end;
      end;
    end;
end;

procedure SortArrayZ(iW, iH : Integer;
                     var raX, raY, raZ : TRealArray);
const
  MAXSTACK = 2048;
var
  i, j, // указатели, участвующие в разделении
  lb, ub, // границы сортируемого в цикле фрагмента
  stackpos, // текущая позиция стека
  ppos : Integer; // середина массива
  // стек запросов каждый запрос задается парой значений, а именно:
  // левой(lbstack) и правой(ubstack) границами промежутка
  lbstack, ubstack : array [0..MAXSTACK - 1] of Integer;
  pivot, rMax, rMin, rTempX, rTempY, rTempZ : TReal;
begin
  FindMaxMinRealArray(iW, iH, raX, rMax, rMin);
  rMax := rMax + 1;
  stackpos := 1;
  lbstack[1] := 0;
  ubstack[1] := iW * iH - 1;
  repeat
    // Взять границы lb и ub текущего массива из стека.
    lb := lbstack[ stackpos ];
    ub := ubstack[ stackpos ];
    Dec(stackpos);
    repeat
      // Шаг 1. Разделение по элементу pivot
      ppos := ( lb + ub ) shr 1;
      i := lb;
      j := ub;
      pivot := raX[ppos] + raY[ppos] * rMax;
      repeat
        while ( raX[i] + raY[i] * rMax < pivot ) and (i < iW * iH - 1) do Inc(i);
        while ( pivot < raX[j] + raY[j] * rMax ) and (j > 0) do Dec(j);
        if ( i <= j ) then begin
          rTempX := raX[i];
          rTempY := raY[i];
          rTempZ := raZ[i];
          raX[i] := raX[j];
          raY[i] := raY[j];
          raZ[i] := raZ[j];
          raX[j] := rTempX;
          raY[j] := rTempY;
          raZ[j] := rTempZ;
          Inc(i);
          Dec(j);
        end;
      until ( i <= j ) or (i = iW * iH - 1) or (j = 0);
      // Сейчас указатель i указывает на начало правого подмассива,
      // j - на конец левого (см. иллюстрацию выше), lb ? j ? i ? ub.
      // Возможен случай, когда указатель i или j выходит за границу массива
      // Шаги 2, 3. Отправляем большую часть в стек  и двигаем lb,ub
      if ( i < ppos ) then begin     // правая часть больше
        if ( i < ub ) then begin     //  если в ней больше 1 элемента - нужно
          Inc(stackpos);       //  сортировать, запрос в стек
          lbstack[ stackpos ] := i;
          ubstack[ stackpos ] := ub;
        end;
        ub := j; //  следующая итерация разделения будет работать с левой частью
      end
      else begin       	    // левая часть больше
        if ( j > lb ) then begin
          Inc(stackpos);
          lbstack[ stackpos ] := lb;
          ubstack[ stackpos ] := j;
        end;
        lb := i;
      end;
    until ( lb < ub );        // пока в меньшей части более 1 элемента
  until ( stackpos <> 0 );    // пока есть запросы в стеке
end;

{
  Описание : Производит оптическую трансформацию координат узловых точек
             сплайнов маски
  Вход : iCounter - количество узловых точек сплайнов маски для трансформации
         paIn - массив с точками для трансформации
         iW, iH - размер массива с профилем НЕТРАНСФОРМИРОВАННОЙ поверхности
         rA, rB - коэффициенты трансформации
         raHeight - массив с профилем НЕТРАНСФОРМИРОВАННОЙ поверхности
  Выход : paOut - массив с трансформированными точками
}
procedure TransformMask(iCounter : Integer;
                        var paIn, paOut : TPointArray;
                        iW, iH : Integer;
                        rA, rB : TReal;
                        var raHeight : TRealArray);
var
  iCount, iX, iY : Integer;
begin
  for iCount := 0 to iCounter do begin
    iX := paIn[iCount].X;
    iY := paIn[iCount].Y;
    paOut[iCount].X := Round((rA + rB * raHeight[iY * iW + iX]) / rA *
      (iX - (iW div 2)) + (iW div 2));
    paOut[iCount].Y := Round((rA + rB * raHeight[iY * iW + iX]) / rA *
      (iY - (iH div 2)) + (iH div 2));
  end;
end;

procedure TransformHeight(iW, iH : Integer;
                          rA, rB : TReal;
                          var raHeight, raTrHeight : TRealArray);
var
  praX, praY, praZ : PRealArray;
  pbaUsed : PByteArray;
  piaWin : PIntegerArray;
  iC, iTemp, iX, iY, iWinX, iWinY : Integer;
  M : array [1..5 * 6] of TReal;
  MSol : array [1..5] of TReal;
  Points : TPointsArray;
  Signal: Boolean;
  rMax, rMin, rDeltaX, rDeltaY, rTemp, rXRMax, rYRMax : TReal;
  zn1 ,zn2, ch_, zn_, z0_, z0, z1, z2, x0, x, x1, x2, y0, y1, y, y2, ch, zn : TReal;
  ok, two : Boolean;
  cout : Integer;
begin
  // выделяем память
  GetMem(praX, iW * iH * SizeOf(TReal));
  GetMem(praY, iW * iH * SizeOf(TReal));
  GetMem(pbaUsed, iW * iH);
  GetMem(piaWin, iW * iH * 2 * SizeOf(Integer));
  FillMemory(pbaUsed, iW * iH, 0);
  FindMaxMinRealArray(iW, iH, raHeight, rMax, rMin);
//  NormRealArray(iW, iH, raHeight, 0, rMax - rMin);
//  rMax := rMax - rMin;
//  rMin := 0;
  iWinX := 0;
  iWinY := 0;
  // Преобразуем координаты
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      praX^[iY * iW + iX] := (rA + rB * raHeight[iY * iW + iX]) / rA *
        (iX - (iW div 2));
      praY^[iY * iW + iX] := (rA + rB * raHeight[iY * iW + iX]) / rA *
        (iY - (iH div 2));
      iTemp := Round(Abs(praX^[iY * iW + iX] - (iX - (iW div 2))));
//      if iTemp < 1 then iTemp := 1;
      piaWin^[(iY * iW + iX) * 2] := iTemp + 1;
//      if iTemp > iWinX then iWinX := iTemp;
      iTemp := Round(Abs(praY^[iY * iW + iX] - (iY - (iH div 2))));
//      if iTemp < 1 then iTemp := 1;
//      if iTemp > iWinY then iWinY := iTemp;
      piaWin^[(iY * iW + iX) * 2 + 1] := iTemp + 1;
    end;
//  Inc(iWinX);
//  Inc(iWinY);
//  ShowMessage(IntToStr(iWinX) + ' ' + IntToStr(iWinY));
{  // Трансформируем координаты к декартовой системе
  iC := 0;
  for iY := 0 to iH - 1 do begin
    for iX := 0 to iW - 1 do begin
      x := (iX - (iW div 2));
      y := (iY - (iH div 2));
      for iTemp := 0 to 2 do
        FindPoint(iW, iH, raHeight, praX^, praY^, points, iX, iY, iTemp,
          pbaUsed^, x, y, piaWin^);
      pbaUsed^[Points[0]] := 0;
      pbaUsed^[Points[1]] := 0;
      pbaUsed^[Points[2]] := 0;
      x0 := praX^[Points[0]];
      x1 := praX^[Points[1]];
      x2 := praX^[Points[2]];
      y0 := praY^[Points[0]];
      y1 := praY^[Points[1]];
      y2 := praY^[Points[2]];
      z0 := raHeight[Points[0]];
      z1 := raHeight[Points[1]];
      z2 := raHeight[Points[2]];
      ch := ((x-x0)*(z1-z0)*(y2-y0))+((y-y0)*(x1-x0)*(z2-z0))-((x-x0)*(y1-y0)*
        (z2-z0))-((y-y0)*(z1-z0)*(x2-x0));
	    zn :=((x1-x0)*(y2-y0))-((y1-y0)*(x2-x0));
      x2 := sqrt(Sqr(x0 - x) + Sqr(y0 - y));
			x1 := sqrt(Sqr(x1 - x) + Sqr(y1 - y));
      ch_ := x1*z1+x2*z0;
      zn_ := x1+x2;
      if (Abs(zn_) > 0) or (Abs(zn) > 0) then begin
        if Abs(zn) > 0  then begin
          raTrHeight[iY * iW + iX] := ch /zn + z0;
//          if (iX = 575) and (iY = 284) then
//            ShowMessage(FloatToStr(raTrHeight[iY * iW + iX]) + ' ' +
//              FloatToStr(z0) + ' ' + FloatToStr(zn) + ' ' + FloatToStr(ch));
        end else raTrHeight[iY * iW + iX] := ch_ / zn_;
        if raTrHeight[iY * iW + iX] > rMax then raTrHeight[iY * iW + iX] := rMax;
        if raTrHeight[iY * iW + iX] < rMin then raTrHeight[iY * iW + iX] := rMin;
      end
      else begin
        raTrHeight[iY * iW + iX] := rMin;
        Inc(iC);
      end;
    end;
  end;
  ShowMessage(IntToStr(iC));}

  // как у сухорукова
  for iY := 0 to iH - 1 do begin
    for iX := 0 to iW - 1 do begin
      x := (iX - (iW div 2));
      y := (iY - (iH div 2));
      //1-я точка
      FindPoint(iW, iH, raHeight, praX^, praY^, points, iX, iY, 0, pbaUsed^, x,
        y, piaWin^);
			//поиск 2-й  точки
			ok := false;
			two := false;
      FindPoint(iW, iH, raHeight, praX^, praY^, points, iX, iY, 1, pbaUsed^, x,
        y, piaWin^);
			x0 := praX^[points[0]];
			x1 := praX^[points[1]];
      z0 := raHeight[Points[0]];
			y0 := praY^[points[0]];
			y1 := praY^[points[1]];
      z1 := raHeight[Points[1]];
  		if (Abs(x1 - x0) < 0.2) and (Abs(y1 - y0) < 0.2) then two := true;
			//поиск третьей точки
  		cout := 0;
      if not(two) then begin
        FindPoint(iW, iH, raHeight, praX^, praY^, points, iX, iY, 2, pbaUsed^,
          x, y, piaWin^);
        if points[2] = -1 then two := True
        else begin
     			x2 := praX^[points[2]];
	    		y2 := praY^[points[2]];
          z2 := raHeight[Points[2]];
        end;
      end;
      zn1 := (x1 - x0)*(y2 - y0);
  		zn2 := (y1 - y0)*(x2 - x0);
			if ((Abs(zn1 - zn2) < 0.5) or two) then begin
        x2 := sqrt(Sqr(x0 - x) + Sqr(y0 - y));
   			x1 := sqrt(Sqr(x1 - x) + Sqr(y1 - y));
        ch_ := x1*z1+x2*z0;
        zn_ := x1+x2;
        raTrHeight[iY * iW + iX] := ch_ / zn_;
//				if (x1 + x2  = 0) then ShowMessage('вылет точки!');
      end
			else begin
        ch := ((x-x0)*(z1-z0)*(y2-y0))+((y-y0)*(x1-x0)*(z2-z0))-((x-x0)*(y1-y0)*
          (z2-z0))-((y-y0)*(z1-z0)*(x2-x0));
	      zn :=((x1-x0)*(y2-y0))-((y1-y0)*(x2-x0));
        raTrHeight[iY * iW + iX] := ch /zn + z0;
      end;
      pbaUsed^[Points[0]] := 0;
      pbaUsed^[Points[1]] := 0;
      if Points[2] <> - 1 then pbaUsed^[Points[2]] := 0;
      if raTrHeight[iY * iW + iX] > rMax then raTrHeight[iY * iW + iX] := rMax;
      if raTrHeight[iY * iW + iX] < rMin then raTrHeight[iY * iW + iX] := rMin;
    end;
  end;
  // освобождаем память
  FreeMem(praX, iW * iH * SizeOf(TReal));
  FreeMem(praY, iW * iH * SizeOf(TReal));
  FreeMem(piaWin, iW * iH * 2 * SizeOf(Integer));
  FreeMem(pbaUsed, iW * iH);
end;

procedure TransformHeightMask(iW, iH: integer;
                              ax, bx, ay, by, OriginX, OriginY: treal;
                              var raIn: TRealArray; var raMaskIn: TBtArr;
                              var raOut: TRealArray; var raMaskOut: TBtArr); overload;
var
  praX, praY, praZ : PRealArray;
  praTemp: PBtArr;
  piaPoints : PIntegerArray;
  iT, iNewX, iNewY, iCount, iPointCount, iX, iY : Integer;
  rX, rY, rZ, rMax, rMin : TReal;
  M : array [1..12] of TReal;
  MSol : array [1..3] of TReal;
  Signal : Boolean;
begin
  // выделяем память
  GetMem(praX, iW * iH * SizeOf(TReal));
  GetMem(praY, iW * iH * SizeOf(TReal));
  GetMem(praZ, iW * iH * SizeOf(TReal));
  GetMem(praTemp, iW * iH * SizeOf(Tbt));
  GetMem(piaPoints, iW * iH * SizeOf(Integer));
  // Ищем максимум минимум
  FindMaxMinRealArray(iW, iH, raIn, rMax, rMin);
  // Преобразуем координаты
  iPointCount := 0;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do if raMaskIn[iY * iW + iX] = 1 then begin
      praX^[iPointCount] := (ax + bx * raIn[iY * iW + iX]) / ax *
        (iX - OriginX);
      praY^[iPointCount] := (ay + by * raIn[iY * iW + iX]) / ay *
        (iY - OriginY);
      praZ^[iPointCount] := raIn[iY * iW + iX];
      Inc(iPointCount);
    end;
  // Маска выходная
  for iCount := 0 to iW * iH - 1 do begin
    raMaskOut[iCount] := 0;
    praTemp^[iCount] := 0;
  end;
  // Ищем ближайшие к узлам Точки
  for iCount := 0 to iPointCount - 1 do begin
    iNewX := Round(praX^[iCount] + OriginX{(iW div 2)});
    iNewY := Round(praY^[iCount] + OriginY{(iH div 2)});
    if (iNewX > 0) and (iNewX < iW) and
       (iNewY > 0) and (iNewY < iH) then begin
      // Если уже есть - оставляем ту у которой высота больше
      if raMaskOut[iNewX + iW * iNewY] = 0 then begin
        raMaskOut[iNewX + iW * iNewY] := 1;
        piaPoints^[iNewX + iW * iNewY] := iCount;
      end
      else begin
        if praZ^[piaPoints^[iNewX + iW * iNewY]] < praZ^[iCount] then
          piaPoints^[iNewX + iW * iNewY] := iCount;
      end;
    end;
  end;
  // Интерполируем по квадрату 3х3
  iT := 1;
  for iY := iT to iH - iT - 1 do
    for iX := iT to iW - iT - 1 do begin
      //  Рассчитываем коэффициенты для апроксимации плоскостью
      iPointCount := 0;
      for iCount := 1 to 12 do M[iCount] := 0.0;
      for iNewX := -iT to iT do
        for iNewY := -iT to iT do
          if raMaskOut[(iY + iNewY) * iW + iX + iNewX] = 1 then begin
            iCount := piaPoints^[(iY + iNewY) * iW + iX + iNewX];
            rX := praX^[iCount];
            rY := praY^[iCount];
            rZ := praZ^[iCount];
            M[12] := M[12] + rZ;
            M[4] := M[4] + rZ * rX;
            M[8] := M[8] + rZ * rY;
            M[3] := M[3] + rX;
            M[1] := M[1] + rX * rX;
            M[7] := M[7] + rY;
            M[6] := M[6] + rY * rY;
            M[2] := M[2] + rX * rY;
            Inc(iPointCount);
          end;
      M[5] := M[2];
      M[9] := M[3];
      M[10] := M[7];
      M[11] := iPointCount;
      if (iPointCount > 3) then begin
        // Ищем апроксимирующую плоскость
        Gauss126(3, M, MSol, Signal);
        // Апроксимируем плоскостью
        if MSol[1] + MSol[2] + MSol[3] <> 0 then begin;
          rX := (iX - OriginX{(iW div 2)});
          rY := (iY - OriginY{(iH div 2)});
          raOut[iY * iW + iX] := MSol[1] * rX + MSol[2] * rY + MSol[3];
          praTemp^[iY * iW + iX] := 1;
        end
        else begin
          if (iPointCount > 0) and (raMaskOut[iY * iW + iX] = 1) then begin
            raOut[iY * iW + iX] := praZ^[piaPoints^[iY * iW + iX]];
            praTemp^[iY * iW + iX] := 1;
          end;
        end;
      end;
    end;
  // Дополняем выходную маску
  for iCount := 0 to iW * iH - 1 do raMaskOut[iCount] := praTemp^[iCount];
  // освобождаем память
  FreeMem(praX, iW * iH * SizeOf(TReal));
  FreeMem(praY, iW * iH * SizeOf(TReal));
  FreeMem(praZ, iW * iH * SizeOf(TReal));
  FreeMem(praTemp, iW * iH * SizeOf(tbt));
  FreeMem(piaPoints, iW * iH * SizeOf(Integer));
end;



procedure TransformHeightMask(iW, iH : Integer;
                              rA, rB : TReal;
                              var raIn: TRealArray; var raMaskIn: TBtArr;
                              var raOut: TRealArray; var raMaskOut: TBtArr); overload;
var
  praX, praY, praZ : PRealArray;
  praTemp: PBtArr;
  piaPoints : PIntegerArray;
  iT, iNewX, iNewY, iCount, iPointCount, iX, iY : Integer;
  rX, rY, rZ, rMax, rMin : TReal;
  M : array [1..12] of TReal;
  MSol : array [1..3] of TReal;
  Signal : Boolean;
begin
  // выделяем память
  GetMem(praX, iW * iH * SizeOf(TReal));
  GetMem(praY, iW * iH * SizeOf(TReal));
  GetMem(praZ, iW * iH * SizeOf(TReal));
  GetMem(praTemp, iW * iH * SizeOf(Tbt));
  GetMem(piaPoints, iW * iH * SizeOf(Integer));
  // Ищем максимум минимум
  FindMaxMinRealArray(iW, iH, raIn, rMax, rMin);
  // Преобразуем координаты
  iPointCount := 0;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do if raMaskIn[iY * iW + iX] = 1 then begin
      praX^[iPointCount] := (rA + rB * raIn[iY * iW + iX]) / rA *
        (iX - (iW div 2));
      praY^[iPointCount] := (rA + rB * raIn[iY * iW + iX]) / rA *
        (iY - (iH div 2));
      praZ^[iPointCount] := raIn[iY * iW + iX];
      Inc(iPointCount);
    end;
  // Маска выходная
  for iCount := 0 to iW * iH - 1 do begin
    raMaskOut[iCount] := 0;
    praTemp^[iCount] := 0;
  end;
  // Ищем ближайшие к узлам Точки
  for iCount := 0 to iPointCount - 1 do begin
    iNewX := Round(praX^[iCount] + (iW div 2));
    iNewY := Round(praY^[iCount] + (iH div 2));
    if (iNewX > 0) and (iNewX < iW) and
       (iNewY > 0) and (iNewY < iH) then begin
      // Если уже есть - оставляем ту у которой высота больше
      if raMaskOut[iNewX + iW * iNewY] = 0 then begin
        raMaskOut[iNewX + iW * iNewY] := 1;
        piaPoints^[iNewX + iW * iNewY] := iCount;
      end
      else begin
        if praZ^[piaPoints^[iNewX + iW * iNewY]] < praZ^[iCount] then
          piaPoints^[iNewX + iW * iNewY] := iCount;
      end;
    end;
  end;
  // Интерполируем по квадрату 3х3
  iT := 1;
  for iY := iT to iH - iT - 1 do
    for iX := iT to iW - iT - 1 do begin
      //  Рассчитываем коэффициенты для апроксимации плоскостью
      iPointCount := 0;
      for iCount := 1 to 12 do M[iCount] := 0.0;
      for iNewX := -iT to iT do
        for iNewY := -iT to iT do
          if raMaskOut[(iY + iNewY) * iW + iX + iNewX] = 1 then begin
            iCount := piaPoints^[(iY + iNewY) * iW + iX + iNewX];
            rX := praX^[iCount];
            rY := praY^[iCount];
            rZ := praZ^[iCount];
            M[12] := M[12] + rZ;
            M[4] := M[4] + rZ * rX;
            M[8] := M[8] + rZ * rY;
            M[3] := M[3] + rX;
            M[1] := M[1] + rX * rX;
            M[7] := M[7] + rY;
            M[6] := M[6] + rY * rY;
            M[2] := M[2] + rX * rY;
            Inc(iPointCount);
          end;
      M[5] := M[2];
      M[9] := M[3];
      M[10] := M[7];
      M[11] := iPointCount;
      if (iPointCount > 3) then begin
        // Ищем апроксимирующую плоскость
        Gauss126(3, M, MSol, Signal);
        // Апроксимируем плоскостью
        if MSol[1] + MSol[2] + MSol[3] <> 0 then begin;
          rX := (iX - (iW div 2));
          rY := (iY - (iH div 2));
          raOut[iY * iW + iX] := MSol[1] * rX + MSol[2] * rY + MSol[3];
          praTemp^[iY * iW + iX] := 1;
        end
        else begin
          if (iPointCount > 0) and (raMaskOut[iY * iW + iX] = 1) then begin
            raOut[iY * iW + iX] := praZ^[piaPoints^[iY * iW + iX]];
            praTemp^[iY * iW + iX] := 1;
          end;
        end;
      end;
    end;
  // Дополняем выходную маску
  for iCount := 0 to iW * iH - 1 do raMaskOut[iCount] := praTemp^[iCount];
  // освобождаем память
  FreeMem(praX, iW * iH * SizeOf(TReal));
  FreeMem(praY, iW * iH * SizeOf(TReal));
  FreeMem(praZ, iW * iH * SizeOf(TReal));
  FreeMem(praTemp, iW * iH * SizeOf(tbt));
  FreeMem(piaPoints, iW * iH * SizeOf(Integer));
end;

procedure TransformHeightMask(iW, iH : Integer;
                              rA, rB : TReal;
                              var raIn, raMaskIn, raOut, raMaskOut : TRealArray);
var
  praTemp, praX, praY, praZ : PRealArray;
  piaPoints : PIntegerArray;
  iT, iNewX, iNewY, iCount, iPointCount, iX, iY : Integer;
  rX, rY, rZ, rMax, rMin : TReal;
  M : array [1..12] of TReal;
  MSol : array [1..3] of TReal;
  Signal : Boolean;
begin
  // выделяем память
  GetMem(praX, iW * iH * SizeOf(TReal));
  GetMem(praY, iW * iH * SizeOf(TReal));
  GetMem(praZ, iW * iH * SizeOf(TReal));
  GetMem(praTemp, iW * iH * SizeOf(TReal));
  GetMem(piaPoints, iW * iH * SizeOf(Integer));
  // Ищем максимум минимум
  FindMaxMinRealArray(iW, iH, raIn, rMax, rMin);
  // Преобразуем координаты
  iPointCount := 0;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do if raMaskIn[iY * iW + iX] = 1 then begin
      praX^[iPointCount] := (rA + rB * raIn[iY * iW + iX]) / rA *
        (iX - (iW div 2));
      praY^[iPointCount] := (rA + rB * raIn[iY * iW + iX]) / rA *
        (iY - (iH div 2));
      praZ^[iPointCount] := raIn[iY * iW + iX];
      Inc(iPointCount);
    end;
  // Маска выходная
  for iCount := 0 to iW * iH - 1 do begin
    raMaskOut[iCount] := 0;
    praTemp^[iCount] := 0;
  end;
  // Ищем ближайшие к узлам Точки
  for iCount := 0 to iPointCount - 1 do begin
    iNewX := Round(praX^[iCount] + (iW div 2));
    iNewY := Round(praY^[iCount] + (iH div 2));
    if (iNewX > 0) and (iNewX < iW) and
       (iNewY > 0) and (iNewY < iH) then begin
      // Если уже есть - оставляем ту у которой высота больше
      if raMaskOut[iNewX + iW * iNewY] = 0 then begin
        raMaskOut[iNewX + iW * iNewY] := 1;
        piaPoints^[iNewX + iW * iNewY] := iCount;
      end
      else begin
        if praZ^[piaPoints^[iNewX + iW * iNewY]] < praZ^[iCount] then
          piaPoints^[iNewX + iW * iNewY] := iCount;
      end;
    end;
  end;
  // Интерполируем по квадрату 3х3
  iT := 1;
  for iY := iT to iH - iT - 1 do
    for iX := iT to iW - iT - 1 do begin
      //  Рассчитываем коэффициенты для апроксимации плоскостью
      iPointCount := 0;
      for iCount := 1 to 12 do M[iCount] := 0.0;
      for iNewX := -iT to iT do
        for iNewY := -iT to iT do
          if raMaskOut[(iY + iNewY) * iW + iX + iNewX] = 1 then begin
            iCount := piaPoints^[(iY + iNewY) * iW + iX + iNewX];
            rX := praX^[iCount];
            rY := praY^[iCount];
            rZ := praZ^[iCount];
            M[12] := M[12] + rZ;
            M[4] := M[4] + rZ * rX;
            M[8] := M[8] + rZ * rY;
            M[3] := M[3] + rX;
            M[1] := M[1] + rX * rX;
            M[7] := M[7] + rY;
            M[6] := M[6] + rY * rY;
            M[2] := M[2] + rX * rY;
            Inc(iPointCount);
          end;
      M[5] := M[2];
      M[9] := M[3];
      M[10] := M[7];
      M[11] := iPointCount;
      if (iPointCount > 3) then begin
        // Ищем апроксимирующую плоскость
        Gauss126(3, M, MSol, Signal);
        // Апроксимируем плоскостью
        if MSol[1] + MSol[2] + MSol[3] <> 0 then begin;
          rX := (iX - (iW div 2));
          rY := (iY - (iH div 2));
          raOut[iY * iW + iX] := MSol[1] * rX + MSol[2] * rY + MSol[3];
          praTemp^[iY * iW + iX] := 1;
        end
        else begin
          if (iPointCount > 0) and (raMaskOut[iY * iW + iX] = 1) then begin
            raOut[iY * iW + iX] := praZ^[piaPoints^[iY * iW + iX]];
            praTemp^[iY * iW + iX] := 1;
          end;
        end;
      end;
    end;
  // Дополняем выходную маску
  for iCount := 0 to iW * iH - 1 do raMaskOut[iCount] := praTemp^[iCount];
  // освобождаем память
  FreeMem(praX, iW * iH * SizeOf(TReal));
  FreeMem(praY, iW * iH * SizeOf(TReal));
  FreeMem(praZ, iW * iH * SizeOf(TReal));
  FreeMem(praTemp, iW * iH * SizeOf(TReal));
  FreeMem(piaPoints, iW * iH * SizeOf(Integer));
end;


procedure RAOpticTransform(iW, iH : Integer;
                           rA, rB : TReal;
                           var raHeight, raTrHeight : TRealArray);
var
  praX, praY : PRealArray;
  ppaFound, piaWin : PIntegerArray;
  pbaBad : PByteArray;
  M : array [1..12] of TReal;
  MSol : array [1..3] of TReal;
  bStopPoint, Signal : Boolean;
  rTemp, rMax, rMin, rX, rY, rZ : TReal;
  iBX, iEX, iBY, iEY, iCount, iWinX, iWinY, iTemp, iX, iY : Integer;
begin
  // выделяем память
  GetMem(praX, iW * iH * SizeOf(TReal));
  GetMem(praY, iW * iH * SizeOf(TReal));
  GetMem(piaWin, iW * iH * 2 * SizeOf(Integer));
  GetMem(ppaFound, 100 * SizeOf(Integer));
  GetMem(pbaBad, iW * iH);
  FillMemory(pbaBad, iW * iH, 0);
  FindMaxMinRealArray(iW, iH, raHeight, rMax, rMin);
  iWinX := 0;
  iWinY := 0;
  // Преобразуем координаты
  // и ищем максимальное смещение
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      praX^[iY * iW + iX] := (rA + rB * raHeight[iY * iW + iX]) / rA *
        (iX - (iW div 2));
      praY^[iY * iW + iX] := (rA + rB * raHeight[iY * iW + iX]) / rA *
        (iY - (iH div 2));
      iTemp := Round(Abs(praX^[iY * iW + iX] - (iX - (iW div 2))));
      piaWin^[(iY * iW + iX) * 2] := iTemp + 1;
      iTemp := Round(Abs(praY^[iY * iW + iX] - (iY - (iH div 2))));
      piaWin^[(iY * iW + iX) * 2 + 1] := iTemp + 1;
      if iWinX < piaWin^[(iY * iW + iX) * 2] then
        iWinX := piaWin^[(iY * iW + iX) * 2];
      if iWinY < piaWin^[(iY * iW + iX) * 2 + 1] then
        iWinY := piaWin^[(iY * iW + iX) * 2 + 1];
    end;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      piaWin^[(iY * iW + iX) * 2 + 1] := piaWin^[(iY * iW + iX) * 2 + 1] + iWinY;
      piaWin^[(iY * iW + iX) * 2] := piaWin^[(iY * iW + iX) * 2] + iWinX;      
    end;
  // Прорежаем
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      iWinX := piaWin^[(iY * iW + iX) * 2];
      iWinY := piaWin^[(iY * iW + iX) * 2 + 1];
      if iX > iWinX then iBX := iX - iWinX else iBX := 0;
      if iX < iW - iWinX - 1 then iEX := iX + iWinX else iEX := iW - 1;
      if iY > iWinY then iBY := iY - iWinY else iBY := 0;
      if iY < iH - iWinY - 1 then iEY := iY + iWinY else iEY := iH - 1;
      rX := (iX - (iW div 2));
      rY := (iY - (iH div 2));
      rZ := raHeight[iY * iW + iX];
      bStopPoint := False;
      for iWinY := iBY to iEY do begin
        for iWinX := iBX to iEX do begin
          if pbaBad^[iWinY * iW + iWinX] = 0 then begin
            rTemp := Sqrt(Sqr(praX^[iWinY * iW + iWinX] - rX) +
              Sqr(praY^[iWinY * iW + iWinX] - rY));
            if (rTemp < 0.1) then begin
              if raHeight[iWinY * iW + iWinX] > raHeight[iY * iW + iX] then begin
                pbaBad^[iY * iW + iX] := 1;
                bStopPoint := True;
              end else pbaBad^[iWinY * iW + iWinX] := 1;
            end;
          end;
          if bStopPoint then Break;
        end;
        if bStopPoint then Break;
      end;
    end;
  // Интерполируем на регулярную сетку
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      // Ищем окружающие точки
      rX := (iX - (iW div 2));
      rY := (iY - (iH div 2));
      FindPoints(iW, iH, praX^, praY^, ppaFound^, iCount, iX, iY, rX, rY,
       piaWin^, pbaBad^);
      if iCount = 3 then begin
        //  Рассчитываем коэффициенты для апроксимации плоскостью
        for iTemp := 1 to 12 do M[iTemp] := 0.0;
        for iTemp := 0 to iCount - 1 do begin
          rX := praX^[ppaFound^[iTemp]];
          rY := praY^[ppaFound^[iTemp]];
          rZ := raHeight[ppaFound^[iTemp]];
          M[12] := M[12] + rZ;
          M[4] := M[4] + rZ * rX;
          M[8] := M[8] + rZ * rY;
          M[3] := M[3] + rX;
          M[1] := M[1] + rX * rX;
          M[7] := M[7] + rY;
          M[6] := M[6] + rY * rY;
          M[2] := M[2] + rX * rY;
        end;
        M[5] := M[2];
        M[9] := M[3];
        M[10] := M[7];
        M[11] := iCount;
        // Ищем апроксимирующую плоскость
        Gauss126(3, M, MSol, Signal);
        // Апроксимируем плоскостью
        rX := (iX - (iW div 2));
        rY := (iY - (iH div 2));
        raTrHeight[iY * iW + iX] := MSol[1] * rX + MSol[2] * rY + MSol[3];
        // Обрезаем на всякий случай
        if raTrHeight[iY * iW + iX] > rMax then raTrHeight[iY * iW + iX] := rMax;
        if raTrHeight[iY * iW + iX] < rMin then raTrHeight[iY * iW + iX] := rMin;
      end;
    end;
  // освобождаем память
  FreeMem(praX, iW * iH * SizeOf(TReal));
  FreeMem(praY, iW * iH * SizeOf(TReal));
  FreeMem(piaWin, iW * iH * 2 * SizeOf(Integer));
  FreeMem(ppaFound, 100 * SizeOf(Integer));
end;

end.
