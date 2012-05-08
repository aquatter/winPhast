unit Crude;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Utype, math, ufiltr, ufft, ULinAlg, t666, giveio,
  ShlObj, ActiveX, directShow9, URATool;

const
  WM_CAPDONE=WM_APP+$1235;
  WM_NEWFRAME=WM_APP+$1236;
type
  TMatrix = array[0..2, 0..3] of TReal;
  TMatrixArray = array[0..(MaxIntegerArraySize div sizeof(TMatrix))-1] of TMatrix;
  PMatrixArray = ^TMatrixArray;
{  TBt = byte;
  TBtArr = array[0..MaxByteArraySize - 1] of Tbt;
  PBtArr = ^TBtArr; }
  TByteArray = array of array of byte;
  TPaletteEntryArray = array [0..255] of TPaletteEntry;
  TDoubleArray = array of array of double;
  TBoolArray = array of array of boolean;
  TIntArray = array of array of integer;
  TInt = array of integer;
  TPointerArray = array of PBtArr;
  TMyInfernalArray = array of TMyInfernalType;
  TPath = array of TPoint;
  TPathArray = array of TPath;
  TStaticObj=(soPoint, soLine, soCircle, soRect, soCross);
  TStaticObjArr = array of TStaticObj;
  TColorStaticObjArr = array of TColor;
  TVectDouble = record
    x0, y0, R: double;
  end;
  TVectInt = record
    x0, y0, R: integer;
  end;
  TRGBArray = array [0..0] of TRGBTriple;
  pRGBArray = ^TRGBArray;

  function CreateBWPalette : HPalette;
  function CreateSpectrPalette  : HPalette;
  procedure ReadFile(var d: TDoubleArray; filename: TfileName);
  procedure WriteFile(var p: TRealArray; height, width: word); overload;
  procedure WriteFile(var p: TBoolArray); overload;
  procedure PaintImage(p: TDoubleArray; mask: TBoolArray; bitmap: TBitmap; canvas: TCanvas);
 // procedure InitBitmap(var bitmap: TBitmap);
  procedure FindMinMax(var min, max: double; p: TDoubleArray; mask: TBoolArray);  overload;
  procedure FindMinMax(var min, max: treal; p, mask: TMyInfernalType);  overload;
  procedure Paint_Img(var p: TIntArray; bitmap: TBitmap; image: TImage); overload;
  procedure Paint_Img(var p: TDoubleArray; bitmap: TBitmap; image: TImage); overload;
  procedure Paint_Img(var p: TBoolArray; bitmap: TBitmap; image: TImage); overload;
  procedure Paint_Img(var p: TRealArray; bitmap: TBitmap; image: TImage; width, height: word); overload;
  procedure Paint_Img(var p, mask: TRealArray; bitmap: TBitmap; image: TImage; width, height: word); overload;
  procedure Paint_Img(var p: TRealArray; var  mask: TBoolArray; bitmap: TBitmap; image: TImage; width, height: word); overload;
  procedure Paint_Img(var p: TDoubleArray; var  mask: TBoolArray; bitmap: TBitmap; image: TImage); overload;
  procedure Paint_Img(var p: TRealArray; var  mask: TBoolArray; bitmap: TBitmap; image: TImage; xmin, ymin, xmax, ymax, width, height, color: word); overload;
  procedure Create_Bmp(var p: TRealArray; var  mask: TBoolArray; bitmap: TBitmap; min, max: Double; xmin, ymin, xmax, ymax, xc, yc, color: word); overload;
  procedure SubsMasks(var mask1, mask2: TRealArray; width, height: Integer);
  procedure AddMasks(var mask1, mask2: TRealArray; width, height: Integer);
  procedure AndMasks(var mask1, mask2: TBtArr; width, height: Integer);
  procedure FindMin_Max(var min, max: TReal; var p: TRealArray; var mask: TBtArr; width, height: word); overload;
  procedure FindMin_Max(var min, max: TReal; var p, mask: TBtArr; width, height: word); overload;
  procedure FindMin_Max(var min, max: integer; var  p: TIntArray); overload;
  procedure FindMin_Max(var min, max: double; var p: TDoubleArray); overload;
  procedure FindMin_Max(var min, max: TReal; var p: TRealArray; width, height: word); overload;
  procedure FindMin_Max(var min, max: TReal; var p, mask: TRealArray; width, height: word); overload;
  procedure FindMin_Max(var min, max: TReal; var p: TRealArray; var mask: TBoolArray; width, height: word); overload;
  procedure FindMin_Max(var min, max: double; var p: TDoubleArray; var mask: TBoolArray); overload;
  procedure FindMin_Max(var min, max: TReal; var p: TRealArray; var mask: TBoolArray; width, height: word; var pmax, pmin: TPoint); overload;
  procedure FindMin_Max(var min, max: TReal; var p: TBtArr; w, h: integer); overload;
  procedure Read_Data(var p: TBoolArray; bitmap: TBitmap);
  procedure ConvertPointer2DynamicArray(var input: TRealArray; var output: TDoubleArray; Height, Width: integer);
  procedure ConvertDynamic2PointerArray(var input: TDoubleArray; var output: TRealArray; Height, Width: integer); overload;
  procedure ConvertDynamic2PointerArray(var input: TBoolArray; var output: TRealArray; Height, Width: integer); overload;
  procedure ReadBitmapFiles(var p: TPointerArray; steps, channel, cadr: integer; EnableFilter: boolean); overload;
  procedure ReadBitmapFiles(var p: TPointerArray; steps, channel, seq: integer); overload;
  procedure CreateTRealMask(var p: TRealArray; var b1, b2: TBoolArray);
  procedure CreateBoolMask(var b: TBoolArray; x,y,r: Double);
  procedure GaussSolve(var arr: TDoubleArray);
  procedure SolveSystem3x4(var a: TMatrix; var k2, k3: treal); overload;
  procedure SolveSystem3x4(var a: TMatrix; var k1, k2, k3: treal); overload;
  procedure TiltRemove(var p: TRealArray; var mask_define, mask_remove: TBtArr; height, width: word); overload;
  procedure TiltRemove(var p: TRealArray; var mask_define, mask_remove: TBtArr; height, width: word; var a, b, c: treal); overload;
  procedure TiltRemove(var p: TRealArray; var mask_define, mask_remove: TBoolArray; height, width: word); overload;
  procedure TiltRemove(var p, mask_define, mask_remove: TRealArray; height, width: word); overload;
  procedure TiltRemove(var p: TDoubleArray; var mask_define, mask_remove: TBoolArray; height, width: word); overload;
  procedure TiltRemove(var p: TDoubleArray; var mask_define, mask_remove: TBoolArray; height, width: word; var a, b, c: treal); overload;
  procedure TiltRemove(var p: TDoubleArray; var mask: TBoolArray); overload;
  procedure TiltRemove(var p, b: TMyInfernalType; var _a, _b, _c: treal); overload;

  procedure InvertMask(var b: TBoolArray); overload;
  procedure InvertMask(var p: TRealArray; m, n: integer);  overload;
  procedure InvertMask(var p: TBtArr; m, n: integer);  overload;
  procedure AreaBounds(var b: TBoolArray; var minx, miny, maxx, maxy: integer); overload;
  procedure AreaBounds(var b: TBtArr; width, height: integer; var minx, miny, maxx, maxy: integer); overload;
  procedure AreaBounds(var p: TRealArray; width, height: integer; var minx, miny, maxx, maxy: integer); overload;
  procedure DrawCirc(x0, y0, r: double; image: TImage; color: TColor);
  procedure DrawCross(x0, y0, d: double; image: TImage; color: TColor);
  function RMS(var p: TRealArray; var b: TBoolArray; height, width: word): treal; overload;
  function RMS(var p, mask: TRealArray; height, width: word): treal; overload;
  function RMS(var p, mask: TMyInfernalType): treal; overload;
  function average(var p: TRealArray; var b: TBoolArray; height, width: word): TReal; overload;
  function average(var p: TRealArray; height, width: word): TReal; overload;
  procedure CreateBin(var p, b: TMyInfernalType; ScaleX, ScaleY: treal; name: string); overload;
  procedure CreateBin(var p: TRealArray; var b: TBoolArray; multiple: Double; minx, miny, maxx, maxy, width, height: integer; name: string); overload;
  procedure CreateBin(var p, b: TRealArray; multiple: Double; minx, miny, maxx, maxy, width, height: integer; name: string); overload;
  procedure CreateBin(var b: TBoolArray; name: string); overload;
  procedure CreateBin(var p: TMyInfernalType; name: string); overload;
  procedure CreateBin(var p, b: TMyInfernalType; name: string); overload;
  procedure CreateBin(var p, b: TMyInfernalType; Rotate: integer; name: string); overload;
  procedure CreateBin(var p, b: TMyInfernalType; ScaleX, ScaleY: treal; Rotate: integer; name: string); overload;
  procedure CreateBmp(var p: TMyInfernalType; scale: boolean; name: string); overload;
  procedure CreateBmp(var p, mask: TMyInfernalType; scale: boolean; name: string); overload;
  procedure CreateBmp(var p, mask: TMyInfernalType; scale: boolean; Rotate: integer; name: string); overload;
  procedure CreateBmp(w, h: integer; p: PBtArr; scale: boolean; name: string); overload;
  procedure CreateBmp(w, h: integer; p: PRealArray; scale: boolean; name: string); overload;
  procedure CreateBmp(w, h: integer; p: PBtArr; scale: boolean; Rotate: integer; name: string); overload;

  procedure CreateMaskBin(var p: TRealArray; minx, miny, maxx, maxy, width, height: integer; name: string); overload;
//  procedure CreateSMTCamBin(var p: TRealArray; var b: TBoolArray; multiple: Double; minx, miny, maxx, maxy, width, height: integer; name: string); overload;
//  procedure CreateSMTCamBin(var p: TDoubleArray; var b: TBoolArray; multiple: Double; minx, miny, maxx, maxy: integer; name: string); overload;
//  procedure CreateSMTCamBin(var p, b: TRealArray; multiple: Double; minx, miny, maxx, maxy, width, height: integer; name: string); overload;
  procedure CreateSMTCamBin(var p: TRealArray; width, height: integer; name: string); overload;
  procedure LoadBmp(var p: TMyInfernalType; name: string; _type: TVarType); overload;
  procedure LoadBmp(var p: TBtArr; w, h: integer; name: string); overload;
  procedure LoadBin(var p: TDoubleArray; var b: TBoolArray; name: string); overload;
  procedure SaveBin(var p: TDoubleArray; var b: TBoolArray; minx, maxx, miny, maxy: integer; name: string); overload;
  procedure SaveBin(var p: TRealArray; var b: TBtArr; minx, maxx, miny, maxy: integer; name: string; width, height: integer); overload;
  procedure SaveBin(var p, b: TMyInfernalType; name: string); overload;
  procedure LoadBin(p, b: PRealArray; width, height: integer; name: string); overload;
//  procedure LoadSMTCamBin(var p, b: PRealArray; var m, n: integer; name: string); overload;
//  procedure LoadSMTCamBin(var p: TDoubleArray; var b: TBoolArray; var m, n: integer; name: string); overload;
//  procedure LoadSMTCamBin(var p: PRealArray; var b: PBtArr; var m, n: integer; name: string); overload;
  procedure LoadMaskBin(p: PRealArray; width, height: integer; name: string); overload;
  procedure LoadBin(var b: TBoolArray; name: string); overload;
  procedure LoadBin(var p, b, int: TMyInfernalType; name: string); overload;
  procedure LoadBin(var p, b: TMyInfernalType; name: string); overload;
  procedure LoadBin(var p, b: TMyInfernalType; var ScaleX, ScaleY: treal; name: string); overload;
  procedure LoadBin(var p: TMyInfernalType; name: string); overload;
  procedure LoadBin(var p: TMyInfernalType; _type: TVarType; name: string); overload;

  procedure FringeRemove(var p: TRealArray; m, n, WinWidth: word);
  
  procedure Save2Pac(var p: TRealArray; minx, miny, maxx, maxy, width, height: integer; name: string);
  procedure SaveSlice(var p: TRealArray; var path: TPath; width: integer; name: string; n: integer = -1); overload;
  procedure SaveSlice(var p: TBtArr; var path: TPath; width: integer; name: string; n: integer = -1); overload;
  procedure SaveSlice(var p: TDoubleArray; var path: TPath; name: string; n: integer = -1); overload;
  procedure AddValue2TextFile(p: TReal; name: string; n: integer = -1);
  procedure MNK_Circle(var _x, _y: TMyInfernalType; var x, y, r: TReal);  overload;
  procedure MNK_Circle(var p: TBtArr; var x, y, r: TReal; width, height: Integer); overload;
  procedure MNK_Circle(var p: TRealArray; var x, y, r: TReal; width, height: Integer); overload;
  procedure MNK_Circle(var p: TBoolArray; var x, y, r: TReal; width, height: Integer); overload;
  procedure MNK_Sphere(var p, b: TRealArray; var x, y, z, r: TReal; c: TReal; width, height: Integer); overload;
  procedure MNK_Sphere(var p: TRealArray; var b: TBoolArray; var x, y, r: TReal; c: TReal; width, height: Integer); overload;
  procedure MNK_Sphere(var p: TDoubleArray; var b: TBoolArray; var x, y, z, r: TReal; c: TReal; width, height: Integer); overload;
  procedure MNK_Sphere(var p: TRealArray; var b: TBtArr; var x, y, z, r: TReal; c: TReal; width, height: Integer); overload;
  function CreateGreyPalette: HPALETTE;
  function CreateColorPalette: HPALETTE;
  procedure FindBadPnts(var p: TPointerArray; var mask: TRealArray; width, height, k: integer);
  procedure MedValve_Binar(var p: TMyInfernalType; order: integer); overload;
  procedure MedValve(var p, b: pRealArray; order, width, height: Integer);  overload;
  procedure MedValve(var p: pRealArray; b: TBoolArray; order, width, height: Integer); overload;
  procedure MedValve(var p: pRealArray; order, width, height: Integer); overload;
  procedure MedValve(var p: TBoolArray; order: Integer); overload;
  procedure ExtrValve(var p: TBoolArray; order: Integer);
  procedure LinearValve(var p: pRealArray; order, width, height: Integer); overload;
  procedure LinearValve(var p: pRealArray; var b: TBoolArray; order, width, height: Integer); overload;
  procedure FindPhase(var phase, mask: TMyInfernalType; var int: TPointerArray; order: integer); overload;
  procedure FindPhase(var phase, amp, mask: TMyInfernalType; var int: TPointerArray; order: integer); overload;
  procedure FindPhase(var phase, mask: TMyInfernalType; var int: TMyInfernalArray); overload;
  procedure FindPhaseApprox(var phase, mask, steps: TMyInfernalType; var int: TMyInfernalArray; invert: boolean; Nsteps: integer); overload;
  procedure FindPhaseApprox(var phase, amp, mask, steps: TMyInfernalType; var int: TPointerArray; Nsteps: integer); overload;

  procedure FindPhase(var output, mask: TRealArray; var int: TPointerArray; order, width, height: integer); overload;
  procedure FindPhase(var output: TDoubleArray; var mask: TBoolArray; var int: TPointerArray; order, width, height: integer); overload;
  procedure FindPhase(var output: TRealArray; var mask: TBtArr; var int: TPointerArray; order, width, height: integer); overload;
  procedure FindPhase5StepsOld(var output: TDoubleArray; var mask: TBoolArray; var int: TPointerArray; N, SizeX, SizeY: integer);
  procedure GaussFilter(var p: TMyInfernalType; filter_aper: integer); overload;
  procedure GaussFilter(var p: TDoubleArray; var b: TBoolArray; filter_aper, width, height: integer); overload;
  procedure GaussFilter(var p: TRealArray; var b: TBtArr; filter_aper, width, height: integer); overload;
//  procedure GaussFilter(var p, b: TBtArr; filter_aper, width, height: integer); overload;
  procedure GaussFilter(var p, b: TBtArr; order, w, h: integer); overload;
  procedure BilinInterp(var p: TMyInfernalType; var trace: PRealArray; var length: integer; x0, y0, x1, y1: integer); overload;
  procedure BilinInterp(var p, trace: TMyInfernalType; p1, p2: TPoint); overload;
  procedure BilinInterp(var p, b, trace, trace_mask: TMyInfernalType; p1, p2: TPoint); overload;

  procedure MakeHist(p, hist, x: PMyInfernalType; p1, p2: TPoint;  n: integer = 100);
  procedure FindMinMax(var min, max: TReal; var p: TMyInfernalType; p1, p2: TPoint); overload;
  procedure CopyT666(var Src, Dst: TMyInfernalType); overload;
  procedure MeanRms(var p, mask: TMyInfernalType; var mean, rms: treal);
  procedure SaveRealArray2Matlab(var p: TMyInfernalType; scale: treal; path: String);
  procedure MoveMirror(base, pos: word);
  function AdvSelectDirectory(const Caption: string; const Root: WideString;
   var Directory: string; EditBox: Boolean = False; ShowFiles: Boolean = False;
   AllowCreateDirs: Boolean = True): Boolean;
  procedure Find_Rz(var line: TMyInfernalType; var Ra, Rz, Rmax: treal); overload;
  procedure Find_Rz(var line, line_mask: TMyInfernalType; var Ra, Rz, Rmax: treal); overload;
  procedure PolyFit(var p, q: TMyInfernalType; order: byte);
  function PolyFit2(var x, y: TMyInfernalType; n: integer; x0: treal): treal;

  procedure CreateBii(var int1, int2, int3: TMyInfernalType; path: string); overload;
  procedure CreateBii(w, h: integer; int1, int2, int3: PBtArr; path: string); overload;
  procedure LoadBii(var int: TMyInfernalType; num: integer; path: string); overload;

  function CheckVidCapDev: integer;
  procedure Grad(var p: TMyInfernalType);
  procedure Errosion(var p: TMyInfernalType; order: byte); overload;
  procedure Dilatation(var p: TMyInfernalType; order: byte); overload;
  procedure Errosion(w, h: integer; var p: PBtArr; order: byte); overload;
  procedure MeanFiltr(var p, mask: TMyInfernalType; order: byte);
  procedure MeanFiltrMask(var p, mask, mask_out: TMyInfernalType; order: byte);
  procedure MinMaxMask(var p, mask: TMyInfernalType; order: byte; t: treal);
  procedure Obrabotka_Raznosti(var p, mask: TMyInfernalType; iter: byte; t: treal); overload;
  procedure Obrabotka_Raznosti(var p, mask: TMyInfernalType; iter: byte; t: treal; var mean: treal); overload;

  procedure MinMaxMask_temp(var p, mask, razn: TMyInfernalType; order: byte; t: treal);
  procedure LoadStl(var facet: Pfacet; var nFasets: integer; path: string);
  //  procedure LoadPac(var p: TRealArray; minx, miny, maxx, maxy, width, height: integer; name: string);
  procedure SetLedBright(adr: Word; b: byte);
  procedure Lapl_with_highcontrast(var p: TMyInfernalType); overload;
  procedure Lapl_with_highcontrast(p: PBtArr; w, h: integer); overload;
  procedure SecondDerivative(var p,b: TMyInfernalType);
  procedure ExperimentalShit(var p, b: TMyInfernalType); overload;
  procedure ExperimentalShit(p: PBtArr; w, h, width, height: integer); overload;
  procedure MedValve(var p: TMyInfernalType; width, height: Integer); overload;
  procedure MedValve(p: PBtArr; w, h, width, height: Integer); overload;
  procedure MedValve_mask(p: PBtArr; b: TMyInfernalType; w, h: integer); overload;
  procedure FilterSector(var fft, mask: TMyInfernalType; order, sector: boolean; r0, r2, r_main: treal);
  procedure GilbertFilter(var fft, mask: TMyInfernalType; order: boolean; _r1: integer; orient: boolean);
  procedure SimpleMask(var fft, mask: TMyInfernalType; order, orient: boolean; _r1: treal); overload;
  procedure SimpleMask(var fft, mask: TMyInfernalType; orient: integer; r0, r1: treal); overload;
  procedure SimpleMask(var fft, mask: TMyInfernalType; order, orient: boolean; _r1: treal; var maxp: tpoint); overload;

  procedure Red_Temp(var fft, mask: TMyInfernalType);
  function NuttallWin(x, x0, w: integer): treal; overload;
  function NuttallWin(x, x0, w: treal): treal; overload;
  procedure BilateralFilter(var p, mask: TMyInfernalType; Sr, Sd: treal; order: byte);
  procedure Distorsion(var p, mask: TMyInfernalType; _A, dx, D: treal; p0: TPoint);
  function DistorsionFunc(A, x: treal): treal;
  procedure Defocus(var p, mask: TMyInfernalType; D, dx: treal; p0: TPoint);
  procedure CreateAsc(var p, mask: TMyInfernalType; name: string);
  procedure Modify(var _in, _out1, _out2: TBtArr; h, w: integer);
  function CheckString(s: string): treal;


implementation

uses filters;

function AdvSelectDirectory(const Caption: string; const Root: WideString;
   var Directory: string; EditBox: Boolean = False; ShowFiles: Boolean = False;
   AllowCreateDirs: Boolean = True): Boolean;

   function SelectDirCB(Wnd: HWND; uMsg: UINT; lParam, lpData: lParam): Integer; stdcall;
   var
     PathName: array[0..MAX_PATH] of Char;
   begin
     case uMsg of
       BFFM_INITIALIZED: SendMessage(Wnd, BFFM_SETSELECTION, Ord(True), Integer(lpData));
       // include the following comment into your code if you want to react on the
      //event that is called when a new directory has been selected
      // binde den folgenden Kommentar in deinen Code ein, wenn du auf das Ereignis
      //reagieren willst, das aufgerufen wird, wenn ein neues Verzeichnis selektiert wurde
      {BFFM_SELCHANGED:
      begin
        SHGetPathFromIDList(PItemIDList(lParam), @PathName);
        // the directory "PathName" has been selected
        // das Verzeichnis "PathName" wurde selektiert
      end;}
     end;
     Result := 0;
   end;
var
   WindowList: Pointer;
   BrowseInfo: TBrowseInfo;
   Buffer: PChar;
   RootItemIDList, ItemIDList: PItemIDList;
   ShellMalloc: IMalloc;
   IDesktopFolder: IShellFolder;
   Eaten, Flags: LongWord;
const
  BIF_USENEWUI = $0040;
  BIF_NOCREATEDIRS = $0200;
begin
   Result := False;
   if not DirectoryExists(Directory) then
     Directory := '';
   FillChar(BrowseInfo, SizeOf(BrowseInfo), 0);
   if (ShGetMalloc(ShellMalloc) = S_OK) and (ShellMalloc <> nil) then
   begin
     Buffer := ShellMalloc.Alloc(MAX_PATH);
     try
       RootItemIDList := nil;
       if Root <> '' then
       begin
         SHGetDesktopFolder(IDesktopFolder);
         IDesktopFolder.ParseDisplayName(Application.Handle, nil,
           POleStr(Root), Eaten, RootItemIDList, Flags);
       end;
       OleInitialize(nil);
       with BrowseInfo do
       begin
         hwndOwner := Application.Handle;
         pidlRoot := RootItemIDList;
         pszDisplayName := Buffer;
         lpszTitle := PChar(Caption);
         // defines how the dialog will appear:
        ulFlags := BIF_RETURNONLYFSDIRS or BIF_USENEWUI or
           BIF_EDITBOX * Ord(EditBox) or BIF_BROWSEINCLUDEFILES * Ord(ShowFiles) or
           BIF_NOCREATEDIRS * Ord(not AllowCreateDirs);
         lpfn    := @SelectDirCB;
         if Directory <> '' then
           lParam := Integer(PChar(Directory));
       end;
       WindowList := DisableTaskWindows(0);
       try
         ItemIDList := ShBrowseForFolder(BrowseInfo);
       finally
         EnableTaskWindows(WindowList);
       end;
       Result := ItemIDList <> nil;
       if Result then
       begin
         ShGetPathFromIDList(ItemIDList, Buffer);
         ShellMalloc.Free(ItemIDList);
         Directory := Buffer;
       end;
     finally
       ShellMalloc.Free(Buffer);
     end;
   end;
end;



procedure MoveMirror(base, pos: word);
var
 d,c:Byte;

begin
 d:=0; c:=0;

 //формируем байт для вывода в порт данных
 d:=d or ((pos and ($01 shl 10)) shr 8); // 10bit -> 2bit
 d:=d or ((pos and ($01 shl 9)) shr 6);  // 9bit -> 3bit
 d:=d or ((pos and ($01 shl 8)) shr 4);  // 8bit -> 4bit
 d:=d or ((pos and ($01 shl 7)) shr 2);  // 7bit -> 5bit

 d:=d or ((pos and ($01 shl 6)) shl 1); // 6bit -> 7bit
 d:=d or ((pos and ($01 shl 5)) shl 1); // 5bit -> 6bit
 d:=d or ((pos and ($01 shl 2)) shr 2); // 2bit -> 0bit
 d:=d or ((pos and $01) shl 1);        // 0bit -> 1bit

 c:=InPort(base+2); //считываем значение контрольного регистра LPT-порта
 c:=c and $ff8; //очищаем три младших бита

 c:=c or ((not pos and ($01 shl 4)) shr 4); // 4bit -> 0bit (учитывая аппаратную инверсию)
 c:=c or ((not pos and ($01 shl 3)) shr 2); // 3bit -> 1bit (учитывая аппаратную инверсию)
 c:=c or ((pos and ($01 shl 1)) shl 1);  // 1bit -> 2bit

 c:=c or ($01 shl 3); //сбрасываем бит строба (учитывая аппаратную инверсию)

 OutPort(base,d);   //выводим d в регистр данных LPT-порта
 OutPort(base+2,c); //выводим c в контрольный регистр LPT-порта

 c:=c and not ($01 shl 3); //устанавливаем строб
 OutPort(base+2,c);

 Sleep(1); //пауза примерно 16мс

 c:=c or ($01 shl 3); //сбрасываем строб
 OutPort(base+2,c);
end;

procedure MakeHist(p, hist, x: PMyInfernalType; p1, p2: TPoint; n: integer = 100);
var i,j,m: integer;
    min, max, int: TReal;
begin
  hist^.Clear;
  x^.Clear;
  case p^._type of
    varByte:  begin
                hist^.Init(1, 256, varInteger);
                x^.Init(1, 256, varDouble);
                for i:=p1.y to p2.y do
                  for j:=p1.x to p2.x do
                    inc(hist^.c^[p^.b^[i*p^.w+j]]);
                for i:=0 to 255 do
                  x^.a^[i]:=i;

              end;
    varDouble: begin
                 FindMinMax(min, max, p^, p1, p2);
                 hist^.Init(1, n, varInteger);
                 x^.Init(1, n, varDouble);
                 int:=(max-min)/n;
                 for m:=1 to n do
                 begin
                   for i:=p1.y to p2.y do
                     for j:=p1.x to p2.x do
                       if (p^.a^[i*p^.w+j] >= (m-1)*int+min) and (p^.a^[i*p^.w+j] <= m*int+min) then
                         inc(hist^.c^[m-1]);
                   x^.a^[m-1]:=(2*m-1)*int/2+min;
                 end;
               end;
    varInteger: begin
                  FindMinMax(min, max, p^, p1, p2);
                  hist^.Init(1, n, varInteger);
                  x^.Init(1, n, varDouble);
                  int:=(max-min)/n;
                  for m:=1 to n do
                  begin
                    for i:=p1.y to p2.y do
                      for j:=p1.x to p2.x do
                        if (p^.c^[i*p^.w+j] >= (m-1)*int+min) and (p^.c^[i*p^.w+j] <= m*int+min) then
                          inc(hist^.c^[m-1]);
                    x^.a^[m-1]:=(2*m-1)*int/2+min;
                  end;
                end;
  end;
end;

procedure FindMinMax(var min, max: TReal; var p: TMyInfernalType; p1, p2: TPoint);
var i, j: integer;
begin
   min:=MaxInt; max:=-MaxInt;
   case p._type of
     varByte:  for i:=p1.y to p2.y do
                 for j:=p1.x to p2.x do
                 begin
                   if min > p.b^[i*p.w+j] then min:=p.b^[i*p.w+j];
                   if max < p.b^[i*p.w+j] then max:=p.b^[i*p.w+j];
                 end;
     varDouble:  for i:=p1.y to p2.y do
                   for j:=p1.x to p2.x do
                   begin
                     if min > p.a^[i*p.w+j] then min:=p.a^[i*p.w+j];
                     if max < p.a^[i*p.w+j] then max:=p.a^[i*p.w+j];
                   end;
     varInteger:  for i:=p1.y to p2.y do
                    for j:=p1.x to p2.x do
                    begin
                      if min > p.c^[i*p.w+j] then min:=p.c^[i*p.w+j];
                      if max < p.c^[i*p.w+j] then max:=p.c^[i*p.w+j];
                    end;
   end;
end;

procedure CopyT666(var Src, Dst: TMyInfernalType);
begin
  Dst.Clear;
  Dst.Init(Src.h, Src.w, Src._type);
  case Src._type of
    varByte: CopyMemory(Dst.b, Src.b, Src.w*Src.h*sizeOf(tbt));
    varDouble: CopyMemory(Dst.a, Src.a, Src.w*Src.h*sizeOf(treal));
    varInteger: CopyMemory(Dst.c, Src.c, Src.w*Src.h*sizeOf(integer));
    varArray: CopyMemory(Dst.d, Src.d, Src.w*Src.h*sizeOf(tpoint));
  end;
end;

procedure BilinInterp(var p, b, trace, trace_mask: TMyInfernalType; p1, p2: TPoint); overload;
var l: treal;
    _x0, _y0, _x1, _y1, i, length, t1, t2, t3, t4: integer;
    _x, _y, _f1, _f2: treal;
    w, h: integer;
begin
  l:=sqrt(sqr(p2.x-p1.x)+sqr(p2.y-p1.y));
  w:=p.w;
  h:=p.h;

  trace.Clear;
  trace_mask.Clear;
  length:=round(l)+1;
  trace.Init(1, length, varDouble);
  trace_mask.Init(1, length, varByte);
  case p._type of
    varByte: begin
//               trace.a^[0]:=p.b^[p1.y*p.w+p1.x];
               for i:=0 to length-1 do
               begin
                 _x:=i*(p2.x-p1.x)/l+p1.x;
                 _y:=i*(p2.y-p1.y)/l+p1.y;
                 _x0:=Floor(_x);
                 _x1:=Ceil(_x);
                 _y0:=Floor(_y);
                 _y1:=Ceil(_y);
                 t1:=_y0*w+_x0;
                 t2:=_y0*w+_x1;
                 t3:=_y1*w+_x1;
                 t4:=_y1*w+_x0;
                 if (b.b^[t1] = 1) and (b.b^[t2] = 1) and (b.b^[t3] = 1) and (b.b^[t4] = 1) then
                 begin
                   _f1:=(p.b^[t4]-p.b^[t1])*(_y-_y0)+p.b^[t1];
                   _f2:=(p.b^[t3]-p.b^[t2])*(_y-_y0)+p.b^[t2];
                   trace.a^[i]:=_f1+(_f2-_f1)*(_x-_x0);
                   trace_mask.b^[i]:=1;
                 end
                 else
                   trace_mask.b^[i]:=0;
               end;
             end;
    vardouble:  begin
//                  trace.a^[0]:=p.a^[p1.y*p.w+p1.x];
                  for i:=0 to length-1 do
                  begin
                    _x:=i*(p2.x-p1.x)/l+p1.x;
                    _y:=i*(p2.y-p1.y)/l+p1.y;
                    _x0:=Floor(_x);
                    _x1:=Ceil(_x);
                    _y0:=Floor(_y);
                    _y1:=Ceil(_y);
                    t1:=_y0*p.w+_x0;
                    t2:=_y0*p.w+_x1;
                    t3:=_y1*p.w+_x1;
                    t4:=_y1*p.w+_x0;
                    if (b.b^[t1] = 1) and (b.b^[t2] = 1) and (b.b^[t3] = 1) and (b.b^[t4] = 1) then
                    begin
                      _f1:=(p.a^[t4]-p.a^[t1])*(_y-_y0)+p.a^[t1];
                      _f2:=(p.a^[t3]-p.a^[t2])*(_y-_y0)+p.a^[t2];
                      trace.a^[i]:=_f1+(_f2-_f1)*(_x-_x0);
                      trace_mask.b^[i]:=1;
                    end
                    else
                      trace_mask.b^[i]:=0;
                  end;
               end;
  end;
end;

procedure BilinInterp(var p, trace: TMyInfernalType; p1, p2: TPoint); overload;
var l: treal;
    _x0, _y0, _x1, _y1, i, length, t1, t2, t3, t4: integer;
    _x, _y, _f1, _f2: treal;
begin
  l:=sqrt(sqr(p2.x-p1.x)+sqr(p2.y-p1.y));
  trace.Clear;
  length:=round(l)+1;
  trace.Init(1, length, varDouble);
  case p._type of
    varByte: begin
               trace.a^[0]:=p.b^[p1.y*p.w+p1.x];
               for i:=1 to length-1 do
               begin
                 _x:=i*(p2.x-p1.x)/l+p1.x;
                 _y:=i*(p2.y-p1.y)/l+p1.y;
                 _x0:=Floor(_x);
                 _x1:=Ceil(_x);
                 _y0:=Floor(_y);
                 _y1:=Ceil(_y);
                 t1:=_y0*p.w+_x0;
                 t2:=_y0*p.w+_x1;
                 t3:=_y1*p.w+_x1;
                 t4:=_y1*p.w+_x0;
                 _f1:=(p.b^[t4]-p.b^[t1])*(_y-_y0)+p.b^[t1];
                 _f2:=(p.b^[t3]-p.b^[t2])*(_y-_y0)+p.b^[t2];
                 trace.a^[i]:=_f1+(_f2-_f1)*(_x-_x0);
                 {trace.a^[i]:=p.b^[_y0*p.w+_x0]*(_x1-_x)*(_y1-_y)+p.b^[_y1*p.w+_x0]*(_x1-_x)*(_y-_y0)+
                 p.b^[_y0*p.w+_x1]*(_y1-_y)*(_x-_x0)+p.b^[_y1*p.w+_x1]*(_y-_y0)*(_x-_x0);}
               end;
             end;
    vardouble:  begin
                  trace.a^[0]:=p.a^[p1.y*p.w+p1.x];
                  for i:=1 to length-1 do
                  begin
                    _x:=i*(p2.x-p1.x)/l+p1.x;
                    _y:=i*(p2.y-p1.y)/l+p1.y;
                    _x0:=Floor(_x);
                    _x1:=Ceil(_x);
                    _y0:=Floor(_y);
                    _y1:=Ceil(_y);
                    t1:=_y0*p.w+_x0;
                    t2:=_y0*p.w+_x1;
                    t3:=_y1*p.w+_x1;
                    t4:=_y1*p.w+_x0;
                    _f1:=(p.a^[t4]-p.a^[t1])*(_y-_y0)+p.a^[t1];
                    _f2:=(p.a^[t3]-p.a^[t2])*(_y-_y0)+p.a^[t2];
                    trace.a^[i]:=_f1+(_f2-_f1)*(_x-_x0);
                    {trace.a^[i]:=p.a^[_y0*p.w+_x0]*(_x1-_x)*(_y1-_y)+p.a^[_y1*p.w+_x0]*(_x1-_x)*(_y-_y0)+
                    p.a^[_y0*p.w+_x1]*(_y1-_y)*(_x-_x0)+p.a^[_y1*p.w+_x1]*(_y-_y0)*(_x-_x0);}
                  end;
               end;
  end;
end;

procedure BilinInterp(var p: TMyInfernalType; var trace: PRealArray; var length: integer; x0, y0, x1, y1: integer);
var l: treal;
    _x0, _y0, _x1, _y1, i: integer;
    _x, _y: treal;
begin
  l:=sqrt(sqr(x1-x0)+sqr(y1-y0));
  length:=round(l)+1;
  GetMem(trace, sizeof(treal)*length);
  case p._type of
    varByte: begin
               trace^[0]:=p.b^[y0*p.w+x0];
               for i:=1 to length-1 do
               begin
                 _x:=i*(x1-x0)/l+x0;
                 _y:=i*(y1-y0)/l+y0;
                 _x0:=Floor(_x);
                 _x1:=Ceil(_x);
                 _y0:=Floor(_y);
                 _y1:=Ceil(_y);
                 trace^[i]:=p.b^[_y0*p.w+_x0]*(_x1-_x)*(_y1-_y)+p.b^[_y1*p.w+_x0]*(_x1-_x)*(_y-_y0)+
                 p.b^[_y0*p.w+_x1]*(_y1-_y)*(_x-_x0)+p.b^[_y1*p.w+_x1]*(_y-_y0)*(_x-_x0);
               end;
             end;
    vardouble:  begin
                  trace^[0]:=p.a^[y0*p.w+x0];
                  for i:=1 to length-1 do
                  begin
                    _x:=i*(x1-x0)/l+x0;
                    _y:=i*(y1-y0)/l+y0;
                    _x0:=Floor(_x);
                    _x1:=Ceil(_x);
                    _y0:=Floor(_y);
                    _y1:=Ceil(_y);
                    trace^[i]:=p.a^[_y0*p.w+_x0]*(_x1-_x)*(_y1-_y)+p.a^[_y1*p.w+_x0]*(_x1-_x)*(_y-_y0)+
                    p.a^[_y0*p.w+_x1]*(_y1-_y)*(_x-_x0)+p.a^[_y1*p.w+_x1]*(_y-_y0)*(_x-_x0);
                  end;
               end;
  end;
end;


procedure GaussFilter(var p, b: TBtArr; order, w, h: integer); overload;
var i,j, k,l: integer;
    Gauss: TDoubleArray;
    a, sum, count, y: TReal;
    temp: TDoubleArray;
    m: integer;
begin
  if not odd(order) then
    inc(order);
  SetLength(Gauss, order, order);
  SetLength(temp, h, w);
  m:=order div 2;


  for i:=0 to order-1 do
    for j:=0 to order-1 do
      Gauss[i,j]:=exp(-sqr(Hypot(i-m, j-m)/m)/2);

  if @(p) <> @(b) then
  begin
  for i:=m to h-1-m do
    for j:=m to w-1-m do
      if b[i*w+j] = 1 then
      begin
        sum:=0;
        count:=0;
        for k:=-m to m do
          for l:= -m to m do
             if b[(i+k)*w+j+l] = 1  then
             begin
               sum:=sum+p[(i+k)*w+j+l]*Gauss[k+m, l+m];
               count:=count+Gauss[k+m, l+m];
             end;
        temp[i,j]:=sum/count;
      end;
  for i:=0 to h-1 do
    for j:=0 to w-1 do
      p[i*w+j]:=round(temp[i,j]);
  end
  else
  begin
    for i:=m to h-1-m do
      for j:=m to w-1-m do
      begin
        sum:=0;
        count:=0;
        for k:=-m to m do
          for l:= -m to m do
          begin
            sum:=sum+p[(i+k)*w+j+l]*Gauss[k+m, l+m];
            count:=count+Gauss[k+m, l+m];
           end;
        temp[i,j]:=sum/count;
      end;
    for i:=0 to h-1 do
      for j:=0 to w-1 do
        p[i*w+j]:=round(temp[i,j]);
  end;
  Finalize(Gauss);
  Finalize(temp);
end;



{procedure GaussFilter(var p, b: TBtArr; filter_aper, width, height: integer); overload;
var i,j, k,l: integer;
    Gauss: TDoubleArray;
    a, q, count: TReal;
    temp: TDoubleArray;
begin
  a:=exp((filter_aper div 2)/2);
  SetLength(Gauss, filter_aper, filter_aper);
  SetLength(temp, height, width);
  for i:=0 to filter_aper-1 do
    for j:=0 to filter_aper-1 do
      Gauss[i,j]:=a*exp(-(sqr(i-(filter_aper div 2))+sqr(j-(filter_aper div 2)))/(2*(filter_aper div 2)));
  if @(p) <> @(b) then
  begin
  for i:=(filter_aper div 2) to height-1-(filter_aper div 2) do
    for j:=(filter_aper div 2) to width-1-(filter_aper div 2) do
      if b[i*width+j]=1 then
      begin
        q:=0;
        count:=0;
        for k:=-(filter_aper div 2) to (filter_aper div 2) do
          for l:= -(filter_aper div 2) to (filter_aper div 2) do
             if b[(i+k)*width+j+l] = 1  then
             begin
               q:=q+p[(i+k)*width+j+l]*Gauss[k+(filter_aper div 2), l+(filter_aper div 2)];
               count:= count + Gauss[k+(filter_aper div 2), l+(filter_aper div 2)];
             end;
        temp[i,j]:=q/count;
      end;
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      p[i*width+j]:=round(temp[i,j]);
  end
  else
  begin
    for i:=0 to height-1 do
      for j:=0 to width-1 do
      begin
        q:=0;
        count:=0;
        for k:=-(filter_aper div 2) to (filter_aper div 2) do
          for l:= -(filter_aper div 2) to (filter_aper div 2) do
          if ((i+k)>=0) and ((i+k)< height) and ((j+l)>=0) and ((j+l)<width) then
          begin
            q:=q+p[(i+k)*width+j+l]*Gauss[k+(filter_aper div 2), l+(filter_aper div 2)];
            count:= count + Gauss[k+(filter_aper div 2), l+(filter_aper div 2)];
           end;
        temp[i,j]:=q/count;
      end;
    for i:=0 to height-1 do
      for j:=0 to width-1 do
        p[i*width+j]:=round(temp[i,j]);
  end;
  Finalize(Gauss);
  Finalize(temp);
end;    }

procedure GaussFilter(var p: TMyInfernalType; filter_aper: integer); overload;
var i,j, k,l: integer;
    Gauss: TDoubleArray;
    a, q, count: TReal;
    temp: TDoubleArray;
begin
  a:=exp((filter_aper div 2)/2);
  SetLength(Gauss, filter_aper, filter_aper);
  SetLength(temp, p.h_img, p.w_img);
  for i:=0 to filter_aper-1 do
    for j:=0 to filter_aper-1 do
      Gauss[i,j]:=a*exp(-(sqr(i-(filter_aper div 2))+sqr(j-(filter_aper div 2)))/(2*(filter_aper div 2)));

  for i:=p.y_img to p.y_img+p.h_img-1 do
    for j:=p.x_img to p.x_img+p.w_img-1 do
    begin
      q:=0;
      count:=0;
      for k:=-(filter_aper div 2) to (filter_aper div 2) do
        for l:= -(filter_aper div 2) to (filter_aper div 2) do
          if ((i+k)>=0) and ((i+k)<=(p.h-1)) and ((j+l)>=0) and ((j+l)<=(p.w-1)) then
             begin
               q:=q+p.a^[(i+k)*p.w+j+l]*Gauss[k+(filter_aper div 2), l+(filter_aper div 2)];
               count:= count + Gauss[k+(filter_aper div 2), l+(filter_aper div 2)];
             end;
        temp[i-p.y_img,j-p.x_img]:=q/count;
      end;

  for i:=p.y_img to p.y_img+p.h_img-1 do
    for j:=p.x_img to p.x_img+p.w_img-1 do
      p.a^[i*p.w+j]:=temp[i-p.y_img,j-p.x_img];

  Finalize(Gauss);
  Finalize(temp);
end;


procedure GaussFilter(var p: TRealArray; var b: TBtArr; filter_aper, width, height: integer);
var i,j, k,l: integer;
    Gauss: TDoubleArray;
    a, q, count: TReal;
    temp: TDoubleArray;
begin
  a:=exp((filter_aper div 2)/2);
  SetLength(Gauss, filter_aper, filter_aper);
  SetLength(temp, height, width);
  for i:=0 to filter_aper-1 do
    for j:=0 to filter_aper-1 do
      Gauss[i,j]:=a*exp(-(sqr(i-(filter_aper div 2))+sqr(j-(filter_aper div 2)))/(2*(filter_aper div 2)));

  for i:=(filter_aper div 2) to height-1-(filter_aper div 2) do
    for j:=(filter_aper div 2) to width-1-(filter_aper div 2) do
      if b[i*width+j]=1 then
      begin
        q:=0;
        count:=0;
        for k:=-(filter_aper div 2) to (filter_aper div 2) do
          for l:= -(filter_aper div 2) to (filter_aper div 2) do
             if b[(i+k)*width+j+l] = 1  then
             begin
               q:=q+p[(i+k)*width+j+l]*Gauss[k+(filter_aper div 2), l+(filter_aper div 2)];
               count:= count + Gauss[k+(filter_aper div 2), l+(filter_aper div 2)];
             end;
        temp[i,j]:=q/count;
      end;
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      p[i*width+j]:=temp[i,j];

  Finalize(Gauss);
  Finalize(temp);
end;

procedure GaussFilter(var p: TDoubleArray; var b: TBoolArray; filter_aper, width, height: integer);
var i,j, k,l: integer;
    Gauss: TDoubleArray;
    a, q, count: TReal;
    temp: TDoubleArray;
begin
  a:=exp((filter_aper div 2)/2);
  SetLength(Gauss, filter_aper, filter_aper);
  SetLength(temp, height, width);
  for i:=0 to filter_aper-1 do
    for j:=0 to filter_aper-1 do
      Gauss[i,j]:=a*exp(-(sqr(i-(filter_aper div 2))+sqr(j-(filter_aper div 2)))/(2*(filter_aper div 2)));

  for i:=(filter_aper div 2) to height-1-(filter_aper div 2) do
    for j:=(filter_aper div 2) to width-1-(filter_aper div 2) do
      if b[i,j] then
      begin
        q:=0;
        count:=0;
        for k:=-(filter_aper div 2) to (filter_aper div 2) do
          for l:= -(filter_aper div 2) to (filter_aper div 2) do
             if b[i+k, j+l] then
             begin
               q:=q+p[i+k,j+l]*Gauss[k+(filter_aper div 2), l+(filter_aper div 2)];
               count:= count + Gauss[k+(filter_aper div 2), l+(filter_aper div 2)];
             end;
        temp[i,j]:=q/count;
      end;
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      p[i,j]:=temp[i,j];

  Finalize(Gauss);
  Finalize(temp);
end;


procedure FindPhase5StepsOld(var output: TDoubleArray; var mask: TBoolArray; var int: TPointerArray; N, SizeX, SizeY: integer);
var M: array[1..12] of TReal;
    MSol : array [1..3] of TReal;
    i, j: integer;
    delta: treal;
    signal: boolean;
begin
   delta:=2*Pi/N;
   for i:=0 to SizeY-1 do
     for j:=0 to SizeX-1 do
       if mask[i,j] then
       begin
         M[1] := 1;
         M[2] := 1/N*Cos(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2);
         M[3] := - 1/N*Sin(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2);
         M[4] := (Int[0]^[I*SizeX + J] + Int[1]^[I*SizeX + J] + Int[2]^[I*SizeX + J] +
                  Int[3]^[I*SizeX + J] + Int[4]^[I*SizeX + J])/N;

         M[5] := 1/N*Cos(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2);
         M[6] := (1 + 1/N*Cos(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2))/2;
         M[7] := - 1/N*Sin(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2)/2;
         M[8] := (Int[0]^[I*SizeX + J]*cos(0*delta) + Int[1]^[I*SizeX + J]*cos(1*delta) +
                  Int[2]^[I*SizeX + J]*cos(2*delta) + Int[3]^[I*SizeX + J]*cos(3*delta) +
                  Int[4]^[I*SizeX + J]*cos(4*delta))/N;

         M[9]  := 1/N*Sin(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2);
         M[10] := 1/N*Sin(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2)/2;
         M[11] := (1 - 1/N*Cos(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2))/2;
         M[12] := (Int[0]^[I*SizeX + J]*sin(0*delta) + Int[1]^[I*SizeX + J]*sin(1*delta) +
                   Int[2]^[I*SizeX + J]*sin(2*delta) + Int[3]^[I*SizeX + J]*sin(3*delta) +
                   Int[4]^[I*SizeX + J]*sin(4*delta))/N;
         Gauss126(3, M, MSol, Signal);
         if (MSol[2] = 0) and (MSol[3] = 0) then
           output[j,j]:= 0
         else
           output[i,j]:=ArcTan2(MSol[3], MSol[2]) + Pi;
       end;
end;

procedure FindPhase(var phase, amp, mask: TMyInfernalType; var int: TPointerArray; order: integer); overload;
var b: TIntArray;
    i, j, k: integer;
    a2, a1, a0: treal;
begin
  SetLength(b, order-3, order);
  for i:=0 to 3 do
    b[0,i]:=round(Power(-1, i div 2));

  for i:=1 to order-4 do
  begin
    b[i,0]:=1;
    b[i,i+3]:=round(Power(-1, (i+3) div 2));
    for j:=1 to i+2 do
      b[i,j]:=(abs(b[i-1, j-1])+abs(b[i-1,j]))*round(Power(-1, j div 2));
  end;

  a0:=0;
  for k:=0 to order-1 do
    a0:=a0+abs(b[order-4, k]);
  a0:=a0/2;

  if mask = phase then
  begin
    for i:=0 to phase.h-1 do
      for j:=0 to phase.w-1 do
      begin
        a2:=0;
        a1:=0;
        a0:=0;
        for k:=0 to order-1 do
        begin
          if odd(k) then
            a2:=a2+int[k]^[i*phase.w+j]*b[order-4, k]
          else
            a1:=a1+int[k]^[i*phase.w+j]*b[order-4, k];
        end;
          phase.a^[i*phase.w+j]:=ArcTan2(a2, a1) + Pi;
          amp.a^[i*amp.w+j]:=Hypot(a1, a2)/a0;
      end;
  end
  else
  begin
    for i:=0 to phase.h-1 do
      for j:=0 to phase.w-1 do
        if mask.b^[i*mask.w+j]=1 then
        begin
          a2:=0;
          a1:=0;
          for k:=0 to order-1 do
          begin
            if odd(k) then
            begin
              a2:=a2+int[k]^[i*phase.w+j]*b[order-4, k];
            end
            else
            begin
              a1:=a1+int[k]^[i*phase.w+j]*b[order-4, k];
            end;
          end;
            phase.a^[i*phase.w+j]:=ArcTan2(a2, a1) + Pi;
            amp.a^[i*amp.w+j]:=Hypot(a1, a2)/a0;
        end;
  end;
  Finalize(b);
end;

procedure FindPhase(var phase, mask: TMyInfernalType; var int: TPointerArray; order: integer); overload;
var b: TIntArray;
    i, j, k: integer;
    a2, a1: treal;
begin
  SetLength(b, order-3, order);
  for i:=0 to 3 do
    b[0,i]:=round(Power(-1, i div 2));

  for i:=1 to order-4 do
  begin
    b[i,0]:=1;
    b[i,i+3]:=round(Power(-1, (i+3) div 2));
    for j:=1 to i+2 do
      b[i,j]:=(abs(b[i-1, j-1])+abs(b[i-1,j]))*round(Power(-1, j div 2));
  end;

  if mask = phase then
  begin
    for i:=0 to phase.h-1 do
      for j:=0 to phase.w-1 do
      begin
        a2:=0;
        a1:=0;
        for k:=0 to order-1 do
        begin
          if odd(k) then
            a2:=a2+int[k]^[i*phase.w+j]*b[order-4, k]
          else
            a1:=a1+int[k]^[i*phase.w+j]*b[order-4, k];
          end;
          phase.a^[i*phase.w+j]:=ArcTan2(a2, a1) + Pi;
      end;
  end
  else
  begin
    for i:=0 to phase.h-1 do
      for j:=0 to phase.w-1 do
        if mask.b^[i*mask.w+j]=1 then
        begin
          a2:=0;
          a1:=0;
          for k:=0 to order-1 do
          begin
            if odd(k) then
              a2:=a2+int[k]^[i*phase.w+j]*b[order-4, k]
            else
              a1:=a1+int[k]^[i*phase.w+j]*b[order-4, k];
            end;
            phase.a^[i*phase.w+j]:=ArcTan2(a2, a1) + Pi;
        end;
  end;
  Finalize(b);
end;

procedure FindPhase(var output: TRealArray; var mask: TBtArr; var int: TPointerArray; order, width, height: integer); overload;
var b: TIntArray;
    i, j, k: integer;
    a2, a1: treal;
begin
  SetLength(b, order-3, order);
  for i:=0 to 3 do
    b[0,i]:=round(Power(-1, i div 2));

  for i:=1 to order-4 do
  begin
    b[i,0]:=1;
    b[i,i+3]:=round(Power(-1, (i+3) div 2));
    for j:=1 to i+2 do
      b[i,j]:=(abs(b[i-1, j-1])+abs(b[i-1,j]))*round(Power(-1, j div 2));
  end;

  for i:=0 to height-1 do
    for j:=0 to width-1 do
    if mask[i*width+j]=1 then
      begin
        a2:=0;
        a1:=0;
        for k:=0 to order-1 do
        begin
          if odd(k) then
            a2:=a2+int[k]^[i*width+j]*b[order-4, k]
          else
            a1:=a1+int[k]^[i*width+j]*b[order-4, k];
        end;
        output[i*width+j]:=ArcTan2(a2, a1) + Pi;
      end;
  Finalize(b);
end;

procedure FindPhase(var output: TDoubleArray; var mask: TBoolArray; var int: TPointerArray; order, width, height: integer); overload;
var b: TIntArray;
    i, j, k: integer;
    a2, a1: treal;
begin
  SetLength(b, order-3, order);
  for i:=0 to 3 do
    b[0,i]:=round(Power(-1, i div 2));

  for i:=1 to order-4 do
  begin
    b[i,0]:=1;
    b[i,i+3]:=round(Power(-1, (i+3) div 2));
    for j:=1 to i+2 do
      b[i,j]:=(abs(b[i-1, j-1])+abs(b[i-1,j]))*round(Power(-1, j div 2));
  end;

  for i:=0 to height-1 do
    for j:=0 to width-1 do
    if mask[i,j] then
      begin
        a2:=0;
        a1:=0;
        for k:=0 to order-1 do
        begin
          if odd(k) then
            a2:=a2+int[k]^[i*width+j]*b[order-4, k]
          else
            a1:=a1+int[k]^[i*width+j]*b[order-4, k];
        end;
        output[i,j]:=ArcTan2(a2, a1) + Pi;
      end;
  Finalize(b);
end;

procedure FindPhase(var output, mask: TRealArray; var int: TPointerArray; order, width, height: integer);
var b: TIntArray;
    i, j, k: integer;
    a2, a1: treal;
begin
  SetLength(b, order-3, order);
  for i:=0 to 3 do
    b[0,i]:=round(Power(-1, i div 2));

  for i:=1 to order-4 do
  begin
    b[i,0]:=1;
    b[i,i+3]:=round(Power(-1, (i+3) div 2));
    for j:=1 to i+2 do
      b[i,j]:=(abs(b[i-1, j-1])+abs(b[i-1,j]))*round(Power(-1, j div 2));
  end;

  for i:=0 to height-1 do
    for j:=0 to width-1 do
    if mask[i*width+j] = 1 then
      begin
        a2:=0;
        a1:=0;
        for k:=0 to order-1 do
        begin
          if odd(k) then
            a2:=a2+int[k]^[i*width+j]*b[order-4, k]
          else
            a1:=a1+int[k]^[i*width+j]*b[order-4, k];
        end;
        output[i*width+j]:=ArcTan2(a2, a1) + Pi;
      end;
  Finalize(b);
end;


procedure LinearValve(var p: pRealArray; var b: TBoolArray; order, width, height: Integer); overload;
var temp: PRealArray;
    i,j,k,l: integer;
    tmp: treal;
    s: boolean;
begin
  GetMem(temp, width*height*sizeof(treal));
  CopyMemory(temp, p, width*height*sizeof(treal));
  for i:=order div 2 to height-1-(order div 2) do
    for j:=order div 2 to width-1-(order div 2) do
    begin
      tmp:=0;
      s:=true;
        for k:=i-(order div 2) to i+(order div 2) do
          for l:=j-(order div 2) to j+(order div 2) do
            s:=s and b[k,l];
        if s then
        begin
          for k:=i-(order div 2) to i+(order div 2) do
            for l:=j-(order div 2) to j+(order div 2) do
              tmp:=tmp+p^[k*width+l];
          temp^[i*width+j]:=tmp/sqr(order);
        end;
    end;
  CopyMemory(p, temp, width*height*sizeof(treal));
  FreeMem(temp, width*height*sizeof(treal));
end;

procedure LinearValve(var p: pRealArray; order, width, height: Integer); overload;
var temp: PRealArray;
    i,j,k,l: integer;
    tmp: treal;
begin
  GetMem(temp, width*height*sizeof(treal));
  CopyMemory(temp, p, width*height*sizeof(treal));
  for i:=order div 2 to height-1-(order div 2) do
    for j:=order div 2 to width-1-(order div 2) do
    begin
      tmp:=0;
        for k:=i-(order div 2) to i+(order div 2) do
          for l:=j-(order div 2) to j+(order div 2) do
            tmp:=tmp+p^[k*width+l];
        temp^[i*width+j]:=tmp/sqr(order);
    end;
  CopyMemory(p, temp, width*height*sizeof(treal));
  FreeMem(temp, width*height*sizeof(treal));
end;

procedure ExtrValve(var p: TBoolArray; order: Integer); overload;
var temp: TBoolArray;
    i,j,k,l,m: integer;
    arr: array of boolean;
    tmp: boolean;
begin
  SetLength(arr, order*order);
  SetLength(temp, length(p), length(p[0]));
  for i:=0 to Length(p)-1 do
    temp[i]:=Copy(p[i],0, length(p[0]));

  for i:=order div 2 to length(p)-1-(order div 2) do
    for j:=order div 2 to length(p[0])-1-(order div 2) do
    begin
      m:=0;
        for k:=i-(order div 2) to i+(order div 2) do
          for l:=j-(order div 2) to j+(order div 2) do
          begin
            arr[m]:=p[k,l];
            inc(m);
          end;
        for k:=0 to length(arr)-2 do
          if not arr[k] then
            for l:=k+1 to length(arr)-1 do
              if arr[l] then
              begin
                tmp:=arr[k];
                arr[k]:=arr[l];
                arr[l]:=tmp;
              end;
        temp[i,j]:=arr[length(arr)-1];
    end;
  Finalize(p);
  p:=temp;
  Finalize(arr);
end;

procedure MedValve(var p: TBoolArray; order: Integer); overload;
var temp: TBoolArray;
    i,j,k,l,m: integer;
    arr: array of boolean;
    tmp: boolean;
begin
  SetLength(arr, order*order);
  SetLength(temp, length(p), length(p[0]));
  for i:=0 to Length(p)-1 do
    temp[i]:=Copy(p[i],0, length(p[0]));

  for i:=order div 2 to length(p)-1-(order div 2) do
    for j:=order div 2 to length(p[0])-1-(order div 2) do
    begin
      m:=0;
        for k:=i-(order div 2) to i+(order div 2) do
          for l:=j-(order div 2) to j+(order div 2) do
          begin
            arr[m]:=p[k,l];
            inc(m);
          end;
        for k:=0 to length(arr)-2 do
          if not arr[k] then
            for l:=k+1 to length(arr)-1 do
              if arr[l] then
              begin
                tmp:=arr[k];
                arr[k]:=arr[l];
                arr[l]:=tmp;
              end;
        temp[i,j]:=arr[(length(arr) div 2)+1];
    end;
  Finalize(p);
  p:=temp;
  Finalize(arr);
end;


procedure MedValve(var p: pRealArray; order, width, height: Integer); overload;
var temp: PRealArray;
    i,j,k,l,m: integer;
    arr: array of treal;
    tmp: treal;
begin
  SetLength(arr, order*order);
  GetMem(temp, width*height*sizeof(treal));
  CopyMemory(temp, p, width*height*sizeof(treal));
  for i:=order div 2 to height-1-(order div 2) do
    for j:=order div 2 to width-1-(order div 2) do
    begin
      m:=0;
        for k:=i-(order div 2) to i+(order div 2) do
          for l:=j-(order div 2) to j+(order div 2) do
          begin
            arr[m]:=p^[k*width+l];
            inc(m);
          end;
        for k:=0 to length(arr)-2 do
          for l:=k+1 to length(arr)-1 do
            if arr[k] < arr[l] then
            begin
              tmp:=arr[k];
              arr[k]:=arr[l];
              arr[l]:=tmp;
            end;
        temp^[i*width+j]:=arr[(length(arr) div 2)+1];
    end;
  CopyMemory(p, temp, width*height*sizeof(treal));
  FreeMem(temp, width*height*sizeof(treal));
  Finalize(arr);
end;

procedure MedValve(var p: pRealArray; b: TBoolArray; order, width, height: Integer); overload;
var temp: PRealArray;
    i,j,k,l,m: integer;
    arr: array of treal;
    s: boolean;
    tmp: treal;
begin
  SetLength(arr, order*order);
  GetMem(temp, width*height*sizeof(treal));
  CopyMemory(temp, p, width*height*sizeof(treal));
  for i:=order div 2 to height-1-(order div 2) do
    for j:=order div 2 to width-1-(order div 2) do
    begin
      m:=0;
      s:=true;
      for k:=i-(order div 2) to i+(order div 2) do
        for l:=j-(order div 2) to j+(order div 2) do
           s:= s and b[k,l];

      if s then
      begin
        for k:=i-(order div 2) to i+(order div 2) do
          for l:=j-(order div 2) to j+(order div 2) do
          begin
            arr[m]:=p^[k*width+l];
            inc(m);
          end;
        for k:=0 to length(arr)-2 do
          for l:=k+1 to length(arr)-1 do
            if arr[k] < arr[l] then
            begin
              tmp:=arr[k];
              arr[k]:=arr[l];
              arr[l]:=tmp;
            end;
        temp^[i*width+j]:=arr[(length(arr) div 2)+1];
      end;
    end;
  CopyMemory(p, temp, width*height*sizeof(treal));
  FreeMem(temp, width*height*sizeof(treal));
  Finalize(arr);
end;


procedure MedValve(var p, b: PRealArray; order, width, height: Integer);
var temp: PRealArray;
    i,j,k,l,m: integer;
    arr: array of treal;
    s: boolean;
    tmp: treal;
begin
  SetLength(arr, order*order);
// SetLength(switch, order, order);
  GetMem(temp, width*height*sizeof(treal));
  CopyMemory(temp, p, width*height*sizeof(treal));
  for i:=order div 2 to height-1-(order div 2) do
    for j:=order div 2 to width-1-(order div 2) do
    begin
      m:=0;
      s:=true;
      for k:=i-(order div 2) to i+(order div 2) do
        for l:=j-(order div 2) to j+(order div 2) do
          if b^[k*width+l] = 0 then
            s:=false;
      if s then
      begin
        for k:=i-(order div 2) to i+(order div 2) do
          for l:=j-(order div 2) to j+(order div 2) do
          begin
            arr[m]:=p^[k*width+l];
            inc(m);
          end;
        for k:=0 to length(arr)-2 do
          for l:=k+1 to length(arr)-1 do
            if arr[k] < arr[l] then
            begin
              tmp:=arr[k];
              arr[k]:=arr[l];
              arr[l]:=tmp;
            end;
        temp^[i*width+j]:=arr[(length(arr) div 2)+1];
      end;
    end;
  CopyMemory(p, temp, width*height*sizeof(treal));
  FreeMem(temp, width*height*sizeof(treal));
  Finalize(arr);
end;


procedure InvertMask(var p: TRealArray; m, n: integer);
var i,j: integer;
begin
  for i:=0 to m-1 do
    for j:=0 to n-1 do
     if p[i*n+j] = 1 then
       p[i*n+j]:=0
     else
       p[i*n+j]:=1;
end;

procedure InvertMask(var p: TBtArr; m, n: integer);  overload;
var i,j: integer;
begin
  for i:=0 to m-1 do
    for j:=0 to n-1 do
     if p[i*n+j] = 1 then
       p[i*n+j]:=0
     else
       p[i*n+j]:=1;
end;

procedure AndMasks(var mask1, mask2: TBtArr; width, height: Integer);
var i,j: integer;
begin
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      mask1[i*width+j]:=mask1[i*width+j]*mask2[i*width+j];
end;

procedure AddMasks(var mask1, mask2: TRealArray; width, height: Integer);
var i,j: integer;
begin
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if mask2[i*width+j] = 1 then
        mask1[i*width+j]:=1;
end;

procedure SubsMasks(var mask1, mask2: TRealArray; width, height: Integer);
var i,j: integer;
begin
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if mask2[i*width+j] = 1 then
        mask1[i*width+j]:=0;
end;

procedure ReadBitmapFiles(var p: TPointerArray; steps, channel, seq: integer); overload;
var k, i, j: integer;
    pb_temp: pByteArray;
    b: TBitmap;
   // s: string;
begin
  b:=TBitmap.Create;
  for k:=0 to steps-1 do
  begin
  //    s:='Capture\i'+ IntToStr(channel)+'_s'+ IntToStr(k+1)+'_c0_n'+ IntToStr(seq)+'.bmp';
      b.LoadFromFile(Format('Capture\i%d_s%d_c0_n%d.bmp',[channel, k+1, seq]));
      for i:=0 to b.Height-1 do
      begin
        pb_temp:=b.ScanLine[i];
        for j:=0 to b.Width-1 do
          p[k]^[i*b.Width+j]:=pb_temp^[j];
      end;
      b.FreeImage;
  end;
  b.Destroy;
end;

procedure ReadBitmapFiles(var p: TPointerArray; steps, channel, cadr: integer; EnableFilter: boolean); overload;
var k, q, i, j, m, n: integer;
    pb_temp: pByteArray;
    temp: PRealArray;
    b: TBitmap;
 //   s: string;
begin
  b:=TBitmap.Create;
  b.LoadFromFile(Format('Capture\cadr_i%d_s%d_c%d.bmp',[channel, 1, 1]));
  m:=b.Height;
  n:=b.Width;
  GetMem(temp,m*n*sizeof(treal));

  for k:=1 to steps do
  begin
    ZeroMemory(temp, m*n*sizeof(treal));
    for q:=1 to cadr do
    begin
      b.LoadFromFile(Format('Capture\cadr_i%d_s%d_c%d.bmp',[channel, k, q]));
      for i:=0 to m-1 do
      begin
        pb_temp:=b.ScanLine[i];
        for j:=0 to n-1 do
          temp^[i*n+j]:=pb_temp^[j]+temp^[i*n+j];
      end;
    end;
    for i:=0 to m-1 do
      for j:=0 to n-1 do
        temp^[i*n+j]:=temp^[i*n+j]/cadr;


    if EnableFilter then
      FringeRemove(temp^, m, n, round(n/15));
    CopyMemory(p[k-1], temp, m*n*sizeof(treal));
    b.FreeImage;
  end;
  FreeMem(temp,m*n*sizeof(treal));
  b.Destroy;
//  FringeRemove(p[8]^, 576, 768, round(576/15));
end;

procedure ConvertDynamic2PointerArray(var input: TBoolArray; var output: TRealArray; Height, Width: integer); overload;
var i,j: integer;
begin
   for i:=0 to height-1 do
     for j:=0 to width-1 do
       if input[i,j] then
         output[i*width+j]:=1
       else
         output[i*width+j]:=0;
end;

procedure ConvertDynamic2PointerArray(var input: TDoubleArray; var output: TRealArray; Height, Width: integer);
var i,j: integer;
begin
   for i:=0 to height-1 do
     for j:=0 to width-1 do
       output[i*width+j]:=input[i,j];
end;

procedure ConvertPointer2DynamicArray(var input: TRealArray; var output: TDoubleArray; Height, Width: integer);
var i,j: integer;
begin
  for i:=0 to Height-1 do
    for j:=0 to Width-1 do
      output[i,j]:=input[i*Width+j];
end;

procedure Read_Data(var p: TBoolArray; bitmap: TBitmap);
var i,j: integer;
    pb_temp: pByteArray;
begin
  SetLength(p, bitmap.Height, bitmap.Width);

  for i:=0 to bitmap.Height-1 do
  begin
    pb_temp:=bitmap.ScanLine[i];
    for j:=0 to bitmap.Width-1 do
    if pb_temp^[j] > 127 then
      p[i,j]:= true
    else
      p[i,j]:= false;
  end;

end;

procedure Create_Bmp(var p: TRealArray; var  mask: TBoolArray;
  bitmap: TBitmap; min, max: double; xmin, ymin, xmax, ymax, xc, yc, color: word); overload;
var temp: TReal;
    pb_temp: pByteArray;
    i, j, width : word;
begin
   if min <> max then
    temp:=255/(max-min)
   else
    temp:=255;
   width:=length(mask[0]); 
   bitmap.Height:=ymax-ymin+1;
   bitmap.Width:=xmax-xmin+1;
   for i:=0 to bitmap.Height-1 do
      begin
        pb_temp:=bitmap.ScanLine[i];
        for j:=0 to bitmap.Width-1 do
        if mask[i+ymin,j+xmin] then
          if (i=yc-ymin) or (j=xc-xmin) then
            pb_temp^[j]:=255-round((p[(i+ymin)*width+j+xmin]-min)*temp)
          else
            pb_temp^[j]:=round((p[(i+ymin)*width+j+xmin]-min)*temp)
        else
          if (i=yc-ymin) or (j=xc-xmin) then
            pb_temp^[j]:=255-color
          else
            pb_temp^[j]:=color;
      end;

end;


procedure Paint_Img(var p: TRealArray; var  mask: TBoolArray; bitmap: TBitmap;
  image: TImage; xmin, ymin, xmax, ymax, width, height, color: word); overload;
var temp, min, max: TReal;
    pb_temp: pByteArray;
    i, j : word;
begin
   FindMin_Max(min,max,p, mask, width, height);
   if min <> max then
    temp:=255/(max-min)
   else
    temp:=255;
   bitmap.Height:=ymax-ymin+1;
   bitmap.Width:=xmax-xmin+1;
   for i:=0 to bitmap.Height-1 do
      begin
        pb_temp:=bitmap.ScanLine[i];
        for j:=0 to bitmap.Width-1 do
        if mask[i+ymin,j+xmin] then
          pb_temp^[j]:=round((p[(i+ymin)*width+j+xmin]-min)*temp)
        else
         pb_temp^[j]:=color;
      end;
      if bitmap.Height > bitmap.Width then
        image.Width:=round(bitmap.Width*image.Height/bitmap.Height)
      else
        image.Height:=round(bitmap.Height*image.Width/bitmap.Width);
        
      image.Canvas.StretchDraw(Rect(0,0,image.Width,image.Height),bitmap);
end;

procedure Paint_Img(var p: TRealArray; var mask: TBoolArray; bitmap: TBitmap; image: TImage; width, height: word); overload;
var temp, min, max: TReal;
    pb_temp: pByteArray;
    i, j : word;
begin
   FindMin_Max(min,max,p, mask, width, height);
   if min <> max then
    temp:=255/(max-min)
   else
    temp:=255;
   bitmap.Height:=height;
   bitmap.Width:=width;
   for i:=0 to height-1 do
      begin
        pb_temp:=bitmap.ScanLine[i];
        for j:=0 to width-1 do
        if mask[i,j] then
          pb_temp^[j]:=round((p[i*width+j]-min)*temp)
        else
         pb_temp^[j]:=0;
      end;
      image.Canvas.StretchDraw(Rect(0,0,image.Width,image.Height),bitmap);
end;


procedure Paint_Img(var p, mask: TRealArray; bitmap: TBitmap; image: TImage; width, height: word); overload;
var temp, min, max: TReal;
    pb_temp: pByteArray;
    i, j : word;
begin
   FindMin_Max(min,max,p, mask, width, height);
   if min <> max then
    temp:=255/(max-min)
   else
    temp:=255;
   bitmap.Height:=height;
   bitmap.Width:=width;
   for i:=0 to height-1 do
      begin
        pb_temp:=bitmap.ScanLine[i];
        for j:=0 to width-1 do
        if mask[i*width+j]=1 then
          pb_temp^[j]:=round((p[i*width+j]-min)*temp)
        else
         pb_temp^[j]:=0;
      end;
      image.Picture.Bitmap:=bitmap;
     // image.Canvas.StretchDraw(Rect(0,0,image.Width,image.Height),bitmap);
end;

procedure Paint_Img(var p: TRealArray; bitmap: TBitmap; image: TImage; width, height: word); overload;
var temp, min, max: TReal;
    pb_temp: pByteArray;
    i, j : word;

begin
   FindMin_Max(min,max,p, width, height);
   if min <> max then
    temp:=255/(max-min)
   else
    temp:=255;
{   image.Picture.Bitmap.Height:=height;
   image.Picture.Bitmap.Width:=width;}

   bitmap.Height:=height;
   bitmap.Width:=width;
   for i:=0 to height-1 do
      begin
        pb_temp:={image.Picture.}bitmap.ScanLine[i];
        for j:=0 to width-1 do
        pb_temp^[j]:=round((p[i*width+j]-min)*temp)
      end;
//   image.Picture.Bitmap.FreeImage;
      image.Picture.Bitmap:=bitmap;
// image.Canvas.StretchDraw(Rect(0,0,image.Width,image.Height),bitmap);
end;

procedure Paint_Img(var p: TIntArray; bitmap: TBitmap; image: TImage); overload;
var
    min, max, i, j: integer;
    temp: double;
    pb_temp: pByteArray;
begin
  FindMin_Max(min, max,p);
   if min <> max then
    temp:=255/(max-min)
   else
    temp:=255;
  for i:=0 to bitmap.Height-1 do
  begin
    pb_temp:=bitmap.ScanLine[i];
    for j:=0 to bitmap.Width-1 do
    pb_temp^[j]:=round((p[i,j]-min)*temp){p[i,j]};
  end;
  image.Canvas.StretchDraw(Rect(0,0,image.Width,image.Height),bitmap);
end;

procedure Paint_Img(var p: TDoubleArray; bitmap: TBitmap; image: TImage); overload;
var temp, min, max: double;
    pb_temp: pByteArray;
    i, j : integer;
begin
   FindMin_Max(min,max,p);
   if min <> max then
    temp:=255/(max-min)
   else
    temp:=255;
   bitmap.Height:=length(p);
   bitmap.Width:=length(p[0]);
   for i:=0 to bitmap.Height-1 do
      begin
        pb_temp:=bitmap.ScanLine[i];
        for j:=0 to bitmap.Width-1 do
        pb_temp^[j]:=round((p[i,j]-min)*temp)
      end;
      image.Canvas.StretchDraw(Rect(0,0,image.Width,image.Height),bitmap);
end;

procedure Paint_Img(var p: TDoubleArray; var mask: TBoolArray; bitmap: TBitmap; image: TImage); overload;
var
    i, j: integer;
    pb_temp: pByteArray;
    min, max, temp: double;
begin
   FindMin_Max(min, max, p, mask);
   if min <> max then
    temp:=255/(max-min)
   else
    temp:=255;
   bitmap.Height:=Length(p);
   bitmap.Width:=Length(p[0]);
   for i:=0 to Length(p)-1 do
      begin
        pb_temp:=bitmap.ScanLine[i];
        for j:=0 to Length(p[0])-1 do
        if mask[i,j] then
          pb_temp^[j]:=round((p[i,j]-min)*temp)
        else
         pb_temp^[j]:=0;
      end;
      image.Canvas.StretchDraw(Rect(0,0,image.Width,image.Height),bitmap);
end;


procedure Paint_Img(var p: TBoolArray; bitmap: TBitmap; image: TImage); overload;
var
    i, j: integer;
    pb_temp: pByteArray;
begin
  bitmap.Height:=Length(p);
  bitmap.Width:=Length(p[0]);
  for i:=0 to length(p)-1 do
  begin
    pb_temp:=bitmap.ScanLine[i];
    for j:=0 to length(p[0])-1 do
    if p[i,j] then pb_temp^[j]:=255
    else
    pb_temp^[j]:=0;
  end;
  image.Canvas.StretchDraw(Rect(0,0,image.Width,image.Height),bitmap);
end;

procedure FindMin_Max(var min, max: TReal; var p: TRealArray; var mask: TBoolArray; width, height: word); overload;
var i, j: word;
begin
   min:=100; max:=-100;
   for i:=0 to height-1 do
     for j:=0 to width-1 do
     begin
       if mask[i,j] then
       begin
         if min > p[i*width+j] then min:=p[i*width+j];
         if max < p[i*width+j] then max:=p[i*width+j];
       end;
     end;
end;

procedure FindMin_Max(var min, max: TReal; var p, mask: TRealArray; width, height: word); overload;
var i, j: word;
begin
   min:=100; max:=-100;
   for i:=0 to height-1 do
     for j:=0 to width-1 do
     begin
       if mask[i*width+j]=1 then
       begin
         if min > p[i*width+j] then min:=p[i*width+j];
         if max < p[i*width+j] then max:=p[i*width+j];
       end;
     end;
end;


procedure FindMin_Max(var min, max: TReal; var p: TRealArray; width, height: word); overload;
var i, j: word;
begin
   min:=100; max:=-100;
   for i:=0 to height-1 do
   for j:=0 to width-1 do
   begin
     if min > p[i*width+j] then min:=p[i*width+j];
     if max < p[i*width+j] then max:=p[i*width+j];
   end;
end;

procedure FindMin_Max(var min, max: integer; var p: TIntArray);   overload;
var i, j: integer;
begin
   min:=round(1e9); max:=round(1e-10);
   for i:=0 to length(p)-1 do
   for j:=0 to length(p[0])-1 do
   begin
     if min > p[i,j] then min:=p[i,j];
     if max < p[i,j] then max:=p[i,j];
   end;
end;



procedure FindMin_Max(var min, max: double; var p: TDoubleArray); overload;
var i, j: integer;
begin
   min:=MaxDouble; max:=-MaxDouble;
   for i:=0 to length(p)-1 do
   for j:=0 to length(p[0])-1 do
   begin
     if min > p[i,j] then min:=p[i,j];
     if max < p[i,j] then max:=p[i,j];
   end;
end;

procedure FindMin_Max(var min, max: double; var p: TDoubleArray; var mask: TBoolArray); overload;
var i, j: word;
begin
   min:=MaxDouble; max:=-MaxDouble;
   for i:=0 to length(p)-1 do
     for j:=0 to length(p[0])-1 do
     begin
       if mask[i,j] then
       begin
         if min > p[i,j] then min:=p[i,j];
         if max < p[i,j] then max:=p[i,j];
       end;
     end;
end;

function CreateSpectrPalette  : HPalette;
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
  {  Фиолетовый - Синий  }
  for I := 0 to 63 do begin
    ColorTable^[I].peRed := 128 - I*2;
    ColorTable^[I].peGreen := 0;
    ColorTable^[I].peBlue := 128 + I*2;
    ColorTable^[I].peFlags := 0;
  end;
  {  Синий - зеленый  }
  for I := 64 to 127 do begin
    ColorTable^[I].peRed := 0;
    ColorTable^[I].peGreen := (I - 64)*4 + 1;
    ColorTable^[I].peBlue := 255 - (I - 64)*4;
    ColorTable^[I].peFlags := 0;
  end;
  {  Зеленый - желтый  }
  for I := 128 to 191 do begin
    ColorTable^[I].peRed := (I - 128)*4;
    ColorTable^[I].peGreen := 255;
    ColorTable^[I].peBlue := 0;
    ColorTable^[I].peFlags := 0;
  end;
  {  Желтый - Красный  }
  for I := 192 to 255 do begin
    ColorTable^[I].peRed := 255;
    ColorTable^[I].peGreen := 255 - (I - 192)*4;
    ColorTable^[I].peBlue := 0;
    ColorTable^[I].peFlags := 0;
  end;
  {  Регистрируем палитру  }
  CreateSpectrPalette := CreatePalette(Pal^);
  {  Освобождаем память  }
  FreeMem(Pal, SizeOf(TLogPalette) + (256 - 1)*SizeOf(TPaletteEntry));
end;



function CreateBWPalette  : HPalette;
var
  i : Integer;
  Pal : PLogPalette;
  ColorTable : ^TPaletteEntryArray;
begin
  {  Выделяем память под палитру  }
  GetMem(Pal, SizeOf(TLogPalette) + (256 - 1)*SizeOf(TPaletteEntry));
  {  Создаем палитру  }
  Pal^.palVersion := $300;
  Pal^.palNumEntries := 256;
  ColorTable := Addr(Pal^.palPalEntry[0]);
  for i := 0 to 255 do begin
    ColorTable^[i].peRed := i;
    ColorTable^[i].peGreen := i;
    ColorTable^[i].peBlue := i;
    ColorTable^[i].peFlags := 0;
  end;
  {  Регистрируем палитру  }
  CreateBWPalette := CreatePalette(Pal^);
  {  Освобождаем память  }
  FreeMem(Pal, SizeOf(TLogPalette) + (256 - 1)*SizeOf(TPaletteEntry));
end;

procedure ReadFile(var d: TDoubleArray; filename: TfileName);
var
    f: TextFile;
    i: integer;
begin
    AssignFile(f, filename);
    Reset(f);
    i:=0;
    while not Eof(f) do
    begin
      while not SeekEoln(f) do
      Read(f,d[i div 768,i mod 768]);
      Readln(f);
      inc(i);
    end;
    CloseFile(f);
end;





procedure PaintImage(p: TDoubleArray; mask: TBoolArray; bitmap: TBitmap; canvas: TCanvas);
var temp, min, max: double;
    pb_temp: pByteArray;
    i, j : integer;
begin
   FindMinMax(min,max,p, mask);
   if min <> max then
    temp:=255/(max-min)
   else
    temp:=255;
   bitmap.Height:=length(p);
   bitmap.Width:=length(p[0]);
   for i:=0 to bitmap.Height-1 do
      begin
        pb_temp:=bitmap.ScanLine[i];
        for j:=0 to bitmap.Width-1 do
        if mask[i,j] then
        pb_temp^[j]:=round((p[i,j]-min)*temp)
        else pb_temp^[j]:=0;
      end;
      canvas.Draw(0,0,bitmap);

end;

procedure FindMinMax(var min, max: treal; p, mask: TMyInfernalType);  overload;
var i, t: integer;
begin
   min:=1e100; max:=1e-100;
   t:=p.w*p.h;
   if p <> mask then
   begin
     case p._type of
       varDouble: for i:=0 to t do
                  begin
                    if mask.b^[i] = 1 then
                    begin
                      if min > p.a^[i] then min:=p.a^[i];
                      if max < p.a^[i] then max:=p.a^[i];
                    end;
                  end;
       varByte:   for i:=0 to t do
                  begin
                    if mask.b^[i] = 1 then
                    begin
                      if min > p.b^[i] then min:=p.b^[i];
                      if max < p.b^[i] then max:=p.b^[i];
                    end;
                  end;
       varInteger:  for i:=0 to t do
                    begin
                      if mask.b^[i] = 1 then
                      begin
                        if min > p.c^[i] then min:=p.c^[i];
                        if max < p.c^[i] then max:=p.c^[i];
                      end;
                    end;
     end;
   end
   else
   begin
     case p._type of
       varDouble:  for i:=0 to t do
                   begin
                     if min > p.a^[i] then min:=p.a^[i];
                     if max < p.a^[i] then max:=p.a^[i];
                   end;
       varInteger: for i:=0 to t do
                   begin
                     if min > p.c^[i] then min:=p.c^[i];
                     if max < p.c^[i] then max:=p.c^[i];
                   end;
       varByte:    for i:=0 to t do
                   begin
                     if min > p.b^[i] then min:=p.b^[i];
                     if max < p.b^[i] then max:=p.b^[i];
                   end;
     end;
   end;
end;


procedure FindMinMax(var min, max: double; p: TDoubleArray; mask: TBoolArray);
var i, j: integer;
begin
   min:=1e100; max:=1e-100;
   for i:=0 to length(p)-1 do
   for j:=0 to length(p[0])-1 do
   if mask[i,j] then
   begin
     if min > p[i,j] then min:=p[i,j];
     if max < p[i,j] then max:=p[i,j];
   end;
end;

procedure CreateBoolMask(var b: TBoolArray; x,y,r: Double);
var i,j: word;
begin
   for i:=0 to Length(b)-1 do
    for j:=0 to Length(b[0])-1 do
      if (sqr(x-j)+sqr(y-i) <= sqr(r)) {sqr(i-Height/2)+sqr(j-Width/2)<=sqr(90) }then
        b[i,j]:=true
      else
        b[i,j]:=false;
end;

procedure CreateTRealMask(var p: TRealArray; var b1, b2: TBoolArray);
var i,j, width, height: word;
begin
  width:=Length(b1[0]);
  height:=Length(b1);
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if b1[i,j] or b2[i,j] then
        p[i*Width+j]:=1
      else
        p[i*Width+j]:=0;
end;

procedure WriteFile(var p: TBoolArray); overload;
var i,j: word;
    f: TextFile;
begin
  AssignFile(f,'mask.txt');
  Rewrite(f);
  for i:=0 to Length(p)-1 do
    for j:=0 to Length(p[0])-1 do
      if p[i,j] then
        Writeln(f, 1)
      else
        Writeln(f, 0);
  CloseFile(f);
end;

procedure WriteFile(var p: TRealArray; height, width: word); overload;
var i,j: word;
    f: TextFile;
begin
  AssignFile(f,'test.txt');
  Rewrite(f);
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      Writeln(f, p[i*width+j]);
  CloseFile(f);
end;

{решение ситемы линейных уравнений методом Гаусса с
выбором главного элемента по столбцу}
procedure GaussSolve(var arr: TDoubleArray);
var i, j, k : byte;
    temp: double;
begin

  {Последовательный перебор столбцов матрицы для приведения оной к
  треугольному виду}
  for j:=0 to length(arr)-1 do
  begin
    {Нахождение максимального элемента  (по абсолютному значению) в j-м столбце}
    temp:=abs(arr[j,j]);
    k:=j;
    for i:=j+1 to length(arr)-1 do
    if temp < abs(arr[i,j]) then
      begin
        k:=i; {строка "k" - сохранение номера строки с максимальным элементом}
        temp:= abs(arr[i,j]);
      end;
      {если присутствует нулевой столбец - система вырождена}
    if temp < 1e-10 {какое-нибудь очень маленькое число}then
    begin
      MessageDlg('Система не имеет единственного решения',mtError, [mbOk], 0);
      break;
    end;
    {замена текущей строки "j" на строку "k"}
    if k <> j then
      for i:=j to length(arr) do
      begin
        temp:=arr[j,i];
        arr[j,i]:=arr[k,i];
        arr[k,i]:=temp;
      end;
    {преобразование j строки -
    делением всей строки на диагональный элемент temp}
    temp:=arr[j,j];
    arr[j,j]:=1;
    for i:=j+1 to length(arr) do
    arr[j,i]:=arr[j,i]/temp;

    {последовательное преобразование остальных строк от j+1 до m-1}
    for i:=j+1 to length(arr)-1 do
    begin
      temp:=arr[i,j];
      arr[i,j]:= 0;
      if temp <> 0 then
      for k:=j+1 to length(arr) do
        arr[i,k]:=arr[i,k]-temp*arr[j,k];
    end;
  end;

  {обратный ход алгоритма - решение последний столбец, т.е. m-тый}
  for j:=length(arr)-1 downto 1 do
  begin
    for i:=j-1 downto 0 do
    begin
      arr[i,length(arr)]:=arr[i,length(arr)]-arr[i,j]*arr[j,length(arr)];
      arr[i,j]:=0;
    end;
  end;
end;

procedure TiltRemove(var p: TRealArray; var mask_define, mask_remove: TBtArr; height, width: word; var a, b, c: treal); overload;
var
    arr: TDoubleArray;
    i,j: integer;
begin
  SetLength(arr,3,4);

  for i:=0 to height-1 do
  begin
    for j:=0 to width-1 do
    if mask_define[i*width+j] = 1 then
    begin
      arr[0,0]:=arr[0,0]+sqr(i);
      arr[0,1]:=arr[0,1]+i*j;
      arr[0,2]:=arr[0,2]+i;
      arr[0,3]:=arr[0,3]+i*p[i*width+j];
      arr[1,1]:=arr[1,1]+sqr(j);
      arr[1,2]:=arr[1,2]+j;
      arr[1,3]:=arr[1,3]+j*p[i*width+j];
      arr[2,2]:=arr[2,2]+1;
      arr[2,3]:=arr[2,3]+p[i*width+j];
    end;
  end;
  arr[1,0]:=arr[0,1];
  arr[2,0]:=arr[0,2];
  arr[2,1]:=arr[1,2];

  GaussSolve(arr);

  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if mask_remove[i*width+j] = 1 then
        p[i*width+j]:=p[i*width+j]-(arr[0,3]*i+arr[1,3]*j+arr[2,3]);

  a:=arr[0,3];
  b:=arr[1,3];
  c:=arr[2,3];

  Finalize(arr);
end;

procedure TiltRemove(var p: TRealArray; var mask_define, mask_remove: TBtArr; height, width: word); overload;
var
    arr: TDoubleArray;
    i,j: integer;
begin
  SetLength(arr,3,4);

  {for i:=0 to height-1 do
    for j:=0 to width-1 do
    arr[i,j]:=0;}

  for i:=0 to height-1 do
  begin
    for j:=0 to width-1 do
    if mask_define[i*width+j] = 1 then
    begin
      arr[0,0]:=arr[0,0]+sqr(i);
      arr[0,1]:=arr[0,1]+i*j;
      arr[0,2]:=arr[0,2]+i;
      arr[0,3]:=arr[0,3]+i*p[i*width+j];
      arr[1,1]:=arr[1,1]+sqr(j);
      arr[1,2]:=arr[1,2]+j;
      arr[1,3]:=arr[1,3]+j*p[i*width+j];
      arr[2,2]:=arr[2,2]+1;
      arr[2,3]:=arr[2,3]+p[i*width+j];
    end;
  end;
  arr[1,0]:=arr[0,1];
  arr[2,0]:=arr[0,2];
  arr[2,1]:=arr[1,2];

  GaussSolve(arr);

  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if mask_remove[i*width+j] = 1 then
        p[i*width+j]:=p[i*width+j]-(arr[0,3]*i+arr[1,3]*j+arr[2,3]);
  Finalize(arr);
end;

procedure TiltRemove(var p: TDoubleArray; var mask_define, mask_remove: TBoolArray; height, width: word; var a, b, c: treal); overload;
var
    arr: TDoubleArray;
    i,j: integer;
begin
  SetLength(arr,3,4);

  for i:=0 to height-1 do
  begin
    for j:=0 to width-1 do
    if mask_define[i,j] then
    begin
      arr[0,0]:=arr[0,0]+sqr(i);
      arr[0,1]:=arr[0,1]+i*j;
      arr[0,2]:=arr[0,2]+i;
      arr[0,3]:=arr[0,3]+i*p[i,j];
      arr[1,1]:=arr[1,1]+sqr(j);
      arr[1,2]:=arr[1,2]+j;
      arr[1,3]:=arr[1,3]+j*p[i,j];
      arr[2,2]:=arr[2,2]+1;
      arr[2,3]:=arr[2,3]+p[i,j];
    end;
  end;
  arr[1,0]:=arr[0,1];
  arr[2,0]:=arr[0,2];
  arr[2,1]:=arr[1,2];

  GaussSolve(arr);

  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if mask_remove[i,j] then
        p[i,j]:=p[i,j]-(arr[0,3]*i+arr[1,3]*j+arr[2,3]);

  a:=arr[0,3];
  b:=arr[1,3];
  c:=arr[2,3];

  Finalize(arr);
end;

procedure TiltRemove(var p: TDoubleArray; var mask_define, mask_remove: TBoolArray; height, width: word); overload;
var
    arr: TDoubleArray;
    i,j: integer;
begin
  SetLength(arr,3,4);

  {for i:=0 to height-1 do
    for j:=0 to width-1 do
    arr[i,j]:=0;}

  for i:=0 to height-1 do
  begin
    for j:=0 to width-1 do
    if mask_define[i,j] then
    begin
      arr[0,0]:=arr[0,0]+sqr(i);
      arr[0,1]:=arr[0,1]+i*j;
      arr[0,2]:=arr[0,2]+i;
      arr[0,3]:=arr[0,3]+i*p[i,j];
      arr[1,1]:=arr[1,1]+sqr(j);
      arr[1,2]:=arr[1,2]+j;
      arr[1,3]:=arr[1,3]+j*p[i,j];
      arr[2,2]:=arr[2,2]+1;
      arr[2,3]:=arr[2,3]+p[i,j];
    end;
  end;
  arr[1,0]:=arr[0,1];
  arr[2,0]:=arr[0,2];
  arr[2,1]:=arr[1,2];

  GaussSolve(arr);

  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if mask_remove[i,j] then
        p[i,j]:=p[i,j]-(arr[0,3]*i+arr[1,3]*j+arr[2,3]);
  Finalize(arr);
end;

procedure TiltRemove(var p, b: TMyInfernalType; var _a, _b, _c: treal); overload;
var
    arr: TDoubleArray;
    i, j, w, h: integer;
begin
  SetLength(arr,3,4);
  w:=p.w;
  h:=p.h;
  for i:=0 to h-1 do
  begin
    for j:=0 to w-1 do
    if b.b^[i*w+j]=1 then
    begin
      arr[0,0]:=arr[0,0]+sqr(i);
      arr[0,1]:=arr[0,1]+i*j;
      arr[0,2]:=arr[0,2]+i;
      arr[0,3]:=arr[0,3]+i*p.a^[i*w+j];
      arr[1,1]:=arr[1,1]+sqr(j);
      arr[1,2]:=arr[1,2]+j;
      arr[1,3]:=arr[1,3]+j*p.a^[i*w+j];
      arr[2,2]:=arr[2,2]+1;
      arr[2,3]:=arr[2,3]+p.a^[i*w+j];
    end;
  end;
  arr[1,0]:=arr[0,1];
  arr[2,0]:=arr[0,2];
  arr[2,1]:=arr[1,2];

  GaussSolve(arr);
  _a:=arr[0,3];
  _b:=arr[1,3];
  _c:=arr[2,3];

  Finalize(arr);
end;

procedure TiltRemove(var p: TDoubleArray; var mask: TBoolArray); overload;
var
    arr: TDoubleArray;
    i,j: integer;
begin
  SetLength(arr,3,4);

  {for i:=0 to length(arr)-1 do
    for j:=0 to length(arr[0])-1 do
    arr[i,j]:=0;}

  for i:=0 to length(p)-1 do
  begin
    for j:=0 to length(p[0])-1 do
    if mask[i,j] then
    begin
      arr[0,0]:=arr[0,0]+sqr(i);
      arr[0,1]:=arr[0,1]+i*j;
      arr[0,2]:=arr[0,2]+i;
      arr[0,3]:=arr[0,3]+i*p[i,j];
      arr[1,1]:=arr[1,1]+sqr(j);
      arr[1,2]:=arr[1,2]+j;
      arr[1,3]:=arr[1,3]+j*p[i,j];
      arr[2,2]:=arr[2,2]+1;
      arr[2,3]:=arr[2,3]+p[i,j];
    end;
  end;
  arr[1,0]:=arr[0,1];
  arr[2,0]:=arr[0,2];
  arr[2,1]:=arr[1,2];

  GaussSolve(arr);

  for i:=0 to length(p)-1 do
    for j:=0 to length(p[0])-1 do
    p[i,j]:=p[i,j]-(arr[0,3]*i+arr[1,3]*j+arr[2,3]);
  Finalize(arr);
end;

procedure TiltRemove(var p, mask_define, mask_remove: TRealArray; height, width: word); overload;
var
    arr: TDoubleArray;
    i,j: integer;
begin
  SetLength(arr,3,4);

  for i:=0 to height-1 do
  begin
    for j:=0 to width-1 do
    if mask_define[i*width+j] = 1 then
    begin
      arr[0,0]:=arr[0,0]+sqr(i);
      arr[0,1]:=arr[0,1]+i*j;
      arr[0,2]:=arr[0,2]+i;
      arr[0,3]:=arr[0,3]+i*p[i*width+j];
      arr[1,1]:=arr[1,1]+sqr(j);
      arr[1,2]:=arr[1,2]+j;
      arr[1,3]:=arr[1,3]+j*p[i*width+j];
      arr[2,2]:=arr[2,2]+1;
      arr[2,3]:=arr[2,3]+p[i*width+j];
    end;
  end;
  arr[1,0]:=arr[0,1];
  arr[2,0]:=arr[0,2];
  arr[2,1]:=arr[1,2];

  GaussSolve(arr);

  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if mask_remove[i*width+j] = 1 then
        p[i*width+j]:=p[i*width+j]-(arr[0,3]*i+arr[1,3]*j+arr[2,3]);
  Finalize(arr);
end;

procedure InvertMask(var b: TBoolArray);
var i,j: word;
begin
  for i:=0 to length(b)-1 do
    for j:=0 to Length(b[0])-1 do
      b[i,j]:= not b[i,j];
end;

procedure TiltRemove(var p: TRealArray; var mask_define, mask_remove: TBoolArray; height, width: word);
var
    arr: TDoubleArray;
    i,j: integer;
begin
  SetLength(arr,3,4);

  {for i:=0 to length(arr)-1 do
    for j:=0 to length(arr[0])-1 do
    arr[i,j]:=0;                   }

  for i:=0 to height-1 do
  begin
    for j:=0 to width-1 do
    if mask_define[i,j] then
    begin
      arr[0,0]:=arr[0,0]+sqr(i);
      arr[0,1]:=arr[0,1]+i*j;
      arr[0,2]:=arr[0,2]+i;
      arr[0,3]:=arr[0,3]+i*p[i*width+j];
      arr[1,1]:=arr[1,1]+sqr(j);
      arr[1,2]:=arr[1,2]+j;
      arr[1,3]:=arr[1,3]+j*p[i*width+j];
      arr[2,2]:=arr[2,2]+1;
      arr[2,3]:=arr[2,3]+p[i*width+j];
    end;
  end;
  arr[1,0]:=arr[0,1];
  arr[2,0]:=arr[0,2];
  arr[2,1]:=arr[1,2];

  GaussSolve(arr);

  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if mask_remove[i,j] then
        p[i*width+j]:=p[i*width+j]-(arr[0,3]*i+arr[1,3]*j+arr[2,3]);
  Finalize(arr);
end;




procedure AreaBounds(var b: TBoolArray; var minx, miny, maxx, maxy: integer); overload;
var i,j: integer;
begin
  minx:=length(b[0]); miny:=length(b);
  maxx:=0; maxy:=0;
  for i:=0 to length(b)-1 do
    for j:=0 to length(b[0])-1 do
      if b[i,j] then
      begin
        if j < minx then minx:=j;
        if i < miny then miny:=i;
        if j > maxx then maxx:=j;
        if i > maxy then maxy:=i;
      end;
end;

procedure AreaBounds(var b: TBtArr; width, height: integer; var minx, miny, maxx, maxy: integer); overload;
var i,j: integer;
begin
  minx:=width; miny:=height;
  maxx:=0; maxy:=0;
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if b[i*width+j] <> 0 then
      begin
        if j < minx then minx:=j;
        if i < miny then miny:=i;
        if j > maxx then maxx:=j;
        if i > maxy then maxy:=i;
      end;
end;

procedure AreaBounds(var p: TRealArray; width, height: integer; var minx, miny, maxx, maxy: integer); overload;
var i,j: integer;
begin
  minx:=width; miny:=height;
  maxx:=0; maxy:=0;
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if p[i*width+j] <> 0 then
      begin
        if j < minx then minx:=j;
        if i < miny then miny:=i;
        if j > maxx then maxx:=j;
        if i > maxy then maxy:=i;
      end;
end;

procedure DrawCirc(x0, y0, r: double; image: TImage; color: TColor);
var i, tmp, l1, l2: word;
begin
  image.Canvas.Pen.Color:=color;
  l1:=round(x0-r/sqrt(2));
  l2:=round(x0+r/sqrt(2));
  for i:=l1 to l2 do
  begin
      tmp:=round(sqrt(sqr(r)-sqr(i-x0)));
      Image.Canvas.Pixels[i, round(y0)+tmp]:=clRed;
      Image.Canvas.Pixels[i, round(y0)-tmp]:=clRed;
  end;
  l1:=round(y0-r/sqrt(2));
  l2:=round(y0+r/sqrt(2));
 for i:=l1 to l2 do
  begin
    tmp:=round(sqrt(sqr(r)-sqr(i-y0)));
    Image.Canvas.Pixels[round(x0)+tmp, i]:=clRed;
    Image.Canvas.Pixels[round(x0)-tmp, i]:=clRed;
  end;
end;

procedure DrawCross(x0, y0, d: double; image: TImage; color: TColor);
begin
  Image.Canvas.Pen.Color:=color;
  Image.Canvas.MoveTo(round(x0-d),round(y0));
  Image.Canvas.LineTo(round(x0+d),round(y0));
  Image.Canvas.MoveTo(round(x0),round(y0-d));
  Image.Canvas.LineTo(round(x0),round(y0+d));
end;

function RMS(var p: TRealArray; var b: TBoolArray; height, width: word): treal;
var i, j, n: integer;
    mean, s: treal;
begin
  n:=0;
  mean:=0;
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if b[i,j] then
      begin
        inc(n);
        mean:=mean+p[i*width+j];
      end;
  mean:=mean/n;
  s:=0;
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if b[i,j] then
        s:=sqr(p[i*width+j]-mean)+s;
  s:=sqrt(s/(n-1));
  Result:=s;
end;

function RMS(var p, mask: TMyInfernalType): treal; overload;
var i, j, n: integer;
    mean, s: treal;
begin
  n:=0;
  mean:=0;
  if p<>mask then
  begin
    case p._type of
      varDouble: begin
                   for i:=0 to p.h-1 do
                     for j:=0 to p.w-1 do
                       if mask.b^[i*p.w+j] = 1 then
                       begin
                         inc(n);
                         mean:=mean+p.a^[i*p.w+j];
                       end;
                   mean:=mean/n;
                   s:=0;
                   for i:=0 to p.h-1 do
                     for j:=0 to p.w-1 do
                       if mask.b^[i*p.w+j] = 1 then
                         s:=sqr(p.a^[i*p.w+j]-mean)+s;
                   s:=sqrt(s/(n-1));
                end;
    end;
  end
  else
  begin
    case p._type of
      varDouble: begin
                   for i:=p.y_img  to p.y_img+p.h_img-1 do
                     for j:=p.x_img to p.x_img+p.w_img-1 do
                     begin
                       inc(n);
                       mean:=mean+p.a^[i*p.w+j];
                     end;
                   mean:=mean/n;
                   s:=0;
                   for i:=p.y_img  to p.y_img+p.h_img-1 do
                     for j:=p.x_img to p.x_img+p.w_img-1 do
                       s:=sqr(p.a^[i*p.w+j]-mean)+s;
                   s:=sqrt(s/(n-1));
                 end;
    end;
  end;
  Result:=s;
end;


function RMS(var p, mask: TRealArray; height, width: word): treal;
var i, j, n: integer;
    mean, s: treal;
begin
  n:=0;
  mean:=0;
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if mask[i*width+j] = 1 then
      begin
        inc(n);
        mean:=mean+p[i*width+j];
      end;
  mean:=mean/n;
  s:=0;
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if mask[i*width+j] = 1 then
        s:=sqr(p[i*width+j]-mean)+s;
  s:=sqrt(s/(n-1));
  Result:=s;
end;

procedure CreateSMTCamBin(var p: TDoubleArray; var b: TBoolArray; multiple: Double; minx, miny, maxx, maxy: integer; name: string); overload;
var F : file;
  i, j, k, l : Short;
  PTemp : PSingleArray;
begin
  Assign(F, name);
  ReWrite(F, 1);
  // Пишем ширину
  i:=maxx-minx+1;
  BlockWrite(F, i, 2);
  // Пишем длину
  j:=maxy-miny+1;
  BlockWrite(F, j, 2);
  // Пишем данные
  GetMem(PTemp, i*j*SizeOf(Single));
  for k:=maxy to miny do
    for l:=maxx to minx do
      if b[k,l] then
        PTemp^[(k-miny)*i+l-minx]:=multiple*p[k,l]
      else
        PTemp^[(k-miny)*i+l-minx]:= -MaxSingle;
  BlockWrite(F, PTemp^,i*j*SizeOf(Single));
  FreeMem(PTemp,i*j*SizeOf(Single));
  // Закрываем файл
  Close(F);
end;

procedure CreateSMTCamBin(var p: TRealArray; var b: TBoolArray; multiple: Double; minx, miny, maxx, maxy, width, height: integer; name: string); overload;
var F : file;
  i, j, k, l : Short;
  PTemp : PSingleArray;
begin
  // Ассоциируем с именем
  Assign(F, name);
  // Открываем пересоздавая
  ReWrite(F, 1);
  // Пишем ширину
  i:=maxx-minx+1;
  BlockWrite(F, i, 2);
  // Пишем длину
  j:=maxy-miny+1;
  BlockWrite(F, j, 2);
  // Пишем данные
  GetMem(PTemp, i*j*SizeOf(Single));
  for k:=maxy downto miny do
    for l:=maxx downto minx do
      if b[k,l] then
        PTemp^[(k-miny)*i+l-minx]:=multiple*p[k*width+l]
      else
        PTemp^[(k-miny)*i+l-minx]:= -MaxSingle;
  BlockWrite(F, PTemp^,i*j*SizeOf(Single));
  FreeMem(PTemp,i*j*SizeOf(Single));
  // Закрываем файл
  Close(F);
end;

procedure LoadSMTCamBin(var p: PRealArray; var b: PBtArr; var m, n: integer; name: string); overload;
var
  f: file;
  width, height, i, j: Short;
  temp: PSingleArray;
begin
  assign(f, name);
  reset(f, 1);
  BlockRead(f, width, 2);
  BlockRead(f, height, 2);
  GetMem(temp, width*height*SizeOf(single));
  BlockRead(f, temp^, width*height*SizeOf(single));
//  if Length(p) <> 0 then Finalize(p);
//  if Length(b) <> 0 then Finalize(b);
  GetMem(p, width*height*SizeOf(treal));
  GetMem(b, width*height*SizeOf(tbt));
  ZeroMemory(b, width*height*SizeOf(tbt));
//  SetLength(p, height, width);
//  SetLength(b, height, width);
  for i:=0  to height-1 do
    for j:=0  to width-1 do
      if temp^[i*width+j] <> temp^[0] then
      begin
        p[i*width+j]:=temp^[i*width+j];
        b[i*width+j]:=1;
      end;
  Close(f);
  m:=height;
  n:=width;
  FreeMem(temp,width*height*SizeOf(single));
end;

procedure LoadSMTCamBin(var p: TDoubleArray; var b: TBoolArray; var m, n: integer; name: string); overload;
var
  f: file;
  width, height, i, j: Short;
  temp: PSingleArray;
begin
  assign(f, name);
  reset(f, 1);
  BlockRead(f, width, 2);
  BlockRead(f, height, 2);
  GetMem(temp, width*height*SizeOf(single));
  BlockRead(f, temp^, width*height*SizeOf(single));
  if Length(p) <> 0 then Finalize(p);
  if Length(b) <> 0 then Finalize(b);
  SetLength(p, height, width);
  SetLength(b, height, width);
  for i:=0  to height-1 do
    for j:=0  to width-1 do
      if temp^[i*width+j] <> temp^[0] then
      begin
        p[i,j]:=temp^[i*width+j];
        b[i,j]:=true;
      end;
  Close(f);
  m:=height;
  n:=width;
  FreeMem(temp,width*height*SizeOf(single));
end;

procedure LoadSMTCamBin(var p, b: PRealArray; var m, n: integer; name: string); overload;
var
  f: file;
  width, height, i, j: Short;
  temp: PSingleArray;
begin
  assign(f, name);
  reset(f, 1);
  BlockRead(f, width, 2);
  BlockRead(f, height, 2);
  GetMem(temp, width*height*SizeOf(single));
  BlockRead(f, temp^, width*height*SizeOf(single));
  GetMem(p, width*height*SizeOf(treal));
  GetMem(b, width*height*SizeOf(treal));
  ZeroMemory(b, width*height*SizeOf(treal));

  for i:=0  to height-1 do
    for j:=0  to width-1 do
      if temp^[i*width+j] <> temp^[0] then
      begin
        p^[i*width+j]:=temp^[i*width+j];
        b^[i*width+j]:=1;
      end;
  Close(f);
  m:=height;
  n:=width;
  FreeMem(temp,width*height*SizeOf(single));
end;

procedure CreateSMTCamBin(var p: TRealArray; width, height: integer; name: string); overload;
var f: file;
  i,j,k,l: Short;
  tmp: PSingleArray;
begin
  Assign(f,name);
  ReWrite(f,1);
  i:=width;
  BlockWrite(f,i,2);
  j:=height;
  BlockWrite(f,j,2);
  GetMem(tmp, height*width*SizeOf(Single));
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      tmp^[i*width+j]:=p[i*width+j];
  BlockWrite(f, tmp^,height*width*SizeOf(single));
  FreeMem(tmp, height*width*sizeof(single));
  Close(f);
end;


procedure CreateSMTCamBin(var p, b: TRealArray; multiple: Double; minx, miny, maxx, maxy, width, height: integer; name: string); overload;
var F : file;
  i, j, k, l : Short;
  PTemp : PSingleArray;
begin
  // Ассоциируем с именем
  Assign(F, name);
  // Открываем пересоздавая
  ReWrite(F, 1);
  // Пишем ширину
  i:=maxx-minx+1;
  BlockWrite(F, i, 2);
  // Пишем длину
  j:=maxy-miny+1;
  BlockWrite(F, j, 2);
  // Пишем данные
  GetMem(PTemp, i*j*SizeOf(Single));
  for k:=maxy downto miny do
    for l:=maxx downto minx do
      if b[k*width+l] <> 0 then
        PTemp^[(k-miny)*i+l-minx]:=multiple*p[k*width+l]
      else
        PTemp^[(k-miny)*i+l-minx]:= -MaxSingle;
  BlockWrite(F, PTemp^,i*j*SizeOf(Single));
  FreeMem(PTemp,i*j*SizeOf(Single));
  // Закрываем файл
  Close(F);
end;

procedure CreateBin(var p: TMyInfernalType; name: string); overload;
var f: file;
  i, j, w, h: Short;
  PTemp: PSingleArray;
begin
  Assign(f, name);
  ReWrite(f, 1);
  w:=p.w;
  BlockWrite(f, w, 2);
  h:=p.h;
  BlockWrite(f, h, 2);
  GetMem(PTemp, w*h*SizeOf(single));
  case p._type of
    varDouble: for i:=0 to h-1 do
                 for j:=0 to w-1 do
                   PTemp^[i*w+j]:=p.a^[i*w+j];

    varByte:  for i:=0 to h-1 do
                for j:=0 to w-1 do
                  PTemp^[i*w+j]:=p.b^[i*w+j];
  end;
  BlockWrite(f, PTemp^, w*h*SizeOf(single));
  FreeMem(PTemp, w*h*SizeOf(single));
  Close(f);
end;

procedure CreateBin(var b: TBoolArray; name: string); overload;
var F : file;
  i, j, width, height : word;
  PTemp : PRealArray;
begin
  Assign(F, name);
  ReWrite(F, 1);
  height:=length(b);
  BlockWrite(F, height, 2);
  width:=length(b[0]);
  BlockWrite(F, width, 2);

  GetMem(PTemp, width*height*SizeOf(treal));
  for i:=0  to height-1 do
    for j:=0 to width-1 do
      if b[i,j] then
        PTemp^[i*width+j]:=1
      else
        PTemp^[i*width+j]:=0;
  BlockWrite(F, PTemp^,width*height*SizeOf(treal));
  FreeMem(PTemp,width*height*SizeOf(treal));
  Close(F);  
end;

procedure AddValue2TextFile(p: TReal; name: string; n: integer);
var F: TextFile;
begin
  Assign(F, name);
  if FileExists(name) then
  begin
    Append(F);
  end
  else
    Rewrite(F);

  if n >= 0 then
    Write(F, n, ' ');
  Write(F, p:10:6,' ');
  Writeln(F);

  Close(F);
end;

procedure SaveSlice(var p: TBtArr; var path: TPath; width: integer; name: string; n: integer = -1); overload;
var F: TextFile;
    i: integer;
begin
  Assign(F, name);
  if FileExists(name) then
  begin
    Append(F);
  end
  else
    Rewrite(F);

  if n >= 0 then
    Write(F, n, ' ');
  for i:=0 to Length(path)-1 do
    Write(F, p[path[i].y*width+path[i].x],' ');
  Writeln(F);

  Close(F);
end;



procedure SaveSlice(var p: TDoubleArray; var path: TPath; name: string; n: integer);
var F: TextFile;
    i: integer;
begin
  Assign(F, name);
  if FileExists(name) then
  begin
    Append(F);
  end
  else
    Rewrite(F);

  if n >= 0 then
    Write(F, n, ' ');
  for i:=0 to Length(path)-1 do
    Write(F, p[path[i].y, path[i].x]:10:6,' ');
  Writeln(F);

  Close(F);
end;

procedure SaveSlice(var p: TRealArray; var path: TPath; width: integer; name: string; n: integer);
var F: TextFile;
    i: integer;
begin
  Assign(F, name);
  if FileExists(name) then
  begin
    Append(F);
  end
  else
    Rewrite(F);

  if n >= 0 then
    Write(F, n, ' ');
  for i:=0 to Length(path)-1 do
    Write(F, p[path[i].y*width+path[i].x]:10:6,' ');
  Writeln(F);

  Close(F);

end;

procedure Save2Pac(var p: TRealArray; minx, miny, maxx, maxy, width, height: integer; name: string);
var F : file;
  m, n: Short;
  PTemp : PRealArray;
begin
  Assign(F, name);
  n:=maxx-minx+1;
  m:=maxy-miny+1;
  GetMem(PTemp, m*n*sizeof(treal));
  CopyMemory(PTemp, @p[miny*width+minx], m*n*sizeof(treal));
  if FileExists(name) then
  begin
    Reset(F, 1);
    Seek(F, FileSize(F));
  end
  else
  begin
    Rewrite(F, 1);
    BlockWrite(F, n, SizeOf(short));
    BlockWrite(F, m, SizeOf(short));
  end;
  BlockWrite(F, PTemp^, m*n*sizeof(treal));
  FreeMem(PTemp, m*n*sizeof(treal));
  Close(F);
end;


procedure CreateBin(var p: TRealArray; var b: TBoolArray; multiple: Double; minx, miny, maxx, maxy, width, height: integer; name: string);
var F : file;
  i, j, k, l : Short;
  PTemp : PRealArray;
begin
  // Ассоциируем с именем
  Assign(F, name);
  // Открываем пересоздавая
  ReWrite(F, 1);
  // Пишем ширину
  i:=maxx-minx+1;
  BlockWrite(F, i, 2);
  // Пишем длину
  j:=maxy-miny+1;
  BlockWrite(F, j, 2);
  // Пишем данные
  GetMem(PTemp, i*j*SizeOf(treal));
  for k:=maxy downto miny do
    for l:=maxx downto minx do
      if b[k,l] then
        PTemp^[(k-miny)*i+l-minx]:=multiple*p[k*width+l]
      else
        PTemp^[(k-miny)*i+l-minx]:= -MaxSingle;
  BlockWrite(F, PTemp^,i*j*SizeOf(treal));
  FreeMem(PTemp,i*j*SizeOf( treal));
  // Закрываем файл
  Close(F);
end;

procedure LoadBii(var int: TMyInfernalType; num: integer; path: string);
var f: file;
  width, height: SHORT;
begin
  AssignFile(f, path);
  Reset(f, 1);
  BlockRead(f, width, sizeof(SHORT));
  BlockRead(f, height, sizeof(SHORT));
  int.Clear;
  int.Init(height, width, varByte);
  Seek(f, (num-1)*width*height+2*sizeof(SHORT));
  BlockRead(f, int.b^, width*height);
  CloseFile(f);
end;

procedure CreateBii(w, h: integer; int1, int2, int3: PBtArr; path: string); overload;
var f: file;
  width, height: SHORT;
begin
  AssignFile(f, path);
  Rewrite(f, 1);
  width:=w;
  height:=h;
  BlockWrite(f, width, sizeof(SHORT));
  BlockWrite(f, height, sizeof(SHORT));
  BlockWrite(f, int1^, width*height);
  BlockWrite(f, int2^, width*height);
  BlockWrite(f, int3^, width*height);
  CloseFile(f);
end;

procedure CreateBii(var int1, int2, int3: TMyInfernalType; path: string);
var f: file;
  width, height: SHORT;
begin
  AssignFile(f, path);
  Rewrite(f, 1);
  width:=int1.w;
  height:=int1.h;
  BlockWrite(f, width, sizeof(SHORT));
  BlockWrite(f, height, sizeof(SHORT));
  BlockWrite(f, int1.b^, width*height);
  BlockWrite(f, int2.b^, width*height);
  BlockWrite(f, int3.b^, width*height);
  CloseFile(f);
end;

procedure CreateMaskBin(var p: TRealArray; minx, miny, maxx, maxy, width, height: integer; name: string); overload;
var F : file;
  i, j, k, l : Short;
  PTemp : PByteArray;
begin
  Assign(F, name);
  ReWrite(F, 1);
  i:=maxx-minx+1;
  BlockWrite(F, i, 2);
  j:=maxy-miny+1;
  BlockWrite(F, j, 2);
  GetMem(PTemp, i*j);
  for k:=maxy downto miny do
    for l:=maxx downto minx do
       PTemp^[(k-miny)*i+l-minx]:=Round(p[k*width+l]);
  BlockWrite(F, PTemp^,i*j);
  FreeMem(PTemp,i*j);
  Close(F);
end;

procedure CreateBin(var p, b: TRealArray; multiple: Double; minx, miny, maxx, maxy, width, height: integer; name: string); overload;
var F : file;
  i, j, k, l : Short;
  PTemp : PRealArray;
begin
  Assign(F, name);
  ReWrite(F, 1);
  i:=maxx-minx+1;
  BlockWrite(F, i, 2);
  j:=maxy-miny+1;
  BlockWrite(F, j, 2);
  GetMem(PTemp, i*j*SizeOf(treal));
  for k:=maxy downto miny do
    for l:=maxx downto minx do
      if b[k*width+l] = 1 then
        PTemp^[(k-miny)*i+l-minx]:=multiple*p[k*width+l]
      else
        PTemp^[(k-miny)*i+l-minx]:= -MaxSingle;
  BlockWrite(F, PTemp^,i*j*SizeOf(treal));
  FreeMem(PTemp,i*j*SizeOf( treal));
  Close(F);
end;

procedure LoadBin(var b: TBoolArray; name: string); overload;
var F : file;
    i, j, width, height : word;
    PTemp : PRealArray;
begin
  Assign(F, name);
  ReSet(F, 1);
  BlockRead(F, height, 2);
  BlockRead(F, width, 2);
  GetMem(PTemp, width*height*SizeOf(treal));
  SetLength(b, height, width);
  BlockRead(F, PTemp^, width*height*SizeOf(treal));
  for i:=0  to height-1 do
    for j:=0 to width-1 do
      if PTemp^[i*width+j]=1 then
        b[i,j]:=true;
  FreeMem(PTemp,width*height*SizeOf(treal));
  Close(F);
end;

procedure SaveBin(var p: TRealArray; var b: TBtArr; minx, maxx, miny, maxy: integer; name: string; width, height: integer); overload;
var
  f: file;
  i, j, w, h: Short;
  PTemp: PRealArray;
begin
  Assign(f, name);
  Rewrite(f, 1);
  w:=maxx-minx+1;
  h:=maxy-miny+1;
  BlockWrite(f, w, 2);
  BlockWrite(f, h, 2);
  GetMem(PTemp, w*h*sizeof(treal));
  for i:=miny to maxy do
    for j:=minx to maxx do
      if b[i*width+j]=1 then
        PTemp^[i*w+j]:=p[i*width+j]
      else
        PTemp^[i*w+j]:=666;
  BlockWrite(f, PTemp^, w*h*sizeof(treal));
  FreeMem(PTemp, w*h*sizeof(treal));
end;

procedure SaveBin(var p: TDoubleArray; var b: TBoolArray; minx, maxx, miny, maxy: integer; name: string);
var
  f: file;
  i, j, w, h: Short;
  PTemp: PRealArray;
begin
  Assign(f, name);
  Rewrite(f, 1);
  w:=maxx-minx+1;
  h:=maxy-miny+1;
  BlockWrite(f, w, 2);
  BlockWrite(f, h, 2);
  GetMem(PTemp, w*h*sizeof(treal));
  for i:=miny to maxy do
    for j:=minx to maxx do
      if b[i,j] then
        PTemp^[i*w+j]:=p[i,j]
      else
        PTemp^[i*w+j]:=666;
  BlockWrite(f, PTemp^, w*h*sizeof(treal));
  FreeMem(PTemp, w*h*sizeof(treal));
end;

procedure LoadBin(var p: TDoubleArray; var b: TBoolArray; name: string);
var F : file;
  i, j, width, height: Short;
  PTemp : PRealArray;
begin
  Assign(F, name);
  ReSet(F, 1);
  BlockRead(F, width, 2);
  BlockRead(F, height, 2);
  GetMem(PTemp, width*height*SizeOf(treal));
  BlockRead(F, PTemp^, width*height*SizeOf(treal));
  SetLength(p, height, width);
  SetLength(b, height, width);
  for i:=0  to height-1 do
    for j:=0  to width-1 do
      if PTemp^[i*width+j]<>PTemp^[0] then
      begin
        p[i,j]:=PTemp^[i*width+j];
        b[i,j]:=true;
      end;
  Close(F);
  FreeMem(PTemp,i*j*SizeOf(treal));
end;



procedure LoadBin(p, b: PRealArray; width, height: integer; name: string); overload;
var F : file;
  i, j, w, h: Short;
  PTemp : PRealArray;
begin
  ZeroMemory(p, width*height*SizeOf(TReal));
  Assign(F, name);
  ReSet(F, 1);
  BlockRead(F, w, 2);
  BlockRead(F, h, 2);
  GetMem(PTemp, w*h*SizeOf(treal));
  BlockRead(F, PTemp^, w*h*SizeOf(treal));
  for i:=0  to h-1 do
    for j:=0  to w-1 do
      if b^[i*width+j] = 1 then
        p^[i*width+j]:=PTemp^[i*w+j];
  FreeMem(PTemp,w*h*SizeOf(treal));
  Close(F);
end;

procedure LoadMaskBin(p: PRealArray; width, height: integer; name: string); overload;
var F : file;
  i, j, w, h: Short;
  PTemp : PByteArray;
begin
  ZeroMemory(p, width*height*SizeOf(TReal));
  Assign(F, name);
  ReSet(F, 1);
  BlockRead(F, w, 2);
  BlockRead(F, h, 2);
  GetMem(PTemp, w*h);
  BlockRead(F, PTemp^, w*h);
  for i:=0  to h-1 do
    for j:=0  to w-1 do
      p^[i*width+j]:=PTemp^[i*w+j];
  FreeMem(PTemp,w*h);
  Close(F);
end;

function average(var p: TRealArray; var b: TBoolArray; height, width: word): TReal; overload;
var i,j: word;
    tmp: TReal;
    count: integer;
begin
  tmp:=0;
  count:=0;
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if b[i,j] then
        begin
          tmp:=tmp+p[i*width+j];
          inc(count);
        end;
   Result:=tmp/count;
end;

function average(var p: TRealArray; height, width: word): TReal; overload;
var i,j: word;
    tmp: TReal;
    count: integer;
begin
  tmp:=0;
  count:=0;
  for i:=0 to height-1 do
    for j:=0 to width-1 do
        begin
          tmp:=tmp+p[i*width+j];
          inc(count);
        end;
   Result:=tmp/count;
end;

procedure FringeRemove(var p: TRealArray; m, n, WinWidth: word);
var i,j: word;
    pcaFilt1 : PRealArray;
begin
  GetMem(pcaFilt1, m*n*2*SizeOf(TReal));
  Forward2dFFTReal(n, m, p, pcaFilt1^);
   for i:= 0 to m-1 do
    for j:= 0 to n-1 do begin
      pcaFilt1^[(i*n+j)*2] := pcaFilt1^[(i*n+j)*2]
        * (1-FltWin(Hypot(i-214,j-410), WinWidth, fwHann))
        * (1-FltWin(Hypot(i-361,j-357), WinWidth, fwHann))
        * (1-FltWin(Hypot(i-224,j-356), WinWidth, fwHann))
        * (1-FltWin(Hypot(i-351,j-411), WinWidth, fwHann));
      pcaFilt1^[(i*n+j)*2+1] := pcaFilt1^[(i*n+j)*2+1]
        * (1-FltWin(Hypot(i-214,j-410), WinWidth, fwHann))
        * (1-FltWin(Hypot(i-361,j-357), WinWidth, fwHann))
        * (1-FltWin(Hypot(i-224,j-356), WinWidth, fwHann))
        * (1-FltWin(Hypot(i-351,j-411), WinWidth, fwHann));
    end;
  Backward2dFFT(n,m, pcaFilt1^, pcaFilt1^);
  Complex2RealArray(n, m, pcaFilt1^, p, 4, True);
  FreeMem(pcaFilt1, m*n*2*SizeOf(TReal));
end;

procedure MNK_Circle(var p: TBtArr; var x, y, r: TReal; width, height: Integer); overload;
var
    arr: TDoubleArray;
    i,j: integer;
    t: TReal;
begin
  SetLength(arr,3,4);
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if p[i*width+j] = 1 then
      begin
        t:=sqr(i)+sqr(j);
        arr[0,0]:=arr[0,0]+sqr(j);
        arr[0,1]:=arr[0,1]+i*j;
        arr[0,2]:=arr[0,2]-j;
        arr[0,3]:=arr[0,3]+j*t;
        arr[1,1]:=arr[1,1]+sqr(i);
        arr[1,2]:=arr[1,2]-i;
        arr[1,3]:=arr[1,3]+i*t;
        arr[2,2]:=arr[2,2]-1;
        arr[2,3]:=arr[2,3]+t;
      end;
  arr[1,0]:=arr[0,1];
  arr[2,0]:=-arr[0,2];
  arr[2,1]:=-arr[1,2];
  GaussSolve(arr);
  x:=arr[0,3]/2;
  y:=arr[1,3]/2;
  r:=sqrt(sqr(x)+sqr(y)-arr[2,3]);
  Finalize(arr);
end;

procedure MNK_Circle(var p: TRealArray; var x, y, r: TReal; width, height: Integer);  overload;
var
    arr: TDoubleArray;
    i,j: integer;
    t: TReal;
begin
  SetLength(arr,3,4);
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if p[i*width+j] = 1 then
      begin
        t:=sqr(i)+sqr(j);
        arr[0,0]:=arr[0,0]+sqr(j);
        arr[0,1]:=arr[0,1]+i*j;
        arr[0,2]:=arr[0,2]-j;
        arr[0,3]:=arr[0,3]+j*t;
        arr[1,1]:=arr[1,1]+sqr(i);
        arr[1,2]:=arr[1,2]-i;
        arr[1,3]:=arr[1,3]+i*t;
        arr[2,2]:=arr[2,2]-1;
        arr[2,3]:=arr[2,3]+t;
      end;
  arr[1,0]:=arr[0,1];
  arr[2,0]:=-arr[0,2];
  arr[2,1]:=-arr[1,2];
  GaussSolve(arr);
  x:=arr[0,3]/2;
  y:=arr[1,3]/2;
  r:=sqrt(sqr(x)+sqr(y)-arr[2,3]);
  Finalize(arr);
end;

procedure MNK_Circle(var _x, _y: TMyInfernalType; var x, y, r: TReal);  overload;
var
    arr: TDoubleArray;
    i{,j}: integer;
    t: TReal;
begin
  SetLength(arr,3,4);
  for i:=0 to _x.w-1 do
  begin
    t:=sqr(_y.a^[i])+sqr(_x.a^[i]);
    arr[0,0]:=arr[0,0]+sqr(_x.a^[i]);
    arr[0,1]:=arr[0,1]+_x.a^[i]*_y.a^[i];
    arr[0,2]:=arr[0,2]-_x.a^[i];
    arr[0,3]:=arr[0,3]+_x.a^[i]*t;
    arr[1,1]:=arr[1,1]+sqr(_y.a^[i]);
    arr[1,2]:=arr[1,2]-_y.a^[i];
    arr[1,3]:=arr[1,3]+_y.a^[i]*t;
    arr[2,2]:=arr[2,2]-1;
    arr[2,3]:=arr[2,3]+t;
  end;
  arr[1,0]:=arr[0,1];
  arr[2,0]:=-arr[0,2];
  arr[2,1]:=-arr[1,2];
  GaussSolve(arr);
  x:=arr[0,3]/2;
  y:=arr[1,3]/2;
  r:=sqrt(sqr(x)+sqr(y)-arr[2,3]);
  Finalize(arr);
end;

procedure MNK_Circle(var p: TBoolArray; var x, y, r: TReal; width, height: Integer);  overload;
var
    arr: TDoubleArray;
    i,j: integer;
    t: TReal;
begin
  SetLength(arr,3,4);
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if p[i,j] then
      begin
        t:=sqr(i)+sqr(j);
        arr[0,0]:=arr[0,0]+sqr(j);
        arr[0,1]:=arr[0,1]+i*j;
        arr[0,2]:=arr[0,2]-j;
        arr[0,3]:=arr[0,3]+j*t;
        arr[1,1]:=arr[1,1]+sqr(i);
        arr[1,2]:=arr[1,2]-i;
        arr[1,3]:=arr[1,3]+i*t;
        arr[2,2]:=arr[2,2]-1;
        arr[2,3]:=arr[2,3]+t;
      end;
  arr[1,0]:=arr[0,1];
  arr[2,0]:=-arr[0,2];
  arr[2,1]:=-arr[1,2];
  GaussSolve(arr);
  x:=arr[0,3]/2;
  y:=arr[1,3]/2;
  r:=sqrt(sqr(x)+sqr(y)-arr[2,3]);
  Finalize(arr);
end;

procedure MNK_Sphere(var p: TDoubleArray; var b: TBoolArray; var x, y, z, r: TReal; c: TReal; width, height: Integer); overload;
var
    arr: TDoubleArray;
    i,j: integer;
    t: TReal;
begin
  SetLength(arr, 4, 5);
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if b[i,j] then
      begin
        t:=sqr(j*c)+sqr(i*c)+sqr(p[i,j]);
        arr[0,0]:=arr[0,0]+sqr(j*c);
        arr[0,1]:=arr[0,1]+i*j*sqr(c);
        arr[0,2]:=arr[0,2]+j*c*p[i,j];
        arr[0,3]:=arr[0,3]-j*c;
        arr[0,4]:=arr[0,4]+j*c*t;
        arr[1,1]:=arr[1,1]+sqr(i*c);
        arr[1,2]:=arr[1,2]+i*c*p[i,j];
        arr[1,3]:=arr[1,3]-i*c;
        arr[1,4]:=arr[1,4]+i*c*t;
        arr[2,2]:=arr[2,2]+sqr(p[i,j]);
        arr[2,3]:=arr[2,3]-p[i,j];
        arr[2,4]:=arr[2,4]+p[i,j]*t;
        arr[3,3]:=arr[3,3]-1;
        arr[3,4]:=arr[3,4]+t;
      end;
        arr[1,0]:=arr[0,1];
        arr[2,0]:=arr[0,2];
        arr[2,1]:=arr[1,2];
        arr[3,0]:=-arr[0,3];
        arr[3,1]:=-arr[1,3];
        arr[3,2]:=-arr[2,3];

        GaussSolve(arr);
        x:=arr[0,4]/2;
        y:=arr[1,4]/2;
        z:=arr[2,4]/2;
        r:=sqrt(sqr(x)+sqr(y)+sqr(z)-arr[3,4]);

        Finalize(arr);
end;

procedure MNK_Sphere(var p: TRealArray; var b: TBtArr; var x, y, z, r: TReal; c: TReal; width, height: Integer); overload;
var
    arr: TDoubleArray;
    i,j: integer;
    t: TReal;
begin
  SetLength(arr, 4, 5);
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if b[i*width+j] = 1 then
      begin
        t:=sqr(j*c)+sqr(i*c)+sqr(p[i*width+j]);
        arr[0,0]:=arr[0,0]+sqr(j*c);
        arr[0,1]:=arr[0,1]+i*j*sqr(c);
        arr[0,2]:=arr[0,2]+j*c*p[i*width+j];
        arr[0,3]:=arr[0,3]-j*c;
        arr[0,4]:=arr[0,4]+j*c*t;
        arr[1,1]:=arr[1,1]+sqr(i*c);
        arr[1,2]:=arr[1,2]+i*c*p[i*width+j];
        arr[1,3]:=arr[1,3]-i*c;
        arr[1,4]:=arr[1,4]+i*c*t;
        arr[2,2]:=arr[2,2]+sqr(p[i*width+j]);
        arr[2,3]:=arr[2,3]-p[i*width+j];
        arr[2,4]:=arr[2,4]+p[i*width+j]*t;
        arr[3,3]:=arr[3,3]-1;
        arr[3,4]:=arr[3,4]+t;
      end;
        arr[1,0]:=arr[0,1];
        arr[2,0]:=arr[0,2];
        arr[2,1]:=arr[1,2];
        arr[3,0]:=-arr[0,3];
        arr[3,1]:=-arr[1,3];
        arr[3,2]:=-arr[2,3];

        GaussSolve(arr);
        x:=arr[0,4]/2;
        y:=arr[1,4]/2;
        r:=sqrt(sqr(x)+sqr(y)+sqr(arr[2,4]/2)-arr[3,4]);

        Finalize(arr);
end;

procedure MNK_Sphere(var p, b: TRealArray; var x, y, z, r: TReal; c: TReal; width, height: Integer); overload;
var
    arr: TDoubleArray;
    i,j: integer;
    t: TReal;
begin
  SetLength(arr, 4, 5);
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if b[i*width+j] = 1 then
      begin
        t:=sqr(j*c)+sqr(i*c)+sqr(p[i*width+j]);
        arr[0,0]:=arr[0,0]+sqr(j*c);
        arr[0,1]:=arr[0,1]+i*j*sqr(c);
        arr[0,2]:=arr[0,2]+j*c*p[i*width+j];
        arr[0,3]:=arr[0,3]-j*c;
        arr[0,4]:=arr[0,4]+j*c*t;
        arr[1,1]:=arr[1,1]+sqr(i*c);
        arr[1,2]:=arr[1,2]+i*c*p[i*width+j];
        arr[1,3]:=arr[1,3]-i*c;
        arr[1,4]:=arr[1,4]+i*c*t;
        arr[2,2]:=arr[2,2]+sqr(p[i*width+j]);
        arr[2,3]:=arr[2,3]-p[i*width+j];
        arr[2,4]:=arr[2,4]+p[i*width+j]*t;
        arr[3,3]:=arr[3,3]-1;
        arr[3,4]:=arr[3,4]+t;
      end;
        arr[1,0]:=arr[0,1];
        arr[2,0]:=arr[0,2];
        arr[2,1]:=arr[1,2];
        arr[3,0]:=-arr[0,3];
        arr[3,1]:=-arr[1,3];
        arr[3,2]:=-arr[2,3];

        GaussSolve(arr);
        x:=arr[0,4]/2;
        y:=arr[1,4]/2;
        r:=sqrt(sqr(x)+sqr(y)+sqr(arr[2,4]/2)-arr[3,4]);

        Finalize(arr);
end;

procedure MNK_Sphere(var p: TRealArray; var b: TBoolArray; var x, y, r: TReal; c: TReal; width, height: Integer); overload;
var
    arr: TDoubleArray;
    i,j: integer;
    t: TReal;
begin
  SetLength(arr, 4, 5);
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if b[i,j] then
      begin
        t:=sqr(j*c)+sqr(i*c)+sqr(p[i*width+j]);
        arr[0,0]:=arr[0,0]+sqr(j*c);
        arr[0,1]:=arr[0,1]+i*j*sqr(c);
        arr[0,2]:=arr[0,2]+j*c*p[i*width+j];
        arr[0,3]:=arr[0,3]-j*c;
        arr[0,4]:=arr[0,4]+j*c*t;
        arr[1,1]:=arr[1,1]+sqr(i*c);
        arr[1,2]:=arr[1,2]+i*c*p[i*width+j];
        arr[1,3]:=arr[1,3]-i*c;
        arr[1,4]:=arr[1,4]+i*c*t;
        arr[2,2]:=arr[2,2]+sqr(p[i*width+j]);
        arr[2,3]:=arr[2,3]-p[i*width+j];
        arr[2,4]:=arr[2,4]+p[i*width+j]*t;
        arr[3,3]:=arr[3,3]-1;
        arr[3,4]:=arr[3,4]+t;
      end;
        arr[1,0]:=arr[0,1];
        arr[2,0]:=arr[0,2];
        arr[2,1]:=arr[1,2];
        arr[3,0]:=-arr[0,3];
        arr[3,1]:=-arr[1,3];
        arr[3,2]:=-arr[2,3];

        GaussSolve(arr);
        x:=arr[0,4]/2;
        y:=arr[1,4]/2;
        r:=sqrt(sqr(x)+sqr(y)+sqr(arr[2,4]/2)-arr[3,4]);

        Finalize(arr);
end;

function CreateGreyPalette: HPALETTE;
var
  i: integer;
  Pal: PLogPalette;
  ColorTable: ^TPaletteEntryArray;
begin
  GetMem(Pal, SizeOf(TLogPalette)+255*SizeOf(TPaletteEntry));
  Pal^.palVersion := $300;
  Pal^.palNumEntries := 256;
  ColorTable := Addr(Pal^.palPalEntry[0]);
  for i := 0 to 255 do begin
    ColorTable^[i].peRed:=i;
    ColorTable^[i].peGreen:=i;
    ColorTable^[i].peBlue:=i;
    ColorTable^[i].peFlags:=0;
  end;
  Result:=CreatePalette(Pal^);
  FreeMem(Pal, SizeOf(TLogPalette)+255*SizeOf(TPaletteEntry));
end;

function CreateColorPalette: HPALETTE;
var
  i: integer;
  Pal: PLogPalette;
  ColorTable: ^TPaletteEntryArray;
begin
  GetMem(Pal, SizeOf(TLogPalette)+255*SizeOf(TPaletteEntry));
  Pal^.palVersion := $300;
  Pal^.palNumEntries := 256;
  ColorTable := Addr(Pal^.palPalEntry[0]);
  for i:=0 to 255 do begin
   { if i < 43  then
    begin
      ColorTable^[i].peRed:=0;
      ColorTable^[i].peGreen:=0;
      ColorTable^[i].peBlue:=round(i*255/42);
      ColorTable^[i].peFlags:=0;
      continue;
    end;
    if i < 85  then
    begin
      ColorTable^[i].peRed:=0;
      ColorTable^[i].peGreen:=round((i-43)*255/41);
      ColorTable^[i].peBlue:=255;
      ColorTable^[i].peFlags:=0;
      continue;
    end;
    if i < 128  then
    begin
      ColorTable^[i].peRed:=0;
      ColorTable^[i].peGreen:=255;
      ColorTable^[i].peBlue:=round((127-i)*255/42);
      ColorTable^[i].peFlags:=0;
      continue;
    end;
    if i < 171  then
    begin
      ColorTable^[i].peRed:=round((i-128)*255/42);
      ColorTable^[i].peGreen:=255;
      ColorTable^[i].peBlue:=0;
      ColorTable^[i].peFlags:=0;
      continue;
    end;
    if i < 213  then
    begin
      ColorTable^[i].peRed:=255;
      ColorTable^[i].peGreen:=round((212-i)*255/41);
      ColorTable^[i].peBlue:=0;
      ColorTable^[i].peFlags:=0;
      continue;
    end;
    if i <= 255  then
    begin
      ColorTable^[i].peRed:=255;
      ColorTable^[i].peGreen:=round((i-213)*255/42);
      ColorTable^[i].peBlue:=round((i-213)*255/42);
      ColorTable^[i].peFlags:=0;
      continue;
    end; }
    if i <= 50 then
    begin
      ColorTable^[i].peRed:=0;
      ColorTable^[i].peGreen:=0;
      ColorTable^[i].peBlue:=round(i*255/50);
      ColorTable^[i].peFlags:=0;
      continue;
    end;
    if i <= 101 then
    begin
      ColorTable^[i].peRed:=0;
      ColorTable^[i].peGreen:=round((i-51)*255/50);
      ColorTable^[i].peBlue:=255;
      ColorTable^[i].peFlags:=0;
      continue;
    end;
    if i <= 152 then
    begin
      ColorTable^[i].peRed:=round((i-102)*255/50);
      ColorTable^[i].peGreen:=255;
      ColorTable^[i].peBlue:=round((152-i)*255/50);
      ColorTable^[i].peFlags:=0;
      continue;
    end;
    if i <= 203 then
    begin
      ColorTable^[i].peRed:=255;
      ColorTable^[i].peGreen:=round((203-i)*255/50);
      ColorTable^[i].peBlue:=0;
      ColorTable^[i].peFlags:=0;
      continue;
    end;
    if i <= 255 then
    begin
      ColorTable^[i].peRed:=255;
      ColorTable^[i].peGreen:=round((i-204)*255/51);
      ColorTable^[i].peBlue:=round((i-204)*255/51);
      ColorTable^[i].peFlags:=0;
      continue;
    end;

  end;
  Result:=CreatePalette(Pal^);
  FreeMem(Pal, SizeOf(TLogPalette)+255*SizeOf(TPaletteEntry));
end;

procedure FindBadPnts(var p: TPointerArray; var mask: TRealArray; width, height, k: integer);
var i,j,q: integer;
    mean, rms: PRealArray;
    filter: TFilter;
    temp: TBoolArray;
begin
  SetLength(temp, height, width);
  filter:=TFilter.Create(height, width);
  filter.Relatively:=true;
  filter.threshold:=0.3;
  filter.MedOrder:=3;
  GetMem(mean, width*height*sizeof(treal));
  GetMem(rms, width*height*sizeof(treal));
  ZeroMemory(mean, width*height*sizeof(treal));
  ZeroMemory(rms, width*height*sizeof(treal));
  for q:=0 to k-1 do
    for i:=0 to height-1 do
      for j:=0 to width-1 do
        if mask[i*width+j] = 1 then
          mean^[i*width+j]:=mean^[i*width+j]+p[q]^[i*width+j];
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if mask[i*width+j] = 1 then
        mean^[i*width+j]:=mean^[i*width+j]/k;
  for q:=0 to k-1 do
    for i:=0 to height-1 do
      for j:=0 to width-1 do
        if mask[i*width+j] = 1 then
          rms^[i*width+j]:=rms^[i*width+j]+sqr(p[q]^[i*width+j]-mean^[i*width+j]);
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if mask[i*width+j] = 1 then
        rms^[i*width+j]:=sqrt(rms^[i*width+j]/(k-1));
  filter.Init(rms^);
  filter.Processing([ffBinar, ffMed]);
  filter.GetBoolMask(temp, false);
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if not temp[i,j] then
       mask[i*width+j]:=0;

  CopyMemory(p[6], rms, width*height*sizeof(treal));
  filter.Destroy;
  Finalize(temp);
  FreeMem(mean, width*height*sizeof(treal));
  FreeMem(rms, width*height*sizeof(treal));
end;

procedure FindMin_Max(var min, max: TReal; var p: TBtArr; w, h: integer); overload;
var i: integer;
begin
   min:=MaxInt; max:=-MaxInt;
   for i:=0 to h*w-1 do
   begin
     if min > p[i] then min:=p[i];
     if max < p[i] then max:=p[i];
   end;
end;

procedure FindMin_Max(var min, max: TReal; var p: TRealArray; var mask: TBoolArray; width, height: word; var pmax, pmin: TPoint); overload;
var i, j: word;
begin
   min:=MaxDouble; max:=-MaxDouble;
   for i:=0 to height-1 do
     for j:=0 to width-1 do
     begin
       if mask[i,j] then
       begin
         if min > p[i*width+j] then
         begin
           min:=p[i*width+j];
           pmin.X:=j;
           pmin.Y:=i;
         end;
         if max < p[i*width+j] then
         begin
           max:=p[i*width+j];
           pmax.x:=j;
           pmax.Y:=i;
         end;
       end;
     end;
end;

procedure FindMin_Max(var min, max: TReal; var p: TRealArray; var mask: TBtArr; width, height: word); overload;
var i, j: integer;
begin
   min:=MaxInt; max:=-MaxInt;
   for i:=0 to height-1 do
     for j:=0 to width-1 do
     begin
       if mask[i*width+j]=1 then
       begin
         if min > p[i*width+j] then min:=p[i*width+j];
         if max < p[i*width+j] then max:=p[i*width+j];
       end;
     end;
end;


procedure FindMin_Max(var min, max: TReal; var p, mask: TBtArr; width, height: word); overload;
var i, j: integer;
begin
   min:=MaxInt; max:=-MaxInt;
   for i:=0 to height-1 do
     for j:=0 to width-1 do
     begin
       if mask[i*width+j]=1 then
       begin
         if min > p[i*width+j] then min:=p[i*width+j];
         if max < p[i*width+j] then max:=p[i*width+j];
       end;
     end;
end;

procedure MeanRms(var p, mask: TMyInfernalType; var mean, rms: treal);
var i,j: integer;
begin
  if p=mask then
    case p._type of
      varDouble: begin
                   mean:=0;
                   for i:=0 to p.h-1 do
                     for j:=0 to p.w-1 do
                       mean:=mean+p.a^[i*p.w+j];
                   mean:=mean/p.w/p.h;
                   rms:=0;
                   for i:=0 to p.h-1 do
                     for j:=0 to p.w-1 do
                       rms:=rms+sqr(p.a^[i*p.w+j]-mean);
                   rms:=sqrt(rms/(p.w*p.h-1));
                 end;
      varInteger:  begin
                     mean:=0;
                     for i:=0 to p.h-1 do
                       for j:=0 to p.w-1 do
                         mean:=mean+p.c^[i*p.w+j];
                     mean:=mean/p.w/p.h;
                     rms:=0;
                     for i:=0 to p.h-1 do
                       for j:=0 to p.w-1 do
                         rms:=rms+sqr(p.c^[i*p.w+j]-mean);
                     rms:=sqrt(rms/(p.w*p.h-1));
                   end;
      varByte: begin
                 mean:=0;
                 for i:=0 to p.h-1 do
                   for j:=0 to p.w-1 do
                     mean:=mean+p.b^[i*p.w+j];
                 mean:=mean/p.w/p.h;
                 rms:=0;
                 for i:=0 to p.h-1 do
                   for j:=0 to p.w-1 do
                     rms:=rms+sqr(p.b^[i*p.w+j]-mean);
                 rms:=sqrt(rms/(p.w*p.h-1));
               end;
    end
    else
      case p._type of
        varDouble: begin
                     mean:=0;
                     for i:=0 to p.h-1 do
                       for j:=0 to p.w-1 do
                         if mask.b^[i*mask.w+j] = 1 then
                           mean:=mean+p.a^[i*p.w+j];
                     mean:=mean/p.w/p.h;
                     rms:=0;
                     for i:=0 to p.h-1 do
                       for j:=0 to p.w-1 do
                         if mask.b^[i*mask.w+j] = 1 then
                           rms:=rms+sqr(p.a^[i*p.w+j]-mean);
                     rms:=sqrt(rms/(p.w*p.h-1));
                   end;
        varInteger:  begin
                       mean:=0;
                       for i:=0 to p.h-1 do
                         for j:=0 to p.w-1 do
                           if mask.b^[i*mask.w+j] = 1 then
                             mean:=mean+p.c^[i*p.w+j];
                       mean:=mean/p.w/p.h;
                       rms:=0;
                       for i:=0 to p.h-1 do
                         for j:=0 to p.w-1 do
                           if mask.b^[i*mask.w+j] = 1 then
                             rms:=rms+sqr(p.c^[i*p.w+j]-mean);
                       rms:=sqrt(rms/(p.w*p.h-1));
                     end;
        varByte:  begin
                    mean:=0;
                    for i:=0 to p.h-1 do
                      for j:=0 to p.w-1 do
                        if mask.b^[i*mask.w+j] = 1 then
                          mean:=mean+p.b^[i*p.w+j];
                    mean:=mean/p.w/p.h;
                    rms:=0;
                    for i:=0 to p.h-1 do
                      for j:=0 to p.w-1 do
                        if mask.b^[i*mask.w+j] = 1 then
                          rms:=rms+sqr(p.b^[i*p.w+j]-mean);
                    rms:=sqrt(rms/(p.w*p.h-1));
                  end;
      end;
end;

procedure SaveRealArray2Matlab(var p: TMyInfernalType; scale: treal; path: String);
var f: TextFile;
    i, j: integer;
begin
  Assign(f, path);
  Rewrite(f);
  Writeln(f, '%WinPhast generated file');
  Writeln(f, 'XSize=', p.w_img,';');
  Writeln(f, 'YSize=', p.h_img,';');
  Writeln(f, 'XUnits=''mkm'';');
  Writeln(f, 'YUnits=''mkm'';');
  Writeln(f, 'ZUnits=''nm'';');
  DecimalSeparator:='.';


  Writeln(f, 'XYScale='+FloatToStrF(scale, ffFixed, 5, 3),';');
  Write(f, 'Height=[');
  for i:=p.y_img to p.y_img+p.h_img-1 do
  begin
    for j:=p.x_img to p.x_img+p.w_img-1 do
    begin
      if i <> (p.y_img+p.h_img-1) then
      begin
        if j <> (p.x_img+p.w_img-1) then
          write(f, FloatToStrF(p.a^[i*p.w+j], ffFixed, 5, 3),' ')
        else
          writeln(f, FloatToStrF(p.a^[i*p.w+j], ffFixed, 5, 3),';')
      end
      else
      begin
        if j <> (p.x_img+p.w_img-1) then
          write(f, FloatToStrF(p.a^[i*p.w+j], ffFixed, 5, 3),' ')
        else
          writeln(f, FloatToStrF(p.a^[i*p.w+j], ffFixed, 5, 3),'];')
      end;
    end;

  end;
  Close(F);
end;

procedure SaveBin(var p, b: TMyInfernalType; name: string); overload;
var
  f: file;
  i, j, w, h: Short;
  PRealTemp: PRealArray;
  PByteTemp: PBtArr;
  PIntTemp: PIntegerArray;
begin
  Assign(f, name);
  Rewrite(f, 1);
  w:=p.w_img;
  h:=p.h_img;
  BlockWrite(f, w, 2);
  BlockWrite(f, h, 2);
  case p._type of
    varDouble: begin
                 GetMem(PRealTemp, w*h*sizeof(treal));
                 if p <> b then
                 begin
                   for i:=p.y_img to p.y_img+p.h_img-1 do
                     for j:=p.x_img to p.x_img+p.w_img-1 do
                       if b.b^[i*b.w+j]=1 then
                         PRealTemp^[(i-p.y_img)*w+j-p.x_img]:=p.a^[i*p.w+j]
                       else
                         PRealTemp^[(i-p.y_img)*w+j-p.x_img]:=666;
                 end
                 else
                   for i:=p.y_img to p.y_img+p.h_img-1 do
                     for j:=p.x_img to p.x_img+p.w_img-1 do
                       PRealTemp^[(i-p.y_img)*w+j-p.x_img]:=p.a^[i*p.w+j];
                 BlockWrite(f, PRealTemp^, w*h*sizeof(treal));
                 FreeMem(PRealTemp, w*h*sizeof(treal));
               end;
    varByte:  begin
                GetMem(PByteTemp, w*h*sizeof(tbt));
                if p <> b then
                begin
                  for i:=p.y_img to p.y_img+p.h_img-1 do
                    for j:=p.x_img to p.x_img+p.w_img-1 do
                      if b.b^[i*b.w+j]=1 then
                        PByteTemp^[(i-p.y_img)*w+j-p.x_img]:=p.b^[i*p.w+j]
                      else
                        PByteTemp^[(i-p.y_img)*w+j-p.x_img]:=255;
                end
                else
                  for i:=p.y_img to p.y_img+p.h_img-1 do
                    for j:=p.x_img to p.x_img+p.w_img-1 do
                      PByteTemp^[(i-p.y_img)*w+j-p.x_img]:=p.b^[i*p.w+j];
                BlockWrite(f, PByteTemp^, w*h*sizeof(tbt));
                FreeMem(PByteTemp, w*h*sizeof(tbt));
              end;
    varInteger:  begin
                   GetMem(PIntTemp, w*h*sizeof(integer));
                   if p <> b then
                   begin
                     for i:=p.y_img to p.y_img+p.h_img-1 do
                       for j:=p.x_img to p.x_img+p.w_img-1 do
                         if b.b^[i*b.w+j]=1 then
                           PIntTemp^[(i-p.y_img)*w+j-p.x_img]:=p.c^[i*p.w+j]
                         else
                           PIntTemp^[(i-p.y_img)*w+j-p.x_img]:=666;
                   end
                   else
                     for i:=p.y_img to p.y_img+p.h_img-1 do
                       for j:=p.x_img to p.x_img+p.w_img-1 do
                         PIntTemp^[(i-p.y_img)*w+j-p.x_img]:=p.c^[i*p.w+j];
                   BlockWrite(f, PIntTemp^, w*h*sizeof(integer));
                   FreeMem(PIntTemp, w*h*sizeof(integer));
                 end;
  end;
  Close(f);
end;

procedure LoadBin(var p, b: TMyInfernalType; var ScaleX, ScaleY: treal; name: string); overload;
var f: file;
    i, j, w, h: Short;
    tmp: PSingleArray;
    Scale: single;
begin
  AssignFile(f, name);
  Reset(f, 1);
  BlockRead(f, w, 2);
  BlockRead(f, h, 2);
  p.Clear;
  p.Init(h, w, varDouble);
  b.Clear;
  b.Init(h, w, varByte);
  GetMem(tmp, w*h*sizeof(single));
  BlockRead(f, tmp^, w*h*sizeof(single));
  for i:=0 to h-1 do
    for j:=0 to w-1 do
      if tmp^[i*w+j] > -10e5 then
      begin
        p.a^[i*w+j]:=tmp^[i*w+j];
        b.b^[i*w+j]:=1;
      end;
  BlockRead(f, Scale, 4);
  ScaleX:=Scale;
  BlockRead(f, Scale, 4);
  ScaleY:=Scale;
  FreeMem(tmp, w*h*sizeof(single));
  CloseFile(f);
end;

procedure LoadBin(var p, b: TMyInfernalType; name: string); overload;
var f: file;
    i, j, w, h: Short;
    tmp: PSingleArray;
begin
  AssignFile(f, name);
  Reset(f, 1);
  BlockRead(f, w, 2);
  BlockRead(f, h, 2);
  p.Clear;
  p.Init(h, w, varDouble);
  b.Clear;
  b.Init(h, w, varByte);
  GetMem(tmp, w*h*sizeof(single));
  BlockRead(f, tmp^, w*h*sizeof(single));
  for i:=0 to h-1 do
    for j:=0 to w-1 do
      if tmp^[i*w+j] > -10e15 then
      begin
        p.a^[i*w+j]:=tmp^[i*w+j];
        b.b^[i*w+j]:=1;
      end;

  FreeMem(tmp, w*h*sizeof(single));
  CloseFile(f);
end;

procedure LoadBin(var p: TMyInfernalType; _type: TVarType; name: string);
var f: file;
    i, j, w, h: Short;
    tmp: PSingleArray;
begin
  AssignFile(f, name);
  Reset(f, 1);
  BlockRead(f, w, 2);
  BlockRead(f, h, 2);


  GetMem(tmp, w*h*sizeof(single));
  BlockRead(f, tmp^, w*h*sizeof(single));
  case _type of
    varDouble: begin
                 p.Clear;
                 p.Init(h, w, varDouble);
                 for i:=0 to h-1 do
                   for j:=0 to w-1 do
                     p.a^[i*w+j]:=tmp^[i*w+j];
               end;
    varByte: begin
               p.Clear;
               p.Init(h, w, varByte);
               for i:=0 to h-1 do
                 for j:=0 to w-1 do
                   p.b^[i*w+j]:=round(tmp^[i*w+j]);
             end;
  end;

  FreeMem(tmp, w*h*sizeof(single));
  CloseFile(f);
end;


procedure LoadBin(var p: TMyInfernalType; name: string); overload;
var f: file;
    i, j, w, h: Short;
    tmp: PSingleArray;
begin
  AssignFile(f, name);
  Reset(f, 1);
  BlockRead(f, w, 2);
  BlockRead(f, h, 2);


  GetMem(tmp, w*h*sizeof(single));
  BlockRead(f, tmp^, w*h*sizeof(single));
  case p._type of
    varDouble: begin
                 p.Clear;
                 p.Init(h, w, varDouble);
                 for i:=0 to h-1 do
                   for j:=0 to w-1 do
                     p.a^[i*w+j]:=tmp^[i*w+j];
               end;
    varByte: begin
               p.Clear;
               p.Init(h, w, varByte);
               for i:=0 to h-1 do
                 for j:=0 to w-1 do
                   p.b^[i*w+j]:=round(tmp^[i*w+j]);
             end;
  end;

  FreeMem(tmp, w*h*sizeof(single));
  CloseFile(f);
end;

procedure LoadBin(var p, b, int: TMyInfernalType; name: string); overload;
var f: file;
  i, j, w, h: Short;
  PRealTemp: PRealArray;
  PByteTemp: PBtArr;
  PIntTemp: PIntegerArray;
begin
  if not FileExists(name) then
  begin
    ShowMessage('Неверно указан путь к файлу');
    exit;
  end;
  Assign(f,name);
  Reset(f,1);
  BlockRead(f,w,2);
  BlockRead(f,h,2);
  case p._type of
    varDouble: begin
                 GetMem(PRealTemp, w*h*sizeof(treal));
                 BlockRead(f, PRealTemp^, w*h*sizeof(treal));
                 p.Clear;
                 p.Init(h, w, varDouble);
                 if p <> b then
                 begin
                   b.Clear;
                   b.Init(h, w, varByte);
                   for i:=0 to h-1 do
                     for j:=0 to w-1 do
                       if PRealTemp^[i*w+j]<>PRealTemp^[0] then
                       begin
                         p.a^[i*p.w+j]:=PRealTemp^[i*w+j];
                         b.b^[i*b.w+j]:=1;
                       end;
                 end
                 else
                   for i:=0 to h-1 do
                     for j:=0 to w-1 do
                       p.a^[i*p.w+j]:=PRealTemp^[i*w+j];
                 FreeMem(PRealTemp, w*h*sizeof(treal));
               end;
    varByte:  begin
                GetMem(PByteTemp, w*h*sizeof(tbt));
                BlockRead(f, PByteTemp^, w*h*sizeof(tbt));
                p.Clear;
                if (int.w <= w) and (int.h <= h) then
                  p.Init(int.h_img, int.w_img, varByte)
                else
                begin
                  ShowMessage('Неверный формат файла');
                  exit;
                end;
                if p <> b then
                begin
                  b.Clear;
                  b.Init(h, w, varByte);
                  for i:=0 to h-1 do
                    for j:=0 to w-1 do
                      if PRealTemp^[i*w+j]<>PRealTemp^[0] then
                      begin
                        p.b^[i*p.w+j]:=PByteTemp^[i*w+j];
                        b.b^[i*b.w+j]:=1;
                      end;
                end
                else
                  for i:=int.y_img to int.y_img+int.h_img-1 do
                    for j:=int.x_img to int.x_img+int.w_img-1 do
                      p.b^[(i-int.y_img)*p.w+j-int.x_img]:=PByteTemp^[i*w+j];
                FreeMem(PByteTemp, w*h*sizeof(tbt));
              end;
    varInteger:  begin
                   GetMem(PIntTemp, w*h*sizeof(integer));
                   BlockRead(f, PIntTemp^, w*h*sizeof(integer));
                   p.Clear;
                   p.Init(h, w, varInteger);
                   if p <> b then
                   begin
                     b.Clear;
                     b.Init(h, w, varByte);
                     for i:=0 to h-1 do
                       for j:=0 to w-1 do
                         if PRealTemp^[i*w+j]<>PIntTemp^[0] then
                         begin
                           p.c^[i*p.w+j]:=PintTemp^[i*w+j];
                           b.b^[i*b.w+j]:=1;
                         end;
                   end
                   else
                     for i:=0 to h-1 do
                       for j:=0 to w-1 do
                         p.c^[i*p.w+j]:=PintTemp^[i*w+j];
                   FreeMem(PIntTemp, w*h*sizeof(integer));
                 end;
  end;
  Close(f);
end;

procedure FindPhaseApprox(var phase, amp, mask, steps: TMyInfernalType; var int: TPointerArray; Nsteps: integer); overload;
var n, i, w, h, k: integer;
    cos_steps, sin_steps: TMyInfernalType;
    arr1: PMatrixArray;
    k2, k3: treal;
begin
  n:=Nsteps;
  w:=phase.w;
  h:=phase.h;

  cos_steps:=TMyInfernalType.Create;
  sin_steps:=TMyInfernalType.Create;
  cos_steps.Init(1, n, varDouble);
  sin_steps.Init(1, n, varDouble);
  for i:=0 to n-1 do
  begin
    cos_steps.a^[i]:=cos(steps.a^[i]);
    sin_steps.a^[i]:=sin(steps.a^[i]);
  end;

  GetMem(arr1, w*h*sizeof(TMatrix));
  ZeroMemory(arr1, w*h*sizeof(TMatrix));

  for k:=0 to n-1 do
  begin
    arr1^[0][0,1]:=arr1^[0][0,1]+cos(steps.a^[k]);
    arr1^[0][0,2]:=arr1^[0][0,2]+sin(steps.a^[k]);
    arr1^[0][1,1]:=arr1^[0][1,1]+sqr(cos(steps.a^[k]));
    arr1^[0][1,2]:=arr1^[0][1,2]+cos(steps.a^[k])*sin(steps.a^[k]);
    arr1^[0][2,2]:=arr1^[0][2,2]+sqr(sin(steps.a^[k]));
  end;
  arr1^[0][0,0]:=n;
  arr1^[0][1,0]:=arr1^[0][0,1];
  arr1^[0][2,0]:=arr1^[0][0,2];
  arr1^[0][2,1]:=arr1^[0][1,2];

  for i:=1 to w*h-1 do
    if mask.b^[i] = 1 then
    begin
      arr1^[i][0,0]:=arr1^[0][0,0];
      arr1^[i][0,1]:=arr1^[0][0,1];
      arr1^[i][0,2]:=arr1^[0][0,2];
      arr1^[i][1,0]:=arr1^[0][1,0];
      arr1^[i][1,1]:=arr1^[0][1,1];
      arr1^[i][1,2]:=arr1^[0][1,2];
      arr1^[i][2,0]:=arr1^[0][2,0];
      arr1^[i][2,1]:=arr1^[0][2,1];
      arr1^[i][2,2]:=arr1^[0][2,2];
    end;

  for i:=0 to w*h-1 do
    if mask.b^[i] = 1 then
    begin
      arr1^[i][0,3]:=0;
      arr1^[i][1,3]:=0;
      arr1^[i][2,3]:=0;
      for k:=0 to n-1 do
      begin
        arr1^[i][0,3]:=arr1^[i][0,3]+int[k]^[i];
        arr1^[i][1,3]:=arr1^[i][1,3]+cos_steps.a^[k]*int[k]^[i];
        arr1^[i][2,3]:=arr1^[i][2,3]+sin_steps.a^[k]*int[k]^[i];
      end;

      SolveSystem3x4(arr1^[i], k2, k3);
      phase.a^[i]:=ArcTan2(k3, k2);
      amp.a^[i]:=Hypot(k3, k2);
    end;

  FreeMem(arr1, w*h*sizeof(TMatrix));
  cos_steps.Destroy;
  sin_steps.Destroy;

end;

procedure FindPhaseApprox(var phase, mask, steps: TMyInfernalType; var int: TMyInfernalArray; invert: boolean; Nsteps: integer); overload;
var n, i, w, h, k, sgn: integer;
    cos_steps, sin_steps: TMyInfernalType;
    arr1: PMatrixArray;
    k2, k3: treal;
begin
  n:=Nsteps;
  w:=phase.w;
  h:=phase.h;

  cos_steps:=TMyInfernalType.Create;
  sin_steps:=TMyInfernalType.Create;
  cos_steps.Init(1, n, varDouble);
  sin_steps.Init(1, n, varDouble);
  for i:=0 to n-1 do
  begin
    cos_steps.a^[i]:=cos(steps.a^[i]);
    sin_steps.a^[i]:=sin(steps.a^[i]);
  end;

  GetMem(arr1, w*h*sizeof(TMatrix));
  ZeroMemory(arr1, w*h*sizeof(TMatrix));

  for k:=0 to n-1 do
  begin
    arr1^[0][0,1]:=arr1^[0][0,1]+cos(steps.a^[k]);
    arr1^[0][0,2]:=arr1^[0][0,2]+sin(steps.a^[k]);
    arr1^[0][1,1]:=arr1^[0][1,1]+sqr(cos(steps.a^[k]));
    arr1^[0][1,2]:=arr1^[0][1,2]+cos(steps.a^[k])*sin(steps.a^[k]);
    arr1^[0][2,2]:=arr1^[0][2,2]+sqr(sin(steps.a^[k]));
  end;
  arr1^[0][0,0]:=n;
  arr1^[0][1,0]:=arr1^[0][0,1];
  arr1^[0][2,0]:=arr1^[0][0,2];
  arr1^[0][2,1]:=arr1^[0][1,2];

  for i:=1 to w*h-1 do
    if mask.b^[i] = 1 then
    begin
      arr1^[i][0,0]:=arr1^[0][0,0];
      arr1^[i][0,1]:=arr1^[0][0,1];
      arr1^[i][0,2]:=arr1^[0][0,2];
      arr1^[i][1,0]:=arr1^[0][1,0];
      arr1^[i][1,1]:=arr1^[0][1,1];
      arr1^[i][1,2]:=arr1^[0][1,2];
      arr1^[i][2,0]:=arr1^[0][2,0];
      arr1^[i][2,1]:=arr1^[0][2,1];
      arr1^[i][2,2]:=arr1^[0][2,2];
    end;

  if invert then
    sgn:=-1
  else
    sgn:=1;

  for i:=0 to w*h-1 do
    if mask.b^[i] = 1 then
    begin
      arr1^[i][0,3]:=0;
      arr1^[i][1,3]:=0;
      arr1^[i][2,3]:=0;
      for k:=0 to n-1 do
      begin
        arr1^[i][0,3]:=arr1^[i][0,3]+int[k].b^[i];
        arr1^[i][1,3]:=arr1^[i][1,3]+cos_steps.a^[k]*int[k].b^[i];
        arr1^[i][2,3]:=arr1^[i][2,3]+sin_steps.a^[k]*int[k].b^[i];
      end;

      SolveSystem3x4(arr1^[i], k2, k3);
      phase.a^[i]:=sgn*ArcTan2(k3, k2);
    end;

  FreeMem(arr1, w*h*sizeof(TMatrix));
  cos_steps.Destroy;
  sin_steps.Destroy;
end;

procedure FindPhase(var phase, mask: TMyInfernalType; var int: TMyInfernalArray); overload;
var b: TIntArray;
    i, j, k, order: integer;
    a2, a1: treal;
begin
  order:=length(int);
  SetLength(b, order-3, order);
  for i:=0 to 3 do
    b[0,i]:=round(Power(-1, i div 2));

  for i:=1 to order-4 do
  begin
    b[i,0]:=1;
    b[i,i+3]:=round(Power(-1, (i+3) div 2));
    for j:=1 to i+2 do
      b[i,j]:=(abs(b[i-1, j-1])+abs(b[i-1,j]))*round(Power(-1, j div 2));
  end;

  if mask = phase then
  begin
    for i:=0 to phase.h-1 do
      for j:=0 to phase.w-1 do
      begin
        a2:=0;
        a1:=0;
        for k:=0 to order-1 do
        begin
          if odd(k) then
            a2:=a2+int[k].b^[i*phase.w+j]*b[order-4, k]
          else
            a1:=a1+int[k].b^[i*phase.w+j]*b[order-4, k];
          end;
          phase.a^[i*phase.w+j]:=ArcTan2(a2, a1) + Pi;
      end;
  end
  else
  begin
    for i:=0 to phase.h-1 do
      for j:=0 to phase.w-1 do
        if mask.b^[i*mask.w+j]=1 then
        begin
          a2:=0;
          a1:=0;
          for k:=0 to order-1 do
          begin
            if odd(k) then
              a2:=a2+int[k].b^[i*phase.w+j]*b[order-4, k]
            else
              a1:=a1+int[k].b^[i*phase.w+j]*b[order-4, k];
            end;
            phase.a^[i*phase.w+j]:=ArcTan2(a2, a1) + Pi;
        end;
  end;
  Finalize(b);
end;


function PolyFit2(var x, y: TMyInfernalType; n: integer; x0: treal): treal;
var
   arr: TDoubleArray;
   i, j, k, w: integer;
   temp: treal;
begin
  w:=x.w;
  if w < (n+1) then
    exit;
  SetLength(arr, n+1, n+2);
  for i:=0 to n do
    for j:=i to n do
      for k:=0 to w-1 do
        arr[i,j]:=arr[i,j]+Power(x.a^[k], i+j);

  for i:=1 to n do
    for j:=0 to i-1 do
      arr[i,j]:=arr[j,i];

  for i:=0 to n do
    for k:=0 to w-1 do
      arr[i,n+1]:=arr[i,n+1]+y.a^[k]*Power(x.a^[k], i);

  GaussSolve(arr);

  temp:=0;
  for i:=0 to n do
    temp:=temp+arr[i,n+1]*Power(x0,i);

  Result:=temp;
  Finalize(arr);
end;

procedure PolyFit(var p, q: TMyInfernalType; order: byte);
var
   arr: TDoubleArray;
   i, j, k: integer;
   temp: treal;
begin
  if p.w < (order+1) then
    exit;

  SetLength(arr, order+1, order+2);
  for i:=0 to order do
    for j:=0 to order do
      for k:=0 to p.w-1 do
        arr[i,j]:=arr[i,j]+Power(k, 2*order-i-j);

  for i:=0 to order do
    for k:=0 to p.w-1 do
      arr[i, order+1]:=arr[i, order+1]+p.a^[k]*Power(k, order-i);

  GaussSolve(arr);

{  q.Clear;
  q.Init(1, p.w, varDouble);}

  for k:=0 to p.w-1 do
  begin
    temp:=0;
    for i:=0 to order do
      temp:=temp+arr[i, order+1]*Power(k, order-i);
    p.a^[k]:=p.a^[k]-temp;
//    q.a^[k]:=temp;
  end;


  Finalize(arr);
end;


procedure Find_Rz(var line, line_mask: TMyInfernalType; var Ra, Rz, Rmax: treal);
var i, N: integer;
 //   a, b, a1, a2, a3, a4: treal;
    _rz: array[0..9] of treal;
    cnt: integer;
begin
  N:=line.w;
  cnt:=0;
  for i:=0 to N-1 do
    if line_mask.b^[i]=1 then
      inc(cnt);

  if cnt < 2 then
    exit;
  {for i:=0 to N-1 do
  begin
    a1:=a1+i*line.a^[i];
    a2:=a2+sqr(i);
    a3:=a3+i;
    a4:=a4+line.a^[i];
  end;
  a:=(N*a1-a3*a4)/(N*a2-sqr(a3));
  b:=(a4-a*a3)/N;
  for i:=0 to N-1 do
    line.a^[i]:=line.a^[i]-a*i-b;}
  Ra:=0;
  for i:=0 to N-1 do
    if line_mask.b^[i]=1 then
      Ra:=Ra+abs(line.a^[i]);
  Ra:=Ra/cnt;

  _rz[0]:=0;
  _rz[5]:=0;
  for i:=1 to N-1 do
    if line_mask.b^[i]=1 then
    begin
      if line.a^[i] > _rz[0] then
      begin
        _rz[4]:=_rz[3];
        _rz[3]:=_rz[2];
        _rz[2]:=_rz[1];
        _rz[1]:=_rz[0];
        _rz[0]:=line.a^[i];
      end;

      if line.a^[i] < _rz[5] then
      begin
        _rz[9]:=_rz[8];
        _rz[8]:=_rz[7];
        _rz[7]:=_rz[6];
        _rz[6]:=_rz[5];
        _rz[5]:=line.a^[i];
      end;
    end;

  Rz:=0;
  for i:=0 to 9 do
    Rz:=Rz+abs(_rz[i]);
  Rz:=Rz/5;
  Rmax:=abs(_rz[0])+abs(_rz[5]);
end;


procedure Find_Rz(var line: TMyInfernalType; var Ra, Rz, Rmax: treal);
var i, N: integer;
 //   a, b, a1, a2, a3, a4: treal;
    _rz: array[0..9] of treal;
begin
  N:=line.w;
  if N < 2 then exit;
  {for i:=0 to N-1 do
  begin
    a1:=a1+i*line.a^[i];
    a2:=a2+sqr(i);
    a3:=a3+i;
    a4:=a4+line.a^[i];
  end;
  a:=(N*a1-a3*a4)/(N*a2-sqr(a3));
  b:=(a4-a*a3)/N;
  for i:=0 to N-1 do
    line.a^[i]:=line.a^[i]-a*i-b;}
  Ra:=0;
  for i:=0 to N-1 do
    Ra:=Ra+abs(line.a^[i]);
  Ra:=Ra/N;
  _rz[0]:=line.a^[0];
  _rz[5]:=_rz[0];
  for i:=1 to N-1 do
  begin
    if line.a^[i] > _rz[0] then
    begin
      _rz[4]:=_rz[3];
      _rz[3]:=_rz[2];
      _rz[2]:=_rz[1];
      _rz[1]:=_rz[0];
      _rz[0]:=line.a^[i];
    end;

    if line.a^[i] < _rz[5] then
    begin
      _rz[9]:=_rz[8];
      _rz[8]:=_rz[7];
      _rz[7]:=_rz[6];
      _rz[6]:=_rz[5];
      _rz[5]:=line.a^[i];
    end;
  end;
  Rz:=0;
  for i:=0 to 9 do
    Rz:=Rz+abs(_rz[i]);
  Rz:=Rz/5;
  Rmax:=abs(_rz[0])+abs(_rz[5]);
end;

function CheckVidCapDev: integer;
const IID_IPropertyBag: TGUID = '{55272A00-42CB-11CE-8135-00AA004BB851}';
var
  pClassEnum: ICreateDevEnum;
  pEnumCat: IEnumMoniker;
  pMoniker: IMoniker;
  pPropBag: IPropertyBag;
  varName: OleVariant;
  hr: HRESULT;
  count: integer;
  cFetched: Longint;
begin
  count:=0;
  CoCreateInstance(CLSID_SystemDeviceEnum, nil, CLSCTX_INPROC_SERVER, IID_ICreateDevEnum, pClassEnum);
  hr:=pClassEnum.CreateClassEnumerator(CLSID_VideoInputDeviceCategory, pEnumCat, 0);
  if hr = S_OK then
    begin
      while pEnumCat.Next(1, pMoniker, @cFetched) = S_OK do
        begin
			    pMoniker.BindToStorage(nil, nil, IID_IPropertyBag, pPropBag);
			    // Получаем имя устройства в виде текстовой строки
			    VariantInit(varName);
			    hr:=pPropBag.Read('FriendlyName', varName, nil);
			    if SUCCEEDED(hr) then
           inc(count);
          VariantClear(varName)
        end;
    end;
  pClassEnum:=nil;
  pEnumCat:=nil;
  pMoniker:=nil;
  pPropBag:=nil;
  Result:=count;
end;

procedure CreateBmp(var p: TMyInfernalType; scale: boolean; name: string);
var min, max, scl: treal;
    bmp: TBitmap;
    pb: PByteArray;
    i,j: integer;
begin
  bmp:=TBitmap.Create;
  bmp.PixelFormat:=pf8bit;
  bmp.Width:=p.w;
  bmp.Height:=p.h;
  bmp.Palette:=CreateBWPalette;
  if scale then
  begin
    FindMinMax(min, max, p, p{,Point(0,0), Point(p.w-1, p.h-1)});
    if min <> max then
      scl:=255/(max-min)
    else
      scl:=0;
  end
  else
  begin
    scl:=1;
    min:=0;
  end;

  case p._type of
    varDouble:  for i:=0 to p.h-1 do
                begin
                  pb:=bmp.ScanLine[i];
                  for j:=0 to p.w-1 do
                    pb^[j]:=round((p.a^[i*p.w+j]-min)*scl);
                end;
    varByte:  for i:=0 to p.h-1 do
              begin
                pb:=bmp.ScanLine[i];
                for j:=0 to p.w-1 do
                  pb^[j]:=round((p.b^[i*p.w+j]-min)*scl);
              end;
  end;

  bmp.SaveToFile(name);
  bmp.Destroy;
end;

procedure CreateBmp(w, h: integer; p: PRealArray; scale: boolean; name: string); overload;
var min, max, scl: treal;
    bmp: TBitmap;
    pb: PByteArray;
    i,j: integer;
begin
  bmp:=TBitmap.Create;
  bmp.PixelFormat:=pf8bit;
  bmp.Width:=w;
  bmp.Height:=h;
  bmp.Palette:=CreateBWPalette;
  if scale then
  begin
    FindMin_Max(min, max, p^, w, h);
    if min <> max then
      scl:=255/(max-min)
    else
      scl:=0;
  end
  else
  begin
    scl:=1;
    min:=0;
  end;
  for i:=0 to h-1 do
  begin
    pb:=bmp.ScanLine[i];
    for j:=0 to w-1 do
      pb^[j]:=round((p^[i*w+j]-min)*scl);
  end;

  bmp.SaveToFile(name);
  bmp.Destroy;

end;


procedure CreateBmp(w, h: integer; p: PBtArr; scale: boolean; name: string); overload;
var min, max, scl: treal;
    bmp: TBitmap;
    pb: PByteArray;
    i,j: integer;
begin
  bmp:=TBitmap.Create;
  bmp.PixelFormat:=pf8bit;
  bmp.Width:=w;
  bmp.Height:=h;
  bmp.Palette:=CreateBWPalette;
  if scale then
  begin
    FindMin_Max(min, max, p^, w, h);
    if min <> max then
      scl:=255/(max-min)
    else
      scl:=0;
  end
  else
  begin
    scl:=1;
    min:=0;
  end;
  for i:=0 to h-1 do
  begin
    pb:=bmp.ScanLine[i];
    for j:=0 to w-1 do
      pb^[j]:=round((p^[i*w+j]-min)*scl);
  end;

  bmp.SaveToFile(name);
  bmp.Destroy;

end;

procedure CreateBmp(w, h: integer; p: PBtArr; scale: boolean; Rotate: integer; name: string); overload;
var min, max, scl: treal;
    bmp: TBitmap;
    pb: PByteArray;
    i,j, h1, w1, tmp: integer;
begin
  bmp:=TBitmap.Create;
  bmp.PixelFormat:=pf8bit;
  bmp.Width:=h;
  bmp.Height:=w;
  bmp.Palette:=CreateBWPalette;
  if scale then
  begin
    FindMin_Max(min, max, p^, w, h);
    if min <> max then
      scl:=255/(max-min)
    else
      scl:=0;
  end
  else
  begin
    scl:=1;
    min:=0;
  end;
  
  h1:=w-1;
  w1:=h-1;
  for i:=0 to h1 do
  begin
    pb:=bmp.ScanLine[i];
    for j:=0 to w1 do
    begin
      if Rotate = 0 then
        tmp:=(w1-j)*w+h1-i
      else
        tmp:=j*w+i;
      pb^[j]:=round((p^[tmp]-min)*scl);
    end;
  end;

  bmp.SaveToFile(name);
  bmp.Destroy;

end;


procedure CreateBmp(var p, mask: TMyInfernalType; scale: boolean; Rotate: integer; name: string); overload;
var min, max, scl: treal;
    bmp: TBitmap;
    pb: PByteArray;
    i,j,w,h, h1, w1, tmp: integer;
begin
  w:=p.w;
  h:=p.h;
  bmp:=TBitmap.Create;
  bmp.PixelFormat:=pf8bit;
  bmp.Width:=h;
  bmp.Height:=w;
  bmp.Palette:=CreateBWPalette;
  if scale then
  begin
    FindMinMax(min, max, p, mask);
    if min <> max then
      scl:=255/(max-min)
    else
      scl:=0;
  end
  else
  begin
    scl:=1;
    min:=0;
  end;

  h1:=w-1;
  w1:=h-1;


  for i:=0 to h1 do
  begin
    pb:=bmp.ScanLine[i];
    for j:=0 to w1 do
    begin
      if Rotate = 0 then
        tmp:=(w1-j)*w+h1-i
      else
        tmp:=j*w+i;
      if mask.b^[tmp] = 1 then
        pb^[j]:=round((p.a^[tmp]-min)*scl)
      else
        pb^[j]:=255;
    end;
  end;

  bmp.SaveToFile(name);
  bmp.Destroy;

end;


procedure CreateBmp(var p, mask: TMyInfernalType; scale: boolean; name: string);
var min, max, scl: treal;
    bmp: TBitmap;
    pb: PByteArray;
    i,j,w,h: integer;
begin
  w:=p.w;
  h:=p.h;
  bmp:=TBitmap.Create;
  bmp.PixelFormat:=pf8bit;
  bmp.Width:=w;
  bmp.Height:=h;
  bmp.Palette:=CreateBWPalette;
  if scale then
  begin
    FindMinMax(min, max, p, mask);
    if min <> max then
      scl:=255/(max-min)
    else
      scl:=0;
  end
  else
  begin
    scl:=1;
    min:=0;
  end;
  for i:=0 to h-1 do
  begin
    pb:=bmp.ScanLine[i];
    for j:=0 to w-1 do
      if mask.b^[i*w+j] = 1 then
        pb^[j]:=round((p.a^[i*w+j]-min)*scl)
      else
        pb^[j]:=255;
  end;

  bmp.SaveToFile(name);
  bmp.Destroy;

end;

procedure Grad(var p: TMyInfernalType);
var temp_arr1, temp_arr2, b1, b2: TMyInfernalType;
    tmp1, tmp2: treal;
    i, w, j, h, k, l: integer;
begin
  w:=p.w;
  h:=p.h;
  b1:=TMyInfernalType.Create;
  b1.Init(3, 3, varDouble);
  b2:=TMyInfernalType.Create;
  b2.Init(3, 3, varDouble);
  temp_arr1:=TMyInfernalType.Create;
  temp_arr1.Init(h, w, varDouble);
  temp_arr2:=TMyInfernalType.Create;
  temp_arr2.Init(h, w, varDouble);
  CopyMemory(temp_arr1.a, p.a, w*h*sizeof(treal));
  CopyMemory(temp_arr2.a, p.a, w*h*sizeof(treal));
  b1.a^[0]:=-1;
  b1.a^[1]:=-2;
  b1.a^[2]:=-1;
  b1.a^[6]:=1;
  b1.a^[7]:=2;
  b1.a^[8]:=1;
  b2.a^[0]:=-1;
  b2.a^[2]:=1;
  b2.a^[3]:=-2;
  b2.a^[5]:=2;
  b2.a^[6]:=-1;
  b2.a^[8]:=1;
  for i:=1 to h-2 do
    for j:=1 to w-2 do
    begin
      tmp1:=0;
      tmp2:=0;
      for k:=i-1 to i+1 do
        for l:=j-1 to j+1 do
        begin
          tmp1:=tmp1+b1.a^[(k-i+1)*3+l-j+1]*p.a^[k*w+l];
          tmp2:=tmp2+b2.a^[(k-i+1)*3+l-j+1]*p.a^[k*w+l];
        end;
      temp_arr1.a^[i*w+j]:=tmp1;
      temp_arr2.a^[i*w+j]:=tmp2;
    end;
  for i:=0 to h*w-1 do
    p.a^[i]:=sqrt(sqr(temp_arr1.a^[i])+sqr(temp_arr2.a^[i]));

  temp_arr1.Destroy;
  temp_arr2.Destroy;
  b1.Destroy;
  b2.Destroy;
end;

procedure MedValve_Binar(var p: TMyInfernalType; order: integer); overload;
var b: TMyInfernalType;
    i,j,k,l, w, h, m1, m2, m3, m4, m5, m6, m7, m8: integer;
    m: treal;
begin
  w:=p.w;
  h:=p.h;
  m1:=order div 2;
  m2:=h-1-m1;
  m3:=w-1-m1;
  m8:=sqr(order) div 2;
  b:=TMyInfernalType.Create;
  b.Init(h, w, p._type);
  case p._type of
    varDouble: begin
                 for i:=m1 to m2 do
                   for j:=m1 to m3 do
                   begin
                     m:=0;
                     m4:=i-m1;
                     m5:=i+m1;
                     m6:=j-m1;
                     m7:=j+m1;
                       for k:=m4 to m5 do
                         for l:=m6 to m7 do
                           m:=m+p.a^[k*w+l];
                     if m > m8 then
                       b.a^[i*w+j]:=1;
                   end;
                 CopyMemory(p.a, b.a, w*h*sizeof(treal));
               end;
    varByte: begin
               for i:=m1 to m2 do
                 for j:=m1 to m3 do
                 begin
                   m:=0;
                   m4:=i-m1;
                   m5:=i+m1;
                   m6:=j-m1;
                   m7:=j+m1;
                     for k:=m4 to m5 do
                       for l:=m6 to m7 do
                         m:=m+p.b^[k*w+l];
                   if m > m8 then
                     b.b^[i*w+j]:=1;
                 end;
               CopyMemory(p.b, b.b, w*h*sizeof(tbt));
             end;
  end;
  b.Destroy;
end;

procedure CreateBin(var p, b: TMyInfernalType; name: string); overload;
var f: file;
  i, j, w, h: Short;
  PTemp: PSingleArray;
begin
  Assign(f, name);
  ReWrite(f, 1);
  w:=p.w;
  BlockWrite(f, w, 2);
  h:=p.h;
  BlockWrite(f, h, 2);
  GetMem(PTemp, w*h*SizeOf(single));
  for i:=0 to h-1 do
    for j:=0 to w-1 do
      if b.b^[i*w+j] = 1 then
        PTemp^[i*w+j]:=p.a^[i*w+j]
      else
        PTemp^[i*w+j]:= -MaxSingle;
  BlockWrite(f, PTemp^, w*h*SizeOf(single));
  FreeMem(PTemp, w*h*SizeOf(single));
  Close(f);
end;

procedure CreateBin(var p, b: TMyInfernalType; ScaleX, ScaleY: treal; Rotate: integer; name: string); overload
var f: file;
  i, j, w, h: Short;
  PTemp: PSingleArray;
  h1, w1, tmp: integer;
  Scale: single;
begin
  Assign(f, name);
  ReWrite(f, 1);
  w:=p.h;
  BlockWrite(f, w, 2);
  h:=p.w;
  BlockWrite(f, h, 2);
  GetMem(PTemp, w*h*SizeOf(single));
  h1:=h-1;
  w1:=w-1;

  for i:=0 to h1 do
    for j:=0 to w1 do
    begin
      if Rotate = 0 then
        tmp:={(w1-j)}j*h+h1-i
      else
        tmp:=j*h+i;
      if b.b^[tmp] = 1 then
        PTemp^[i*w+j]:=p.a^[tmp]
      else
        PTemp^[i*w+j]:= -MaxSingle;
    end;
  BlockWrite(f, PTemp^, w*h*SizeOf(single));
  Scale:=ScaleX;
  BlockWrite(f, Scale, 4);
  Scale:=ScaleY;
  BlockWrite(f, Scale, 4);
  FreeMem(PTemp, w*h*SizeOf(single));
  Close(f);
end;

procedure CreateBin(var p, b: TMyInfernalType; ScaleX, ScaleY: treal; name: string); overload
var f: file;
  i, j, w, h: Short;
  PTemp: PSingleArray;
  h1, w1, tmp: integer;
  Scale: single;
begin
  Assign(f, name);
  ReWrite(f, 1);
  w:=p.w;
  BlockWrite(f, w, 2);
  h:=p.h;
  BlockWrite(f, h, 2);
  GetMem(PTemp, w*h*SizeOf(single));

  for i:=0 to h-1 do
    for j:=0 to w-1 do
    begin
      tmp:=i*w+j;
      if b.b^[tmp] = 1 then
        PTemp^[tmp]:=p.a^[tmp]
      else
        PTemp^[tmp]:= -MaxSingle;
    end;
  BlockWrite(f, PTemp^, w*h*SizeOf(single));
  Scale:=ScaleX;
  BlockWrite(f, Scale, 4);
  Scale:=ScaleY;
  BlockWrite(f, Scale, 4);
  FreeMem(PTemp, w*h*SizeOf(single));
  Close(f);
end;

procedure CreateBin(var p, b: TMyInfernalType; Rotate: integer; name: string); overload
var f: file;
  i, j, w, h: Short;
  PTemp: PSingleArray;
  h1, w1, tmp: integer;
begin
  Assign(f, name);
  ReWrite(f, 1);
  w:=p.h;
  BlockWrite(f, w, 2);
  h:=p.w;
  BlockWrite(f, h, 2);
  GetMem(PTemp, w*h*SizeOf(single));
  h1:=h-1;
  w1:=w-1;

  for i:=0 to h1 do
    for j:=0 to w1 do
    begin
      if Rotate = 0 then
        tmp:=(w1-j)*h+h1-i
      else
        tmp:=j*h+i;
      if b.b^[tmp] = 1 then
        PTemp^[i*w+j]:=p.a^[tmp]
      else
        PTemp^[i*w+j]:= -MaxSingle;
    end;
  BlockWrite(f, PTemp^, w*h*SizeOf(single));
  FreeMem(PTemp, w*h*SizeOf(single));
  Close(f);
end;

procedure LoadBmp(var p: TBtArr; w, h: integer; name: string);
var
    bmp: TBitmap;
    pb: PByteArray;
    i,j: integer;
begin
  bmp:=TBitmap.Create;
  bmp.PixelFormat:=pf8bit;
  bmp.LoadFromFile(name);
  for i:=0 to h-1 do
  begin
    pb:=bmp.ScanLine[i];
    for j:=0 to w-1 do
      p[i*w+j]:=pb^[j];
  end;
  bmp.Destroy;
end;

procedure LoadBmp(var p: TMyInfernalType; name: string; _type: TVarType);
var
    bmp: TBitmap;
    pb: PByteArray;
    i,j: integer;
begin
  bmp:=TBitmap.Create;
  bmp.PixelFormat:=pf8bit;
  bmp.LoadFromFile(name);
  p.Clear;
  p.Init(bmp.Height, bmp.Width, _type);

  case _type of
    varDouble:  for i:=0 to p.h-1 do
                begin
                  pb:=bmp.ScanLine[i];
                  for j:=0 to p.w-1 do
                    p.a^[i*p.w+j]:=pb^[j];
                end;
    varByte:  for i:=0 to p.h-1 do
              begin
                pb:=bmp.ScanLine[i];
                for j:=0 to p.w-1 do
                  p.b^[i*p.w+j]:=pb^[j];
              end;
  end;
  bmp.Destroy;
end;

procedure Dilatation(var p: TMyInfernalType; order: byte); overload;
var temp_arr, b: TMyInfernalType;
    max, tmp: TBt;
    r: treal;
    i, w, j, h, k, l, hh, m1, m2, m3, m4: integer;
begin
  hh:=order div 2;
  w:=p.w;
  h:=p.h;
  b:=TMyInfernalType.Create;
  b.Init(order, order, varByte);
  temp_arr:=TMyInfernalType.Create;
  temp_arr.Init(h, w, varByte);
  CopyMemory(temp_arr.b, p.b, w*h);

  for i:=0 to order-1 do
    for j:=0 to order-1 do
    begin
      r:=sqrt(sqr((order-1)/2-i)+sqr((order-1)/2-j));
      if r < (order-2)/2 then
        b.b^[i*order+j]:=1;
    end;

  for i:=hh to h-1-hh do
    for j:=hh to w-1-hh do
    begin
      max:=0;
      m1:=i-hh;
      m2:=i+hh;
      m3:=j-hh;
      m4:=j+hh;
      for k:=m1 to m2 do
        for l:=m3 to m4 do
        begin
          if b.b^[(k-m1)*order+l-m3] > 0 then
          begin
            tmp:=p.b^[k*w+l];
            if max < tmp then
              max:=tmp;
          end;
        end;
       temp_arr.b^[i*w+j]:=max;
    end;
  CopyMemory(p.b, temp_arr.b, w*h);
  temp_arr.Destroy;
  b.Destroy;
end;


procedure Errosion(var p: TMyInfernalType; order: byte);
var temp_arr, b: TMyInfernalType;
    min, tmp: TBt;
    r: treal;
    i, w, j, h, k, l, hh, m1, m2, m3, m4: integer;
begin
  hh:=order div 2;
  w:=p.w;
  h:=p.h;
  b:=TMyInfernalType.Create;
  b.Init(order, order, varByte);
  temp_arr:=TMyInfernalType.Create;
  temp_arr.Init(h, w, varByte);
  CopyMemory(temp_arr.b, p.b, w*h);

  for i:=0 to order-1 do
    for j:=0 to order-1 do
    begin
      r:=sqrt(sqr((order-1)/2-i)+sqr((order-1)/2-j));
      if r < (order-2)/2 then
        b.b^[i*order+j]:=1;
    end;

  for i:=hh to h-1-hh do
    for j:=hh to w-1-hh do
    begin
      min:=255;
      m1:=i-hh;
      m2:=i+hh;
      m3:=j-hh;
      m4:=j+hh;
      for k:=m1 to m2 do
        for l:=m3 to m4 do
        begin
          if b.b^[(k-m1)*order+l-m3] > 0 then
          begin
            tmp:=p.b^[k*w+l];
            if min > tmp then
              min:=tmp;
          end;
        end;
       temp_arr.b^[i*w+j]:=min;
    end;
  CopyMemory(p.b, temp_arr.b, w*h);
  temp_arr.Destroy;
  b.Destroy;
end;

procedure Errosion(w, h: integer; var p: PBtArr; order: byte); overload;
var temp_arr, b: TMyInfernalType;
    min, tmp: TBt;
    r: treal;
    i, j, k, l, hh, m1, m2, m3, m4: integer;
begin
  hh:=order div 2;
  b:=TMyInfernalType.Create;
  b.Init(order, order, varByte);
  temp_arr:=TMyInfernalType.Create;
  temp_arr.Init(h, w, varByte);
  CopyMemory(temp_arr.b, p, w*h);

  for i:=0 to order-1 do
    for j:=0 to order-1 do
    begin
      r:=sqrt(sqr((order-1)/2-i)+sqr((order-1)/2-j));
      if r < (order-1)/2 then
        b.b^[i*order+j]:=1;
    end;

  for i:=hh to h-1-hh do
    for j:=hh to w-1-hh do
    begin
      min:=255;
      m1:=i-hh;
      m2:=i+hh;
      m3:=j-hh;
      m4:=j+hh;
      for k:=m1 to m2 do
        for l:=m3 to m4 do
        begin
          if b.b^[(k-m1)*order+l-m3] > 0 then
          begin
            tmp:=p^[k*w+l];
            if min > tmp then
              min:=tmp;
          end;
        end;
       temp_arr.b^[i*w+j]:=min;
    end;
  CopyMemory(p, temp_arr.b, w*h);
  temp_arr.Destroy;
  b.Destroy;
end;

procedure MinMaxMask_temp(var p, mask, razn: TMyInfernalType; order: byte; t: treal);
var temp_arr, b: TMyInfernalType;
    max, min, tmp, sum: treal;
    i, w, j, h, k, l, hh, m1, m2, m3, m4, cnt: integer;
begin
  hh:=order div 2;
  w:=p.w;
  h:=p.h;
  b:=TMyInfernalType.Create;
  b.Init(order, order, varDouble);

  temp_arr:=TMyInfernalType.Create;
  temp_arr.Init(h, w, varDouble, 1);
  CopyMemory(temp_arr.a, p.a, w*h*sizeof(treal));

  for i:=0 to order-1 do
    for j:=0 to order-1 do
    begin
      tmp:=sqrt(sqr(hh-i)+sqr(hh-j));
      if tmp < (hh) then
        b.a^[i*order+j]:=1;
    end;

  for i:=hh to h-1-hh do
    for j:=hh to w-1-hh do
    if mask.b^[i*w+j]=1 then
    begin
      max:=-MaxInt;
      min:=MaxInt;
      m1:=i-hh;
      m2:=i+hh;
      m3:=j-hh;
      m4:=j+hh;
      cnt:=0;
      sum:=0;
      for k:=m1 to m2 do
        for l:=m3 to m4 do
        begin
          if (b.a^[(k-m1)*order+l-m3] > 0) and (mask.b^[i*w+j]=1) then
          begin
            inc(cnt);
            sum:=sum+p.a^[k*w+l];
            tmp:=razn.a^[k*w+l];
            if max < tmp then
              max:=tmp;
            if min > tmp then
              min:=tmp;
          end;
        end;
        if abs(max-min) > t then
          temp_arr.a^[i*w+j]:=razn.a^[i*w+j]+p.a^[i*w+j]{sum/cnt};
  //       mask.b^[i*w+j]:=0
    end;

  CopyMemory(p.a, temp_arr.a, w*h*sizeof(treal));
  temp_arr.Destroy;
  b.Destroy;
end;

procedure MeanFiltrMask(var p, mask, mask_out: TMyInfernalType; order: byte);
var {temp_arr,} b: TMyInfernalType;
    max, min, tmp, sum: treal;
    i, w, j, h, k, l, hh, m1, m2, m3, m4, cnt: integer;
begin
  hh:=order div 2;
  w:=p.w;
  h:=p.h;
  b:=TMyInfernalType.Create;
  b.Init(order, order, varDouble);
  mask_out.Clear;
  mask_out.Init(h, w, varByte, 0);

  for i:=0 to order-1 do
    for j:=0 to order-1 do
    begin
      tmp:=sqrt(sqr(hh-i)+sqr(hh-j));
      if tmp < (hh) then
        b.a^[i*order+j]:=1;
    end;

  for i:=hh to h-1-hh do
    for j:=hh to w-1-hh do
    if mask.b^[i*w+j] =1 then
    begin
      max:=-MaxInt;
      min:=MaxInt;
      m1:=i-hh;
      m2:=i+hh;
      m3:=j-hh;
      m4:=j+hh;
      cnt:=0;
      sum:=0;
      for k:=m1 to m2 do
        for l:=m3 to m4 do
        begin
          if (b.a^[(k-m1)*order+l-m3] > 0) and (mask.b^[k*w+l]=1) then
          begin
            inc(cnt);
            sum:=sum+p.a^[k*w+l];
          end;
        end;

      if abs(p.a^[i*w+j]-sum/cnt) > 1 then
        mask_out.b^[i*w+j]:=1;
    end;

 // CopyMemory(p.a, temp_arr.a, w*h*sizeof(treal));
 // temp_arr.Destroy;
  b.Destroy;
end;

procedure MeanFiltr(var p, mask: TMyInfernalType; order: byte);
var temp_arr, b: TMyInfernalType;
    max, min, tmp, sum: treal;
    i, w, j, h, k, l, hh, m1, m2, m3, m4, cnt: integer;
begin
  hh:=order div 2;
  w:=p.w;
  h:=p.h;
  b:=TMyInfernalType.Create;
  b.Init(order, order, varDouble);
  temp_arr:=TMyInfernalType.Create;
  temp_arr.Init(h, w, varDouble, 1);
  CopyMemory(temp_arr.a, p.a, w*h*sizeof(treal));

  for i:=0 to order-1 do
    for j:=0 to order-1 do
    begin
      tmp:=sqrt(sqr(hh-i)+sqr(hh-j));
      if tmp < (hh) then
        b.a^[i*order+j]:=1;
    end;

  for i:=hh to h-1-hh do
    for j:=hh to w-1-hh do
    if mask.b^[i*w+j] =1 then
    begin
      max:=-MaxInt;
      min:=MaxInt;
      m1:=i-hh;
      m2:=i+hh;
      m3:=j-hh;
      m4:=j+hh;
      cnt:=0;
      sum:=0;
      for k:=m1 to m2 do
        for l:=m3 to m4 do
        begin
          if (b.a^[(k-m1)*order+l-m3] > 0) and (mask.b^[i*w+j] =1) then
          begin
            inc(cnt);
            sum:=sum+p.a^[k*w+l];
          end;
        end;
      temp_arr.a^[i*w+j]:=sum/cnt;
    end;

  CopyMemory(p.a, temp_arr.a, w*h*sizeof(treal));
  temp_arr.Destroy;
  b.Destroy;
end;

procedure Obrabotka_Raznosti(var p, mask: TMyInfernalType; iter: byte; t: treal; var mean: treal); overload;
var temp_mask: TMyInfernalType;
    i, j, w, h, count: integer;
begin
  w:=p.w;
  h:=p.h;
  temp_mask:=TMyInfernalType.Create;
  temp_mask.InitByArray(mask);
 (* count:=0;
  mean:=0;
  for i:=0 to w*h-1 do
    if temp_mask.b^[i]{mask.b^[i]}=1 then
    begin
      inc(count);
      mean:=mean+p.a^[i];
    end;
  mean:=mean/count;    *)
  for j:=0 to iter-1 do
  begin
 //  temp_mask.Clear;
 //  temp_mask.Init(h, w, varByte);




   count:=0;
   mean:=0;
   for i:=0 to w*h-1 do
     if temp_mask.b^[i]=1 then
     begin
       inc(count);
       mean:=mean+p.a^[i];
     end;
   mean:=mean/count;

   for i:=0 to w*h-1 do
     if {mask.}temp_mask.b^[i] = 1 then
       if abs(p.a^[i]-mean) > t then
         temp_mask.b^[i]:=0;

  end;

  {for i:=0 to w*h-1 do
    mask.b^[i]:=mask.b^[i]*temp_mask.b^[i];}
  for i:=0 to w*h-1 do
    if mask.b^[i] <> temp_mask.b^[i] then
      mask.b^[i]:=1
    else
      mask.b^[i]:=0;
//  CopyMemory(mask.b, temp_mask.b, w*h);
  temp_mask.Destroy;
end;

procedure Obrabotka_Raznosti(var p, mask: TMyInfernalType; iter: byte; t: treal);
var temp_mask: TMyInfernalType;
    mean: treal;
    i, j, w, h, count: integer;
begin
  w:=p.w;
  h:=p.h;
  temp_mask:=TMyInfernalType.Create;
  temp_mask.InitByArray(mask);
  {count:=0;
  mean:=0;
  for i:=0 to w*h-1 do
    if mask.b^[i]=1 then
    begin
      inc(count);
      mean:=mean+p.a^[i];
    end;
  mean:=mean/count;}
  for j:=0 to iter-1 do
  begin
    count:=0;
    mean:=0;
    for i:=0 to w*h-1 do
      if temp_mask.b^[i]=1 then
      begin
        inc(count);
        mean:=mean+p.a^[i];
      end;
    mean:=mean/count;
   {temp_mask.Clear;
   temp_mask.Init(h, w, varByte);}
   for i:=0 to w*h-1 do
     if temp_mask.b^[i] = 1 then
       if abs(p.a^[i]-mean) > t then
         temp_mask.b^[i]:=0;

  end;

  CopyMemory(mask.b, temp_mask.b, w*h);
  temp_mask.Destroy;
end;

procedure MinMaxMask(var p, mask: TMyInfernalType; order: byte; t: treal);
var temp_arr, b: TMyInfernalType;
    max, min, tmp: treal;
    i, w, j, h, k, l, hh, m1, m2, m3, m4: integer;
begin
  hh:=order div 2;
  w:=p.w;
  h:=p.h;
  b:=TMyInfernalType.Create;
  b.Init(order, order, varDouble);
  mask.Clear;
  mask.Init(h, w, varByte, 1);

  {temp_arr:=TMyInfernalType.Create;
  temp_arr.Init(h, w, varDouble, 1);}
  //CopyMemory(temp_arr.a, p.a, w*h*sizeof(treal));

  for i:=0 to order-1 do
    for j:=0 to order-1 do
    begin
      tmp:=sqrt(sqr(hh-i)+sqr(hh-j));
      if tmp < (hh) then
        b.a^[i*order+j]:=1;
    end;

  for i:=hh to h-1-hh do
    for j:=hh to w-1-hh do
    begin
      max:=-MaxInt;
      min:=MaxInt;
      m1:=i-hh;
      m2:=i+hh;
      m3:=j-hh;
      m4:=j+hh;
      for k:=m1 to m2 do
        for l:=m3 to m4 do
        begin
          if b.a^[(k-m1)*order+l-m3] > 0 then
          begin
            tmp:=p.a^[k*w+l];
            if max < tmp then
              max:=tmp;
            if min > tmp then
              min:=tmp;
          end;
        end;
        if abs(max-min) > t then
         mask.b^[i*w+j]:=0
    end;
  {CopyMemory(p.a, temp_arr.a, w*h*sizeof(treal));
  temp_arr.Destroy;}
  b.Destroy;
end;

procedure LoadStl(var facet: Pfacet; var nFasets: integer; path: string);
var f: file;
    s: string[79];
    n: LongWord;
begin
  AssignFile(f, path);
  Reset(f, 1);
  BlockRead(f, s, 80);
  BlockRead(f, n, 4);
  nFasets:=n;
  GetMem(facet, n*sizeof(Tfacet));
  BlockRead(f, facet^, n*sizeof(Tfacet));
  CloseFile(f);
end;

procedure SetLedBright(adr: Word; b: byte);
var r: array[0..7] of byte;
    i: integer;
    c, d: byte;
    s: string;
begin
  b:=255-b;
  for i:=0 to 7 do
  begin
    r[i]:=round(IntPower(2, i)) and b;
  end;
  c:=0;
  c:=r[0] xor 1;
  d:=0;
  for i:=0 to 7 do
  begin
    r[i]:=r[i] shr 1;
    d:=d or r[i];
  end;
  d:=d or 128;

  OutPort(adr+2, c);
  OutPort(adr, d);
  sleep(50);
  d:=d xor 128;
  OutPort(adr, d);
end;

procedure Lapl_with_highcontrast(p: PBtArr; w, h: integer); overload;
var temp_arr1, b1: TMyInfernalType;
    tmp1: treal;
    i, j, k, l, bias: integer;
begin
  bias:=-200;
  b1:=TMyInfernalType.Create;
  b1.Init(3, 3, varDouble);
  temp_arr1:=TMyInfernalType.Create;
  temp_arr1.Init(h, w, varByte);
  CopyMemory(temp_arr1.b, p, w*h);
  b1.a^[0]:=-1;
  b1.a^[1]:=-1;
  b1.a^[2]:=-1;
  b1.a^[3]:=-1;
  b1.a^[4]:=11;
  b1.a^[5]:=-1;
  b1.a^[6]:=-1;
  b1.a^[7]:=-1;
  b1.a^[8]:=-1;
  for i:=1 to h-2 do
    for j:=1 to w-2 do
    begin
      tmp1:=0;
      for k:=i-1 to i+1 do
        for l:=j-1 to j+1 do
          tmp1:=tmp1+b1.a^[(k-i+1)*3+l-j+1]*p^[k*w+l];
      tmp1:=tmp1+bias;
      if tmp1 < 0 then
        temp_arr1.b^[i*w+j]:=0
      else
      begin
        if tmp1 > 255 then
          temp_arr1.b^[i*w+j]:=255
        else
          temp_arr1.b^[i*w+j]:=round(tmp1);
      end;

//      temp_arr1.b^[i*w+j]:=round(tmp1+bias);
    end;
  CopyMemory(p, temp_arr1.b, w*h);
  temp_arr1.Destroy;
  b1.Destroy;
end;

procedure Lapl_with_highcontrast(var p: TMyInfernalType);
var temp_arr1, b1: TMyInfernalType;
    tmp1: treal;
    i, w, j, h, k, l, bias: integer;
begin
  w:=p.w;
  h:=p.h;
  bias:=-200;
  b1:=TMyInfernalType.Create;
  b1.Init(3, 3, varDouble);
  temp_arr1:=TMyInfernalType.Create;
  temp_arr1.Init(h, w, varByte);
  CopyMemory(temp_arr1.b, p.b, w*h);
  b1.a^[0]:=-1;
  b1.a^[1]:=-1;
  b1.a^[2]:=-1;
  b1.a^[3]:=-1;
  b1.a^[4]:=11;
  b1.a^[5]:=-1;
  b1.a^[6]:=-1;
  b1.a^[7]:=-1;
  b1.a^[8]:=-1;
  for i:=1 to h-2 do
    for j:=1 to w-2 do
    begin
      tmp1:=0;
      for k:=i-1 to i+1 do
        for l:=j-1 to j+1 do
          tmp1:=tmp1+b1.a^[(k-i+1)*3+l-j+1]*p.b^[k*w+l];
      tmp1:=tmp1+bias;
      if tmp1 < 0 then
        temp_arr1.b^[i*w+j]:=0
      else
      begin
        if tmp1 > 255 then
          temp_arr1.b^[i*w+j]:=255
        else
          temp_arr1.b^[i*w+j]:=round(tmp1);
      end;

//      temp_arr1.b^[i*w+j]:=round(tmp1+bias);
    end;
  CopyMemory(p.b, temp_arr1.b, w*h);
  temp_arr1.Destroy;
  b1.Destroy;
end;

procedure ExperimentalShit(p: PBtArr; w, h, width, height: integer); overload;
var temp: TMyInfernalType;
    i, j, k, l, m1, m2: integer;
    hist: array[0..255] of integer;
    max1, max2, ind1, ind2, t, raz1, raz2, sum, cnt: integer;
begin
  temp:=TMyInfernalType.Create;
  temp.Init(h, w, varByte);
  CopyMemory(temp.b, p, w*h);
  m1:=width div 2;
  m2:=height div 2;
  for i:=m2 to h-m2-1 do
    for j:=m1 to w-m1-1 do
    begin
      ZeroMemory(@hist[0], 256*sizeof(integer));
      for k:=i-m2 to i+m2 do
        for l:=j-m1 to j+m1 do
          inc(hist[p^[k*w+l]]);

      ind1:=0;
      for k:=0 to 255 do
      begin
        ind1:=k;
        if hist[k] <> 0 then
          break;
      end;

      ind2:=0;
      for k:=255 downto 0 do
      begin
        ind2:=k;
        if hist[k] <> 0 then
          break;
      end;

      temp.b^[i*w+j]:=round(abs(255*(p^[i*w+j]-ind1)/(ind2-ind1)));
    end;
    CopyMemory(p, temp.b, w*h);
  temp.Destroy;
end;


procedure ExperimentalShit(var p, b: TMyInfernalType); overload;
var temp: TMyInfernalType;
    i, j, k, l, m, w, h, m1, m2, width, height: integer;
    hist: array[0..255] of integer;
    max1, max2, ind1, ind2, t, raz1, raz2, sum, cnt: integer;
begin
  w:=p.w;
  h:=p.h;
  width:=b.w;
  height:=b.h;

  temp:=TMyInfernalType.Create;
  temp.InitByArray(p);
  m1:=width div 2;
  m2:=height div 2;
  for i:=m2 to h-m2-1 do
    for j:=m1 to w-m1-1 do
    begin
      ZeroMemory(@hist[0], 256*sizeof(integer));
      cnt:=0;
      for k:=i-m2 to i+m2 do
        for l:=j-m1 to j+m1 do
        if b.b^[(k-i+m2)*width+l-j+m1] = 255 then
        begin
          inc(hist[p.b^[k*w+l]]);
        end;
      max1:=0;
      ind1:=0;
      for k:=0 to 255 do
      begin
        ind1:=k;
        if hist[k] <> 0 then
          break;
      end;

      ind2:=0;
      for k:=255 downto 0 do
      begin
        ind2:=k;
        if hist[k] <> 0 then
          break;
      end;
      temp.b^[i*w+j]:=round(abs(255*(p.b^[i*w+j]-ind1)/(ind2-ind1)));
    end;
    CopyMemory(p.b, temp.b, w*h);
  temp.Destroy;
end;

procedure MedValve(p: PBtArr; w, h, width, height: Integer); overload;
var temp: TMyInfernalType;
    i, j, k, l, m: integer;
    tmp: treal;
    tmp_b: byte;
    m1, m2, m3, m4, q1, q2, ind: integer;
    hist: array[0..255] of integer;
begin
  temp:=TMyInfernalType.Create;
  temp.Init(h, w, varByte);
  CopyMemory(temp.b, p, w*h);
  m1:=width div 2;
  m2:=height div 2;
  m3:=width*height-1;
  m4:=(width*height div 2)+1;
  for i:=m2 to h-m2-1 do
    for j:=m1 to w-m1-1 do
    begin
      ZeroMemory(@hist[0], 256*sizeof(integer));
      for k:=i-m2 to i+m2 do
        for l:=j-m1 to j+m1 do
        begin
          inc(hist[p^[k*w+l]]);
        end;
      ind:=0;
      m:=0;
      while m < m4 do
      begin
        for k:=1 to hist[ind] do
          inc(m);
        inc(ind);
      end;
      temp.b^[i*w+j]:=ind-1;
    end;
  CopyMemory(p, temp.b, w*h);
  temp.Destroy;
end;

procedure MedValve(var p: TMyInfernalType; width, height: Integer); overload;
var temp: TMyInfernalType;
    i, j, k, l, m, w, h: integer;
    arr: TMyInfernalType;
    tmp: treal;
    tmp_b: byte;
    m1, m2, m3, m4, q1, q2, ind: integer;
    hist: array[0..255] of integer;
begin
  w:=p.w;
  h:=p.h;
  temp:=TMyInfernalType.Create;
  arr:=TMyInfernalType.Create;
  case p._type of
    varDouble: begin
                 arr.Init(1, width*height, varDouble);
                 temp.Init(h, w, varDouble);
                 CopyMemory(temp.a, p.a, w*h*sizeof(treal));
               end;
    varByte:  begin
                arr.Init(1, width*height, varByte);
                temp.Init(h, w, varByte);
                CopyMemory(temp.b, p.b, w*h);
              end;
  end;


  m1:=width div 2;
  m2:=height div 2;
  m3:=width*height-1;
  m4:=(width*height div 2)+1;

  case p._type of
    varDouble: begin
                 for i:=m2 to h-m2-1 do
                   for j:=m1 to w-m1-1 do
                   begin
                     m:=0;
                     ZeroMemory(@hist[0], 256*sizeof(integer));
                       for k:=i-m2 to i+m2 do
                         for l:=j-m1 to j+m1 do
                         begin
                           inc(hist[round(p.a^[k*w+l])]);
                           //arr.a^[m]:=p.a^[k*w+l];
                           //inc(m);
                         end;
                         ind:=0;
                         while m < m4 do
                         begin
                           for k:=1 to hist[ind] do
                             inc(m);
                           inc(ind);
                         end;



                         {for k:=0 to 255 do
                           for l:=1 to hist[k] do
                           begin
                             inc(m);
                             ind:=k;
                             if m=m4 then
                               Break;
                           end;}



                       {for k:=0 to m3-1 do
                         for l:=k+1 to m3 do
                           if arr.a^[k] < arr.a^[l] then
                           begin
                             tmp:=arr.a^[k];
                             arr.a^[k]:=arr.a^[l];
                             arr.a^[l]:=tmp;
                           end;}
                       temp.a^[i*w+j]:=ind-1;//arr.a^[m4];
                   end;
                 CopyMemory(p.a, temp.a, w*h*sizeof(treal));
               end;
    varByte:  begin
                for i:=m2 to h-m2-1 do
                  for j:=m1 to w-m1-1 do
                  begin
                    m:=0;
                      for k:=i-m2 to i+m2 do
                        for l:=j-m1 to j+m1 do
                        begin
                          arr.b^[m]:=p.b^[k*w+l];
                          inc(m);
                        end;
                      for k:=0 to m3-1 do
                        for l:=k+1 to m3 do
                          if arr.b^[k] < arr.b^[l] then
                          begin
                            tmp_b:=arr.b^[k];
                            arr.b^[k]:=arr.b^[l];
                            arr.b^[l]:=tmp_b;
                          end;
                      temp.b^[i*w+j]:=arr.b^[m4];
                  end;

                CopyMemory(p.b, temp.b, w*h);
              end;
  end;
  temp.Destroy;
  arr.Destroy;
end;

procedure MedValve_mask(p: PBtArr; b: TMyInfernalType; w, h: integer); overload;
var temp: TMyInfernalType;
    i, j, k, l, m, width, height: integer;
    tmp: treal;
    tmp_b: byte;
    m1, m2, m3, m4, cnt, m5, ind, sum: integer;
    hist: array[0..255] of integer;
begin
  width:=b.w;
  height:=b.h;
  temp:=TMyInfernalType.Create;
  temp.Init(h, w, varByte);
  CopyMemory(temp.b, p, w*h);

  m1:=width div 2;
  m2:=height div 2;
  m3:=width*height-1;

  cnt:=0;
  for i:=0 to m3 do
    if b.b^[i]=255 then
      inc(cnt);

  m4:=(cnt div 2)+1;
  m5:=cnt-1;

  for i:=m2 to h-m2-1 do
    for j:=m1 to w-m1-1 do
    begin             
      m:=0;             
      sum:=0;
      ZeroMemory(@hist[0], 256*sizeof(integer));
        for k:=i-m2 to i+m2 do
          for l:=j-m1 to j+m1 do
            if b.b^[(k-i+m2)*width+l-j+m1]=255 then
            begin
              inc(hist[p^[k*w+l]]);
           //   sum:=sum+p^[k*w+l];
            end;
       // tmp:=sum/cnt;
        ind:=0;
        m:=0;
        while m < m4 do
        begin
          for k:=1 to hist[ind] do
            inc(m);
          inc(ind);
        end;
      temp.b^[i*w+j]:=ind-1;
      {cnt:=0;
      for k:=0 to 255 do
      begin
        sum:=sum+k*hist[k];
        cnt:=cnt+hist[k];
      end;
      if tmp > 255 then
        temp.b^[i*w+j]:=255
      else
        begin
          if tmp < 0 then
            temp.b^[i*w+j]:=0
          else
            temp.b^[i*w+j]:=round(tmp);
        end;}
     // temp.b^[i*w+j]:=round(sum/cnt);
    end;
  CopyMemory(p, temp.b, w*h);
  temp.Destroy;
end;

procedure Red_Temp(var fft, mask: TMyInfernalType);
var i, j, h, w, wdt, w0, h0, maxx, maxy, curx, cury, BeginR, EndR: integer;
    r, _r1, r1, r2, _r2, r3, _r3, r0, _r0, norm, rR, fi, xmax1, ymax1, xmax2, ymax2, xmax3, ymax3, max, alpha, n, _rWdt: treal;
    amp: TMyInfernalType;
    orient: (vert, hor);
begin
  h:=fft.h;
  w:=fft.w div 2;
  w0:=w div 2;
  h0:=h div 2;
  wdt:=20;
  orient:=vert;
  BeginR:=25;
  EndR:=170;
  alpha:=90*pi/180;

  _r1:=50;
  _r2:=30;
  _r0:=60;
  mask.Clear;
  mask.Init(h, w, varDouble);
  amp:=TMyInfernalType.Create;
  amp.Init(h, w, varDouble);
  norm:=h*w;
  for i:=0 to w*h-1 do
    amp.a^[i]:=sqrt(sqr(fft.a^[2*i])+sqr(fft.a^[2*i+1]))/norm;

  maxx:=0;
  maxy:=0;
  max:=-MaxTReal;
  if orient = hor then
  begin
    for i:=0 to h0-5 do
      for j:=0 to w-1 do
      begin
        r:=sqrt(sqr(i-h0)+sqr(j-w0));
        if (amp.a^[i*w+j] > max) and (r > BeginR) and (r < EndR) then
        begin
          max:=amp.a^[i*w+j];
          maxx:=j;
          maxy:=i;
        end;
      end;
  end
  else
  begin
    for i:=0 to h-1 do
      for j:=0 to w0-5 do
      begin
        r:=sqrt(sqr(i-h0)+sqr(j-w0));
        if (amp.a^[i*w+j] > max) and (r > BeginR) and (r < EndR) then
        begin
          max:=amp.a^[i*w+j];
          maxx:=j;
          maxy:=i;
        end;
      end;
  end;
  maxx:=maxx-w0;
  maxy:=h0-maxy;
  rR:=Sqrt(Sqr(maxx)+Sqr(maxy));
  fi:=Arctan2(maxy, maxx);

  if orient = vert then
  begin
    {maxx:=w0+maxx;
    maxy:=h0-maxy;}

    for i:=0 to h-1 do
      for j:=0 to w-1 do
      begin
        curx:=j-w0;
        cury:=h0-i;

        //r:=sqrt(sqr(i-h/2)+sqr(j-w/2));
        ymax1:=(cury-maxy)*Cos(fi)-(curx-maxx)*Sin(fi);
        xmax1:=(cury-maxy)*Sin(fi)+(curx-maxx)*Cos(fi);
        xmax2:=(cury-2*maxy)*Sin(fi)+(curx-2*maxx)*Cos(fi);
        ymax2:=(cury-2*maxy)*Cos(fi)-(curx-2*maxx)*Sin(fi);
        {xmax3:=(cury-3*maxy)*Sin(fi)+(curx-3*maxx)*Cos(fi);
        ymax3:=(cury-3*maxy)*Cos(fi)-(curx-3*maxx)*Sin(fi);}

        r0:=Hypot(curx, cury);
        r1:=Hypot(xmax1, ymax1);
        r2:=Hypot(xmax2, ymax2);
        _rWdt:=Hypot(curx+wdt, cury+wdt);
        {r1:=sqrt(sqr(xmax1)+sqr(ymax1));
        r2:=sqrt(sqr(xmax2)+sqr(ymax2));}
      //  r3:=sqrt(sqr(xmax3)+sqr(ymax3));
        n:=cury*sin(alpha)+curx*cos(alpha);


        if {true}r1 < _r1 then
        begin
         { if (i <= h0) and (j <= w0) then
          begin
            if curx > -wdt then
              mask.a^[i*w+j]:=NuttallWin(curx, -wdt, 2*wdt)*NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r0, 0, 2*_r0))
            else
              mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r0, 0, 2*_r0))
          end;
          if (i > h0) and (j <= w0) then
          begin
            if r0 < wdt then
              mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r0, 0, 2*_r0))*NuttallWin(r0, wdt, 2*wdt)
            else
              mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r0, 0, 2*_r0))*(1-NuttallWin(r2, 0, 2*_r2));

          end;

          if (i > h0) and (j > w0) then
          begin
            if cury > - wdt then
              mask.a^[i*w+j]:=NuttallWin(cury, -wdt, 2*wdt)*NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r0, 0, 2*_r0))
            else
              mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r0, 0, 2*_r0));
          end;
         }
        { if (i >= h0) and (j <= w0) then
         begin
           if (cury > -wdt) and (curx <= -wdt) then
             mask.a^[i*w+j]:=NuttallWin(cury, -wdt, 2*wdt)*NuttallWin(r1, 0, 2*_r1);
           if (cury <= -wdt) and (curx > -wdt) then
             mask.a^[i*w+j]:=NuttallWin(curx, -wdt, 2*wdt)*NuttallWin(r1, 0, 2*_r1);
           if (curx <= -wdt) and (cury <= -wdt) then
             mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r2, 0, 2*_r2));
           if (curx > -wdt) and (cury > -wdt) then
             mask.a^[i*w+j]:=NuttallWin(_rWdt, 0, 2*wdt)*NuttallWin(r1, 0, 2*_r1);
         end;  }


          if n < wdt then
            mask.a^[i*w+j]:=NuttallWin(n, wdt, 2*wdt)*NuttallWin(r1, 0, 2*_r1)
          else
          begin
            //mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1);
            if r2 < _r2 then
              mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r2, 0, 2*_r2))
            else
              mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1);
          end;


           { if (r2 < _r2) and (r3 < _r2) then
              mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r2, 0, 2*_r2))*(1-NuttallWin(r3, 0, 2*_r2))
            else
            begin
              if (r2 < _r2) and (r3 >= r2) then
                mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r2, 0, 2*_r2))
              else
              begin
                if (r2 >= _r2) and (r3 < r2) then
                  mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r3, 0, 2*_r2))
                else
                  mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1);
              end;
            end;
            mask.a^[i*w+j]:=1;

          end;}
        end;
      end;
    {for i:=0 to h0 do
      for j:=w0 to w-1 do
      begin
        curx:=j-w0;
        cury:=h0-i;
        if cury < wdt then
          mask.a^[i*w+j]:=NuttallWin(cury, wdt, 2*wdt)
        else
          mask.a^[i*w+j]:=1;
      end;
    for i:=0 to h0 do
      for j:=0 to w0 do
      begin
        curx:=j-w0;
        cury:=h0-i;
        r:=Sqrt(Sqr(curx)+Sqr(cury));
        if r < wdt then
          mask.a^[i*w+j]:=NuttallWin(r, wdt, 2*wdt)
        else
          mask.a^[i*w+j]:=1;

      end;}
  end;
  amp.Destroy;

end;

procedure SimpleMask(var fft, mask: TMyInfernalType; orient: integer; r0, r1: treal); overload;
var i, j, h, w, w0, h0, EndR: integer;
    r, _r1, max: treal;
    amp: TMyInfernalType;
    cp: TPoint;
begin
  h:=fft.h;
  w:=fft.w div 2;

  w0:=w div 2;
  h0:=h div 2;

  EndR:=170;

  mask.Clear;
  mask.Init(h, w, varDouble);
  amp:=TMyInfernalType.Create;
  amp.Init(h, w, varDouble);

  for i:=0 to w*h-1 do
    amp.a^[i]:=Hypot(fft.a^[2*i], fft.a^[2*i+1]);

  cp.x:=0;
  cp.y:=0;
  max:=-MaxTReal;


  case orient of
    0: begin
         for i:=0 to h-1 do
           for j:=0 to w0-5 do
           begin
             r:=Hypot(i-h0, j-w0);
             if (r > r0) and (r < EndR) and (amp.a^[i*w+j] > max) then
             begin
               max:=amp.a^[i*w+j];
               cp.x:=j;
               cp.y:=i;
             end;
           end;
       end;
    1: begin
         for i:=0 to h0-5 do
           for j:=0 to w-1 do
           begin
             r:=Hypot(i-h0, j-w0);
             if (r > r0) and (r < EndR) and (amp.a^[i*w+j] > max) then
             begin
               max:=amp.a^[i*w+j];
               cp.x:=j;
               cp.y:=i;
             end;
           end;
       end;
    2: begin
         for i:=0 to h0-5 do
           for j:=0 to w0-5 do
           begin
             r:=Hypot(i-h0, j-w0);
             if (r > r0) and (r < EndR) and (amp.a^[i*w+j] > max) then
             begin
               max:=amp.a^[i*w+j];
               cp.x:=j;
               cp.y:=i;
             end;
           end;
       end;
    3: begin
         for i:=0 to h0-5 do
           for j:=w0+5 to w-1 do
           begin
             r:=Hypot(i-h0, j-w0);
             if (r > r0) and (r < EndR) and (amp.a^[i*w+j] > max) then
             begin
               max:=amp.a^[i*w+j];
               cp.x:=j;
               cp.y:=i;
             end;
           end;
       end;
  end;

  for i:=0 to h-1 do
    for j:=0 to w-1 do
    begin
      r:=Hypot(i-h0, j-w0);
      _r1:=Hypot(i-cp.y, j-cp.x);
      if _r1 < r1 then
        mask.a^[i*w+j]:=NuttallWin(_r1, 0, 2*r1)*(1-NuttallWin(r, 0, 2*r0));
    end;

  amp.Destroy;
end;

procedure SimpleMask(var fft, mask: TMyInfernalType; order, orient: boolean; _r1: treal); overload;
var i, j, h, w, w0, h0, maxx, maxy, curx, cury, BeginR, EndR: integer;
    r, r1, r2, norm, max: treal;
    amp: TMyInfernalType;
begin
  h:=fft.h;
  w:=fft.w div 2;
  w0:=w div 2;
  h0:=h div 2;
  BeginR:=15;
  EndR:=170;
  mask.Clear;
  mask.Init(h, w, varDouble);
  amp:=TMyInfernalType.Create;
  amp.Init(h, w, varDouble);
  norm:=h*w;
  for i:=0 to w*h-1 do
    amp.a^[i]:=Hypot(fft.a^[2*i], fft.a^[2*i+1]);

  maxx:=0;
  maxy:=0;
  max:=-MaxTReal;
  //
  //  orient == true - horizontal
  //  orient == false - vertical
  //

  if orient then
  begin
    for i:=0 to h0-5 do
      for j:=0 to w-1 do
      begin
        r:=Hypot(i-h0, j-w0);
        if (amp.a^[i*w+j] > max) and (r > BeginR) and (r < EndR) then
        begin
          max:=amp.a^[i*w+j];
          maxx:=j;
          maxy:=i;
        end;
      end;
  end
  else
  begin
    for i:=0 to h-1 do
      for j:=0 to w0-5 do
      begin
        r:=sqrt(sqr(i-h0)+sqr(j-w0));
        if (amp.a^[i*w+j] > max) and (r > BeginR) and (r < EndR) then
        begin
          max:=amp.a^[i*w+j];
          maxx:=j;
          maxy:=i;
        end;
      end;
  end;
  maxx:=maxx-w0;
  maxy:=h0-maxy;

  if order then
  begin
    maxy:=-maxy;
    maxx:=-maxx;
  end;

  for i:=0 to h-1 do
    for j:=0 to w-1 do
    begin
      curx:=j-w0;
      cury:=h0-i;
      r:=Hypot(curx, cury);
      r1:=Hypot(curx-maxx, cury-maxy);
    //  r2:=Hypot(curx-2*maxx, cury-2*maxy);
      if r1 < _r1 then
        mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r, 0, 60)){*(1-NuttallWin(r2, 0, 60))};
    end;
  amp.Destroy;
end;


procedure SimpleMask(var fft, mask: TMyInfernalType; order, orient: boolean; _r1: treal; var maxp: tpoint); overload;
var i, j, h, w, w0, h0, maxx, maxy, curx, cury, BeginR, EndR: integer;
    r, r1, r2, norm, max: treal;
    amp: TMyInfernalType;
begin
  h:=fft.h;
  w:=fft.w div 2;
  w0:=w div 2;
  h0:=h div 2;
  BeginR:=15;
  EndR:=170;
  mask.Clear;
  mask.Init(h, w, varDouble);
  amp:=TMyInfernalType.Create;
  amp.Init(h, w, varDouble);
  norm:=h*w;
  for i:=0 to w*h-1 do
    amp.a^[i]:=Hypot(fft.a^[2*i], fft.a^[2*i+1]);

  maxx:=0;
  maxy:=0;
  max:=-MaxTReal;
  //
  //  orient == true - horizontal
  //  orient == false - vertical
  //

  if orient then
  begin
    for i:=0 to h0-5 do
      for j:=0 to w-1 do
      begin
        r:=Hypot(i-h0, j-w0);
        if (amp.a^[i*w+j] > max) and (r > BeginR) and (r < EndR) then
        begin
          max:=amp.a^[i*w+j];
          maxx:=j;
          maxy:=i;
        end;
      end;
  end
  else
  begin
    for i:=0 to h-1 do
      for j:=0 to w0-5 do
      begin
        r:=sqrt(sqr(i-h0)+sqr(j-w0));
        if (amp.a^[i*w+j] > max) and (r > BeginR) and (r < EndR) then
        begin
          max:=amp.a^[i*w+j];
          maxx:=j;
          maxy:=i;
        end;
      end;
  end;
  maxx:=maxx-w0;
  maxy:=h0-maxy;

  if order then
  begin
    maxy:=-maxy;
    maxx:=-maxx;
  end;

  maxp.x:=maxx;
  maxp.y:=maxy;

  for i:=0 to h-1 do
    for j:=0 to w-1 do
    begin
      curx:=j-w0;
      cury:=h0-i;
      r:=Hypot(curx, cury);
      r1:=Hypot(curx-maxx, cury-maxy);
    //  r2:=Hypot(curx-2*maxx, cury-2*maxy);
      if r1 < _r1 then
        mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r, 0, 60)){*(1-NuttallWin(r2, 0, 60))};
    end;
  amp.Destroy;
end;

procedure GilbertFilter(var fft, mask: TMyInfernalType; order: boolean; _r1: integer; orient: boolean);
var i, j, h, w, wdt, w0, h0, maxx, maxy, curx, cury, BeginR, EndR: integer;
    r{, _r1}, r1, r2, _r2, r3, _r3, r0, _r0, r1x, norm, rR, fi,
    xmax1, ymax1, xmax2, ymax2, xmax3, ymax3, max, alpha, n, _rWdt, _rWdt2, _rWdt3: treal;
    amp: TMyInfernalType;
   // orient: (vert, hor);
begin
  h:=fft.h;
  w:=fft.w div 2;
  w0:=w div 2;
  h0:=h div 2;
  wdt:=5;
 // orient:=vert;
  BeginR:=25;
  EndR:=170;
  alpha:=260*pi/180;

//  _r1:=150;
  _r2:=0;
  _r0:=60;
  mask.Clear;
  mask.Init(h, w, varDouble);
  amp:=TMyInfernalType.Create;
  amp.Init(h, w, varDouble);
  norm:=h*w;
  for i:=0 to w*h-1 do
    amp.a^[i]:=sqrt(sqr(fft.a^[2*i])+sqr(fft.a^[2*i+1]))/norm;

  maxx:=0;
  maxy:=0;
  max:=-MaxTReal;
  if orient then
  begin
    for i:=0 to h0-5 do
      for j:=0 to w-1 do
      begin
        r:=sqrt(sqr(i-h0)+sqr(j-w0));
        if (amp.a^[i*w+j] > max) and (r > BeginR) and (r < EndR) then
        begin
          max:=amp.a^[i*w+j];
          maxx:=j;
          maxy:=i;
        end;
      end;
  end
  else
  begin
    for i:=0 to h-1 do
      for j:=0 to w0-5 do
      begin
        r:=sqrt(sqr(i-h0)+sqr(j-w0));
        if (amp.a^[i*w+j] > max) and (r > BeginR) and (r < EndR) then
        begin
          max:=amp.a^[i*w+j];
          maxx:=j;
          maxy:=i;
        end;
      end;
  end;
  maxx:=maxx-w0;
  maxy:=h0-maxy;


//  FindLocalMaxRealArray(w, h, amp.a^, 25, 170, maxx, maxy);
 { if order then
  begin
    maxy:=-maxy;
    maxx:=-maxx;
  end;}

  (*
  {rR:=Sqrt(Sqr(maxx)+Sqr(maxy));
  fi:=Arctan2(maxy, maxx);}
  if orient then
  begin
    for i:=0 to h0-1 do
      for j:=0 to w-1 do
      begin
        curx:=j-w0;
        cury:=h0-i;
        r0:=Hypot(curx, cury);
        r1:=Hypot(curx-maxx, cury-maxy);
        r2:=Hypot(curx-2*maxx, cury-2*maxy);
        if r1 < _r1 then
          mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1){*(1-NuttallWin(abs(curx), 0, 2*wdt))}*
             (1-NuttallWin(abs(cury), 0, 2*wdt)){*(1-NuttallWin(r2, 0, 2*_r2))}*(1-NuttallWin(r0, 0, 2*_r0))
             {*(1-NuttallWin(abs(curx+maxx), 0, 2*wdt))*(1-NuttallWin(abs(cury+maxy), 0, 2*wdt))};
      end;
  end
  else
  begin
    for i:=0 to h-1 do
      for j:=0 to w0-1 do
      begin
        curx:=j-w0;
        cury:=h0-i;
        r0:=Hypot(curx, cury);
        r1:=Hypot(curx-maxx, cury-maxy);
        r2:=Hypot(curx-2*maxx, cury-2*maxy);
        if r1 < _r1 then
          mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(abs(curx), 0, 2*wdt)){*
             (1-NuttallWin(abs(cury), 0, 2*wdt)){*(1-NuttallWin(r2, 0, 2*_r2))}*(1-NuttallWin(r0, 0, 2*_r0))
             {*(1-NuttallWin(abs(curx+maxx), 0, 2*wdt))*(1-NuttallWin(abs(cury+maxy), 0, 2*wdt))};
      end;
  end;
   *)
  

  if (maxx <= 0) and (maxy <= 0) then

    for i:=0 to h-1 do
      for j:=0 to w-1 do
      begin
        curx:=j-w0;
        cury:=h0-i;
        r0:=Hypot(curx, cury);
        r1:=Hypot(curx-maxx, cury-maxy);
        r2:=Hypot(curx-2*maxx, cury-2*maxy);
        if r1 < _r1 then
          if not ((j > w0) and (i < h0)) then
            mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(abs(curx), 0, 2*wdt))*
               (1-NuttallWin(abs(cury), 0, 2*wdt)){*(1-NuttallWin(r2, 0, 2*_r2))}*(1-NuttallWin(r0, 0, 2*_r0))
               {*(1-NuttallWin(abs(curx+maxx), 0, 2*wdt))*(1-NuttallWin(abs(cury+maxy), 0, 2*wdt))};
      end;

  if (maxx <= 0) and (maxy >= 0) then
    for i:=0 to h-1 do
      for j:=0 to w-1 do
      begin
        curx:=j-w0;
        cury:=h0-i;
        r0:=Hypot(curx, cury);
        r1:=Hypot(curx-maxx, cury-maxy);
        r2:=Hypot(curx-2*maxx, cury-2*maxy);
        if r1 < _r1 then
          if not ((j > w0) and (i > h0)) then
            mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(abs(curx), 0, 2*wdt))*
              (1-NuttallWin(abs(cury), 0, 2*wdt)){*(1-NuttallWin(r2, 0, 2*_r2))}*(1-NuttallWin(r0, 0, 2*_r0))
              {*(1-NuttallWin(abs(curx+maxx), 0, 2*wdt))*(1-NuttallWin(abs(cury+maxy), 0, 2*wdt))};
      end;

  if (maxx >= 0) and (maxy >= 0) then
    for i:=0 to h-1 do
      for j:=0 to w-1 do
      begin
        curx:=j-w0;
        cury:=h0-i;
        r0:=Hypot(curx, cury);
        r1:=Hypot(curx-maxx, cury-maxy);
        r2:=Hypot(curx-2*maxx, cury-2*maxy);
        if r1 < _r1 then
          if not ((j < w0) and (i > h0)) then
            mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(abs(curx), 0, 2*wdt))*
              (1-NuttallWin(abs(cury), 0, 2*wdt)){*(1-NuttallWin(r2, 0, 2*_r2))}*(1-NuttallWin(r0, 0, 2*_r0))
              {*(1-NuttallWin(abs(curx+maxx), 0, 2*wdt))*(1-NuttallWin(abs(cury+maxy), 0, 2*wdt))};
      end;

  if (maxx >= 0) and (maxy <= 0) then
    for i:=0 to h-1 do
      for j:=0 to w-1 do
      begin
        curx:=j-w0;
        cury:=h0-i;
        r0:=Hypot(curx, cury);
        r1:=Hypot(curx-maxx, cury-maxy);
        r2:=Hypot(curx-2*maxx, cury-2*maxy);
        if r1 < _r1 then
          if not ((j < w0) and (i < h0)) then
            mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(abs(curx), 0, 2*wdt))*
              (1-NuttallWin(abs(cury), 0, 2*wdt)){*(1-NuttallWin(r2, 0, 2*_r2))}*(1-NuttallWin(r0, 0, 2*_r0))
              {*(1-NuttallWin(abs(curx+maxx), 0, 2*wdt))*(1-NuttallWin(abs(cury+maxy), 0, 2*wdt))};
      end;

  if order then
  begin
    for i:=0 to h-1 do
      for j:=0 to w-1 do
        amp.a^[i*w+j]:=mask.a^[(h-1-i)*w+w-1-j];
    CopyMemory(mask.a, amp.a, w*h*sizeof(treal));
  end;
  amp.Destroy;



(*  if orient = vert then
  begin
    {maxx:=w0+maxx;
    maxy:=h0-maxy;}

    for i:=0 to h-1 do
      for j:=0 to w-1 do
      begin
        curx:=j-w0;
        cury:=h0-i;

        //r:=sqrt(sqr(i-h/2)+sqr(j-w/2));
        ymax1:=(cury-maxy)*Cos(fi)-(curx-maxx)*Sin(fi);
        xmax1:=(cury-maxy)*Sin(fi)+(curx-maxx)*Cos(fi);
        xmax2:=(cury-2*maxy)*Sin(fi)+(curx-2*maxx)*Cos(fi);
        ymax2:=(cury-2*maxy)*Cos(fi)-(curx-2*maxx)*Sin(fi);
        {xmax3:=(cury-3*maxy)*Sin(fi)+(curx-3*maxx)*Cos(fi);
        ymax3:=(cury-3*maxy)*Cos(fi)-(curx-3*maxx)*Sin(fi);}

        r0:=Hypot(curx, cury);
        r1:=Hypot(curx-maxx, (cury-maxy));
        r1x:=Hypot((curx-maxx), (cury-maxy));
        r2:=Hypot(xmax2, ymax2);
        _rWdt:=Hypot(curx+wdt, cury+wdt);
        _rWdt2:=Hypot(curx+wdt, cury-wdt);
        _rWdt3:=Hypot(curx-wdt, cury+wdt);
        {r1:=sqrt(sqr(xmax1)+sqr(ymax1));
        r2:=sqrt(sqr(xmax2)+sqr(ymax2));}
      //  r3:=sqrt(sqr(xmax3)+sqr(ymax3));
        n:=cury*sin(alpha)+curx*cos(alpha);


        if r1 < _r1 then
        begin
         { if (i <= h0) and (j <= w0) then
          begin
            if curx > -wdt then
              mask.a^[i*w+j]:=NuttallWin(curx, -wdt, 2*wdt)*NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r0, 0, 2*_r0))
            else
              mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r0, 0, 2*_r0))
          end;
          if (i > h0) and (j <= w0) then
          begin
            if r0 < wdt then
              mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r0, 0, 2*_r0))*NuttallWin(r0, wdt, 2*wdt)
            else
              mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r0, 0, 2*_r0))*(1-NuttallWin(r2, 0, 2*_r2));

          end;

          if (i > h0) and (j > w0) then
          begin
            if cury > - wdt then
              mask.a^[i*w+j]:=NuttallWin(cury, -wdt, 2*wdt)*NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r0, 0, 2*_r0))
            else
              mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r0, 0, 2*_r0));
          end;
         }
        { if (i >= h0) and (j <= w0) then
         begin
           if (cury > -wdt) and (curx <= -wdt) then
             mask.a^[i*w+j]:=NuttallWin(cury, -wdt, 2*wdt)*NuttallWin(r1, 0, 2*_r1);
           if (cury <= -wdt) and (curx > -wdt) then
             mask.a^[i*w+j]:=NuttallWin(curx, -wdt, 2*wdt)*NuttallWin(r1, 0, 2*_r1);
           if (curx <= -wdt) and (cury <= -wdt) then
             mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r2, 0, 2*_r2));
           if (curx > -wdt) and (cury > -wdt) then
             mask.a^[i*w+j]:=NuttallWin(_rWdt, 0, 2*wdt)*NuttallWin(r1, 0, 2*_r1);
         end;

         if (i <= h0) and (j <= w0) then
         begin
           if (cury <= wdt) and (curx <= -wdt) then
             mask.a^[i*w+j]:=NuttallWin(cury, wdt, 2*wdt)*NuttallWin(r1, 0, 2*_r1);
           if (cury > wdt) and (curx > -wdt) then
             mask.a^[i*w+j]:=NuttallWin(curx, -wdt, 2*wdt)*NuttallWin(r1, 0, 2*_r1);
           if (curx <= -wdt) and (cury > wdt) then
             mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1);
           if (curx > -wdt) and (cury <= wdt) then
             mask.a^[i*w+j]:=NuttallWin(_rWdt2, 0, 2*wdt)*NuttallWin(r1, 0, 2*_r1);
         end;

         if (i >= h0) and (j >= w0) then
         begin
           if (cury >= -wdt) and (curx >= wdt) then
             mask.a^[i*w+j]:=NuttallWin(cury, -wdt, 2*wdt)*NuttallWin(r1, 0, 2*_r1);
           if (cury < -wdt) and (curx < wdt) then
             mask.a^[i*w+j]:=NuttallWin(curx, wdt, 2*wdt)*NuttallWin(r1, 0, 2*_r1);
           if (curx >= wdt) and (cury < -wdt) then
             mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1);
           if (curx <= wdt) and (cury >= -wdt) then
             mask.a^[i*w+j]:=NuttallWin(_rWdt3, 0, 2*wdt)*NuttallWin(r1, 0, 2*_r1);
         end;}

         if not ((j > w0) and (i < h0)) then
         begin
         {  if abs(curx) <= wdt then
             mask.a^[i*w+j]:=(1-NuttallWin(abs(curx), 0, 2*wdt))*NuttallWin(r1, 0, 2*_r1);
           if abs(cury) <= wdt then
             mask.a^[i*w+j]:=(1-NuttallWin(abs(cury), 0, 2*wdt))*NuttallWin(r1, 0, 2*_r1);
           if (abs(curx) > wdt) and (abs(cury) > wdt) then }


             mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(abs(curx), 0, 2*wdt))*
                            (1-NuttallWin(abs(cury), 0, 2*wdt))*(1-NuttallWin(r2, 0, 2*_r2))*(1-NuttallWin(r0, 0, 2*_r0));
         end;
     //  mask.a^[i*w+j]:=(1-NuttallWin(r1, 0, 20*wdt))*(1-NuttallWin(r0, 0, _r0));

       {if (i >= h0) and (j <= w0) and (r0 >= 10) then

         mask.a^[i*w+j]:=(NuttallWin(r1, 0, 2*_r1)+NuttallWin(r1x, 0, 2*_r1))/2;}



          {if n < wdt then

            mask.a^[i*w+j]:=NuttallWin(n, wdt, 2*wdt)*NuttallWin(r1, 0, 2*_r1)
          else
          begin
            //mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1);
            if r2 < _r2 then
              mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r2, 0, 2*_r2))
            else
              mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1);
          end;}


           { if (r2 < _r2) and (r3 < _r2) then
              mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r2, 0, 2*_r2))*(1-NuttallWin(r3, 0, 2*_r2))
            else
            begin
              if (r2 < _r2) and (r3 >= r2) then
                mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r2, 0, 2*_r2))
              else
              begin
                if (r2 >= _r2) and (r3 < r2) then
                  mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)*(1-NuttallWin(r3, 0, 2*_r2))
                else
                  mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1);
              end;
            end;
            mask.a^[i*w+j]:=1;

          end;}
        end;
      end;
    {for i:=0 to h0 do
      for j:=w0 to w-1 do
      begin
        curx:=j-w0;
        cury:=h0-i;
        if cury < wdt then
          mask.a^[i*w+j]:=NuttallWin(cury, wdt, 2*wdt)
        else
          mask.a^[i*w+j]:=1;
      end;
    for i:=0 to h0 do
      for j:=0 to w0 do
      begin
        curx:=j-w0;
        cury:=h0-i;
        r:=Sqrt(Sqr(curx)+Sqr(cury));
        if r < wdt then
          mask.a^[i*w+j]:=NuttallWin(r, wdt, 2*wdt)
        else
          mask.a^[i*w+j]:=1;

      end;}
  end
  else
  begin
    for i:=0 to h0 do
      for j:=0 to w-1 do
      begin
        curx:=j-w0;
        cury:=h0-i;
        ymax1:=(cury-maxy)*Cos(fi)-(curx-maxx)*Sin(fi);
        xmax1:=(cury-maxy)*Sin(fi)+(curx-maxx)*Cos(fi);
        xmax2:=(cury-2*maxy)*Sin(fi)+(curx-2*maxx)*Cos(fi);
        ymax2:=(cury-2*maxy)*Cos(fi)-(curx-2*maxx)*Sin(fi);
        xmax3:=(cury-3*maxy)*Sin(fi)+(curx-3*maxx)*Cos(fi);
        ymax3:=(cury-3*maxy)*Cos(fi)-(curx-3*maxx)*Sin(fi);

        r1:=sqrt(sqr(xmax1)+sqr(ymax1));
        r2:=sqrt(sqr(xmax2)+sqr(ymax2));
        r3:=sqrt(sqr(xmax3)+sqr(ymax3));
        if true{ (r1 < _r1) }then
        begin
          if cury < wdt then
             mask.a^[i*w+j]:=NuttallWin(cury, wdt, 2*wdt){*NuttallWin(r1, 0, 2*_r1)}
          else
          begin
            //mask.a^[i*w+j]:=NuttallWin(r1, 0, 2*_r1)
            mask.a^[i*w+j]:=1
          end;
        end;
      end;
  end;


  {else
  begin
    for i:=0 to h-1 do
      for j:=(w div 2) to w-1 do
      begin
        r:=sqrt(sqr(i-h/2)+sqr(j-w/2));
        if r > r0 then
          mask.a^[i*w+j]:=1;
      end;
  end;}
  *)


end;

procedure FilterSector(var fft, mask: TMyInfernalType; order, sector: boolean; r0, r2, r_main: treal);
var i,j, h, w, maxx, maxy, curx, cury: integer;
    norm: integer;
    rR, fi, rk, ymax1, xmax1, ymax2, xmax2: treal;
    bIsOnSector: boolean;
    amp{, mask}: TMyInfernalType;
begin
  h:=fft.h;
  w:=fft.w div 2;
  amp:=TMyInfernalType.Create;
 // mask:=TMyInfernalType.Create;
  amp.Init(h, w, varDouble);
  mask.Clear;
  mask.Init(h, w, varDouble);
  norm:=h*w;
  for i:=0 to w*h-1 do
    amp.a^[i]:=sqrt(sqr(fft.a^[2*i])+sqr(fft.a^[2*i+1]))/norm;
 // CreateBin(amp, 'fft.bin');
  FindLocalMaxRealArray(w, h, amp.a^, 25, 170, maxx, maxy);
  if order then
  begin
    maxy:=-maxy;
    maxx:=-maxx;
  end;
  rR:=Sqrt(Sqr(maxx)+Sqr(maxy));
  fi:=Arctan2(maxy, maxx);
  for i:=0 to h-1 do
    for j:=0 to w-1 do
    begin
      curx:=j-(w div 2);
      cury:=(h div 2)-i;
      ymax1:=(cury-maxy)*Cos(fi)-(curx-maxx)*Sin(fi);
      xmax1:=(cury-maxy)*Sin(fi)+(curx-maxx)*Cos(fi);
      xmax2:=(cury-2*maxy)*Sin(fi)+(curx-2*maxx)*Cos(fi);
      ymax2:=(cury-2*maxy)*Cos(fi)-(curx-2*maxx)*Sin(fi);
      if sector then
        bIsOnSector:=(Sqrt(Sqr(curx)+Sqr(cury)) > r0*rR) and
          (xmax1 > -rR) and not
          ((xmax2 > -r2*rR) and (Abs(ymax2) < xmax2+r2*rR)) and
          (Sqrt(Sqr(ymax2)+Sqr(xmax2)) >= r2*rR)
      else
        bIsOnSector:=(Sqrt(Sqr(curx)+Sqr(cury)) > r0*rR) and
          (xmax1 > -rR) and
          (Sqrt(Sqr(ymax2)+Sqr(xmax2)) >= r2*rR);

      if bIsOnSector then
      begin
        rk:=FltWin(Sqrt(Sqr(xmax1)+Sqr(ymax1)), r_main*rR, fwHann);
       // fft.a^[2*(i*w+j)]:=fft.a^[2*(i*w+j)]*rk;
       // fft.a^[2*(i*w+j)+1]:=fft.a^[2*(i*w+j)+1]*rk;
        mask.a^[i*w+j]:=rk;
      end
      else
      begin
        //fft.a^[2*(i*w+j)]:=0;
       // fft.a^[2*(i*w+j)+1]:=0;
      end;
    end;
 // CreateBin(mask, 'mask.bin');
  amp.Destroy;
  //mask.Destroy;
end;

function NuttallWin(x, x0, w: integer): treal;
var a0, a1, a2, a3, _x: treal;
begin
  a0:=0.3635819;
  a1:=0.4891775;
  a2:=0.1365995;
  a3:=0.0106411;
  _x:=2*pi*(x-x0+w/2)/w;
  if abs(x-x0) > (w div 2) then
  begin
    Result:=0;
    exit;
  end;
  Result:=a0-a1*cos(_x)+a2*cos(2*_x)-a3*cos(3*_x);
end;

function NuttallWin(x, x0, w: treal): treal; overload;
var a0, a1, a2, a3, _x, w0: treal;
begin
  a0:=0.3635819;
  a1:=0.4891775;
  a2:=0.1365995;
  a3:=0.0106411;
  w0:= w/2;
  _x:=2*pi*(x-x0+w/2)/w;
  if abs(x-x0) > w0 then
  begin
    Result:=0;
    exit;
  end;
  Result:=a0-a1*cos(_x)+a2*cos(2*_x)-a3*cos(3*_x);
end;

procedure SolveSystem3x4(var a: TMatrix; var k1, k2, k3: treal); overload;
var t: treal;
begin
  t:=a[0,0]*a[2,2]*a[1,1]-a[2,2]*a[1,0]*a[0,1]-a[2,0]*a[0,2]*a[1,1]+a[2,0]*a[0,1]*a[1,2]+a[2,1]*a[1,0]*a[0,2]-a[0,0]*a[2,1]*a[1,2];
  if t = 0 then
    exit;
  k1:=(a[0,1]*a[1,2]*a[2,3]-a[0,1]*a[1,3]*a[2,2]+a[0,2]*a[2,1]*a[1,3]-a[0,2]*a[2,3]*a[1,1]+a[0,3]*a[2,2]*a[1,1]-a[0,3]*a[2,1]*a[1,2])/t;
  k2:=-(a[0,0]*a[2,3]*a[1,2]-a[0,0]*a[2,2]*a[1,3]-a[1,0]*a[0,2]*a[2,3]-a[1,2]*a[2,0]*a[0,3]+a[1,3]*a[2,0]*a[0,2]+a[1,0]*a[0,3]*a[2,2])/t;
  k3:=(-a[2,0]*a[0,3]*a[1,1]-a[0,0]*a[2,1]*a[1,3]+a[0,0]*a[2,3]*a[1,1]-a[2,3]*a[1,0]*a[0,1]+a[2,0]*a[0,1]*a[1,3]+a[2,1]*a[1,0]*a[0,3])/t;
end;

procedure SolveSystem3x4(var a: TMatrix; var k2, k3: treal);
var t: treal;
begin
  t:=a[0,0]*a[2,2]*a[1,1]-a[2,2]*a[1,0]*a[0,1]-a[2,0]*a[0,2]*a[1,1]+a[2,0]*a[0,1]*a[1,2]+a[2,1]*a[1,0]*a[0,2]-a[0,0]*a[2,1]*a[1,2];
  if t = 0 then
    exit;
  k2:=-(a[0,0]*a[2,3]*a[1,2]-a[0,0]*a[2,2]*a[1,3]-a[1,0]*a[0,2]*a[2,3]-a[1,2]*a[2,0]*a[0,3]+a[1,3]*a[2,0]*a[0,2]+a[1,0]*a[0,3]*a[2,2])/t;
  k3:=(-a[2,0]*a[0,3]*a[1,1]-a[0,0]*a[2,1]*a[1,3]+a[0,0]*a[2,3]*a[1,1]-a[2,3]*a[1,0]*a[0,1]+a[2,0]*a[0,1]*a[1,3]+a[2,1]*a[1,0]*a[0,3])/t;
end;

procedure BilateralFilter(var p, mask: TMyInfernalType; Sr, Sd: treal; order: byte);
var w, h, i, j, k, l, q: integer;
    c: array of array of treal;
    t: TMyInfernalType;
    sum, norm, y: treal;
    v, _v: treal;

begin
  w:=p.w;
  h:=p.h;
  t:=TMyInfernalType.Create;
  t.Init(h, w, varDouble);
  SetLength(c, order, order);
  q:=order div 2;
  for i:=0 to order-1 do
    for j:=0 to order-1 do
      c[i,j]:=exp(-sqr(Hypot(j-q, i-q)/Sd)/2);
  v:=(exp(-0.5)-1)/Sr;


  for i:=q to h-q-1 do
    for j:=q to w-q-1 do
      if mask.b^[i*w+j]=1 then
      begin
        sum:=0;
        norm:=0;
        for k:=i-q to i+q do
          for l:=j-q to j+q do
            if mask.b^[k*w+l]=1 then
            begin
              _v:=1+abs(p.a^[i*w+j]-p.a^[k*w+l])*v;
              if _v < 0 then
                _v:=0;
              y:=c[k-i+q, l-j+q]*_v;
              sum:=sum+y*p.a^[k*w+l];
              norm:=norm+y;
            end;
        t.a^[i*w+j]:=sum/norm;
      end;

  Finalize(c);
  CopyMemory(p.a, t.a, w*h*sizeof(treal));
  t.Destroy;
end;

procedure Distorsion(var p, mask: TMyInfernalType; _A, dx, D: treal; p0: TPoint);
var i, j, w, h, cnt, k, l: integer;
    x, y, z: TMyInfernalType;
    r, phi, _r: treal;
    _p, _mask, pp, tm: TMyInfernalType;
    _x, _y, _cnt: integer;
    a: TMatrix;
    nx, ny, nz: treal;
    k1, k2, k3: treal;
begin
  w:=p.w;
  h:=p.h;
  x:=TMyInfernalType.Create;
  y:=TMyInfernalType.Create;
  z:=TMyInfernalType.Create;
  _p:=TMyInfernalType.Create;
  _mask:=TMyInfernalType.Create;
  pp:=TMyInfernalType.Create;
  tm:=TMyInfernalType.Create;
  x.Init(1, w*h, varDouble);
  y.Init(1, w*h, varDouble);
  z.Init(1, w*h, varDouble);
  _p.Init(h, w, varDouble);
  _mask.Init(h, w, varByte);
  pp.Init(h, w, varInteger);
  tm.Init(h, w, varByte);

  cnt:=0;

  for i:=0 to h-1 do
    for j:=0 to w-1 do
      if mask.b^[i*w+j] = 1 then
      begin
        r:=Hypot(p0.x-j, p0.y-i);
        phi:=ArcTan2(i-p0.y, j-p0.x);
        r:=r*dx*2/D;
        _r:=DistorsionFunc(_A, r);
        r:=(r+_r)*D/(2*dx);

        x.a^[cnt]:=p0.x+r*cos(phi);
        y.a^[cnt]:=p0.y+r*sin(phi);
        z.a^[cnt]:=p.a^[i*w+j];
        inc(cnt);
      end;

  for i:=0 to cnt-1 do
  begin
    _x:=round(x.a^[i]);
    _y:=round(y.a^[i]);
    if (_x >= 0) and (_x < w) and (_y >= 0) and (_y < h) then
    begin
      _mask.b^[_y*w+_x]:=1;
      pp.c^[_y*w+_x]:=i;
    end;
  end;

  for i:=1 to h-2 do
    for j:=1 to w-2 do
    begin
      ZeroMemory(@(a), 12*sizeof(treal));
      _cnt:=0;
      for k:=i-1 to i+1 do
        for l:=j-1 to j+1 do
          if _mask.b^[k*w+l] = 1 then
          begin
            cnt:=pp.c^[k*w+l];
            nx:=x.a^[cnt];
            ny:=y.a^[cnt];
            nz:=z.a^[cnt];
            a[0,0]:=a[0,0]+sqr(nx);
            a[0,1]:=a[0,1]+nx*ny;
            a[0,2]:=a[0,2]+nx;
            a[0,3]:=a[0,3]+nx*nz;
            a[1,1]:=a[1,1]+sqr(ny);
            a[1,2]:=a[1,2]+ny;
            a[1,3]:=a[1,3]+ny*nz;
            a[2,3]:=a[2,3]+nz;
            inc(_cnt);
          end;
      a[1,0]:=a[0,1];
      a[2,0]:=a[0,2];
      a[2,1]:=a[1,2];
      a[2,2]:=_cnt;
      if _cnt > 3 then
      begin
        SolveSystem3x4(a, k1, k2, k3);
        //if (k1+k2+k3) <> 0 then
        begin
          _p.a^[i*w+j]:=k1*j+k2*i+k3;
          tm.b^[i*w+j]:=1;
        end;
      end
      else
      begin
        if (_cnt > 0) and (_mask.b^[i*w+j] = 1)then
        begin
          _p.a^[i*w+j]:=z.a^[pp.c^[i*w+j]];
          tm.b^[i*w+j]:=1;
        end;
      end;
    end;

  CopyMemory(p.a, _p.a, w*h*sizeof(treal));
  CopyMemory(mask.b, tm.b, w*h);
  x.Destroy;
  y.Destroy;
  z.Destroy;
  _p.Destroy;
  _mask.Destroy;
  pp.Destroy;
  tm.Destroy;
end;

procedure Defocus(var p, mask: TMyInfernalType; D, dx: treal; p0: TPoint);
var i,j,w,h: integer;
    t, r, {a,} b, k: Extended;
    a: TMatrix;
    k1, k2, k3: treal;
begin
  w:=p.w;
  h:=p.h;
 // a:=0;
  b:=0;
  k:=dx*2/D;
  ZeroMemory(@(a), 12*sizeof(treal));
  for i:=0 to h-1 do
    for j:=0 to w-1 do
      if mask.b^[i*w+j] = 1 then
      begin
        r:={k*}Hypot(p0.x-j, p0.y-i);
       // a:=a+(p.a^[i*w+j])*sqr(r);
       // b:=b+{sqr(r)}Power(r,4);
        a[0,0]:=a[0,0]+Power(r,4);
        a[0,1]:=a[0,1]+Power(r,3);
        a[0,2]:=a[0,2]+Power(r,2);
        a[0,3]:=a[0,3]+p.a^[i*w+j]*Power(r,2);
        a[1,2]:=a[1,2]+r;
        a[1,3]:=a[1,3]+p.a^[i*w+j]*r;
        a[2,2]:=a[2,2]+1;
        a[2,3]:=a[2,3]+p.a^[i*w+j];
      end;
  a[1,0]:=a[0,1];
  a[1,1]:=a[0,2];
  a[2,0]:=a[0,2];
  a[2,1]:=a[1,2];

  SolveSystem3x4(a, k1, k2, k3);

  {if b <> 0 then
    t:=a/b
  else
    exit;}

  for i:=0 to h-1 do
    for j:=0 to w-1 do
      if mask.b^[i*w+j] = 1 then
      begin
        r:={k*}Hypot(p0.x-j, p0.y-i);
        p.a^[i*w+j]:=p.a^[i*w+j]-(k1*sqr(r)+k2*r+k3);
       // p.a^[i*w+j]:=p.a^[i*w+j]-sqr(r)*t;
      end;

end;

function DistorsionFunc(A, x: treal): treal;
var r: treal;
begin
  if (x >= 0) and (x <= 1) then
    Result:=A*x*(1-sqr(x))
  else
    Result:=0;
end;

procedure CreateAsc(var p, mask: TMyInfernalType; name: string);
var f: TextFile;
    w, h, i, j: integer;
begin
  AssignFile(f, name);
  Rewrite(f);
  w:=p.w;
  h:=p.h;
  for i:=0 to h-1 do
  begin
    for j:=0 to w-1 do
      if mask.b^[i*w+j]=1 then
        Write(f, p.a^[i*w+j]:10:5)
      else
        Write(f, 0.0:10:5);
    Writeln(f);
  end;
  CloseFile(f);
end;


procedure Modify(var _in, _out1, _out2: TBtArr; h, w: integer);
var i, j, h0, w0: integer;
begin
  h0:=h div 2;
  w0:=w div 2;

  for i:=0 to h0-2 do
    for j:=1 to w-2 do
    begin
      _out1[2*i*w+j]:=_in[2*i*w+j];
      _out1[(2*i+1)*w+j]:=round((_in[2*i*w+j]+_in[2*i*w+j-1]+_in[2*i*w+j+1]+_in[2*(i+1)*w+j]+_in[2*(i+1)*w+j-1]+_in[2*(i+1)*w+j+1])/6);
    end;

  for i:=1 to h0-1 do
    for j:=1 to w-2 do
    begin
      _out2[(2*i+1)*w+j]:=_in[(2*i+1)*w+j];
      _out2[2*i*w+j]:=round((_in[(2*i-1)*w+j]+_in[(2*i-1)*w+j-1]+_in[(2*i-1)*w+j+1]+_in[(2*i+1)*w+j]+_in[(2*i+1)*w+j-1]+_in[(2*i+1)*w+j+1])/6);
    end;
end;


function CheckString(s: string): treal;
var i: integer;
begin
  for i:=1 to length(s) do
    case s[i] of
      '0'..'9', 'E', 'e', '-': ;
      ',','.': s[i]:=DecimalSeparator;
    end;
  try
   Result:=StrToFloat(s);
  except
    on Exception do
    begin
      ShowMessage('Неверный формат числа');
      Result:=1;
    end;
  end;

end;

procedure SecondDerivative(var p,b: TMyInfernalType);
var i,j,w,h,k,l: integer;
    temp, temp_mask: TMyInfernalType;
    b1: TMyInfernalType;
    tmp: treal;
    sw: boolean;
begin
  w:=p.w;
  h:=p.h;
  temp:=TMyInfernalType.Create;
  temp.Init(h, w, varDouble);
  temp_mask:=TMyInfernalType.Create;
  temp_mask.Init(h, w, varByte, 1);
  b1:=TMyInfernalType.Create;
  b1.Init(3, 3, varDouble);
  b1.a^[0]:=-1;
  b1.a^[1]:=-1;
  b1.a^[2]:=-1;
  b1.a^[3]:=-1;
  b1.a^[4]:=8;
  b1.a^[5]:=-1;
  b1.a^[6]:=-1;
  b1.a^[7]:=-1;
  b1.a^[8]:=-1;

  for i:=1 to h-2 do
    for j:=1 to w-2 do
    begin
//      try
        tmp:=0;
        sw:=true;
        for k:=i-1 to i+1 do
          for l:=j-1 to j+1 do
          begin
            if b.b^[k*w+l] <> 1 then
            begin
              sw:=false;
              Continue;
            end;
//              raise EAbort.Create('');

            tmp:=tmp+b1.a^[(k-i+1)*3+l-j+1]*p.a^[k*w+l];
          end;
//      except
//        on eAbort do
//        begin
//          tmp:=0;
//          temp_mask.b^[i*w+j]:=0;
//        end;
//      end;
      if not sw then
      begin
        tmp:=0;
        temp_mask.b^[i*w+j]:=0;
      end;
      temp.a^[i*w+j]:=tmp;
    end;
  CopyMemory(b.b, temp_mask.b, w*h);
  CopyMemory(p.a, temp.a, w*h*sizeof(treal));

  temp.Destroy;
  temp_mask.Destroy;
  b1.Destroy;
end;

end.
