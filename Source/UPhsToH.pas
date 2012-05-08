unit UPhsToH;

interface

uses UType;

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
                        rA1, rA2, rA3, rA, rB, rXCCD, rYCCD : TReal;
                        var raPhase, raHeight : TRealArray);

implementation

procedure PhaseToHeight(iW, iH : Integer;
                        rA1, rA2, rA3, rA, rB, rXCCD, rYCCD : TReal;
                        var raPhase, raHeight : TRealArray);
var
  praX, praY, praZ : PRealArray;
  iX, iY : Integer;
begin
  // выделяем память
  GetMem(praX, iW * iH * SizeOf(TReal));
  GetMem(praY, iW * iH * SizeOf(TReal));
  GetMem(praZ, iW * iH * SizeOf(TReal));
  // Ищем высоту в милиметрах и преобразуем координаты
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      praZ^[iY * iW + iX] := rA1 * Sqr(raPhase[iY * iW + iX]) +
                             rA2 * raPhase[iY * iW + iX] + rA3;
      praX^[iY * iW + iX] := (rA + rB * praZ^[iY * iW + iX]) * iX / iW * rXCCD;
      praY^[iY * iW + iX] := (rA + rB * praZ^[iY * iW + iX]) * iY / iH * rYCCD;
    end;
  // Формируем выходной массив с необходимой интерполяцией
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
    
    end;
  // освобождаем память
  FreeMem(praX, iW * iH * SizeOf(TReal));
  FreeMem(praY, iW * iH * SizeOf(TReal));
  FreeMem(praZ, iW * iH * SizeOf(TReal));
end;

end.
