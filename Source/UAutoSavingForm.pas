unit UAutoSavingForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls;

type

  TAutoSavingThread = class(TThread)
  public
    masked: boolean;

  protected
    procedure Execute; override;
  end;

  TAutoSavingForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Edit1: TEdit;
    TrackBar1: TTrackBar;
    Label3: TLabel;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Label4: TLabel;
    Label5: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
  private
    AutoSavingThread: TAutoSavingThread;

  public

    path: string;
    procedure StartThread;
  end;

var
  AutoSavingForm: TAutoSavingForm;

implementation

{$R *.dfm}

uses panel1, UPhast2Vars, unit1, t666, Math, Crude;

procedure TAutoSavingForm.Button1Click(Sender: TObject);
begin
  Close;
end;

procedure TAutoSavingForm.Button2Click(Sender: TObject);
var dir: string;
begin
  dir:= path;
  if  AdvSelectDirectory('Выберите директорию для сохранения:', '', dir, false, false, True) then
    path:= dir + '\';

  Label3.Caption:= path;
end;

procedure TAutoSavingForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if Assigned(AutoSavingThread) then
    AutoSavingThread.Terminate;
end;

procedure TAutoSavingForm.FormCreate(Sender: TObject);
begin
   path:= ExtractFilePath(Application.ExeName);
   Label3.Caption:= path;
end;

procedure TAutoSavingForm.StartThread;
begin

 Label4.Caption:= 'Счетчик областей:';

 AutoSavingThread:= TAutoSavingThread.Create(true);
 AutoSavingThread.masked:= CheckMask(mask_inner);
 AutoSavingThread.Start;
end;

procedure TAutoSavingForm.TrackBar1Change(Sender: TObject);
begin
  AlphaBlendValue:= TrackBar1.Position;
end;

{ TAutoSavingThread }

procedure TAutoSavingThread.Execute;
var wait_event: THandle;
    s, mask: string;
    p1, p2: TPoint;
    i,j, cnt, x0, y0, x1, y1, w, h, w1: integer;
    data: TMyInfernalType;
begin
  inherited;

  wait_event:= CreateEvent(nil, true, false, nil);
  ResetEvent(wait_event);

  data:= TMyInfernalType.Create;
  w:= phase.w;
  h:= phase.h;

  Synchronize(
  procedure
  begin
    Form1.Off(false);
    pnl.Cursor:=Unit1.crMyShittyCursor;
    pnl.Contrast_mask:= 1.0;
    pnl.DrawMode:= dmNone;

  end);

  cnt:=0;

  while not Terminated do
  begin
    Synchronize( procedure begin pnl.DrawMode:= dmSimpleRect; end);

    repeat
      WaitForSingleObject(wait_event, 100);
      if Terminated then break;
    until pnl.DrawMode = dmNone;

    if not DirectoryExists(AutoSavingForm.path) then
    begin
      Synchronize(procedure begin ShowMessage('Путь для сохранения задан неверно.') end);
      Terminate;
    end;

    Synchronize( procedure begin s:= AutoSavingForm.path + AutoSavingForm.Edit1.Text; end);

    p1:= pnl.GetPoint1;
    p2:= pnl.GetPoint2;

    x0:= Max(0, p1.x);
    x1:= Min(w-1, p2.x);
    y0:= Max(0, p1.y);
    y1:= Min(h-1, p2.y);

    data.Clear;
    data.Init(y1-y0+1, x1-x0+1, varDouble);
    w1:=x1-x0+1;

    if masked then
    begin
      for i:=y0 to y1 do
        for j:=x0 to x1 do
          if mask_inner.b^[i*w+j] = 1 then
            data.a^[(i-y0)*w1 + j-x0]:= phase.a^[i*w+j];
    end
    else
    begin
      for i:=y0 to y1 do
        for j:=x0 to x1 do
          data.a^[(i-y0)*w1 + j-x0]:= phase.a^[i*w+j];
    end;

    if AutoSavingForm.CheckBox1.Checked then
      CreateBmp(data, true, s + Format('_%.3d.bmp', [cnt+1]));

    if AutoSavingForm.CheckBox2.Checked then
      SaveData2Txt(data, data, s + Format('_%.3d.txt', [cnt+1]));

    if AutoSavingForm.CheckBox3.Checked then
      SaveRealArray2Matlab(data, 1.0, s + Format('_%.3d.m', [cnt+1]));

    Synchronize( procedure begin AutoSavingForm.Label4.Caption:= 'Счетчик: '+ IntToStr(cnt+1); end);
    inc(cnt);
  end;

  Synchronize(
  procedure
  begin
    Form1.Off(true);
    pnl.Cursor:= crDefault;
    AutoSavingForm.Close;
    pnl.DrawMode:= dmNone;
  end);

  data.Destroy;
  CloseHandle(wait_event);
end;

end.
