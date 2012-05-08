unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OpenGL, math, crude, utype, t666, StdCtrls;

type
  T3dPoint = record
               x,y,z: GLfloat;
             end;
  TMode = (mdColor, mdGrey, mdInt);

  TForm7 = class(TForm)
    Button1: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure FormMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Click(Sender: TObject);
  private
     DC: HDC;
     hrc: HGLRC;
     ry, rx, sx, dimx, dimy, dimz, tempdim, ampz, module: GLfloat;
     q: integer;
     min, max, k: treal;
     b, rot: Boolean;
     a: TPoint;
     mode: TMode;
     mt: array[0..3, 0..3] of GLfloat;
     procedure GetNormal(x1, y1, z1, x2, y2, z2, x3, y3, z3: GLfloat; var  norm: T3dPoint); overload;
     procedure GetColour(data: GLfloat; var R, G, B: GLfloat; i, j, w, h: integer);
  public
     procedure InitModel(var p: TDoubleArray; var mask: TBoolArray; w, h: integer); overload;
     procedure InitModel(var p: TRealArray; var mask: TBtArr; w, h: integer); overload;
     procedure InitModel(var p: TMyInfernalType); overload;
  protected
    procedure WMPaint(var Msg: TWMPaint); message WM_PAINT;
  end;

const SURFACE = 1;
      AXES = 2;
      GLF_START_LIST = 1000;

var
  Form7: TForm7;

implementation

uses unit1, Types, UPhast2Vars;

{$R *.dfm}

procedure OutText(Litera: PChar);
begin
  glListBase(GLF_START_LIST);
  glCallLists(Length(Litera), GL_UNSIGNED_BYTE, Litera);
end;

procedure SetDCPixelFormat(hdc : HDC);
var
 pfd : TPixelFormatDescriptor;
 nPixelFormat : Integer;
begin
 FillChar (pfd, SizeOf (pfd), 0);
 pfd.dwFlags  := PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
 nPixelFormat := ChoosePixelFormat (hdc, @pfd);
 SetPixelFormat (hdc, nPixelFormat, @pfd);
end;

procedure TForm7.FormCreate(Sender: TObject);
begin
 DC:= GetDC(Handle);
 SetDCPixelFormat(DC);
 hrc:= wglCreateContext(DC);
 wglMakeCurrent(DC, hrc);
// wglUseFontBitmaps(DC, 0, 255, GLF_START_LIST);
 glClearColor(1.0, 1.0, 1.0, 1.0);
 glEnable(GL_DEPTH_TEST);
 glEnable(GL_LIGHTING);
 glEnable(GL_LIGHT0);
 glLightModelf(GL_LIGHT_MODEL_TWO_SIDE, 1);
 glEnable(GL_COLOR_MATERIAL);
// glEnable(GL_LINE_SMOOTH);
// glEnable(GL_POINT_SMOOTH);
// glPointSize(5);
// glLineWidth(0.5);
end;

procedure TForm7.FormDestroy(Sender: TObject);
begin
  glDeleteLists(GLF_START_LIST, 1);
  wglMakeCurrent(0, 0);
  wglDeleteContext(hrc);
  ReleaseDC(Handle, DC);
  DeleteDC(DC);
end;

procedure TForm7.FormResize(Sender: TObject);
begin
 glViewport(0, 0, ClientWidth, ClientHeight);
 glMatrixMode (GL_PROJECTION);
 glLoadIdentity;
 if ClientWidth/ClientHeight >= dimx/dimy then
 //  glFrustum(-ClientWidth/ClientHeight*dimy/2, ClientWidth/ClientHeight*dimy/2, -dimy/2, dimy/2, 10, tempdim+10)
   glOrtho(-ClientWidth/ClientHeight*dimy/2, ClientWidth/ClientHeight*dimy/2, -dimy/2, dimy/2, -tempdim/2, tempdim/2)
 else
   glOrtho(-dimx/2, dimx/2, -ClientHeight/ClientWidth*dimx/2, ClientHeight/ClientWidth*dimx/2, -tempdim/2, tempdim/2);
  // glFrustum(-dimx/2, dimx/2, -ClientHeight/ClientWidth*dimx/2, ClientHeight/ClientWidth*dimx/2, 10, tempdim+10);

 glTranslatef(0.0, 0.0, -ampz*(max+min)/2{-tempdim/2-10});
 glMatrixMode (GL_MODELVIEW);
 glLoadIdentity;

 glGetFloatv(GL_MODELVIEW_MATRIX,@mt);
 InvalidateRect(Handle, nil, False);
end;

procedure TForm7.GetColour(data: GLfloat; var R, G, B: GLfloat; i, j, w, h: integer);
begin
  if data > 1 then
    data:=1
  else
    if data < 0 then
      data:=0;

  with form1 do
    if mode = mdInt then
    begin
      R:=int.b^[(i+int.y_img)*int.w+j+int.x_img]/255;
      G:=int.b^[(i+int.y_img)*int.w+j+int.x_img]/255;
      B:=int.b^[(i+int.y_img)*int.w+j+int.x_img]/255;
      exit;
    end;

  if mode = mdColor then
  begin
    if data <= 1/5 then
    begin
      R:=0;
      G:=0;
      B:=data*5;
      exit;
    end;
    if data <= 2/5 then
    begin
      R:=0;
      G:=(data-1/5)*5;
      B:=1;
      exit;
    end;
    if data <= 3/5 then
    begin
      R:=(data-2/5)*5;
      G:=1;
      B:=(3/5-data)*5;
      exit;
    end;
    if data <= 4/5 then
    begin
      R:=1;
      G:=(4/5-data)*5;
      B:=0;
      exit;
    end;
    if data <= 1 then
    begin
      R:=1;
      G:=(data-4/5)*5;
      B:=(data-4/5)*5;
      exit;
    end;
  end
  else
  begin
    R:=data;
    G:=data;
    B:=data;
  end;

end;

procedure TForm7.GetNormal(x1, y1, z1, x2, y2, z2, x3, y3, z3: GLfloat;
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

procedure TForm7.InitModel(var p: TDoubleArray; var mask: TBoolArray; w, h: integer);
var i, j, minx, miny, maxx, maxy, m, n: integer;
    norm: T3dPoint;
    R, G, B: GLfloat;
begin
  AreaBounds(mask, minx, miny, maxx, maxy);
  m:=maxy-miny+1;
  n:=maxx-minx+1;

  q:=3; //разрешение
  sx:=0.7; //масштаб
  k:=1;  //линейный размер
  ampz:=1;
  rot:=true;
  rx:=0.0;
  ry:=0.0;
  dimx:=n*k;
  dimy:=m*k;
  FindMin_Max(min, max, p, mask);
  dimz:=ampz*(max-min);
  tempdim:=sqrt(sqr(dimx)+sqr(dimy)+sqr(dimz));
  {if Form3.ListView1.ItemIndex = 0 then
    mode:= mdInt
  else
  begin
    if Form3.tpanel11.Palette = ColorPalette then
      mode:=mdColor
    else
      mode:=mdGrey;
  end;}

  mode:=mdColor; //режим раскрашивания

  {if Form1.ProgaSys.axes then
  begin
   glNewList(AXES, GL_COMPILE);
   glColor3f(0,0,0);
   glBegin(GL_LINES);
     glVertex3f(0,0,-dimz/2);
     glVertex3f(0.5+dimx,0,-dimz/2);
     glVertex3f(0,0,-dimz/2);
     glVertex3f(0,0.5+dimy,-dimz/2);
     glVertex3f(0,0,-dimz/2);
     glVertex3f(0,0,dimz/2+0.5);
   glEnd;
   glRasterPos3f(dimx+1, 0, -dimz/2);
   OutText('X');
   glRasterPos3f(0, 1+dimy, -dimz/2);
   OutText('Y');
   glRasterPos3f(0, 0, dimz/2+1);
   OutText('Z');
   glRasterPos3f(-0.3,-0.3,-dimz/2-0.3);
   OutText('0');
   glRasterPos3f(dimx,-0.5,-dimz/2-0.5);
   OutText(PChar(FloatToStrF(dimx,ffExponent, 3, 2)));
   glRasterPos3f(-0.5,dimy,-dimz/2-0.5);
   OutText(PChar(FloatToStrF(dimy,ffExponent, 3, 2)));
   glRasterPos3f(-0.5,-0.5,dimz/2);
   OutText(PChar(FloatToStrF(dimz/ampz,ffExponent, 3, 2)));

   glBegin(GL_POINTS);
     glVertex3f(0,0,-dimz/2);
     glVertex3f(dimx,0,-dimz/2);
     glVertex3f(0,dimy,-dimz/2);
     glVertex3f(0,0, dimz/2);
   glEnd;
   glEndList;
  end;}
  glNewList(SURFACE, GL_COMPILE);
   for i:=0 to (m div q)-2 do
     for j:=0 to (n div q)-2 do
       if mask[i*q+miny,j*q+minx] and mask[q*(i+1)+miny,q*j+minx] and mask[q*i+miny,q*(j+1)+minx] and mask[q*(i+1)+miny, q*(j+1)+minx] then
       begin
       glBegin(GL_TRIANGLES);
         GetNormal(q*(j+1)*k, (m-i*q)*k, ampz*p[q*i+miny,q*(j+1)+minx], q*j*k, (m-q*(i+1))*k, ampz*p[q*(i+1)+miny,q*j+minx], q*j*k, (m-i*q)*k, ampz*p[q*i+miny,q*j+minx], norm);
         glNormal3f(-norm.x, -norm.y, -norm.z);
         GetColour((p[q*i+miny,q*j+minx]-min)/(max-min) ,R, G, B, i*q+miny, j*q+minx, w, h);
         glColor3f(R, G, B);
         glVertex3f(j*q*k,(m-i*q)*k,ampz*p[i*q+miny,j*q+minx]);
         GetColour((p[q*(i+1)+miny,q*j+minx]-min)/(max-min) ,R, G, B, i*q+miny, j*q+minx, w, h);
         glColor3f(R, G, B);
         glVertex3f(q*j*k,(m-q*(i+1))*k,ampz*p[q*(i+1)+miny,q*j+minx]);
         GetColour((p[q*i+miny,q*(j+1)+minx]-min)/(max-min) ,R, G, B, i*q+miny, j*q+minx, w, h);
         glColor3f(R, G, B);
         glVertex3f(q*(j+1)*k,(m-i*q)*k,ampz*p[q*i+miny,q*(j+1)+minx]);

         GetNormal(q*(j+1)*k, (m-q*i)*k, ampz*p[q*i+miny,q*(j+1)+minx], q*(j+1)*k, (m-q*(i+1))*k, ampz*p[q*(i+1)+miny,q*(j+1)+minx], q*j*k, (m-q*(i+1))*k, ampz*p[q*(i+1)+miny,q*j+minx], norm);
         glNormal3f(-norm.x, -norm.y, -norm.z);
         glVertex3f(q*(j+1)*k,(m-q*i)*k,ampz*p[q*i+miny,q*(j+1)+minx]);
         GetColour((p[q*(i+1)+miny,q*j+minx]-min)/(max-min) ,R, G, B, i*q+miny, j*q+minx, w, h);
         glColor3f(R, G, B);
         glVertex3f(q*j*k,(m-q*(i+1))*k,ampz*p[q*(i+1)+miny,q*j+minx]);
         GetColour((p[q*(i+1)+miny,q*(j+1)+minx]-min)/(max-min) ,R, G, B, i*q+miny, j*q+minx, w, h);
         glColor3f(R, G, B);
         glVertex3f(q*(j+1)*k,(m-q*(i+1))*k,ampz*p[q*(i+1)+miny,q*(j+1)+minx]);
       glEnd;
       end;
 glEndList;
 FormResize(Self);
end;

procedure TForm7.WMPaint(var Msg: TWMPaint);
var
  ps: TPaintStruct;
begin
  BeginPaint(Handle, ps);
  glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
  glPushMatrix;
  glLoadMatrixf(@mt);
  if rot then glRotatef(module, rx*mt[0,0]+ry*mt[0,1], rx*mt[1,0]+ry*mt[1,1], rx*mt[2,0]+ry*mt[2,1]);
  glGetFloatv(GL_MODELVIEW_MATRIX,@mt);
  glScalef(sx, sx, sx);
  if not rot then rot:=not rot;
  glTranslatef(-dimx/2, -dimy/2, 0);
  glCallList(SURFACE);
  glPopMatrix;
  SwapBuffers(DC);
  EndPaint(Handle, ps);
end;

procedure TForm7.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  if ((sx >= 0.5) and (sx <= 2)) or ((sx < 0.5) and (WheelDelta > 0)) or ((sx > 2) and (WheelDelta < 0)) then
  begin
    sx:=sx + 0.0002*WheelDelta;
    rot:=false;
    InvalidateRect(Handle, nil, False);
  end;
end;

procedure TForm7.FormMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if b then b:= not b;
end;

procedure TForm7.FormMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  if b then
  begin
    ry:=-a.x+x;
    rx:=-a.y+y;
    a.x:=x;
    a.y:=y;
    module:=sqrt(sqr(rx)+sqr(ry));
    rx:=rx/module;
    ry:=ry/module;
    InvalidateRect(Handle, nil, False);
  end;
end;

procedure TForm7.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button = mbLeft then
   begin
     a.x:=x;
     a.Y:=y;
     b:=not b;
   end;
end;

procedure TForm7.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  glDeleteLists(SURFACE, 1);
{  if Form1.ProgaSys.axes then
    glDeleteLists(AXES, 1);}
end;

procedure TForm7.InitModel(var p: TRealArray; var mask: TBtArr; w, h: integer);
var i, j, minx, miny, maxx, maxy, m, n: integer;
    norm: T3dPoint;
    R, G, B: GLfloat;
begin
  AreaBounds(mask, w, h, minx, miny, maxx, maxy);
  m:=maxy-miny+1;
  n:=maxx-minx+1;

  with form1 do
  begin
   q:=cfg.q; //разрешение
   sx:=0.7; //масштаб
//   if cfg.input = 1 then
     k:=(cfg.h1/h + cfg.w1/w)/2;
//   else
//     k:=(cfg.h2/unwrap.h + cfg.w2/unwrap.w)/2;
  ampz:=cfg.z;
  end;
  rot:=true;
  rx:=0.0;
  ry:=0.0;
  dimx:=n*k;
  dimy:=m*k;
  FindMin_Max(min, max, p, mask, w, h);
  dimz:=ampz*(max-min);
  tempdim:=sqrt(sqr(dimx)+sqr(dimy)+sqr(dimz));
{  if Form3.ListView1.ItemIndex = 0 then
    mode:= mdInt
  else
  begin
    if Form3.tpanel11.Palette = ColorPalette then
      mode:=mdColor
    else
      mode:=mdGrey;
  end;}
  mode:=Tmode(cfg.pal); //режим разукрашивания
{  if Form1.ProgaSys.axes then
  begin
   glNewList(AXES, GL_COMPILE);
   glColor3f(0,0,0);
   glBegin(GL_LINES);
     glVertex3f(0,0,-dimz/2);
     glVertex3f(0.5+dimx,0,-dimz/2);
     glVertex3f(0,0,-dimz/2);
     glVertex3f(0,0.5+dimy,-dimz/2);
     glVertex3f(0,0,-dimz/2);
     glVertex3f(0,0,dimz/2+0.5);
   glEnd;
   glRasterPos3f(dimx+1, 0, -dimz/2);
   OutText('X');
   glRasterPos3f(0, 1+dimy, -dimz/2);
   OutText('Y');
   glRasterPos3f(0, 0, dimz/2+1);
   OutText('Z');
   glRasterPos3f(-0.3,-0.3,-dimz/2-0.3);
   OutText('0');
   glRasterPos3f(dimx,-0.5,-dimz/2-0.5);
   OutText(PChar(FloatToStrF(dimx,ffExponent, 3, 2)));
   glRasterPos3f(-0.5,dimy,-dimz/2-0.5);
   OutText(PChar(FloatToStrF(dimy,ffExponent, 3, 2)));
   glRasterPos3f(-0.5,-0.5,dimz/2);
   OutText(PChar(FloatToStrF(dimz/ampz,ffExponent, 3, 2)));

   glBegin(GL_POINTS);
     glVertex3f(0,0,-dimz/2);
     glVertex3f(dimx,0,-dimz/2);
     glVertex3f(0,dimy,-dimz/2);
     glVertex3f(0,0, dimz/2);
   glEnd;
   glEndList;
  end;}
  glNewList(SURFACE, GL_COMPILE);
   for i:=0 to (m div q)-2 do
     for j:=0 to (n div q)-2 do
       if (mask[(i*q+miny)*w+j*q+minx]=1) and (mask[(q*(i+1)+miny)*w+q*j+minx]=1) and (mask[(q*i+miny)*w+q*(j+1)+minx]=1) and (mask[(q*(i+1)+miny)*w+q*(j+1)+minx]=1) then
       begin
       glBegin(GL_TRIANGLES);
         GetNormal(q*(j+1)*k, (m-i*q)*k, ampz*p[(q*i+miny)*w+q*(j+1)+minx], q*j*k, (m-q*(i+1))*k, ampz*p[(q*(i+1)+miny)*w+q*j+minx], q*j*k, (m-i*q)*k, ampz*p[(q*i+miny)*w+q*j+minx], norm);
         glNormal3f(-norm.x, -norm.y, -norm.z);
         GetColour((p[(q*i+miny)*w+q*j+minx]-min)/(max-min) ,R, G, B, i*q+miny, j*q+minx, w, h);
         glColor3f(R, G, B);
         glVertex3f(j*q*k,(m-i*q)*k,ampz*p[(i*q+miny)*w+j*q+minx]);
         GetColour((p[(q*(i+1)+miny)*w+q*j+minx]-min)/(max-min) ,R, G, B, i*q+miny, j*q+minx, w, h);
         glColor3f(R, G, B);
         glVertex3f(q*j*k,(m-q*(i+1))*k,ampz*p[(q*(i+1)+miny)*w+q*j+minx]);
         GetColour((p[(q*i+miny)*w+q*(j+1)+minx]-min)/(max-min) ,R, G, B, i*q+miny, j*q+minx, w, h);
         glColor3f(R, G, B);
         glVertex3f(q*(j+1)*k,(m-i*q)*k,ampz*p[(q*i+miny)*w+q*(j+1)+minx]);

         GetNormal(q*(j+1)*k, (m-q*i)*k, ampz*p[(q*i+miny)*w+q*(j+1)+minx], q*(j+1)*k, (m-q*(i+1))*k, ampz*p[(q*(i+1)+miny)*w+q*(j+1)+minx], q*j*k, (m-q*(i+1))*k, ampz*p[(q*(i+1)+miny)*w+q*j+minx], norm);
         glNormal3f(-norm.x, -norm.y, -norm.z);
         glVertex3f(q*(j+1)*k,(m-q*i)*k,ampz*p[(q*i+miny)*w+q*(j+1)+minx]);
         GetColour((p[(q*(i+1)+miny)*w+q*j+minx]-min)/(max-min) ,R, G, B, i*q+miny, j*q+minx, w, h);
         glColor3f(R, G, B);
         glVertex3f(q*j*k,(m-q*(i+1))*k,ampz*p[(q*(i+1)+miny)*w+q*j+minx]);
         GetColour((p[(q*(i+1)+miny)*w+q*(j+1)+minx]-min)/(max-min) ,R, G, B, i*q+miny, j*q+minx, w, h);
         glColor3f(R, G, B);
         glVertex3f(q*(j+1)*k,(m-q*(i+1))*k,ampz*p[(q*(i+1)+miny)*w+q*(j+1)+minx]);
       glEnd;
       end;
 glEndList;
 FormResize(Self);
end;

procedure TForm7.InitModel(var p: TMyInfernalType);
var i, j, minx, miny, maxx, maxy, m, n: integer;
    norm: T3dPoint;
    R, G, B: GLfloat;
begin
 // AreaBounds(mask, w, h, minx, miny, maxx, maxy);
  m:=p.h_img;
  n:=p.w_img;
  minx:=p.x_img;
  miny:=p.y_img;

  with form1 do
  begin
   q:=cfg.q+1; //качество
   sx:=0.7; //масштаб
{   if cfg.input = 1 then
     k:=(cfg.h1/int.h + cfg.w1/int.w)/2
   else
     k:=(cfg.h2/int.h + cfg.w2/int.w)/2;}
   k:=cfg.scl_eye;
   ampz:=cfg.z/1000;
  end;
  rot:=true;
  rx:=0.0;
  ry:=0.0;
  dimx:=p.w_img*k;
  dimy:=p.h_img*k;

  min:=MaxInt; max:=-MaxInt;
  for i:=p.y_img to p.y_img+p.h_img-1 do
    for j:=p.x_img to p.x_img+p.w_img-1 do
    begin
      if min > p.a^[i*p.w+j] then min:=p.a^[i*p.w+j];
      if max < p.a^[i*p.w+j] then max:=p.a^[i*p.w+j];
    end;

  dimz:=ampz*(max-min);
  tempdim:=sqrt(sqr(dimx)+sqr(dimy)+sqr(dimz));
  case cfg.pal of
    0: mode:=mdGrey;
    1: mode:=mdColor;
    2: mode:=mdInt;
  end;

  max:=pnl.Top_Level;
  min:=pnl.Bottom_Level;

  glNewList(SURFACE, GL_COMPILE);
   for i:=0 to (m div q)-2 do
     for j:=0 to (n div q)-2 do
   //    if (mask[(i*q+miny)*w+j*q+minx]=1) and (mask[(q*(i+1)+miny)*w+q*j+minx]=1) and (mask[(q*i+miny)*w+q*(j+1)+minx]=1) and (mask[(q*(i+1)+miny)*w+q*(j+1)+minx]=1) then
       begin
       glBegin(GL_TRIANGLES);
         GetNormal(q*(j+1)*k, (m-i*q)*k, ampz*p.a^[(q*i+miny)*p.w+q*(j+1)+minx], q*j*k, (m-q*(i+1))*k, ampz*p.a^[(q*(i+1)+miny)*p.w+q*j+minx], q*j*k, (m-i*q)*k, ampz*p.a^[(q*i+miny)*p.w+q*j+minx], norm);
         glNormal3f(-norm.x, -norm.y, -norm.z);
         GetColour((p.a^[(q*i+miny)*p.w+q*j+minx]-min)/(max-min) ,R, G, B, i*q+miny, j*q+minx, p.w, p.h);
         glColor3f(R, G, B);
         glVertex3f(j*q*k,(m-i*q)*k,ampz*p.a^[(i*q+miny)*p.w+j*q+minx]);
         GetColour((p.a^[(q*(i+1)+miny)*p.w+q*j+minx]-min)/(max-min) ,R, G, B, i*q+miny, j*q+minx, p.w, p.h);
         glColor3f(R, G, B);
         glVertex3f(q*j*k,(m-q*(i+1))*k,ampz*p.a^[(q*(i+1)+miny)*p.w+q*j+minx]);
         GetColour((p.a^[(q*i+miny)*p.w+q*(j+1)+minx]-min)/(max-min) ,R, G, B, i*q+miny, j*q+minx, p.w, p.h);
         glColor3f(R, G, B);
         glVertex3f(q*(j+1)*k,(m-i*q)*k,ampz*p.a^[(q*i+miny)*p.w+q*(j+1)+minx]);

         GetNormal(q*(j+1)*k, (m-q*i)*k, ampz*p.a^[(q*i+miny)*p.w+q*(j+1)+minx], q*(j+1)*k, (m-q*(i+1))*k, ampz*p.a^[(q*(i+1)+miny)*p.w+q*(j+1)+minx], q*j*k, (m-q*(i+1))*k, ampz*p.a^[(q*(i+1)+miny)*p.w+q*j+minx], norm);
         glNormal3f(-norm.x, -norm.y, -norm.z);
         glVertex3f(q*(j+1)*k,(m-q*i)*k,ampz*p.a^[(q*i+miny)*p.w+q*(j+1)+minx]);
         GetColour((p.a^[(q*(i+1)+miny)*p.w+q*j+minx]-min)/(max-min) ,R, G, B, i*q+miny, j*q+minx, p.w, p.h);
         glColor3f(R, G, B);
         glVertex3f(q*j*k,(m-q*(i+1))*k,ampz*p.a^[(q*(i+1)+miny)*p.w+q*j+minx]);
         GetColour((p.a^[(q*(i+1)+miny)*p.w+q*(j+1)+minx]-min)/(max-min) ,R, G, B, i*q+miny, j*q+minx, p.w, p.h);
         glColor3f(R, G, B);
         glVertex3f(q*(j+1)*k,(m-q*(i+1))*k,ampz*p.a^[(q*(i+1)+miny)*p.w+q*(j+1)+minx]);
       glEnd;
       end;
 glEndList;
 FormResize(Self);
end;

procedure TForm7.Button1Click(Sender: TObject);
var bmp: TBitmap;
 //   p2: PByteArray;
  //  i,j: integer;
    r: TRect;
begin
//  GetMem(p, Width*Height*3);
  r:=Canvas.ClipRect;
  bmp:=TBitmap.Create;
  bmp.Width:=r.Right-r.Left;
  bmp.Height:=r.Bottom-r.Top;
  bmp.PixelFormat:=pf24bit;
  BitBlt(bmp.Canvas.Handle, 0, 0, bmp.Width, bmp.Height, Canvas.Handle, 0, 0, SRCCOPY);
  bmp.SaveToFile('temp.bmp');
  bmp.Destroy;

//  FreeMem(p, Width*Height*3);
end;

end.
