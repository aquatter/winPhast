unit UPhast2Vars;

interface

uses t666, panel1, utype, windows, VidCap, UProjectData;

type
TConfig = record
     steps, mean, input, q, pal: byte;
     scl_photo, scl_eye, lambda: TReal;
     w2, h2: integer;
     z: treal;
     w1, h1: treal;
     tilt, base, invert, do_seq, do_mean, do_step, do_gauss: boolean;
     x_left, x_top, y_left, y_top, legend_left, legend_top: integer;
     slice_left, slice_top: integer;
     path: string;
     m_shift: integer;
     transp: integer;
     amp, expos: UINT;
     img_path: string;
     base_path: string;
     capture_left, capture_top: integer;
     port: word;
     int_filtr, save_bmp_int: boolean;
     cam_w, cam_h: integer;
     poly_order, num_seq, num_mean, num_skip: byte;
     step_height: treal;
     do_filtr: boolean;
     do_unwrap: boolean;
     do_phase2z: boolean;
     gauss_aper: treal;
     gauss_cut_off: treal;
     _f, _t, _p, b_ref, b_rab, n_ref: treal;
     img_path_izm: string;
     CameraType: string;
     DeviceNum: integer;
     LazerNum: integer;
     LazerPos: array[0..2] of integer;
     Shifts: array[0..2] of integer;
     LazerLambda: array[0..2] of treal;
     ComPort: integer;
     ComMode: boolean;
     Com_phase_shift: boolean;
     Com_Step_Motor: boolean;
     Step_Motor_Shift: integer;
     Step_Motor_Curr_Pos: integer;
     n_photo: treal;
     SaveAS: integer;
     SavePath: string;
     TiltMask: integer;
     UnwrapPhaseSeparately: boolean;
     FinalMaskFullScreen: boolean;
     SeriesPause: integer;
     PhaseShiftPause: integer;
     AverageSerie: boolean;
     SaveOnlyMaskedArea: boolean;
     Fizo: boolean;
     Fizo_Frames: integer;
     Fizo_pedestal: integer;
     Fizo_amp: integer;
     Fizo_t: integer;
     r, r0, r1: integer;
     how_many_wavelengths: integer;

  end;

const
  WP_SAVE_AMPLITUDE =         1;
  WP_SAVE_PHASE =             2;
  WP_SAVE_UNWRAP =            4;
  WP_SAVE_BMP =               8;
  WP_SAVE_MATLAB =            16;
  WP_SAVE_TXT =               32;
  WP_SAVE_BIN =               64;


procedure GaussHighPass(var p: TMyInfernalType);
procedure SetBit(var b: byte; m: integer);
procedure ResetBit(var b: byte; m: integer);
function LowByte(b: word): byte;
function HiByte(b: word): byte;
function TestVideoScan: boolean;
procedure SaveAS; overload;
procedure SaveAS(name: string); overload;
function GetCurrentMask: PMyInfernalType;
procedure SaveData2Txt(var p, m: TMyInfernalType; name: string);
function CheckMask(var mask: TMyInfernalType; p: PPoint = nil): boolean;

var
  amp, int, phase, unwrap, _mask, final_mask, final_phase, mask_inner, mask_outer: TMyInfernalType;
  phase_exp1, phase_exp2, super_lunka, buff: TMyInfernalType;
  tilt1, tilt2: TMyInfernalType;
  Fizo_Steps: TMyInfernalType;
  pnl: tpanel1;
  CurrentMatrix: (cmInt, cmPhase, cmUnwrap, cmAmp, cmVideo_);
  CurrentMask: (cmMask1, cmMask2, cmFinal);
  from: (fromCamera, fromHDD);
  TraceLinesMode: (tlmRZ, tlmH);
  razn, _rms, _pv: treal;
  Origin: TPoint;
  Origin01, Origin02: TPoint;
  _origin, mask_b: boolean;
  vol1, vol2, vol3, n_vol: treal;
  cfg: tconfig;
//  do_step: boolean;
  VidCap1: TVidCap;
  _buff: array[0..4] of byte;
  ComEvent, ComInit: THandle;
  DataReady_Average: THandle;
  CurrentNum_Average: integer;
  ComConnected, ComEnabled: boolean;
  LazPos: integer;
  VideoScanEnabled: boolean;
  ProjectData: TProjectData;

implementation

uses ufft, math, VideoScan, crude;

procedure GaussHighPass(var p: TMyInfernalType);
var plan: pointer;
    w, h, i,j, w0, h0, norm, ind: integer;
    A, B, _a, lc, q: treal;
    fft1, fft2: TMyInfernalType;

function Gauss(x, y, A, B: treal): treal;
begin
  Result:=A*exp(B*(sqr(x)+sqr(y)));
end;

begin
  w:=p.w;
  h:=p.h;
  w0:=w div 2;
  h0:=h div 2;
  norm:=w*h;
  _a:=sqrt(Ln(2)/pi);
  lc:=cfg.gauss_cut_off/cfg.scl_eye;
  A:=1/sqr(_a*lc);
  B:=-pi*A;

  fft1:=TMyInfernalType.Create;
  fft1.Clear;
  fft1.Init(h, 2*w, varDouble);
  fft2:=TMyInfernalType.Create;
  fft2.Clear;
  fft2.Init(h, 2*w, varDouble);

  for i:=0 to h-1 do
    for j:=0 to w-1 do
    begin
      ind:=i*w+j;
      fft1.a^[2*ind]:=p.a^[ind];
      fft2.a^[2*ind]:=Gauss(i-h0, j-w0, A, B);
    end;

  plan:=fftw_plan_dft_2d(h, w, fft1.a, fft1.a, FFTW_FORWARD, FFTW_ESTIMATE);
  fftw_execute(plan);
  fftw_destroy_plan(plan);

  plan:=fftw_plan_dft_2d(h, w, fft2.a, fft2.a, FFTW_FORWARD, FFTW_ESTIMATE);
  fftw_execute(plan);
  fftw_destroy_plan(plan);

  for i:=0 to h-1 do
    for j:=0 to w-1 do
    begin
      ind:=i*w+j;
      q:=Power(-1, i+j);
      a:=fft1.a^[2*ind]*fft2.a^[2*ind]-fft1.a^[2*ind+1]*fft2.a^[2*ind+1];
      b:=fft1.a^[2*ind]*fft2.a^[2*ind+1]+fft2.a^[2*ind]*fft1.a^[2*ind+1];
      fft2.a^[2*ind]:=a*q;
      fft2.a^[2*ind+1]:=b*q;
    end;

  plan:=fftw_plan_dft_2d(h, w, fft2.a, fft2.a, FFTW_BACKWARD, FFTW_ESTIMATE);
  fftw_execute(plan);
  fftw_destroy_plan(plan);

  for i:=0 to h-1 do
    for j:=0 to w-1 do
    begin
      ind:=i*w+j;
      p.a^[ind]:=p.a^[ind]-fft2.a^[2*ind]/norm;
    end;

  fft1.Destroy;
  fft2.Destroy;
end;

procedure SetBit(var b: byte; m: integer);
var t: byte;
begin
 t:=1 shl m;
 b:=b or t;
end;

procedure ResetBit(var b: byte; m: integer);
var t: byte;
begin
  t:=$FF-(1 shl m);
  b:=b and t;
end;

function LowByte(b: word): byte;
begin
  Result:=b and $00FF;
end;

function HiByte(b: word): byte;
begin
  Result:=b shr 8;
end;

function TestVideoScan: boolean;
var err: VS_ERROR_DATA;
begin
   VsLib3Init(@(err));
   Result:= err.Id = 0;
end;

procedure SaveAS;
var i,j,k: integer;
    p, m: PMyInfernalType;
    s: string;
    minx, miny, maxx, maxy, w, h, w1: integer;
    temp_p, temp_m: TMyInfernalType;
begin
  m:=GetCurrentMask;
  if cfg.SaveOnlyMaskedArea then
  begin
    AreaBounds(m^.b^, m^.w, m^.h, minx, miny, maxx, maxy);
    w:=maxx-minx+1;
    h:=maxy-miny+1;
    temp_p:=TMyInfernalType.Create;
    temp_p.Init(h, w, varDouble);
    temp_m:=TMyInfernalType.Create;
    temp_m.Init(h, w, varByte);
    w1:=m^.w;
    for i:=miny to maxy do
      for j:=minx to maxx do
        temp_m.b^[(i-miny)*w+j-minx]:=m^.b^[i*w1+j];


    for k:=0 to 2 do
    begin
     if not boolean(round(Power(2,k)) and cfg.SaveAS) then
       continue;

     case k of
       0: begin
            p:=@(amp);
            s:='_amp';
          end;
       1: begin
            p:=@(phase);
            s:='_wphase';
          end;
       2: begin
            p:=@(final_phase);
            s:='_phase';
          end;
     end;

     if not p^.loaded then
       continue;

     for i:=miny to maxy do
       for j:=minx to maxx do
         if m^.b^[i*w1+j]=1 then
           temp_p.a^[(i-miny)*w+j-minx]:=p^.a^[i*w1+j];


     if boolean(cfg.SaveAS and WP_SAVE_BMP) then
       CreateBmp(temp_p, temp_m, true, cfg.SavePath+s+'.bmp');

     if boolean(cfg.SaveAS and WP_SAVE_MATLAB) then
       SaveRealArray2Matlab(temp_p, 1, cfg.SavePath+s+'.m');

     if boolean(cfg.SaveAS and WP_SAVE_TXT) then
       SaveData2Txt(temp_p, temp_m, cfg.SavePath+s+'.txt');

     if boolean(cfg.SaveAS and WP_SAVE_BIN) then
       CreateBin(temp_p, temp_m, cfg.SavePath+s+'.bin');
    end;



    temp_p.Destroy;
    temp_m.Destroy;
    exit;
  end;


  for i:=0 to 2 do
  begin
   if not boolean(round(Power(2,i)) and cfg.SaveAS) then
     continue;

   case i of
     0: begin
          p:=@(amp);
          s:='_amp';
        end;
     1: begin
          p:=@(phase);
          s:='_phase';
        end;
     2: begin
          p:=@(final_phase);
          s:='_result';
        end;
   end;

   if not p^.loaded then
     continue;

   if boolean(cfg.SaveAS and WP_SAVE_BMP) then
     CreateBmp(p^, m^, true, cfg.SavePath+s+'.bmp');

   if boolean(cfg.SaveAS and WP_SAVE_MATLAB) then
     SaveRealArray2Matlab(p^, 1, cfg.SavePath+s+'.m');

   if boolean(cfg.SaveAS and WP_SAVE_TXT) then
     SaveData2Txt(p^, m^, cfg.SavePath+s+'.txt');

   if boolean(cfg.SaveAS and WP_SAVE_BIN) then
     CreateBin(p^, m^, cfg.SavePath+s+'.bin');
  end;
end;

procedure SaveAS(name: string); overload;
var i: integer;
    p, m: PMyInfernalType;
    s: string;
begin
  m:=GetCurrentMask;
  for i:=0 to 2 do
  begin
   if not boolean(round(Power(2,i)) and cfg.SaveAS) then
     continue;

   case i of
     0: begin
          p:=@(amp);
          s:='_amp';
        end;
     1: begin
          p:=@(phase);
          s:='_phase';
        end;
     2: begin
          p:=@(unwrap);
          s:='_result';
        end;
   end;

   if not p^.loaded then
     continue;

   if boolean(cfg.SaveAS and WP_SAVE_BMP) then
     CreateBmp(p^, m^, true, name+s+'.bmp');

   if boolean(cfg.SaveAS and WP_SAVE_MATLAB) then
     SaveRealArray2Matlab(p^, 1, name+s+'.m');

   if boolean(cfg.SaveAS and WP_SAVE_TXT) then
     SaveData2Txt(p^, m^, name+s+'.txt');

   if boolean(cfg.SaveAS and WP_SAVE_BIN) then
     CreateBin(p^, m^, name+s+'.bin');
  end;
end;

procedure SaveData2Txt(var p, m: TMyInfernalType; name: string);
var s: string;
    f: TextFile;
    i,j,w,h: integer;
begin
  AssignFile(f, name);
  Rewrite(f);

  w:=p.w;
  h:=p.h;
  if p <> m then
    for i:=0 to h-1 do
    begin
      for j:=0 to w-1 do
        if m.b^[i*w+j]=1 then
          write(f, p.a^[i*w+j]:8:5, ' ')
        else
          write(f, 0.0, ' ');
     writeln(f);
    end
  else
    for i:=0 to h-1 do
    begin
      for j:=0 to w-1 do
        write(f, p.a^[i*w+j]:8:5, ' ');
      writeln(f);
    end;

  CloseFile(f);
end;


function GetCurrentMask: PMyInfernalType;
begin
   CurrentMask:= cmMask1;
   case CurrentMask of
    cmMask1: Result:=@(mask_inner);
    cmMask2: Result:=@(mask_outer);
    cmFinal: Result:=@(final_mask);
  end;

end;


function CheckMask(var mask: TMyInfernalType; p: PPoint): boolean;
var i, j, sum, sumx, sumy: integer;

begin
  sum:=0;
  sumx:=0;
  sumy:=0;

  for i:=0 to mask.h-1 do
    for j:=0 to mask.w-1 do
      if mask.b^[i*mask.w+j] = 1 then
      begin
        inc(sum);
        sumx:= sumx + j;
        sumy:= sumy + i;
      end;

  if Assigned(p) and (sum <> 0) then
  begin
    p^.x:= Round(sumx/sum);
    p^.y:= Round(sumy/sum);
  end;

  Result:= sum <> 0;
end;

end.
