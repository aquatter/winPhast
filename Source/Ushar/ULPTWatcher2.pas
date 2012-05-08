unit ULPTWatcher2;

interface

uses
  Classes, VidCap, Windows;

type
  TLPTWatcher2 = class(TThread)
  private
     run: boolean;
  protected
      procedure Execute; override;
  published
      procedure Stop;
  public
     adr: Word;
     VidCap: TVidCap;
     WaitEvent: THandle;
  end;


implementation

{ TLPTWatcher2 }
uses giveio, SysUtils;

procedure TLPTWatcher2.Execute;
var port: byte;
begin
  //run:=true;
  WaitEvent:=CreateEvent(nil, true, false, nil);
  while not Terminated do
  begin
    port:=InPort(adr);
    if (port and 16) <> 0 then
      VidCap.Capture;
    WaitForSingleObject(WaitEvent, 2);
  end;
  CloseHandle(WaitEvent);
end;

procedure TLPTWatcher2.Stop;
begin
  run:=false;
end;

end.
