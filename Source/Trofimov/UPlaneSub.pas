unit UPlaneSub;

interface

uses Windows, UType, ULinAlg;

// Вычитание клина по СКО старый вариант
// size_x, size_y размерность
// Mask область выделения
// IsSubFromPlane вычитать из клина или клин из
// PRAInput входной массив
// PRAOutput выходной массив
procedure SubPlaneSKO(size_x, size_y : integer;
                      IsSubFromPlane : Boolean;
                      var PRAInput, Mask, PRAOutput : TRealArray);
// Вычитание клина по 3 точкам
// size_x, size_y размерность
// IsSubFromPlane вычитать из клина или клин из
// X1, Y1, X2, Y2, X3, Y3 координаты точек
// PixelSize размер области для усредения
// PRAInput входной массив
// Mask область выделения
// PRAOutput выходной массив
procedure SubPlane3Points(size_x, size_y : integer;
                          IsSubFromPlane : Boolean;
                          X1, Y1, X2, Y2, X3, Y3, PixelSize : Integer;
                          var PRAInput, Mask, PRAOutput : TRealArray);
// Вычитание клина по СКО
// size_x, size_y размерность
// Mask область выделения
// IsSubFromPlane вычитать из клина или клин из
// PRAInput входной массив
// PRAOutput выходной массив
procedure SubPlaneSKOOld(size_x, size_y : integer;
                         IsSubFromPlane : Boolean;
                         var PRAInput, Mask, PRAOutput : TRealArray);

implementation

procedure SubPlaneSKO(size_x, size_y : integer;
                      IsSubFromPlane : Boolean;
                      var PRAInput, Mask, PRAOutput : TRealArray);
var
  X, Y, PixCount : Integer;
  M : array [1..12] of TReal;
  MSol : array [1..3] of TReal;
  Signal : Boolean;
begin
  for Y := 1 to 12 do M[Y] := 0.0;
  PixCount := 0;
  {  Рассчитываем коэффициенты }
  for Y := 0 to Size_Y - 1 do
    for X := 0 to Size_X - 1 do if Mask[Y*Size_X + X] = 1 then begin
      M[12] := M[12] + PRAInput[Y*Size_X + X];
      M[4] := M[4] + PRAInput[Y*Size_X + X]*X;
      M[8] := M[8] + PRAInput[Y*Size_X + X]*Y;
      M[3] := M[3] + X;
      M[1] := M[1] + X*X;
      M[7] := M[7] + Y;
      M[6] := M[6] + Y*Y;
      M[2] := M[2] + X*Y;
      Inc(PixCount);
    end;
  {  Заполняем матрицу }
  M[5] := M[2];
  M[9] := M[3];
  M[10] := M[7];
  M[11] := PixCount;
  {  Решаем систему линейных уравнений - коэффициенты в матрице }
  Gauss126(3, M, MSol, Signal);
  {  Вычитаем найденную плоскость }
  if IsSubFromPlane then
    for Y := 0 to Size_Y - 1 do
      for X := 0 to Size_X - 1 do begin
        if Mask[Y*Size_X + X] = 1 then
          PRAOutput[Y*Size_X + X] := MSol[1]*X + MSol[2]*Y + MSol[3]
                                      - PRAInput[Y*Size_X + X]
        else PRAOutput[Y*Size_X + X] := 0.0;
      end
  else
    for Y := 0 to Size_Y - 1 do
      for X := 0 to Size_X - 1 do begin
        if Mask[Y*Size_X + X] = 1 then
          PRAOutput[Y*Size_X + X] := PRAInput[Y*Size_X + X] -
        else PRAOutput[Y*Size_X + X] := 0.0;
      end;
end;

procedure SubPlane3Points(size_x, size_y : integer;
                          IsSubFromPlane : Boolean;
                          X1, Y1, X2, Y2, X3, Y3, PixelSize : Integer;
                          var PRAInput, Mask, PRAOutput : TRealArray);
var
  X, Y : Integer;
  M : array [1..12] of TReal;
  MSol : array [1..3] of TReal;
  Signal : Boolean;
begin
  {  Инициализация  }
  for Y := 1 to 12 do M[Y] := 0.0;
  // усредняем Z для первой точки
  for Y := Y1 - PixelSize div 2 to Y1 + PixelSize div 2 do
    for X := X1 - PixelSize div 2 to X1 + PixelSize div 2 do
      if Mask[Y*Size_X + X] = 1 then M[4] := M[4] + PRAInput[Y*Size_X + X];
  // усредняем Z для второй точки
  for Y := Y2 - PixelSize div 2 to Y2 + PixelSize div 2 do
    for X := X2 - PixelSize div 2 to X2 + PixelSize div 2 do
      if Mask[Y*Size_X + X] = 1 then M[8] := M[8] + PRAInput[Y*Size_X + X];
  // усредняем Z для третьей точки
  for Y := Y3 - PixelSize div 2 to Y3 + PixelSize div 2 do
    for X := X3 - PixelSize div 2 to X3 + PixelSize div 2 do
      if Mask[Y*Size_X + X] = 1 then M[12] := M[12] + PRAInput[Y*Size_X + X];
  {  Заполняем матрицу }
  M[1] := X1;
  M[2] := Y1;
  M[3] := 1;
  M[5] := X2;
  M[6] := Y2;
  M[7] := 1;
  M[9] := X3;
  M[10] := Y3;
  M[11] := 1;
  {  Решаем систему линейных уравнений - коэффициенты в матрице }
  Gauss126(3, M, MSol, Signal);
  {  Вычитаем найденную плоскость }
  if IsSubFromPlane then
    for Y := 0 to Size_Y - 1 do
      for X := 0 to Size_X - 1 do
        PRAOutput[Y*Size_X + X] := MSol[1]*X + MSol[2]*Y + MSol[3]
                                   - PRAInput[Y*Size_X + X]
  else
    for Y := 0 to Size_Y - 1 do
      for X := 0 to Size_X - 1 do
        PRAOutput[Y*Size_X + X] := PRAInput[Y*Size_X + X] -
                                   MSol[1]*X - MSol[2]*Y - MSol[3];
end;

procedure SubPlaneSKOOld(size_x, size_y : integer;
                         IsSubFromPlane : Boolean;
                         var PRAInput, Mask, PRAOutput : TRealArray);
var
  e1, e2, f1, f2, g1, g2, k0, k1, k2, a2, a3, a1, b1, b2, b3, c2, c3, d3 : TReal;
  X, Y : Integer;
begin
  // Инициализация
  a2 := 0.0;
  a3 := 0.0;
  a1 := 0.0;
  b1 := 0.0;
  b2 := 0.0;
  b3 := 0.0;
  c2 := 0.0;
  c3 := 0.0;
  d3 := 0.0;
  // Находим коэффициенты считая точки только в области выделения
  for Y := 0 to Size_Y - 1 do
    for X := 0 to Size_X - 1 do if Mask[Y*Size_X + X] = 1 then begin
      a1 := a1 + PRAInput[Y*Size_X + X];
      a2 := a2 + X * PRAInput[Y*Size_X + X];
      a3 := a3 + Y * PRAInput[Y*Size_X + X];
      b1 := b1 + 1;
      b2 := b2 + x;
      b3 := b3 + y;
      c2 := c2 + x * x;
      c3 := c3 + x * y;
      d3 := d3 + y * y;
    end;
  // Решаем систему
  e1 := a1 / b1 - a2 / b2;
  e2 := a3 / b3 - a2 / b2;
  f1 := b2 / b1 - c2 / b2;
  f2 := c3 / b3 - c2 / b2;
  g1 := b3 / b1 - c3 / b2;
  g2 := d3 / b3 - c3 / b2;
  k2 := (e2 * f1 - e1 * f2) / (g2 * f1 - g1 * f2);
  k1 := (e1 - k2 * g1) / f1;
  k0 := (a1 - k1 * b2 - k2 * b3) / b1;
  {  Вычитаем найденную плоскость }
  if IsSubFromPlane then
    for Y := 0 to Size_Y - 1 do
      for X := 0 to Size_X - 1 do
        PRAOutput[Y*Size_X + X] := k0 + k1 * x + k2 * y
                                   - PRAInput[Y*Size_X + X]
  else
    for Y := 0 to Size_Y - 1 do
      for X := 0 to Size_X - 1 do
        PRAOutput[Y*Size_X + X] := PRAInput[Y*Size_X + X] -
                                   k0 + k1 * x + k2 * y;
end;

end.
