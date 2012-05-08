unit UType;

interface

uses Windows, Types, math, Messages;

type
  // Тип - дествительное число
  TReal = Double;
  PReal = ^TReal;
  TBt = byte;
  Tfacet = packed record
            normal: array[0..2] of single;
            vertex: array[0..2,0..2] of single;
            attr: word;
          end;
  TRealPoint = record
                x: treal;
                y: treal;
              end;
  TCircleCoord = record
                   x, y, r: treal;
                 end;
  TDouble1DArray = array of double;

const
  // Максимальный размер массива дествительных чисел в байтах
  MaxRealArraySize = MaxInt div SizeOf(TReal);
  // Максимальный размер массива байт в байтах
  MaxByteArraySize = MaxInt div SizeOf(Byte);
  MaxIntegerArraySize = MaxInt div SizeOf(Integer);
  MaxSingleArraySize = MaxInt div SizeOf(Single);
  MaxWordArraySize = MaxInt div SizeOf(Word);
  MaxCircleCoordArraySize = MaxInt div sizeof(TCircleCoord);
  MaxTReal = MaxDouble;
  WM_CAPDONE=WM_APP+$1235;
  WM_NEWFRAME=WM_APP+$1236;

type
  TCircleCoordArray = array of TCircleCoord;
  _TCircleCoordArray = array[0..MaxCircleCoordArraySize-1] of TCircleCoord;
  PCircleCoordArray = ^_TCircleCoordArray;
  ST_ProgressPosFcn = function(percent: integer; pContext: pointer): integer;
  // Массив байт
  PByteArray = ^TByteArray;
  TByteArray = array [0..MaxByteArraySize - 1] of Byte;
  PWordArray = ^TWordArray;
  TWordArray = array[0..MaxWordArraySize-1] of Word;
  
  // Массив байт
  PIntegerArray = ^TIntegerArray;
  TIntegerArray = array [0..MaxIntegerArraySize - 1] of Integer;
  PIntegerArray1 = ^TIntegerArray1;
  TIntegerArray1 = array [1..MaxIntegerArraySize] of Integer;
  // Массив дествительных чисел
  PRealArray = ^TRealArray;
  TRealArray = array [0..MaxRealArraySize - 1] of TReal;
  PRealArray1 = ^TRealArray1;
  TRealArray1 = array [1..MaxRealArraySize] of TReal;
  PSingleArray = ^TSingleArray;
  TSingleArray = array [0..MaxSingleArraySize - 1] of Single;
  TBtArr = array[0..MaxByteArraySize - 1] of Tbt;
  PBtArr = ^TBtArr;
  TBtPointerArr = array[0..100] of PBtArr;
  PBtPointerArr = ^TBtPointerArr;
  TPointArray = array [0..(MaxIntegerArraySize div 2)-1] of TPoint;
  PPointArray = ^TPointArray;
  TRecParam = record
                ax, bx, ay, by, OriginX, OriginY, AmpTr: treal;
                MedW, GaussW, w, h, Rotate, Tracts, red1, red2, blue1, blue2, PhShiftSteps, VoscobW: integer;
                CutLines, spectrummax1, spectrummax2, spectrummax3, spectrummax4, NonLinear, Unwrap, Invert: boolean;
              end;
  TFacetArray = array[0..(MaxIntegerArraySize div sizeof(Tfacet))-1] of Tfacet;
  Pfacet= ^TFacetArray;
  TAnsiStringArray = array[0..(MaxIntegerArraySize div sizeof(AnsiString))-1] of AnsiString;
  PAnsiStringArray = ^TAnsiStringArray;

implementation

end.









