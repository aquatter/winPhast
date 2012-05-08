unit UTwoWaveLengthThread;

interface

uses
  Classes, t666;

type
  TTwoWaveLengthThread = class(TThread)
  private
    mm: integer;
    phase1, phase2, base_mask: TMyInfernalType;
  protected
    procedure Execute; override;
    procedure Draw;
  end;

var TwoWaveLengthThread: TTwoWaveLengthThread;

implementation

uses utype, UTwoWaveLengthClass, crude, sysutils, forms, UPhast2Vars, math, windows,
ufiltr, unit1;


procedure TTwoWaveLengthThread.Draw;
begin
  case mm of
    0: pnl.DrawImage(phase1, final_mask);
    1: pnl.DrawImage(phase2, final_mask);
    2: pnl.DrawImage(final_phase, final_mask);
    3: form1.Off(true);
  end;
end;

procedure TTwoWaveLengthThread.Execute;
var base1, base2: TMyInfernalType;
    w,h,n,i,j, cnt: integer;
    temp: TPointerArray;
    sgn: TValueSign;
    lam_eq: treal;
  _mean: treal;
begin
  base1:=TMyInfernalType.Create;
  base2:=TMyInfernalType.Create;
  phase1:=TMyInfernalType.Create;
  phase2:=TMyInfernalType.Create;
  base_mask:=TMyInfernalType.Create;
  if cfg.base then
  begin
    LoadBin(base1, base_mask, izm1.opt.base_path);
    LoadBin(base2, base_mask, izm2.opt.base_path);
  end;

  w:=int.w;
  h:=int.h;
  n:=izm1.int_list.Count;
  final_mask.Clear;
  final_mask.Init(h, w, varByte);
  final_phase.Clear;
  final_phase.Init(h, w, varDouble);
  phase1.Init(h, w, varDouble);
  phase2.Init(h, w, varDouble);


  for i:=10 to h-9 do
    for j:=10 to w-9 do
      final_mask.b^[i*w+j]:=1;

  if cfg.base then
    for i:=0 to w*h-1 do
      final_mask.b^[i]:=final_mask.b^[i]*base_mask.b^[i];


  SetLength(temp, n);
  for i:=0 to n-1 do
    GetMem(temp[i], w*h);

  for i:=0 to n-1 do
    LoadBmp(temp[i]^, w, h, izm1.int_list.Strings[i]);

  FindPhase(phase1, final_mask, temp, n);

  mm:=0;
  Synchronize(Draw);

  for i:=0 to n-1 do
    LoadBmp(temp[i]^, w, h, izm2.int_list.Strings[i]);

  FindPhase(phase2, final_mask, temp, n);

  mm:=1;
  Synchronize(Draw);

  for i:=0 to n-1 do
    FreeMem(temp[i], w*h);
  Finalize(temp);

  if cfg.base then
    for i:=0 to w*h-1 do
      if final_mask.b^[i]=1 then
        begin
          phase1.a^[i]:=phase1.a^[i]-base1.a^[i];
          phase2.a^[i]:=phase2.a^[i]-base2.a^[i];
        end;


  for i:=0 to w*h-1 do
    if final_mask.b^[i]=1 then
    begin
      sgn:=sign(phase1.a^[i]-phase2.a^[i]);
      if abs(phase1.a^[i]) < abs(phase2.a^[i]) then
        phase1.a^[i]:=phase1.a^[i]-sgn*2*pi;

      final_phase.a^[i]:=phase1.a^[i]-phase2.a^[i];
    end;


  lam_eq:=abs(izm1.opt.lambda*izm2.opt.lambda/(izm1.opt.lambda-izm2.opt.lambda));


  if cfg.do_phase2z then
    for i:=0 to w*h-1 do
      if final_mask.b^[i]=1 then
        final_phase.a^[i]:=final_phase.a^[i]*lam_eq/(4*pi*(cfg.n_photo-1));


  _mean:=0;
  cnt:=0;

  for i:=0 to w*h-1 do
    if final_mask.b^[i]=1 then
    begin
      _mean:=_mean+final_phase.a^[i];
      inc(cnt);
    end;
  _mean:=_mean/cnt;

  for i:=0 to w*h-1 do
    if final_mask.b^[i]=1 then
      final_phase.a^[i]:=final_phase.a^[i]-_mean;

  if cfg.tilt then
    TiltRemove(final_phase.a^, mask_inner.b^, final_mask.b^, h, w);

//  CreateBin(final_phase, final_mask, 'final_phase.bin');

//  CopyMemory(final_mask.b, base_mask.b, w*h);
  CopyMemory(mask_inner.b, final_mask.b, w*h);

  mm:=2;
  Synchronize(Draw);

  if cfg.do_gauss then
    RAFilterGaussianMaskOutBad(w, h, round(cfg.gauss_aper), cfg.gauss_aper/2, final_phase.a^, final_phase.a^, final_mask.b^);

  Synchronize(Draw);

  CurrentMatrix:=cmUnwrap;

  base1.Destroy;
  base2.Destroy;
  phase1.Destroy;
  phase2.Destroy;
  base_mask.Destroy;


  mm:=3;
  Synchronize(Draw);
end;

end.
