unit UCapture_with_Averaging_DirectShow_Thread;

interface

uses
  Classes, t666;

type
  TCapture_with_Averaging_DirectShow_Thread = class(TThread)
  private
    buff_mean: TMyInfernalType;

  protected
    procedure Execute; override;
  end;

var Capture_with_Averaging_DirectShow_Thread: TCapture_with_Averaging_DirectShow_Thread;

procedure MyBeep(Tone: Word; Delay: Integer);


implementation

uses UPhast2Vars, windows, unit10, sysutils, crude, VidCap, utype, unit1;

procedure TCapture_with_Averaging_DirectShow_Thread.Execute;
var i, j, w, h: integer;
    p: PByteArray;
begin
  w:=cfg.cam_w;
  h:=cfg.cam_h;

  buff_mean:=TMyInfernalType.Create;
  buff_mean.Init(h, w, varDouble);

  VidCap1.CB.SetCaptureParams(cfg.num_mean, cfg.cam_w, cfg.cam_h);
  ResetEvent(DataReady_Average);
  VidCap1.CB.start;
  WaitForSingleObject(DataReady_Average, 5000);

  for i:=0 to cfg.num_mean-1 do
  begin
    p:=VidCap1.CB.Frames[i].Buf;
    for j:=0 to w*h-1 do
      buff_mean.a^[j]:=buff_mean.a^[j]+p^[3*j];
  end;

  for i:=0 to w*h-1 do
    buff_mean.a^[i]:=buff_mean.a^[i]/cfg.num_mean;

  CreateBmp(buff_mean, false,  cfg.img_path+'\shit_'+IntToStr(CurrentNum_Average)+'.bmp');
  inc(CurrentNum_Average);

  MyBeep(3000, 100);

  VidCap1.CB.ClearCaptureParams;
  buff_mean.Destroy;
end;


procedure MyBeep(Tone: Word; Delay: Integer);
begin
  asm
    mov   al,  0b6H
    out   43H, al
    mov ax,Tone
    out 42h,al
    ror ax,8
    out 42h,al
    in    al,  61H
    or    al,  03H
    out   61H, al
  end;
  sleep(Delay);
  asm
    in    al,  61H
    and   al,  0fcH
    out   61H, al
  end;
end;


end.
