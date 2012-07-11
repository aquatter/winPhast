unit UDirectShowVideoForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart, StdCtrls, Menus;

type
  TDirectShowVideoForm = class(TForm)
    Chart1: TChart;
    Series1: TAreaSeries;
    ScrollBar2: TScrollBar;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label3: TLabel;
    Label1: TLabel;
    Bevel1: TBevel;
    PopupMenu1: TPopupMenu;
    CaprurewithAveraging1: TMenuItem;
    N1: TMenuItem;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ScrollBar2Change(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure CaprurewithAveraging1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DirectShowVideoForm: TDirectShowVideoForm;

implementation

{$R *.dfm}
uses VidCap, UPhast2Vars, unit10, unit3, unit4, unit1, panel1,
     UDirectShowCaptureThread, crude, UCapture_with_Averaging_DirectShow_Thread;

procedure TDirectShowVideoForm.Button1Click(Sender: TObject);
begin
  VidCap1.ShowPropertyPages;
end;

procedure TDirectShowVideoForm.Button2Click(Sender: TObject);
begin
  form10.ProgressBar1.Max:=cfg.steps;
  form10.ProgressBar1.Position:=0;
  form10.Show;
  form3.Close;
  form4.Close;
  pnl.DrawMode:=dmNone;
  DirectShowCaptureThread:=TDirectShowCaptureThread.Create(true);
  DirectShowCaptureThread.FreeOnTerminate:=true;
  DirectShowCaptureThread.Start;

  close;
end;

procedure TDirectShowVideoForm.Button3Click(Sender: TObject);
begin
  VidCap1.Pause;
  VidCap1.VideoRect:=Rect(0, 0, 0, 0);
  CurrentMatrix:=cmInt;
  form1.off(true);
  pnl.DrawMode:=dmNone;
  pnl.Repaint;
  Close;
end;

procedure TDirectShowVideoForm.Button4Click(Sender: TObject);
begin
  form1.ToolButton33Click(nil);
end;

procedure TDirectShowVideoForm.CaprurewithAveraging1Click(Sender: TObject);
begin
  Capture_with_Averaging_DirectShow_Thread:=TCapture_with_Averaging_DirectShow_Thread.Create(true);
  Capture_with_Averaging_DirectShow_Thread.FreeOnTerminate:=true;
  Capture_with_Averaging_DirectShow_Thread.Resume;
end;

procedure TDirectShowVideoForm.FormCreate(Sender: TObject);
begin
  Left:=cfg.capture_left;
  Top:=cfg.capture_top;
end;

procedure TDirectShowVideoForm.N1Click(Sender: TObject);
begin
  CurrentNum_Average:=0;
end;

procedure TDirectShowVideoForm.ScrollBar2Change(Sender: TObject);
begin
  if cfg.Com_phase_shift then
    form1.MoveMirrorCom(ScrollBar2.Position)
  else
    MoveMirror(cfg.port, ScrollBar2.Position);
  Label1.Caption:=IntToStr(ScrollBar2.Position);

  if cfg.how_many_wavelengths = 1 then
    cfg.Shifts[cfg.LazerNum]:= ScrollBar2.Position
  else
    cfg.Shifts[1]:= ScrollBar2.Position;

//    cfg.m_shift:=ScrollBar2.Position;
end;

end.
