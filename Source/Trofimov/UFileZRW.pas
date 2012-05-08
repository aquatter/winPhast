Unit UFileZRW;

interface

uses SysUtils, Classes, Windows, Graphics, Math, Jpeg, UType, URATool;

procedure RALoadBn2(sFileName : string;
                    var praOut : PRealArray;
                    var iW, iH : Integer);

procedure RASaveBinMask(size_x, size_y,
                        x_vid_min, x_vid_max, y_vid_min, y_vid_max : INteger;
                        var PRAInput, raMask : TRealArray;
                        FileName : string);

procedure RASaveBinMask_with_Scale(size_x, size_y,
                        x_vid_min, x_vid_max, y_vid_min, y_vid_max : INteger;
                        scale_x, scale_y: treal;
                        var PRAInput, raMask : TRealArray;
                        FileName : string); overload;

procedure RASaveBinMask_with_Scale(size_x, size_y,
                        x_vid_min, x_vid_max, y_vid_min, y_vid_max : INteger;
                        scale_x, scale_y: treal;
                        var PRAInput : TRealArray;
                        var raMask: TBtArr;
                        FileName : string); overload;

procedure RASaveAscWMask(iW, iH : Integer;
                         var raIn, raMask : TRealArray;
                         sFileName : AnsiString;
                         rA: TReal); overload;

procedure RASaveAscWMask(iW, iH : Integer;
                         var raIn: TRealArray;
                         var raMask: TBtArr;
                         sFileName : AnsiString;
                         rA: TReal); overload;

function LoadAscAsRealMatrix(FileName : string;
                             var P : PRealArray;
                             var size_x, size_y : Integer) : Integer; cdecl;

function LoadBinAsRealMatrix(FileName : string;
                             var PRaInput : PRealArray;
                             var size_x, size_y : Integer) : Integer; cdecl;

procedure LoadPrnAsRealMatrix2(sFileName : string;
                               var praOut : PRealArray;
                               var iOutX, iOutY : Integer);

function LoadJpgAsRealMatrix(FileName : string;
                             var P : PRealArray;
                             var size_x, size_y : Integer) : Integer; cdecl;

function LoadImgAsRealMatrix(FileName : string;
                             var P : PRealArray;
                             var size_x, size_y : Integer) : Integer; cdecl;

function LoadBmpAsRealMatrix(FileName : string;
                             var P : PRealArray;
                             var size_x, size_y : Integer) : Integer; cdecl;

procedure RALoadBinWMask(FileName : string;
                         var PRaInput, praMask : PRealArray;
                         var size_x, size_y : Integer);

procedure RALoadASCwMask(sFileName : string;
                         var praOut, praMask : PRealArray;
                         var iOutX, iOutY : Integer);

procedure RASaveAsc(iW, iH : Integer;
                    var raIn : TRealArray;
                    sFileName : AnsiString);

function SaveMatrixRealAsBmp(XSize, YSize : Integer;
                             x_vid_min, x_vid_max, y_vid_min, y_vid_max : INteger;
                             var P : TRealArray;
                             FileName : string) : Integer; cdecl;

//procedure RASaveMaskAsc3(iW, iH : Integer;
//                         var raIn, raMask : TRealArray;
//                         sFileName : AnsiString);

procedure RASaveMaskAsc2(iW, iH : Integer;
                         var raIn, raMask : TRealArray;
                         sFileName : AnsiString);

procedure SaveMatrixRealAsBinMask(size_x, size_y,
                             x_vid_min, x_vid_max, y_vid_min, y_vid_max : INteger;
                             var PRAInput, raMask : TRealArray;
                             FileName : string);
function SaveMatrixRealAsBin_with_scale(size_x, size_y,
                             x_vid_min, x_vid_max, y_vid_min, y_vid_max : INteger;
                             scale_x, scale_y: treal;
                             var PRAInput : TRealArray;
                             FileName : string) : Integer; cdecl;

function SaveMatrixRealAsBin(size_x, size_y,
                             x_vid_min, x_vid_max, y_vid_min, y_vid_max : INteger;
                             var PRAInput : TRealArray;
                             FileName : string) : Integer; cdecl;


function LoadRealMatrix(FileName : string;
                        var P : PRealArray;
                        var size_x, size_y : Integer) : Integer; cdecl;
                        
function SaveMatrixReal(XSize, YSize : Integer;
                        xmin, xmax, ymin, ymax : INteger;
                        var P : TRealArray;
                        FileName : string) : Integer; cdecl;

function SaveMatrixRealAsBinByte(size_x, size_y,
                                 x_vid_min, x_vid_max, y_vid_min, y_vid_max : INteger;
                                 var PRAInput : TRealArray;
                                 FileName : string) : Integer; cdecl;
                        
implementation

uses Dialogs;

{
  Описание : выводим массив дествительных чисел в bin файл
             формат файла : ширина, длина по 2 байта со знаком,
             затем данные дествительные числа по 4 байта
             минимальное число в массиве - не показывать
  Вход     : size_x, size_y - размер матрицы
             x_vid_min, x_vid_max, y_vid_min, y_vid_max - выводимая часть
             PRAInput - матрица (указатель на область памяти)
             FileName - имя файла с расширением!!!
  Выход    : нет
  Источник : Трофимов А. Н.
}

function SaveMatrixRealAsBin_with_scale(size_x, size_y,
                             x_vid_min, x_vid_max, y_vid_min, y_vid_max : INteger;
                             scale_x, scale_y: treal;
                             var PRAInput : TRealArray;
                             FileName : string) : Integer; cdecl;
var
  F : file;
  I, J, K, L : Short;
  D : Single;
  PTemp : PSingleArray;
  rK, rNum, rMax, rMin : TReal;
begin
  // Ассоциируем с именем
  System.Assign(F, FileName);
  // Открываем пересоздавая
  System.ReWrite(F, 1);
  // Пишем ширину
  I := x_vid_max - x_vid_min + 1;
  System.BlockWrite(F, I, 2);
  // Пишем длину
  J := y_vid_max - y_vid_min + 1;
  System.BlockWrite(F, J, 2);
  FindMaxMinRealArray(size_x, size_y, PRAInput, rMax, rMin);
  // Пишем данные
  GetMem(PTemp, I*J*SizeOf(Single));
  for K := y_vid_max downto y_vid_min do
    for L := x_vid_max downto x_vid_min do begin
      rNum := PRAInput[K * size_x + L];
      PTemp^[(K - y_vid_min) * I + L - x_vid_min] := rNum
{      if rNum > rMin then PTemp^[(K - y_vid_min) * I + L - x_vid_min] := rNum
      else PTemp^[(K - y_vid_min) * I + L - x_vid_min] := -MaxSingle;}
    end;
  System.BlockWrite(F, PTemp^, I*J*SizeOf(Single));
  FreeMem(PTemp, I*J*SizeOf(Single));
  D:=scale_x;
  System.BlockWrite(F, D, SizeOf(Single));
  D:=scale_y;
  System.BlockWrite(F, D, SizeOf(Single));
  // Закрываем файл
  System.Close(F);
end;


function SaveMatrixRealAsBin(size_x, size_y,
                             x_vid_min, x_vid_max, y_vid_min, y_vid_max : INteger;
                             var PRAInput : TRealArray;
                             FileName : string) : Integer; cdecl;
var
  F : file;
  I, J, K, L : Short;
  D : Single;
  PTemp : PSingleArray;
  rK, rNum, rMax, rMin : TReal;
begin
  // Ассоциируем с именем
  System.Assign(F, FileName);
  // Открываем пересоздавая
  System.ReWrite(F, 1);
  // Пишем ширину
  I := x_vid_max - x_vid_min + 1;
  System.BlockWrite(F, I, 2);
  // Пишем длину
  J := y_vid_max - y_vid_min + 1;
  System.BlockWrite(F, J, 2);
  FindMaxMinRealArray(size_x, size_y, PRAInput, rMax, rMin);
  // Пишем данные
  GetMem(PTemp, I*J*SizeOf(Single));
  for K := y_vid_max downto y_vid_min do
    for L := x_vid_max downto x_vid_min do begin
      rNum := PRAInput[K * size_x + L];
      PTemp^[(K - y_vid_min) * I + L - x_vid_min] := rNum
{      if rNum > rMin then PTemp^[(K - y_vid_min) * I + L - x_vid_min] := rNum
      else PTemp^[(K - y_vid_min) * I + L - x_vid_min] := -MaxSingle;}
    end;
  System.BlockWrite(F, PTemp^, I*J*SizeOf(Single));
  FreeMem(PTemp, I*J*SizeOf(Single));
  // Закрываем файл
  System.Close(F);
end;

procedure SaveMatrixRealAsBinMask(size_x, size_y,
                             x_vid_min, x_vid_max, y_vid_min, y_vid_max : INteger;
                             var PRAInput, raMask : TRealArray;
                             FileName : string);
var
  F : file;
  I, J, K, L : Short;
  D : Single;
  PTemp : PSingleArray;
  rK, rNum, rMax, rMin : TReal;
  iPointsCountIn, iPointsCountOut : Integer;
begin
  iPointsCountIn := 0;
  iPointsCountOut := 0;
  // Ассоциируем с именем
  System.Assign(F, FileName);
  // Открываем пересоздавая
  System.ReWrite(F, 1);
  // Пишем ширину
  I := x_vid_max - x_vid_min + 1;
  System.BlockWrite(F, I, 2);
  // Пишем длину
  J := y_vid_max - y_vid_min + 1;
  System.BlockWrite(F, J, 2);
  // Пишем данные
  GetMem(PTemp, I*J*SizeOf(Single));
  for K := y_vid_max downto y_vid_min do
    for L := x_vid_max downto x_vid_min do begin
      rNum := PRAInput[K * size_x + L];
      if  raMask[K * size_x + L] = 1 then
        PTemp^[(K - y_vid_min) * I + L - x_vid_min] := rNum
      else PTemp^[(K - y_vid_min) * I + L - x_vid_min] := -MaxSingle;
    end;
  System.BlockWrite(F, PTemp^, I*J*SizeOf(Single));
  FreeMem(PTemp, I*J*SizeOf(Single));
  // Закрываем файл
  System.Close(F);
end;

procedure RASaveBinMask_with_Scale(size_x, size_y,
                        x_vid_min, x_vid_max, y_vid_min, y_vid_max : INteger;
                        scale_x, scale_y: treal;
                        var PRAInput, raMask : TRealArray;
                        FileName : string);
var
  F : file;
  I, J, K, L : Short;
  D: Single;
  PTemp : PSingleArray;
  rK, rNum, rMax, rMin : TReal;
  iK, iPointsCountIn, iPointsCountOut : Integer;
  bOutX, bOutY : Boolean;
begin
  iPointsCountIn := 0;
  iPointsCountOut := 0;
  bOutX := True;
  bOutY := True;
  iK := 1;
  // Ассоциируем с именем
  System.Assign(F, FileName);
  // Открываем пересоздавая
  System.ReWrite(F, 1);
  // Пишем ширину
  I := size_x div iK;
  System.BlockWrite(F, I, 2);
  // Пишем длину
  J := size_y div iK;
  System.BlockWrite(F, J, 2);
  // Пишем данные
  GetMem(PTemp, I*J*SizeOf(Single));
  for K := 0 to J - 1 do begin
    for L := 0 to I - 1 do begin
      rNum := PRAInput[K * iK * size_x + L * iK];
      if  raMask[K * iK * size_x + L * iK] = 1 then begin
        PTemp^[K * I + L] := rNum;
        Inc(iPointsCountOut);
      end
      else PTemp^[K * I + L] := -MaxSingle;
    end;
  end;
  System.BlockWrite(F, PTemp^, I*J*SizeOf(Single));
  FreeMem(PTemp, I*J*SizeOf(Single));
  D:=scale_x;
  System.BlockWrite(F, D, SizeOf(Single));
  D:=scale_y;
  System.BlockWrite(F, D, SizeOf(Single));
  // Закрываем файл
  System.Close(F);
  // Скока точек
//  ShowMessage('Для вывода ' + IntToStr(iPointsCountIn) + ' точек, вывели ' +
//    IntToStr(iPointsCountOut) + ' точек');
end;

procedure RASaveBinMask_with_Scale(size_x, size_y,
                        x_vid_min, x_vid_max, y_vid_min, y_vid_max : INteger;
                        scale_x, scale_y: treal;
                        var PRAInput : TRealArray;
                        var raMask: TBtArr;
                        FileName : string); overload;
var
  F : file;
  I, J, K, L : Short;
  D: Single;
  PTemp : PSingleArray;
  rK, rNum, rMax, rMin : TReal;
  iK, iPointsCountIn, iPointsCountOut : Integer;
  bOutX, bOutY : Boolean;
begin
  iPointsCountIn := 0;
  iPointsCountOut := 0;
  bOutX := True;
  bOutY := True;
  iK := 1;
  // Ассоциируем с именем
  System.Assign(F, FileName);
  // Открываем пересоздавая
  System.ReWrite(F, 1);
  // Пишем ширину
  I := size_x div iK;
  System.BlockWrite(F, I, 2);
  // Пишем длину
  J := size_y div iK;
  System.BlockWrite(F, J, 2);
  // Пишем данные
  GetMem(PTemp, I*J*SizeOf(Single));
  for K := 0 to J - 1 do begin
    for L := 0 to I - 1 do begin
      rNum := PRAInput[K * iK * size_x + L * iK];
      if  raMask[K * iK * size_x + L * iK] = 1 then begin
        PTemp^[K * I + L] := rNum;
        Inc(iPointsCountOut);
      end
      else PTemp^[K * I + L] := -MaxSingle;
    end;
  end;
  System.BlockWrite(F, PTemp^, I*J*SizeOf(Single));
  FreeMem(PTemp, I*J*SizeOf(Single));
  D:=scale_x;
  System.BlockWrite(F, D, SizeOf(Single));
  D:=scale_y;
  System.BlockWrite(F, D, SizeOf(Single));
  // Закрываем файл
  System.Close(F);
  // Скока точек
//  ShowMessage('Для вывода ' + IntToStr(iPointsCountIn) + ' точек, вывели ' +
//    IntToStr(iPointsCountOut) + ' точек');
end;

procedure RASaveBinMask(size_x, size_y,
                        x_vid_min, x_vid_max, y_vid_min, y_vid_max : INteger;
                        var PRAInput, raMask : TRealArray;
                        FileName : string);
var
  F : file;
  I, J, K, L : Short;
  D : Single;
  PTemp : PSingleArray;
  rK, rNum, rMax, rMin : TReal;
  iK, iPointsCountIn, iPointsCountOut : Integer;
  bOutX, bOutY : Boolean;
begin
  iPointsCountIn := 0;
  iPointsCountOut := 0;
  bOutX := True;
  bOutY := True;
  iK := 1;
  // Ассоциируем с именем
  System.Assign(F, FileName);
  // Открываем пересоздавая
  System.ReWrite(F, 1);
  // Пишем ширину
  I := size_x div iK;
  System.BlockWrite(F, I, 2);
  // Пишем длину
  J := size_y div iK;
  System.BlockWrite(F, J, 2);
  // Пишем данные
  GetMem(PTemp, I*J*SizeOf(Single));
  for K := 0 to J - 1 do begin
    for L := 0 to I - 1 do begin
      rNum := PRAInput[K * iK * size_x + L * iK];
      if  raMask[K * iK * size_x + L * iK] = 1 then begin
        PTemp^[K * I + L] := rNum;
        Inc(iPointsCountOut);
      end
      else PTemp^[K * I + L] := -MaxSingle;
    end;
  end;
  System.BlockWrite(F, PTemp^, I*J*SizeOf(Single));
  FreeMem(PTemp, I*J*SizeOf(Single));
  // Закрываем файл
  System.Close(F);
  // Скока точек
//  ShowMessage('Для вывода ' + IntToStr(iPointsCountIn) + ' точек, вывели ' +
//    IntToStr(iPointsCountOut) + ' точек');
end;

{
  Описание : выводим массив дествительных чисел в bin файл
             формат файла : ширина, длина по 2 байта со знаком,
             затем данные - по 1 байту
             минимальное число в массиве - не показывать
  Вход     : size_x, size_y - размер матрицы
             x_vid_min, x_vid_max, y_vid_min, y_vid_max - выводимая часть
             PRAInput - матрица (указатель на область памяти)
             FileName - имя файла с расширением!!!
  Выход    : нет
  Источник : Трофимов А. Н.
}
function SaveMatrixRealAsBinByte(size_x, size_y,
                                 x_vid_min, x_vid_max, y_vid_min, y_vid_max : INteger;
                                 var PRAInput : TRealArray;
                                 FileName : string) : Integer; cdecl;
var
  F : file;
  I, J, K, L : Short;
  D : Single;
  PTemp : PByteArray;
begin
  // Ассоциируем с именем
  System.Assign(F, FileName);
  // Открываем пересоздавая
  System.ReWrite(F, 1);
  // Пишем ширину
  I := x_vid_max - x_vid_min + 1;
  System.BlockWrite(F, I, 2);
  // Пишем длину
  J := y_vid_max - y_vid_min + 1;
  System.BlockWrite(F, J, 2);
  // Пишем данные
  GetMem(PTemp, I * J);
  for K := y_vid_min to y_vid_max do
    for L := x_vid_min to x_vid_max do
      PTemp^[(K - y_vid_min) * I + L - x_vid_min] := Round(PRAInput[K*size_x + L]);
  System.BlockWrite(F, PTemp^, I * J);
  FreeMem(PTemp, I * J);
  // Закрываем файл
  System.Close(F);
end;

function FindMaxMinRealArray(XSize, YSize : Integer;
                             var P : TRealArray;
                             var MaxRA, MinRA : TReal) : Integer;
var
  I, J : Integer;
  MinP, MaxP : TReal;
begin
  MaxP := MinDouble;
  MinP := MaxDouble;
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do begin
      if P[I * XSize + J] > maxP then MaxP := P[I * XSize + J];
      if P[I * XSize + J] < minP then MinP := P[I * XSize + J];
    end;
  MaxRA := MaxP;
  MinRA := MinP;
end;

{
  Описание : грузим массив дествительных чисел из bin файла
             формат файла : ширина, длина по 2 байта со знаком,
             затем данные дествительные числа по 4 байта
             минимальное число в массиве - не показывать             
  Вход     : FileName - имя файла с расширением!!!
  Выход    : size_x, size_y - размер матрицы
             PRAInput - матрица (указатель на адрес области памяти!!!)
             массив создается в функции
  Источник : Трофимов А. Н.
}
function LoadBinAsRealMatrix(FileName : string;
                             var PRaInput : PRealArray;
                             var size_x, size_y : Integer) : Integer; cdecl;
var
  F : file;
  I, J : Short;
  rMin, Max, Min : TREal;
  rNum : Single;
  PTemp : PSingleArray;
begin
  // Ассоциируем с именем
  System.Assign(F, FileName);
  // Открываем
  System.ReSet(F, 1);
  // Читаем ширину
  System.BlockRead(F, I, 2);
  size_x := I;
  // Читаем длину
  System.BlockRead(F, I, 2);
  size_y := I;
  // Читаем данные
  GetMem(PRAInput, Size_x*Size_y*SizeOf(TReal));
  GetMem(PTemp, Size_x*Size_y*SizeOf(Single));
  System.BlockRead(F, PTemp^, Size_x*Size_y*SizeOf(Single));
  rMin := MaxDouble;
  for I := 0 to size_y - 1 do
    for J := 0 to size_x - 1 do begin
      rNum := PTemp^[I*size_x + J];
      if rNum > -3.300000E+38 then begin
        PRAInput^[I*size_x + J] := rNum;
        if rNum < rMin then rMin := rNum;
      end;
    end;
  for I := 0 to size_y - 1 do
    for J := 0 to size_x - 1 do begin
      rNum := PTemp^[I*size_x + J];
      if rNum < -3.300000E+38 then PRAInput^[I*size_x + J] := rMin;
    end;
  FreeMem(PTemp, Size_x*Size_y*SizeOf(Single));
  // Закрываем файл
  System.Close(F);
end;

procedure RALoadBn2(sFileName : string;
                    var praOut : PRealArray;
                    var iW, iH : Integer);
var
  fIn : file;
  sTemp : Short;
  iX, iY : Integer;
  pbaTemp : PByteArray;
begin
  // Ассоциируем с именем
  System.Assign(fIn, sFileName);
  // Открываем
  System.ReSet(fIn, 1);
  // Читаем ширину
  System.BlockRead(fIn, sTemp, 2);
  iW := sTemp;
  // Читаем длину
  System.BlockRead(fIn, sTemp, 2);
  iH := sTemp;
  // Читаем данные
  GetMem(praOut, iW * iH * SizeOf(TReal));
  GetMem(pbaTemp, iW * iH);
  System.BlockRead(fIn, pbaTemp^, iW * iH);
  // Закрываем файл
  System.Close(fIn);
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      praOut^[iY * iW + iX] := pbaTemp^[iY * iW + iX];
  FreeMem(pbaTemp, iW * iH);
end;

procedure RALoadBinWMask(FileName : string;
                         var PRaInput, praMask : PRealArray;
                         var size_x, size_y : Integer);
var
  F : file;
  I, J : Short;
  rMin, Max, Min : TREal;
  rNum : Single;
  PTemp : PSingleArray;
begin
  // Ассоциируем с именем
  System.Assign(F, FileName);
  // Открываем
  System.ReSet(F, 1);
  // Читаем ширину
  System.BlockRead(F, I, 2);
  size_x := I;
  // Читаем длину
  System.BlockRead(F, I, 2);
  size_y := I;
  // Выделяем память
  GetMem(PRAInput, Size_x*Size_y*SizeOf(TReal));
  GetMem(PraMask, Size_x*Size_y*SizeOf(TReal));
  GetMem(PTemp, Size_x*Size_y*SizeOf(Single));
  // Читаем данные из файла
  System.BlockRead(F, PTemp^, Size_x*Size_y*SizeOf(Single));
  // Закрываем файл
  System.Close(F);
  // В выходной массив их и формируем маску
  for I := 0 to size_y - 1 do
    for J := 0 to size_x - 1 do begin
      rNum := PTemp^[I*size_x + J];
      praMask^[I*size_x + J] := 1.0;
      if rNum > -3.300000E+38 then PRAInput^[I*size_x + J] := rNum
      else begin
        PRAInput^[I*size_x + J] := 0.0;
        praMask^[I*size_x + J] := 0.0;
      end;
    end;
  // Освобождаем память
  FreeMem(PTemp, Size_x*Size_y*SizeOf(Single));
end;

{
  Описание : выводим массив дествительных чисел в prn файл
             формат файла : тестовый файл с числами построчно
  Вход     : size_x, size_y - размер матрицы
             x_vid_min, x_vid_max, y_vid_min, y_vid_max - выводимая часть
             PRAInput - матрица (указатель на область памяти)
             FileName - имя файла с расширением!!!
  Выход    : нет
  Источник : Трофимов А. Н.
}
function SaveMatrixRealAsPrn(XSize, YSize : Integer;
                             x_vid_min, x_vid_max, y_vid_min, y_vid_max : INteger;
                             var P : TRealArray;
                             FileName : string) : Integer; cdecl;
var
  F : Text;
  I, J : Integer;
begin
  {  Связываем имя с файлом  }
  System.Assign(F, FileName);
  {  Открываем файл  }
  System.ReWrite(F);
  {  В случае ошибки выходим  }
  if System.IOResult <> 0 then Exit;
  for I := y_vid_min to y_vid_max do begin
    {  Выводим строку  }
    for J := x_vid_min to x_vid_max do System.Write(F, P[I * XSize + J]:10:6, ' ');
    {  На следующую строку  }
    WriteLn(F);
  end;
  {  Закрываем файл  }
  System.Close(F);
end;

procedure DelSpBar(var S : Ansistring);
var
  St, St2 : Ansistring;
  I : Integer;
begin
  St := S;
  if St <> '' then begin
    {  Удаляем пробелы в начале строки  }
    while (St[1] = ' ') and (St <> '') do St := Copy(St, 2, Length(St));
    {  Удаляем пробелы в конце строки  }
    while St[Length(St)] = ' ' do Delete(St, Length(St), 1);
    {  Удаляем пробелы в середине строки  }
    St2 := '';
    I := 1;
    while I <= Length(St) do begin
      if St[I] = ' ' then
        while (I + 1 < Length(St)) and (St[I + 1] = ' ') do Inc(I);
      St2 := St2 + St[I];
      Inc(I);
    end;
    S := St2;
  end;
end;

procedure DelDuplSpBar(var S : Ansistring);
var
  St, St2 : Ansistring;
  I : Integer;
begin
  St := S;
  if St <> '' then begin
    {  Удаляем пробелы в середине строки  }
    St2 := '';
    I := 1;
    while I <= Length(St) do begin
      if St[I] = ' ' then
        while (I + 1 < Length(St)) and (St[I + 1] = ' ') do Inc(I);
      St2 := St2 + St[I];
      Inc(I);
    end;
    S := St2;
  end;
end;

function IsNumChar(cIn : Char) : Boolean;
begin
  if cIn in ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'E', 'e', ',',
    '.', '+', '-', ' '] then Result := True else Result := False;
end;

procedure FindNumString(var sIn, sNum : AnsiString);
var
  iCounter, iDiv : Integer;
begin
  iCounter := 1;
  iDiv := 0;
  while (iCounter <= Length(sIn)) and IsNumChar(char(sIn[iCounter])) and
    (iDiv < 3) do begin
    if sIn[iCounter] in ['.', ',', '+', '-'] then Inc(iDiv);
    if (sIn[iCounter] = ' ') and not(sIn[iCounter + 1] in ['+', '-']) then Inc(iDiv);
    if (sIn[iCounter] in ['e', 'E']) and (iDiv > 1) then Dec(iDiv);
    Inc(iCounter);
  end;
  if iCounter < Length(sIn) then begin
    sNum := Copy(sIn, 1, iCounter - 2);
    sIn := Copy(sIn, iCounter - 1, Length(sIn));
  end  
  else begin
    sNum := Copy(sIn, 1, iCounter - 1);
    sIn := '';
  end;
end;

{
  Описание : грузим массив дествительных чисел из prn файла
  Вход     : FileName - имя файла с расширением!!!
  Выход    : size_x, size_y - размер матрицы
             PRAInput - матрица (указатель на адрес области памяти!!!)
             массив создается в функции
  Источник : Трофимов А. Н.
}
procedure LoadPrnAsRealMatrix2(sFileName : string;
                               var praOut : PRealArray;
                               var iOutX, iOutY : Integer);
var
  tfIn : Text;
  iTempX, iX, iY, iFileX, iFileY : Integer;
  sIn, sNum : AnsiString;
  praTemp : PRealArray;
begin
  System.Assign(tfIn, sFileName);
  System.ReSet(tfIn);
  if System.IOResult <> 0 then Exit;
  iFileX := 0;
  iFileY := 0;
  GetMem(praTemp, 3000 * 3000 * SizeOf(TReal));
  while not(EoF(tfIn)) do begin
    ReadLn(tfIn, sIn);
    iTempX := 0;
    DelSpBar(sIn);
    SIn := ' ' + sIn;
    if Pos('.', sIn) <> 0 then DecimalSeparator := '.'
    else DecimalSeparator := ',';
    while Length(sIn) <> 0 do begin
      FindNumString(sIn, sNum);
      DelSpBar(sNum);
      praTemp^[iFileY * iFileX + iTempX] := StrToFloat(sNum);
      Inc(iTempX);
    end;
//    if (iFileX <> 0) and (iTempX <> iFileX) then
//      ShowMessage('неравные строки ' + IntToStr(iFileX) + ' ' +
//        IntToStr(iTempX) + ' ' + IntToStr(iFileY))
//    else iFileX := iTempX;
    iFileX := iTempX;
    Inc(iFileY);
  end;
  GetMem(praOut, iFileX * iFileY * SizeOf(TReal));
  CopyMemory(praOut, praTemp,  iFileX * iFileY * SizeOf(TReal));
  FreeMem(praTemp, 3000 * 3000 * SizeOf(TReal));
//  iFileX := iTempX;
//  ShowMessage(IntToStr(iFileX) + ' ' + IntToStr(iFileY));
{  System.Close(tfIn);
  GetMem(praOut, iFileX * iFileY * SizeOf(TReal));
  System.Assign(tfIn, sFileName);
  System.ReSet(tfIn);
  for iY := 0 to iFileY - 1 do begin
    ReadLn(tfIn, sIn);
    DelDuplSpBar(sIn);
    for iX := 0 to iFileX - 1 do begin
      FindNumString(sIn, sNum);
      DelSpBar(sNum);
      if Pos('.', sNum) <> 0 then DecimalSeparator := '.'
      else DecimalSeparator := ',';
      praOut^[iY * iFileX + iX] := StrToFloat(sNum);
    end;
  end;  }
  iOutX := iFileX;
  iOutY := iFileY;
  System.Close(tfIn);
end;

procedure RALoadAscWMask(sFileName : string;
                         var praOut, praMask : PRealArray;
                         var iOutX, iOutY : Integer);
var
  tfIn : Text;
  iOldX, iFileX, iFileY : Integer;
  sIn, sNum : AnsiString;
  praTemp : PRealArray;
begin
  // Открываем файл
  System.Assign(tfIn, sFileName);
  System.ReSet(tfIn);
  // Не получилось - на выход
  if System.IOResult <> 0 then Exit;
  // Инициализация
  iFileX := 0;
  iFileY := 0;
  iOldX := 0;
  // !!! не забывать
  GetMem(praTemp, 3000 * 3000 * SizeOf(TReal));
  // Если сохранена только маска - то не знаю будет вылет
  // Первая строка массива
  while not(EoF(tfIn)) do begin
    Read(tfIn, iFileX, iFileY);
    if (iFileY < 1) then ReadLn(tfIn, praTemp^[iFileX])
    else begin
      iOutX := iOldX + 1;
      ReadLn(tfIn, praTemp^[iOldX + iFileX]);
      Break;      
    end;
    iOldX := iFileX;
  end;
  // все остальное
  while not(EoF(tfIn)) do begin
    Read(tfIn, iFileX, iFileY);
    ReadLn(tfIn, praTemp^[iFileX + iFileY * iOutX]);
  end;
  iOutY := iFileY + 1;
  // закрываем файл
  System.Close(tfIn);
  // память под выходные массивы
  GetMem(praOut, iOutX * iOutY * SizeOf(TReal));
  GetMem(praMask, iOutX * iOutY * SizeOf(TReal));
  // Считанные на выход
  CopyMemory(praOut, praTemp,  iOutX * iOutY * SizeOf(TReal));
  // распознаем маску
  for iFileY := 0 to iOutY - 1 do
    for iFileX := 0 to iOutX - 1 do
      if praTemp^[iFileY * iOutX + iFileX] < - 1.6e+308 then
        praMask^[iFileY * iOutX + iFileX] := 0
      else praMask^[iFileY * iOutX + iFileX] := 1;
  // Забиваем плохие числа
  FillRealArrayMiddleMask(iOutX, iOutY, praOut^, praMask^);
  // Освобождаем память
  FreeMem(praTemp, 3000 * 3000 * SizeOf(TReal));
end;


function LoadPrnAsRealMatrix(FileName : string;
                             var PRaInput : PRealArray;
                             var size_x, size_y : Integer) : Integer; cdecl;
var
  F : Text;
  TempPR : PRealArray;
  PPA : PPointerArray;
  NumSize, MaxX, I, J, X, Y, K : Integer;
  S, SD : AnsiString;
begin
  {  Связываем имя с файлом  }
  System.Assign(F, FileName);
  {  Открываем файл  }
  System.ReSet(F);
  if System.IOResult <> 0 then Exit;
  {  Определяем размер массива в файле  }
  X := 0;
  Y := 0;
  MaxX := 0;
  NumSize := 8;
  while not(EoF(F)) do begin
    ReadLn(F, S);
    X := Length(S) div NumSize;
    if X > MaxX then MaxX := X;
    {  Счетчик строк  }
    Inc(Y);
  end;
  {  Закрываем файл  }
  System.Close(F);
  {  Связываем имя с файлом  }
  System.Assign(F, FileName);
  {  Открываем файл  }
  System.ReSet(F);
  {  Выделяем память  }
  GetMem(PRAInput, X*Y*SizeOf(TReal));
  for I := 0 to Y - 1 do begin
    {  Считываем строку  }
    ReadLn(F, S);
    {  Удаляем пробелы  }
    DelSpBar(S);
    J := 0;
   {  Обрабатываем строку  }
    while S <> '' do begin
      {  Числа разделяются пробелами  }
      K := Pos(' ', S);
      {  Если последнее число  }
      if K = 0 then begin
        {  Это чтобы StrToFloat понял  }
        if not(S[1] in ['-', '+']) then S := '+' + S;
        S[Pos('.', S)] := ',';
        {  Преобразуем  }
        PRAInput^[I * X + J] := StrToFloat(S);
        {  Остаток строки  }
        S := '';
      end
      {  Если нет  }
      else begin
        {  Дайте мне это число  }
        SD := Copy(S, 1, K - 1);
        {  Это чтобы StrToFloat понял  }
        if not(SD[1] in ['-', '+']) then SD := '+' + SD;
        SD[Pos('.', SD)] := ',';
        {  Преобразуем  }
        PRAInput^[I * X + J] := StrToFloat(SD);
        {  Остаток строки  }
        S := Copy(S, K + 1, Length(S));
        {  Счетчик чисел в строке  }
        Inc(J);
      end;
    end;
  end;
  Size_x := X;
  Size_Y := Y;
  {  Закрываем файл  }
  System.Close(F);
end;

{  Загрузка различных палитр  }

type
  TPaletteEntryArray = array [0..255] of TPaletteEntry;

function CreateBWPalette  : HPalette;
var
  I : Integer;
  Pal : PLogPalette;
  ColorTable : ^TPaletteEntryArray;
begin
  {  Выделяем память под палитру  }
  GetMem(Pal, SizeOf(TLogPalette) + (256 - 1)*SizeOf(TPaletteEntry));
  {  Создаем палитру  }
  Pal^.palVersion := $300;
  Pal^.palNumEntries := 256;
  ColorTable := Addr(Pal^.palPalEntry[0]);
  for I := 0 to 255 do begin
    ColorTable^[I].peRed := I;
    ColorTable^[I].peGreen := I;
    ColorTable^[I].peBlue := I;
    ColorTable^[I].peFlags := 0;
  end;
  {  Регистрируем палитру  }
  CreateBWPalette := CreatePalette(Pal^);
  {  Освобождаем память  }
  FreeMem(Pal, SizeOf(TLogPalette) + (256 - 1)*SizeOf(TPaletteEntry));
end;

// переводим битмап в массив дествительных чисел по коэффициентам
procedure MatrixBitmap2Real(XSize, YSize : Integer;
                            var P : TRealArray;
                            var Bitmap : TBitmap;
                            BZ, KZ : TReal);
var
  I, J, R, G, B : Integer;
  PBmp : PByteArray;
begin
  // Формируем массив дествительных чисел
  for I := 0 to YSize - 1 do begin
    PBmp := Bitmap.ScanLine[I];
    for J := 0 to XSize - 1 do
      // В зависимости от типа битовой карты
      case Bitmap.PixelFormat of
        pf1bit : P[I*XSize + J] := PBmp^[J div 8]*KZ + BZ;
        pf4bit : P[I*XSize + J] := PBmp^[J div 2]*KZ + BZ;
        pf8bit : P[I*XSize + J] := PBmp^[J]*KZ + BZ;
        pf24bit : begin
                    R := PBmp^[J*3 + 0] * 30;
                    G := PBmp^[J*3 + 1] * 59;
                    B := PBmp^[J*3 + 2] * 11;
                    P[I*XSize + J] := (R + G + B) /100 * KZ + BZ;
                  end;
        pf32bit : begin
                    R := PBmp^[J*4 + 1] * 30;
                    G := PBmp^[J*4 + 2] * 59;
                    B := PBmp^[J*4 + 3] * 11;
                    P[I*XSize + J] := (R + G + B) / 100 * KZ + BZ;
                  end;
      end;
  end;
end;

// нормируем массив реальных чисел в битмап
procedure MatrixReal2Bitmap(XSize, YSize : Integer;
                            var P : TRealArray;
                            var B : TBitmap;
                            IsLn : Boolean;
                            Porog : Integer);
var
  I, J : Integer;
  PMax, PMin : TReal;
  PBmp : PByteArray;
begin
  // Ищем максимум и минимум
  FindMaxMinRealArray(XSize, YSize, P, PMax, PMin);
  // Формируем отнормированный битмап
  B := TBitmap.Create;
  B.Height := YSize;
  B.Width := XSize;
  B.PixelFormat := pf8bit;
  B.Palette := CreateBWPalette;
  if PMax - PMin <> 0 then
    for I := 0 to YSize - 1 do begin
      PBmp := B.ScanLine[I];
      for J := 0 to XSize - 1 do begin
        // Логарифмическая нормировка
        if IsLn then PBmp^[J] := Round((Ln(P[I * XSize + J] + 1) - Ln(PMin + 1))/
                                       (Ln(PMax + 1) - Ln(PMin + 1)) * 255)
        // Обычная
        else PBmp^[J] := Round((P[I * XSize + J] - PMin) / (PMax - PMin) * 255);
        // И по порогу
        if PBmp^[J] > Porog then PBmp^[J] := 255;
      end;
    end;
end;

{
  Описание : грузим массив дествительных чисел из bmp файла
  Вход     : FileName - имя файла с расширением!!!
  Выход    : size_x, size_y - размер матрицы
             P - матрица (указатель на адрес области памяти!!!)
             массив создается в функции
  Источник : Трофимов А. Н.
}
function LoadBmpAsRealMatrix(FileName : string;
                             var P : PRealArray;
                             var size_x, size_y : Integer) : Integer; cdecl;
var
  B : TBitmap;
begin
  B := TBitmap.Create;
  B.LoadFromFile(FileName);
  GetMem(P, B.Width*B.Height*SizeOf(TReal));
  MatrixBitmap2Real(B.Width, B.Height, P^, B, 0, 1);
  Size_x := B.Width;
  Size_Y := B.Height;
  B.Free;
end;

{
  Описание : выводим массив дествительных чисел в bmp файл
  Вход     : size_x, size_y - размер матрицы
             x_vid_min, x_vid_max, y_vid_min, y_vid_max - выводимая часть
             PRAInput - матрица (указатель на область памяти)
             FileName - имя файла с расширением!!!
  Выход    : нет
  Источник : Трофимов А. Н.
}
function SaveMatrixRealAsBmp(XSize, YSize : Integer;
                             x_vid_min, x_vid_max, y_vid_min, y_vid_max : INteger;
                             var P : TRealArray;
                             FileName : string) : Integer; cdecl;
var
  B : TBitmap;
  PNew : PRealArray;
  I, J : Integer;
begin
  // создаем матрицу меньшего размера с выводимой областью
  GetMem(PNew, (x_vid_max - x_vid_min + 1) *
               (y_vid_max - y_vid_min + 1) * SizeOf(TReal));
  for I := y_vid_min to y_vid_max do
    for J := x_vid_min to x_vid_max do
      PNew^[I * (x_vid_max - x_vid_min + 1) + J] := P[I * Xsize + J];
  MatrixReal2Bitmap((x_vid_max - x_vid_min + 1), (y_vid_max - y_vid_min + 1),
                    PNew^, B, False, 255);
  B.SaveToFile(FileName);
  B.Free;
  FreeMem(PNew, (x_vid_max - x_vid_min + 1) *
               (y_vid_max - y_vid_min + 1) * SizeOf(TReal));
end;

{
  Описание : выводим массив дествительных чисел в Jpg файл
  Вход     : size_x, size_y - размер матрицы
             x_vid_min, x_vid_max, y_vid_min, y_vid_max - выводимая часть
             PRAInput - матрица (указатель на область памяти)
             FileName - имя файла с расширением!!!
  Выход    : нет
  Источник : Трофимов А. Н.
}
function SaveMatrixRealAsJpg(XSize, YSize : Integer;
                             x_vid_min, x_vid_max, y_vid_min, y_vid_max : INteger;
                             var P : TRealArray;
                             FileName : string) : Integer; cdecl;
var
  Jp : TJpegImage;
  B : TBitmap;
  PNew : PRealArray;
  I, J : Integer;
begin
  {  Создаем Jpeg  }
  Jp := TJpegImage.Create;
  {  Создаем битмап  }
  // создаем матрицу меньшего размера с выводимой областью
  GetMem(PNew, (x_vid_max - x_vid_min + 1) *
               (y_vid_max - y_vid_min + 1) * SizeOf(TReal));
  for I := y_vid_min to y_vid_max do
    for J := x_vid_min to x_vid_max do
      PNew^[I * (x_vid_max - x_vid_min + 1) + J] := P[I * Xsize + J];
  MatrixReal2Bitmap((x_vid_max - x_vid_min + 1), (y_vid_max - y_vid_min + 1),
                    PNew^, B, False, 255);
  {  Передаем битмап в Jpeg  }
  Jp.Assign(B);
  Jp.CompressionQuality := 80;
  {  Пусть сам себя записывает  }
  Jp.SaveToFile(FileName);
  {  Освобождаем битмап и Jpeg  }
  B.Free;
  Jp.Free;
  FreeMem(PNew, (x_vid_max - x_vid_min + 1) *
               (y_vid_max - y_vid_min + 1) * SizeOf(TReal));
end;

{
  Описание : грузим массив дествительных чисел из jpg файла
  Вход     : FileName - имя файла с расширением!!!
  Выход    : size_x, size_y - размер матрицы
             P - матрица (указатель на адрес области памяти!!!)
             массив создается в функции
  Источник : Трофимов А. Н.
}
function LoadJpgAsRealMatrix(FileName : string;
                             var P : PRealArray;
                             var size_x, size_y : Integer) : Integer; cdecl;
var
  Jp : TJpegImage;
  B : TBitmap;
begin
  {  Создаем Jpeg  }
  Jp := TJpegImage.Create;
  {  Грузим его из файла  }
  Jp.LoadFromFile(FileName);
  {  Создаем битмап  }
  B := TBitmap.Create;
  {  Передаем Jpeg в битмап  }
  B.Assign(Jp);
  {  Грузим битмап в свой объект  }
  GetMem(P, B.Width*B.Height*SizeOf(TReal));
  MatrixBitmap2Real(B.Width, B.Height, P^, B, 0, 1);
  Size_x := B.Width;
  Size_Y := B.Height;
  {  Освобождаем битмап и Jpeg  }
  B.Free;
  Jp.Free;
end;

type
  {  Заголовок Img файла длиной 64 байта  }
  TIMGHeader = record
    SignS : INteger;          {  Признак файла *.IMG = IM#0#0             }
    LenX,                     {  Горизонтальная и                         }
    LenY : SmallINt;          {  вертикальная размерность изображения     }
    C : Single;               {  Коэффициент пересчета яркостей пикселов  }
                              {   в величины результатов для объекта :    }
                              {   F(x,y) = C * (IMG(x,y) - BaseBright)    }
    MagnifyNum,               {  Сколько раз изображение было x2          }
    IMGType : Byte;           {  Признак того, что в изображении записаны }
                              {   томографические проекции                }
    Reserved : SmallInt;      {  Не используется                          }
    Scr2Obj : record          {  Данные для пересчета массива в объект    }
      IsIs : Byte;            {  Признак задания координат объекта        }
      X,Y : record            {  Коэффициенты пересчета :                 }
        C : Single;           {  ObjX=(ScrX-Scr2Obj.X.Base)*Scr2Obj.X.C   }
        Base : SmallInt;
      end;
    end;
    Name : string[25];        {  Имя изображения                          }
    SizeName : string[6];     {  Имя размерности измеренной величины      }
    Base : SmallINt;          {  Нулевой уровень яркости пиксела          }
  end;

{
  Описание : грузим массив дествительных чисел из img файла
  Вход     : FileName - имя файла с расширением!!!
  Выход    : size_x, size_y - размер матрицы
             P - матрица (указатель на адрес области памяти!!!)
             массив создается в функции
  Источник : Трофимов А. Н.
}
function LoadImgAsRealMatrix(FileName : string;
                             var P : PRealArray;
                             var size_x, size_y : Integer) : Integer; cdecl;
var
  F : file;
  H : TImgHeader;
  I, J : Integer;
  PTemp : PByteArray;
  Max, Min : TReal;
begin
  {  Связываем имя с файлом  }
  System.Assign(F, FileName);
  {  Открываем файл  }
  System.Reset(F, 1);
  if System.IOResult <> 0 then Exit;
  {  Считываем заголовок  }
  System.BlockRead(F, H, 64);
  if H.SignS <> 19785 then Exit;
  Size_x := H.LenX;
  Size_y := H.LenY;
  GetMem(PTemp, Size_x * Size_Y);
  GetMem(P, Size_x * Size_Y * SizeOf(TReal));
  BlockRead(F, PTemp^, Size_x * Size_Y);
  {  Записываем в память  }
  for I := 0 to H.LenY - 1 do
    for J := 0 to H.LenX - 1 do
      P^[I * Size_X + J] := H.C * (Integer(PTemp^[I * Size_X + J]) - H.Base);
  {  Ищем максимум и минимум  }
  FindMaxMinRealArray(Size_X, Size_Y, P^, Max, Min);
   {  Закрываем файл  }
  System.Close(F);
  FreeMem(PTemp, Size_x * Size_Y);
end;

{
  Описание : выводим массив дествительных чисел в Jpg файл
  Вход     : size_x, size_y - размер матрицы
             x_vid_min, x_vid_max, y_vid_min, y_vid_max - выводимая часть
             PRAInput - матрица (указатель на область памяти)
             FileName - имя файла с расширением!!!
  Выход    : нет
  Источник : Трофимов А. Н.
}
function SaveMatrixRealAsImg(XSize, YSize : Integer;
                             x_vid_min, x_vid_max, y_vid_min, y_vid_max : INteger;
                             var P : TRealArray;
                             FileName : string) : Integer; cdecl;
var
  F : file;
  I, J : Integer;
  H : TImgHeader;
  PNew : PByteArray;
  Max, Min : TReal;
begin
  {  Связываем имя с файлом  }
  System.Assign(F, FileName);
  {  Открываем файл  }
  System.ReWrite(F, 1);
  if System.IOResult <> 0 then Exit;
  {  Ищем максимум и минимум  }
  FindMaxMinRealArray(XSize, YSize, P, Max, Min);
  {  Всяческая инициализация  }
  H.LenX := 0;
  H.LenY := 0;
  H.SignS := 19785;
  H.C := 1;
  H.MagnifyNum := 1;
  H.Scr2Obj.IsIs := 1;
  H.Scr2Obj.X.C := 1;
  H.Scr2Obj.X.Base := 0;
  H.Scr2Obj.Y.C := 1;
  H.Scr2Obj.Y.Base := 0;
  H.Base := 0;
  H.LenX := (x_vid_max - x_vid_min + 1);
  H.LenY := (y_vid_max - y_vid_min + 1);
  if Max <> Min then begin
    H.C := (Max - Min) / 255;
    H.Base := Round(- Min * 255 / (Max - Min));
  end;
  {  Записываем заголовок  }
  System.BlockWrite(F, H, 64);
  // создаем матрицу меньшего размера с выводимой областью
  GetMem(PNew, (x_vid_max - x_vid_min + 1) *
               (y_vid_max - y_vid_min + 1));
  for I := y_vid_min to y_vid_max do
    for J := x_vid_min to x_vid_max do
      PNew^[I * (x_vid_max - x_vid_min + 1) + J] := Round(P[I * Xsize + J] / H.C +
                                                    H.Base);
  {  Записываем в файл  }
  System.BlockWrite(F, PNew^, (x_vid_max - x_vid_min + 1) *
                   (y_vid_max - y_vid_min + 1));
  {  Закрываем файл  }
  System.Close(F);
  FreeMem(PNew, (x_vid_max - x_vid_min + 1) *
               (y_vid_max - y_vid_min + 1));
end;

{
  Описание : выводим массив дествительных чисел в Asc файл
  Вход     : size_x, size_y - размер матрицы
             x_vid_min, x_vid_max, y_vid_min, y_vid_max - выводимая часть
             PRAInput - матрица (указатель на область памяти)
             FileName - имя файла с расширением!!!
  Выход    : нет
  Источник : Трофимов А. Н.
}
function SaveMatrixRealAsAsc(XSize, YSize : Integer;
                             xmin, xmax, ymin, ymax : INteger;
                             var P : TRealArray;
                             FileName : string) : Integer; cdecl;
var
  F : Text;
  NNumber, I, J, K : Integer;
begin
  {  Связываем имя с файлом  }
  System.Assign(F, FileName);
  {  Открываем файл  }
  System.ReWrite(F);
  if System.IOResult <> 0 then Exit;
  {  Выводить будем по 16 чисел в строке  }
  NNumber := 16;
  XMin := XMin div NNumber;
  XMax := XMax div NNumber;
  {  Выводим  }
  for I := YMin to YMax do begin
    {  Выводим  NNumber чисел  }
    for J := XMin to XMax do begin
      {  Координаты  }
      Write(F, 'Y=', I, ',X=', (J * NNumber):3, '    ');
      {  Числа  }
      for K := 0 to NNumber - 1 do
        if (J * NNumber + K > XSize - 1) or
           (P[I * XSize + J * NNumber + K] = 0) then Write(F, '. ')
        else Write(F, P[I * XSize + J * NNumber + K]:8, ' ');
      {  На следующую строку  }
      WriteLn(F);
    end;
    {  Пустая строка перед следующей строкой массива  }
    if I < YMax then WriteLn(F);
  end;
  {  Закрываем файл  }
  System.Close(F);
end;

procedure RASaveMaskAsc2(iW, iH : Integer;
                         var raIn, raMask : TRealArray;
                         sFileName : AnsiString);
var
  fOut : TextFile;
  iX, iY : Integer;
begin
  {  Связываем имя с файлом  }
  AssignFile(fOut, sFileName);
  {  Открываем файл  }
  System.ReWrite(fOut);
  if System.IOResult = 0 then begin
    {  Выводим  }
    for iY := 0 to iH - 1 do
      for iX := 0 to iW - 1 do
        if raMask[iY * iW + iX] = 1 then WriteLn(fOut, iX, ' ', iY, ' ',
          raIn[iY * iW + iX]:8:5);
    {  Закрываем файл  }
    System.Close(fOut);
  end;
end;

procedure RASaveAscWMask(iW, iH : Integer;
                         var raIn: TRealArray;
                         var raMask: TBtArr;
                         sFileName : AnsiString;
                         rA: TReal); overload;

var
  fOut : TextFile;
  iX, iY : Integer;
  rNum : Double;
begin
  {  Связываем имя с файлом  }
  AssignFile(fOut, sFileName);
  {  Открываем файл  }
  System.ReWrite(fOut);
  if System.IOResult = 0 then begin
    {  Выводим  }
    WriteLn(fOut, 'VNIIOFI ', rA:10:7);
    for iY := 0 to iH - 1 do
      for iX := 0 to iW - 1 do begin
        if raMask[iY * iW + iX] = 1 then
          rNum := raIn[iY * iW + iX]
        else
          rNum := -MaxDouble;
        WriteLn(fOut, iX, ' ', iY, ' ', rNum:8:5);
      end;
    {  Закрываем файл  }
    System.Close(fOut);
  end;
end;


procedure RASaveAscWMask(iW, iH : Integer;
                         var raIn, raMask : TRealArray;
                         sFileName : AnsiString;
                         rA: TReal);
var
  fOut : TextFile;
  iX, iY : Integer;
  rNum : Double;
begin
  {  Связываем имя с файлом  }
  AssignFile(fOut, sFileName);
  {  Открываем файл  }
  System.ReWrite(fOut);
  if System.IOResult = 0 then begin
    {  Выводим  }
    WriteLn(fOut, 'VNIIOFI ', rA:10:7);
    for iY := 0 to iH - 1 do
      for iX := 0 to iW - 1 do begin
        if raMask[iY * iW + iX] = 1 then
          rNum := raIn[iY * iW + iX]
        else
          rNum := -MaxDouble;
        WriteLn(fOut, iX, ' ', iY, ' ', rNum:8:5);
      end;
    {  Закрываем файл  }
    System.Close(fOut);
  end;
end;

procedure RASaveAsc(iW, iH : Integer;
                    var raIn : TRealArray;
                    sFileName : AnsiString);
var
  fOut : TextFile;
  iX, iY : Integer;
  rNum : Treal;
begin
  {  Связываем имя с файлом  }
  AssignFile(fOut, sFileName);
  {  Открываем файл  }
  System.ReWrite(fOut);
  if System.IOResult = 0 then begin
    {  Выводим  }
    for iY := 0 to iH - 1 do
      for iX := 0 to iW - 1 do begin
        rNum := raIn[iY * iW + iX];
        WriteLn(fOut, iX, ' ', iY, ' ', rNum:8:5);
      end;
    {  Закрываем файл  }
    System.Close(fOut);
  end;
end;


{
  Описание : грузим массив дествительных чисел из asc файла
  Вход     : FileName - имя файла с расширением!!!
  Выход    : size_x, size_y - размер матрицы
             P - матрица (указатель на адрес области памяти!!!)
             массив создается в функции
  Источник : Трофимов А. Н.
}
function LoadAscAsRealMatrix(FileName : string;
                             var P : PRealArray;
                             var size_x, size_y : Integer) : Integer; cdecl;

procedure GetBlock(var FIn : Text;
                   PDA1 : Pointer;
                   var XMin, XMax, YNum : Integer);
var
  PDA : PRealArray absolute PDA1;
  S, SD : AnsiString;
  I, K : Integer;
begin
  {  Пропускаем пустые строки  }
  repeat ReadLn(FIn, S); until S <> '';
  {  Номер строки и Х  }
  K := Pos(',', S);
  YNum := StrToInt(Copy(S, 3, K - 3));
  SD := Copy(S, K + 3, 6);
  DelSpBar(SD);
  XMin := StrToInt(SD);
  XMax := XMin;
  I := 0;
  {  До следующей пустой строки - блок  }
  repeat
    {  Координаты в болото  }
    S := Copy(S, 16, Length(S));
    {  Удаляем ВСЕ пробелы  }
    DelSpBar(S);
    {  Пока строка не кончится  }
    while S <> '' do begin
      {  Где тут у нас кончается число  }
      K := Pos(' ', S);
      if K = 0 then K := Length(S) else Dec(K);
      {  Вот гады - вместо числа точку подсунули  }
      if Copy(S, 1, K) = '.' then PDA^[I + XMin] := 0
      {  Нормальное число  }
      else begin
        {  Дайте мне это число  }
        SD := Copy(S, 1, K);
        {  Это чтобы StrToFloat понял  }
        if not(SD[1] in ['-', '+']) then SD := '+' + SD;
        SD[Pos('.', SD)] := ',';
        {  Преобразуем  }
        PDA^[I + XMin] := StrToFloat(SD);
      end;
      {  Получаем остаток строки  }
      S := Copy(S, K + 2, Length(S));
      {  Счетчик чисел  }
      Inc(I);
    end;
    {  Если можно - то следующую строку из файла  }
    if not(EoF(FIn)) then ReadLn(FIn, S);
  until S = '';
  {  Позиция последнего числа  }
  Inc(XMax, I - 1);
end;

var
  FIn : Text;
  X, XMin, XMax, Y, YNum, I, J : Integer;
  PDA, TempPR : PRealArray;
  PPA : PPointerArray;
  S, SD : AnsiString;

begin
  {  Связываем имя с файлом  }
  System.Assign(FIn, FileName);
  {  Открываем файл  }
  System.Reset(FIn);
  if System.IOResult <> 0 then Exit;
  {  Определяем размер файла  }
  X := 0;
  Y := 0;
  {  Прогоняем весь файл  }
  while not(EoF(FIn)) do begin
    repeat ReadLn(FIn, S); until (S <> '') or EoF(FIn);
    if S <> '' then begin
      J := Pos(',', S);
      Y := StrToInt(Copy(S, 3, J - 3));
      SD := Copy(S, J + 3, 6);
      DelSpBar(SD);
      I := StrToInt(SD);
      if I > X then X := I;
    end;
  end;
  Inc(Y);
  {  Определяем размер последней строки  }
  S := Copy(S, 16, Length(S));
  DelSpBar(S);
  I := 0;
  while S <> '' do begin
    J := Pos(' ', S);
    if J = 0 then J := Length(S) else Dec(J);
    S := Copy(S, J + 2, Length(S));
    Inc(I);
  end;
  Inc(X, I);
  {  Закрываем файл  }
  System.Close(FIn);
  {  Связываем имя с файлом  }
  System.Assign(FIn, FileName);
  {  Открываем файл  }
  System.Reset(FIn);
  {  Выделяем память  }
  GetMem(PDA, X*SizeOf(TReal));
  GetMem(P, X*Y*SizeOf(TReal));
  Size_x := X;
  Size_Y := Y;
  {  Наконец-то считываем данные  }
  while not(EoF(FIn)) do begin
    {  Блок из ASC файла - часть строки массива  }
    GetBlock(FIn, PDA, XMin, XMax, YNum);
    for I := XMin to XMax do P^[YNum * X + I] := PDA^[I];
  end;
  {  Освобождаем память  }
  FreeMem(PDA, X*SizeOf(TReal));
  {  Закрываем файл  }
  System.Close(FIn);
end;

procedure S2Up(var S : Ansistring);
  var
    I : Byte;
  begin
    for I := 1 to Length(S) do begin
      if (S[I] >= 'р') and (S[I] <= 'я') then S[I] := AnsiChar(Byte(S[I]) - 80);
      if (S[I] >= 'а') and (S[I] <= 'п') then S[I] := AnsiChar(Byte(S[I]) - 32);
      if (S[I] >= 'a') and (S[I] <= 'z') then S[I] := AnsiChar(223 and Byte(S[I]));
    end
  end;

function LoadRealMatrix(FileName : string;
                        var P : PRealArray;
                        var size_x, size_y : Integer) : Integer; cdecl;
var
  FNameExt : AnsiString;
begin
  FNameExt := Copy(FileName, Length(FileName) - 2 , 3);
  S2Up(FNameExt);
  if FNameExt = 'BMP' then LoadBmpAsRealMatrix(FileName, P, size_x, size_y);
  if FNameExt = 'IMG' then LoadImgAsRealMatrix(FileName, P, size_x, size_y);
  if FNameExt = 'JPG' then LoadJpgAsRealMatrix(FileName, P, size_x, size_y);
  if FNameExt = 'PRN' then LoadPrnAsRealMatrix2(FileName, P, size_x, size_y);
  if FNameExt = 'ASC' then LoadAscAsRealMatrix(FileName, P, size_x, size_y);
  if FNameExt = 'BIN' then LoadBinAsRealMatrix(FileName, P, size_x, size_y);
end;

function SaveMatrixReal(XSize, YSize : Integer;
                        xmin, xmax, ymin, ymax : INteger;
                        var P : TRealArray;
                        FileName : string) : Integer; cdecl;
var
  FNameExt : AnsiString;
begin
  FNameExt := Copy(FileName, Length(FileName) - 2 , 3);
  S2Up(FNameExt);
  if FNameExt = 'BMP' then SaveMatrixRealAsBmp(XSIze, YSize,
                                               xmin, xmax, ymin, ymax, P,
                                               FileName);
  if FNameExt = 'IMG' then SaveMatrixRealAsImg(XSIze, YSize,
                                               xmin, xmax, ymin, ymax, P,
                                               FileName);
  if FNameExt = 'JPG' then SaveMatrixRealAsJpg(XSIze, YSize,
                                               xmin, xmax, ymin, ymax, P,
                                               FileName);
  if FNameExt = 'PRN' then SaveMatrixRealAsPrn(XSIze, YSize,
                                               xmin, xmax, ymin, ymax, P,
                                               FileName);
  if FNameExt = 'ASC' then SaveMatrixRealAsAsc(XSIze, YSize,
                                               xmin, xmax, ymin, ymax, P,
                                               FileName);
  if FNameExt = 'BIN' then SaveMatrixRealAsBin(XSIze, YSize,
                                               xmin, xmax, ymin, ymax, P,
                                               FileName);
  if FNameExt = 'BN2' then SaveMatrixRealAsBinByte(XSIze, YSize,
                                               xmin, xmax, ymin, ymax, P,
                                               FileName);
end;

end.
