unit ULPTWatcher;

interface

uses
  Classes, utype, it_mouth;

type
  TLPTWatcher = class(TThread)
  private
     mm: byte;
     run: boolean;
  protected
      procedure Execute; override;
      procedure Draw;
  published
      procedure Stop;
  public
     adr: Word;
  end;

var LPTWatcher: TLPTWatcher;

implementation

uses unit1, SysUtils, giveio;

{ TLPTWatcher }


procedure TLPTWatcher.Draw;
begin
  Form1.VidCap.Capture;
  run:=false;
end;

procedure TLPTWatcher.Execute;
var port: byte;
begin
  run:=true;
  mm:=0;
  while run do
  begin
    port:=InPort(adr);
    if (port and 16) <> 0 then
    begin
      Form1.VidCap.Capture;
     //run:=false;
      //inc(mm);
    //Synchronize(Draw);
    end;
    sleep(5);
  end;
end;


procedure TLPTWatcher.Stop;
begin
  run:=false;
end;

end.
