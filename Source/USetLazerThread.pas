unit USetLazerThread;

interface

uses
  Classes;

type
  TSetLazerThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
  end;

procedure SetLazerThreadStart;

var SetLazerThread: TSetLazerThread;

implementation

uses UWatchComThread, windows, UPhast2Vars, unit1, math;
{ TSetLazerThread }

procedure TSetLazerThread.Execute;
var dist, ShiftTo: integer;
begin
  ShiftTo:=cfg.LazerPos[cfg.LazerNum];
  dist:=ShiftTo-LazPos;
  ResetEvent(ComEvent);

  if dist > 0 then
    form1.Shift(dist, 10, true, false, true);

  if dist < 0 then
    form1.Shift(abs(dist), 10, true, true, true);

  LazPos:=ShiftTo;

  WaitForSingleObject(ComEvent, 5000);

  ResetEvent(ComEvent);
  WaitForSingleObject(ComEvent, 100);

  WatchComThread.Resume;
end;

procedure SetLazerThreadStart;
begin
  WatchComThread.Suspend;

  SetLazerThread:=TSetLazerThread.Create(true);
  SetLazerThread.FreeOnTerminate:=true;
  SetLazerThread.Resume;
end;

end.
