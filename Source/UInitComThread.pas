unit UInitComThread;

interface

uses
  Classes;

type
  TInitComThread = class(TThread)
  private
    { Private declarations }
  protected
    procedure Execute; override;
    procedure Draw;
  end;

procedure InitComThreadStart;

var InitComThread: TInitComThread;

implementation

{ TInitComThread }
uses unit1, UTInitComThreadForm, windows, UPhast2Vars;

procedure TInitComThread.Draw;
begin
//  InitComThreadForm.Close;
//  form1.Off(true);

end;

procedure TInitComThread.Execute;
var i: integer;
    lpModemStat: cardinal;
begin
  i:=0;
  while True do
  begin
    ResetEvent(ComEvent);
    form1.Shift(1, 50, true, true, true);
    sleep(50);
//    WaitForSingleObject(ComEvent, 500);
    GetCommModemStatus(form1.CommPortDriver1.ComHandle, lpModemStat);
    if lpModemStat = $80 then
      break;
    inc(i);
    if i > 100 then
      break;
  end;


 { form1.Shift(70, 30, true, true, true);

  while True do
  begin
    sleep(100);
    GetCommModemStatus(form1.CommPortDriver1.ComHandle, lpModemStat);
    if lpModemStat = $80 then
    begin
      form1.Shift(0, 30, true, true, true);

      break;
    end;

  end;
  }




//  ResetEvent(ComEvent);
//  WaitForSingleObject(ComEvent, 100);
  form1.Shift(cfg.LazerPos[cfg.LazerNum], 30, true, false, true);
//  WaitForSingleObject(ComEvent, 5000);
  LazPos:=cfg.LazerPos[cfg.LazerNum];
//  SetEvent(ComInit);
//  Synchronize(draw);
end;

procedure InitComThreadStart;
begin
  InitComThread:=TInitComThread.Create(true);
  InitComThread.FreeOnTerminate:=true;
  InitComThread.Resume;
//  form1.Off(false);
//  InitComThreadForm.Show;
end;

end.
