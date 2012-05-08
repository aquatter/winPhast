unit UWatchComThread;

interface

uses
  Classes;

type
  TWatchComThread = class(TThread)
  private
    { Private declarations }
    mm: integer;
  protected
    procedure Execute; override;
    procedure Draw;
  public
    SetLazer: boolean;
  end;

procedure WatchComThreadStart;

var WatchComThread: TWatchComThread;



implementation

uses unit1, UPhast2Vars, windows, UInitComThread, sysutils;
{ TWatchComThread }

procedure TWatchComThread.Draw;
begin
  case mm of
    0: form1.StatusBar1.SimpleText:='Осветительный блок выключен.';
    1: form1.StatusBar1.SimpleText:='Осветительный блок включен. '+FloatToStr(cfg.LazerLambda[cfg.LazerNum])+' нм.';
  end;
end;

procedure TWatchComThread.Execute;
var ret: cardinal;
    dist, ShiftTo: integer;
begin
  SetLazer:=false;
  while not Terminated do
  begin
    if Terminated then break;

    ResetEvent(ComEvent);
    WaitForSingleObject(ComEvent, 900);

    if Terminated then break;

    form1.Shift(0, 10, true, true, true);
    ret:=WaitForSingleObject(ComEvent, 500);
    ResetEvent(ComEvent);
    WaitForSingleObject(ComEvent, 100);

    if ret = WAIT_TIMEOUT then
      ComEnabled:=false;

    if (ret = WAIT_OBJECT_0) and (not ComEnabled) then
    begin
      ComEnabled:=true;
      ResetEvent(ComInit);
      InitComThreadStart;
      WaitForSingleObject(ComInit, INFINITE);
    end;

    if SetLazer then
    begin
      ShiftTo:=cfg.LazerPos[cfg.LazerNum];
      dist:=ShiftTo-LazPos;
      ResetEvent(ComEvent);

      if dist > 0 then
        form1.Shift(dist, 10, true, false, true);
      if dist < 0 then
        form1.Shift(abs(dist), 10, true, true, true);

      WaitForSingleObject(ComEvent, 5000);

      LazPos:=ShiftTo;
      SetLazer:=false;
    end;

    if ComEnabled then
    begin
      mm:=1;
      Synchronize(Draw);
    end
    else
    begin
      mm:=0;
      Synchronize(Draw);
    end;

  end;
end;

procedure WatchComThreadStart;
begin
  WatchComThread:=TWatchComThread.Create(true);
  WatchComThread.FreeOnTerminate:=true;
  WatchComThread.Resume;
end;

end.
