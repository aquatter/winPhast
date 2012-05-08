unit UAutoReg;

interface

uses
  Classes, UVidCap, UVidCap_ini, Windows;

type
  TAutoReg = class(TThread)
  public
    WaitEvent: THandle;
  protected
    procedure Execute; override;
  end;

var AutoReg: TAutoReg;
    AutoRegTerminated: boolean;
implementation

{ TAutoReg }

procedure TAutoReg.Execute;
begin
  WaitEvent:=CreateEvent(nil, true, false, nil);
  while not Terminated do
  begin
    if VidCapParam.AutoReg then
      ImageOK:=VidCap.AutoReg;
    WaitForSingleObject(WaitEvent, 100);
  end;
  CloseHandle(WaitEvent);
end;

initialization
  AutoRegTerminated:=true;

end.

