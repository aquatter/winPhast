unit UComWatcher;

interface

uses
  Classes, VidCap, Comm32, Windows, Dialogs;

type
  TComWatcher = class(TThread)
  public
    VidCap: TVidCap;
    status: byte;
    WaitEvent: THandle;
    Comm321: TComm32;
    Frames: integer;
  protected
    procedure Execute; override;
  end;

var ComWatcher: TComWatcher;
    ComWatcherTerminated: boolean;

implementation


procedure TComWatcher.Execute;
var p: byte;
begin
  while not Terminated do
  begin
    p:=$12;
    Comm321.WriteCommData(PChar(@p), 1);
   // WaitForSingleObject(WaitEvent, INFINITE);
    if WAIT_TIMEOUT = WaitForSingleObject(WaitEvent, 1000) then
      Break;
    ResetEvent(WaitEvent);
    if status = 6 then
      VidCap.Capture(Frames);
  end;
  CloseHandle(WaitEvent);
end;

initialization

  ComWatcherTerminated:=true;

end.
