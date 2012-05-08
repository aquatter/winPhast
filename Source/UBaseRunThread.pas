unit UBaseRunThread;

interface

uses
  Classes;

type
  TBaseRunThread = class(TThread)
  private
    mm: integer;
  protected
    procedure Execute; override;
    procedure Draw;
  end;

var BaseRunThread: TBaseRunThread;

implementation

uses unit1, crude, utype, UUnwrap, SysUtils, forms, windows, UPhast2Vars;

procedure TBaseRunThread.Draw;
begin
  case mm of
    0: pnl.DrawImage(phase, final_mask);
    1: begin
         pnl.DrawImage(unwrap, final_mask);
         CurrentMatrix:=cmUnwrap;
         CreateBin(unwrap, final_mask, ExtractFilePath(Application.ExeName)+'base.bin');
       end;
  end;
end;

procedure TBaseRunThread.Execute;
var temp: TPointerArray;
    i, j, w, h: integer;
begin
  w:=cfg.cam_w;
  h:=cfg.cam_h;
  SetLength(temp, cfg.steps);

  for i:=0 to cfg.steps-1 do
    GetMem(temp[i], w*h);

  form1.LoadBitmaps(temp);
  phase.Clear;
  phase.Init(h, w, varDouble);
  unwrap.Clear;
  unwrap.Init(h, w, varDouble);
  final_mask.Clear;
  final_mask.Init(h, w, varByte);

  for i:=10 to h-9 do
    for j:=10 to w-9 do
      final_mask.b^[i*w+j]:=1;

  FindPhase(phase, final_mask, temp, cfg.steps);

  mm:=0;
  Synchronize(Draw);

  for i:=0 to cfg.steps-1 do
    FreeMem(temp[i], w*h);
  Finalize(temp);

  UnWrapPhaseSt(w div 2, h div 2, w, h, phase.a^, unwrap.a^, final_mask.b^);

  if cfg.invert then
    for i:=0 to w*h-1 do
      if final_mask.b^[i]=1 then
        unwrap.a^[i]:=-unwrap.a^[i];



  TiltRemove(unwrap.a^, final_mask.b^, final_mask.b^, h, w);

  mm:=1;
  Synchronize(Draw);
end;

end.
