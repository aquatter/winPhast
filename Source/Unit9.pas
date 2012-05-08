unit Unit9;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, EditR, StdCtrls, ExtCtrls, Crude, Series, TeEngine,
  TeeFunci, TeeProcs, Chart, VideoStream;

type

  TMyTrackBar = class(TScrollBar)
  protected


    procedure Scroll(ScrollCode: TScrollCode; var ScrollPos: Integer); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState;
      X: Integer; Y: Integer); override;
  published

  end;

  TMyTrackBar2 = class(TTrackBar)
  protected


  end;


  TForm9 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Chart1: TChart;
    Series1: TAreaSeries;
    Button1: TButton;
    Button2: TButton;
    ScrollBar1: TScrollBar;
    ScrollBar2: TScrollBar;
    Bevel1: TBevel;
    CheckBox1: TCheckBox;
    Button3: TButton;
    Button4: TButton;
    ScrollBar3: TScrollBar;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Button5: TButton;
    Button6: TButton;
    Button9: TButton;
    Button7: TButton;
    Label7: TLabel;
    Label8: TLabel;
    Button8: TButton;
    Button10: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure ScrollBar1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure CheckBox1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ScrollBar3Change(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Label8DblClick(Sender: TObject);
    procedure Button10Click(Sender: TObject);
  private
  public
    tb: TMyTrackBar;
    ed, ed1, ed2{, ed3}: TEditR;
    procedure UpdateHist;
  end;

var
  Form9: TForm9;

implementation

uses unit1, VideoScan, panel1, Unit3, Unit4, t666, Unit10, UVideoCaptureSeqThread,
     UPhast2Vars, UWatchComThread, FileCtrl, utype, UTest_Com_Port_Form;
{$R *.dfm}

{ TMyTrackBar }



procedure TMyTrackBar.MouseDown(Button: TMouseButton; Shift: TShiftState; X,
  Y: Integer);
begin
  inherited MouseDown(Button, Shift, X, Y);
  Form1.vs.SetExpos(Position, VSLIB3_SCALAR_UNIT_MS);
  cfg.expos:=Position;
end;

procedure TForm9.FormCreate(Sender: TObject);
begin
  tb:=TMyTrackBar.Create(Self);
  tb.Max:=10000;
  tb.Min:=0;
  tb.Left:=8;
  tb.Top:=24;
  tb.Width:=385;
  tb.Height:=17;
  tb.Parent:=Self;

  ed:=TEditR.Create(Self);
  ed.Parent:=Self;
  ed.Text:=IntToStr(tb.Position);
  ed.Left:=408;
  ed.Top:=24;
  ed.Width:=49;
  ed.Height:=21;

  ed1:=TEditR.Create(Self);
  ed1.Parent:=Self;
  ed1.Text:=IntToStr(ScrollBar1.Position);
  ed1.Left:=408;
  ed1.Top:=64;
  ed1.Width:=49;
  ed1.Height:=21;

  ed2:=TEditR.Create(Self);
  ed2.Parent:=Self;
//  ed2.Text:=IntToStr(TrackBar1.Position);
  ed2.Left:=408;
  ed2.Top:=104;
  ed2.Width:=49;
  ed2.Height:=21;

 { ed3:=TEditR.Create(Self);
  ed3.Parent:=Self;
//  ed3.Text:=IntToStr(TrackBar1.Position);
  ed3.Left:=216;
  ed3.Top:=140;
  ed3.Width:=49;
  ed3.Height:=21;}
  Left:=cfg.capture_left;
  Top:=cfg.capture_top;
end;

{procedure TForm9.TrackBar1Change(Sender: TObject);
begin
  Form9.ed1.Text:=IntToStr(TrackBar1.Position);
  Form1.vs.SetAmplify(TrackBar1.Position);
end;}

procedure TForm9.UpdateHist;
var i: integer;
begin
  with form1 do
  begin
//    MakeHist(@(int), @(hist), @(x_hist), point(int.x_img, int.y_img), point(int.x_img+int.w_img-1, int.y_img+int.h_img-1));
    form9.Series1.Clear;
    for i:=0 to hist.w-1 do
      form9.Series1.AddXY(x_hist.a^[i], hist.c^[i]);
    form9.Chart1.Update;
  end;
end;

procedure TForm9.Button2Click(Sender: TObject);
begin
  VideoCaptureSeqThread.Terminate;
//  form1.VideoThread.Terminate;
  form1.vs.run:=false;
  form1.Off(true);
//  pnl.DrawMode:=dmNone;
  {sleep(500);
  form1.int.Clear;}

  form3.Close;
  form4.Close;
  pnl.DrawMode:=dmNone;
  form1.N80.Checked:=false;

  pnl.Repaint;
//  WatchComThread.Resume;




  {if form1.ToolButton34.Down then
  begin
    form1.ToolButton34.Down:= false;
    Form3.close;
    Form4.close;
  end;}
  Close;
end;

procedure TForm9.Button3Click(Sender: TObject);
begin
  form1.ToolButton33Click(nil);
  Label6.Caption:=cfg.img_path;
  Label6.Hint:=cfg.img_path;

  if cfg.ComMode then
  begin
    form1.SetLazer;
    cfg.m_shift:=cfg.Shifts[cfg.LazerNum];
    ScrollBar2.Position:=cfg.m_shift;
    ed2.Text:=IntToStr(cfg.m_shift);
  end;
end;

procedure TForm9.Button4Click(Sender: TObject);
begin
  form10.ProgressBar1.Max:=cfg.steps;
  form10.ProgressBar1.Position:=0;
  form10.Show;
  form3.Close;
  form4.Close;
  pnl.DrawMode:=dmNone;
  form1.N80.Checked:=false;


  TestThread:=TTestThread.Create(true);
  TestThread.FreeOnTerminate:=true;
  TestThread.Resume;

  close;
end;

procedure TForm9.Button5Click(Sender: TObject);

var dir: string;
    opt: TSelectDirOpts;
begin
  dir:=cfg.img_path;
  if  AdvSelectDirectory('Выберите директорию для сохранения интерферограмм', '', dir, false, false, True) then
  begin
    Label6.Caption:=dir;
    Label6.Hint:=dir;
    cfg.img_path:=dir;
  end;

end;

procedure TForm9.Button6Click(Sender: TObject);
begin
  form1.Shift(1, 50, true, false, true);
  label7.Caption:='Текущее положение '+IntToStr(cfg.Step_Motor_Curr_Pos);
end;

procedure TForm9.Button7Click(Sender: TObject);
begin
  form1.Shift(1, 50, true, true, true);
  label7.Caption:='Текущее положение '+IntToStr(cfg.Step_Motor_Curr_Pos);
end;

procedure TForm9.Button8Click(Sender: TObject);
begin
  cfg.Step_Motor_Shift:=cfg.Step_Motor_Curr_Pos;
  label8.Caption:='Диапазон сдвига '+IntToStr(cfg.Step_Motor_Shift);
end;

procedure TForm9.Button9Click(Sender: TObject);
begin
  cfg.Step_Motor_Curr_Pos:=0;
  label7.Caption:='Текущее положение 0';
end;

procedure TForm9.CheckBox1Click(Sender: TObject);
begin
    pnl.Draw_circle:=CheckBox1.Checked;
end;

procedure TForm9.Button10Click(Sender: TObject);
begin
  Test_Com_Port_Form.Show;
end;

procedure TForm9.Button1Click(Sender: TObject);
begin
  if  not DirectoryExists(cfg.img_path) then
  begin
    ShowMessage('Неверно задана директория сохранения изображений!');
    exit;
  end;

  with form1 do
  begin
//   VideoThread.Terminate;


   {if  not DirectoryExists(cfg.img_path) then
   begin
     ShowMessage('Неверно задана директория сохранения изображений!');
     VideoCaptureSeqThread.Terminate;
     Form9.Close;
     exit;
   end;
   }
   form10.ProgressBar1.Max:=cfg.steps;
   form10.ProgressBar1.Position:=0;
   form10.Show;
   VideoCaptureMode:=cmCapture;
   {if cfg.do_seq then
   begin
     VideoCaptureSeqThread:=TVideoCaptureSeqThread.Create(true);
     VideoCaptureSeqThread.FreeOnTerminate:=true;
     VideoCaptureSeqThread.Resume;
   end
   else
   begin
     form10.ProgressBar1.Max:=Form1.cfg.steps;
     form10.Show;
     VideoCaptureThread:=TVideoCaptuteThread.Create(true);
     VideoCaptureThread.ProcessLastError:=vs.ProcessLastError;
     VideoCaptureThread.Init(vs.InDInterface, vs.InputControlInterface, vs.CInterfaceSync, vs.SizeX, vs.SizeY);
     VideoCaptureThread.FreeOnTerminate:=true;
     VideoCaptureThread.Resume;
   end;}


  end;
 // Form1.VideoThread.Destroy;
  Close;
end;

{procedure TForm9.TrackBar2Change(Sender: TObject);
var shift: TShiftState;
begin
  Form9.ed1.Text:=IntToStr(TrackBar2.Position);
  MoveMirror($b400, TrackBar2.Position);
 // form1.PnlMouseDown(form1, mbLeft, shift, 0, 0);
end;}

procedure TMyTrackBar.Scroll(ScrollCode: TScrollCode;
  var ScrollPos: Integer);
begin
  inherited Scroll(ScrollCode, ScrollPos);
  Form9.ed.Text:=IntToStr(Position);
end;

procedure TForm9.ScrollBar2Change(Sender: TObject);
begin
  Form9.ed2.Text:=IntToStr(ScrollBar2.Position);
  if cfg.Com_phase_shift then
    form1.MoveMirrorCom(ScrollBar2.Position)
  else
    MoveMirror(cfg.port, ScrollBar2.Position);
  cfg.m_shift:=ScrollBar2.Position;
  if cfg.ComMode then
    cfg.Shifts[cfg.LazerNum]:=cfg.m_shift;

end;

procedure TForm9.ScrollBar3Change(Sender: TObject);
begin
  AlphaBlendValue:=ScrollBar3.Position;
  cfg.transp:=ScrollBar3.Position;
end;

procedure TForm9.ScrollBar1Change(Sender: TObject);
begin
  Form9.ed1.Text:=IntToStr(ScrollBar1.Position);
  Form1.vs.SetAmplify(ScrollBar1.Position);
  cfg.amp:=ScrollBar1.Position;
end;

procedure TForm9.FormShow(Sender: TObject);
//var i: integer;
begin
  with form1 do
  begin
    vs.SetAmplify(cfg.amp);
    ScrollBar1.Position:=cfg.amp;
    ed1.Text:=IntToStr(cfg.amp);
    vs.SetExpos(cfg.expos, VSLIB3_SCALAR_UNIT_MS);
    tb.Position:=cfg.expos;
    ed.Text:=IntToStr(cfg.expos);
    if cfg.Com_phase_shift then
      form1.MoveMirrorCom(0)
    else
      MoveMirror(cfg.port, 0);
    ScrollBar2.Position:=cfg.m_shift;
    ed2.Text:=IntToStr(cfg.m_shift);
  end;
  Left:=cfg.capture_left;
  Top:=cfg.capture_top;
end;

procedure TForm9.Label8DblClick(Sender: TObject);
var s: string;
    t: treal;
begin
   s:=IntToStr(cfg.Step_Motor_Curr_Pos);
   if InputQuery('Введите значение', 'Величина сдвига', s) then
   begin
     t:=CheckString(s);
     label8.Caption:=FloatToStr(t);
     cfg.Step_Motor_Shift:=round(t);
   end;
end;

procedure TForm9.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  cfg.capture_left:=Left;
  cfg.capture_top:=Top;
end;

end.
