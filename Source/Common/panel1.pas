unit panel1;

interface

uses
  windows, messages, SysUtils, Classes, Controls, ExtCtrls, Graphics, dialogs, math,
  crude, utype, StdCtrls, editr, t666, gdipapi, gdipobj, OpenGL;

type
  T3dPoint = record
               x,y,z: GLfloat;
             end;
  {TReal = Double;
  TRealArray = array [0..0] of TReal;
  PRealArray = ^TRealArray;
  TDoubleArray = array of array of double;
  TBoolArray = array of array of boolean;}
  TPaletteMode = (ColorPalette, GreyPalette, GreyPaletteWithThreshold);
  TPaletteEntryArray = array [0..255] of TPaletteEntry;
  TDrawMode = (dmNone, dmSpline, dmRect, dmLine, dmCirc, dmCross, dmSpline2, dmLargeCross, dmSingleLine,
               dmSimpleSlice, dmPoint, dmStatic, dmSimpleCircle, dmCircle2, dmTemp, dmSimpleRect,
               dmTraceLines, dmNewSpline, dmNull, dmOpenGL, dmOpenGL_STL, dmSprite, dmLine2, dmLine3,
               dmStaticCircles, dmCrossAndCircle, dmNewSlice, dmNewRects, dmNewPoints, dmNPO_cell);
  TDragPoint=(dpNone,dpFirst,dpBegin,dpInter1,dpInter2,dpEnd);
  TInterpMode=(imBilinear, imNearest);
//  TCurve=array of TPoint;
//  TPathArray = array of array of TPoint;
  TCurveMode = (cvNone, cvDrawMode, cvEditMode, cvWait, cvFinished, cvDeleteMode);
  TExpoMode = (em1, em2);
  TSTLdim = record
              maxx, maxy, maxz, minx, miny, minz, cx, cy, cz: treal;
            end;

  tpanel1 = class(TPanel)
  private
    FCountLines, varCountLines, LineIndex: integer;
    FThreshold: boolean;
    FBottom_Level, FTop_Level: treal;
    Ffactor: integer;
    FPaletteMode: TPaletteMode;
    FInterpMode: TInterpMode;
  //  GreyPal, ColorPal: HPALETTE;
    outline, tol: integer;   //количество кривых
    FirstClick: Boolean;

//    PathArray: TPathArray;

    FDrawMode, LastCurve: TDrawMode;
    Origin, point_exact: TPoint;
    mask: TBitmap;
  //  procedure LineDraw(x, y: Integer; Canvas: TCanvas); stdcall;
    Static: array of TStaticObj;
    ColorObj: array of TColor;
    Edit1, Edit2: TEditR;
    Panel1: TPanel;
//    Label1, Label2: TLabel;
//    Button1: TButton;
    switch: boolean;
    w_pict, h_pict, w_img, h_img, x_img, y_img, xc, yc: integer;
    scl: treal;
    sx, sy, sax, say: integer;
    FFinalized: boolean;
    scale_x: TReal;
    grap: TGPGraphics;
    _pen: TGPPen;
    _brush: TGPSolidBrush;
    mt: array[0..3, 0..3] of GLfloat;
    GLColor: array[0..2] of Glfloat;
    SpriteText: string;
    GLQuality: byte;
    ry, rx, module: GLfloat;
    _a: TPoint;
    CrossMode: (cmCross, cmScale);
    Progress: byte;
    circ_x, circ_y, circ_r: TReal;
    procedure FindNearPoint(x, y: integer);
    procedure DrawText(x,y: integer; m: integer = 1);
    procedure DrawCross;
    procedure FindControlPoints(a, b, c: tpoint; var d, e: tpoint; delta1, delta2: integer);
    procedure GenerateMask;
    procedure FindMinMax(var min, max: TReal; var p, mask: TRealArray; width, height: Integer); overload;
    procedure FindMinMax(var min, max: TReal; var p: TRealArray; width, height: Integer); overload;
    procedure FindMinMax(var min, max: TReal; var p: TRealArray; var mask: TBoolArray; width, height: Integer); overload;
    procedure FindMinMax(var min, max: TReal; var p: TDoubleArray; var mask: TBoolArray; width, height: Integer); overload;
    procedure FindMinMax(var min, max: TReal; var p: TDoubleArray; var mask: TBoolArray; minx, miny, w, h: Integer); overload;
    procedure FindMinMax(var min, max: TReal; var p, mask: TMyInfernalType); overload;
    procedure FindMinMax(var min, max: TReal; var p: TMyInfernalType); overload;
    procedure FindMinMax(var min, max: TReal; var p: TDoubleArray; width, height: Integer); overload;
    procedure FindMinMax(var min, max: TReal; var p, mask: TBtArr; width, height: word); overload;
    procedure FindMinMax(var min, max: TReal; var p, mask: TMyInfernalType; minx, miny, w, h: Integer); overload;
    procedure CreateEditWnd(x,y: integer);
    procedure MyProcMsg;
    procedure CreateInterpImage(var p, mask: TMyInfernalType; _top, _bottom, ColorScale: TReal);
    procedure ReSizeInterpImage;
    procedure Find_Circle;
    procedure FindMaxCircle(x, y: integer);
  //  procedure FindPaths;
  protected
    procedure Paint; override;
    procedure ReSize; override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure ChangePaletteMode(value: TPaletteMode);
    procedure ChangeDrawMode(value: TDrawMode);
    procedure ChangeThreshold(value: byte);
    procedure ChangeFactor(value: integer);
    procedure MesMouseWheel(var Wheel: TWMMouseWheel);  message WM_MOUSEWHEEL;
    procedure Button1Click(Sender: TObject);
    procedure WMKeyDown(var msg: TWMKey); message WM_KEYDOWN;
  public
    Curve, tempCurve: TPath;
    temp_point, Point1, Point2: TPoint;
    dc: HDC;
    hrc: HGLRC;
    bitmap, temp_bitmap: TBitmap;
    Scale_OpenGL: treal;
    dimx, dimy, dimz, tempdim: treal;
    min_pal, max_pal{, OpenGL_w, OpenGL_h}: integer;
    Image_OK, Draw_circle: boolean;
    p, _m, bw: TMyInfernalType;
    facet: Pfacet;
    nFacets: integer;
    grab: boolean;
    OpenGLBuf: PSingleArray;
    STLdim: TSTLdim;
    _x, _y, _r: TMyInfernalType;
    lc1, lc2: TCircleCoordArray;
    ExpoMode: TExpoMode;
    CurveMode: TCurveMode;
    _int: PBtArr;
    w_int, h_int: integer;
    CheckListCircles: TInt;
    Curr_checked: integer;
    Contrast_mask: treal;
   // PathArray: TPathArray;
    procedure SetProgress(prgs: byte);
    procedure SetSpriteText(text: string);
    procedure SetGLColor(R, G, B: Single);
    procedure GetNormal(x1, y1, z1, x2, y2, z2, x3, y3, z3: GLfloat; var  norm: T3dPoint);
    procedure DrawModel_OpenGL;
    procedure DrawModel_OpenGL2;
    procedure DrawModel_OpenGL_STL;
    procedure InitOpenGL(var p, mask, bw: TMyInfernalType; k: treal); overload;
    procedure InitOpenGL(var p, mask: TMyInfernalType; k, R, G, B: treal; quality: byte); overload;
    procedure InitOpenGL_STL(_facet: Pfacet; _nFacets: integer);
    procedure ReleaseOpenGL;
    procedure SetPort;
    procedure SetDCPixelFormat(hdc : HDC);
    procedure GetPathPoints(var p: TPath); overload;
    procedure GetPathPoints(var p: TMyInfernalType); overload;
    function GetOrigin: TPoint;
    function GetPoint1: TPoint;
    function GetPoint2: TPoint;
    procedure SetOrigin(point: TPoint); overload;
    procedure SetOrigin(x, y: integer); overload;
    procedure GetMask(p: PRealArray); overload;
    procedure GetMask(var p: TBoolArray); overload;
    procedure GetMask(p: PBtArr); overload;
    procedure GetMask(p, msk: PMyInfernalType); overload;
    procedure GetDistance(var dist: treal);
    procedure DrawImage(var p: TRealArray; var mask: TBtArr; width, height: Integer); overload;
//    procedure DrawImage(var p, mask: TBtArr; width, height: Integer); overload;
    procedure DrawImage(var p, mask: TBtArr; width, height: Integer); overload;
    procedure DrawImage(var p, mask: TRealArray; width, height: Integer); overload;
    procedure DrawImage(var p: TRealArray; width, height: Integer); overload;
    procedure DrawImage(var p: TRealArray; var mask: TBoolArray; width, height: Integer); overload;
    procedure DrawImage(var p: TDoubleArray; var mask: TBoolArray; xmin, ymin, w, h, x_h, y_h, w_h, h_h: Integer); overload;
    procedure DrawImage(var p, mask: TMyInfernalType; xmin, ymin, w, h, x_h, y_h, w_h, h_h: Integer); overload;
    procedure DrawImage(var p: TDoubleArray; width, height: Integer); overload;
    procedure DrawImage(var b: TBoolArray; width, height: Integer); overload;
    procedure DrawImage(var p, mask: TMyInfernalType); overload;
    procedure DrawImage(var p: TMyInfernalType); overload;
    procedure DrawImage24bit(var p, mask: TRealArray; width, height: Integer); overload;
    procedure InitStaticCircles(var x, y, r: TMyInfernalType);
    procedure NullPaint;
    procedure FindMinMax(var min, max: TReal; var p: TRealArray; var mask: TBtArr; width, height: word); overload;
    function CreateGreyPaletteWithThreshold: HPALETTE;
    function CreateGreyPalette: HPALETTE;
    function CreateColorPalette: HPALETTE;
    procedure InitStatic(ObjList: array of TStaticObj; Color: array of TColor; CoordList: TPath);
    procedure DestroyStatic;
    procedure SetScale_x(scale: treal);
    procedure SetVideoRect(w, h: integer);
    constructor Create(aowner: Tcomponent); override;
    destructor Destroy; override;
    procedure SetBuffer(var buf: PSingleArray);
    procedure GetBuffer(var buf: PSingleArray);
    procedure InitStaticCircle(var int: TMyInfernalType);
    procedure ClearStaticCircles;
    procedure GetStaticCircle(var x, y, r: treal);
    procedure GetCheckedCircle(x, y: treal);
    procedure PainBlack;
    procedure InitNewSlices(var p: TPath);
    procedure GetNewSlices(var p: TPath);

  published
    property Palette: TPaletteMode read FPaletteMode write ChangePaletteMode;
    property DrawMode: TDrawMode read FDrawMode write ChangeDrawMode;
    property _CurveMode: TCurveMode read CurveMode write CurveMode;
    property StartPoint: TPoint read Origin write Origin;
    property Threshold: boolean read FThreshold write FThreshold; //ChangeThreshold;
    property Factor: integer read Ffactor write ChangeFactor;
    property Top_Level: treal read FTop_Level write FTop_Level;
    property Bottom_Level: TReal read FBottom_Level write FBottom_Level;
    property Finalized: boolean read FFinalized write FFinalized;
    property CounLines: integer read varCountLines write FCountLines;
    property _LineIndex: integer read LineIndex write LineIndex;
    property InterpMode: TInterpMode read FInterpMode write FInterpMode;
  end;

procedure Register;

implementation

uses DateUtils, unit1;

procedure Register;
begin
  RegisterComponents('Samples', [tpanel1]);
end;

{ tpanel1 }

constructor tpanel1.Create(aowner: Tcomponent);
begin
  inherited Create(aowner);
  mask:=TBitmap.Create;
  mask.PixelFormat:=pf8bit;
  bitmap:=TBitmap.Create;
  FPaletteMode:=GreyPalette;
  FDrawMode:=dmNone;
  FInterpMode:=imNearest;
  bitmap.PixelFormat:=pf8bit;
  FirstClick:=true;
  temp_bitmap:=TBitmap.Create;
//  temp_bitmap.PixelFormat:=pf8bit;
//  temp_bitmap.Palette:=CreateGreyPalette;

  Ffactor:=1;
  FThreshold:=false;
  Top_Level:=1.0;
  Bottom_Level:=0.0;
  sax:=0;
  say:=0;
  grab:=false;
  Draw_circle:=false;
  Curr_checked:=-1;
 {Panel1:=TPanel.Create(Self);
  Panel1.Parent:=Self;
  Panel1.Color:=clWhite;
  Panel1.Width:=89;
  Panel1.Height:=60;
  Edit1:=TEditR.Create(Self);
  Edit1.Parent:=Panel1;
  Edit1.Ctl3D:=False;
  Edit1.Top:=10;
  Edit1.Left:=22;
  Edit1.Width:=40;
  Edit1.Height:=19;
  Edit2:=TEditR.Create(Self);
  Edit2.Ctl3D:=False;
  Edit2.Parent:=Panel1;
  Edit2.Top:=30;
  Edit2.Left:=22;
  Edit2.Width:=40;
  Edit2.Height:=19;
  Label1:=TLabel.Create(Self);
  Label1.Parent:=Panel1;
  Label1.Caption:='X';
  Label1.Top:=16;
  Label1.Left:=8;
  Label2:=TLabel.Create(Self);
  Label2.Parent:=Panel1;
  Label2.Caption:='Y';
  Label2.Top:=36;
  Label2.Left:=8;
  Button1:=TButton.Create(Self);
  Button1.Parent:=Panel1;
  Button1.Left:=66;
  Button1.Top:=16;
  Button1.Width:=17;
  Button1.Height:=25;
  Button1.Caption:='ok';
  Button1.OnClick:=Button1Click;
  Panel1.Visible:=false;  }
  switch:=true;
  DrawMode:=dmNone;
  Palette:=GreyPalette;
  min_pal:=0;
  max_pal:=255;
  outline:=-1;
end;

destructor tpanel1.Destroy;
begin
  bitmap.Destroy;
  mask.Destroy;
  temp_bitmap.Destroy;
  inherited Destroy;
end;

procedure tpanel1.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  if switch then
  case FDrawMode of
    dmSpline: begin
              if ssLeft in Shift then
                case CurveMode of
                  cvDrawMode:         //режим рисования кривой
                    if Length(curve) <> 0 then
                    begin
                      Curve[outline].X:=X;
                      Curve[outline].Y:=Y;
                      if (Length(curve)-1)>=(outline+2) then
                      begin
                        Curve[outline+2].X:=2*Curve[outline+1].X-X;
                        Curve[outline+2].Y:=2*Curve[outline+1].Y-Y;
                      end;
                      Paint;
                    end;
                  cvEditMode:      //режим редактирования
                    if outline >= 0 then
                      case outline mod 3 of
                      0:
                        if (outline = 0) or (outline = Length(curve)-1) then
                        begin
                          curve[1].X:=curve[1].x+x-Curve[0].x;
                          curve[1].y:=curve[1].y+y-Curve[0].y;
                          curve[Length(curve)-2].x:=curve[Length(curve)-2].x+x-Curve[0].x;
                          curve[Length(curve)-2].y:=curve[Length(curve)-2].y+y-Curve[0].y;
                          Curve[0].X:=x;
                          Curve[0].Y:=y;
                          curve[length(curve)-1]:=curve[0];
                          Paint;
                          DrawText(curve[outline].X, curve[outline].Y);
                        end
                        else
                        begin
                          curve[outline-1].X:=curve[outline-1].x+x-Curve[outline].x;
                          curve[outline-1].y:=curve[outline-1].y+y-Curve[outline].y;
                          curve[outline+1].X:=curve[outline+1].x+x-Curve[outline].x;
                          curve[outline+1].y:=curve[outline+1].y+y-Curve[outline].y;
                          Curve[outline].X:=x;
                          Curve[outline].Y:=y;
                          Paint;
                          DrawText(curve[outline].X, curve[outline].Y);
                        end;
                      1:
                        if outline = 1 then
                        begin
                          curve[1].x:=x;
                          curve[1].y:=y;
                          curve[length(curve)-2].X:=2*curve[0].x-x;
                          curve[length(curve)-2].y:=2*curve[0].y-y;
                          Paint;
                        end
                        else
                        begin
                          curve[outline].x:=x;
                          curve[outline].y:=y;
                          curve[outline-2].x:=2*curve[outline-1].X-x;
                          curve[outline-2].y:=2*curve[outline-1].y-y;
                          Paint;
                        end;
                      2:
                        if outline = length(curve)-2 then
                        begin
                          curve[outline].X:=x;
                          curve[outline].y:=y;
                          curve[1].x:=2*curve[0].x-x;
                          curve[1].y:=2*curve[0].y-y;
                          Paint;
                        end
                        else
                        begin
                          curve[outline].X:=x;
                          curve[outline].y:=y;
                          curve[outline+2].x:=2*curve[outline+1].X-x;
                          curve[outline+2].y:=2*curve[outline+1].y-y;
                          Paint;
                        end;
                      end;
                end
              else
              if CurveMode = cvDrawMode then
              begin
                if Length(curve) <> 0 then
                begin
                  temp_point.x:=x;
                  temp_point.y:=y;
                  Paint;
                end
                else
                begin
                  temp_point.x:=x;
                  temp_point.y:=y;
                  paint;
                end;
              end;
            end;
    dmLine: Begin
                case CurveMode of
                  cvDrawMode: if Length(curve) <> 0 then
                                begin
                                  Curve[outline].x:=round((x-sx)*scl+sax);
                                  Curve[outline].y:=round((y-sy)*scl+say);
                                  Paint;
                                end
                                else
                                begin
                                  temp_point.x:=round((x-sx)*scl+sax);
                                  temp_point.Y:=round((y-sy)*scl+say);
                                  Paint;
                                end;
                  cvEditMode: if ssLeft in Shift then
                                begin
                                if (outline = 0) or (outline  = length(curve)-1) then
                                begin
                                  curve[0].x:=round((x-sx)*scl+sax);
                                  curve[0].y:=round((y-sy)*scl+say);
                                  curve[length(curve)-1]:=curve[0];
                                  Paint;
                                end;
                                if outline > 0 then
                                begin
                                  curve[outline].x:=round((x-sx)*scl+sax);
                                  curve[outline].y:=round((y-sy)*scl+say);
                                  Paint;
                                end;
                              end;
                  end;
            end;
    dmLine2: Begin
                case CurveMode of
                  cvDrawMode: if Length(curve) <> 0 then
                                begin
                                  Curve[outline].x:=round((x-sx)*scl+sax);
                                  Curve[outline].y:=round((y-sy)*scl+say);
                                  Paint;
                                end
                                else
                                begin
                                  temp_point.x:=round((x-sx)*scl+sax);
                                  temp_point.Y:=round((y-sy)*scl+say);
                                  Paint;
                                end;
                  cvEditMode: if ssLeft in Shift then
                                begin
                                {if (outline = 0) or (outline  = length(curve)-1) then
                                begin
                                  curve[0].x:=round((x-sx)*scl+sax);
                                  curve[0].y:=round((y-sy)*scl+say);
                                  curve[length(curve)-1]:=curve[0];
                                  Paint;
                                end;}
                                //if outline > 0 then
                                begin
                                  curve[outline].x:=round((x-sx)*scl+sax);
                                  curve[outline].y:=round((y-sy)*scl+say);
                                  Paint;
                                end;
                              end;
                  end;
            end;
    dmCrossAndCircle:  case CurveMode of
                          cvDrawMode:  if (Length(curve) <> 0) then
//                                         if (ssLeft in Shift) then
                                         begin
                                           curve[outline].x:=round((x-sx)*scl+sax);
                                           curve[outline].y:=round((y-sy)*scl+say);
                                           Paint;
                                         end;
                           cvEditMode: begin
                                         if (outline >= 0) and (ssLeft in Shift) then
                                         begin
                                           case outline of
                                              1: begin
                                                   curve[1].x:=round((x-sx)*scl+sax);
                                                   curve[1].y:=round((y-sy)*scl+say);
                                                 end;
                                              0: begin
                                                   temp_point.x:=curve[1].x-curve[0].x;
                                                   temp_point.y:=curve[1].y-curve[0].y;
                                                   curve[0].x:=round((x-sx)*scl+sax);
                                                   curve[0].y:=round((y-sy)*scl+say);
                                                   curve[1].x:=curve[0].x+temp_point.x;
                                                   curve[1].y:=curve[0].y+temp_point.y;
                                                 end;

                                           end;


                                           Paint;




                                         end;


                                       end;



                       end;


    dmRect, dmCirc:  case CurveMode of
                cvDrawMode: if Length(curve) <> 0 then
                            begin
                              if ssShift in Shift then
                              begin
                                if abs((x-sx)*scl+sax-curve[0].x) >= abs((y-sy)*scl+say-curve[0].y) then
                                begin
                                  curve[2].x:=round((x-sx)*scl+sax);
                                  curve[2].y:=curve[0].y+sign((y-sy)*scl+say-curve[0].y)*abs(round((x-sx)*scl+sax)-curve[0].x);
                                end
                                else
                                begin
                                  curve[2].y:=round((y-sy)*scl+say);
                                  curve[2].x:=curve[0].x+sign((x-sx)*scl+sax-curve[0].x)*abs(round((y-sy)*scl+say)-curve[0].y);
                                end;
                              end
                              else
                              begin
                                curve[2].x:=round((x-sx)*scl+sax);
                                curve[2].y:=round((y-sy)*scl+say);
                              end;

                              curve[1].x:=curve[0].x;
                              curve[1].y:=curve[2].y;
                              curve[3].x:=curve[2].x;
                              curve[3].Y:=curve[0].y;
                              paint;
                            end
                            else
                            begin
                              temp_point.x:=round((x-sx)*scl+sax);
                              temp_point.Y:=round((y-sy)*scl+say);
                              Paint;
                            end;
               cvEditMode: if (outline >= 0) and (ssLeft in Shift) then
                           begin
                             if ssShift in Shift then
                             begin
                               if abs((x-sx)*scl+sax-curve[(outline+2) mod 4].x) >= abs((y-sy)*scl+say-curve[(outline+2) mod 4].y) then
                               begin
                                 Curve[outline].x:=round((x-sx)*scl+sax);
                                 Curve[outline].y:=curve[(outline+2) mod 4].y+Sign((y-sy)*scl+say-curve[(outline+2) mod 4].y)*abs(round((x-sx)*scl+sax)-curve[(outline+2) mod 4].x);
                               end
                               else
                               begin
                                 Curve[outline].y:=round((y-sy)*scl+say);
                                 Curve[outline].x:=curve[(outline+2) mod 4].x+Sign((x-sx)*scl+sax-curve[(outline+2) mod 4].x)*abs(round((y-sy)*scl+say)-curve[(outline+2) mod 4].y);
                               end;
                             end
                             else
                             begin
                               curve[outline].x:=round((x-sx)*scl+sax);
                               curve[outline].y:=round((y-sy)*scl+say);
                             end;
                             case outline mod 2 of
                               0: begin
                                    curve[(outline+3) mod 4].y:=curve[outline].y;
                                    curve[outline+1].x:=curve[outline].x;
                                    paint;
                                  end;
                               1: begin
                                    curve[outline-1].x:=curve[outline].x;
                                    curve[(outline+1) mod 4].y:=curve[outline].y;
                                    paint;
                                  end;
                             end;
                           end;
              end;

    dmCircle2: begin
                 case CurveMode of
                   cvDrawMode: if Length(curve) <> 0 then
                               begin
                                 if abs(x-curve[0].x) >= abs(y-curve[0].y) then
                                 begin
                                   curve[1].x:=x;
                                   curve[1].y:=curve[0].y+sign(y-curve[0].y)*abs(x-curve[0].x);
                                 end
                                 else
                                 begin
                                   curve[1].y:=y;
                                   curve[1].x:=curve[0].x+sign(x-curve[0].x)*abs(y-curve[0].y);
                                 end;
                                 Paint;
                               end
                               else
                               begin
                                 temp_point.x:=x;
                                 temp_point.Y:=y;
                                 Paint;
                               end;

                 end;
               end;

    dmCross: begin
               Origin.X:=round((x-sx)*scl+sax);
               Origin.Y:=round((y-sy)*scl+say);
               Paint;
             end;
    dmSpline2: begin
                   case CurveMode of
                     cvDrawMode:
                       if Length(Curve) <> 0 then
                       begin
                         {case Length(tempCurve) of
                           2: begin}
                                {tempCurve[outline].x:=x;
                                tempCurve[outline].y:=y;}
                                Curve[length(curve)-1].x:=x;
                                Curve[length(curve)-1].y:=y;
                                Curve[length(curve)-2]:=Curve[length(curve)-1];
                                if length(curve) > 4 then
                                  FindControlPoints(curve[length(curve)-7], curve[length(curve)-4],
                                  curve[length(curve)-1], curve[length(curve)-5], curve[length(curve)-3],
                                  tol{round(hypot(curve[length(curve)-4].x-curve[length(curve)-7].x,
                                  curve[length(curve)-4].y-curve[length(curve)-7].y)/2)},
                                  {round(hypot(curve[length(curve)-4].x-curve[length(curve)-1].x,
                                  curve[length(curve)-4].y-curve[length(curve)-1].y)/2)}tol);
                                Paint;

                       end;
                   end;
               end;
    dmLargeCross: begin
                  if (ssLeft in Shift) and (CrossMode = cmCross) then
                    if ((x-sx) >= 0) and ((y-sy) >= 0) and
                    ((x-sx)*scl <= (w_img)) and ((y-sy)*scl <= (h_img)) then
                    begin
                      Origin.x:=round((x-sx)*scl+sax);
                      Origin.y:=round((y-sy)*scl+say);
                      Paint;
                    end;
                  if (ssRight in Shift) and (CrossMode = cmScale) then
                    if ((x-sx) >= 0) and ((y-sy) >= 0) and
                    ((x-sx)*scl <= (w_img)) and ((y-sy)*scl <= (h_img)) then
                    begin
                      Point2.x:=round((x-sx)*scl+sax);
                      Point2.y:=round((y-sy)*scl+say);
                      Paint;
                    end;
                  end;
    dmLine3: begin
               if length(curve) <> 0 then
               begin
                 begin
                   if ((x-sx) >= 0) and ((y-sy) >= 0) and
                   ((x-sx)*scl <= (w_img)) and ((y-sy)*scl <= (h_img)) then
                   begin
                     case CurveMode of
                       cvDrawMode: if (outline >= 0) then
                                   begin
                                     curve[outline].x:=round((x-sx)*scl+sax);
                                     curve[outline].y:=round((y-sy)*scl+say);
                                     paint;
                                   end;
                       cvEditMode: begin
                                     if (outline >= 0) and (ssLeft in Shift) then
                                     begin
                                       curve[outline].x:=round((x-sx)*scl+sax);
                                       curve[outline].y:=round((y-sy)*scl+say);
                                       paint;
                                     end;
                                   end;
                     end;
                   end;
                 end;
               end
               else
               begin
                 temp_point.x:=round((x-sx)*scl+sax);
                 temp_point.Y:=round((y-sy)*scl+say);
                 paint;
               end;
             end;
    dmSingleLine: case CurveMode of
                    cvDrawMode: begin
                                  if (Length(curve) >= 2) and (not FirstClick) then
                                  begin
                                    Curve[outline].x:=x;
                                    Curve[outline].y:=y;
                                    {if FirstClick then
                                      temp_point.x:=x;
                                      temp_point.y:=y;}
                                    paint;
                                    exit;
                                  end;
                                  if (Length(curve) <> 0) and FirstClick then
                                  begin
                                     temp_point.x:=x;
                                     temp_point.y:=y;
                                     Paint;
                                     exit;
                                  end;
                                  if Length(curve) = 0 then
                                  begin
                                     temp_point.x:=x;
                                     temp_point.y:=y;
                                     Paint;
                                  end;
                                end;
                    cvEditMode:  if (ssLeft in Shift) and (outline >= 0) then
                                 begin
                                   Curve[outline].x:=x;
                                   Curve[outline].y:=y;
                                   paint;
                                 end;
                  end;
    dmSimpleSlice, dmSimpleRect:
                     if (not FirstClick) then
                     begin
                       if ((x-sx) >= 0) and ((y-sy) >= 0) and        { TODO : Загадочно... }
                       ((x-sx)*scl < (w_img)) and ((y-sy)*scl < (h_img)) then
                       begin
                         Point2.x:=round((x-sx)*scl+sax);
                         Point2.y:=round((y-sy)*scl+say);
                         paint;
                       end;
                     end
                     else
                     begin
                       temp_point.x:=round((x-sx)*scl+sax);
                       temp_point.y:=round((y-sy)*scl+say);
                       Paint;
                     end;
    dmPoint: case CurveMode of
               cvDrawMode: //if length(curve) = 0 then
                           begin
                             temp_point.x:=x;
                             temp_point.y:=y;
                             Paint;
                           end;
               cvEditMode: if (ssLeft in Shift) and (outline >= 0) then
                           begin
                             Curve[outline].x:=x;
                             Curve[outline].y:=y;
                             paint;
                           end;
             end;
    dmSimpleCircle: begin
                      Point2.x:=x;
                      Point2.y:=y;
                      Paint;
                    end;
    dmTraceLines: case CurveMode of
                    cvWait: begin
                              temp_point.x:=round((x-sx)*scl+sax);
                              temp_point.y:=round((y-sy)*scl+say);
                              Paint;
                            end;
                    cvDrawMode:  if ((x-sx) >= 0) and ((y-sy) >= 0) and
                                 ((x-sx)*scl <= (w_img)) and ((y-sy)*scl <= (h_img)) then
                                 begin
                                   curve[outline].x:=round((x-sx)*scl+sax);
                                   curve[outline].y:=round((y-sy)*scl+say);
                                   Point2:=curve[outline];
                                   paint;
                                 end;
                    cvEditMode:  if (outline >= 0) and (ssLeft in Shift) then
                                   if ((x-sx) >= 0) and ((y-sy) >= 0) and
                                   ((x-sx)*scl <= (w_img)) and ((y-sy)*scl <= (h_img)) then
                                   begin
                                     curve[outline].x:=round((x-sx)*scl+sax);
                                     curve[outline].y:=round((y-sy)*scl+say);
                                     if odd(outline) then
                                     begin
                                       Point1:=curve[outline-1];
                                       Point2:=curve[outline];
                                     end
                                     else
                                     begin
                                       Point1:=curve[outline];
                                       Point2:=curve[outline+1];
                                     end;
                                     LineIndex:=(outline div 2) + 1;
                                     paint;
                                   end;

                  end;
    dmNewSpline: begin
                   if Length(curve) <> 0 then
                   begin
                     if ((x-sx) >= 0) and ((y-sy) >= 0) and
                     ((x-sx)*scl <= (w_img)) and ((y-sy)*scl <= (h_img)) then
                     begin
                       if (outline >= 0) and (CurveMode= cvdrawmode)then
                       begin
                         curve[outline].x:=round((x-sx)*scl+sax);
                         curve[outline].y:=round((y-sy)*scl+say);
                         paint;
                       end;
                       if (CurveMode= cveditmode) and not ((ssLeft in Shift)) then
                         FindNearPoint(round((x-sx)*scl+sax),round((y-sy)*scl+say));
                       if (CurveMode= cveditmode) then
                       begin
                         if (outline >= 0) and (ssLeft in Shift) then
                         begin
                           curve[outline].x:=round((x-sx)*scl+sax);
                           curve[outline].y:=round((y-sy)*scl+say);
                         end;
                         paint;
                       end;
                     end;
                   end;
                 end;
    dmOpenGL, dmOpenGL_STL:
              if ssLeft in Shift then
              begin
                rx:=-_a.y+y;
                ry:=-_a.x+x;
                _a.x:=x;
                _a.y:=y;
                module:=sqrt(sqr(rx)+sqr(ry));
                rx:=rx/module;
                ry:=ry/module;
                Paint;
              end;
    dmStaticCircles: begin
                       case CurveMode of
                         cvDrawMode:  if ((x-sx) >= 0) and ((y-sy) >= 0) and
                                      ((x-sx)*scl <= (w_img)) and ((y-sy)*scl <= (h_img)) then
                                      begin
                                        if ssShift in Shift then
                                        begin
                                          FindMaxCircle(round((x-sx)*scl+sax), round((y-sy)*scl+say));
                                        end
                                        else
                                        begin
                                          Origin.x:=round((x-sx)*scl+sax);
                                          Origin.y:=round((y-sy)*scl+say);
                                        end;


                                        if (ssLeft in Shift) and (outline >= 0) then
                                        begin
                                          {if ssShift in Shift then
                                          begin
                                            FindMaxCircle(round((x-sx)*scl+sax), round((y-sy)*scl+say));
                                            curve[outline]:=Origin;
                                          end
                                          else
                                          begin}
                                            curve[outline].x:=round((x-sx)*scl+sax);
                                            curve[outline].y:=round((y-sy)*scl+say);
                                          {end;}

                                        end;
                                        FindNearPoint(round((x-sx)*scl+sax),round((y-sy)*scl+say));
                                        Paint;
                                      end;

                         cvDeleteMode: begin
                                         if ((x-sx) >= 0) and ((y-sy) >= 0) and
                                         ((x-sx)*scl <= (w_img)) and ((y-sy)*scl <= (h_img)) then
                                         begin
                                           GetCheckedCircle((x-sx)*scl+sax, (y-sy)*scl+say);
                                           paint;
                                         end;
                                       end;

                       end;
                     end;

    dmNewSlice: begin
                  if ((x-sx) >= 0) and ((y-sy) >= 0) and
                  ((x-sx)*scl <= (w_img)) and ((y-sy)*scl <= (h_img)) then
                  begin
                    temp_point.x:=round((x-sx)*scl+sax);
                    temp_point.y:=round((y-sy)*scl+say);

                    if odd(length(curve)) then
                    begin
                      Point1:=curve[length(curve)-1];
                      Point2:=temp_point;
                    end;

                    if (ssLeft in Shift) and (outline >= 0) then
                    begin
                      curve[outline].x:=round((x-sx)*scl+sax);
                      curve[outline].y:=round((y-sy)*scl+say);
//                      if outline > 0 then
                      begin
                        if odd(outline) then
                        begin
                          if outline > 0 then
                            Point1:=curve[outline-1];
                          Point2:=curve[outline];
                        end
                        else
                        begin
                          Point1:=curve[outline];
                          if outline < (length(curve)-1) then
                            Point2:=curve[outline+1];
                        end;
                      end;

                    end;
                    FindNearPoint(round((x-sx)*scl+sax),round((y-sy)*scl+say));
                    Paint;
                  end;
                end;
    dmNewRects: begin
                  if ((x-sx) >= 0) and ((y-sy) >= 0) and
                  ((x-sx)*scl <= (w_img)) and ((y-sy)*scl <= (h_img)) then
                  begin
                    temp_point.x:=round((x-sx)*scl+sax);
                    temp_point.y:=round((y-sy)*scl+say);
                    if (ssLeft in Shift) and (outline >= 0) then
                    begin
                      curve[outline].x:=round((x-sx)*scl+sax);
                      curve[outline].y:=round((y-sy)*scl+say);
                    end;
                    FindNearPoint(round((x-sx)*scl+sax),round((y-sy)*scl+say));
                    Paint;
                  end;
                end;
    dmNewPoints: begin
                   if ((x-sx) >= 0) and ((y-sy) >= 0) and
                   ((x-sx)*scl <= (w_img)) and ((y-sy)*scl <= (h_img)) then
                   begin
                     if (ssLeft in Shift) and (outline >= 0) then
                     begin
                       curve[outline].x:=round((x-sx)*scl+sax);
                       curve[outline].y:=round((y-sy)*scl+say);
                     end;
                     FindNearPoint(round((x-sx)*scl+sax),round((y-sy)*scl+say));
                     Paint;
                   end;
                 end;
  end;
  inherited MouseMove(Shift, X, Y);
end;

procedure tpanel1.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var i: integer;
  temp_CheckList: TInt;
  sw: Boolean;
  num: Integer;
begin
 if (ssCtrl in Shift) and switch then
 begin
   CreateEditWnd(x, y);
   repeat
     MyProcMsg;
   until switch;
   X:=point_exact.x;
   Y:=point_exact.y;
 end;

 if switch then
 case FDrawMode of
  dmSpline:
  begin
    if Button=mbLeft then
      case CurveMode of
        cvDrawMode:
          if Length(curve)=0 then
          begin
            SetLength(curve,2);
            Curve[0].X:=X;
            Curve[0].Y:=Y;
            Curve[1]:=Curve[0];
            outline:=1;
            Paint;
          end
          else
          begin
            SetLength(curve,length(curve)+3);
            curve[length(curve)-2].X:=X;
            curve[length(curve)-2].Y:=Y;
            curve[length(curve)-3]:=curve[length(curve)-2];
            curve[length(curve)-1]:=curve[length(curve)-2];
            outline:=length(curve)-3;
            Paint;
          end;
        cvEditMode: begin
                      FindNearPoint(x,y);
                      if outline >= 0 then
                      begin
                        Paint;
                        DrawText(curve[outline].X, curve[outline].Y);
                      end;
                    end;
      end;
      if (Button = mbRight) and (length(curve)>=8) and (CurveMode = cvDrawMode) then
      begin
         SetLength(curve,length(curve)+2);
         curve[length(curve)-1]:=curve[0];
         curve[length(curve)-2].X:=2*curve[0].X-curve[1].X;
         curve[length(curve)-2].Y:=2*curve[0].Y-curve[1].Y;
         CurveMode:=cvEditMode;
         Paint;
         exit;
      end;
      if (Button = mbRight) and (CurveMode = cvEditMode) then
      begin
        ChangeDrawMode(dmCross);
        Origin.X:=x;
        Origin.y:=y;
        Paint;
      end;
  end;
  dmLine: begin
            if Button=mbLeft then
              case CurveMode of
                cvDrawMode:  if Length(curve)=0 then
                             begin
                               SetLength(curve, 2);
                               curve[0].x:=round((x-sx)*scl+sax);
                               Curve[0].y:=round((y-sy)*scl+say);
                               Curve[1]:=curve[0];
                               outline:=1;
                               Paint;
                            end
                            else
                            begin
                              curve[Length(curve)-1].x:=round((x-sx)*scl+sax);
                              Curve[length(curve)-1].y:=round((y-sy)*scl+say);
                              SetLength(curve, length(curve)+1);
                              curve[length(curve)-1]:=curve[length(curve)-2];
                              outline:=length(curve)-1;
                              Paint;
                            end;
                cvEditMode: begin
                              FindNearPoint(round((x-sx)*scl+sax), round((y-sy)*scl)+say);
                              paint;
                            end;
              end;
            if (Button = mbRight) and (length(curve)>=4) and (CurveMode = cvDrawMode) then
            begin
              curve[Length(curve)-1]:=curve[0];
              CurveMode:=cvEditMode;
              Paint;
              exit;
            end;
            if (Button = mbRight) and (CurveMode = cvEditMode) then
            begin
              LastCurve:=FDrawMode;
              ChangeDrawMode(dmNone);
              Origin.x:=0;
              Origin.y:=0;
              for i:=0 to Length(curve)-1 do
              begin
                Origin.x:=Origin.x+curve[i].x;
                Origin.y:=Origin.y+curve[i].y;
              end;
              Origin.x:=round(Origin.x/length(curve));
              Origin.y:=round(Origin.y/length(curve));
              Paint;
            end;
          end;

  dmLine2: begin
            if Button=mbLeft then
              case CurveMode of
                cvDrawMode:  if Length(curve)=0 then
                             begin
                               SetLength(curve, 2);
                               curve[0].x:=round((x-sx)*scl+sax);
                               Curve[0].y:=round((y-sy)*scl+say);
                               Curve[1]:=curve[0];
                               outline:=1;
                               Paint;
                            end
                            else
                            begin
                              curve[Length(curve)-1].x:=round((x-sx)*scl+sax);
                              Curve[length(curve)-1].y:=round((y-sy)*scl+say);
                              SetLength(curve, length(curve)+1);
                              curve[length(curve)-1]:=curve[length(curve)-2];
                              outline:=length(curve)-1;
                              Paint;
                            end;
                cvEditMode: begin
                              FindNearPoint(round((x-sx)*scl+sax), round((y-sy)*scl)+say);
                              paint;
                            end;
              end;
            if (Button = mbRight) and (length(curve)>=2) and (CurveMode = cvDrawMode) then
            begin
              //curve[Length(curve)-1]:=curve[0];
              SetLength(curve, Length(curve)-1);
              CurveMode:=cvEditMode;
              Paint;
              exit;
            end;
            if (Button = mbRight) and (CurveMode = cvEditMode) then
            begin
              LastCurve:=FDrawMode;
              ChangeDrawMode(dmNone);
              Paint;
            end;
          end;

  dmCrossAndCircle: begin
                      if Button=mbLeft then
                        case CurveMode of
                          cvDrawMode: if Length(curve)=0 then
                                      begin
                                        SetLength(curve, 2);
                                        curve[0].x:=round((x-sx)*scl+sax);
                                        Curve[0].y:=round((y-sy)*scl+say);
                                        Curve[1]:=curve[0];
                                        outline:=1;
                                        Paint;
                                      end
                                      else
                                      begin
                                        CurveMode:=cvEditMode;
                                        outline:=-1;
                                        Paint;
                                      end;

                          cvEditMode: begin
                                        FindNearPoint(round((x-sx)*scl+sax), round((y-sy)*scl)+say);
                                      end;

                        end;



                    end;

  dmRect, dmCirc: begin
            if Button=mbLeft then
              case CurveMode of
                cvDrawMode:  if Length(curve)=0 then
                             begin
                               SetLength(curve, 4);
                               curve[0].x:=round((x-sx)*scl+sax);
                               Curve[0].y:=round((y-sy)*scl+say);
                               Curve[1]:=curve[0];
                               Curve[2]:=curve[0];
                               Curve[3]:=curve[0];
                               outline:=2;
                               Paint;
                             end
                             else
                             begin
                               MouseMove(Shift, x, y);
                               CurveMode:=cvEditMode;
                               outline:=-1;
                               Paint;
                             end;
                cvEditMode:
                  begin
                    FindNearPoint(round((x-sx)*scl+sax), round((y-sy)*scl)+say);
                    Paint;
                  end;
              end;
              if (Button = mbRight) and (CurveMode = cvEditMode) then
              begin
                Origin.x:=round((Curve[0].x+Curve[1].x+Curve[2].x+Curve[3].x)/4);
                Origin.y:=round((Curve[0].y+Curve[1].y+Curve[2].y+Curve[3].y)/4);
                LastCurve:=FDrawMode;
                {Origin.x:=round((x-sx)*s
                cl+sax);
                Origin.y:=round((y-sy)*scl+say);
                ChangeDrawMode(dmCross);}
                ChangeDrawMode(dmNone);
                Paint;
              end;
          end;
  dmCircle2: begin
            if Button=mbLeft then
              case CurveMode of
                cvDrawMode:  if Length(curve)=0 then
                             begin
                               SetLength(curve, 2);
                               curve[0].X:=X;
                               Curve[0].Y:=Y;
                               Curve[1]:=curve[0];
                               outline:=1;
                               Paint;
                             end
                             else
                             begin
                               CurveMode:=cvEditMode;
                               outline:=-1;
                             end;
                cvEditMode:
                  begin
                    FindNearPoint(X, Y);
                    Paint;
                  end;
              end;
              if (Button = mbRight) and (CurveMode = cvEditMode) then
              begin
                ChangeDrawMode(dmCross);
                Origin.X:=x;
                Origin.y:=y;
                Paint;
              end;
          end;
  dmCross: begin
             Origin.X:=round((x-sx)*scl+sax);
             Origin.Y:=round((y-sy)*scl+say);
             ChangeDrawMode(dmNone);
             Paint;
           end;
  dmSpline2: begin
               if Button=mbLeft then
                 case CurveMode of
                   cvDrawMode: begin
                                 if Length(Curve) = 0 then
                                 begin
                                   SetLength(Curve, 4);
                                   curve[0].x:=x;
                                   curve[0].y:=y;
                                   curve[1]:=curve[0];
                                   curve[2]:=curve[0];
                                   curve[3]:=curve[0];
                                   paint;
                                 end
                                 else
                                 begin
                                   setlength(curve, length(curve)+3);
                                   curve[length(curve)-1].x:=x;
                                   curve[length(curve)-1].y:=y;
                                   curve[length(curve)-2]:=curve[length(curve)-1];
                                   curve[length(curve)-3]:=curve[length(curve)-4];
                                   tol:=30;
                                   paint;
                                 end;
                               end;
                 end;
               if (Button = mbRight) and (length(curve)>=8) and (CurveMode = cvDrawMode) then
               begin
                 CurveMode:=cvEditMode;
                 FDrawMode:=dmSpline;
                 setlength(curve, length(curve)+3);
                 curve[length(curve)-1]:=curve[0];
                 curve[length(curve)-2]:=curve[0];
                 FindControlPoints(curve[length(curve)-7], curve[length(curve)-4],
                 curve[length(curve)-1], curve[length(curve)-5], curve[length(curve)-3],
                 tol{round(hypot(curve[length(curve)-4].x-curve[length(curve)-7].x,
                 curve[length(curve)-4].y-curve[length(curve)-7].y)/2)},
                 {round(hypot(curve[length(curve)-4].x-curve[length(curve)-1].x,
                 curve[length(curve)-4].y-curve[length(curve)-1].y)/2)}tol);
                 FindControlPoints(curve[length(curve)-4], curve[0],
                 curve[3], curve[length(curve)-2], curve[1],
                 tol{round(hypot(curve[length(curve)-4].x-curve[length(curve)-7].x,
                 curve[length(curve)-4].y-curve[length(curve)-7].y)/2)},
                 {round(hypot(curve[length(curve)-4].x-curve[length(curve)-1].x,
                 curve[length(curve)-4].y-curve[length(curve)-1].y)/2)}tol);
                 paint;

               end;
             end;
  dmLargeCross: begin
                if Button = mbLeft then
                  if ((x-sx) >= 0) and ((y-sy) >= 0) and
                  ((x-sx)*scl <= (w_img)) and ((y-sy)*scl <= (h_img)) then
                  begin
                    Origin.x:=round((x-sx)*scl+sax);
                    Origin.y:=round((y-sy)*scl+say);
                    CrossMode:=cmCross;
                    Paint;
                  end;
                if button = mbRight then
                  if ((x-sx) >= 0) and ((y-sy) >= 0) and
                  ((x-sx)*scl <= (w_img)) and ((y-sy)*scl <= (h_img)) then
                  begin
                    Point1.x:=round((x-sx)*scl+sax);
                    Point1.y:=round((y-sy)*scl+say);
                    Point2:=Point1;
                    CrossMode:=cmScale;
                    Paint;
                  end;
                end;
  dmLine3: begin
             if Button=mbLeft then
               case CurveMode of
                 cvDrawMode: begin
                               if FirstClick then
                               begin
                                 SetLength(curve, 2);
                                 curve[0].x:=round((x-sx)*scl+sax);
                                 curve[0].y:=round((y-sy)*scl+say);
                                 curve[1]:=curve[0];
                                 FirstClick:=false;
                                 Outline:=1;
                                 paint;
                               end
                               else
                               begin
                                 CurveMode:=cvEditMode;
                                 paint;
                               end;
                             end;
                 cvEditMode: begin
                               FindNearPoint(round((x-sx)*scl+sax), round((y-sy)*scl)+say);
                               if outline >= 0 then
                                 paint;
                             end;
               end;
             if (Button = mbRight) and (CurveMode = cvEditMode) then
             begin
               ChangeDrawMode(dmNone);
               paint;
             end;
           end;

  dmSingleLine: begin
                  if Button=mbLeft then
                    case CurveMode of
                      cvDrawMode: begin
                                    if FirstClick then
                                    begin
                                      SetLength(curve, length(curve)+2);
                                      Curve[Length(curve)-2].x:=x;
                                      Curve[Length(curve)-2].y:=y;
                                      Curve[Length(curve)-1]:=Curve[Length(curve)-2];
                                      outline:=length(curve)-1;
                                      FirstClick:=false;
                                      Paint;
                                    end
                                    else
                                    begin
                                      FirstClick:=true;
                                      outline:=-1;
                                    end;
                                  end;
                      cvEditMode: begin
                                    FindNearPoint(x,y);
                                    if outline >= 0 then
                                    begin
                                      Paint;
                                     // DrawText(curve[outline].X, curve[outline].Y);
                                    end;
                                  end;
                    end;
                    if (Button = mbRight) and (length(curve)>=2) and (CurveMode = cvDrawMode) and FirstClick then
                    begin
                      FirstClick:=false;
                      CurveMode:=cvEditMode;
                      outline:=-1;
                      Paint;
                      Exit;
                    end;
                    if (Button = mbRight) and (CurveMode = cvEditMode) then
                    begin
                      outline:=-1;
                      Paint;
                      ChangeDrawMode(dmNone);
                    end;
                end;
  dmSimpleSlice: begin
                   if Button = mbLeft then
                     if FirstClick then
                     begin
                       Origin.x:=round((x-sx)*scl+sax);
                       Origin.y:=round((y-sy)*scl+say);
                       Point2:=Origin;
                       FirstClick:=false;
                       Paint;
                     end
                     else
                     begin
                       FirstClick:=true;
                     //  ChangeDrawMode(dmNone);
                     end;
                 end;
  dmPoint: begin
             if Button = mbLeft then
               case CurveMode of
                 cvDrawMode: begin
                               SetLength(Curve, length(curve)+1);
                               Curve[length(curve)-1].x:=x;
                               Curve[length(curve)-1].y:=y;
                               outline:=-1;
                               paint;
                             end;
                 cvEditMode: begin
                               FindNearPoint(x,y);
                               if outline >= 0 then
                               begin
                                 Paint;
                                 //DrawText(curve[outline].X, curve[outline].Y);
                               end;
                             end;
               end;
             if (Button = mbRight) and (length(curve)> 0) and (CurveMode = cvDrawMode) then
             begin
               CurveMode:=cvEditMode;
               outline:=-1;
               Paint;
               Exit;
             end;
             if (Button = mbRight) and (CurveMode = cvEditMode) then
             begin
               outline:=-1;
               Paint;
               ChangeDrawMode(dmNone);
             end;
           end;
  dmSimpleCircle: if Button = mbLeft then
                  begin
                    Point2.x:=x;
                    Point2.y:=y;
                    ChangeDrawMode(dmNone);
                    Paint;
                  end;
  dmTemp: begin
            CreateEditWnd(x, y);

          end;
  dmSimpleRect:    if Button = mbLeft then
                     if FirstClick then
                     begin
                       if ((x-sx) >= 0) and ((y-sy) >= 0) and
                       ((x-sx)*scl <= (w_img)) and ((y-sy)*scl <= (h_img)) then
                       begin
                         Point1.x:=round((x-sx)*scl+sax);
                         Point1.y:=round((y-sy)*scl+say);
                         Point2:=Point1;
                         FirstClick:=false;
                         Paint;
                       end;
                     end
                     else
                     begin
                       if Point1.x > Point2.x then
                       begin
                         i:=Point1.x;
                         Point1.x:=Point2.x;
                         Point2.x:=i;
                       end;
                       if Point1.y > Point2.y then
                       begin
                         i:=Point1.y;
                         Point1.y:=Point2.y;
                         Point2.y:=i;
                       end;
                       FirstClick:=true;
                       FFinalized:=true;
                       DrawMode:=dmNone;
                       Paint;
                     end;
  dmNewSlice: begin
                if Button = mbLeft then
                begin
                  if ((x-sx) >= 0) and ((y-sy) >= 0) and
                  ((x-sx)*scl <= (w_img)) and ((y-sy)*scl <= (h_img)) then
                  begin
                    {
                    SetLength(Curve, length(curve)+2);
                    curve[length(curve)-2].x:=round((x-sx)*scl+sax);
                    curve[length(curve)-2].y:=round((y-sy)*scl+say);
                    curve[length(curve)-1]:=curve[length(curve)-2];
                    outline:=length(curve)-1;}
                    if outline < 0  then
                    begin
                      SetLength(Curve, length(curve)+1);

                      curve[length(curve)-1].x:=round((x-sx)*scl+sax);
                      curve[length(curve)-1].y:=round((y-sy)*scl+say);
                      paint;
                    end;

                  end;
                end;
              end;
  dmNewRects: begin
                if Button = mbLeft then
                begin
                  if ((x-sx) >= 0) and ((y-sy) >= 0) and
                  ((x-sx)*scl <= (w_img)) and ((y-sy)*scl <= (h_img)) then
                  begin
                    if outline < 0  then
                    begin
                      SetLength(Curve, length(curve)+1);

                      curve[length(curve)-1].x:=round((x-sx)*scl+sax);
                      curve[length(curve)-1].y:=round((y-sy)*scl+say);
                      paint;
                    end;
                  end;
                end;
              end;
  dmNewPoints: begin
                 if ((x-sx) >= 0) and ((y-sy) >= 0) and
                 ((x-sx)*scl <= (w_img)) and ((y-sy)*scl <= (h_img)) then
                 begin
                   if outline < 0  then
                   begin
                     SetLength(Curve, length(curve)+1);

                     curve[length(curve)-1].x:=round((x-sx)*scl+sax);
                     curve[length(curve)-1].y:=round((y-sy)*scl+say);
                     paint;
                   end;
                 end;
               end;
  dmTraceLines: begin
                  if Button = mbLeft then
                  begin
                    if (CurveMode = cvWait) and ((FCountLines = 0) or (varCountLines < FCountLines)) then
                      if ((x-sx) >= 0) and ((y-sy) >= 0) and
                      ((x-sx)*scl <= (w_img)) and ((y-sy)*scl <= (h_img)) then
                      begin
                        CurveMode:=cvDrawMode;
                        SetLength(Curve, length(curve)+2);
                        curve[length(curve)-2].x:=round((x-sx)*scl+sax);
                        curve[length(curve)-2].y:=round((y-sy)*scl+say);
                        curve[length(curve)-1]:=curve[length(curve)-2];
                        outline:=length(curve)-1;
                        Point1:=curve[length(curve)-2];
                        Point2:=Point1;
                        inc(LineIndex);
                        paint;
                        exit;
                      end;
                    if CurveMode =cvDrawMode then
                      if ((x-sx) >= 0) and ((y-sy) >= 0) and
                      ((x-sx)*scl <= (w_img)) and ((y-sy)*scl <= (h_img)) then
                      begin
                        CurveMode:=cvWait;
                        curve[outline].x:=round((x-sx)*scl+sax);
                        curve[outline].y:=round((y-sy)*scl+say);
                        Point2:=curve[outline];
                        inc(varCountLines);
                        if (varCountLines = FCountLines) and (FCountLines <> 0) then
                        begin
                          CurveMode:=cvEditMode;
                          outline:=-1;
                          paint;
                        end;
                        exit;
                      end;

                    if CurveMode = cvEditMode then
                    begin
                      FindNearPoint(round((x-sx)*scl+sax), round((y-sy)*scl)+say);
                      Paint;
                    end;


                  end;
                  if Button = mbRight then
                  begin
                    if (CurveMode = cvDrawMode) then
                      ShowMessage('You should left click to finalize line');
                    if (CurveMode = cvWait) and (FCountLines = 0) and (varCountLines > 0) then
                    begin
                      CurveMode:=cvEditMode;
                      outline:=-1;
                      paint;
                      exit;
                    end;
                    if CurveMode = cvEditMode then
                    begin
                      CurveMode:=cvFinished;
                      FFinalized:=true;
                      ChangeDrawMode(dmNone);
                      paint;
                    end;
                  end;

                end;
  dmNewSpline: begin


                   if ((x-sx) >= 0) and ((y-sy) >= 0) and
                   ((x-sx)*scl <= (w_img)) and ((y-sy)*scl <= (h_img)) then
                   begin
                     if (Button = mbLeft) and (CurveMode = cvdrawmode) then
                     begin
                       if Length(curve)=0 then
                       begin
                         SetLength(curve,2);
                         Curve[0].x:=round((x-sx)*scl+sax);
                         Curve[0].y:=round((y-sy)*scl+say);
                         Curve[1]:=Curve[0];
                         outline:=1;
                         Paint;
                       end
                       else
                       begin
                         SetLength(curve,length(curve)+1);
                         outline:=length(curve)-1;
                         curve[outline].x:=round((x-sx)*scl+sax);
                         curve[outline].y:=round((y-sy)*scl+say);
                         Paint;
                       end;
                     end;
                     if (Button = mbRight) and (length(curve)>2) and (CurveMode = cvdrawmode) then
                     begin
                       {SetLength(curve,length(curve)+1);
                       outline:=length(curve)-1;
                       curve[outline].x:=round((x-sx)*scl+sax);
                       curve[outline].y:=round((y-sy)*scl+say);}
                       Hint:='Left Click to Edit Contour. Right Click to Finish';
                       CurveMode:=cvEditMode;
                       {ChangeDrawMode(dmNone);
                       FFinalized:=true;       }
                       paint;
                       exit;
                     end;
                     if (Button = mbLeft) and (CurveMode = cveditmode) then
                     begin
                       FindNearPoint(round((x-sx)*scl+sax),round((y-sy)*scl+say));
                       if outline >= 0 then
                         Paint;
                     end;
                     if (Button = mbRight) and  (CurveMode = cveditmode) then
                     begin
                       ChangeDrawMode(dmNone);
                       FFinalized:=true;
                       Paint;
                     end;
                   end;
               end;
  dmOpenGL, dmOpenGL_STL:
             if Button = mbLeft then
             begin
               _a.x:=x;
               _a.y:=y;
             end;
  dmStaticCircles: begin
                     if Button = mbLeft then
                     begin
                       case CurveMode of
                         cvDrawMode:  begin
                                        if ((x-sx) >= 0) and ((y-sy) >= 0) and
                                        ((x-sx)*scl <= (w_img)) and ((y-sy)*scl <= (h_img)) and (outline = -1) then
                                        begin
//                                          FindMaxCircle(round((x-sx)*scl+sax), round((y-sy)*scl+say));
                                          SetLength(Curve, length(curve)+1);
                                          Curve[length(curve)-1].x:=Origin.x;
                                          Curve[length(curve)-1].y:=Origin.y;
                                          paint;
                                        end;
                                      end;
                         cvDeleteMode: begin
                                         if ((x-sx) >= 0) and ((y-sy) >= 0) and
                                         ((x-sx)*scl <= (w_img)) and ((y-sy)*scl <= (h_img)) then
                                         begin
                                           GetCheckedCircle((x-sx)*scl+sax, (y-sy)*scl+say);
                                           if Curr_checked >= 0 then
                                           begin
                                             sw:=false;

                                             for i:=0 to length(CheckListCircles)-1 do
                                               if CheckListCircles[i] = Curr_checked then
                                                 sw:=true;
                                             if sw then
                                             begin
                                               SetLength(temp_CheckList, length(CheckListCircles)-1);
                                               num:=0;
                                               for i:=0 to length(CheckListCircles)-1 do
                                               begin
                                                 if CheckListCircles[i] = Curr_checked then
                                                   continue;
                                                 temp_CheckList[num]:=CheckListCircles[i];
                                                 inc(num);
                                               end;
                                               Finalize(CheckListCircles);
                                               SetLength(CheckListCircles, length(temp_CheckList));
                                               for i:=0 to length(temp_CheckList)-1 do
                                                 CheckListCircles[i]:=temp_CheckList[i];
                                               Finalize(temp_CheckList);
                                             end
                                             else
                                             begin
                                               SetLength(CheckListCircles, length(CheckListCircles)+1);
                                               CheckListCircles[length(CheckListCircles)-1]:=Curr_checked;
                                             end;
                                           end;
                                           Curr_checked:=-1;
                                           paint;
                                         end;
                                       end;
                         cvEditMode: ;
                         cvWait: ;
                         cvFinished: ;
                       end;
                     end;
                   end;
  end;
  inherited MouseDown(Button, Shift, X, Y);
end;

procedure tpanel1.FindControlPoints(a, b, c: tpoint; var d, e: tpoint; delta1, delta2: integer);
var alpha, beta: treal;
  //  _t: tpoint;
begin
   alpha:=(ArcTan2((b.Y-a.Y),(b.X-a.X)));
   beta:=-(ArcTan2((c.Y-b.Y),(c.X-b.X)));
   d.x:=b.x+Sign(a.x-c.x)*abs(round(delta1*cos((beta-alpha)/2)));
   d.y:=b.y+Sign(a.y-c.y)*abs(round(delta1*sin((beta-alpha)/2)));
   e.x:=b.X-Sign(a.x-c.x)*abs(round(delta2*cos((beta-alpha)/2)));
   e.Y:=b.y-Sign(a.y-c.y)*abs(round(delta2*sin((beta-alpha)/2)));
end;

procedure tpanel1.PainBlack;
begin
  PatBlt(bitmap.Canvas.Handle, 0, 0, bitmap.Width, bitmap.Height, BLACKNESS);
  Paint;
end;

procedure tpanel1.Paint;
var MyPaint : TPaintStruct;
    i, k: integer;
    t: TReal;
    lkm, pkm: string;
    _lkm, _pkm: integer;
    r, g, b: integer;
    x1, y1, x2, y2: integer;
  u: TCircleCoordArray;
  tclr: Integer;
begin
  if (FDrawMode = dmNull) then
  begin
    BeginPaint(temp_bitmap.Canvas.Handle, MyPaint);
    PatBlt(temp_bitmap.Canvas.Handle, 0, 0, Width, Height, BLACKNESS);

    with temp_bitmap.Canvas do
    begin
   //   Draw(0,0, bitmap);
      StretchDraw(Rect(sx, sy, w_pict+sx, h_pict+sy), bitmap);

      {Pen.Mode:=pmCopy;
      Pen.Width:=1;
      Pen.Style:=psSolid;
      Pen.Color:=clGreen;
      Brush.Color:=clGreen;}
      {if Image_OK then
      begin
        Pen.Color:=clGreen;
        Brush.Color:=clGreen;
      end
      else
      begin
        Pen.Color:=clRed;
        Brush.Color:=clRed;
      end;}
      {Rectangle(xc-100, yc-1, xc+100, yc+1);
      Rectangle(xc-1, yc-100, xc+1, yc+100);
      Pen.Color:=clRed;
      Brush.Style:=bsClear;
      if Draw_circle then
        temp_bitmap.Canvas.Ellipse(xc-300,  yc-300, xc+300,  yc+300);}
      {MoveTo(xc-100, yc);
      LineTo(xc+101, yc);
      MoveTo(xc, yc-100);
      LineTo(xc, yc+101);}

    //    temp_bitmap.Canvas.Draw(0, 0, form1.Image2.Picture.Icon)
     //   temp_bitmap.Canvas.Draw(0, 0, form1.Image1.Picture.Icon);
    end;


    Canvas.Draw(0,0, temp_bitmap);

    EndPaint(temp_bitmap.Canvas.Handle, MyPaint);
    exit;
  end;

  if FDrawMode = dmOpenGL then
  begin
    DrawModel_OpenGL2;
    exit;
  end;

  if FDrawMode = dmOpenGL_STL then
  begin
    DrawModel_OpenGL_STL;
    exit;
  end;

  if FDrawMode = dmSprite then
  begin
    BeginPaint(temp_bitmap.Canvas.Handle, MyPaint);
    PatBlt(temp_bitmap.Canvas.Handle, 0, 0, Width, Height, BLACKNESS);
    with temp_bitmap.Canvas do
    begin
      StretchDraw(Rect(sx, sy, w_pict+sx, h_pict+sy), bitmap);
      Brush.Color:=clBlack;
      Brush.Style:=bsSolid;
      Pen.Mode:=pmCopy;
      Pen.Color:=clNone;
      Pen.Style:=psClear;
      Font.Color:=clWhite;
      Font.Size:=12;
      Font.Style:=[fsBold];
      SetBkMode(Handle, TRANSPARENT);
      Point1.x:=(temp_bitmap.Width div 2)-150;
      Point1.y:=(temp_bitmap.Height div 2)-90;
      Rectangle(Point1.x, Point1.y, Point1.x+300, Point1.y+180);
      TextOut(Point1.x+((300-TextWidth(SpriteText)) div 2), Point1.y+33, SpriteText);
      Brush.Color:=RGB(128, 128, 128);
      Rectangle(Point1.x+25, Point1.y+90, Point1.x+275, Point1.y+150);
      Brush.Color:=clWhite;
      Rectangle(Point1.x+25, Point1.y+90, Point1.x+25+Round(2.5*Progress), Point1.y+150);
    end;
    EndPaint(temp_bitmap.Canvas.Handle, MyPaint);
     Canvas.Draw(0,0, temp_bitmap);
    exit;
  end;


  BeginPaint(temp_bitmap.Canvas.Handle, MyPaint);
  PatBlt(temp_bitmap.Canvas.Handle, 0, 0, Width,Height, BLACKNESS);
  case InterpMode of
    imBilinear: temp_bitmap.Canvas.Draw(sx, sy, bitmap);
    imNearest: temp_bitmap.Canvas.StretchDraw(Rect(sx, sy, w_pict+sx, h_pict+sy), bitmap);
  end;
 {
  if Width > w_pict then
    temp_bitmap.Canvas.StretchDraw(Rect(sx, 0, w_pict+sx, h_pict), bitmap)
//    BitBlt(Canvas.Handle,round((Width-temp_bitmap.Width)/2),0, temp_bitmap.Width, temp_bitmap.Height, temp_bitmap.Canvas.Handle, 0, 0, SRCCOPY)
  else
    temp_bitmap.Canvas.StretchDraw(Rect(0, sy, w_pict, h_pict+sy), bitmap);
//    BitBlt(Canvas.Handle, 0, round((Height-temp_bitmap.Height)/2), temp_bitmap.Width, temp_bitmap.Height, temp_bitmap.Canvas.Handle, 0, 0, SRCCOPY);
  }

//  BitBlt(temp_bitmap.Canvas.Handle, 0, 0, bitmap.Width, bitmap.Height, bitmap.Canvas.Handle, 0, 0, SRCCOPY);
 // StretchBlt(temp_bitmap.Canvas.Handle, 0, 0, w_pict, h_pict, bitmap.Canvas.Handle, 0, 0, bitmap.Width, bitmap.Height,  SRCCOPY);
 // temp_bitmap.Canvas.Pen.Color:=RGB(61, 247, 40);
 // if FPaletteMode = ColorPalette then
  temp_bitmap.Canvas.Pen.Mode:=pmNot;

  temp_bitmap.Canvas.Brush.Style:=bsClear;
  case FDrawMode of
    dmSpline: begin
                if (length(curve)<>0) then
                begin
                  for i := 0 to length(curve)-2 do
                  begin
                    if (i mod 3 = 0) or (i mod 3 = 2) then
                    begin
                      if length(curve)<>i then
                      begin
                        temp_bitmap.Canvas.MoveTo(Curve[i].X, Curve[i].Y);
                        temp_bitmap.Canvas.LineTo(Curve[i+1].X, Curve[i+1].Y);
                      end;
                    end;
                  end;
                  temp_bitmap.Canvas.PolyBezier(Copy(curve, 0, 3*(length(curve) div 3)+1));
                  if (Curve[0].x <> curve[length(curve)-1].x) and (Curve[0].y <> curve[length(curve)-1].y) then
                    for i:=0 to length(curve)-1 do
                      temp_bitmap.Canvas.Rectangle(Curve[i].X-3,Curve[i].Y-3,Curve[i].X+4,Curve[i].Y+4)
                  else
                    for i:=0 to length(curve)-2 do
                      temp_bitmap.Canvas.Rectangle(Curve[i].X-3,Curve[i].Y-3,Curve[i].X+4,Curve[i].Y+4);
                  if outline >= 0 then
                    DrawText(curve[outline].X,curve[outline].y);
                end
                else
                  DrawText(temp_point.x,temp_point.y);
              end;
    dmCross: begin
                {case LastCurve of
                  dmSpline: begin
                              temp_bitmap.Canvas.PolyBezier(Curve);
                              DrawCross;
                            end;
                  dmLine: begin
                            temp_bitmap.Canvas.MoveTo(curve[0].X, curve[0].y);
                            for i:=1 to length(curve)-1 do
                              temp_bitmap.Canvas.LineTo(curve[i].X, curve[i].Y);
                            DrawCross;
                          end;
                  dmRect: begin
                            temp_bitmap.Canvas.MoveTo(round((curve[0].x-sax)/scl)+sx,round((curve[0].Y-say)/scl)+sy);
                            for i:=1 to Length(curve)-1 do
                              temp_bitmap.Canvas.LineTo(round((curve[i].x-sax)/scl)+sx, round((curve[i].y-say)/scl)+sy);
                            temp_bitmap.Canvas.LineTo(round((curve[0].x-sax)/scl)+sx, round((curve[0].y-say)/scl)+sy);
                            DrawCross;
                          end;
                  dmCirc: begin
                            temp_bitmap.Canvas.Ellipse(round((curve[0].X-sax)/scl)+sx, round((curve[0].Y-say)/scl)+sy, round((curve[2].X-sax)/scl)+sx, round((curve[2].Y-say)/scl)+sy);
                            DrawCross;
                          end;
                  dmNone: begin
                            DrawCross;
                          end;
                  end;}
                  SetTextColor(temp_bitmap.Canvas.Handle, clRed);
                  with temp_bitmap.Canvas do
                  begin
                    TextOut(round((origin.x-sax)/scl)+10+sx,round((Origin.y-say)/scl)-30+sy, 'x = '+IntToStr(Origin.X));
                    TextOut(round((origin.x-sax)/scl)+10+sx,round((Origin.y-say)/scl)-20+sy, 'y = '+IntToStr(Origin.Y));
                    {Brush.Style:=bsSolid;
                    Brush.Color:=clGreen;
                    pen.Mode:=pmCopy;
                    pen.Color:=clGreen;
                    Rectangle(round((origin.x-sax)/scl)+sx-15, round((Origin.y-say)/scl)+sy-3, round((origin.x-sax)/scl)+sx+14, round((Origin.y-say)/scl)+sy+2);
                    Rectangle(round((origin.x-sax)/scl)+sx-3, round((Origin.y-say)/scl)+sy-15, round((origin.x-sax)/scl)+sx+2, round((Origin.y-say)/scl)+sy+14);}
                  end;
              end;
    dmLine: begin
               if (length(curve) <> 0) then
               begin
                 temp_bitmap.Canvas.Pen.Mode:=pmCopy;
                 temp_bitmap.Canvas.Pen.Color:=clRed;
                 temp_bitmap.Canvas.MoveTo(round((curve[0].x-sax)/scl)+sx, round((curve[0].Y-say)/scl)+sy);
                 for i:=1 to Length(curve)-1 do
                   temp_bitmap.Canvas.LineTo(round((curve[i].x-sax)/scl)+sx, round((curve[i].y-say)/scl)+sy);
                 temp_bitmap.Canvas.Pen.Color:=clBlack;
                 temp_bitmap.Canvas.Brush.Color:=clRed;
                 for i:=0 to length(curve)-2 do
                   temp_bitmap.Canvas.Rectangle(round((Curve[i].x-sax)/scl)-3+sx,round((Curve[i].y-say)/scl)-3+sy,round((Curve[i].x-sax)/scl)+4+sx,round((Curve[i].y-say)/scl)+4+sy);
                 if outline >= 0 then
                   DrawText(round((curve[outline].x-sax)/scl)+sx,round((curve[outline].y-say)/scl)+sy);
               end
               else
                 DrawText(round((temp_point.x-sax)/scl)+sx, round((temp_point.y-say)/scl)+sy);

               lkm:='Левая кнопка мыши:';
               pkm:='Правая кнопка мыши:';
               temp_bitmap.Canvas.Font.Style:=[fsBold];
               _lkm:=temp_bitmap.Canvas.TextWidth(lkm);
               _pkm:=temp_bitmap.Canvas.TextWidth(pkm);
               temp_bitmap.Canvas.Pen.Mode:=pmCopy;

               case CurveMode of
                 cvDrawMode: begin
                               temp_bitmap.Canvas.Brush.Color:=RGB(255, 255, 160);
                               temp_bitmap.Canvas.Rectangle(10, temp_bitmap.Height-55, 340, temp_bitmap.Height-10);
                               temp_bitmap.Canvas.TextOut(16, temp_bitmap.Height-48, lkm);
                               temp_bitmap.Canvas.TextOut(16, temp_bitmap.Height-31, pkm);
                               temp_bitmap.Canvas.Font.Style:=[];
                               temp_bitmap.Canvas.TextOut(16+_lkm+5, temp_bitmap.Height-48, 'поставить точку контура');
                               temp_bitmap.Canvas.TextOut(16+_pkm+5, temp_bitmap.Height-31, 'перейти в режим редактирования.');
                             end;

                 cvEditMode: begin
                               temp_bitmap.Canvas.Brush.Color:=RGB(255, 255, 160);
                               temp_bitmap.Canvas.Rectangle(10, temp_bitmap.Height-55, 390, temp_bitmap.Height-10);
                               temp_bitmap.Canvas.TextOut(16, temp_bitmap.Height-48, lkm);
                               temp_bitmap.Canvas.TextOut(16, temp_bitmap.Height-31, pkm);
                               temp_bitmap.Canvas.Font.Style:=[];
                               temp_bitmap.Canvas.TextOut(16+_lkm+5, temp_bitmap.Height-48, 'щелкните на маркере и переместите границу.');
                               temp_bitmap.Canvas.TextOut(16+_pkm+5, temp_bitmap.Height-31, 'завершить выделение контура.');
                             end;

               end;
             end;
    dmLine2: begin
               if (length(curve) <> 0) then
               begin
                 temp_bitmap.Canvas.Pen.Mode:=pmCopy;
                 temp_bitmap.Canvas.Pen.Color:=clRed;
                 temp_bitmap.Canvas.MoveTo(round((curve[0].x-sax)/scl)+sx, round((curve[0].Y-say)/scl)+sy);
                 for i:=1 to Length(curve)-1 do
                   temp_bitmap.Canvas.LineTo(round((curve[i].x-sax)/scl)+sx, round((curve[i].y-say)/scl)+sy);
                 temp_bitmap.Canvas.Pen.Color:=clBlack;
                 temp_bitmap.Canvas.Brush.Color:=clRed;
                 for i:=0 to length(curve)-1 do
                   temp_bitmap.Canvas.Rectangle(round((Curve[i].x-sax)/scl)-3+sx,round((Curve[i].y-say)/scl)-3+sy,round((Curve[i].x-sax)/scl)+4+sx,round((Curve[i].y-say)/scl)+4+sy);
                 if outline >= 0 then
                   DrawText(round((curve[outline].x-sax)/scl)+sx,round((curve[outline].y-say)/scl)+sy);
               end
               else
                 DrawText(round((temp_point.x-sax)/scl)+sx, round((temp_point.y-say)/scl)+sy);

               lkm:='Левая кнопка мыши:';
               pkm:='Правая кнопка мыши:';
               temp_bitmap.Canvas.Font.Style:=[fsBold];
               _lkm:=temp_bitmap.Canvas.TextWidth(lkm);
               _pkm:=temp_bitmap.Canvas.TextWidth(pkm);
               temp_bitmap.Canvas.Pen.Mode:=pmCopy;

               case CurveMode of
                 cvDrawMode: begin
                               temp_bitmap.Canvas.Brush.Color:=RGB(255, 255, 160);
                               temp_bitmap.Canvas.Rectangle(10, temp_bitmap.Height-55, 340, temp_bitmap.Height-10);
                               temp_bitmap.Canvas.TextOut(16, temp_bitmap.Height-48, lkm);
                               temp_bitmap.Canvas.TextOut(16, temp_bitmap.Height-31, pkm);
                               temp_bitmap.Canvas.Font.Style:=[];
                               temp_bitmap.Canvas.TextOut(16+_lkm+5, temp_bitmap.Height-48, 'поставить точку контура');
                               temp_bitmap.Canvas.TextOut(16+_pkm+5, temp_bitmap.Height-31, 'перейти в режим редактирования.');
                             end;

                 cvEditMode: begin
                               temp_bitmap.Canvas.Brush.Color:=RGB(255, 255, 160);
                               temp_bitmap.Canvas.Rectangle(10, temp_bitmap.Height-55, 390, temp_bitmap.Height-10);
                               temp_bitmap.Canvas.TextOut(16, temp_bitmap.Height-48, lkm);
                               temp_bitmap.Canvas.TextOut(16, temp_bitmap.Height-31, pkm);
                               temp_bitmap.Canvas.Font.Style:=[];
                               temp_bitmap.Canvas.TextOut(16+_lkm+5, temp_bitmap.Height-48, 'щелкните на маркере и переместите границу.');
                               temp_bitmap.Canvas.TextOut(16+_pkm+5, temp_bitmap.Height-31, 'завершить выделение контура.');
                             end;

               end;
             end;
    dmRect: begin
               if (length(curve)<>0) then
               begin
                 temp_bitmap.Canvas.Pen.Mode:=pmCopy;
                 temp_bitmap.Canvas.Pen.Color:=clRed;
                 temp_bitmap.Canvas.MoveTo(round((curve[0].x-sax)/scl)+sx,round((curve[0].Y-say)/scl)+sy);
                 for i:=1 to Length(curve)-1 do
                   temp_bitmap.Canvas.LineTo(round((curve[i].x-sax)/scl)+sx, round((curve[i].y-say)/scl)+sy);
                 temp_bitmap.Canvas.LineTo(round((curve[0].X-sax)/scl)+sx, round((curve[0].Y-say)/scl)+sy);
                 temp_bitmap.Canvas.Pen.Color:=clBlack;
                 temp_bitmap.Canvas.Brush.Color:=clRed;
                 for i:=0 to length(curve)-1 do
                   temp_bitmap.Canvas.Rectangle(round((Curve[i].x-sax)/scl)-3+sx,round((Curve[i].y-say)/scl)-3+sy,round((Curve[i].x-sax)/scl)+4+sx,round((Curve[i].y-say)/scl)+4+sy);
                 if outline >= 0 then
                   DrawText(round((curve[outline].x-sax)/scl)+sx,round((curve[outline].y-say)/scl)+sy);
               end
               else
                 DrawText(round((temp_point.x-sax)/scl)+sx,round((temp_point.y-say)/scl)+sy);

               lkm:='Левая кнопка мыши:';
               pkm:='Правая кнопка мыши:';
               temp_bitmap.Canvas.Font.Style:=[fsBold];
               _lkm:=temp_bitmap.Canvas.TextWidth(lkm);
               _pkm:=temp_bitmap.Canvas.TextWidth(pkm);
               temp_bitmap.Canvas.Pen.Mode:=pmCopy;

               case CurveMode of
                 cvDrawMode: begin
                               temp_bitmap.Canvas.Brush.Color:=RGB(255, 255, 160);
                               temp_bitmap.Canvas.Rectangle(10, temp_bitmap.Height-55, 310, temp_bitmap.Height-10);
                               temp_bitmap.Canvas.TextOut(16, temp_bitmap.Height-48, lkm);
                               //temp_bitmap.Canvas.TextOut(16, temp_bitmap.Height-31, pkm);
                               temp_bitmap.Canvas.Font.Style:=[];
                               if length(curve)=0 then
                                 temp_bitmap.Canvas.TextOut(16+_lkm+5, temp_bitmap.Height-48, 'укажите 1ую точку контура')
                               else
                                 temp_bitmap.Canvas.TextOut(16+_lkm+5, temp_bitmap.Height-48, 'укажите 2ую точку контура');
                             end;

                 cvEditMode: begin
                               temp_bitmap.Canvas.Brush.Color:=RGB(255, 255, 160);
                               temp_bitmap.Canvas.Rectangle(10, temp_bitmap.Height-55, 390, temp_bitmap.Height-10);
                               temp_bitmap.Canvas.TextOut(16, temp_bitmap.Height-48, lkm);
                               temp_bitmap.Canvas.TextOut(16, temp_bitmap.Height-31, pkm);
                               temp_bitmap.Canvas.Font.Style:=[];
                               temp_bitmap.Canvas.TextOut(16+_lkm+5, temp_bitmap.Height-48, 'щелкните на маркере и переместите границу.');
                               temp_bitmap.Canvas.TextOut(16+_pkm+5, temp_bitmap.Height-31, 'завершить выделение контура.');
                             end;

               end;
             end;
     dmCirc: begin
               lkm:='Левая кнопка мыши:';
               pkm:='Правая кнопка мыши:';
               temp_bitmap.Canvas.Font.Style:=[fsBold];
               _lkm:=temp_bitmap.Canvas.TextWidth(lkm);
               _pkm:=temp_bitmap.Canvas.TextWidth(pkm);
               temp_bitmap.Canvas.Pen.Mode:=pmCopy;

               case CurveMode of
                 cvDrawMode: begin
                               temp_bitmap.Canvas.Brush.Color:=RGB(255, 255, 160);
                               temp_bitmap.Canvas.Rectangle(10, temp_bitmap.Height-55, 310, temp_bitmap.Height-10);
                               temp_bitmap.Canvas.TextOut(16, temp_bitmap.Height-48, lkm);
                               //temp_bitmap.Canvas.TextOut(16, temp_bitmap.Height-31, pkm);
                               temp_bitmap.Canvas.Font.Style:=[];
                               if length(curve)=0 then
                                 temp_bitmap.Canvas.TextOut(16+_lkm+5, temp_bitmap.Height-48, 'укажите 1ую точку контура')
                               else
                                 temp_bitmap.Canvas.TextOut(16+_lkm+5, temp_bitmap.Height-48, 'укажите 2ую точку контура');
                             end;

                 cvEditMode: begin
                               temp_bitmap.Canvas.Brush.Color:=RGB(255, 255, 160);
                               temp_bitmap.Canvas.Rectangle(10, temp_bitmap.Height-55, 390, temp_bitmap.Height-10);
                               temp_bitmap.Canvas.TextOut(16, temp_bitmap.Height-48, lkm);
                               temp_bitmap.Canvas.TextOut(16, temp_bitmap.Height-31, pkm);
                               temp_bitmap.Canvas.Font.Style:=[];
                               temp_bitmap.Canvas.TextOut(16+_lkm+5, temp_bitmap.Height-48, 'щелкните на маркере и переместите границу.');
                               temp_bitmap.Canvas.TextOut(16+_pkm+5, temp_bitmap.Height-31, 'завершить выделение контура.');
                             end;
               end;
               temp_bitmap.Canvas.Brush.Style:=bsClear;
               if (length(curve) <> 0) then
               begin
                 temp_bitmap.Canvas.Pen.Mode:=pmCopy;
                 temp_bitmap.Canvas.Pen.Color:=clRed;
                 temp_bitmap.Canvas.MoveTo(round((curve[0].x-sax)/scl)+sx,round((curve[0].Y-say)/scl)+sy);
                 for i:=1 to Length(curve)-1 do
                   temp_bitmap.Canvas.LineTo(round((curve[i].x-sax)/scl)+sx, round((curve[i].y-say)/scl)+sy);
                 temp_bitmap.Canvas.LineTo(round((curve[0].X-sax)/scl)+sx, round((curve[0].Y-say)/scl)+sy);
                 temp_bitmap.Canvas.Ellipse(round((curve[0].X-sax)/scl)+sx, round((curve[0].Y-say)/scl)+sy, round((curve[2].X-sax)/scl)+sx, round((curve[2].Y-say)/scl)+sy);
                 temp_bitmap.Canvas.Pen.Color:=clBlack;
                 temp_bitmap.Canvas.Brush.Color:=clRed;
                 for i:=0 to length(curve)-1 do
                   temp_bitmap.Canvas.Rectangle(round((Curve[i].x-sax)/scl)-3+sx,round((Curve[i].y-say)/scl)-3+sy,round((Curve[i].x-sax)/scl)+4+sx,round((Curve[i].y-say)/scl)+4+sy);
                 if outline >= 0 then
                   DrawText(round((curve[outline].x-sax)/scl)+sx,round((curve[outline].y-say)/scl)+sy);
               end
               else
                 DrawText(round((temp_point.x-sax)/scl)+sx,round((temp_point.y-say)/scl)+sy);
             end;
     dmLine3: begin
                temp_bitmap.Canvas.Pen.Mode:=pmCopy;
                temp_bitmap.Canvas.Brush.Style:=bsClear;
                lkm:='Левая кнопка мыши:';
                pkm:='Правая кнопка мыши:';
                temp_bitmap.Canvas.Font.Style:=[fsBold];
                _lkm:=temp_bitmap.Canvas.TextWidth(lkm);
                _pkm:=temp_bitmap.Canvas.TextWidth(pkm);

                case CurveMode of
                  cvDrawMode: begin
                                temp_bitmap.Canvas.Brush.Color:=RGB(255, 255, 160);
                                temp_bitmap.Canvas.Rectangle(10, temp_bitmap.Height-55, 310, temp_bitmap.Height-10);
                                temp_bitmap.Canvas.TextOut(16, temp_bitmap.Height-48, lkm);
                                //temp_bitmap.Canvas.TextOut(16, temp_bitmap.Height-31, pkm);
                                temp_bitmap.Canvas.Font.Style:=[];
                                if length(curve)=0 then
                                  temp_bitmap.Canvas.TextOut(16+_lkm+5, temp_bitmap.Height-48, 'укажите 1ую точку линии.')
                                else
                                  temp_bitmap.Canvas.TextOut(16+_lkm+5, temp_bitmap.Height-48, 'укажите 2ую точку линии.');
                              end;

                  cvEditMode: begin
                                temp_bitmap.Canvas.Brush.Color:=RGB(255, 255, 160);
                                temp_bitmap.Canvas.Rectangle(10, temp_bitmap.Height-55, 390, temp_bitmap.Height-10);
                                temp_bitmap.Canvas.TextOut(16, temp_bitmap.Height-48, lkm);
                                temp_bitmap.Canvas.TextOut(16, temp_bitmap.Height-31, pkm);
                                temp_bitmap.Canvas.Font.Style:=[];
                                temp_bitmap.Canvas.TextOut(16+_lkm+5, temp_bitmap.Height-48, 'щелкните на маркере и переместите точку.');
                                temp_bitmap.Canvas.TextOut(16+_pkm+5, temp_bitmap.Height-31, 'завершить калибровку масштаба.');
                              end;
                end;
                if (length(curve) <> 0) then
                begin
                  temp_bitmap.Canvas.Pen.Color:=clRed;
                  temp_bitmap.Canvas.MoveTo(round((curve[0].x-sax)/scl)+sx,round((curve[0].y-say)/scl)+sy);
                  temp_bitmap.Canvas.LineTo(round((curve[1].x-sax)/scl)+sx, round((curve[1].y-say)/scl)+sy);
                  temp_bitmap.Canvas.Pen.Color:=clBlack;
                  temp_bitmap.Canvas.Brush.Color:=clRed;
                  for i:=0 to length(curve)-1 do
                    temp_bitmap.Canvas.Rectangle(round((Curve[i].x-sax)/scl)-3+sx,round((Curve[i].y-say)/scl)-3+sy,round((Curve[i].x-sax)/scl)+4+sx,round((Curve[i].y-say)/scl)+4+sy);
                   if outline >= 0 then
                     DrawText(round((curve[outline].x-sax)/scl)+sx,round((curve[outline].y-say)/scl)+sy);
                end
                else
                  DrawText(round((temp_point.x-sax)/scl)+sx,round((temp_point.y-say)/scl)+sy);
              end;
     dmCircle2: begin
                  if (length(curve)<>0) then
                  begin
                    i:=round((curve[0].y+curve[1].y)/2);
                    k:=round((curve[0].x+curve[1].x)/2);
                    temp_bitmap.Canvas.MoveTo(k-10, i);
                    temp_bitmap.Canvas.LineTo(k+10, i);
                    temp_bitmap.Canvas.MoveTo(k, i-10);
                    temp_bitmap.Canvas.LineTo(k, i+10);

                    temp_bitmap.Canvas.Ellipse(curve[0].X, curve[0].Y, curve[1].x,curve[1].y);
                    {for i:=0 to length(curve)-1 do
                      temp_bitmap.Canvas.Rectangle(Curve[i].X-3,Curve[i].Y-3,Curve[i].X+4,Curve[i].Y+4);}
                    {if outline >= 0 then
                      DrawText(curve[outline].X,curve[outline].y);}
                  end;
                  {else
                    DrawText(temp_point.x,temp_point.y);}
                end;


     dmSpline2: begin
                  if (length(Curve)<>0) then
                  begin
                    temp_bitmap.Canvas.PolyBezier(curve);
                    for i := 0 to length(Curve)-1 do
                      if (i mod 3) = 0 then
                        temp_bitmap.Canvas.Rectangle(Curve[i].X-3,Curve[i].Y-3,Curve[i].X+4,Curve[i].Y+4);
                  end;
                end;
     dmLargeCross: begin
                     case CrossMode of
                       cmCross:  begin
                                   temp_bitmap.Canvas.Pen.Mode:=pmCopy;
                                   temp_bitmap.Canvas.Pen.Color:=clRed;
                                   temp_bitmap.Canvas.MoveTo(sx, round((Origin.y-say)/scl)+sy);
                                   temp_bitmap.Canvas.LineTo(w_pict+sx-1, round((Origin.y-say)/scl)+sy);
                                   temp_bitmap.Canvas.MoveTo(round((Origin.x-sax)/scl)+sx, sy);
                                   temp_bitmap.Canvas.LineTo(round((Origin.x-sax)/scl)+sx, sy+h_pict-1);
                                 end;
                       cmScale:  begin
                                   temp_bitmap.Canvas.Rectangle(round((Point1.x-sax)/scl)+sx, round((Point1.y-say)/scl)+sy, round((Point2.x-sax)/scl)+sx, round((Point2.y-say)/scl)+sy);
                                 end;
                      end;

                   end;
     dmSingleLine: if Length(curve) <> 0 then
                   begin
                     for i:=0 to (Length(curve) div 2)-1 do
                     begin
                       temp_bitmap.Canvas.MoveTo(curve[2*i].X, curve[2*i].y);
                       temp_bitmap.Canvas.LineTo(curve[2*i+1].x, curve[2*i+1].y);
                       SetTextColor(temp_bitmap.Canvas.Handle, RGB(55, 255, 55));
                       temp_bitmap.Canvas.TextOut(round((curve[2*i+1].x+curve[2*i].x)/2), round((curve[2*i+1].y+curve[2*i].y)/2), IntToStr(i+1));
                     end;
                     for i:=0 to length(curve)-1 do
                       temp_bitmap.Canvas.Rectangle(Curve[i].X-3,Curve[i].Y-3,Curve[i].X+4,Curve[i].Y+4);
                     if outline >= 0 then
                       DrawText(curve[outline].X,curve[outline].y);
                     if FirstClick then
                       DrawText(temp_point.x,temp_point.y);
                   end
                   else
                     DrawText(temp_point.x,temp_point.y);
     dmSimpleSlice: if not FirstClick then
                    begin
                      temp_bitmap.Canvas.MoveTo(Origin.x, Origin.y);
                      temp_bitmap.Canvas.LineTo(Point2.x, Point2.y);
                      temp_bitmap.Canvas.Ellipse(Origin.x-2, Origin.y-2, Origin.x+3, Origin.y+3);
                      temp_bitmap.Canvas.Ellipse(Point2.x-3, Point2.y-3, Point2.x+3, Point2.y+3);
                      DrawText(Origin.x,Origin.y,-1);
                      DrawText(Point2.x,Point2.y);
                    end
                    else
                      DrawText(temp_point.x,temp_point.y);
     dmPoint: if length(curve) > 0 then
              begin
                for i:=0 to length(curve)-1 do
                begin
                  temp_bitmap.Canvas.Rectangle(Curve[i].X-3,Curve[i].Y-3,Curve[i].X+4,Curve[i].Y+4);
                  SetTextColor(temp_bitmap.Canvas.Handle, RGB(55, 255, 55));
                  temp_bitmap.Canvas.TextOut(Curve[i].X-5, Curve[i].Y-15, IntToStr(i+1));
                end;
                if outline >= 0 then
                    DrawText(curve[outline].X,curve[outline].y);
                if CurveMode = cvDrawMode then
                   DrawText(temp_point.x,temp_point.y);

              end
              else
                DrawText(temp_point.x,temp_point.y);
     dmStatic: begin
                 temp_bitmap.Canvas.Pen.Mode:=pmCopy;
                 k:=0;
                 for i:=0 to length(Static)-1 do
                   case Static[i] of
                     soPoint: begin
                                temp_bitmap.Canvas.Pen.Color:=ColorObj[i];
                                temp_bitmap.Canvas.Ellipse(curve[k].x-3, curve[k].y-3, curve[k].x+4, curve[k].y+4);
                                inc(k);
                              end;
                     soLine: begin
                               temp_bitmap.Canvas.Pen.Color:=ColorObj[i];
                               temp_bitmap.Canvas.MoveTo(curve[k].x, curve[k].y);
                               inc(k);
                               temp_bitmap.Canvas.LineTo(curve[k].x, curve[k].y);
                               inc(k);
                             end;
                     soCircle: begin
                                 temp_bitmap.Canvas.Pen.Color:=ColorObj[i];
                                 temp_bitmap.Canvas.Ellipse(round((curve[k].x-sax)/scl+sx), round((curve[k].y-say)/scl+sy), round((curve[k+1].x-sax)/scl+sx), round((curve[k+1].y-say)/scl+sy));
                                 inc(k); inc(k);
                               end;
                     soRect: begin
                               temp_bitmap.Canvas.Pen.Color:=ColorObj[i];
                               temp_bitmap.Canvas.Rectangle(curve[k].x, curve[k].y, curve[k+1].x, curve[k+1].y);
                               inc(k); inc(k);
                             end;
                     soCross: begin
                                temp_bitmap.Canvas.Pen.Color:=ColorObj[i];
                                temp_bitmap.Canvas.MoveTo(round(((curve[k].x-curve[k+1].x)-sax)/scl+sx), round((curve[k].y-say)/scl+sy));
                                temp_bitmap.Canvas.LineTo(round(((curve[k].x+curve[k+1].x)-sax)/scl+sx), round((curve[k].y-say)/scl+sy));
                                temp_bitmap.Canvas.MoveTo(round((curve[k].x-sax)/scl+sx), round(((curve[k].y-curve[k+1].y)-say)/scl+sy));
                                temp_bitmap.Canvas.LineTo(round((curve[k].x-sax)/scl+sx), round(((curve[k].y+curve[k+1].y)-say)/scl+sy));
                                inc(k); inc(k);
                              end;
                   end;
               end;
     dmSimpleCircle: begin
                       temp_bitmap.Canvas.MoveTo(Origin.x-10, Origin.y);
                       temp_bitmap.Canvas.LineTo(Origin.x+10, Origin.y);
                       temp_bitmap.Canvas.MoveTo(Origin.x, Origin.y-10);
                       temp_bitmap.Canvas.LineTo(Origin.x, Origin.y+10);
                       temp_bitmap.Canvas.MoveTo(Origin.x, Origin.y);
                       temp_bitmap.Canvas.LineTo(Point2.x, Point2.y);
                       k:=round(sqrt(sqr(Origin.x-Point2.x)+sqr(Origin.y-Point2.y)));
                       for i:=0 to 9 do
                       // temp_bitmap.Canvas.Ellipse(Origin.x-round(k*(i+1)/10), Origin.y-round(k*(i+1)/10), Origin.x+round(k*(i+1)/10), Origin.y+round(k*(i+1)/10));
                       temp_bitmap.Canvas.Ellipse(Origin.x-round(k*(1+i/9)/2), Origin.y-round(k*(1+i/9)/2), Origin.x+round(k*(1+i/9)/2), Origin.y+round(k*(1+i/9)/2));
                     end;
     dmStaticCircles: begin
                       temp_bitmap.Canvas.Pen.Mode:=pmCopy;
                       temp_bitmap.Canvas.Pen.Width:=2;
                       case ExpoMode of
                         em1: begin
                                u:=lc1;
                                tclr:=clRed;
                              end;
                         em2: begin
                                u:=lc2;
                                tclr:=clBlue;
                              end;
                       end;
                       temp_bitmap.Canvas.Pen.Color:=tclr;
                       for i:=0 to length(u)-1 do
                       begin
                         x1:=round(u[i].x-u[i].r);
                         y1:=round(u[i].y-u[i].r);
                         x2:=round(u[i].x+u[i].r);
                         y2:=round(u[i].y+u[i].r);
                         temp_bitmap.Canvas.Ellipse(round((x1-sax)/scl+sx),  round((y1-say)/scl+sy), round((x2-sax)/scl+sx),  round((y2-say)/scl+sy));
                       end;
                       temp_bitmap.Canvas.Pen.Width:=1;
                       case CurveMode of
                         cvDrawMode: begin
                                       temp_bitmap.Canvas.Pen.Color:=tclr;
                                       temp_bitmap.Canvas.MoveTo(round((Origin.x-sax)/scl+sx)-10, round((origin.y-say)/scl+sy));
                                       temp_bitmap.Canvas.LineTo(round((origin.x-sax)/scl+sx)+11, round((origin.y-say)/scl+sy));
                                       temp_bitmap.Canvas.MoveTo(round((origin.x-sax)/scl+sx), round((origin.y-say)/scl+sy)-10);
                                       temp_bitmap.Canvas.LineTo(round((origin.x-sax)/scl+sx), round((origin.y-say)/scl+sy)+11);

                                       if (length(curve) > 2) then
                                       begin
                                         Find_Circle;
//                                         temp_bitmap.Canvas.Pen.Color:=clRed;
                                         temp_bitmap.Canvas.Ellipse(round((circ_x-sax)/scl+sx-circ_r/scl), round((circ_y-say)/scl+sy-circ_r/scl), round((circ_x-sax)/scl+sx+circ_r/scl), round((circ_y-say)/scl+sy+circ_r/scl));
                                         temp_bitmap.Canvas.MoveTo(round((circ_x-sax)/scl+sx)-20, round((circ_y-say)/scl+sy));
                                         temp_bitmap.Canvas.LineTo(round((circ_x-sax)/scl+sx)+21, round((circ_y-say)/scl+sy));
                                         temp_bitmap.Canvas.MoveTo(round((circ_x-sax)/scl+sx), round((circ_y-say)/scl+sy)-20);
                                         temp_bitmap.Canvas.LineTo(round((circ_x-sax)/scl+sx), round((circ_y-say)/scl+sy)+21);
                                       end;
                                       temp_bitmap.Canvas.Pen.Color:=clBlack;
                                       temp_bitmap.Canvas.Brush.Color:=tclr;
                                       for i:=0 to length(curve)-1 do
                                         temp_bitmap.Canvas.Rectangle(round((Curve[i].X-sax)/scl+sx)-3,round((Curve[i].Y-say)/scl+sy)-3,round((Curve[i].X-sax)/scl+sx)+4,round((Curve[i].Y-say)/scl+sy)+4);
                                       if outline >= 0 then
                                       begin
                                         temp_bitmap.Canvas.Brush.Color:=clYellow;
                                         temp_bitmap.Canvas.Rectangle(round((Curve[outline].X-sax)/scl+sx)-3,round((Curve[outline].Y-say)/scl+sy)-3,round((Curve[outline].X-sax)/scl+sx)+4,round((Curve[outline].Y-say)/scl+sy)+4);
                                       end;
                                     end;
                         cvDeleteMode: begin
                                         temp_bitmap.Canvas.Pen.Width:=2;
                                         if Curr_checked >= 0 then
                                         begin
                                           temp_bitmap.Canvas.Pen.Color:=clWhite;
                                           x1:=round(u[Curr_checked].x-u[Curr_checked].r);
                                           y1:=round(u[Curr_checked].y-u[Curr_checked].r);
                                           x2:=round(u[Curr_checked].x+u[Curr_checked].r);
                                           y2:=round(u[Curr_checked].y+u[Curr_checked].r);
                                           temp_bitmap.Canvas.Ellipse(round((x1-sax)/scl+sx),  round((y1-say)/scl+sy), round((x2-sax)/scl+sx),  round((y2-say)/scl+sy));
                                         end;


                                         for i:=0 to length(CheckListCircles) - 1 do
                                         begin
                                           temp_bitmap.Canvas.Pen.Width:=1;
                                           temp_bitmap.Canvas.Pen.Color:=clWhite;
//                                           temp_bitmap.Canvas.Pen.Color:=clYellow;
                                           temp_bitmap.Canvas.Pen.Style:=psDash;
                                           x1:=round(u[CheckListCircles[i]].x-u[CheckListCircles[i]].r);
                                           y1:=round(u[CheckListCircles[i]].y-u[CheckListCircles[i]].r);
                                           x2:=round(u[CheckListCircles[i]].x+u[CheckListCircles[i]].r);
                                           y2:=round(u[CheckListCircles[i]].y+u[CheckListCircles[i]].r);
                                           temp_bitmap.Canvas.Ellipse(round((x1-sax)/scl+sx),  round((y1-say)/scl+sy), round((x2-sax)/scl+sx),  round((y2-say)/scl+sy));
                                           temp_bitmap.Canvas.Pen.Style:=psSolid;
                                         end;

                                       end;
                       end;
                      end;
     dmNewSlice: begin
                   if (length(curve) <> 0) then
                   begin
                     temp_bitmap.Canvas.Pen.Mode:=pmCopy;
                     temp_bitmap.Canvas.Pen.Color:=clRed;
                     SetBkMode(temp_bitmap.Canvas.Handle, TRANSPARENT);
                     SetTextColor(temp_bitmap.Canvas.Handle, clYellow {clWebGold});
                     k:=Length(curve) div 2;

                     for i:=0 to k-1 do
                     begin
                       temp_bitmap.Canvas.MoveTo(round((curve[2*i].x-sax)/scl)+sx,round((curve[2*i].y-say)/scl)+sy);
                       temp_bitmap.Canvas.LineTo(round((curve[2*i+1].x-sax)/scl)+sx, round((curve[2*i+1].y-say)/scl)+sy);
                       temp_bitmap.Canvas.TextOut(round((curve[2*i].x-sax)/scl)+sx-2,round((curve[2*i].y-say)/scl)+sy-15, IntToStr(i+1));
                       temp_bitmap.Canvas.TextOut(round((curve[2*i+1].x-sax)/scl)+sx-2,round((curve[2*i+1].y-say)/scl)+sy-15, IntToStr(i+1));
                     end;

                     k:=Length(curve);
                     if odd(k) then
                     begin
                       temp_bitmap.Canvas.MoveTo(round((curve[k-1].x-sax)/scl)+sx,round((curve[k-1].y-say)/scl)+sy);
                       temp_bitmap.Canvas.LineTo(round((temp_point.x-sax)/scl)+sx, round((temp_point.y-say)/scl)+sy);
                     end;

                     temp_bitmap.Canvas.Pen.Color:=clBlack;
                     temp_bitmap.Canvas.Brush.Color:=clRed;

                      for i:=0 to length(curve)-1 do
                        temp_bitmap.Canvas.Rectangle(round((Curve[i].x-sax)/scl)-3+sx,round((Curve[i].y-say)/scl)-3+sy,round((Curve[i].x-sax)/scl)+4+sx,round((Curve[i].y-say)/scl)+4+sy);

                      if outline >= 0 then
                      begin
                        temp_bitmap.Canvas.Pen.Color:=clBlack;
                        temp_bitmap.Canvas.Brush.Color:=clYellow;
                        temp_bitmap.Canvas.Rectangle(round((Curve[outline].x-sax)/scl)-3+sx,round((Curve[outline].y-say)/scl)-3+sy,round((Curve[outline].x-sax)/scl)+4+sx,round((Curve[outline].y-say)/scl)+4+sy);
                      end;


                   end;
                 end;
     dmNewRects: begin
                   if (length(curve) <> 0) then
                   begin
                     temp_bitmap.Canvas.Pen.Mode:=pmCopy;
                     temp_bitmap.Canvas.Pen.Color:=clRed;
                     SetBkMode(temp_bitmap.Canvas.Handle, TRANSPARENT);
                     SetTextColor(temp_bitmap.Canvas.Handle, clYellow {clWebGold});

                     k:=Length(curve) div 2;
                     for i:=0 to k-1 do
                     begin
                       temp_bitmap.Canvas.Rectangle(round((curve[2*i].x-sax)/scl)+sx, round((curve[2*i].y-say)/scl)+sy, round((curve[2*i+1].x-sax)/scl)+sx, round((curve[2*i+1].y-say)/scl)+sy);
                       temp_bitmap.Canvas.TextOut(round((curve[2*i].x-sax)/scl)+sx-2,round((curve[2*i].y-say)/scl)+sy-15, IntToStr(i+1));
                       temp_bitmap.Canvas.TextOut(round((curve[2*i+1].x-sax)/scl)+sx-2,round((curve[2*i+1].y-say)/scl)+sy-15, IntToStr(i+1));
                     end;

                     k:=Length(curve);
                     if odd(k) then
                       temp_bitmap.Canvas.Rectangle(round((curve[k-1].x-sax)/scl)+sx, round((curve[k-1].y-say)/scl)+sy, round((temp_point.x-sax)/scl)+sx, round((temp_point.y-say)/scl)+sy);

                     temp_bitmap.Canvas.Pen.Color:=clBlack;
                     temp_bitmap.Canvas.Brush.Color:=clRed;

                     for i:=0 to length(curve)-1 do
                       temp_bitmap.Canvas.Rectangle(round((Curve[i].x-sax)/scl)-3+sx,round((Curve[i].y-say)/scl)-3+sy,round((Curve[i].x-sax)/scl)+4+sx,round((Curve[i].y-say)/scl)+4+sy);

                     if outline >= 0 then
                     begin
                       temp_bitmap.Canvas.Pen.Color:=clBlack;
                       temp_bitmap.Canvas.Brush.Color:=clYellow;
                       temp_bitmap.Canvas.Rectangle(round((Curve[outline].x-sax)/scl)-3+sx,round((Curve[outline].y-say)/scl)-3+sy,round((Curve[outline].x-sax)/scl)+4+sx,round((Curve[outline].y-say)/scl)+4+sy);
                     end;
                   end;
                 end;
     dmNewPoints: begin
                    if (length(curve) <> 0) then
                    begin
                      temp_bitmap.Canvas.Pen.Mode:=pmCopy;

                      SetTextColor(temp_bitmap.Canvas.Handle, clYellow);

                      temp_bitmap.Canvas.Pen.Color:=clBlack;
                      temp_bitmap.Canvas.Brush.Color:=clRed;

                      SetBkMode(temp_bitmap.Canvas.Handle, TRANSPARENT);
                      for i:=0 to length(curve)-1 do
                      begin
                        temp_bitmap.Canvas.Rectangle(round((Curve[i].x-sax)/scl)-3+sx,round((Curve[i].y-say)/scl)-3+sy,round((Curve[i].x-sax)/scl)+4+sx,round((Curve[i].y-say)/scl)+4+sy);
                        temp_bitmap.Canvas.TextOut(round((curve[i].x-sax)/scl)+sx-2,round((curve[i].y-say)/scl)+sy-15, IntToStr(i+1));
                      end;

                      if outline >= 0 then
                      begin
                        temp_bitmap.Canvas.Brush.Color:=clYellow;
                        temp_bitmap.Canvas.Rectangle(round((Curve[outline].x-sax)/scl)-3+sx,round((Curve[outline].y-say)/scl)-3+sy,round((Curve[outline].x-sax)/scl)+4+sx,round((Curve[outline].y-say)/scl)+4+sy);
                      end;
                    end;
                  end;
     dmCrossAndCircle: begin
                         if (length(curve) <> 0) then
                         begin
                           temp_bitmap.Canvas.Pen.Mode:=pmCopy;
                           temp_bitmap.Canvas.Pen.Width:=2;
                           temp_bitmap.Canvas.Pen.Color:=clRed;
                           temp_bitmap.Canvas.MoveTo(round((curve[0].x-sax)/scl)+sx-20,round((curve[0].Y-say)/scl)+sy);
                           temp_bitmap.Canvas.LineTo(round((curve[0].x-sax)/scl)+sx+19,round((curve[0].Y-say)/scl)+sy);
                           temp_bitmap.Canvas.MoveTo(round((curve[0].x-sax)/scl)+sx,round((curve[0].Y-say)/scl)+sy-20);
                           temp_bitmap.Canvas.LineTo(round((curve[0].x-sax)/scl)+sx,round((curve[0].Y-say)/scl)+sy+19);
                           t:=Hypot(curve[0].x-curve[1].x, curve[0].y-curve[1].y);
                           temp_bitmap.Canvas.Ellipse(round((curve[0].X-t-sax)/scl)+sx, round((curve[0].Y-t-say)/scl)+sy, round((curve[0].X+t-sax)/scl)+sx, round((curve[0].Y+t-say)/scl)+sy);
                           temp_bitmap.Canvas.Pen.Color:=clBlack;
                           temp_bitmap.Canvas.Brush.Color:=clRed;
                           temp_bitmap.Canvas.Pen.Width:=1;
                           for i:=0 to length(curve)-1 do
                             temp_bitmap.Canvas.Rectangle(round((Curve[i].x-sax)/scl)-3+sx,round((Curve[i].y-say)/scl)-3+sy,round((Curve[i].x-sax)/scl)+4+sx,round((Curve[i].y-say)/scl)+4+sy);


                         end;
                       end;
     dmSimpleRect: if not FirstClick then
                   begin
                     temp_bitmap.Canvas.Pen.Mode:=pmCopy;
                     temp_bitmap.Canvas.Pen.Color:=clRed;
                     temp_bitmap.Canvas.Rectangle(round((Point1.x-sax)/scl+sx), round((Point1.y-say)/scl+sy), round((Point2.x-sax)/scl+sx), round((Point2.y-say)/scl+sy));
//                     DrawText(round((Point2.x-sax)/scl+sx),round((Point2.y-say)/scl+sy));
                   end;
//                   else
//                     DrawText(round((temp_point.x-sax)/scl+sx),round((temp_point.y-say)/scl+sy));
     dmTraceLines: if (CurveMode = cvWait) and (varCountLines = 0) then
                    // DrawText(round((temp_point.x-sax)/scl)+sx,round((temp_point.y-say)/scl)+sy)
                   else
                   begin
                     temp_bitmap.Canvas.Pen.Mode:=pmCopy;
                     temp_bitmap.Canvas.Pen.Color:=clRed;
                     for i:=0 to (Length(curve) div 2)-1 do
                     begin
                     //round((curve[0].x-sax)/scl)+sx,round((curve[0].Y-say)/scl)+sy
                       temp_bitmap.Canvas.MoveTo(round((curve[2*i].x-sax)/scl)+sx, round((curve[2*i].y-say)/scl)+sy);
                       temp_bitmap.Canvas.LineTo(round((curve[2*i+1].x-sax)/scl)+sx, round((curve[2*i+1].y-say)/scl)+sy);
                       {SetTextColor(temp_bitmap.Canvas.Handle, clRed);
                       temp_bitmap.Canvas.TextOut(round((curve[2*i].x-sax)/scl)+sx, round((curve[2*i].y-say)/scl)+sy, IntToStr(i+1));
                       temp_bitmap.Canvas.TextOut(round((curve[2*i+1].x-sax)/scl)+sx, round((curve[2*i+1].y-say)/scl)+sy, IntToStr(i+1));}
                     end;
                     temp_bitmap.Canvas.Pen.Color:=clBlack;
                     temp_bitmap.Canvas.Brush.Color:=clRed;
                     for i:=0 to length(curve)-1 do
                     begin
                       temp_bitmap.Canvas.Rectangle(round((Curve[i].X-sax)/scl+sx)-3,round((Curve[i].Y-say)/scl+sy)-3,round((Curve[i].X-sax)/scl+sx)+4,round((Curve[i].Y-say)/scl+sy)+4);
                       {temp_bitmap.Canvas.MoveTo(round((curve[i].x-sax)/scl)+sx-2, round((curve[i].y-say)/scl)+sy);
                       temp_bitmap.Canvas.LineTo(round((curve[i].x-sax)/scl)+sx+3, round((curve[i].y-say)/scl)+sy);
                       temp_bitmap.Canvas.MoveTo(round((curve[i].x-sax)/scl)+sx, round((curve[i].y-say)/scl)+sy-2);
                       temp_bitmap.Canvas.LineTo(round((curve[i].x-sax)/scl)+sx, round((curve[i].y-say)/scl)+sy+3);}
                       //temp_bitmap.Canvas.Rectangle(Curve[i].X-3,Curve[i].Y-3,Curve[i].X+4,Curve[i].Y+4);
                     end;
                     t:=Hypot(curve[1].x-curve[0].x, curve[1].y-curve[0].y);
                     temp_bitmap.Canvas.TextOut(round((curve[outline].x-sax)/scl+sx)+5, round((curve[outline].y-say)/scl+sy)-15, FloatToStrF(t*scale_x, ffFixed, 5, 3));

                     {case CurveMode of
                       cvWait: DrawText(round((temp_point.x-sax)/scl)+sx,round((temp_point.y-say)/scl)+sy);
                       cvDrawMode: DrawText(round((curve[outline].x-sax)/scl)+sx,round((curve[outline].y-say)/scl)+sy);
                       cvEditMode:  if outline >= 0 then
                                      DrawText(round((curve[outline].x-sax)/scl)+sx,round((curve[outline].y-say)/scl)+sy);
                     end;}
                   end;
     dmNewSpline: begin
                    with temp_bitmap.Canvas do
                    begin
                      Pen.Mode:=pmCopy;
                      Pen.Color:=clRed;
                      if length(curve) = 2 then
                      begin
                        //grap.DrawLine(_pen, tgppoint(curve[0]), tgppoint(curve[1]));
                        MoveTo(round((curve[0].x-sax)/scl+sx), round((curve[0].y-say)/scl+sy));
                        LineTo(round((curve[1].x-sax)/scl+sx), round((curve[1].y-say)/scl+sy));
                      end;
                      if length(curve) > 2 then
                      begin
                       { MoveTo(curve[0].x, curve[0].y);
                        for i:=0 to length(curve)-1 do
                          LineTo(curve[i].x, curve[i].y);}
                        grap:=TGPGraphics.Create(temp_bitmap.Canvas.Handle);
                        _pen:=TGPPen.Create(MakeColor(255, 255, 0, 0));
                        finalize(tempCurve);
                        SetLength(tempCurve, length(curve));
                        for i:=0 to length(curve)-1 do
                        begin
                          tempCurve[i].x:=round((curve[i].x-sax)/scl+sx);
                          tempCurve[i].y:=round((curve[i].y-say)/scl+sy);
                        end;

                        grap.DrawClosedCurve(_pen, PGPPoint(@(tempCurve[0])), length(curve), 0.5);
                        if CurveMode = cveditmode then
                        begin
                          {_pen.Free;
                          _pen:=TGPPen.Create(MakeColor(255, 255, 255, 0));}
                          _brush:=TGPSolidBrush.Create(MakeColor(255, 0,0,255));
                          for i:=0 to length(tempCurve)-1 do
                          begin
                            tempCurve[i].x:=tempCurve[i].x-5;
                            tempCurve[i].y:=tempCurve[i].y-5;
                            grap.FillRectangle(_brush, MakeRect(TGPPoint(tempCurve[i]), MakeSize(10, 10)));
                            grap.DrawRectangle(_pen, MakeRect(TGPPoint(tempCurve[i]), MakeSize(10, 10)));
                          end;
                          _brush.Free;

                          if outline >= 0 then
                          begin
                            {_pen.Free;
                            _pen:=TGPPen.Create(MakeColor(255, 0, 255, 0));}

                            _brush:=TGPSolidBrush.Create(MakeColor(255, 255,255,0));

                            grap.FillRectangle(_brush, MakeRect(TGPPoint(tempCurve[outline]), MakeSize(10, 10)));
                            grap.DrawRectangle(_pen, MakeRect(TGPPoint(tempCurve[outline]), MakeSize(10, 10)));
                            _brush.Free;
                          end;


                        end;
                        finalize(tempCurve);
                        _pen.Free;
//                        _brush.Free;
                        grap.Free;






                      end;
                    end;




                  end;
    dmNPO_cell: begin
                  {if (length(curve) <> 0) then
                         begin
                           temp_bitmap.Canvas.Pen.Mode:=pmCopy;
                           temp_bitmap.Canvas.Pen.Width:=2;
                           temp_bitmap.Canvas.Pen.Color:=clRed;
                           temp_bitmap.Canvas.MoveTo(round((curve[0].x-sax)/scl)+sx-20,round((curve[0].Y-say)/scl)+sy);
                           temp_bitmap.Canvas.LineTo(round((curve[0].x-sax)/scl)+sx+19,round((curve[0].Y-say)/scl)+sy);
                           temp_bitmap.Canvas.MoveTo(round((curve[0].x-sax)/scl)+sx,round((curve[0].Y-say)/scl)+sy-20);
                           temp_bitmap.Canvas.LineTo(round((curve[0].x-sax)/scl)+sx,round((curve[0].Y-say)/scl)+sy+19);
                           t:=Hypot(curve[0].x-curve[1].x, curve[0].y-curve[1].y);
                           temp_bitmap.Canvas.Ellipse(round((curve[0].X-t-sax)/scl)+sx, round((curve[0].Y-t-say)/scl)+sy, round((curve[0].X+t-sax)/scl)+sx, round((curve[0].Y+t-say)/scl)+sy);
                           temp_bitmap.Canvas.Pen.Color:=clBlack;
                           temp_bitmap.Canvas.Brush.Color:=clRed;
                           temp_bitmap.Canvas.Pen.Width:=1;
                           for i:=0 to length(curve)-1 do
                             temp_bitmap.Canvas.Rectangle(round((Curve[i].x-sax)/scl)-3+sx,round((Curve[i].y-say)/scl)-3+sy,round((Curve[i].x-sax)/scl)+4+sx,round((Curve[i].y-say)/scl)+4+sy);


                         end;}
                  if (length(curve) <> 0) then
                  begin
                    temp_bitmap.Canvas.Pen.Mode:=pmCopy;
                    temp_bitmap.Canvas.Pen.Width:=2;
                    temp_bitmap.Canvas.Pen.Color:=clRed;
                    temp_bitmap.Canvas.Ellipse(round((curve[0].x-curve[1].x-sax)/scl)+sx, round((curve[0].y-curve[1].x-say)/scl)+sy, round((curve[0].x+curve[1].x-sax)/scl)+sx+1, round((curve[0].y+curve[1].x-say)/scl)+sy+1);
                    temp_bitmap.Canvas.MoveTo(round((curve[0].x-curve[1].x-sax)/scl)+sx,round((curve[0].Y-say)/scl)+sy);
                    temp_bitmap.Canvas.LineTo(round((curve[0].x+curve[1].x-sax)/scl)+sx,round((curve[0].Y-say)/scl)+sy);
                    temp_bitmap.Canvas.MoveTo(round((curve[0].x-sax)/scl)+sx,round((curve[0].Y-curve[1].x-say)/scl)+sy);
                    temp_bitmap.Canvas.LineTo(round((curve[0].x-sax)/scl)+sx,round((curve[0].Y+curve[1].x-say)/scl)+sy);

                    temp_bitmap.Canvas.Pen.Color:=clBlack;

                    temp_bitmap.Canvas.Pen.Width:=1;
                    for i:=2 to length(curve)-1 do
                    begin
                      t:=Hypot(curve[0].x-curve[i].x, curve[0].y-curve[i].y);
                      if t < curve[1].x then
                        temp_bitmap.Canvas.Brush.Color:=clLime
                      else
                        temp_bitmap.Canvas.Brush.Color:=clRed;

                      temp_bitmap.Canvas.Ellipse(round((curve[i].x-sax)/scl)+sx-4, round((curve[i].y-say)/scl)+sy-4, round((curve[i].x-sax)/scl)+sx+4, round((curve[i].y-say)/scl)+sy+4);
                    end;

                  end;
                end;
  end;
  Canvas.Draw(0,0, temp_bitmap);


 // Canvas.StretchDraw(Rect(0,0,w_pict,h_pict), temp_bitmap);
//  StretchBlt(Canvas.Handle, 0, 0, w_pict, h_pict, temp_bitmap.Canvas.Handle, 0, 0, temp_bitmap.Width, temp_bitmap.Height,  SRCCOPY);
  {if Width > temp_bitmap.Width then
    BitBlt(Canvas.Handle,round((Width-temp_bitmap.Width)/2),0, temp_bitmap.Width, temp_bitmap.Height, temp_bitmap.Canvas.Handle, 0, 0, SRCCOPY)
  else
    BitBlt(Canvas.Handle, 0, round((Height-temp_bitmap.Height)/2), temp_bitmap.Width, temp_bitmap.Height, temp_bitmap.Canvas.Handle, 0, 0, SRCCOPY);}
  //Canvas.TextOut(0,0,FloatToStr(scl));
  EndPaint(temp_bitmap.Canvas.Handle, MyPaint);
end;

procedure tpanel1.ReSize;
{var t: treal;
    tmp: TBitmap;}
begin
  if (DrawMode = dmOpenGL) or (DrawMode = dmOpenGL_STL) then
  begin
    {if OpenGL_w/OpenGL_h >= Width/Height then
    begin
      w_pict:=Width;
      h_pict:=round(Width*OpenGL_h/OpenGL_w);
    end
    else
    begin
      h_pict:=Height;
      w_pict:=round(Height*OpenGL_w/OpenGL_h);
    end;
    sx:=round((Width-w_pict)/2);
    sy:=round((Height-h_pict)/2);
     }

    SetPort;
   // Paint;
  end;
//  tmp:=TBitmap.Create;
  {if  w_img > 0 then
  begin
    t:=w_pict/h_pict; //temp_bitmap.Width/temp_bitmap.Height;
    if t >= Width/Height then
    begin
        w_pict:=Width;
        h_pict:=round(Width/t);
   //   temp_bitmap.Width:=Width;
   //   temp_bitmap.Height:=round(Width/t);

    end
    else
    begin
       h_pict:=Height;
       w_pict:=round(Height*t);
     // scl:=bitmap.Height/Height;
//      temp_bitmap.Height:=Height;
  //    temp_bitmap.Width:=round(Height*t);
    end;
    if Width > w_pict then
    begin
      sx:=round((Width-w_pict)/2);
      sy:=0;
    end
    else
    begin
      sx:=0;
      sy:=round((Height-h_pict)/2);
    end;
    scl:=(w_img/w_pict+h_img/h_pict)/2;   }

   { temp_bitmap.Width:=Width;
    temp_bitmap.Height:=Height;
    tmp.Width:=bitmap.Width;
    tmp.Height:=bitmap.Height;
    tmp.Canvas.Draw(0,0,bitmap);
    bitmap.Width:=w_pict;
    bitmap.Height:=h_pict;
    bitmap.Canvas.StretchDraw(bitmap.Canvas.ClipRect, tmp);
    tmp.Destroy;}
    //ReSizeInterpImage;
//  end;
  inherited ReSize;
end;

procedure tpanel1.ChangePaletteMode(value: TPaletteMode);
begin
  FPaletteMode:=value;
  case value of
    ColorPalette: bitmap.Palette:=CreateColorPalette;
    GreyPalette: bitmap.Palette:=CreateGreyPalette;
    GreyPaletteWithThreshold: bitmap.Palette:=CreateGreyPaletteWithThreshold;
  end;
 // Paint;
end;

function tpanel1.CreateGreyPalette: HPALETTE;
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

function tpanel1.CreateColorPalette: HPALETTE;
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

procedure tpanel1.FindNearPoint(x, y: integer);
var i: word;
begin
  outline:=-1;
  if length(curve) = 0 then
    exit;
  for i:=0 to length(curve)-1 do
   if (x>=curve[i].x-5) and (x<=curve[i].x+5) and (y>=curve[i].y-5) and (y<=curve[i].y+5) then
   begin
     outline:=i;
     if outline = 0 then
       if (curve[0].x = curve[1].x)  and (curve[0].y = curve[1].y) then
         outline:=1;
     exit;
   end;
   outline:=-1;
end;

procedure tpanel1.Find_Circle;
var
    arr: TDoubleArray;
    i,j: integer;
    t: TReal;
begin
  SetLength(arr,3,4);
    for i:=0 to Length(Curve)-1 do
      begin
        t:=sqr(curve[i].x)+sqr(curve[i].y);
        arr[0,0]:=arr[0,0]+sqr(curve[i].x);
        arr[0,1]:=arr[0,1]+curve[i].x*curve[i].y;
        arr[0,2]:=arr[0,2]-curve[i].x;
        arr[0,3]:=arr[0,3]+curve[i].x*t;
        arr[1,1]:=arr[1,1]+sqr(curve[i].y);
        arr[1,2]:=arr[1,2]-curve[i].y;
        arr[1,3]:=arr[1,3]+curve[i].y*t;
        arr[2,2]:=arr[2,2]-1;
        arr[2,3]:=arr[2,3]+t;
      end;
  arr[1,0]:=arr[0,1];
  arr[2,0]:=-arr[0,2];
  arr[2,1]:=-arr[1,2];
  GaussSolve(arr);
  circ_x:=arr[0,3]/2;
  circ_y:=arr[1,3]/2;
  circ_r:=sqrt(sqr(circ_x)+sqr(circ_y)-arr[2,3]);
  Finalize(arr);
end;

procedure tpanel1.ChangeDrawMode(value: TDrawMode);
begin
  case FDrawMode of
    dmNone:
       case value of
          dmSpline, dmRect, dmLine, dmCirc, dmSpline2, dmLargeCross, dmCross,
          dmSingleLine, dmSimpleSlice, dmPoint, dmStatic, dmSimpleCircle, dmCircle2,
          dmTemp, dmSimpleRect, dmNewSpline, dmNull, dmOpenGL, dmOpenGL_STL, dmSprite, dmLine2,
          dmStaticCircles, dmNewSlice, dmNewRects, dmNewPoints, dmCrossAndCircle, dmNPO_cell:
            begin
              FDrawMode:=value;
//              outline:=0;
              CurveMode:=cvDrawMode;
              FFinalized:=false;
            end;
          dmTraceLines: begin
                          FDrawMode:=value;
                          CurveMode:=cvWait;
                          varCountLines:=0;
                          LineIndex:=0;
                          Finalized:=false;
                        end;
          dmLine3: begin
                     FDrawMode:=value;
                     Finalize(curve);
                     outline:=-1;
                     CurveMode:=cvDrawMode;
                     FirstClick:=true;
                   end;
       end;
    dmSpline, dmRect, dmLine, dmCirc, dmLine2:
      begin
        case value of
         dmCross:  begin
                     LastCurve:=FDrawMode;
                     FDrawMode:=value;
                   end;
          dmNone: begin
                    FDrawMode:=value;
                    //Finalize(Curve);
                  end;
        end;
      end;
    dmCross, dmLargeCross, dmSingleLine, dmSimpleSlice, dmPoint, dmStatic,
    dmSimpleCircle, dmTemp, dmSimpleRect, dmNewSpline, dmNull, dmSprite, dmLine3,
    dmStaticCircles, dmNewSlice, dmNewRects, dmNewPoints, dmCrossAndCircle,
    dmNPO_cell: begin
               if value = dmNone then
               begin
                 LastCurve:=FDrawMode;
                 FDrawMode:=value;
                 {GenerateMask;
                 Finalize(Curve);}
               end;
             end;
    dmOpenGL:
              if value = dmNone then
              begin
                LastCurve:=FDrawMode;
                FDrawMode:=value;
                ReleaseOpenGL;
              end;
    dmOpenGL_STL:  if value = dmNone then
                   begin
                     LastCurve:=FDrawMode;
                     FDrawMode:=value;
                     ReleaseOpenGL;
                     FreeMem(facet, nFacets*sizeOf(Tfacet));
                     facet:=nil;
                   end;
    dmTraceLines:  if value = dmNone then
                   begin
                     FDrawMode:=value;
                     Finalize(Curve);
                   end;

    {dmSingleLine: begin
                    if value = dmNone then
                      FDrawMode:=value;
                  end;
     }
  end;
end;

procedure tpanel1.DrawCross;
begin
  SetTextColor(temp_bitmap.Canvas.Handle, clRed);
  temp_bitmap.Canvas.TextOut(round((origin.x-sax)/scl)+10+sx,round((Origin.y-say)/scl)-30+sy, 'x = '+IntToStr(Origin.X));
  temp_bitmap.Canvas.TextOut(round((origin.x-sax)/scl)+10+sx,round((Origin.y-say)/scl)-20+sy, 'y = '+IntToStr(Origin.Y));
 // Canvas.Pen.Mode:=pmCopy;
  temp_bitmap.Canvas.Pen.Width:=3;
 // Canvas.Pen.Color:=$000080FF;
  temp_bitmap.Canvas.MoveTo(round((origin.x-sax)/scl)-15+sx,round((Origin.y-say)/scl)+sy);
  temp_bitmap.Canvas.LineTo(round((origin.x-sax)/scl)+14+sx,round((Origin.y-say)/scl)+sy);
  temp_bitmap.Canvas.MoveTo(round((origin.x-sax)/scl)+sx,round((Origin.y-say)/scl)-15+sy);
  temp_bitmap.Canvas.LineTo(round((origin.x-sax)/scl)+sx,round((Origin.y-say)/scl)+14+sy);
  temp_bitmap.Canvas.Pen.Width:=1;
end;

procedure tpanel1.DrawText(x, y: integer; m: integer = 1);
begin
  SetTextColor(temp_bitmap.Canvas.Handle, RGB(255, 55, 55));
  SetBkMode(temp_bitmap.Canvas.Handle, TRANSPARENT);
  temp_bitmap.Canvas.TextOut(X+9*m, y-29*m, 'x = '+IntToStr(round((x-sx)*scl+sax)));
  temp_bitmap.Canvas.TextOut(X+9*m, y-19*m, 'y = '+IntToStr(round((y-sy)*scl+say)));
end;

procedure tpanel1.GenerateMask;
var i, _x, _y: integer;

begin
  mask.Height:=bitmap.Height;
  mask.Width:=bitmap.Width;
  mask.Canvas.Brush.Color:=clWhite;
  mask.Canvas.FillRect(mask.Canvas.ClipRect);
  if LastCurve = dmLine2 then
  begin
    with mask.Canvas do
    begin
      Pen.Color:=clBlack;
      Pen.Width:=2;
      MoveTo(curve[0].x,curve[0].y);
      for i:=1 to Length(curve)-1 do
        mask.Canvas.LineTo(curve[i].x, curve[i].y);
    end;
    //mask.SaveToFile('temp.bmp');
    exit;
  end;

  mask.Canvas.Pen.Color:=clRed;
  case LastCurve of
    dmSpline:  begin
                 mask.Canvas.PolyBezier(Curve);
               end;
    dmLine: begin
              mask.Canvas.MoveTo(curve[0].X, curve[0].y);
              for i:=1 to length(curve)-1 do
                mask.Canvas.LineTo(curve[i].X, curve[i].Y);
            end;
    dmRect: begin
              mask.Canvas.MoveTo(curve[0].x,curve[0].Y);
              for i:=1 to Length(curve)-1 do
                mask.Canvas.LineTo(curve[i].X, curve[i].Y);
              mask.Canvas.LineTo(curve[0].X, curve[0].Y);
            end;
    dmCirc: Begin
              mask.Canvas.Brush.Style:=bsClear;
              mask.Canvas.Ellipse(curve[0].x-x_img, curve[0].y-y_img, curve[2].x-x_img,curve[2].y-y_img);
            end;
    dmNewSpline: begin
                   grap:=TGPGraphics.Create(mask.Canvas.Handle);
                   _pen:=TGPPen.Create(MakeColor(255, 255, 0, 0));
                   finalize(tempCurve);
                   SetLength(tempCurve, length(curve));
                   for i:=0 to length(curve)-1 do
                   begin
                     tempCurve[i].x:=curve[i].x-x_img;
                     tempCurve[i].y:=curve[i].y-y_img;
                   end;
                   _x:=0;
                   _y:=0;
                   for i:=0 to length(curve)-1 do
                   begin
                     _x:=_x+tempCurve[i].x;
                     _y:=_y+tempCurve[i].y;
                   end;
                   Origin.x:=round(_x/length(curve));
                   Origin.y:=round(_y/length(curve));

                   grap.DrawClosedCurve(_pen, PGPPoint(@(tempCurve[0])), length(curve), 0.5);
                   finalize(tempCurve);
                   _pen.Free;
                   grap.Free;
                 end;
  end;
  mask.Canvas.Brush.Color:=clBlack;
  mask.Canvas.FloodFill(Origin.x-x_img, Origin.y-y_img, clWhite, fsSurface);
end;


procedure tpanel1.GetMask(p: PRealArray);
var i,j: integer;
    pb: PByteArray;
begin
  GenerateMask;
  for i:=0 to bitmap.Height-1 do
  begin
    pb:=mask.ScanLine[i];
    for j:=0 to bitmap.Width-1 do
      if pb^[j] = 0 then
        p^[i*bitmap.Width+j]:=1
      else
        p^[i*bitmap.Width+j]:=0;
      {if mask.Canvas.Pixels[j,i] <> clBlack then
        p^[i*bitmap.Width+j]:=0
      else
        p^[i*bitmap.Width+j]:=1;}
  end;
  mask.FreeImage;
  Finalize(Curve);
  LastCurve:=dmNone;
end;

procedure tpanel1.MesMouseWheel(var Wheel: TWMMouseWheel);
begin
   tol:=tol+ round(Wheel.WheelDelta/50);
   if length(curve) > 4 then
     FindControlPoints(curve[length(curve)-7], curve[length(curve)-4],
     curve[length(curve)-1], curve[length(curve)-5], curve[length(curve)-3], tol, tol);
   paint;
end;


procedure tpanel1.DrawImage(var p, mask: TRealArray; width,
  height: Integer);
var min, max, temp: TReal;
    pb_temp: pByteArray;
    i, j: word;
begin
  FindMinMax(min, max, p, mask, width, height);
  if (min <> max) {and (FThreshold <> 0)} then
    temp:=Ffactor*255e2/(max-min){/FThreshold}
   else
    temp:=255;
  if bitmap.Width < width then bitmap.Width:=width;
  if bitmap.Height < height then bitmap.Height:=height;
  temp_bitmap.Width:=bitmap.Width;
  temp_bitmap.Height:=bitmap.Height;

  for i:=0 to height-1 do
    begin
      pb_temp:=bitmap.ScanLine[i];
      for j:=0 to width-1 do
        if mask[i*width+j]=1 then
          if round((p[i*width+j]-min)*temp) > 255 then
            pb_temp^[j]:=255
          else
            pb_temp^[j]:=round((p[i*width+j]-min)*temp)
        else
         pb_temp^[j]:=255;
      end;
  Paint;
end;

procedure tpanel1.FindMinMax(var min, max: TReal; var p, mask: TRealArray; width,
  height: Integer);
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

procedure tpanel1.DrawImage(var p: TRealArray; var mask: TBoolArray; width,
  height: Integer);
var min, max, temp: TReal;
    pb_temp: pByteArray;
    i, j: word;
begin
  FindMinMax(min, max, p, mask, width, height);
  if min <> max then
    temp:=255/(max-min)
   else
    temp:=255;
  if bitmap.Width < width then bitmap.Width:=width;
  if bitmap.Height < height then bitmap.Height:=height;
  temp_bitmap.Width:=bitmap.Width;
  temp_bitmap.Height:=bitmap.Height;

  for i:=0 to height-1 do
    begin
      pb_temp:=bitmap.ScanLine[i];
      for j:=0 to width-1 do
        if mask[i,j] then
          pb_temp^[j]:=round((p[i*width+j]-min)*temp)
        else
         pb_temp^[j]:=255;
      end;
  Paint;
end;

procedure tpanel1.FindMinMax(var min, max: TReal; var p: TRealArray;
  var mask: TBoolArray; width, height: Integer);
var i, j: integer;
begin
   min:=MaxInt; max:=-MaxInt;
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

procedure tpanel1.FindMinMax(var min, max: TReal; var p, mask: TMyInfernalType; minx, miny, w, h: Integer);
var i, j: integer;
begin
   min:=MaxInt; max:=-MaxInt;
   case p._type of
     varByte:  for i:=miny to miny+h-1 do
                 for j:=minx to minx+w-1 do
                 begin
                   if mask.b^[i*mask.w+j] = 1 then
                   begin
                     if min > p.b^[i*p.w+j] then min:=p.b^[i*p.w+j];
                     if max < p.b^[i*p.w+j] then max:=p.b^[i*p.w+j];
                   end;
                 end;
     varDouble:  for i:=miny to miny+h-1 do
                   for j:=minx to minx+w-1 do
                   begin
                     if mask.b^[i*mask.w+j] = 1 then
                     begin
                       if min > p.a^[i*p.w+j] then min:=p.a^[i*p.w+j];
                       if max < p.a^[i*p.w+j] then max:=p.a^[i*p.w+j];
                     end;
                   end;
   end;
end;


procedure tpanel1.DrawImage(var p, mask: TMyInfernalType; xmin, ymin, w, h, x_h, y_h, w_h, h_h: Integer);
var min, max, temp, _top, _bottom: TReal;
    pb_temp: pByteArray;
    i, j: word;
begin
  if (not p.loaded) or (not mask.loaded) then exit;
  
  if w/h >= Width/Height then
  begin
    scl:=w/Width;
    w_pict:=Width;
    h_pict:=round(Width*h/w);
  end
  else
  begin
    scl:=h/Height;
    h_pict:=Height;
    w_pict:=round(Height*w/h);
  end;
  if Width > w_pict then
  begin
    sx:=round((Width-w_pict)/2);
    sy:=0;
  end
  else
  begin
    sx:=0;
    sy:=round((Height-h_pict)/2);
  end;

  FindMinMax(min, max, p, mask, x_h, y_h, w_h, h_h);

  if Threshold then
  begin
    _top:=(max-min)*Top_Level+min;
    _bottom:=(max-min)*Bottom_Level+min;
  end
  else
  begin
    _top:=max;
    _bottom:=min;
  end;

  if _top <> _bottom then
    temp:=255/(_top-_bottom)
   else
    temp:=0;

  bitmap.Width:=w;
  bitmap.Height:=h;
  temp_bitmap.Width:=Width;
  temp_bitmap.Height:=Height;
  sax:=xmin;
  say:=ymin;

  case p._type of
    varByte:  for i:=ymin to ymin+h-1 do
                begin
                  pb_temp:=bitmap.ScanLine[i-ymin];
                  for j:=xmin to xmin+w-1 do
                    if mask.b^[i*mask.w+j] = 1 then
                    begin
                      if p.b^[i*p.w+j] > _top then
                        pb_temp^[j-xmin]:=255
                      else
                      begin
                        if p.b^[i*p.w+j] < _bottom then
                          pb_temp^[j-xmin]:=0
                        else
                          pb_temp^[j-xmin]:=round((p.b^[i*p.w+j]-_bottom)*temp)
                      end;
                    end
                    else
                      pb_temp^[j-xmin]:=255;
                  end;
    varDouble: for i:=ymin to ymin+h-1 do
                 begin
                   pb_temp:=bitmap.ScanLine[i-ymin];
                   for j:=xmin to xmin+w-1 do
                     if mask.b^[i*mask.w+j] = 1 then
                     begin
                       if p.a^[i*p.w+j] > _top then
                         pb_temp^[j-xmin]:=255
                       else
                       begin
                         if p.a^[i*p.w+j] < _bottom then
                           pb_temp^[j-xmin]:=0
                         else
                           pb_temp^[j-xmin]:=round((p.a^[i*p.w+j]-_bottom)*temp)
                       end;
                     end
                     else
                       pb_temp^[j-xmin]:=255;
                   end;
  end;
  Paint;
end;

procedure tpanel1.DrawImage(var p, mask: TMyInfernalType);
var temp, _top, _bottom: TReal;
    pb_temp: pByteArray;
    i, j, tmp: word;
begin
  if p.w_img/p.h_img >= Width/Height then
  begin
    scl:=p.w_img/Width;  //масштабный коэффициент
    w_pict:=Width;
    h_pict:=round(Width*p.h_img/p.w_img);
  end
  else
  begin
    scl:=p.h_img/Height;
    h_pict:=Height;
    w_pict:=round(Height*p.w_img/p.h_img);
  end;
  if Width > w_pict then
  begin
    sx:=round((Width-w_pict)/2);
    sy:=0;
  end
  else
  begin
    sx:=0;
    sy:=round((Height-h_pict)/2);
  end;


  {if Threshold then               //расчет гистограммы или по порогам или по области
  begin
    _top:=(max-min)*Top_Level+min;
    _bottom:=(max-min)*Bottom_Level+min;
  end
  else
  begin
    _top:=max;
    _bottom:=min;
  end;      }
  case p.ColorScale of
    byArea_hist: if p<>mask then
                   FindMinMax(_bottom, _top, p, mask)
                 else
                   FindMinMax(_bottom, _top, p, p);
    byMinMax_hist: begin
                     _top:=p.max_hist;
                     _bottom:=p.min_hist;
                   end;
    noScale: begin
               _top:=255;
               _bottom:=0;
             end;
  end;
  if Contrast_mask <> 1 then
    FindMinMax(_bottom, _top, p, p);

  FTop_Level:=_top;
  FBottom_Level:=_bottom;

  if _top <> _bottom then     //масштабирование гистограммы
    temp:=255/abs(_top-_bottom)
   else
    temp:=0;
  x_img:=p.x_img;
  y_img:=p.y_img;


  w_img:=p.w_img;
  h_img:=p.h_img;
  temp_bitmap.Width:=Width;
  temp_bitmap.Height:=Height;
  sax:=p.x_img;  //сдвиги массива
  say:=p.y_img;


  if FInterpMode = imBilinear then
  begin
    bitmap.Width:=w_pict;
    bitmap.Height:=h_pict;
    CreateInterpImage(p, mask,_top, _bottom, temp)
  end
  else
  begin
    bitmap.Width:=p.w_img;
    bitmap.Height:=p.h_img;
  end;



  if p <> mask then
  begin
  if Contrast_mask = 1 then
    case p._type of
      varByte: for i:=p.y_img to p.y_img+p.h_img-1 do
                 begin
                   pb_temp:=bitmap.ScanLine[i-p.y_img];
                   for j:=p.x_img to p.x_img+p.w_img-1 do
                     if mask.b^[i*mask.w+j] = 1 then
                     begin
                       if p.b^[i*p.w+j] > _top then
                         pb_temp^[j-p.x_img]:=255
                       else
                       begin
                         if p.b^[i*p.w+j] < _bottom then
                           pb_temp^[j-p.x_img]:=0
                         else
                           pb_temp^[j-p.x_img]:=round((p.b^[i*p.w+j]-_bottom)*temp)
                       end;
                     end
                     else
                       pb_temp^[j-p.x_img]:=255;
                 end;
      varDouble:  for i:=p.y_img to p.y_img+p.h_img-1 do
                    begin
                      pb_temp:=bitmap.ScanLine[i-p.y_img];
                      for j:=p.x_img to p.x_img+p.w_img-1 do
                        if mask.b^[i*mask.w+j] = 1 then
                        begin
                          if p.a^[i*p.w+j] > _top then
                            pb_temp^[j-p.x_img]:=255
                          else
                          begin
                            if p.a^[i*p.w+j] < _bottom then
                              pb_temp^[j-p.x_img]:=0
                            else
                              pb_temp^[j-p.x_img]:=round((p.a^[i*p.w+j]-_bottom)*temp)
                          end;
                        end
                        else
                          pb_temp^[j-p.x_img]:=255;
                    end;
    end
  else
    case p._type of
      varDouble:  for i:=p.y_img to p.y_img+p.h_img-1 do
                    begin
                      pb_temp:=bitmap.ScanLine[i-p.y_img];
                      for j:=p.x_img to p.x_img+p.w_img-1 do
                        if mask.b^[i*mask.w+j] = 1 then
                        begin
                          tmp:=round((p.a^[i*p.w+j]-_bottom)*temp);
                          if tmp > 255 then
                            tmp:=255;
                          if tmp < 0 then
                            tmp:=0;
                          pb_temp^[j-p.x_img]:=tmp;
                        end
                        else
                        begin
                          tmp:=round((p.a^[i*p.w+j]-_bottom)*temp*Contrast_mask+128*(1-Contrast_mask));
                          if tmp > 255 then
                            tmp:=255;
                          if tmp < 0 then
                            tmp:=0;
                          pb_temp^[j-p.x_img]:=tmp
                        end;
                    end;
      varByte:  for i:=p.y_img to p.y_img+p.h_img-1 do
                  begin
                    pb_temp:=bitmap.ScanLine[i-p.y_img];
                    for j:=p.x_img to p.x_img+p.w_img-1 do
                      if mask.b^[i*mask.w+j] = 1 then
                      begin
                        tmp:=round((p.b^[i*p.w+j]-_bottom)*temp);
                        if tmp > 255 then
                          tmp:=255;
                        if tmp < 0 then
                          tmp:=0;
                        pb_temp^[j-p.x_img]:=tmp;
                      end
                      else
                      begin
                        tmp:=round((p.b^[i*p.w+j]-_bottom)*temp*Contrast_mask+64+128*(1-Contrast_mask));
                        if tmp > 255 then
                          tmp:=255;
                        if tmp < 0 then
                          tmp:=0;
                        pb_temp^[j-p.x_img]:=tmp
                      end;
                  end;
    end;


  end;

  if p=mask then
    case p._type of
      varByte: for i:=p.y_img to p.y_img+p.h_img-1 do
                 begin
                   pb_temp:=bitmap.ScanLine[i-p.y_img];
                   for j:=p.x_img to p.x_img+p.w_img-1 do
                     if p.b^[i*p.w+j] > _top then
                       pb_temp^[j-p.x_img]:=255
                     else
                     begin
                       if p.b^[i*p.w+j] < _bottom then
                         pb_temp^[j-p.x_img]:=0
                       else
                         pb_temp^[j-p.x_img]:=round((p.b^[i*p.w+j]-_bottom)*temp)
                     end;
                 end;
      varDouble:  for i:=p.y_img to p.y_img+p.h_img-1 do
                    begin
                      pb_temp:=bitmap.ScanLine[i-p.y_img];
                      for j:=p.x_img to p.x_img+p.w_img-1 do
                        if p.a^[i*p.w+j] > _top then
                            pb_temp^[j-p.x_img]:=255
                        else
                        begin
                          if p.a^[i*p.w+j] < _bottom then
                            pb_temp^[j-p.x_img]:=0
                          else
                           pb_temp^[j-p.x_img]:=round((p.a^[i*p.w+j]-_bottom)*temp)
                        end;
                    end;
    end;
  Paint;
end;

procedure tpanel1.DrawImage(var p: TMyInfernalType);
var min, max, temp, _top, _bottom: TReal;
    pb_temp: pByteArray;
    i, j: word;
begin
  if p.w_img/p.h_img >= Width/Height then
  begin
    scl:=p.w_img/Width;  //масштабный коэффициент
    w_pict:=Width;
    h_pict:=round(Width*p.h_img/p.w_img);
  end
  else
  begin
    scl:=p.h_img/Height;
    h_pict:=Height;
    w_pict:=round(Height*p.w_img/p.h_img);
  end;
  if Width > w_pict then
  begin
    sx:=round((Width-w_pict)/2);
    sy:=0;
  end
  else
  begin
    sx:=0;
    sy:=round((Height-h_pict)/2);
  end;
  FindMinMax(min, max, p);
  if Threshold then               //расчет гистограммы или по порогам или по области
  begin
    _top:=(max-min)*Top_Level+min;
    _bottom:=(max-min)*Bottom_Level+min;
  end
  else
  begin
    _top:=max;
    _bottom:=min;
  end;
  if _top <> _bottom then     //масштабирование гистограммы
    temp:=255/(_top-_bottom)
   else
    temp:=0;
  x_img:=p.x_img;
  y_img:=p.y_img;
  bitmap.Width:=p.w_img;
  bitmap.Height:=p.h_img;
  temp_bitmap.Width:=Width;
  temp_bitmap.Height:=Height;
  sax:=p.x_img;  //сдвиги массива
  say:=p.y_img;
  case p._type of
    varByte: for i:=p.y_img to p.y_img+p.h_img-1 do
               begin
                 pb_temp:=bitmap.ScanLine[i-p.y_img];
                 for j:=p.x_img to p.x_img+p.w_img-1 do
                   if p.b^[i*p.w+j] > _top then
                     pb_temp^[j-p.x_img]:=255
                   else
                   begin
                     if p.b^[i*p.w+j] < _bottom then
                       pb_temp^[j-p.x_img]:=0
                     else
                       pb_temp^[j-p.x_img]:=round((p.b^[i*p.w+j]-_bottom)*temp)
                   end;
               end;
    varDouble:  for i:=p.y_img to p.y_img+p.h_img-1 do
                  begin
                    pb_temp:=bitmap.ScanLine[i-p.y_img];
                    for j:=p.x_img to p.x_img+p.w_img-1 do
                      if p.a^[i*p.w+j] > _top then
                        pb_temp^[j-p.x_img]:=255
                      else
                      begin
                        if p.a^[i*p.w+j] < _bottom then
                          pb_temp^[j-p.x_img]:=0
                        else
                          pb_temp^[j-p.x_img]:=round((p.a^[i*p.w+j]-_bottom)*temp)
                      end;
                  end;
  end;
  Paint;

end;


procedure tpanel1.DrawImage(var p: TDoubleArray; var mask: TBoolArray;
  xmin, ymin, w, h, x_h, y_h, w_h, h_h: Integer);
var min, max, temp, _top, _bottom: TReal;
    pb_temp: pByteArray;
    i, j: word;
begin
  if w/h >= Width/Height then
  begin
    scl:=w/Width;
    w_pict:=Width;
    h_pict:=round(Width*h/w);
//    temp_bitmap.Width:=Width;
//    temp_bitmap.Height:=round(Width*h/w);
  end
  else
  begin
    scl:=h/Height;
    h_pict:=Height;
    w_pict:=round(Height*w/h);
//    temp_bitmap.Height:=Height;
//    temp_bitmap.Width:=round(Height*w/h);
  end;
  if Width > w_pict then
  begin
    sx:=round((Width-w_pict)/2);
    sy:=0;
  end
  else
  begin
    sx:=0;
    sy:=round((Height-h_pict)/2);
  end;
  FindMinMax(min, max, p, mask, x_h, y_h, w_h, h_h);
  if Threshold then
  begin
    _top:=(max-min)*Top_Level+min;
    _bottom:=(max-min)*Bottom_Level+min;
  end
  else
  begin
    _top:=max;
    _bottom:=min;
  end;

//  D:=_top-_bottom;

  if _top <> _bottom then
    temp:=255/(_top-_bottom)
   else
    temp:=0;

  bitmap.Width:=w;
  bitmap.Height:=h;
  temp_bitmap.Width:=Width;
  temp_bitmap.Height:=Height;
  sax:=xmin;
  say:=ymin;
 // if bitmap.Width < w then bitmap.Width:=w;
//  if bitmap.Height < h then bitmap.Height:=h;
//  temp_bitmap.Width:=w_pict;//bitmap.Width;
 // temp_bitmap.Height:=h_pict;//bitmap.Height;

  for i:=ymin to ymin+h-1 do
    begin
      pb_temp:=bitmap.ScanLine[i-ymin];
      for j:=xmin to xmin+w-1 do
        if mask[i,j] then
        begin
          if p[i,j] > _top then
            pb_temp^[j-xmin]:=255
          else
          begin
            if p[i,j] < _bottom then
              pb_temp^[j-xmin]:=0
            else
              pb_temp^[j-xmin]:=round((p[i,j]-_bottom)*temp)
          end;
        end
        else
          pb_temp^[j-xmin]:=255;
          {if  round((p[i,j]-min)*temp) > 255 then
            pb_temp^[j]:=255
          else
            pb_temp^[j]:=round((p[i,j]-min)*temp)
        else
         pb_temp^[j]:=255;}
      end;
  Paint;
end;

procedure tpanel1.FindMinMax(var min, max: TReal; var p: TDoubleArray;
  var mask: TBoolArray; width, height: Integer);
var i, j: integer;
begin
   min:=MaxInt; max:=-MaxInt;
   for i:=0 to height-1 do
     for j:=0 to width-1 do
     begin
       if mask[i,j] then
       begin
         if min > p[i,j] then min:=p[i,j];
         if max < p[i,j] then max:=p[i,j];
       end;
     end;
end;

function tpanel1.GetOrigin: TPoint;
begin
  Result:=Origin;
end;


procedure tpanel1.DrawImage(var p: TRealArray; width, height: Integer);
var min, max, temp: TReal;
    pb_temp: pByteArray;
    i, j: word;
begin
  FindMinMax(min, max, p, width, height);
  if (min <> max){ and (FThreshold <> 0)} then
    temp:=Ffactor*255e2/(max-min){/FThreshold}
   else
    temp:=255;
  if bitmap.Width < width then bitmap.Width:=width;
  if bitmap.Height < height then bitmap.Height:=height;
  temp_bitmap.Width:=bitmap.Width;
  temp_bitmap.Height:=bitmap.Height;

  for i:=0 to height-1 do
    begin
      pb_temp:=bitmap.ScanLine[i];
      for j:=0 to width-1 do
        if round((p[i*width+j]-min)*temp) > 255 then
          pb_temp^[j]:=255
        else
          pb_temp^[j]:=round((p[i*width+j]-min)*temp);
    end;
  Paint;
end;

procedure tpanel1.FindMinMax(var min, max: TReal; var p: TRealArray; width,
  height: Integer);
var i, j: integer;
begin
   min:=MaxInt; max:=-MaxInt;
   for i:=0 to height-1 do
     for j:=0 to width-1 do
     begin
       if min > p[i*width+j] then min:=p[i*width+j];
       if max < p[i*width+j] then max:=p[i*width+j];
     end;
end;

{procedure LineDraw(x, y: Integer; Canvas: TCanvas); stdcall;
begin

   with tpanel1 do
   begin
     SetLength(PathArray[length(PathArray)-1], length(PathArray[length(PathArray)-1])+1);
   end;
 end;}

{procedure tpanel1.FindPaths;
var i: Integer;
begin
  if Length(PathArray) <> 0 then Finalize(PathArray);
 // SetLength(PathArray, length(curve) div 2);
  for i:=0 to (length(curve) div 2)-1 do
  begin
    SetLength(PathArray, i+1);

    LineDDA(curve[2*i].x, curve[2*i].y, curve[2*i+1].x, curve[2*i+1].y, @LineDraw, integer(Canvas));
  end;
end;  }

procedure tpanel1.GetPathPoints(var p: TPath);
begin
  p:=Copy(curve, 0, length(curve));
  Finalize(curve);
end;

procedure tpanel1.ChangeFactor(value: integer);
begin
  if (value >= 1) and (value <= 1000) then
    Ffactor:=value;
end;

procedure tpanel1.ChangeThreshold(value: byte);
begin
 { if (value >= 1) and (value <= 100) then
    FThreshold:=value;}
end;

procedure tpanel1.ClearStaticCircles;
begin
  Finalize(curve);
end;

procedure tpanel1.DrawImage(var b: TBoolArray; width, height: Integer);
var pb_temp: pByteArray;
    i, j: word;
begin
  if bitmap.Width < width then bitmap.Width:=width;
  if bitmap.Height < height then bitmap.Height:=height;
  temp_bitmap.Width:=bitmap.Width;
  temp_bitmap.Height:=bitmap.Height;

  for i:=0 to height-1 do
    begin
      pb_temp:=bitmap.ScanLine[i];
      for j:=0 to width-1 do
        if b[i,j] then
          pb_temp^[j]:=255
        else
          pb_temp^[j]:=0;
    end;
  Paint;
end;

procedure tpanel1.InitStatic(ObjList: array of TStaticObj;
  Color: array of TColor; CoordList: TPath);
var i: integer;
begin
  if length(Curve) <> 0 then Finalize(Curve);
  if length(Static) <> 0 then Finalize(Static);
  if length(ColorObj) <> 0 then Finalize(ColorObj);
  SetLength(Static, Length(ObjList));
  SetLength(ColorObj, Length(Color));
  for i:=0 to Length(ObjList)-1 do
  begin
    Static[i]:=ObjList[i];
    ColorObj[i]:=Color[i];
  end;
  Curve:=CoordList;
  Paint;
end;

procedure tpanel1.DestroyStatic;
begin
  if length(Curve) <> 0 then Finalize(Curve);
  if length(Static) <> 0 then Finalize(Static);
  if length(ColorObj) <> 0 then Finalize(ColorObj);
  ChangeDrawMode(dmNone);
  Paint;
end;

procedure tpanel1.GetMask(var p: TBoolArray);
var i,j: integer;
    pb: PByteArray;
begin
  GenerateMask;
  for i:=0 to bitmap.Height-1 do
  begin
    pb:=mask.ScanLine[i];
    for j:=0 to bitmap.Width-1 do
      if pb^[j] = 0 then
        p[i,j]:=true
      else
        p[i,j]:=false;
      {if mask.Canvas.Pixels[j,i] <> clBlack then
        p[i,j]:=false
      else
        p[i,j]:=true;}
  end;
  mask.FreeImage;
  Finalize(Curve);
  LastCurve:=dmNone;
end;

procedure tpanel1.DrawImage24bit(var p, mask: TRealArray; width, height: Integer);
var i,j, tmp: integer;
    min, max, temp, temp2: TReal;
    prgb: PRGBArray;
begin
  bitmap.FreeImage;
  bitmap.PixelFormat:=pf24bit;
  FindMinMax(min, max, p, mask, width, height);
  if (min <> max) then
  begin
    temp:=255/(max-min);
    temp2:=128/(max-min)
  end
  else
  begin
    temp:=255;
    temp2:=255;
  end;
  if bitmap.Width < width then bitmap.Width:=width;
  if bitmap.Height < height then bitmap.Height:=height;

  for i:=0 to height-1 do
    begin
      prgb:=PRGBArray(bitmap.ScanLine[i]);
      for j:=0 to width-1 do
        if mask[i*width+j] = 1 then
        begin
          tmp:= round((p[i*width+j] - min)*temp);
          prgb^[j].rgbtBlue:=tmp;
          prgb^[j].rgbtRed:=tmp;
          prgb^[j].rgbtGreen:=tmp;
          if p[i*width+j] >= (min+ {FThreshold*}(max-min)/100) then
          begin
            {if (tmp + 128) >= 255 then
              prgb^[j].rgbtRed:=255
            else
              prgb^[j].rgbtRed:=tmp+128;}
            prgb^[j].rgbtGreen:=round((p[i*width+j] - min)*temp2)+100;
            prgb^[j].rgbtRed:=0{round((p[i*width+j] - min)*temp2)+100};
            prgb^[j].rgbtBlue:=0;
          end;
        end
        else
        begin
          prgb^[j].rgbtBlue:=255;
          prgb^[j].rgbtRed:=255;
          prgb^[j].rgbtGreen:=255;
        end;
      end;
  Paint;

 { bitmap.FreeImage;}
  bitmap.PixelFormat:=pf8bit;
  bitmap.Palette:=CreateGreyPalette;
end;

procedure tpanel1.DrawImage(var p: TDoubleArray; width, height: Integer);
var min, max, temp: TReal;
    pb_temp: pByteArray;
    i, j: word;
begin
  FindMinMax(min, max, p,  width, height);
  if min <> max then
    temp:=255e2/(max-min){/FThreshold}
   else
    temp:=255;
  if bitmap.Width < width then bitmap.Width:=width;
  if bitmap.Height < height then bitmap.Height:=height;
  temp_bitmap.Width:=bitmap.Width;
  temp_bitmap.Height:=bitmap.Height;

  for i:=0 to height-1 do
    begin
      pb_temp:=bitmap.ScanLine[i];
      for j:=0 to width-1 do
        if  round((p[i,j]-min)*temp) > 255 then
          pb_temp^[j]:=255
        else
          pb_temp^[j]:=round((p[i,j]-min)*temp)
      end;
  Paint;
end;

procedure tpanel1.FindMinMax(var min, max: TReal; var p: TDoubleArray;
  width, height: Integer);
var i, j: integer;
begin
   min:=MaxInt; max:=-MaxInt;
   for i:=0 to height-1 do
     for j:=0 to width-1 do
     begin
       if min > p[i,j] then min:=p[i,j];
       if max < p[i,j] then max:=p[i,j];
     end;
end;

procedure tpanel1.SetOrigin(point: TPoint);
begin
  Origin:=point;
end;

procedure tpanel1.SetOrigin(x, y: integer);
begin
  Origin.x:=x;
  Origin.y:=y;
end;

function tpanel1.GetPoint2: TPoint;
begin
  Result:=Point2;
end;

procedure tpanel1.GetStaticCircle(var x, y, r: treal);
begin
  x:=circ_x;
  y:=circ_y;
  r:=circ_r;
  Finalize(curve);
end;

procedure tpanel1.GetMask(p: PBtArr);
var i,j: integer;
    pb: PByteArray;
begin
  GenerateMask;
  for i:=0 to bitmap.Height-1 do
  begin
    pb:=mask.ScanLine[i];
    for j:=0 to bitmap.Width-1 do
      if pb^[j] = 0 then
        p^[i*bitmap.Width+j]:=1
      else
        p^[i*bitmap.Width+j]:=0;
      {if mask.Canvas.Pixels[j,i] <> clBlack then
        p^[i*bitmap.Width+j]:=0
      else
        p^[i*bitmap.Width+j]:=1;}
  end;
  mask.FreeImage;
  Finalize(Curve);
  LastCurve:=dmNone;
end;

procedure tpanel1.GetMask(p, msk: PMyInfernalType);
var i,j: integer;
    pb: PByteArray;
begin
  GenerateMask;
  msk^.Clear;
  msk^.Init(p^.h, p^.w, varByte);
  for i:=0 to bitmap.Height-1 do
  begin
    pb:=mask.ScanLine[i];
    for j:=0 to bitmap.Width-1 do
      if pb^[j] = 0 then
        msk.b^[(i+p^.y_img)*p^.w+j+p^.x_img]:=1;
      {else
        msk.b^[(i+p^.y_img)*p^.w+j+p^.x_img]:=0;}
  end;
  mask.FreeImage;
  Finalize(Curve);
  LastCurve:=dmNone;
end;

procedure tpanel1.DrawImage(var p: TRealArray; var mask: TBtArr; width,
  height: Integer);
var min, max, temp, _top, _bottom: TReal;
    pb_temp: pByteArray;
    i, j: word;
begin
  FindMinMax(min, max, p, mask, width, height);
  _top:=(max-min)*Top_Level+min;
  _bottom:=(max-min)*Bottom_Level+min;
  if _top <> _bottom then
    temp:=255/(_top-_bottom)
   else
    temp:=0;
  if bitmap.Width < width then bitmap.Width:=width;
  if bitmap.Height < height then bitmap.Height:=height;
  temp_bitmap.Width:=bitmap.Width;
  temp_bitmap.Height:=bitmap.Height;
  for i:=0 to height-1 do
    begin
      pb_temp:=bitmap.ScanLine[i];
      for j:=0 to width-1 do
        if mask[i*width+j] = 1  then
        begin
          if p[i*width+j] > _top then
            pb_temp^[j]:=255
          else
          begin
            if p[i*width+j] < _bottom then
              pb_temp^[j]:=0
            else
              pb_temp^[j]:=round((p[i*width+j]-_bottom)*temp)
          end;
        end
        else
          pb_temp^[j]:=255;
      end;
  Paint;


end;

procedure tpanel1.FindMaxCircle(x, y: integer);
var i,j,w,h,q, tmp: integer;
    max: treal;
begin
  w:=w_int;
  h:=h_int;
  max:=-MaxInt;
  q:=15;

  if (x > q) and (x < (w-q-1)) and (y > q) and (y < (h-q-1)) then
  begin
    for i:=y-q to y+q do
      for j:= x-q to x+q do
      begin
        tmp:=i*w+j;
        if max < _int^[tmp] then
        begin
          max:=_int^[tmp];
          Origin.x:=j;
          Origin.y:=i;
        end;
      end;
  end
  else
  begin
    Origin.x:=x;
    Origin.y:=y;
  end;

end;

procedure tpanel1.FindMinMax(var min, max: TReal; var p: TRealArray;
  var mask: TBtArr; width, height: word);
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

procedure tpanel1.DrawImage(var p, mask: TBtArr; width, height: Integer);
var min, max, temp, _top, _bottom: TReal;
    pb_temp: pByteArray;
    i, j: word;
begin
  FindMinMax(min, max, p, mask, width, height);
  _top:=(max-min)*Top_Level+min;
  _bottom:=(max-min)*Bottom_Level+min;
  if _top <> _bottom then
    temp:=255/(_top-_bottom)
   else
    temp:=0;
  if bitmap.Width < width then bitmap.Width:=width;
  if bitmap.Height < height then bitmap.Height:=height;
  temp_bitmap.Width:=bitmap.Width;
  temp_bitmap.Height:=bitmap.Height;
  for i:=0 to height-1 do
    begin
      pb_temp:=bitmap.ScanLine[i];
      for j:=0 to width-1 do
        if mask[i*width+j] = 1  then
        begin
          if p[i*width+j] > _top then
            pb_temp^[j]:=255
          else
          begin
            if p[i*width+j] < _bottom then
              pb_temp^[j]:=0
            else
              pb_temp^[j]:=round((p[i*width+j]-_bottom)*temp)
          end;
        end
        else
          pb_temp^[j]:=255;
      end;
  Paint;
end;

procedure tpanel1.FindMinMax(var min, max: TReal; var p, mask: TBtArr;
  width, height: word);
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

procedure tpanel1.Button1Click(Sender: TObject);
begin
  point_exact.x:= StrToInt(Edit1.Text);
  point_exact.y:= StrToInt(Edit2.Text);
  Panel1.Visible:=false;
  switch:=true;
end;

procedure tpanel1.CreateEditWnd(x, y: integer);
begin

  Panel1.Visible:=False;
  Panel1.Top:=y;
  Panel1.Left:=x;
  Edit1.Text:=IntToStr(x);
  Edit2.Text:=IntToStr(y);
  Panel1.Visible:=true;
  switch:=false;
end;

procedure tpanel1.MyProcMsg;
var
  Msg: TMsg;
begin
  if PeekMessage(Msg, 0, 0, 0, PM_REMOVE) then
    if Msg.Message <> WM_QUIT then
    begin
      TranslateMessage(Msg);
      DispatchMessage(Msg);
    end;
end;

procedure tpanel1.FindMinMax(var min, max: TReal; var p, mask: TMyInfernalType);
var i, j: integer;
begin
   min:=MaxInt; max:=-MaxInt;
   if p<>mask then
     case p._type of
       varByte:  for i:=p.y_hist to p.y_hist+p.h_hist-1 do
                   for j:=p.x_hist to p.x_hist+p.w_hist-1 do
                   begin
                     if mask.b^[i*mask.w+j] = 1 then
                     begin
                       if min > p.b^[i*p.w+j] then min:=p.b^[i*p.w+j];
                       if max < p.b^[i*p.w+j] then max:=p.b^[i*p.w+j];
                     end;
                   end;
       varDouble:  for i:=p.y_hist to p.y_hist+p.h_hist-1 do
                     for j:=p.x_hist to p.x_hist+p.w_hist-1 do
                     begin
                       if mask.b^[i*mask.w+j] = 1 then
                       begin
                         if min > p.a^[i*p.w+j] then min:=p.a^[i*p.w+j];
                         if max < p.a^[i*p.w+j] then max:=p.a^[i*p.w+j];
                       end;
                     end;
     end;
   if p=mask then
     case p._type of
       varByte:  for i:=p.y_hist to p.y_hist+p.h_hist-1 do
                   for j:=p.x_hist to p.x_hist+p.w_hist-1 do
                   begin
                     if min > p.b^[i*p.w+j] then min:=p.b^[i*p.w+j];
                     if max < p.b^[i*p.w+j] then max:=p.b^[i*p.w+j];
                   end;
       varDouble:  for i:=p.y_hist to p.y_hist+p.h_hist-1 do
                     for j:=p.x_hist to p.x_hist+p.w_hist-1 do
                     begin
                       if min > p.a^[i*p.w+j] then min:=p.a^[i*p.w+j];
                       if max < p.a^[i*p.w+j] then max:=p.a^[i*p.w+j];
                     end;
     end;
end;

procedure tpanel1.FindMinMax(var min, max: TReal; var p: TMyInfernalType);
var i, j: integer;
begin
   min:=MaxInt; max:=-MaxInt;
   case p._type of
     varByte:  for i:=p.y_hist to p.y_hist+p.h_hist-1 do
                 for j:=p.x_hist to p.x_hist+p.w_hist-1 do
                 begin
                   if min > p.b^[i*p.w+j] then min:=p.b^[i*p.w+j];
                   if max < p.b^[i*p.w+j] then max:=p.b^[i*p.w+j];
                 end;
     varDouble:  for i:=p.y_hist to p.y_hist+p.h_hist-1 do
                   for j:=p.x_hist to p.x_hist+p.w_hist-1 do
                   begin
                     if min > p.a^[i*p.w+j] then min:=p.a^[i*p.w+j];
                     if max < p.a^[i*p.w+j] then max:=p.a^[i*p.w+j];
                   end;
   end;
end;

procedure tpanel1.FindMinMax(var min, max: TReal; var p: TDoubleArray;
  var mask: TBoolArray; minx, miny, w, h: Integer);
var i, j: integer;
begin
   min:=MaxInt; max:=-MaxInt;
   for i:=miny to miny+h-1 do
     for j:=minx to minx+w-1 do
     begin
       if mask[i,j] then
       begin
         if min > p[i,j] then min:=p[i,j];
         if max < p[i,j] then max:=p[i,j];
       end;
     end;
end;

function tpanel1.GetPoint1: TPoint;
begin
  Result:=Point1;
end;

procedure tpanel1.GetPathPoints(var p: TMyInfernalType);
var i: integer;
begin
  p.Clear;
  p.Init(1, length(Curve), varArray);
  for i:=0 to Length(Curve)-1 do
    p.d^[i]:=curve[i];
  Finalize(curve);
end;

procedure tpanel1.CreateInterpImage(var p, mask: TMyInfernalType; _top, _bottom,
  ColorScale: TReal);
var
  a: PRealArray;
  i, j, _x0, _y0, _x1, _y1, w, h, t1, t2, t3, t4: integer;
  _x, _y, _f1, _f2, p1, p2, p3, p4: treal;
  pb: PByteArray;
begin
  GetMem(a, w_pict*h_pict*sizeof(treal));
  w:=p.w;
  h:=p.h;
  if p=mask then
    case p._type of
      varDouble:  for i:=0 to h_pict-1 do
                    for j:=0 to w_pict-1 do
                    begin
                      _x:=(j*scl+x_img);
                      _y:=(i*scl+y_img);
                      _x0:=Floor(_x);
                      _x1:=Ceil(_x) mod w;
                      _y0:=Floor(_y);
                      _y1:=Ceil(_y) mod h;
                     t1:=_y0*w+_x0;
                     t2:=_y1*w+_x0;
                     t3:=_y0*w+_x1;
                     t4:=_y1*w+_x1;


                     _f1:=p.a^[t1]+(_y-_y0)*(p.a^[t2]-p.a^[t1]);
                     _f2:=p.a^[t3]+(_y-_y0)*(p.a^[t4]-p.a^[t3]);
                      a^[i*w_pict+j]:=_f1+(_x-_x0)*(_f2-_f1);
                    end;
      varByte:  for i:=0 to h_pict-1 do
                  for j:=0 to w_pict-1 do
                  begin
                    _x:=j*scl+x_img;
                    _y:=i*scl+y_img;
                    _x0:=Floor(_x);
                    _x1:=Ceil(_x) mod w;
                    _y0:=Floor(_y);
                    _y1:=Ceil(_y) mod h;
                   t1:=_y0*w+_x0;
                   t2:=_y1*w+_x0;
                   t3:=_y0*w+_x1;
                   t4:=_y1*w+_x1;
                   _f1:=p.b^[t1]+(_y-_y0)*(p.b^[t2]-p.b^[t1]);
                   _f2:=p.b^[t3]+(_y-_y0)*(p.b^[t4]-p.b^[t3]);
                    a^[i*w_pict+j]:=_f1+(_x-_x0)*(_f2-_f1);
                  end;
      varInteger: for i:=0 to h_pict-1 do
                    for j:=0 to w_pict-1 do
                    begin
                      _x:=j*scl+x_img;
                      _y:=i*scl+y_img;
                      _x0:=Floor(_x);
                      _x1:=Ceil(_x) mod w;
                      _y0:=Floor(_y);
                      _y1:=Ceil(_y) mod h;
                     t1:=_y0*w+_x0;
                     t2:=_y1*w+_x0;
                     t3:=_y0*w+_x1;
                     t4:=_y1*w+_x1;
                     _f1:=p.c^[t1]+(_y-_y0)*(p.c^[t2]-p.c^[t1]);
                     _f2:=p.c^[t3]+(_y-_y0)*(p.c^[t4]-p.c^[t3]);
                      a^[i*w_pict+j]:=_f1+(_x-_x0)*(_f2-_f1);
                    end;
    end;
  if p<>mask then
    case p._type of
      varDouble:  for i:=0 to h_pict-1 do
                    for j:=0 to w_pict-1 do
                    begin
                      _x:=j*scl+x_img;
                      _y:=i*scl+y_img;
                      _x0:=Floor(_x);
                      _x1:=Ceil(_x) mod w;
                      _y0:=Floor(_y);
                      _y1:=Ceil(_y) mod h;
                     t1:=_y0*w+_x0;
                     t2:=_y1*w+_x0;
                     t3:=_y0*w+_x1;
                     t4:=_y1*w+_x1;
                     if mask.b^[t1] = 1 then
                       p1:=p.a^[t1]
                     else
                       p1:=_top;
                     if mask.b^[t2] = 1 then
                       p2:=p.a^[t2]
                     else
                       p2:=_top;
                     if mask.b^[t3] = 1 then
                       p3:=p.a^[t3]
                     else
                       p3:=_top;
                     if mask.b^[t4] = 1 then
                       p4:=p.a^[t4]
                     else
                       p4:=_top;
                     _f1:=p1+(_y-_y0)*(p2-p1);
                     _f2:=p3+(_y-_y0)*(p4-p3);
                      a^[i*w_pict+j]:=_f1+(_x-_x0)*(_f2-_f1);
                    end;
      varByte:  for i:=0 to h_pict-1 do
                  for j:=0 to w_pict-1 do
                  begin
                    _x:=j*scl+x_img;
                    _y:=i*scl+y_img;
                    _x0:=Floor(_x);
                    _x1:=Ceil(_x) mod w;
                    _y0:=Floor(_y);
                    _y1:=Ceil(_y) mod h;
                   t1:=_y0*w+_x0;
                   t2:=_y1*w+_x0;
                   t3:=_y0*w+_x1;
                   t4:=_y1*w+_x1;
                   if mask.b^[t1] = 1 then
                     p1:=p.b^[t1]
                   else
                     p1:=_top;
                   if mask.b^[t2] = 1 then
                     p2:=p.b^[t2]
                   else
                     p2:=_top;
                   if mask.b^[t3] = 1 then
                     p3:=p.b^[t3]
                   else
                     p3:=_top;
                   if mask.b^[t4] = 1 then
                     p4:=p.b^[t4]
                   else
                     p4:=_top;
                   _f1:=p1+(_y-_y0)*(p2-p1);
                   _f2:=p3+(_y-_y0)*(p4-p3);
                    a^[i*w_pict+j]:=_f1+(_x-_x0)*(_f2-_f1);
                  end;
      varInteger: for i:=0 to h_pict-1 do
                    for j:=0 to w_pict-1 do
                    begin
                      _x:=j*scl+x_img;
                      _y:=i*scl+y_img;
                      _x0:=Floor(_x);
                      _x1:=Ceil(_x) mod w;
                      _y0:=Floor(_y);
                      _y1:=Ceil(_y) mod h;
                     t1:=_y0*w+_x0;
                     t2:=_y1*w+_x0;
                     t3:=_y0*w+_x1;
                     t4:=_y1*w+_x1;
                     if mask.b^[t1] = 1 then
                       p1:=p.c^[t1]
                     else
                       p1:=_top;
                     if mask.b^[t2] = 1 then
                       p2:=p.c^[t2]
                     else
                       p2:=_top;
                     if mask.b^[t3] = 1 then
                       p3:=p.c^[t3]
                     else
                       p3:=_top;
                     if mask.b^[t4] = 1 then
                       p4:=p.c^[t4]
                     else
                       p4:=_top;
                     _f1:=p1+(_y-_y0)*(p2-p1);
                     _f2:=p3+(_y-_y0)*(p4-p3);
                      a^[i*w_pict+j]:=_f1+(_x-_x0)*(_f2-_f1);
                    end;
    end;

  for i:=0 to bitmap.Height-1 do
  begin
    pb:=bitmap.ScanLine[i];
    for j:=0 to bitmap.Width-1 do
      if a^[i*w_pict+j] > _top then
        pb^[j]:=255
      else
      begin
        if a^[i*w_pict+j] < _bottom then
          pb^[j]:=0
        else
          pb^[j]:=round((a^[i*w_pict+j]-_bottom)*ColorScale);
      end;
  end;

  FreeMem(a, w_pict*h_pict*sizeof(treal));
end;

procedure tpanel1.ReSizeInterpImage;
var
  a: PRealArray;
  b: PByteArray;
  i, j, _x0, _y0, _x1, _y1, w, h, t1, t2, t3, t4: integer;
  _x, _y, _f1, _f2, s: treal;
  pb: PByteArray;

begin
  GetMem(a, w_pict*h_pict*sizeof(treal));
  w:=bitmap.Width;
  h:=bitmap.Height;
  GetMem(b, w*h*sizeof(tbt));
  for i := 0 to h-1 do
  begin
    pb:=bitmap.ScanLine[i];
    for j := 0 to w-1 do
      b^[i*w+j]:=pb^[j];
  end;
  bitmap.Width:=w_pict;
  bitmap.Height:=h_pict;
  s:=(w/w_pict+h/h_pict)/2;
  for i:=0 to h_pict-1 do
  begin
    for j:=0 to w_pict-1 do
    begin
      _x:=j*s;
      _y:=i*s;
      _x0:=Floor(_x);
      _x1:=Ceil(_x);
      _y0:=Floor(_y);
      _y1:=Ceil(_y);
     t1:=_y0*w+_x0;
     t2:=_y1*w+_x0;
     t3:=_y0*w+_x1;
     t4:=_y1*w+_x1;
     _f1:=b^[t1]+(_y-_y0)*(b^[t2]-b^[t1]);
     _f2:=b^[t3]+(_y-_y0)*(b^[t4]-b^[t3]);
      a^[i*w_pict+j]:=_f1+(_x-_x0)*(_f2-_f1);
    end;
  end;
  for i:=0 to h_pict-1 do
  begin
    pb:=bitmap.ScanLine[i];
    for j:=0 to w_pict-1 do
       pb^[j]:=round(a^[i*w_pict+j]);
  end;

  FreeMem(b, bitmap.Width*bitmap.Height*sizeof(tbt));
  FreeMem(a, w_pict*h_pict*sizeof(treal));
end;

procedure tpanel1.SetScale_x(scale: treal);
begin
  scale_x:=scale;
end;

procedure tpanel1.WMKeyDown(var msg: TWMKey);
begin
  ShowMessage('!');
end;

procedure tpanel1.SetVideoRect(w, h: integer);
begin
  if w/h >= Width/Height then
  begin
    scl:=w/Width;  //масштабный коэффициент
    w_pict:=Width;
    h_pict:=round(Width*h/w);
  end
  else
  begin
    scl:=h/Height;
    h_pict:=Height;
    w_pict:=round(Height*w/h);
  end;
  sx:=round((Width-w_pict)/2);
  sy:=round((Height-h_pict)/2);
  temp_bitmap.Width:=Width;
  temp_bitmap.Height:=Height;
  xc:=Width div 2;
  yc:=Height div 2;
end;

function tpanel1.CreateGreyPaletteWithThreshold: HPALETTE;
var
  i: integer;
  Pal: PLogPalette;
  ColorTable: ^TPaletteEntryArray;
begin
  GetMem(Pal, SizeOf(TLogPalette)+255*SizeOf(TPaletteEntry));
  Pal^.palVersion:= $300;
  Pal^.palNumEntries:= 256;
  ColorTable:= Addr(Pal^.palPalEntry[0]);
  for i:=0 to min_pal do
    with ColorTable^[i] do
    begin
      peRed:=0;//179;
      peGreen:=255;//241;
      peBlue:=0;//141;
      peFlags:=0;
    end;
  for i:=max_pal to 255 do
    with ColorTable^[i] do
    begin
      peRed:=255;//252;
      peGreen:=0;//131;
      peBlue:=0;//164;
      peFlags:=0;
    end;
  for i:=min_pal+1 to max_pal-1 do
    with ColorTable^[i] do
    begin
      peRed:=i;
      peGreen:=i;
      peBlue:=i;
      peFlags:=0;
    end;
  Result:=CreatePalette(Pal^);
  FreeMem(Pal, SizeOf(TLogPalette)+255*SizeOf(TPaletteEntry));
end;

procedure tpanel1.NullPaint;
begin
  Paint;
end;

procedure tpanel1.InitOpenGL(var p, mask, bw: TMyInfernalType; k: treal);
var max, min: treal;
begin
  dc:=GetDC(Handle);
  SetDCPixelFormat(dc);
  hrc:= wglCreateContext(dc);
  wglMakeCurrent(dc, hrc);
  dimx:=p.w*k;
  dimy:=p.h*k;
  FindMin_Max(min, max, p.a^, mask.b^, p.w, p.h);
  dimz:=max-min;
  tempdim:=sqrt(sqr(dimx)+sqr(dimy)+sqr(dimz));

  glClearColor(1.0, 1.0, 1.0, 1.0);
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_LIGHTING);
  glEnable(GL_LIGHT0);
  glLightModelf(GL_LIGHT_MODEL_TWO_SIDE, 1);
  glEnable(GL_COLOR_MATERIAL);
  Self.p:=p;
  _m:=mask;
  Self.bw:=bw;
  Scale_OpenGL:=k;
  rx:=0;
  ry:=0;

  {OpenGL_w:=p.w;
  OpenGL_h:=p.h;

  if p.w/p.h >= Width/Height then
  begin
    w_pict:=Width;
    h_pict:=round(Width*p.h/p.w);
  end
  else
  begin
    h_pict:=Height;
    w_pict:=round(Height*p.w/p.h);
  end;
  sx:=round((Width-w_pict)/2);
  sy:=round((Height-h_pict)/2);
   }
  SetPort;
  paint;
  {}
end;

procedure tpanel1.SetDCPixelFormat(hdc: HDC);
var
 pfd: TPixelFormatDescriptor;
 nPixelFormat: Integer;
begin
 FillChar(pfd, SizeOf (pfd), 0);
 pfd.dwFlags:=PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
 nPixelFormat:=ChoosePixelFormat (hdc, @pfd);
 SetPixelFormat(hdc, nPixelFormat, @pfd);
end;

procedure tpanel1.SetPort;
begin
 glViewport(0, 0, Width, Height);
 glMatrixMode(GL_PROJECTION);
 glLoadIdentity;
 if Width/Height >= dimx/dimy then
   glOrtho(-Width/Height*dimy/2, Width/Height*dimy/2, -dimy/2, dimy/2, -tempdim/2, tempdim/2)
 else
   glOrtho(-dimx/2, dimx/2, -Height/Width*dimx/2, Height/Width*dimx/2, -tempdim/2, tempdim/2);
// glTranslatef(0.0, 0.0, -(max+min)/2);
 glMatrixMode(GL_MODELVIEW);
 glGetFloatv(GL_MODELVIEW_MATRIX, @mt);
 rx:=0;
 ry:=0;
 glLoadIdentity;
end;

procedure tpanel1.DrawModel_OpenGL;
var i,j,h,w: integer;
    norm: T3dPoint;
    k: TReal;
    m1, m2, m3, m4: integer;
   { pb: PByteArray;
    bmp: TBitmap;
    pixels: PSingleArray;
    tmp, tmp2: integer;
    _w_p, _h_p, _sx, _sy: integer;}
begin
  k:=Scale_OpenGL;
  h:=p.h;
  w:=p.w;
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glPushMatrix;
  glLoadMatrixf(@mt);
  glRotatef(module, rx*mt[0,0]+ry*mt[0,1], rx*mt[1,0]+ry*mt[1,1], rx*mt[2,0]+ry*mt[2,1]);
  glGetFloatv(GL_MODELVIEW_MATRIX, @mt);

  glTranslatef(-dimx/2, -dimy/2, 0);
  glColor3f(0.75, 0.75, 0.75);
    for i:=0 to h-1 do
      for j:=0 to w-1 do
      begin
        m1:=i*w+j;
        m2:=(i+1)*w+j;
        m3:=i*w+j+1;
        m4:=(i+1)*w+j+1;
        if (_m.b^[m1]=1) and (_m.b^[m2]=1) and (_m.b^[m3]=1) and (_m.b^[m4]=1) then
        begin
          glBegin(GL_TRIANGLES);
            GetNormal((j+1)*k, (h-i)*k, p.a^[m3], j*k, (h-(i+1))*k, p.a^[m2], j*k, (h-i)*k, p.a^[m1], norm);
            glNormal3f(-norm.x, -norm.y, -norm.z);
            glColor3f(bw.a^[m1], bw.a^[m1], bw.a^[m1]);
            glVertex3f(j*k,(h-i)*k,p.a^[m1]);
            glColor3f(bw.a^[m2], bw.a^[m2], bw.a^[m2]);
            glVertex3f(j*k,(h-(i+1))*k,p.a^[m2]);
            glColor3f(bw.a^[m3], bw.a^[m3], bw.a^[m3]);
            glVertex3f((j+1)*k,(h-i)*k,p.a^[m3]);
            GetNormal((j+1)*k, (h-i)*k, p.a^[m3], (j+1)*k, (h-(i+1))*k, p.a^[m4], j*k, (h-(i+1))*k, p.a^[m2], norm);
            glNormal3f(-norm.x, -norm.y, -norm.z);
            glColor3f(bw.a^[m3], bw.a^[m3], bw.a^[m3]);
            glVertex3f((j+1)*k,(h-i)*k,p.a^[m3]);
            glColor3f(bw.a^[m2], bw.a^[m2], bw.a^[m2]);
            glVertex3f(j*k,(h-(i+1))*k,p.a^[m2]);
            glColor3f(bw.a^[m4], bw.a^[m4], bw.a^[m4]);
            glVertex3f((j+1)*k,(h-(i+1))*k,p.a^[m4]);
          glEnd;
        end;
      end;
  glPopMatrix;
  {glPixelTransferi(GL_RED_SCALE, 1);
  glPixelTransferi(GL_RED_BIAS, 0);
  glPixelTransferi(GL_GREEN_SCALE, 1);
  glPixelTransferi(GL_GREEN_BIAS, 0);
  glPixelTransferi(GL_BLUE_SCALE, 1);
  glPixelTransferi(GL_BLUE_BIAS, 0);            }

  if grab then
  begin
    GetMem(OpenGLBuf, Width*Height*3*sizeof(single));
    glReadPixels(0, 0, Width, Height, GL_RGB, GL_FLOAT, OpenGLBuf);
    {if p.w/p.h >= Width/Height then
    begin
      _w_p:=width;
      _h_p:=round(width*p.h/p.w);
    end
    else
    begin
      _h_p:=Height;
      _w_p:=round(height*p.w/p.h);
    end;
      _sx:=round((width-_w_p)/2);
      _sy:=round((height-_h_p)/2);
    w:=Width;
    h:=Height;
    bmp:=TBitmap.Create;
    bmp.Width:=_w_p;
    bmp.Height:=_h_p;
    bmp.PixelFormat:=pf24bit;
    GetMem(pixels, w*h*3*sizeof(single));
    glReadPixels(0, 0, w, h, GL_RGB, GL_FLOAT, pixels);
    for i:=_sy to _sy+_h_p-1 do
    begin
      pb:=bmp.ScanLine[i-_sy];
      for j:=_sx to _sx+_w_p-1 do
      begin
        tmp:=((h-1-i)*w+j)*3;
        tmp2:=(j-_sx)*3;
        pb^[tmp2]:=round(pixels^[tmp]*255);
        pb^[tmp2+1]:=round(pixels^[tmp+1]*255);
        pb^[tmp2+2]:=round(pixels^[tmp+2]*255);
      end;
    end;
    FreeMem(pixels, w*h*3*sizeof(single));
    bmp.SaveToFile('temp.bmp');
    bmp.destroy; }
  end;
  SwapBuffers(dc);
end;

procedure tpanel1.GetNewSlices(var p: TPath);
var i: integer;
begin
  setlength(p, length(curve));

  for i:=0 to length(curve)-1 do
    p[i]:=curve[i];

  finalize(curve);

end;

procedure tpanel1.GetNormal(x1, y1, z1, x2, y2, z2, x3, y3, z3: GLfloat;
  var norm: T3dPoint);
var module: GLfloat;
begin
  norm.x:=((y2-y1)*(z3-z1)-(z2-z1)*(y3-y1));
  norm.y:=((x3-x1)*(z2-z1)-(x2-x1)*(z3-z1));
  norm.z:=((x2-x1)*(y3-y1)-(y2-y1)*(x3-x1));
  module:=sqrt(sqr(norm.x)+sqr(norm.y)+sqr(norm.z));
  norm.x:=(norm.x/module);
  norm.y:=(norm.y/module);
  norm.z:=(norm.z/module);
end;

procedure tpanel1.ReleaseOpenGL;
begin
  wglMakeCurrent(0,0);
  wglDeleteContext(hrc);
  ReleaseDC(Handle, dc);
  DeleteDC(dc);
end;

procedure tpanel1.SetBuffer(var buf: PSingleArray);
begin
  OpenGLBuf:=buf;
end;

procedure tpanel1.GetBuffer(var buf: PSingleArray);
begin
  buf:=OpenGLBuf;
end;

procedure tpanel1.GetCheckedCircle(x, y: treal);
var i, w: integer;
    r: treal;
  u: TCircleCoordArray;
begin
  case ExpoMode of
    em1: u:=lc1;
    em2: u:=lc2;
  end;
  w:=Length(u);

  Curr_checked:=-1;
  for i:=0 to w-1 do
  begin
    r:=Hypot(x-u[i].x, y-u[i].y);
    if abs(r-u[i].r) < 5 then
    begin
      Curr_checked:=i;
      break;
    end;
  end;


end;


procedure tpanel1.InitOpenGL_STL(_facet: Pfacet; _nFacets: integer);
var i, j: integer;
   // zmin, zmax, xmin, xmax, ymin, ymax: treal;
begin
  dc:=GetDC(Handle);
  SetDCPixelFormat(dc);
  hrc:= wglCreateContext(dc);
  wglMakeCurrent(dc, hrc);
  facet:=_facet;
  nFacets:=_nFacets;
  with STLdim do
  begin
    minx:=MaxInt;
    miny:=MaxInt;
    minz:=MaxInt;
    maxz:=-MaxInt;
    maxy:=-MaxInt;
    maxz:=-MaxInt;
    for i:=0 to nFacets-1 do
    begin
      for j:=0 to 2 do
      begin
       { if (facet^[i].vertex[j,0] = 0) or (facet^[i].vertex[j,1] = 0) or (facet^[i].vertex[j,2] = 0) then
          Continue;
        }
        if maxx < facet^[i].vertex[j,0] then
          maxx:=facet^[i].vertex[j,0];
        if minx > facet^[i].vertex[j,0] then
          minx:=facet^[i].vertex[j,0];
        if maxy < facet^[i].vertex[j,1] then
          maxy:=facet^[i].vertex[j,1];
        if miny > facet^[i].vertex[j,1] then
          miny:=facet^[i].vertex[j,1];
        if maxz < facet^[i].vertex[j,2] then
          maxz:=facet^[i].vertex[j,2];
        if minz > facet^[i].vertex[j,2] then
          minz:=facet^[i].vertex[j,2];
      end;
    end;
    cx:=(maxx+minx)/2;
    cy:=(maxy+miny)/2;
    cz:=(maxz+minz)/2;
    tempdim:=sqrt(sqr(maxx-minx)+sqr(maxy-miny)+sqr(maxz-minz));
    dimx:=2*Max(abs(minx-cx), abs(maxx-cx));
    dimy:=2*Max(abs(miny-cy), abs(maxy-cy));
    dimz:=2*Max(abs(minz-cz), abs(maxz-cz));
  end;

  glClearColor(1.0, 1.0, 1.0, 1.0);
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_LIGHTING);
  glEnable(GL_LIGHT0);
  glLightModelf(GL_LIGHT_MODEL_TWO_SIDE, 1);
  glEnable(GL_COLOR_MATERIAL);

  SetPort;
  Paint;
  rx:=0;
  ry:=0;
end;

procedure tpanel1.DrawModel_OpenGL_STL;
var i,j: integer;
begin
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glPushMatrix;
  glLoadMatrixf(@mt);
  glRotatef(module, rx*mt[0,0]+ry*mt[0,1], rx*mt[1,0]+ry*mt[1,1], rx*mt[2,0]+ry*mt[2,1]);
  glGetFloatv(GL_MODELVIEW_MATRIX, @mt);

  with STLdim do
    glTranslatef(-cx, -cy, -cz);
  glColor3f(0.75, 0.75, 0.75);

  glBegin(GL_TRIANGLES);
  for i:=0 to nFacets-1 do
  begin
    glNormal3f(facet^[i].normal[0], facet^[i].normal[1], facet^[i].normal[2]);
    for j:=0 to 2 do
      glVertex3f(facet^[i].vertex[j,0], facet^[i].vertex[j,1], facet^[i].vertex[j,2]);
  end;
  glEnd;
  glPopMatrix;
  SwapBuffers(dc);
end;

procedure tpanel1.MouseUp(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
 // grab:=false;
  case FDrawMode of
    dmLargeCross: begin
                    if (button = mbRight) and (CrossMode = cmScale) then
                      if ((x-sx) >= 0) and ((y-sy) >= 0) and
                      ((x-sx)*scl <= (w_img)) and ((y-sy)*scl <= (h_img)) then
                      begin
                        Point2.x:=round((x-sx)*scl+sax);
                        Point2.y:=round((y-sy)*scl+say);
                        CrossMode:=cmCross;
                        grab:=true;
                        Paint;
                      end
                      else
                      begin
                        grab:=false;
                        CrossMode:=cmCross;
                        Paint;
                      end;
                  end;
  end;
  inherited MouseUp(Button, Shift, X, Y);
end;

procedure tpanel1.SetGLColor(R, G, B: Single);
begin
  GLColor[0]:=R;
  GLColor[1]:=G;
  GLColor[2]:=B;
end;

procedure tpanel1.InitNewSlices(var p: TPath);
var i: integer;
begin
  Finalize(curve);
  setlength(curve, length(p));
  for i:=0 to length(p)-1 do
    curve[i]:=p[i];
  paint;
end;

procedure tpanel1.InitOpenGL(var p, mask: TMyInfernalType; k, R, G, B: treal; quality: byte);
var max, min: treal;
begin
  dc:=GetDC(Handle);
  SetDCPixelFormat(dc);
  hrc:= wglCreateContext(dc);
  wglMakeCurrent(dc, hrc);
  dimx:=p.w*k;
  dimy:=p.h*k;
  FindMin_Max(min, max, p.a^, mask.b^, p.w, p.h);
  dimz:=max-min;
  tempdim:=sqrt(sqr(dimx)+sqr(dimy)+sqr(dimz));

  glClearColor(1.0, 1.0, 1.0, 1.0);
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_LIGHTING);
  glEnable(GL_LIGHT0);
  glLightModelf(GL_LIGHT_MODEL_TWO_SIDE, 1);
  glEnable(GL_COLOR_MATERIAL);
  Self.p:=p;
  _m:=mask;
  Scale_OpenGL:=k;
  rx:=0;
  ry:=0;
  GLColor[0]:=R;
  GLColor[1]:=G;
  GLColor[2]:=B;
  GLQuality:=quality;
  ZeroMemory(@mt, sizeof(mt));
  rx:=0;
  ry:=0;
  SetPort;
//  paint;

end;

procedure tpanel1.DrawModel_OpenGL2;
var i,j,h,w, h1, w1, q: integer;
    norm: T3dPoint;
    k: TReal;
    m1, m2, m3, m4: integer;
begin
  k:=Scale_OpenGL;
  h:=p.h;
  w:=p.w;
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glPushMatrix;
  glLoadMatrixf(@mt);
  glRotatef(module, rx*mt[0,0]+ry*mt[0,1], rx*mt[1,0]+ry*mt[1,1], rx*mt[2,0]+ry*mt[2,1]);
  glGetFloatv(GL_MODELVIEW_MATRIX, @mt);
  q:=GLQuality;
  h1:=(h div q)-2;
  w1:=(w div q)-2;

  glTranslatef(-dimx/2, -dimy/2, 0);
  glColor3fv(@GLColor);
    for i:=0 to h1 do
      for j:=0 to w1 do
      begin
        m1:=i*q*w+j*q;
        m2:=(i+1)*q*w+j*q;
        m3:=i*q*w+(j+1)*q;
        m4:=(i+1)*q*w+(j+1)*q;
        if (_m.b^[m1]=1) and (_m.b^[m2]=1) and (_m.b^[m3]=1) and (_m.b^[m4]=1) then
        begin
          glBegin(GL_TRIANGLES);
            GetNormal(q*(j+1)*k, (h-i*q)*k, p.a^[m3], q*j*k, (h-q*(i+1))*k, p.a^[m2], q*j*k, (h-q*i)*k, p.a^[m1], norm);
            glNormal3f(-norm.x, -norm.y, -norm.z);
            glVertex3f(q*j*k,(h-q*i)*k,p.a^[m1]);
            glVertex3f(q*j*k,(h-q*(i+1))*k,p.a^[m2]);
            glVertex3f(q*(j+1)*k,(h-q*i)*k,p.a^[m3]);
            GetNormal(q*(j+1)*k, (h-q*i)*k, p.a^[m3], q*(j+1)*k, (h-q*(i+1))*k, p.a^[m4], q*j*k, (h-q*(i+1))*k, p.a^[m2], norm);
            glNormal3f(-norm.x, -norm.y, -norm.z);
            glVertex3f(q*(j+1)*k,(h-q*i)*k,p.a^[m3]);
            glVertex3f(q*j*k,(h-q*(i+1))*k,p.a^[m2]);
            glVertex3f(q*(j+1)*k,(h-q*(i+1))*k,p.a^[m4]);
          glEnd;
        end;
      end;

  if grab then
  begin
    GetMem(OpenGLBuf, Width*Height*3*sizeof(single));
    glReadPixels(0, 0, Width, Height, GL_RGB, GL_FLOAT, OpenGLBuf);
  end;
  glPopMatrix;
  SwapBuffers(dc);
end;

procedure tpanel1.SetProgress(prgs: byte);
begin
  Progress:= prgs;
end;

procedure tpanel1.SetSpriteText(text: string);
begin
  SpriteText:=text;
end;

procedure tpanel1.GetDistance(var dist: treal);
begin
  dist:=Hypot(curve[0].x-curve[1].x, curve[0].y-curve[1].y);
  Finalize(curve);
end;

procedure tpanel1.InitStaticCircle(var int: TMyInfernalType);
begin
  _int:=int.b;
  w_int:=int.w;
  h_int:=int.h;
end;

procedure tpanel1.InitStaticCircles(var x, y, r: TMyInfernalType);
begin
  _x:=x;
  _y:=y;
  _r:=r;
  Repaint;
end;

end.

