unit calc;

interface

uses
  Classes, utype, it_mouth, Windows, OpenGL, Scanner, t666;

type
  TMouthThread = class(TThread)
  public
    recMode: (rmSingle, rmMulti);
  private
    mm: byte;
    pbaMask: array [1..3] of PByteArray;
    praTemp: array [0..5] of PRealArray;
    pcaOut: array [1..3] of PRealArray;
    pcaBase, pcaInt : PRealArray;
    w, h, pos: integer;
    ready: boolean;
    iComplexArraySize, iRealArraySize, iByteArraySize: integer;
  protected
      procedure Execute; override;
      procedure Stop_temp;
      procedure Draw;
  published
  end;

  T3dPoint = record
               x,y,z: GLfloat;
             end;

procedure SetDCPixelFormat(hdc: HDC);
procedure GetNormal(x1, y1, z1, x2, y2, z2, x3, y3, z3: GLfloat; var  norm: T3dPoint);
procedure Enable_OpenGL;
procedure SetPort_OpenGL;
procedure Disable_OpenGL;
procedure Draw_OpenGl;
function CallBack(percent: integer; pContext: pointer): integer;
procedure Rotate(var p, b: TMyInfernalType);

var MouthThread: TMouthThread;

implementation

uses UIntPrepare, Dialogs, unit1, UIntReconstruct, Ufft, UCATool,
     UMask, UUnwrap, UPhsRecn, URATool, UVarWinF, UPhsToH, UFiltr, ini_file,
     SysUtils, Controls, UFileZRW, ComCtrls, ImgList, UForm_Prog, crude, forms, panel1,
     UShow3DForm;

{ TMouthThread }

procedure GetNormal(x1, y1, z1, x2, y2, z2, x3, y3, z3: GLfloat; var  norm: T3dPoint);
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

procedure SetDCPixelFormat(hdc: HDC);
var
 pfd: TPixelFormatDescriptor;
 nPixelFormat : Integer;
begin
 FillChar(pfd, SizeOf (pfd), 0);
 pfd.dwFlags:=PFD_DRAW_TO_WINDOW or PFD_SUPPORT_OPENGL or PFD_DOUBLEBUFFER;
 nPixelFormat:=ChoosePixelFormat (hdc, @pfd);
 SetPixelFormat(hdc, nPixelFormat, @pfd);
end;


procedure TMouthThread.Draw;
var i: integer;
    s: string;
begin
  case mm of
    1: begin
         with form1 do
         begin
           //ready:=false;
           Form_Prog.Close;



           {Show3DForm.Width:=pnl.Width;
           Show3DForm.Height:=pnl.Height;
           Show3DForm.Left:=pnl.Left+form1.Left+4;
           Show3DForm.Top:=pnl.Top+form1.Top+23;

           Show3DForm.InitModel(_res.a^, mask.b^, _res.w, _res.h);

           Show3DForm.Show;}
           lv[Items_Ind.y].Items[Items_Ind.x].SubItems[1]:='Yes';
           calc_run:=false;

           _on;

           {pnl.DrawMode:=dmNone;
           pnl.DrawMode:=dmOpenGL;
           pnl.InitOpenGL(_res, mask, RecParam.ax, 0.7, 0.2, 0.0, 3);
           AddBmp2List2(Items_Ind.y);
           lv[Items_Ind.y].Items[Items_Ind.x].ImageIndex:=il[Items_Ind.y].Count-1;
           lv[Items_Ind.y].Items[Items_Ind.x].SubItems[1]:='Yes';
           ArrayNum:=1;
           calc_run:=false;
          // pnl.ReleaseOpenGL;
           ready:=true;

            }


            // s:=lv[Items_Ind.y].Items[Items_Ind.x].SubItems[0];
           {Form_Prog.Close;}

           //lv[Items_Ind.y].Items[Items_Ind.x].Caption;
           {LoadBmp(_bmp, _pth[Items_Ind.y]+s+'.bmp', varDouble);
           for i:=0 to _w*_h-1 do
             _bmp.a^[i]:=_bmp.a^[i]/255;}




           //AddBmp2List(_res, Items_Ind.y);

           {il[Items_Ind.y].GetBitmap(lv[Items_Ind.y].Items[Items_Ind.x].ImageIndex, bmp);
           bmp.Canvas.StretchDraw(form1.Image1.Canvas.ClipRect, form1.Image1.Picture.Bitmap);
           il[Items_Ind.y].Replace(lv[Items_Ind.y].Items[Items_Ind.x].ImageIndex, bmp, nil);}





          (* for i:=0 to lv[Items_Ind.y].Items.Count-1 do
             if lv[Items_Ind.y].Items[i].ImageIndex = Items_Ind.x then
             begin
               s:=lv[Items_Ind.y].Items[i].Caption;
               {RASaveBinMask_with_Scale(_res.w, _res.h, 0, _res.w-1, 0, _res.h-1, recParam.f01,
               recParam.f01, _res.a^, mask.b^, save_pth[Items_Ind.y]+s+'.bin');}
               //pnl.DrawMode:=dmOpenGL;
               //pnl.InitOpenGL(_res, mask, recParam.f01);
               //AddBmp2List2(Items_Ind.y);



               {pnl.grab:=true;
               pnl.Repaint;
               pnl.grab:=false;}
               AddBmp2List2(Items_Ind.y);


               lv[Items_Ind.y].Items[i].ImageIndex:=il[Items_Ind.y].Count-1;
               lv[Items_Ind.y].Items[i].SubItems[1]:='Yes';
               Items_Ind.x:=il[Items_Ind.y].Count-1;
               break;
             end;
            *)


   //        pnl.DrawMode:=dmOpenGL;
     //      pnl.InitOpenGL(_res, mask, recParam.f01);
  //         pnl.DrawImage(_res, mask);
//           pnl.DrawMode:=

           {pnl.Repaint;
           Application.ProcessMessages;
           Enable_OpenGL;
           SetPort_OpenGL;
           Draw_OpenGl;
           Disable_OpenGL;}
         end;

       end;
     2: begin
          Form_Prog.pb.Position:=pos;
          {form1.pnl.SetProgress(pos);
          form1.pnl.Repaint;}
        end;
     3: begin
          //ready:=false;
          form1.pnl.DrawMode:=dmNone;
          PatBlt(form1.pnl.bitmap.Canvas.Handle, 0, 0, form1.pnl.bitmap.Width, form1.pnl.bitmap.Height, BLACKNESS);
          form1.pnl.DrawMode:=dmSprite;
          form1.pnl.SetProgress(0);
          form1.pnl.SetSpriteText('Bundle Reconstruction');
          form1.pnl.Repaint;
          form1._off;
          calc_run:=true;
          {with Form_Prog do
          begin
            pb.Position:=0;
            lb.Caption:='Bundle Reconstruction';
            Show;
          end;}
          ready:=true;
        end;
     4: begin
          //form1._on;
          //Form_Prog.FormStyle:=fsNormal;
          //Form_Prog.Close;

        end;
  end;
{}
end;

procedure Enable_OpenGL;
var min, max, k: treal;
begin
  dc:=GetDC(form1.pnl.Handle);
  SetDCPixelFormat(dc);
  hrc:=wglCreateContext(dc);
  wglMakeCurrent(dc,hrc);
  FindMin_Max(min, max, _res.a^, mask.b^, _res.w, _res.h);
  k:=RecParam.ax;
  dimx:=_res.w*k;
  dimy:=_res.h*k;
  dimz:=max-min;
  _dim:=sqrt(sqr(dimx)+sqr(dimy)+sqr(dimz));
  glClearColor(1.0, 1.0, 1.0, 1.0);
  glEnable(GL_DEPTH_TEST);
  glEnable(GL_LIGHTING);
  glEnable(GL_LIGHT0);
  glLightModelf(GL_LIGHT_MODEL_TWO_SIDE, 1);
  glEnable(GL_COLOR_MATERIAL);
end;

procedure SetPort_OpenGL;
var _w,_h: integer;
begin
  _w:=form1.pnl.Width;
  _h:=form1.pnl.Height;
  glViewport(0, 0, _w, _h);
  glMatrixMode(GL_PROJECTION);
  glLoadIdentity;
  if _w/_h >= dimx/dimy then
   glOrtho(-_w/_h*dimy/2, _w/_h*dimy/2, -dimy/2, dimy/2, -_dim/2, _dim/2)
  else
   glOrtho(-dimx/2, dimx/2, -_h/_w*dimx/2, _h/_w*dimx/2, -_dim/2, _dim/2);

//  glTranslatef(0.0, 0.0, -(max+min));
  glMatrixMode(GL_MODELVIEW);
  glLoadIdentity;
end;

procedure Draw_OpenGl;
var h, w, i, j: integer;
    norm: T3dPoint;
    k: treal;
begin
    k:=RecParam.ax;
    h:=_res.h;
    w:=_res.w;
    glClear(GL_COLOR_BUFFER_BIT or GL_DEPTH_BUFFER_BIT);
    glPushMatrix;
    glTranslatef(-dimx/2, -dimy/2, 0);
    glColor3f(0.75, 0.75, 0.75);
      for i:=0 to h-1 do
        for j:=0 to w-1 do
          if (mask.b^[i*w+j]=1) and (mask.b^[(i+1)*w+j]=1) and (mask.b^[i*w+j+1]=1) and (mask.b^[(i+1)*w+j+1]=1) then
          begin
            glBegin(GL_TRIANGLES);
              GetNormal((j+1)*k, (h-i)*k, _res.a^[i*w+j+1], j*k, (h-(i+1))*k, _res.a^[(i+1)*w+j], j*k, (h-i)*k, _res.a^[i*w+j], norm);
              glNormal3f(-norm.x, -norm.y, -norm.z);
              glVertex3f(j*k,(h-i)*k,_res.a^[i*w+j]);
              glVertex3f(j*k,(h-(i+1))*k,_res.a^[(i+1)*w+j]);
              glVertex3f((j+1)*k,(h-i)*k,_res.a^[i*w+j+1]);
              GetNormal((j+1)*k, (h-i)*k, _res.a^[i*w+j+1], (j+1)*k, (h-(i+1))*k, _res.a^[(i+1)*w+j+1], j*k, (h-(i+1))*k, _res.a^[(i+1)*w+j], norm);
              glNormal3f(-norm.x, -norm.y, -norm.z);
              glVertex3f((j+1)*k,(h-i)*k,_res.a^[i*w+j+1]);
              glVertex3f(j*k,(h-(i+1))*k,_res.a^[(i+1)*w+j]);
              glVertex3f((j+1)*k,(h-(i+1))*k,_res.a^[(i+1)*w+j+1]);
            glEnd;
          end;
    glPopMatrix;
  SwapBuffers(dc);  
end;

procedure Disable_OpenGL;
begin
  wglMakeCurrent(0,0);
  wglDeleteContext(hrc);
  ReleaseDC(form1.pnl.Handle, dc);
  DeleteDC(dc);
end;

procedure TMouthThread.Execute;
var
  i, x, y: Integer;
  LoadPath, LoadName, SavePath: string;
begin
  inherited;

  case recMode of
    rmSingle: begin
                LoadPath:=_pth[Items_Ind.y];//ExtractFilePath(Form1.lv[Items_Ind.y].Items[Items_Ind.x].SubItems[0]);
                LoadName:=Form1.lv[Items_Ind.y].Items[Items_Ind.x].SubItems[0]; //ExtractFileName(Form1.lv[Items_Ind.y].Items[Items_Ind.x].SubItems[0]);
                SavePath:=save_pth[Items_Ind.y];

                case VidCapParam.Mode of
                  0: begin
                       _res.Clear;
                       mask.Clear;
                       _res.Init(VidCapParam.Height, VidCapParam.Width, varDouble);
                       mask.Init(VidCapParam.Height, VidCapParam.Width, varByte);

                       TS_Reconstruct(idRec, _res.a, mask.b, PChar(LoadPath), PChar(LoadName), PChar(SavePath), PChar(LoadName), nil);
                       Rotate(_res, mask);
                     end;
                  1: begin
                       TS_ReconstructPhShift(idRec, PChar(LoadPath), PChar(LoadName), PChar(SavePath), PChar(LoadName));
                       LoadBin(_res, mask, SavePath+LoadName+'.bin');
                     end;
                end;
                mm:=1;
                Synchronize(Draw);
              end;
    rmMulti: begin
               for i:=0 to form1.lv[shotmode].Items.Count-1 do
                 if form1.lv[shotmode].Items[i].SubItems[1] = 'No' then
                 begin
                   {mm:=3;
                   Synchronize(Draw);
                   repeat
                     sleep(100);
                   until ready;}
                   LoadPath:=_pth[shotmode];
                   LoadName:=Form1.lv[shotmode].Items[i].SubItems[0];
                   SavePath:=save_pth[shotmode];
                   _res.Clear;
                   mask.Clear;
                   _res.Init(VidCapParam.Height, VidCapParam.Width, varDouble);
                   mask.Init(VidCapParam.Height, VidCapParam.Width, varByte);
                   TS_Reconstruct(idRec, _res.a, mask.b, PChar(LoadPath), PChar(LoadName), PChar(SavePath), PChar(LoadName), nil);
                   Rotate(_res, mask);
                   Items_Ind.y:=shotmode;
                   Items_Ind.x:=i;
                   mm:=1;
                   Synchronize(Draw);
                   {repeat
                     sleep(100);
                   until ready;}
                 end;
             end;
  end;

 { mm:=2;
  w:=int[0].w;
  h:=int[0].h;
  iComplexArraySize:=2*w*h*SizeOf(TReal);
  iRealArraySize:=w*h*SizeOf(TReal);
  iByteArraySize:=w*h;
  GetMem(pcaInt, iComplexArraySize);
  GetMem(pcaBase, iComplexArraySize);
  for i:=0 to 5 do
    GetMem(praTemp[i], iRealArraySize);
  for i:=1 to 3 do
    GetMem(pbaMask[i], iByteArraySize);
  for i:=1 to 3 do
    GetMem(pcaOut[i], iComplexArraySize);
  // Восстанавливаем первый ракурс
  // Предобработка
  IntPrepare(w, h, int[0].b^, int[1].b^, base[0].b^, base[1].b^, mask.b^,
    praTemp[1]^, praTemp[2]^, praTemp[3]^, praTemp[4]^, recParam.b32,
    recParam.b02, recParam.b40, recParam.b43,
    recParam.i02, recParam.i40);
  pos:=10;
  Synchronize(Draw);
  // Восстанавливаем
  IntReconstruct(w, h, praTemp[1]^, praTemp[2]^, praTemp[3]^, praTemp[4]^,
    praTemp[0]^, praTemp[1]^, praTemp[2]^, praTemp[3]^, praTemp[4]^, praTemp[5]^,
    pcaInt^, pcaBase^, pcaOut[1]^, pbaMask[1]^, recParam.i04 = 0,
    recParam.i07 = 1, recParam.b39, recParam.b41,
    recParam.i02 = 1, recParam.f04, recParam.f05);
  pos:=30;
  Synchronize(Draw);
  // Восстанавливаем второй ракурс
  // Предобработка
  IntPrepare(w, h, int[0].b^, int[2].b^, base[0].b^, base[2].b^, mask.b^,
    praTemp[1]^, praTemp[2]^, praTemp[3]^, praTemp[4]^, recParam.b32,
    recParam.b02, recParam.b40, recParam.b43,
    recParam.i02, recParam.i40);
  pos:=45;
  Synchronize(Draw);
  // Восстанавливаем
  IntReconstruct(w, h, praTemp[1]^, praTemp[2]^, praTemp[3]^, praTemp[4]^,
    praTemp[0]^, praTemp[1]^, praTemp[2]^, praTemp[3]^, praTemp[4]^, praTemp[5]^,
      pcaInt^, pcaBase^, pcaOut[2]^, pbaMask[2]^, recParam.i05 = 0,
      recParam.i07 = 1, recParam.b39, recParam.b41,
      recParam.i02 = 1, recParam.f04, recParam.f05);
  pos:=60;
  Synchronize(Draw);
  // Фурье синтез для 2 ракурсов
  CAMiddle(w, h, pcaOut[1]^, pcaOut[2]^, pcaOut[1]^);
  BAAnd2(w, h, pbaMask[1]^, pbaMask[2]^, pbaMask[1]^);
  Complex2RealArray(w, h, pcaOut[1]^, praTemp[0]^, 8, True);
  for i:=0 to w*h-1 do
     praTemp[1]^[i]:=mask.b^[i];
  // Сшиваем
  if recParam.b03 then
  begin
    // Выбираем точку начала сшивки
    FindMaskCenter(w, h, praTemp[1]^, x, y);
    // Увеличиваем маску, чтобы исбавиться от краевого эффекта
    if recParam.b01 then
      GroWMask(w, h, praTemp[1]^, praTemp[1]^,(recParam.i39 div 2) + 1);
    UnwrapPhaseMask(w, h, x, y, praTemp[0]^, praTemp[1]^, praTemp[2]^);
    RAFillMask(w, h, praTemp[2]^, praTemp[1]^, recParam.i45);
    CopyMemory(praTemp[0], praTemp[2], w*h*SizeOf(TReal));
  end;
  pos:=75;
  Synchronize(Draw);
  // Сдвигаем фазу
  if recParam.b37 then
    ShiftPhase(w, h, praTemp[0]^, praTemp[1]^, praTemp[0]^);
  // Нелинейная фильтрация
  if recParam.b05 then
  begin
    RAFiltLinearVarWind(w, h, praTemp[0]^, praTemp[0]^, praTemp[3]^,
      praTemp[3]^, praTemp[3]^, praTemp[3]^, praTemp[1]^, 10);
    RAFillMask(w, h, praTemp[0]^, praTemp[1]^, recParam.i45);
  end;
  // Фильтруем по гауссу
  if recParam.b42 then
  begin
    RAFilterGaussianMaskOutBad(w, h, recParam.i39, recParam.i39 div 2, praTemp[0]^, praTemp[1]^, praTemp[0]^);
    RAFillMask(w, h, praTemp[0]^, praTemp[1]^, recParam.i45);
  end;
  // Фильтруем медианной
  if recParam.b04 then begin
    RAFilterMedianSqrMask(w, h, recParam.i09, praTemp[0]^, praTemp[0]^, praTemp[1]^);
    RAFillMask(w, h, praTemp[0]^, praTemp[1]^, recParam.i45);
  end;
  pos:=90;
  Synchronize(Draw);
  // Восстанавливаем неувеличенную маску
  if recParam.b01 then
  begin
   for i:=0 to w*h-1 do
     praTemp[1]^[i]:=mask.b^[i];
   RAFillMask(w, h, praTemp[0]^, praTemp[1]^, recParam.i45);
  end;
  // Переводим в мм
  if recParam.b06 then
  begin
    PhaseToHeightArray(w, h, _k[0].a^, _k[1].a^, _k[2].a^, praTemp[0]^, praTemp[0]^);
    RAFillMask(w, h, praTemp[0]^, praTemp[1]^, recParam.i45);
  end;
  // Трансформация
  if recParam.b07 then
  begin
    TransformHeightMask(w, h, recParam.f01, recParam.f02, praTemp[0]^, praTemp[1]^, praTemp[2]^, praTemp[3]^);
    RAFillMask(w, h, praTemp[2]^, praTemp[3]^, recParam.i45);
    for i:=0 to w*h-1 do
      mask.b^[i]:=round(praTemp[3]^[i]);
    CopyMemory(praTemp[0], praTemp[2], w*h*SizeOf(TReal));
    CopyMemory(praTemp[1], praTemp[3], w*h*SizeOf(TReal));
  end;
  pos:=100;
  Synchronize(Draw);
  // Обрезаем по краю маски
  if recParam.b08 then begin
    RiseMask(w, h, praTemp[1]^, praTemp[1]^, recParam.i11);
   RAFillMask(w, h, praTemp[0]^, praTemp[1]^, recParam.i45);
   for i:=0 to w*h-1 do
      mask.b^[i]:=round(praTemp[1]^[i]);
  end;
  // вращение
  case recParam.i37 of
    2: begin
         RARotate180(w, h, praTemp[0]^);
         RARotate180(w, h, praTemp[1]^);
         for i:=0 to w*h-1 do
           mask.b^[i]:=round(praTemp[1]^[i]);
       end;
  end;
  // отражение
  case recParam.i38 of
    1: begin
         RAMirrorX(w, h, praTemp[0]^);
         RAMirrorX(w, h, praTemp[1]^);
         for i:=0 to w*h-1 do
           mask.b^[i]:=round(praTemp[1]^[i]);
       end;
    2: begin
         RAMirrorY(w, h, praTemp[0]^);
         RAMirrorY(w, h, praTemp[1]^);
         for i:=0 to w*h-1 do
           mask.b^[i]:=round(praTemp[1]^[i]);
       end;
  end;
  
  _res.Clear;
  _res.Init(h, w, varDouble);
  CopyMemory(_res.a, praTemp[0], w*h*SizeOf(TReal));

  FreeMem(pcaInt, iComplexArraySize);
  FreeMem(pcaBase, iComplexArraySize);
  for i:=0 to 5 do
    FreeMem(praTemp[i], iRealArraySize);
  for i:=1 to 3 do
    FreeMem(pbaMask[i], iByteArraySize);
  for i:=1 to 3 do
    FreeMem(pcaOut[i], iComplexArraySize);

  mm:=1;
  Synchronize(Draw); }
end;

procedure TMouthThread.Stop_temp;
var i: integer;
begin
  FreeMem(pcaInt, iComplexArraySize);
  FreeMem(pcaBase, iComplexArraySize);
  for i:=0 to 5 do
    FreeMem(praTemp[i], iRealArraySize);
  for i:=1 to 3 do
    FreeMem(pbaMask[i], iByteArraySize);
  for i:=1 to 3 do
    FreeMem(pcaOut[i], iComplexArraySize);
 

end;

function CallBack(percent: integer; pContext: pointer): integer;
begin
  MouthThread.mm:=2;
  MouthThread.pos:=percent;
  MouthThread.Synchronize(MouthThread.Draw);
end;

procedure Rotate(var p, b: TMyInfernalType);
var i, j, w, h, w1, h1, tmp: integer;
    _p, _b: TMyInfernalType;
begin
  w:=p.w;
  h:=p.h;
  _p:=TMyInfernalType.Create;
  _b:=TMyInfernalType.Create;
  _p.Init(w, h, varDouble);
  _b.Init(w, h, varByte);
  h1:=w-1;
  w1:=h-1;
  for i:=0 to h1 do
    for j:=0 to w1 do
    begin
      if VidCapParam.Rotate = 0 then
        tmp:={(w1-j)}j*w+h1-i
      else
        tmp:=j*w+i;
      if b.b^[tmp] = 1 then
      begin
        _b.b^[i*h+j]:=1;
        _p.a^[i*h+j]:=p.a^[tmp];
      end;
    end;
  p.Clear;
  b.Clear;
  p.InitByArray(_p);
  b.InitByArray(_b);
  _p.Destroy;
  _b.Destroy;
end;

end.
