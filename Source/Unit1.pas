unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ToolWin, ComCtrls, Menus, ImgList, ExtCtrls, StdCtrls, unit2, t666,
  panel1, unit3, unit4, crude, Utype, interp, calibr, math, fftw, unit5, Types,
  Filters, Contour, ActnList, ActnMan, ActnCtrls, ActnMenus, ShellApi, Unit6,
  UPhShAlg, UUnwrap, UPalette, ufft, ufiltr, unit8, ComObj, Clipbrd, VideoStream,
  Unit9, VideoScan, giveio, UWinPhast_INI, ComDrv32, VirtualTrees, Series,
  TeEngine, TeeProcs, Chart;

 { TConfig = record
     steps, mean, input, q, pal: byte;
     scl_photo, scl_eye, lambda: TReal;
     w1,h1,w2,h2,z: integer;
     tilt, base, invert, do_seq, do_mean, do_step: boolean;
     x_left, x_top, y_left, y_top, legend_left, legend_top: integer;
     path: string[100];
     m_shift: integer;
     amp, expos: UINT;
     img_path: string[100];
     capture_left, capture_top: integer;
     port: word;
     int_filtr, save_bmp_int: boolean;
     cam_w, cam_h: integer;
     poly_order, num_seq, num_mean: byte;
     step_height: treal;
     do_filtr: boolean;
     gauss_aper: integer;
     _f, _t, _p, _b: treal;
  end; }
const
  crMyShittyCursor = 1;
  WM_STARTEDITING = WM_USER + 778;

type


  TForm1 = class(TForm)
    ImageList1: TImageList;
    ControlBar1: TControlBar;
    ToolBar6: TToolBar;
    ToolButton18: TToolButton;
    ToolButton19: TToolButton;
    ToolBar8: TToolBar;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ImageList4: TImageList;
    ToolBar9: TToolBar;
    ToolButton27: TToolButton;
    ToolButton29: TToolButton;
    ToolButton30: TToolButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    ToolBar1: TToolBar;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    OpenDialog1: TOpenDialog;
    TabSheet5: TTabSheet;
    ToolBar3: TToolBar;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    ToolButton1: TToolButton;
    ToolBar7: TToolBar;
    ToolButton20: TToolButton;
    ToolButton21: TToolButton;
    ToolButton22: TToolButton;
    ToolButton26: TToolButton;
    ToolButton2: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ComboBox1: TComboBox;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    ToolBar2: TToolBar;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton25: TToolButton;
    ToolButton28: TToolButton;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    N14: TMenuItem;
    ToolButton31: TToolButton;
    ToolButton32: TToolButton;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    ToolButton33: TToolButton;
    ToolButton34: TToolButton;
    ToolButton35: TToolButton;
    ToolButton36: TToolButton;
    N18: TMenuItem;
    N19: TMenuItem;
    ToolButton37: TToolButton;
    ToolButton38: TToolButton;
    ToolButton39: TToolButton;
    ToolButton40: TToolButton;
    ToolButton41: TToolButton;
    ToolButton42: TToolButton;
    N20: TMenuItem;
    N21: TMenuItem;
    bmp1: TMenuItem;
    Matlabfilem1: TMenuItem;
    SaveDialog1: TSaveDialog;
    ImageList2: TImageList;
    Label1: TLabel;
    ToolButton44: TToolButton;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    N30: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    N33: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    Cthbz1: TMenuItem;
    N36: TMenuItem;
    N37: TMenuItem;
    N38: TMenuItem;
    N39: TMenuItem;
    N40: TMenuItem;
    RMS1: TMenuItem;
    N41: TMenuItem;
    N42: TMenuItem;
    N43: TMenuItem;
    N44: TMenuItem;
    N45: TMenuItem;
    N46: TMenuItem;
    N22: TMenuItem;
    N47: TMenuItem;
    N48: TMenuItem;
    N49: TMenuItem;
    N50: TMenuItem;
    N110: TMenuItem;
    N210: TMenuItem;
    N51: TMenuItem;
    N52: TMenuItem;
    N53: TMenuItem;
    N54: TMenuItem;
    N55: TMenuItem;
    N56: TMenuItem;
    N57: TMenuItem;
    N58: TMenuItem;
    N59: TMenuItem;
    N60: TMenuItem;
    N61: TMenuItem;
    N62: TMenuItem;
    N63: TMenuItem;
    N64: TMenuItem;
    N65: TMenuItem;
    N66: TMenuItem;
    Binfile1: TMenuItem;
    N67: TMenuItem;
    N68: TMenuItem;
    N69: TMenuItem;
    N70: TMenuItem;
    N71: TMenuItem;
    N72: TMenuItem;
    N73: TMenuItem;
    N74: TMenuItem;
    N75: TMenuItem;
    N76: TMenuItem;
    N77: TMenuItem;
    ToolButton43: TToolButton;
    ToolButton45: TToolButton;
    N78: TMenuItem;
    N79: TMenuItem;
    ToolBar4: TToolBar;
    ImageList3: TImageList;
    ToolButton46: TToolButton;
    ToolButton47: TToolButton;
    ToolButton48: TToolButton;
    ToolButton49: TToolButton;
    ToolButton50: TToolButton;
    ToolButton51: TToolButton;
    N80: TMenuItem;
    N81: TMenuItem;
    N82: TMenuItem;
    Rz1: TMenuItem;
    N83: TMenuItem;
    N84: TMenuItem;
    N85: TMenuItem;
    N86: TMenuItem;
    ImageList5: TImageList;
    N87: TMenuItem;
    N88: TMenuItem;
    N89: TMenuItem;
    N90: TMenuItem;
    N91: TMenuItem;
    Panel1: TPanel;
    Splitter3: TSplitter;
    StatusBar1: TStatusBar;
    Chart3: TChart;
    Series1: TLineSeries;
    Series2: TPointSeries;
    Chart1: TChart;
    LineSeries1: TLineSeries;
    PointSeries1: TPointSeries;
    Splitter2: TSplitter;
    N211: TMenuItem;
    N92: TMenuItem;
    N93: TMenuItem;
    N94: TMenuItem;
    EMP1: TMenuItem;
    N95: TMenuItem;
    N96: TMenuItem;
    N111: TMenuItem;
    N212: TMenuItem;
    N97: TMenuItem;
    N98: TMenuItem;
    N99: TMenuItem;
    N100: TMenuItem;
    N101: TMenuItem;
    N102: TMenuItem;
    N103: TMenuItem;
    N104: TMenuItem;
    N105: TMenuItem;
    N106: TMenuItem;
    N107: TMenuItem;
    N108: TMenuItem;
    N109: TMenuItem;
    N112: TMenuItem;
    N113: TMenuItem;
    N114: TMenuItem;
    N115: TMenuItem;
    N116: TMenuItem;
    test1: TMenuItem;
    Panel2: TPanel;
    Splitter1: TSplitter;
    Panel3: TPanel;
    N117: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton16Click(Sender: TObject);
    procedure ToolButton19Click(Sender: TObject);
    procedure ToolButton18Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure ToolButton23Click(Sender: TObject);
    procedure ToolButton24Click(Sender: TObject);
    procedure ToolButton20Click(Sender: TObject);
    procedure ToolButton26Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure ToolButton21Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ToolButton29Click(Sender: TObject);
    procedure ToolButton30Click(Sender: TObject);
    procedure ToolButton22Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton10Click(Sender: TObject);
    procedure ToolButton11Click(Sender: TObject);
    procedure ToolButton12Click(Sender: TObject);
    procedure Action4Execute(Sender: TObject);
    procedure Action6Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure Action7Execute(Sender: TObject);
    procedure ToolButton27Click(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action21Execute(Sender: TObject);
    procedure Action22Execute(Sender: TObject);
    procedure ToolButton33Click(Sender: TObject);
    procedure ToolButton17Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure ToolButton35Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure ToolButton40Click(Sender: TObject);
    procedure ToolButton42Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N22Click(Sender: TObject);
    procedure bmp1Click(Sender: TObject);
    procedure Matlabfilem1Click(Sender: TObject);
    procedure ToolButton43Click(Sender: TObject);
    procedure ToolButton44Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure ToolButton45Click(Sender: TObject);
    procedure N27Click(Sender: TObject);
    procedure N26Click(Sender: TObject);
    procedure N30Click(Sender: TObject);
    procedure N29Click(Sender: TObject);
    procedure N28Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure N34Click(Sender: TObject);
    procedure N35Click(Sender: TObject);
    procedure N33Click(Sender: TObject);
    procedure N36Click(Sender: TObject);
    procedure N38Click(Sender: TObject);
    procedure N37Click(Sender: TObject);
    procedure N39Click(Sender: TObject);
    procedure N40Click(Sender: TObject);
    procedure RMS1Click(Sender: TObject);
    procedure N41Click(Sender: TObject);
    procedure N42Click(Sender: TObject);
    procedure N43Click(Sender: TObject);
    procedure N44Click(Sender: TObject);
    procedure N45Click(Sender: TObject);
    procedure N46Click(Sender: TObject);
    procedure N48Click(Sender: TObject);
    procedure N49Click(Sender: TObject);
    procedure N50Click(Sender: TObject);
    procedure N52Click(Sender: TObject);
    procedure N53Click(Sender: TObject);
    procedure N54Click(Sender: TObject);
    procedure N56Click(Sender: TObject);
    procedure N59Click(Sender: TObject);
    procedure N57Click(Sender: TObject);
    procedure N58Click(Sender: TObject);
    procedure N55Click(Sender: TObject);
    procedure N60Click(Sender: TObject);
    procedure N61Click(Sender: TObject);
    procedure N62Click(Sender: TObject);
    procedure N63Click(Sender: TObject);
    procedure N64Click(Sender: TObject);
    procedure N65Click(Sender: TObject);
    procedure N66Click(Sender: TObject);
    procedure Binfile1Click(Sender: TObject);
    procedure N68Click(Sender: TObject);
    procedure N69Click(Sender: TObject);
    procedure N70Click(Sender: TObject);
    procedure N71Click(Sender: TObject);
    procedure N72Click(Sender: TObject);
    procedure N73Click(Sender: TObject);
    procedure N74Click(Sender: TObject);
    procedure N75Click(Sender: TObject);
    procedure N76Click(Sender: TObject);
    procedure N77Click(Sender: TObject);
    procedure N78Click(Sender: TObject);
    procedure ToolButton49Click(Sender: TObject);
    procedure N87Click(Sender: TObject);
    procedure N81Click(Sender: TObject);
    procedure N80Click(Sender: TObject);
    procedure Rz1Click(Sender: TObject);
    procedure N83Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure CommPortDriver1ReceiveData(Sender: TObject; DataPtr: Pointer;
      DataSize: Integer);
    procedure Button5Click(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure N88Click(Sender: TObject);
    procedure N90Click(Sender: TObject);
    procedure N91Click(Sender: TObject);
    procedure N211Click(Sender: TObject);
    procedure N92Click(Sender: TObject);
    procedure N93Click(Sender: TObject);
    procedure N94Click(Sender: TObject);
    procedure EMP1Click(Sender: TObject);
    procedure N95Click(Sender: TObject);
    procedure N111Click(Sender: TObject);
    procedure N212Click(Sender: TObject);
    procedure N97Click(Sender: TObject);
    procedure N98Click(Sender: TObject);
    procedure N103Click(Sender: TObject);
    procedure N102Click(Sender: TObject);
    procedure N104Click(Sender: TObject);
    procedure N106Click(Sender: TObject);
    procedure N105Click(Sender: TObject);
    procedure N107Click(Sender: TObject);
    procedure N109Click(Sender: TObject);
    procedure N108Click(Sender: TObject);
    procedure N112Click(Sender: TObject);
    procedure N114Click(Sender: TObject);
    procedure N113Click(Sender: TObject);
    procedure N115Click(Sender: TObject);
    procedure N116Click(Sender: TObject);
    procedure test1Click(Sender: TObject);
    procedure Panel3Click(Sender: TObject);
    procedure N117Click(Sender: TObject);



  private




    procedure PnlResize(Sender: TObject);
    procedure ReadParams;
    function GetCurrentArray: PMyInfernalType;
    procedure SaveParams;
    procedure LoadParams;


    procedure ExportToWord;
    procedure WMStartEditing(var Message: TMessage); message WM_STARTEDITING;
  public
    line1, line2, fft, hist, x_hist: TMyInfernalType;


//    line1, line2: TPath;

    vs: TVideoStream;
    VideoThread: TVideoThread;
    VideoCaptureThread: TVideoCaptuteThread;
    Rz, Ra, Rmax: treal;
    CommPortDriver1: TCommPortDriver;

    procedure Off(b: boolean);
    procedure InitialiseArrays;
    procedure ClearArrays;
    procedure InitArrays(h, w: integer);
    procedure UpdateLegend;
    procedure UpdateLegendLabels;
    procedure LoadBitmaps(p: TPointerArray); overload;
    procedure LoadBitmaps(p: TMyInfernalArray); overload;
    procedure PnlMouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure PnlMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure WM_WMNewFrame(var msg: TMessage); message WM_NewFrame;
    procedure WM_WMCapDone(var msg: TMessage); message WM_CapDone;
    function CalcVideoRect: TRect;
    procedure Shift(steps, f: integer; mode, dir, enable: boolean);
    procedure Move2Start;
    procedure SetLazer;
    procedure MoveMirrorCom(pos: word);
  end;

  TRunThread = class(TThread)
  private
    mm: byte;
  protected
      procedure Execute; override;
      procedure Draw;
  published
  end;


var
  Form1: TForm1;

implementation

uses Unit7, UBaseRunThread, URaznForm, UVideoCaptureSeqThread, URecSeqThread, UPhast2Vars,
     URecSeqThreadForm, ULoadSeqForm, ULunkaRunhread, ULoadSeqLunkaForm, ULunkaSeqResultsForm, URaRzRmaxForm,
     UWhat2CalcForm, UReportForm, VidCap, UDirectShowVideoForm, UDirectShowCaptureThread,
     UInitComThread, UTInitComThreadForm, UWatchComThread, USetLazerThread, UTwoWaveLengthDialogForm,
     UTwoWaveLengthClass, UTwoWaveLengthThread, USaveAsForm, UPTree, UProjectData, Uvt;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
var p: array[0..2] of byte;
begin
  pnl:=tpanel1.Create(Self);
  pnl.Parent:=form1;
  pnl.Align:=alClient;
  pnl.SendToBack;
  pnl.OnMouseMove:=PnlMouseMove;
  pnl.OnMouseDown:=PnlMouseDown;
  pnl.OnResize:=PnlResize;
  pnl.Contrast_mask:=1;

  InitVt;

  phase:=TMyInfernalType.Create;
  unwrap:=TMyInfernalType.Create;
  amp:=TMyInfernalType.Create;
  int:=TMyInfernalType.Create;
  mask_inner:=TMyInfernalType.Create;
  mask_outer:=TMyInfernalType.Create;
  _mask:=TMyInfernalType.Create;
  final_mask:=TMyInfernalType.Create;
  final_phase:=TMyInfernalType.Create;
  line1:=TMyInfernalType.Create;
  line2:=TMyInfernalType.Create;
  fft:=TMyInfernalType.Create;
  hist:=TMyInfernalType.Create;
  x_hist:=TMyInfernalType.Create;
  phase_exp1:=TMyInfernalType.Create;
  phase_exp2:=TMyInfernalType.Create;
  super_lunka:=TMyInfernalType.Create;
  tilt1:=TMyInfernalType.Create;
  tilt2:=TMyInfernalType.Create;
  buff:=TMyInfernalType.Create;
  Fizo_Steps:=TMyInfernalType.Create;

  ProjectData:= TProjectData.Create;

  from:=fromCamera;
  _origin:=false;

  ReadINI(cfg, ExtractFileDir(Application.ExeName)+'\phast.ini');

  if cfg.CameraType = 'VideoScan' then
  begin
//    VideoScanEnabled:=TestVideoScan;
    VideoScanEnabled:=true;


    vs:=TVideoStream.Create;
//    VideoScanEnabled:=vs.err_list.Id = 0;

//    if VideoScanEnabled then
//    begin
    pnl.SetVideoRect(vs.SizeX, vs.SizeY);
    cfg.cam_w:=vs.SizeX;
    cfg.cam_h:=vs.SizeY;
//    end
//    else
//      ShowMessage('Видеокамера не подключена!');
  end;

  if cfg.CameraType = 'DirectShow' then
  begin
    VidCap1:=TVidCap.Create(Self);
    VidCap1.SelectCapDevice(cfg.DeviceNum);
    VidCap1.Handle:=Handle;
//    VidCap1.StartStream;
    VidCap1.BuildFilterGraph;

    VidCap1.Control:=pnl;
    VidCap1.VideoRect:=Rect(0, 0, 0, 0);
    VidCap1.NeedHist:=false;
    VidCap1.SetResolution(cfg.cam_w, cfg.cam_h);
    VidCap1.GetResolution(cfg.cam_w, cfg.cam_h);
    VidCap1.SetVideoMode($10);
    DataReady_Average:=CreateEvent(nil, true, false, nil);
    CurrentNum_Average:=0;
  end;


  Screen.Cursors[crMyShittyCursor]:=LoadCursor(HInstance, 'MYSHITTYCURSOR');

  {do_step:=false;
  if ParamStr(1) <> '' then}
  begin
    n25.Visible:=true;
    n35.Visible:=true;
//    do_step:=true;
  end;

  _rms:=0;
  _pv:=0;
  Ra:=0;
  Rz:=0;
  Rmax:=0;
  // LoadParams;
  {cfg.cam_w:=vs.SizeX;
  cfg.cam_h:=vs.SizeY;}

 { tb:=TMyTrackBar.Create(self);
  tb.Parent:=Self;
  tb.Position:=100;
  tb.Min:=100;
  tb.Max:=1000;}
  ComEnabled:=false;
  ComConnected:=false;
  CommPortDriver1:= TCommPortDriver.Create(self);
  CommPortDriver1.ComPortSpeed:=br19200;
  CommPortDriver1.ComPortStopBits:=sb1BITS;
  CommPortDriver1.ComPortParity:=TComPortParity.ptNONE;
  CommPortDriver1.ComPortDataBits:=db8BITS;

  if cfg.ComMode then
  begin
    CommPortDriver1.ComPort:=TComPortNumber(cfg.ComPort-1);
    ComConnected:=CommPortDriver1.Connect;
    if ComConnected then
    begin
      EscapeCommFunction(CommPortDriver1.ComHandle, 6);
      EscapeCommFunction(CommPortDriver1.ComHandle, 4);
      ComEvent:=CreateEvent(nil, true, false, nil);
      ComInit:=CreateEvent(nil, true, false, nil);
//      WatchComThreadStart;
    end
    else
      ShowMessage('Ошибка подключения осветительного блока!');

//    StatusBar1.Visible:=cfg.ComMode;
  end;

  if cfg.Com_phase_shift or cfg.Com_Step_Motor or cfg.Fizo then
  begin
    CommPortDriver1.ComPort:=TComPortNumber(cfg.ComPort-1);
    ComConnected:=CommPortDriver1.Connect;
    cfg.Step_Motor_Curr_Pos:=0;
    if not ComConnected then
    begin
      ShowMessage('Ошибка подключения пьезоэлемента!');
      exit;
    end;
    {p[0]:=0;
    p[1]:=32;
    p[2]:=1;
    CommPortDriver1.SendData(@(p), 3);
     }

  end;

  izm1.opt:=cfg;
  izm2.opt:=cfg;

end;

function TForm1.CalcVideoRect: TRect;
var w, h: integer;
    pnl_w, pnl_h: integer;
    sx, sy: integer;
    rez_w, rez_h: integer;
begin
  w:=cfg.cam_w;
  h:=cfg.cam_h;
  pnl_w:=pnl.Width;
  pnl_h:=pnl.Height;
  if w/h >= pnl_w/pnl_h then
  begin
    rez_w:=pnl_w;
    rez_h:=round(pnl_w*h/w);
  end
  else
  begin
    rez_h:=pnl_h;
    rez_w:=round(pnl_h*w/h);
  end;

  sx:=round((pnl_w-rez_w)/2);
  sy:=round((pnl_h-rez_h)/2);
  Result:=Rect(sx, sy, rez_w, rez_h);
end;

procedure TForm1.ClearArrays;
begin
  int.Clear;
  mask_inner.Clear;
  mask_outer.Clear;
  phase.Clear;
  unwrap.Clear;
  amp.Clear;
end;

procedure TForm1.InitArrays(h, w: integer);
begin
  mask_inner.Init(h, w, varByte, 1);
  mask_outer.Init(h, w, varByte, 1);
  phase.Init(h, w, varDouble);
  unwrap.Init(h, w, varDouble);
  int.Init(h, w, varByte);
  amp.Init(h, w, varDouble);
end;

procedure TForm1.ToolButton3Click(Sender: TObject);
begin
  {if vs.run then
  begin
    ShowMessage('Остановите видеопоток');
    exit;
  end;}

  Form2.FileMask:='bmp';
  if Form2.ShowModal = mrOk then
  begin
    from:=fromHDD;
    InitialiseArrays;
  end;
end;

procedure TForm1.ToolButton4Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.InitialiseArrays;
var s: string;
    w, h, i: integer;
    rec_: TRec;
begin
  ProjectData.Clear;

  case from of
    fromCamera: begin
                 s:=cfg.img_path+'\cadr_i1_s1_c1.bmp';
                end;
    fromHDD: begin
               s:=Form2.ListView2.Items[0].SubItems[1];
               ProjectData.prop_.WaveLength:= cfg.lambda;
               ProjectData.prop_.file_path:= ExtractFilePath(s);
               ProjectData.prop_.project_name:='New Project';
               ProjectData.prop_.file_name:='New Project.winPhast';
               ProjectData.changed:= true;
               rec_:=ProjectData.Add.Add;

               if form2.ListView2.Items.Count = 0 then exit;
               for i:=0 to form2.ListView2.Items.Count-1 do
                 rec_.img.Add(ExtractFileName(Form2.ListView2.Items[i].SubItems[1]));

               rec_.phase:='None';
               rec_.unwrap:='None';
               cfg.steps:=Form2.ListView2.Items.Count;
             end;
  end;

  LoadBmp(int, s, varByte);
  w:=int.w;
  h:=int.h;

  ProjectData.prop_.w:=w;
  ProjectData.prop_.h:=h;

  SaveProject(ProjectData);

  cfg.cam_w:=w;
  cfg.cam_h:=h;
  with cfg do
    scl_eye:=(w1/cam_w+h1/cam_h)/2;

  _origin:=false;
  mask_b:=false;

  _mask.Clear;
  _mask.Init(h, w, varByte, 1);
  //if not mask_inner.loaded then
  //begin
    mask_inner.Clear;
    mask_inner.Init(h, w, varByte, 0);
//  end;
//  if not mask_outer.loaded then
//  begin
    mask_outer.Clear;
    mask_outer.Init(h, w, varByte);
//  end;
//  if not final_mask.loaded then
//  begin
    final_mask.Clear;
    final_mask.Init(h, w, varByte, 1);
//  end;
//  pnl.Contrast_mask:=0.5;
//  pnl.DrawImage(int, mask_inner);
  pnl.Contrast_mask:=1;
  pnl.DrawImage(int, _mask);

  CurrentMatrix:=cmInt;
  CurrentMask:=cmMask1;
  pnl.InterpMode:=imNearest;
  UpdateLegend;
  UpdateLegendLabels;
  _rms:=0;
  _pv:=0;
  Ra:=0;
  Rz:=0;
  Rmax:=0;
end;

procedure TForm1.ToolButton16Click(Sender: TObject);
var p1, p2: TPoint;
begin
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmSimpleRect;
  repeat
    Application.ProcessMessages;
  until pnl.Finalized;
  pnl.DrawMode:=dmNone;
  p1:=pnl.GetPoint1;
  p2:=pnl.GetPoint2;
  pnl.DrawImage(int, mask_inner, 0, 0, int.w, int.h, p1.x, p1.y,  p2.x-p1.x+1, p2.y-p1.y+1);
end;

procedure TForm1.ToolButton19Click(Sender: TObject);
begin
 { if vs.run then
  begin
    ShowMessage('Остановите видеопоток');
    exit;
  end;}
 Close;
end;

procedure TForm1.ToolButton18Click(Sender: TObject);
var pb: PByteArray;
    b: TBitmap;
    i, j: integer;
begin
//cadr_I1_S9_C1.bmp
  with OpenDialog1 do
  begin
    Filter:='Bitmap (*.bmp)|*.bmp';
    DefaultExt:='*.bmp';
    InitialDir:=ExtractFilePath(Application.ExeName);
  end;

  if not OpenDialog1.Execute then exit;

  b:=TBitmap.Create;
  b.LoadFromFile(OpenDialog1.FileName);
  ClearArrays;
  int.Init(b.Height, b.Width, varByte);
  mask_inner.Init(b.Height, b.Width, varByte, 1);

  for i:=0 to int.h-1 do
  begin
    pb:=b.ScanLine[i];
    for j:=0 to int.w-1 do
    begin
      int.b^[i*int.w+j]:=pb^[j];
      {if int.b^[i*int.w+j] < 45 then
        mask_inner.b^[i*mask_inner.w+j]:=0;}
    end;
  end;
  b.Destroy;
  pnl.DrawImage(int, mask_inner);

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  ClearArrays;
  int.Destroy;
  phase.Destroy;
  unwrap.Destroy;
  amp.Destroy;
  mask_inner.Destroy;
  mask_outer.Destroy;
  _mask.Destroy;
  line1.Destroy;
  line2.Destroy;
  fft.Destroy;
  final_mask.Destroy;
  final_phase.Destroy;
  hist.Destroy;
  x_hist.Destroy;
  phase_exp1.Destroy;
  phase_exp2.Destroy;
  super_lunka.Destroy;
  tilt1.Destroy;
  tilt2.Destroy;
  buff.Destroy;
  Fizo_Steps.Destroy;
  CommPortDriver1.Destroy;
  ProjectData.Destroy;
  vt.Free;

  WriteINI(cfg, ExtractFileDir(Application.ExeName)+'\phast.ini');
//  SaveParams;
end;

procedure TForm1.ToolButton23Click(Sender: TObject);
var p1, p2: TPoint;
    p: PMyInfernalType;
    mode: TDrawMode;
begin
  {if ToolButton23.Down then
  begin}
//    Action16.Checked:=true;
//    ActionToolBar1.Repaint;

    p:=GetCurrentArray;
    if not p^.loaded then
    begin
      ToolButton15.Down:=false;
      exit;
    end;

    Off(false);
    mode:=pnl.DrawMode;
    pnl.DrawMode:=dmNone;
    pnl.DrawMode:=dmSimpleRect;
    repeat
      Application.ProcessMessages;
    until pnl.Finalized;
    pnl.DrawMode:=dmNone;
    p1:=pnl.GetPoint1;
    p2:=pnl.GetPoint2;

    p^.x_img:=p1.x;
    p^.y_img:=p1.y;
    p^.w_img:=p2.x-p1.x+1;
    p^.h_img:=p2.y-p1.y+1;
    pnl.DrawImage({int, mask_inner}p^, p^);
    ToolButton15.Down:=false;
    pnl.DrawMode:=mode;
    Off(true);
    //    Action16.Checked:=false;
{  end;
  ToolButton23.Down:=not ToolButton23.Down;}
end;

procedure TForm1.ToolButton24Click(Sender: TObject);
var p: PMyInfernalType;
begin
  p:=GetCurrentArray;
  if not p^.loaded then exit;
  p^.x_img:=0;
  p^.y_img:=0;
  p^.w_img:=p^.w;
  p^.h_img:=p^.h;
  pnl.DrawImage({int, mask_inner}p^, p^);
end;

procedure TForm1.ToolButton20Click(Sender: TObject);
//var //temp: TPath;
  //  trace: PRealArray;
  //  i, len: integer;
  //  points: TMyInfernalType;
//    interp: TInterp;
 //   p1, p2: TPoint;
 var calibr: TCalibr;
     points: TMyInfernalType;
begin
  if ToolButton20.Down then
  begin
    pnl.DrawMode:=dmNone;
    pnl.DrawMode:=dmTraceLines;
    pnl.CounLines:=2;
    repeat
      Application.ProcessMessages;
    until pnl.Finalized;
    pnl.DrawMode:=dmNone;
  end;
  ToolButton20.Down:=not ToolButton20.Down;
  points:=TMyInfernalType.Create;
  pnl.GetPathPoints(points);
  calibr:=TCalibr.Create(@(line1), @(line2), @(points));
  ShowMessage('h1 = '+FloatToStr(calibr.h1));
  calibr.Destroy;
  points.Destroy;
  {points:=TMyInfernalType.Create;
  pnl.GetPathPoints(points);
  interp:=TInterp.Create(points, @(int));
  interp.Run;

  Form3.Series1.Clear;
  for i:=0 to PMyInfernalType(interp.Line[0])^.w-1 do
    Form3.Series1.AddXY(i, PMyInfernalType(interp.Line[0])^.a^[i]);

  Form4.Series1.Clear;
  for i:=0 to PMyInfernalType(interp.Line[1])^.w-1 do
    Form4.Series1.AddXY(i, PMyInfernalType(interp.Line[1])^.a^[i]);

  interp.Destroy;
  points.Destroy;}
  {p1:=pnl.GetPoint1;
  p2:=pnl.GetPoint2;
  BilinInterp(int, trace, len, p1.x, p1.y, p2.x, p2.y);
  Form3.Series1.Clear;
  for i:=0 to len-1 do
    Form3.Series1.AddXY(i, trace^[i]);
  FreeMem(trace, len*sizeof(treal));}

end;

procedure TForm1.ToolButton26Click(Sender: TObject);
begin
{  if not int.loaded then
  begin
    ShowMessage('Интерферограммы незагружены');
    ToolButton34.Down:=false;
    exit;
  end;}

  if ToolButton34.Down then
  begin
    Form3.Show;
    Form4.Show;
    pnl.DrawMode:=dmNone;
    pnl.DrawMode:=dmLargeCross;
  end
  else
  begin
    Form3.close;
    Form4.close;
    pnl.DrawMode:=dmNone;
    pnl.Repaint;
  end;
//  ToolButton26.Down:= not ToolButton26.Down;
end;

procedure TForm1.Button1Click(Sender: TObject);
//var p: PMyInfernalType;
var s: string;
    min, max: integer;
    p1, p2: UINT;
    p3: int64;
begin
//  ToolButton42Click(Sender);
//  InitComThreadStart;
{  GetMem(p, sizeof(TMyInfernalType));
//  Caption:=IntToStr(sizeof(TMyInfernalType));
  p^:=TMyInfernalType.Create;
  p^.Init(100, 100, varDouble);
  p^.Clear;
  p^.Destroy;
  Freemem(p, sizeof(TMyInfernalType));}
//  Off(true);
//  ToolBar2.Enabled:=true;
// if not CommPortDriver1.Connect then
//   ShowMessage('Shit!');
//
// EscapeCommFunction(CommPortDriver1.ComHandle, 6);
// EscapeCommFunction(CommPortDriver1.ComHandle, 4);
//  WatchComThread.Suspend;
// Timer1.Enabled:=true;
//EscapeCommFunction(CommPortDriver1.ComHandle, 6);
//  s:='Проект1';
//  InputQuery('Новый проект', 'Имя проекта', s);



// VsLib3OptionGetScalarRange(vs.CInterfaceExpos, @min, @max, VSLIB3_SCALAR_UNIT_S, @vs.err);
// ShowMessage(IntToStr(min)+' '+IntToStr(max));
//  VsLib3InDInterfaceGetType(vs.InDInterface, vs.pDataHeader, @vs.err);
//  VsLib3OutDInterfaceGetType(vs.OutDInterface, vs.pDataHeader, vs.err);
//  VsLib3DataheaderGetType(vs.pDataHeader, p1, p2, p3, vs.err);

//  VsLib3DataheaderSetU32(vs.pDataHeader, VSLIB3_DATAHEADER_FIELD_PIXEL_BITS, 8, vs.err);

//  VsLib3OutDInterfaceSetType(vs.OutDInterface, vs.pDataHeader, vs.err);

//  VsLib3DataheaderGetU32(vs.pDataHeader, VSLIB3_DATAHEADER_FIELD_PIXEL_BITS, @min, @vs.err);

//  ShowMessage(IntToStr(min));
//  ShowMessage(IntToStr(p1)+' '+IntToStr(p2)+' '+IntToStr(p3));
//    EscapeCommFunction(CommPortDriver1.ComHandle, 5);


end;

procedure TForm1.PnlMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
var p1, p2: TPoint;
   // trace: PRealArray;
   p, m: PMyInfernalType;
   scl: treal;
   d, cnt1, cnt2, w, h, i, j: integer;
   mean1, mean2: treal;
begin
  if pnl.DrawMode = dmTraceLines then
  begin
    if (pnl._CurveMode = cvDrawMode) or ((pnl._CurveMode = cvEditMode) and (ssLeft in Shift)) then
    begin
      p1:=pnl.GetPoint1;
      p2:=pnl.GetPoint2;
      p:=GetCurrentArray;
      m:=GetCurrentMask;
      scl:=cfg.scl_eye;
      if not p^.loaded then exit;
      if not m^.loaded then exit;

      if (pnl._LineIndex = 1) and p^.loaded and (p^._type = varDouble) then
      begin
        case TraceLinesMode of
          tlmRZ: begin
                   BilinInterp(p^, m^, line1, line2, p1, p2);
//                   PolyFit(line1, line2, {cfg.poly_order}6);
                   Form5.Series1.Clear;
//                   Form5.Series2.Clear;
                   Find_Rz(line1, line2, Ra, Rz, Rmax);
//                   Form3.Series1.Clear;
                   for i:=0 to line1.w-1 do
                     if line2.b^[i] = 1 then
                     begin
                       Form5.Series1.AddXY(i*scl, line1.a^[i]);
//                       if line2.loaded then
//                         Form3.Series2.AddXY(i*scl, line2.a^[i]);
                     end
                     else
                       Form5.Series1.AddNullXY(i*scl, 0);

                   Form5.Chart1.Update;
                   RaRzRmaxForm.Label1.Caption:='Ra = '+ FloatToStrF(Ra, ffFixed, 5, 2)+' нм.';
                   RaRzRmaxForm.Label2.Caption:='Rz = '+ FloatToStrF(Rz, ffFixed, 5, 2)+' нм.';
                   RaRzRmaxForm.Label3.Caption:='Rmax = '+ FloatToStrF(Rmax, ffFixed, 5, 2)+' нм.';
                   RaRzRmaxForm.Label1.Update;
                   RaRzRmaxForm.Label2.Update;
                   RaRzRmaxForm.Label3.Update;
//                   Label1.Caption:='Ra = '+ FloatToStrF(Ra, ffFixed, 5, 2)+'нм; Rz = '+ FloatToStrF(Rz, ffFixed, 5, 2)+'нм; Rmax = '+
//                   FloatToStrF(Rmax, ffFixed, 5, 2)+'нм'; {; СКО = ' + FloatToStrF(_rms, ffFixed, 5, 1)+'нм.'};
//                   Label1.Update;
                 end;
          tlmH:  begin
                   d:=StrToInt(RaznForm.Edit1.Text) div 2;
                   BilinInterp(p^, m^, line1, line2, p1, p2);
                   w:=p^.w;
                   h:=p^.h;
                   mean1:=0;
                   mean2:=0;
                   cnt1:=0;
                   cnt2:=0;
                   for i:=p1.y-d to p1.y+d do
                     for j:=p1.x-d to p1.x+d do
                       if (i>=0) and (i<h) and (j>=0) and (j<w) then
                         if m^.b^[i*w+j]=1 then
                         begin
                           mean1:=mean1+p^.a^[i*w+j];
                           inc(cnt1);
                         end;

                   for i:=p2.y-d to p2.y+d do
                     for j:=p2.x-d to p2.x+d do
                       if (i>=0) and (i<h) and (j>=0) and (j<w) then
                         if m^.b^[i*w+j]=1 then
                         begin
                           mean2:=mean2+p^.a^[i*w+j];
                           inc(cnt2);
                         end;

                   if cnt1 <> 0 then
                     mean1:=mean1/cnt1
                   else
                     mean1:=0;
                   if cnt2 <> 0 then
                     mean2:=mean2/cnt2
                   else
                     cnt2:=0;

                   Form5.Series1.Clear;
                   for i:=0 to line1.w-1 do
                     if line2.b^[i] = 1 then
                       Form5.Series1.AddXY(i*scl, line1.a^[i])
                     else
                       Form5.Series1.AddNullXY(i*scl, 0);
                   Form5.Chart1.Update;

                   RaznForm.Label2.Caption:=#916+'x = '+FloatToStrF(abs((p1.x-p2.x)*scl), ffFixed, 5, 3)+ ' мкм.';
                   RaznForm.Label3.Caption:=#916+'y = '+FloatToStrF(abs((p1.y-p2.y)*scl), ffFixed, 5, 3)+ ' мкм.';
                   RaznForm.Label4.Caption:=#916+'z = '+FloatToStrF(abs(mean1-mean2), ffFixed, 5, 3)+ ' нм.';

                   RaznForm.Label2.Update;
                   RaznForm.Label3.Update;
                   RaznForm.Label4.Update;

                 end;
        end;

      end;
      if pnl._LineIndex = 2 then
      begin
        BilinInterp(int, line2, p1, p2);
        Form4.Series1.Clear;
        Form4.Series2.Clear;
        for i:=0 to line2.w-1 do
          Form4.Series1.AddXY(i, line2.a^[i]);
        Form4.Chart1.Update;
      end;
   //   FreeMem(trace, len*sizeof(treal));
    end;
  end;

  if (pnl.DrawMode = dmLargeCross) and (ssLeft in Shift) then
    PnlMouseDown(Sender, mbLeft, Shift, X, Y);
end;

procedure TForm1.ToolButton21Click(Sender: TObject);
var _fft: Tfftw;
    p: PMyInfernalType;
  //  tmp: TMyInfernalType;
begin
   p:=GetCurrentArray;
  _fft:=Tfftw.Create(p);
  _fft.FFTMode:=fmAchh;
  _fft.fft(@(fft));
//  _fft.ifft(@(fft));
  _fft.Destroy;
  ComboBox1.ItemIndex:=1;
  ComboBox1Change(Self);
//  tmp:=TMyInfernalType.Create;
//  tmp.Init(fft.h, fft.w, varByte, 1);
//  pnl.DrawImage(fft);
 // tmp.Destroy;

end;

function TForm1.GetCurrentArray: PMyInfernalType;
begin
  case CurrentMatrix of
    cmInt: Result:=@(int);
    cmUnwrap: Result:=@(final_phase);
    cmPhase: Result:=@(phase);
    cmAmp: Result:=@(amp);
    cmVideo_: Result:=@(buff);
  end;
  {case ComboBox1.ItemIndex of
    0: Result:=@(int);
    1: Result:=@(fft);
    2: Result:=@(phase);
    3: Result:=@(amp);
    4: Result:=@(unwrap);
  end;}
end;

procedure TForm1.ComboBox1Change(Sender: TObject);
var p: PMyInfernalType;
begin
  p:=GetCurrentArray;
  if p^.loaded then pnl.DrawImage(p^, p^);
end;

procedure TForm1.CommPortDriver1ReceiveData(Sender: TObject; DataPtr: Pointer;
  DataSize: Integer);
var b: byte;
begin
  b:=byte(DataPtr^);
  if b = $AF then
    SetEvent(ComEvent);

//  Label2.Caption:=IntToHex(b, 2);

end;

procedure TForm1.ToolButton29Click(Sender: TObject);
var p: PMyInfernalType;
    tmp: TMyInfernalType;
    i,j: integer;
    x,y, r, vol: TReal;
begin
  if ToolButton29.Down then
  begin
    pnl.DrawMode:=dmNone;
    pnl.DrawMode:=dmCirc;
    repeat
      Application.ProcessMessages;
    until pnl.DrawMode = dmNone;
  end;
  tmp:=TMyInfernalType.Create;

  p:=GetCurrentArray;
  pnl.GetMask(p, @(tmp));

  x:=0;
  y:=0;
  vol:=0;
  for i:=0 to p^.h-1 do
    for j:=0 to p^.w-1 do
      if tmp.b^[i*tmp.w+j] = 1 then
       begin
         x:=x+j*p^.a^[i*p^.w+j];
         y:=y+i*p^.a^[i*p^.w+j];
         vol:=vol+p^.a^[i*p^.w+j];
       end;
  x:=abs(x/vol-(p^.w div 2));
  y:=abs(y/vol-(p^.h div 2));
  r:=sqrt(sqr(p^.w)+sqr(p^.h))/sqrt(sqr(x)+sqr(y));
  ShowMessage('r = '+FloatToStr(r));
  tmp.Destroy;
  ToolButton29.Down:= not ToolButton29.Down;
end;

procedure TForm1.ToolButton30Click(Sender: TObject);
var p: PMyInfernalType;
    tmp: TMyInfernalType;
begin
  if ToolButton30.Down then
  begin
    pnl.DrawMode:=dmNone;
    pnl.DrawMode:=dmRect;
    repeat
      Application.ProcessMessages;
    until pnl.DrawMode = dmNone;
  end;
  tmp:=TMyInfernalType.Create;

  p:=GetCurrentArray;
  pnl.GetMask(p, @(tmp));
  pnl.DrawImage(p^, tmp);
  tmp.Destroy;
  ToolButton30.Down:= not ToolButton30.Down;
end;

procedure TForm1.ToolButton22Click(Sender: TObject);
var p: PMyInfernalType;
    tmp: TMyInfernalType;
    i,j: integer;
    x,y, r, vol: TReal;
begin
  if ToolButton22.Down then
  begin
    pnl.DrawMode:=dmNone;
    pnl.DrawMode:=dmCirc;
    repeat
      Application.ProcessMessages;
    until pnl.DrawMode = dmNone;
  end;
  tmp:=TMyInfernalType.Create;

  p:=GetCurrentArray;
  pnl.GetMask(p, @(tmp));

  x:=0;
  y:=0;
  vol:=0;
  for i:=0 to p^.h-1 do
    for j:=0 to p^.w-1 do
      if tmp.b^[i*tmp.w+j] = 1 then
       begin
         x:=x+j*p^.a^[i*p^.w+j];
         y:=y+i*p^.a^[i*p^.w+j];
         vol:=vol+p^.a^[i*p^.w+j];
       end;
  x:=abs(x/vol-(p^.w div 2));
  y:=abs(y/vol-(p^.h div 2));
  r:=sqrt(sqr(p^.w)+sqr(p^.h))/sqrt(sqr(x)+sqr(y));
  ShowMessage('r = '+FloatToStr(r));
  tmp.Destroy;
  ToolButton22.Down:= not ToolButton22.Down;
end;

procedure TForm1.ToolButton6Click(Sender: TObject);
var  i: integer;
     p: PMyInfernalType;
begin
  if ToolButton6.Down then
  begin
    Form5.Show;
    p:=GetCurrentArray;
    MakeHist(p, @(hist), @(x_hist), point(0,0), Point(p^.w-1, p^.h-1));
    with Form5 do
    begin


    end;

    for i:=0 to hist.w-1 do
      Form5.Series1.AddXY(x_hist.a^[i], hist.c^[i]);
    Form5.Chart1.Update;
  end
  else
    Form5.Close;
end;

procedure TForm1.ToolButton7Click(Sender: TObject);
var p1, p2: TPoint;
    i{, j}: integer;
    p: PMyInfernalType;
   // m, rms, sum: treal;
begin
  if ToolButton7.Down then
  begin
    pnl.DrawMode:=dmNone;
    pnl.DrawMode:=dmSimpleRect;
    repeat
      Application.ProcessMessages;
    until pnl.Finalized;
    pnl.DrawMode:=dmNone;
    p1:=pnl.GetPoint1;
    p2:=pnl.GetPoint2;
    p:=GetCurrentArray;
    MakeHist(p, @(hist), @(x_hist), p1, p2);
    Form5.Series1.Clear;
    for i:=0 to hist.w-1 do
      Form5.Series1.AddXY(x_hist.a^[i], hist.c^[i]);
   // form5.Chart1.LeftAxis.SetMinMax(0, form5.Series1.MaxYValue);
    Form5.Chart1.Update;
  end;
  ToolButton7.Down:= not ToolButton7.Down;
  {m:=0;
  sum:=0;
  for i:=0 to hist.w-1 do
  begin
    m:=x_hist.a^[i]*hist.c^[i]+m;
    sum:=hist.c^[i]+sum;
  end;
  m:=m/sum;
  rms:=0;
  for i:=0 to hist.w-1 do
  begin
    rms:=sqr(x_hist.a^[i]*hist.c^[i]-m)+rms;
  end;
  rms:=sqrt(rms)/sum;
  ShowMessage('mean = '+FloatToStr(m)+'; rms = '+FloatToStr(rms));
  mask_inner.Clear;
  mask_inner.Init(p^.h, p^.w, varByte);
  for i:=0 to p^.h-1 do
    for j:=0 to p^.w-1 do
      if p^.b^[i*p^.w+j] >= (m+rms) then
        mask_inner.b^[i*p^.w+j]:=1;
  pnl.DrawImage(mask_inner, mask_inner);}
end;

procedure TForm1.ToolButton8Click(Sender: TObject);
var
 p1, p2: TPoint;
 p, m: PMyInfernalType;
 mode: TDrawMode;
begin

    p:=GetCurrentArray;
    m:=GetCurrentMask;
    if (not p^.loaded) or (not m^.loaded) then
    begin
//      ToolButton37.Down:=false;
      exit;
    end;
    off(false);
//    ToolButton37.Down:=true;
    mode:=pnl.DrawMode;
    pnl.DrawMode:=dmNone;
    pnl.DrawMode:=dmSimpleRect;
    pnl.Cursor:=crMyShittyCursor;
    repeat
      Application.ProcessMessages;
    until pnl.Finalized;
    pnl.Cursor:=crDefault;
    pnl.DrawMode:=dmNone;
    p1:=pnl.GetPoint1;
    p2:=pnl.GetPoint2;

    p^.x_hist:=p1.x;
    p^.y_hist:=p1.y;
    p^.w_hist:=p2.x-p1.x+1;
    p^.h_hist:=p2.y-p1.y+1;
    pnl.DrawImage(p^, m^);
    pnl.DrawMode:=mode;

//    ToolButton37.Down:=false;
    UpdateLegendLabels;
    off(true);
end;

procedure TForm1.ToolButton9Click(Sender: TObject);
var p: PMyInfernalType;
   // b: boolean;
begin
  if ToolButton9.Down then
  begin
    Form5.Show;
    form5.start;
    repeat
      Application.ProcessMessages;
    until form5.mode = mdNone;
    p:=GetCurrentArray;
    p^.min_hist:=Form5.min;
    p^.max_hist:=Form5.max;
    p^.ColorScale:=byMinMax_hist;
    pnl.DrawImage(p^, p^);
  end;
  ToolButton9.Down:=not ToolButton9.Down;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
//  AlphaBlendValue:=TrackBar1.Position;
//  MoveMirrorCom(TrackBar1.Position);
end;

procedure TForm1.ToolButton2Click(Sender: TObject);
var p, m: PMyInfernalType;
begin
  p:=GetCurrentArray;
  m:=GetCurrentMask;
  {if not p^.loaded then exit;
  with p^ do
  begin
    x_hist:=x_img;
    y_hist:=y_img;
    w_hist:=w_img;
    h_hist:=h_img;
    ColorScale:=byArea_hist;
  end;}
  pnl.DrawImage(p^, m^);
  UpdateLegendLabels;
end;

procedure TForm1.PnlResize(Sender: TObject);
var p: PMyInfernalType;
begin
  if (cfg.CameraType = 'VideoScan') then
  begin
    p:=GetCurrentArray;
//    if p^.loaded then pnl.DrawImage(p^, mask_inner);
    {if VideoScanEnabled then
      pnl.SetVideoRect(vs.SizeX, vs.SizeY)
    else}
      pnl.SetVideoRect(cfg.cam_w, cfg.cam_h);
  end;

  if cfg.CameraType = 'DirectShow' then
  begin
    case CurrentMatrix of
      cmVideo_: begin
                  VidCap1.VideoRect:=CalcVideoRect;
                end;
      cmInt, cmUnwrap: begin
                         {p:=GetCurrentArray;
                         if p^.loaded then pnl.DrawImage(p^, p^);
                         pnl.SetVideoRect(p^.w, p^.h);}
                         pnl.SetVideoRect(cfg.cam_w, cfg.cam_h);
                       end;
    end;
  end;

end;

procedure TForm1.ToolButton5Click(Sender: TObject);
var pb: PByteArray;
    b: TBitmap;
    i, j, sum, count: integer;
{    filter: TFilter;
    contour: TContour;}
    x, y{, r}: TMyInfernalType;
    path: TPath;
    s: string;
    SearchRec: TSearchRec;
    obj: array of TStaticObj;
    col: array of TColor;
    _x, _y, _r: TReal;
begin
   b:=TBitmap.Create;
   s:=ExtractFilePath(Application.ExeName)+'GIDRO\DIN\LIN\S10\';
   x:=TMyInfernalType.Create;
   y:=TMyInfernalType.Create;


   FindFirst(s+'*.*', faAnyFile, SearchRec);
   count:=-1;
   repeat
     if ExtractFileExt(SearchRec.Name) <> '.bmp' then Continue;
     if count = -1 then
     begin
       x.Init(1, 1, varDouble);
       y.Init(1, 1, varDouble);
       inc(count);
     end
     else
     begin
       x.Add1D();
       y.Add1D();
       inc(count);
     end;
     b.LoadFromFile(s+SearchRec.Name);
     x.a^[count]:=0;
     y.a^[count]:=0;
     sum:=0;
     for i:=0 to b.Height-1 do
     begin
       pb:=b.ScanLine[i];
       for j:=0 to b.Width-1 do
       if pb^[j] >= 20 then
         begin
           x.a^[count]:=j*pb^[j]+x.a^[count];
           y.a^[count]:=i*pb^[j]+y.a^[count];
           sum:=pb^[j]+sum;
         end;
     end;
     x.a^[count]:=x.a^[count]/sum;
     y.a^[count]:=y.a^[count]/sum;
   //ShowMessage('x = '+FloatToStr(x)+#13#10+'y = '+FloatToStr(y));

   until (FindNext(SearchRec) <> 0);

   int.Clear;
   int.Init(b.Height, b.Width, varByte);
   b.Destroy;
   pnl.DrawImage(int, int);
   pnl.DrawMode:=dmStatic;
   SetLength(path, 2*(count+1)+4);
   SetLength(obj, count+3);
   SetLength(col, count+3);
   for i:=0 to count do
   begin
     path[2*i].x:=round(x.a^[i]);
     path[2*i].y:=round(y.a^[i]);
     path[2*i+1].x:=10;
     path[2*i+1].y:=10;
     obj[i]:=soCross;
     col[i]:=clGreen;
   end;
   MNK_Circle(x, y, _x, _y, _r);
   path[length(path)-4].x:=round(_x);
   path[length(path)-4].y:=round(_y);
   path[length(path)-3].x:=10;
   path[length(path)-3].y:=10;
   path[length(path)-2].x:=round(_x-_r);
   path[length(path)-2].y:=round(_y-_r);
   path[length(path)-1].x:=round(_x+_r);
   path[length(path)-1].y:=round(_y+_r);
   obj[length(obj)-2]:=soCross;
   obj[length(obj)-1]:=soCircle;
   col[length(obj)-2]:=clRed;
   col[length(obj)-1]:=clBlue;
   pnl.InitStatic(obj,  col, path);
   Finalize(path);
   Finalize(obj);
   Finalize(col);
   x.Destroy;
   y.Destroy;

   ShowMessage('Xc = '+FloatToStr(_x)+#13#10+'Yc = '+FloatToStr(_y));
{  with OpenDialog1 do
  begin
    Filter:='Bitmap (*.bmp)|*.bmp';
    DefaultExt:='*.bmp';
    InitialDir:=ExtractFilePath(Application.ExeName);
  end;

  if not OpenDialog1.Execute then exit;

  b:=TBitmap.Create;
  b.LoadFromFile(OpenDialog1.FileName);
  ClearArrays;
  int.Init(b.Height, b.Width, varByte);
  mask_inner.Init(b.Height, b.Width, varByte, 1);

  for i:=0 to int.h-1 do
  begin
    pb:=b.ScanLine[i];
    for j:=0 to int.w-1 do
      int.b^[i*int.w+j]:=pb^[j];
  end;
  b.Destroy;
  ComboBox1.ItemIndex:=1;
//  ComboBox1Change(Self);
  pnl.DrawImage(int, int);

  {filter:=TFilter.Create(int.h, int.w);
  filter.Init(int.b^);
  filter.RangOrder:=3;
  filter.border:=10;
  filter.threshold:=0.15;
  filter.Processing([ffRang, ffBinar]);
  filter.GetTbtMask(mask_inner.b^, false);
  filter.Destroy;

  contour:=TContour.Create(mask_inner.h,mask_inner.w);
  contour.threshold:=1000;
  contour.Processing(mask_inner);
  contour.nearest:=true;
  contour.CreateMaskByDistance(mask_inner, mask_inner.w div 2, mask_inner.h div 2);
  contour.Destroy;
  MNK_Circle(mask_inner.b^, x, y, r, mask_inner.w, mask_inner.h);
  pnl.DrawImage(mask_inner, mask_inner);
  pnl.DrawMode:=dmStatic;
  SetLength(path, 4);
  path[0].x:=round(x-r);
  path[0].y:=round(y-r);
  path[1].x:=round(x+r);
  path[1].y:=round(y+r);
  path[2].x:=round(x);
  path[2].y:=round(y);
  path[3].x:=30;
  path[3].y:=30;
  pnl.InitStatic([soCircle, soCross], [clRed, clGreen], path);
  Finalize(Path);}


 // ShowMessage('x = '+FloatToStr(x)+#13#10+'y = '+FloatToStr(y)+#13#10+'r = '+FloatToStr(r));
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var lpModemStat: cardinal;
begin
{  lpModemStat:=0;
  GetCommModemStatus(CommPortDriver1.ComHandle, lpModemStat);
  Label2.Font.Color:=clBlack;
  Label3.Font.Color:=clBlack;

  if lpModemStat = $80 then
    Label2.Font.Color:=clRed;

  if lpModemStat = $40 then
    Label3.Font.Color:=clRed;
 }
 ResetEvent(ComEvent);
 Shift(0, 10, true, true, true);

 lpModemStat:=WaitForSingleObject(ComEvent, 500);
                 {
 if lpModemStat = WAIT_TIMEOUT then
 begin
   ComEnabled:=false;
   label4.Caption:='false';
 end;

 if (lpModemStat = WAIT_OBJECT_0) and (not ComEnabled) then
 begin
   ComEnabled:=true;
   Timer1.Enabled:=false;
   label4.Caption:='true';
//   InitComThreadStart;
 end;
  }

end;

procedure TForm1.ToolButton10Click(Sender: TObject);
var pb: PByteArray;
    b: TBitmap;
    i, j, sum, count: integer;
    x, y: TMyInfernalType;
    s: string;
    SearchRec: TSearchRec;
    mean_x, mean_y, rms_x, rms_y: treal;
begin
   b:=TBitmap.Create;
   s:=ExtractFilePath(Application.ExeName)+'GIDRO\STAT\3\';
   x:=TMyInfernalType.Create;
   y:=TMyInfernalType.Create;


   FindFirst(s+'*.*', faAnyFile, SearchRec);
   repeat
     if ExtractFileExt(SearchRec.Name) <> '.bmp' then Continue;
     if not x.loaded then
     begin
       x.Init(1, 1, varDouble);
       y.Init(1, 1, varDouble);
       count:=0;
     end
     else
     begin
       x.Add1D();
       y.Add1D();
       inc(count);
     end;
     b.LoadFromFile(s+SearchRec.Name);
     x.a^[count]:=0;
     y.a^[count]:=0;
     sum:=0;
     for i:=0 to b.Height-1 do
     begin
       pb:=b.ScanLine[i];
       for j:=0 to b.Width-1 do
       if pb^[j] >= 45 then
         begin
           x.a^[count]:=j*pb^[j]+x.a^[count];
           y.a^[count]:=i*pb^[j]+y.a^[count];
           sum:=pb^[j]+sum;
         end;
     end;
     x.a^[count]:=x.a^[count]/sum;
     y.a^[count]:=y.a^[count]/sum;

   until (FindNext(SearchRec) <> 0);

   mean_x:=0;
   mean_y:=0;
   for i:=0 to x.w-1 do
   begin
     mean_x:=x.a^[i]+mean_x;
     mean_y:=y.a^[i]+mean_y;
   end;
   mean_x:=mean_x/x.w;
   mean_y:=mean_y/x.w;
   rms_x:=0;
   rms_y:=0;
   for i:=0 to x.w-1 do
   begin
    rms_x:=sqr(x.a^[i]-mean_x)+rms_x;
    rms_y:=sqr(y.a^[i]-mean_y)+rms_y;
   end;
   rms_x:=sqrt(rms_x/(x.w-1));
   rms_y:=sqrt(rms_y/(x.w-1));

   ShowMessage('Xcp = '+FloatToStr(mean_x)+ '; Rms_x = '+ FloatToStr(rms_x)+#13#10+'Ycp = '+FloatToStr(mean_y)+'; Rms_y = '+ FloatToStr(rms_y));

   b.Destroy;
   x.Destroy;
   y.Destroy;

end;

procedure TForm1.ToolButton11Click(Sender: TObject);
var i, j: integer;
    {mean, rms,} k, x0, y0, t, Rs, r, h, N0: TReal;
begin
  Randomize;
  k:=35/576;
  phase.Clear;
  phase.Init(576, 768, varDouble);
  mask_inner.Clear;
  mask_inner.Init(576, 768, varByte, 0);
  x0:=phase.w div 2;
  y0:=phase.h div 2;
  Rs:=8e3;                              //радиус сферы
  r:=8;                                 //радиус сферической поверхности
  h:=Rs-sqrt(sqr(Rs)-sqr(r));           //стрелка
  N0:=1e-4;
  for i:=0 to phase.h-1 do
    for j:=0 to phase.w-1 do
    begin
      t:=sqr(Rs)-sqr(k*(j-x0))-sqr(k*(i-y0));
      t:=Rs-h-sqrt(t);
      if t<= 0 then
      begin
        phase.a^[i*phase.w+j]:=t+N0*sqrt(-2*ln(random))*sin(2*pi*random);
        mask_inner.b^[i*mask_inner.w+j]:=1;
      end
      else
        phase.a^[i*phase.w+j]:=0;
    end;

//      phase.a^[i*phase.w+j]:=sqrt(-2*ln(random))*sin(2*pi*random);
  MNK_Sphere(phase.a^, mask_inner.b^, x0, y0, t, r, k+0.3e-3, phase.w, phase.h);

  ComboBox1.ItemIndex:=2;
  ComboBox1Change(Self);
  ShowMessage(FloatToStr(r));
  //MeanRms(phase, phase, mean, rms);
  //ShowMessage('mean = '+FloatToStr(mean)+#13#10+'rms = '+FloatToStr(rms));
//  pnl.DrawImage(phase, phase);
end;

procedure TForm1.ToolButton12Click(Sender: TObject);
var _fft: Tfftw;
    p: PMyInfernalType;
    i,j: integer;
    x0, y0, r, _r, t, mean, rms: treal;
begin
  p:=GetCurrentArray;
  _fft:=Tfftw.Create(p);
  _fft.FFTMode:=fmAchh;
  _fft.fft(@(fft));
  r:=1000;
  p:=_fft.Get;
  x0:=p^.w div 4;
  y0:=p^.h div 2;
  for i:=0 to p^.h-1 do
    for j:=0 to (p^.w div 2)-1 do
    begin
      _r:=sqrt(sqr(x0-j)+sqr(y0-i));
      if  _r > r then
      begin
        p^.a^[i*p^.w+2*j]:=0;
        p^.a^[i*p^.w+2*j+1]:=0;
      end
      else
      begin
        t:=0.5*(1-cos(pi*_r/r+pi));
        p^.a^[i*p^.w+2*j]:=p^.a^[i*p^.w+2*j]*t;
        p^.a^[i*p^.w+2*j+1]:=p^.a^[i*p^.w+2*j]*t;
      end;
//      fft.a^[i*fft.w+j]:=sqrt(sqr(p^.a^[i*p^.w+2*j])+sqr(p^.a^[i*p^.w+2*j+1]));
    end;
  _fft.ifft(@(fft));
  _fft.Destroy;

  ComboBox1.ItemIndex:=1;
  ComboBox1Change(Self);
  MeanRms(fft, fft, mean, rms);
  ShowMessage('mean = '+FloatToStr(mean)+#13#10+'rms = '+FloatToStr(rms));
end;

procedure TForm1.Action4Execute(Sender: TObject);
begin
  ShowMessage('Hello');
end;

procedure TForm1.Action6Execute(Sender: TObject);
begin
{}
end;

procedure TForm1.Action3Execute(Sender: TObject);
begin
{}
end;

procedure TForm1.Action7Execute(Sender: TObject);
begin
{}
end;

procedure TForm1.Binfile1Click(Sender: TObject);
var s: string;
    p: PMyInfernalType;
begin
  p:=GetCurrentArray;
  if not p^.loaded then
    exit;

//  if (not final_phase.loaded) or (not final_mask.loaded)then
//    exit;

  SaveDialog1.Filter:='Bin files|*.bin';
  SaveDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  if not SaveDialog1.Execute then
    exit;

  s:=SaveDialog1.FileName;
  s:=ChangeFileExt(s, '.bin');


  CreateBin(p^, {final_mask} mask_inner, s);

end;

procedure TForm1.ToolButton27Click(Sender: TObject);
begin

end;

{ TRunThread }

procedure TRunThread.Draw;
begin
  with form1 do
  case mm of
    0:  pnl.DrawImage(phase, final_mask);
    1: begin
         CurrentMatrix:=cmUnwrap;
         pnl.DrawImage(unwrap, final_mask);
         UpdateLegendLabels;
       end;
    2: begin
         CurrentMatrix:=cmUnwrap;
         pnl.DrawImage(unwrap, final_mask);
         UpdateLegendLabels;
         ShowMessage('Высота ступеньки = ' + FloatToStrF(razn, ffFixed, 5, 3)+' нм.');
//         Label1.Caption:='Высота ступеньки = ' + FloatToStrF(razn, ffFixed, 5, 3)+' нм.';
//         _pv:=abs(pnl.Top_Level-pnl.Bottom_Level);
//         Label1.Caption:='Выборочное СКО = '+ FloatToStrF(_rms, ffFixed, 5, 1)+' нм. '
//         +'|max-min| = '+ FloatToStrF(_pv, ffFixed, 5, 1)+ ' нм.' ;
       end;
  end;
end;

procedure TRunThread.Execute;
var {s: string;}
    i, j, w, h, cnt1, cnt2: integer;
//    min, max: treal;
//    temp: TMyInfernalArray;
    temp: TPointerArray;
    min, max, mean1, mean2: treal;
    p: PRealArray;
    _base, base_mask: TMyInfernalType;
begin

  with cfg do
  begin
    w:=cfg.cam_w;
    h:=cfg.cam_h;
    SetLength(temp, steps);

  {  if (int.w = int.w_img) and (int.h = int.h_img) then
    begin
      int.w_img:=int.w-10;
      int.h_img:=int.h-10;
      int.x_img:=5;
      int.y_img:=5;
    end;}
    for i:=0 to steps-1 do
    begin
      GetMem(temp[i], w*h);
 //     temp[i]:=TMyInfernalType.Create;
 //     temp[i].Init(0, 0, varByte);
    end;
//      GetMem(temp[i], int.w_img*int.h_img*sizeof(tbt));

    final_mask.Clear;
    final_mask.Init(h, w, varByte);

    for i:=10 to h-9 do
      for j:=10 to w-9 do
        final_mask.b^[i*w+j]:=1;


    form1.LoadBitmaps(temp);
    FindPhase(phase, final_mask, temp, cfg.steps);
    for i:=0 to steps-1 do
      FreeMem(temp[i], w*h);
     // temp[i].Destroy;
//     FreeMem(temp[i], int.w_img*int.h_img*sizeof(tbt));
    Finalize(temp);
    mm:=0;
    Synchronize(Draw);

    UnWrapPhaseSt(w div 2, h div 2, w, h, phase.a^, unwrap.a^, final_mask.b^);


    if invert then
      for i:=0 to w*h-1 do
        unwrap.a^[i]:=-unwrap.a^[i];



    if base and FileExists(ExtractFilePath(Application.ExeName)+'base.bin') then
    begin
      _base:=TMyInfernalType.Create;
      base_mask:=TMyInfernalType.Create;

      LoadBin(_base, base_mask, ExtractFilePath(Application.ExeName)+'base.bin');
      for i:=0 to w*h-1 do
        final_mask.b^[i]:=final_mask.b^[i]*base_mask.b^[i];

      for i:=0 to h-1 do
        for j:=0 to w-1 do
        if final_mask.b^[i*w+j] = 1 then
          unwrap.a^[i*w+j]:=unwrap.a^[i*w+j]-_base.a^[i*w+j];

      _base.Destroy;
      base_mask.Destroy;
    end;

    mm:=1;
    Synchronize(Draw);

    for i:=0 to w*h-1 do
    begin
      mask_inner.b^[i]:=mask_inner.b^[i]*final_mask.b^[i];
      mask_outer.b^[i]:=mask_outer.b^[i]*final_mask.b^[i];
    end;

    ZeroMemory(final_mask.b, w*h);

    for i:=0 to w*h-1 do
      if (mask_inner.b^[i]=1) or (mask_outer.b^[i]=1) then
        final_mask.b^[i]:=1;

    if cfg.tilt then
      TiltRemove(unwrap.a^, mask_inner.b^, final_mask.b^, h, w);

    for i:=0 to w*h-1 do
      unwrap.a^[i]:=unwrap.a^[i]*cfg.lambda/(4*Pi);

   // GaussFilter(unwrap.a^, final_mask.b^, 7, w, h);




   { for i:=0 to unwrap.h-1 do
     for j:=0 to unwrap.w-1 do
        unwrap.a^[i*unwrap.w+j]:=unwrap.a^[i*unwrap.w+j]*cfg.lambda/(4*Pi);

    GetMem(p, (unwrap.w-4)*(unwrap.h-4)*sizeof(treal));
    for i:=2 to unwrap.h-3 do
     for j:=2 to unwrap.w-3 do
       p^[(i-2)*(unwrap.w-4)+j-2]:=unwrap.a^[i*unwrap.w+j];
    unwrap.Clear;
    unwrap.Init(phase.h-4, phase.w-4, varDouble);
    CopyMemory(unwrap.a, p, unwrap.w*unwrap.h*sizeof(treal));
    FreeMem(p, unwrap.w*unwrap.h*sizeof(treal));}




  //  GaussFilter(unwrap, 3);
{    case input of
      1: GaussFilter(unwrap, 3);
      2: GaussFilter(unwrap, 7);
    end;}
   { FindMin_Max(min, max, unwrap.a^, mask_inner.b^, unwrap.w, unwrap.h);
    for i:=0 to unwrap.h-1 do
      for j:=0 to unwrap.w-1 do
        if mask_inner.b^[i*mask_inner.w+j] = 1 then
          unwrap.a^[i*unwrap.w+j]:=unwrap.a^[i*unwrap.w+j]-min;

    mask_inner.Clear;
    _rms:=RMS(unwrap, unwrap);                                 }

{    unwrap.w_hist:=unwrap.w_hist-4;
    unwrap.h_hist:=unwrap.h_hist-4;
    unwrap.x_hist:=2;
    unwrap.y_hist:=2;}

    cnt1:=0;
    cnt2:=0;
    mean1:=0;
    mean2:=0;
    for i:=0 to w*h-1 do
    begin
      if mask_inner.b^[i]=1 then
      begin
        mean1:=mean1+unwrap.a^[i];
        inc(cnt1);
      end;

      if mask_outer.b^[i]=1 then
      begin
        mean2:=mean2+unwrap.a^[i];
        inc(cnt2);
      end;
    end;
    mean1:=mean1/cnt1;
    mean2:=mean2/cnt2;
    razn:=Abs(mean1-mean2);

    mm:=2;
    Synchronize(Draw);
  end;

  inherited;

end;

procedure TForm1.Action2Execute(Sender: TObject);
{var SEInfo: TShellExecuteInfo;
    ExitCode: DWORD;
    ExecuteFile: string;}
var ret, i: cardinal;

begin
  if cfg.Com_phase_shift and (not ComConnected) then
    exit;
  if cfg.ComMode and (not ComConnected) then
    exit;

  if cfg.ComMode then
  begin
   { ResetEvent(ComEvent);
    Shift(0, 10, true, true, true);

   for i:=0 to 9 do
   begin
     Application.ProcessMessages;
     ret:=WaitForSingleObject(ComEvent, 100);
     if ret =WAIT_OBJECT_0 then
       break;
   end;

   if ret = WAIT_TIMEOUT then
   begin
     ShowMessage('Осветительный блок не подключен!');
     exit;
   end; }

    cfg.m_shift:=cfg.Shifts[cfg.LazerNum];
    InitComThreadStart;
  end;

  pnl.InterpMode:=imNearest;
  from:=fromCamera;
  CurrentMatrix:=cmInt;
  _rms:=0;
  _pv:=0;
  Ra:=0;
  Rz:=0;
  Rmax:=0;

  if cfg.CameraType = 'VideoScan' then
  begin

    if vs.run then
    begin
      ShowMessage('Видеопоток уже запущен!');
      exit;
    end;
    if not VideoScanEnabled then
      exit;

    int.Clear;
    int.Init(vs.SizeY, vs.SizeX, varByte);
    mask_inner.Clear;
    mask_inner.Init(vs.SizeY, vs.SizeX, varByte, 1);
    cfg.cam_w:=vs.SizeX;
    cfg.cam_h:=vs.SizeY;
    cfg.scl_eye:=(cfg.w1/cfg.cam_w+cfg.h1/cfg.cam_h)/2;

    Off(false);
    n2.Enabled:=true;
    n80.Enabled:=true;
    form9.Label6.Caption:=cfg.img_path;
    form9.Label6.Hint:=cfg.img_path;
    form9.ScrollBar3.Position:=cfg.transp;

    CurrentMatrix:=cmVideo_;
    VideoCaptureMode:=cmVideo;
    VideoCaptureSeqThread:=TVideoCaptureSeqThread.Create(true);
    VideoCaptureSeqThread.FreeOnTerminate:=true;
    VideoCaptureSeqThread.Start;

    if cfg.Com_phase_shift then
    begin
      form9.ScrollBar2.Max:=4095;
    end;

    if cfg.Com_Step_Motor then
    begin
      form9.ScrollBar2.Visible:=false;
      form9.Label3.Visible:=false;
      Form9.ed2.Visible:=false;
      form9.Button6.Visible:=true;
      form9.Button7.Visible:=true;
      form9.Button8.Visible:=true;
      form9.Button9.Visible:=true;
      form9.Label7.Visible:=true;
      form9.Label8.Visible:=true;
      form9.Label7.Caption:='Текущее положение '+IntToStr(cfg.Step_Motor_Curr_Pos);
      form9.label8.Caption:='Диапазон сдвига '+IntToStr(cfg.Step_Motor_Shift);

    end;

    Form9.Show;
  end;

  if cfg.CameraType = 'DirectShow' then
  begin
    CurrentMatrix:=cmVideo_;
    VidCap1.Run;
    VidCap1.VideoRect:=CalcVideoRect;
    VidCap1.GetResolution(cfg.cam_w, cfg.cam_h);

    int.Clear;
    int.Init(cfg.cam_h, cfg.cam_w, varByte);
    mask_inner.Clear;
    mask_inner.Init(cfg.cam_h, cfg.cam_w, varByte, 1);
    cfg.scl_eye:=(cfg.w1/cfg.cam_w+cfg.h1/cfg.cam_h)/2;

    Off(false);


    if cfg.Com_phase_shift then
      DirectShowVideoForm.ScrollBar2.Max:=4095;

    DirectShowVideoForm.ScrollBar2.Position:=cfg.m_shift;
    DirectShowVideoForm.Label1.Caption:=inttostr(cfg.m_shift);
    DirectShowVideoForm.Show;
  end;
{  ExecuteFile:= ExtractFilePath(Application.ExeName)+'Capture\TVMicro_2p.exe';
  FillChar(SEInfo, SizeOf(SEInfo), 0);
  SEInfo.cbSize:= SizeOf(TShellExecuteInfo);
  with SEInfo do
  begin
    fMask:=SEE_MASK_NOCLOSEPROCESS;
    lpFile:=PChar(ExecuteFile);
    nShow:=SW_SHOWNORMAL;
  end;
  if ShellExecuteEx(@SEInfo) then
  begin
    Off(false);
    repeat
      Application.ProcessMessages;
      GetExitCodeProcess(SEInfo.hProcess, ExitCode);
    until (ExitCode <> STILL_ACTIVE) or Application.Terminated;
    from:=fromCamera;
    InitialiseArrays;
    Off(true);
  end
  else
  begin
    ShowMessage('Ошибка запуска программы захвата');
    exit;
  end;

  from:=fromCamera;
  InitialiseArrays;}

end;

procedure TForm1.ReadParams;
var l: TStringList;
    s: string;
begin
  l:=TStringList.Create;
  l.BeginUpdate;
  l.LoadFromFile(ExtractFilePath(Application.ExeName)+'capture\param.txt');
  l.EndUpdate;
  s:=l.Strings[2];
  cfg.steps:=StrToInt(copy(s, 1, pos(';', s)-1));
  s:=l.Strings[1];
  cfg.mean:=StrToInt(copy(s, 1, pos(';', s)-1));
  s:=l.Strings[7];
  cfg.input:=StrToInt(copy(s, 1, pos(';', s)-1));
  l.Destroy;

end;

procedure TForm1.RMS1Click(Sender: TObject);
var min, max: treal;
begin
  if not final_phase.loaded then
    exit;
  _rms:=RMS(final_phase, mask_inner);

  FindMin_Max(min, max, final_phase.a^, mask_inner.b^, final_phase.w, final_phase.h);
  _pv:=abs(max-min);

  ShowMessage('Rms = '+FloatToStrF(_rms, ffFixed, 7, 3)+' нм.' + #13#10+#13#10+
  'PV = '+ FloatToStrF(_pv, ffFixed, 7, 3)+' нм.');

end;

procedure TForm1.Rz1Click(Sender: TObject);
var mode: TDrawMode;
begin
  if not int.loaded then
  begin
    ShowMessage('Интерферограммы незагружены');
    exit;
  end;
  if not unwrap.loaded then
  begin
    ShowMessage('Расчет не проведен');
    exit;
  end;
  Off(False);
  mode:=pnl.DrawMode;
  TraceLinesMode:=tlmRZ;
  Form5.Show;

  RaRzRmaxForm.Show;
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmTraceLines;
  pnl.CounLines:=1;
  pnl.SetScale_x(cfg.scl_eye);
  pnl.Cursor:=crMyShittyCursor;

  repeat
    Application.ProcessMessages;
  until pnl.Finalized;

  pnl.Cursor:=crDefault;
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=mode;

  RaRzRmaxForm.Close;
  Form5.Close;

  Off(true);
end;

procedure TForm1.Action21Execute(Sender: TObject);
begin
  CurrentMatrix:=cmInt;
 if int.loaded then pnl.DrawImage(int, int);
end;

procedure TForm1.Action22Execute(Sender: TObject);
begin
  CurrentMatrix:=cmUnwrap;
  if unwrap.loaded then pnl.DrawImage(unwrap, unwrap);
end;

procedure TForm1.LoadParams;
var f: file;
begin
  System.Assign(f, ExtractFilePath(Application.ExeName)+'phast.sys');
  System.Reset(f, sizeof(tconfig));
  BlockRead(f, cfg, 1);
  System.Close(f);
end;

procedure TForm1.SaveParams;
var f: file;
begin
  System.Assign(f, ExtractFilePath(Application.ExeName)+'phast.sys');
  System.Rewrite(f, sizeof(tconfig));
  BlockWrite(f, cfg, 1);
  System.Close(f);
end;

procedure TForm1.SetLazer;
var dist, ShiftTo: integer;
begin
  ShiftTo:=cfg.LazerPos[cfg.LazerNum];
  dist:=ShiftTo-LazPos;

  if dist > 0 then
    Shift(dist, 30, true, false, true);

  if dist < 0 then
    Shift(abs(dist), 30, true, true, true);

  LazPos:=ShiftTo;
end;

procedure TForm1.Shift(steps, f: integer; mode, dir, enable: boolean);
var val: word;
    n: integer;
    m: byte;
begin
  if f > 120 then
    n:=1;
  if (f >= 2) and (f <= 120) then
    n:=64;
  val:=$FFFF-round(7372800/(f*n));

  m:=0;
  if enable then SetBit(m, 0);

  if mode then SetBit(m, 1);

  if dir then SetBit(m, 2);

  if n = 64 then SetBit(m, 4);

  SetBit(m, 3);

  _buff[0]:=HiByte(val);
  _buff[1]:=LowByte(val);
  _buff[2]:=HiByte(steps);
  _buff[3]:=LowByte(steps);
  _buff[4]:=m;


  CommPortDriver1.SendData(@(_buff), 5);

  if dir then
    cfg.Step_Motor_Curr_Pos:=cfg.Step_Motor_Curr_Pos+steps
  else
    cfg.Step_Motor_Curr_Pos:=cfg.Step_Motor_Curr_Pos-steps;

end;

procedure TForm1.test1Click(Sender: TObject);
{ var s: AnsiString;
     pt: pointer;
     q1, q2: array of integer;
     s1: string;
     i: integer;}
begin
    {
  pt:= ptree_init;
                       s:='node1.node2';
  ptree_set_string(pt, @s, 'Some Text');

  ptree_write_xml(pt, 'e:\temp.xml');
  ptree_shutdown(pt);
  exit;
  }
//  SaveDialog1.Filter:='*.winPhast| winPhast project files';
//  SaveDialog1.FileName:= ProjectData.prop_.file_name;

//  if not SaveDialog1.Execute() then
//    exit;

//  s:= SaveDialog1.FileName;
//  ChangeFileExt(s, '.winPhast');


//  ShowMessage( IntToStr(MessageDlg('Проект не сохранен. Сохранить?', mtConfirmation, mbYesNo, 0)));
//  exit;
  SaveProject(ProjectData);

  {
  p:= ptree_init();
  ptree_set_int(p, 'shit.int_value', 10);
  ptree_set_double(p, 'shit.double_value', 1123.234);
  ptree_set_string(p, 'shit.string', 'string_value');
  ptree_write_xml(p, 'e:\\temp.xml');
  ptree_shutdown(p);
  }

end;

procedure TForm1.ToolButton33Click(Sender: TObject);
begin



  with form6, cfg do
  begin
    ed[0].Text:=FloatToStr(h1);
    ed[1].Text:=FloatToStr(w1);
   // ed[2].Text:=IntToStr(h2);
   // ed[3].Text:=IntToStr(w2);
    ed[4].Text:=FloatToStr(lambda);
    ed[5].Text:=FloatToStr(z);
    ed[6].Text:=IntToStr(steps);
    ed1.Text:=IntToHex(port, 4);
    ComboBox1.ItemIndex:=q-1;
    ComboBox2.ItemIndex:=pal;
    //RadioGroup2.ItemIndex:=input-1;
    CheckBox1.Checked:=tilt;
//    CheckBox2.Checked:=int_filtr;
    Edit1.Text:=img_path;
//    SpinEdit1.Value:=poly_order;
    CheckBox3.Checked:=base;
    CheckBox4.Checked:=invert;
    CheckBox5.Checked:=do_seq;
    CheckBox6.Checked:=do_mean;
    CheckBox7.Checked:=do_step;
    CheckBox8.Checked:=do_gauss;
    CheckBox9.Checked:=do_unwrap;
    CheckBox10.Checked:=do_phase2z;
    CheckBox11.Checked:=UnwrapPhaseSeparately;
    CheckBox12.Checked:=FinalMaskFullScreen;
    CheckBox13.Checked:=not AverageSerie;

    Edit14.Text:=IntToStr(PhaseShiftPause);
    Edit3.Text:=IntToStr(SeriesPause);
    Edit4.Text:=IntToStr(num_seq);
    Edit5.Text:=IntToStr(num_mean);
    Edit6.Text:=FloatToStr(step_height);
    Edit7.Text:=FloatToStr(gauss_cut_off);
    CheckBox2.Checked:=do_filtr;
    Edit2.Text:=FloatToStr(gauss_aper);

    Edit8.Text:=FloatToStr(_t);
    Edit9.Text:=FloatToStr(_p);
    Edit12.Text:=FloatToStr(_f);
    Edit10.Text:=FloatToStr(n_ref);
    Edit11.Text:=FloatToStr(b_ref);
    Edit13.Text:=FloatToStr(b_rab);
    Edit19.Text:=IntToStr(r);
    Edit20.Text:=IntToStr(r0);
    Edit21.Text:=IntToStr(r1);


    Label31.Caption:=base_path;
    Label31.Hint:=base_path;
    RadioGroup1.ItemIndex:=TiltMask;

    Edit15.Text:=IntToStr(Fizo_pedestal);
    Edit16.Text:=IntToStr(Fizo_amp);
    Edit17.Text:=IntToStr(Fizo_t);
    Edit18.Text:=IntToStr(Fizo_Frames);

    if cfg.ComMode then
    begin
      ComboBox3.Visible:=true;
      Label28.Visible:=true;
      Label5.Visible:=false;
      Label6.Visible:=false;
      ComboBox3.Items.Clear;
      ComboBox3.Items.Add({'Синий '+}FloatToStr(cfg.LazerLambda[0])+' нм.');
      ComboBox3.Items.Add({'Зеленый '+}FloatToStr(cfg.LazerLambda[1])+' нм.');
      ComboBox3.Items.Add({'Красный '+}FloatToStr(cfg.LazerLambda[2])+' нм.');
      ComboBox3.ItemIndex:=cfg.LazerNum;
    end;

    if cfg.Com_phase_shift then
    begin
      Label16.Visible:=false;
      ed1.Visible:=false;
    end;



  //  CheckBox3.Checked:=save_bmp_int;
    if ShowModal <> mrOk then
      exit;

    h1:=StrToFloat(ed[0].Text);
    w1:=StrToFloat(ed[1].Text);
    lambda:=StrToFloat(ed[4].Text);
    q:=ComboBox1.ItemIndex+1;
    pal:=ComboBox2.ItemIndex;
    z:=CheckString(ed[5].Text);
    tilt:=CheckBox1.Checked;
    img_path:=Edit1.Text;
    base_path:=Label31.Caption;

    steps:=StrToInt(ed[6].Text);
    port:=StrToInt('$'+ed1.Text);

    base:=CheckBox3.Checked;
    invert:=CheckBox4.Checked;
    do_seq:=CheckBox5.Checked;
    num_seq:=StrToInt(Edit4.Text);
    do_mean:=CheckBox6.Checked;
    do_step:=CheckBox7.Checked;
    do_gauss:=CheckBox8.Checked;
    do_unwrap:=CheckBox9.Checked;
    do_phase2z:=CheckBox10.Checked;
    UnwrapPhaseSeparately:=CheckBox11.Checked;
    FinalMaskFullScreen:=CheckBox12.Checked;
    AverageSerie:=not CheckBox13.Checked;

    num_mean:=StrToInt(Edit5.Text);
    SeriesPause:=StrToInt(Edit3.Text);
    PhaseShiftPause:=StrToInt(Edit14.Text);
    do_filtr:=CheckBox2.Checked;
    gauss_cut_off:=CheckString(Edit7.Text);
    gauss_aper:=CheckString(Edit2.Text);
    r:=StrToInt(Edit19.Text);
    r0:=StrToInt(Edit20.Text);
    r1:=StrToInt(Edit21.Text);

    step_height:=CheckString(Edit6.Text);

    scl_eye:=(w1/cam_w+h1/cam_h)/2;

    cfg.LazerNum:=ComboBox3.ItemIndex;
    TiltMask:=RadioGroup1.ItemIndex;

    if ComConnected and (cfg.ComMode) then
    begin
//      WatchComThread.SetLazer:=true;
      cfg.lambda:=cfg.LazerLambda[cfg.LazerNum];
      cfg.m_shift:=cfg.Shifts[cfg.LazerNum];
    end;
//    SetLazerThreadStart;

    Fizo_pedestal:=StrToInt(Edit15.Text);
    Fizo_amp:=StrToInt(Edit16.Text);
    Fizo_t:=StrToInt(Edit17.Text);
    Fizo_Frames:=StrToInt(Edit18.Text);



  end;
end;

procedure TForm1.LoadBitmaps(p: TPointerArray);
var i,j,k{,l}: integer;
    pb: PByteArray;
    bmp: TBitmap;
  //  temp: PRealArray;
begin
  bmp:=TBitmap.Create;
  with cfg, int do
    case from of
      fromHDD:  for k:=0 to steps-1 do
                begin

                  bmp.LoadFromFile(Form2.ListView2.Items[k].SubItems[1]);
                  for i:=y_img to y_img+h_img-1 do
                  begin
                    pb:=bmp.ScanLine[i];
                    for j:=x_img to x_img+w_img-1 do
                      p[k]^[(i-y_img)*w_img+j-x_img]:=pb^[j];
                  end;
                end;
      fromCamera: begin
                //    GetMem(temp, w_img*h_img*sizeof(treal));
                    for k:=0 to steps-1 do
                    begin
                      bmp.LoadFromFile(format(cfg.img_path+'\cadr_i%d_s%d_c%d.bmp',[1, k+1, 1]));
                      {ZeroMemory(temp, w_img*h_img*sizeof(treal));
                      for l:=1 to mean do
                      begin}
                      for i:=y_img to y_img+h_img-1 do
                      begin
                        pb:=bmp.ScanLine[i];
                        for j:=x_img to x_img+w_img-1 do
                          p[k]^[(i-y_img)*w_img+j-x_img]:=pb^[j];
                         //   temp^[(i-y_img)*w_img+j-x_img]:=pb^[j]+temp^[(i-y_img)*w_img+j-x_img];
                       // end;
                      end;
                      if cfg.int_filtr then
                         GaussFilter(p[k]^, p[k]^, 5, w_img, h_img);
                      {for i:=0 to h_img-1 do
                        for j:=0 to w_img-1 do
                          p[k]^[i*w_img+j]:=round(temp^[i*w_img+j]/mean);}
                    end;
                  //  FreeMem(temp, w_img*h_img*sizeof(treal));
                  end;
    end;
  bmp.Destroy;
end;

procedure TForm1.ToolButton17Click(Sender: TObject);
var Thread: TRunThread;
begin
  if not int.loaded then
  begin
    ShowMessage('Интерферограммы не загружены. Расчет невозможен!');
    exit;
  end;
  if vs.run then
  begin
    ShowMessage('Остановите видеопоток');
    exit;
  end;

 { if (int.w = int.w_img) and (int.h = int.h_img) then
  begin
    int.w_img:=int.w-10;
    int.h_img:=int.h-10;
    int.x_img:=5;
    int.y_img:=5;
  end;}
  Label1.Caption:='';
  phase.Clear;
  phase.Init(int.h_img, int.w_img, varDouble);
  unwrap.Clear;
  unwrap.Init(int.h_img, int.w_img, varDouble);
//  mask_inner.Clear;
//  mask_inner.Init(int.h_img, int.w_img, varByte, 1);

  Thread:=TRunThread.Create(true);
  Thread.FreeOnTerminate:=true;
  Thread.Resume;
end;

procedure TForm1.N12Click(Sender: TObject);
var m: PMyInfernalType;
begin
  m:=GetCurrentMask;
  if int.loaded and m^.loaded then
  begin
    CurrentMatrix:=cmInt;
    pnl.DrawImage(int, m^);
    UpdateLegendLabels;
  end
  else
    ShowMessage('Интерферограммы не загружены. Загрузите их!');
end;

procedure TForm1.N13Click(Sender: TObject);
var m: PMyInfernalType;
begin
  m:=GetCurrentMask;
  if unwrap.loaded and m^.loaded then
  begin
    CurrentMatrix:=cmUnwrap;
    pnl.DrawImage(final_phase, m^);
    UpdateLegendLabels;
  end
  else
    ShowMessage('Расчет не проведен. Увы...');
end;

procedure TForm1.Panel3Click(Sender: TObject);
begin
  if Panel2.Width > 15 then
  begin
    Panel2.Width:= 15;
    Panel3.Caption:= '>>';
    Panel3.Hint:='Развернуть';
  end
  else
  begin
    Panel2.Width:= 250;
    Panel3.Caption:= '<<';
    Panel3.Hint:='Свернуть';
  end;


end;

procedure TForm1.PnlMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var p, m: PMyInfernalType;
    i, w, h: integer;
    origin: TPoint;
    scl: TReal;
begin
  if (pnl.DrawMode = dmLargeCross) and (Button = mbLeft) then
  begin
   Series1.Clear;
   Series2.Clear;
   LineSeries1.Clear;
   PointSeries1.Clear;
   {Form3.Series1.Clear;
   Form4.Series1.Clear;
   Form3.Series2.Clear;
   Form4.Series2.Clear;}

   p:=GetCurrentArray;
   m:=GetCurrentMask;
   if not p^.loaded then exit;
   if not m^.loaded then exit;
   
   w:=p^.w;
   h:=p^.h;

   origin:=pnl.GetOrigin;
   {if cfg.input = 1 then
     scl:=(cfg.h1/int.h + cfg.w1/int.w)/2
   else
     scl:=(cfg.h2/int.h + cfg.w2/int.w)/2;}
   scl:=cfg.scl_eye;
   {form3.Chart1.LeftAxis.AutomaticMaximum:=true;
   form3.Chart1.LeftAxis.AutomaticMinimum:=true;}
//   form3.Chart1.LeftAxis.Minimum:=0;
   if p^.loaded then
   case p^._type of
     varByte: begin
                for i:=0 to w-1 do
                  if m^.b^[origin.y*w+i]=1 then
                    Series1.AddXY(i*scl ,p^.b^[origin.y*w+i])
                  else
                    Series1.AddNullXY(i*scl, 0);
                for i:=0 to h-1 do
                  if m^.b^[i*w+origin.x]=1 then
                    LineSeries1.AddXY(i*scl, p^.b^[i*w+origin.x])
                  else
                    LineSeries1.AddNullXY(i*scl, 0);

                if m^.b^[origin.y*w+origin.x]=1 then
                begin
                  Series2.AddXY(origin.x*scl, p^.b^[origin.y*w+origin.x]);
                  PointSeries1.AddXY(origin.y*scl, p^.b^[origin.y*w+origin.x]);
                end;
              end;
     varDouble:  begin
                   for i:=0 to w-1 do
                     if m^.b^[origin.y*w+i]=1 then
                       Series1.AddXY(i*scl ,p^.a^[origin.y*w+i])
                     else
                       Series1.AddNullXY(i*scl, 0);

                   for i:=0 to p^.h_img-1 do
                     if m^.b^[i*w+origin.x]=1 then
                       LineSeries1.AddXY(i*scl, p^.a^[i*w+origin.x])
                     else
                       LineSeries1.AddNullXY(i*scl, 0);
//                   form3.Caption:=FloatToStr(p^.a^[origin.y*w+origin.x]);

                   if m^.b^[origin.y*w+origin.x]=1 then
                   begin
                     Series2.AddXY(origin.x*scl, p^.a^[origin.y*w+origin.x]);
                     PointSeries1.AddXY(origin.y*scl, p^.a^[origin.y*w+origin.x]);
                   end;
                 end;
   end;
   Chart1.Update;
//   form3.Series2.AddXY((origin.x-p^.x_img)*scl, form3.Chart1.LeftAxis.Minimum);
//   form3.Series2.AddXY((origin.x-p^.x_img)*scl, form3.Chart1.LeftAxis.Maximum);

   Chart3.Update;
//   form4.Series2.AddXY((origin.y-p^.y_img)*scl, form4.Chart1.LeftAxis.Minimum);
//   form4.Series2.AddXY((origin.y-p^.y_img)*scl, form4.Chart1.LeftAxis.Maximum);
//   form3.Chart1.Update;
//   form4.Chart1.Update;


  end;
end;

procedure TForm1.ToolButton35Click(Sender: TObject);
begin
  if ToolButton35.Down then
    form8.Show
  else
    form8.Close;
end;

procedure TForm1.N18Click(Sender: TObject);
begin
//  pnl.Palette:=ColorPalette;
  UpdateLegend;
{  Form8.Image1.Picture.Bitmap.Palette:=CreateColorPalette;
  Form8.Image1.Repaint;}
end;

procedure TForm1.N19Click(Sender: TObject);
begin
  pnl.Palette:=GreyPalette;
  UpdateLegend;
{  Form8.Image1.Picture.Bitmap.Palette:=CreateGreyPalette;
  Form8.Image1.Repaint;}
end;

procedure TForm1.UpdateLegend;
var p: PByteArray;
    i,j: integer;
    p1: PMyInfernalType;
begin
  with form8 do
  begin
    {case pnl.Palette of
      ColorPalette: Image1.Picture.Bitmap.Palette:=CreateColorPalette;
      GreyPalette:  Image1.Picture.Bitmap.Palette:=CreateGreyPalette;
    end;}

    for i:=0 to Image1.Picture.Bitmap.Height-1 do
    begin
      p:=Image1.Picture.Bitmap.ScanLine[i];
      for j:=0 to Image1.Picture.Bitmap.Width-1 do
      begin
        p^[j]:=round(j*255/Image1.Picture.Bitmap.Width);
          if 0 = (j mod round(Image1.Picture.Bitmap.Width/9)) then
            p^[j]:=255-p^[j];
      end;
    end;
  end;
  {p1:=GetCurrentArray;
  if p1^.loaded then
    pnl.DrawImage(p1^, mask_inner);}
end;

procedure TForm1.UpdateLegendLabels;
var min, max: treal;
    p: PMyInfernalType;
begin
  p:=GetCurrentArray;
  if not p^.loaded then exit;
  min:=pnl.Bottom_Level;
  max:=pnl.Top_Level;
  with form8 do
  begin
    Label1.Caption:=FloatToStrF(min, ffFixed, 3, 2);
    Label2.Caption:=FloatToStrF((max-min)/9+min, ffFixed, 5, 2);
    Label3.Caption:=FloatToStrF(2*(max-min)/9+min, ffFixed, 5, 2);
    Label4.Caption:=FloatToStrF((max-min)/3+min, ffFixed, 5, 2);
    Label5.Caption:=FloatToStrF(4*(max-min)/9+min, ffFixed, 5, 2);
    Label6.Caption:=FloatToStrF(5*(max-min)/9+min, ffFixed, 5, 2);
    Label7.Caption:=FloatToStrF(2*(max-min)/3+min, ffFixed, 5, 2);
    Label8.Caption:=FloatToStrF(7*(max-min)/9+min, ffFixed, 5, 2);
    Label10.Caption:=FloatToStrF(8*(max-min)/9+min, ffFixed, 5, 2);
    Label11.Caption:=FloatToStrF(max, ffFixed, 5, 2);
  end;
end;

procedure TForm1.WMStartEditing(var Message: TMessage);
var
  Node: PVirtualNode;
begin
  Node:= Pointer(Message.WParam);
  vt.EditNode(Node, -1);
end;

procedure TForm1.WM_WMCapDone(var msg: TMessage);
begin
  SetEvent(TDirectShowCaptureThread.DataReady);
  SetEvent(DataReady_Average);
end;

procedure TForm1.WM_WMNewFrame(var msg: TMessage);
var
    i: integer;
begin
  DirectShowVideoForm.Series1.Clear;
  for i:=0 to 255 do
    DirectShowVideoForm.Series1.Add(VidCap1.CB.Hist[i]);
  DirectShowVideoForm.Chart1.Update;
end;

procedure TForm1.EMP1Click(Sender: TObject);
var w,h,k: integer;
    t, tx, ty: treal;
    i,j: integer;
begin
  w:=1392;
  h:=1040;
  int.Clear;
  int.Init(h, w, varByte);
  tx:=700;
  ty:=350;
  for k:=0 to 8 do
  begin
    for i:= 0 to h-1 do
      for j:=0 to w-1 do
      begin
        t:=127*(sin(2*pi*(i/ty+j/tx)+k*pi/2)+1);
        int.b^[i*w+j]:=round(t);
      end;
    CreateBmp(int, false, Format('int_%.4d.bmp', [k+1]));
  end;
  pnl.DrawImage(int, int);


end;

procedure TForm1.ExportToWord;
var WordApp, WordSel: Variant;
    b: TBitmap;
    w_img, h_img: integer;
begin
    w_img:=570;
    h_img:=380;
    try // Получаем копию Word'а, если он уже запущен
     WordApp := GetActiveOleObject('Word.Application');
    except // Произошло исключение, значит Word не запущен
      try // Пробуем запустить Word
        WordApp := CreateOleObject('Word.Application');
      except // Произошло исключение, значит Word'а нет вообще
        Application.MessageBox('Microsoft Word не установлен.', 'Внимание!');
        Exit;
      end;
   end;
   try
     WordApp.Documents.Add(template:=ExtractFilePath(Application.ExeName)+'template.doc');
     WordApp.Visible:=false;
     WordSel:=WordApp.selection;
     WordSel.goto(What:=-1,name:='date');
     WordSel.TypeText(DateToStr(Date));
     WordSel.goto(What:=-1,name:='rms');
     WordSel.TypeText(FloatToStrF(_rms, ffFixed, 5, 2));
     WordSel.goto(What:=-1,name:='pv');
     WordSel.TypeText(FloatToStrF(_pv, ffFixed, 5, 2));
     WordSel.goto(What:=-1,name:='ra');
     WordSel.TypeText(FloatToStrF(Ra, ffFixed, 5, 2));
     WordSel.goto(What:=-1,name:='rz');
     WordSel.TypeText(FloatToStrF(Rz, ffFixed, 5, 2));
     WordSel.goto(What:=-1,name:='rmax');
     WordSel.TypeText(FloatToStrF(Rmax, ffFixed, 5, 2));

     WordSel.goto(What:=-1,name:='topo');
     b:=TBitmap.Create;
     if pnl.bitmap.Height/pnl.bitmap.Width >= h_img/w_img then
     begin
       b.Height:=h_img;
       b.Width:=round( h_img*pnl.bitmap.Width/pnl.bitmap.Height);
     end
     else
     begin
       b.Width:=w_img;
       b.Height:=round(w_img*pnl.bitmap.Height/pnl.bitmap.Width);
     end;
     b.Canvas.StretchDraw(b.Canvas.ClipRect, pnl.bitmap);
     Clipboard.Assign(b);
     WordSel.paste;

     WordSel.goto(What:=-1,name:='legend');
     Clipboard.Assign(Form8.GetFormImage);
     WordSel.paste;

     WordSel.goto(What:=-1,name:='slice_x');
     Form3.Chart1.CopyToClipboardMetafile(True);
     WordSel.paste;
     WordSel.goto(What:=-1,name:='slice_y');
     Form4.Chart1.CopyToClipboardMetafile(True);
     WordSel.paste;
   finally
     if not VarIsEmpty(WordApp) Then WordApp.Visible:=true;
     WordApp:=UnAssigned;
   end;


     b.Destroy;
end;

procedure TForm1.ToolButton40Click(Sender: TObject);
var cb: TClipboard;
begin
 { if not unwrap.loaded then
  begin
    ShowMessage('Расчет непроведен');
    exit;
  end;
  if CurrentMatrix = cmInt then
  begin
    ShowMessage('Необходимо перейти в режим представления результата');
    exit;
  end;
  }
  cb:=TClipboard.Create;
  with ReportForm do
  begin
    Label1.Caption:='Ra = '+FloatToStrF(Ra, ffFixed, 5, 2)+' нм.';
    Label2.Caption:='Rz = '+FloatToStrF(Rz, ffFixed, 5, 2)+' нм.';
    Label3.Caption:='Rmax = '+FloatToStrF(Rmax, ffFixed, 5, 2)+' нм.';
    Label4.Caption:='RMS = '+FloatToStrF(_rms, ffFixed, 5, 2)+' нм.';
    Label5.Caption:='PV = '+FloatToStrF(_pv, ffFixed, 5, 2)+' нм.';
    form3.Chart1.CopyToClipboardBitmap;
    Image1.Picture.LoadFromClipboardFormat(CF_BITMAP, cb.GetAsHandle(CF_BITMAP), 0);
    form4.Chart1.CopyToClipboardBitmap;
    Image2.Picture.LoadFromClipboardFormat(CF_BITMAP, cb.GetAsHandle(CF_BITMAP), 0);
    cb.Destroy;
//    Image1.Picture.Bitmap.Canvas.Draw(0,0, form3.Chart1.CopyToClipboardBitmap);

    if ShowModal <> mrOk then
      exit;

    ExportToWord;
  end;
end;

procedure TForm1.ToolButton42Click(Sender: TObject);
var m: PMyInfernalType;
begin
//  mask_inner.Clear;
//  mask_inner.Init(unwrap.h, unwrap.w, varByte, 1);
  m:=GetCurrentMask;
  if (not final_phase.loaded) or (not m^.loaded) then
  begin
    ShowMessage('Расчет не проведен!');
    exit;
  end;
  Form7.InitModel(final_phase.a^, m.b^, final_phase.w, final_phase.h);
  Form7.ShowModal;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if ProjectData.changed then
  begin
    if MessageDlg('Проект не сохранен. Сохранить?', mtConfirmation, mbYesNo, 0) = mrYes then
      SaveProject(ProjectData);
  end;

  with cfg do
  begin
    x_left:=form3.Left;
    x_top:=Form3.Top;
    y_left:=Form4.Left;
    y_top:=Form4.Top;
    legend_left:=Form8.Left;
    legend_top:=Form8.Top;
    slice_left:=Form5.Left;
    slice_top:=Form5.Top;
    if cfg.CameraType = 'VideoScan' then
    begin
      capture_left:=Form9.Left;
      capture_top:=Form9.top;
    end;
    if cfg.CameraType = 'DirectShow' then
    begin
      capture_left:=DirectShowVideoForm.Left;
      capture_top:=DirectShowVideoForm.top;
    end;
  end;

  if (cfg.CameraType = 'VideoScan') and VideoScanEnabled then
  begin
    if vs.run then
      VideoThread.Terminate;
    vs.Destroy;
  end;

  if cfg.CameraType = 'DirectShow' then
  begin
    {VidCap1.FFilterGraph:=nil;
    VidCap1.FMediaControl:=nil;
    VidCap1.FMediaEvent:=nil;
    VidCap1.FMediaSeek:=nil;
    VidCap1.CB.Destroy;}

    VidCap1.aGrabber.SetCallback(nil, 1);

    VidCap1.Destroy;
    CloseHandle(DataReady_Average);
  end;

  if ComConnected and cfg.ComMode then
  begin
//    WatchComThread.Terminate;
    CloseHandle(ComEvent);
    CloseHandle(ComInit);
    CommPortDriver1.Disconnect;
  end;

  if ComConnected and (cfg.Com_phase_shift or cfg.Com_Step_Motor) then
  begin
    CommPortDriver1.Disconnect;
  end;

  DoneDriver;
end;

procedure TForm1.N22Click(Sender: TObject);
begin
  ShellAbout(Handle, 'WinPhast by TomoLab', 'ВНИИОФИ -- Лаборатория голографии'+
  ' и оптической томографии -- 119361, г. Москва, ул. Озерная, д. 46', 0);
end;

procedure TForm1.N26Click(Sender: TObject);
var p: PMyInfernalType;
    i,j: integer;
    p1, p2: TPoint;
    mode: TDrawMode;
begin
  p:=GetCurrentArray;
  if not p^.loaded then exit;
  mode:=pnl.DrawMode;
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmSimpleRect;
//  FillMemory(_mask.b, cfg.cam_w*cfg.cam_h, 1);

//  pnl.DrawImage(p^, _mask);
  pnl.Contrast_mask:=0.5;
  pnl.DrawImage(p^, mask_inner);
  pnl.Contrast_mask:=1;
  off(false);
  pnl.Cursor:=crMyShittyCursor;


  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;
  pnl.Cursor:=crDefault;

  p1:=pnl.GetPoint1;
  p2:=pnl.GetPoint2;

  for i:=p1.y to p2.y do
    for j:=p1.x to p2.x do
      mask_inner.b^[i*cfg.cam_w+j]:=1;

//  pnl.GetMask(p, @(_mask));
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=mode;

  with p^ do
  begin
    x_hist:=x_img;
    y_hist:=y_img;
    w_hist:=w_img;
    h_hist:=h_img;
    ColorScale:=byArea_hist;
  end;

//  for i:=0 to _mask.w*_mask.h-1 do
//    if _mask.b^[i]=1 then
//      mask_inner.b^[i]:=1;

  pnl.DrawImage(p^, mask_inner);
  off(true);
  UpdateLegendLabels;
end;

procedure TForm1.N27Click(Sender: TObject);
var p: PMyInfernalType;
begin
  p:=GetCurrentArray;
  if not p^.loaded then exit;

  ZeroMemory(mask_inner.b, cfg.cam_w*cfg.cam_h);
//  FillMemory(_mask.b, cfg.cam_w*cfg.cam_h, 1);
  pnl.Contrast_mask:=1;
  pnl.DrawImage(p^, p^);
  CurrentMask:=cmMask1;
//  FillMemory(mask_inner.b, cfg.cam_w*cfg.cam_h, 1);
 { pnl.Contrast_mask:=0.5;
  pnl.DrawImage(p^, mask_inner);
  pnl.Contrast_mask:=1;}
//  UpdateLegendLabels;
end;

procedure TForm1.N28Click(Sender: TObject);
var p: PMyInfernalType;
    i: integer;
begin
  p:=GetCurrentArray;
  if not p^.loaded then exit;
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmRect;
  FillMemory(_mask.b, cfg.cam_w*cfg.cam_h, 1);
  off(false);
  pnl.DrawImage(p^, _mask);
  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;

  pnl.GetMask(p, @(_mask));
  pnl.DrawMode:=dmNone;

  for i:=0 to _mask.w*_mask.h-1 do
    if _mask.b^[i]=1 then
      mask_outer.b^[i]:=1;

  pnl.DrawImage(p^, mask_outer);
  off(true);
end;

procedure TForm1.N29Click(Sender: TObject);
var p: PMyInfernalType;
begin
  p:=GetCurrentArray;
  if not p^.loaded then exit;

  ZeroMemory(mask_outer.b, cfg.cam_w*cfg.cam_h);
//  FillMemory(_mask.b, cfg.cam_w*cfg.cam_h, 1);
  pnl.DrawImage(p^, p^);
  CurrentMask:=cmMask2;
end;

procedure TForm1.N30Click(Sender: TObject);
var p: PMyInfernalType;
    i, j: integer;
    p1, p2: TPoint;
    mode: TDrawMode;
begin
  p:=GetCurrentArray;
  if not p^.loaded then exit;

  mode:=pnl.DrawMode;
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmSimpleRect;
//  CopyMemory(_mask.b, mask_inner.b, cfg.cam_w*cfg.cam_h);
  off(false);
//  pnl.DrawImage(p^, _mask);
  pnl.Cursor:=crMyShittyCursor;
  pnl.DrawImage(p^, mask_inner);
  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;
  pnl.Cursor:=crDefault;

  p1:=pnl.GetPoint1;
  p2:=pnl.GetPoint2;

  for i:=p1.y to p2.y do
    for j:=p1.x to p2.x do
      mask_inner.b^[i*cfg.cam_w+j]:=0;

  with p^ do
  begin
    x_hist:=x_img;
    y_hist:=y_img;
    w_hist:=w_img;
    h_hist:=h_img;
    ColorScale:=byArea_hist;
  end;

//  pnl.GetMask(p, @(_mask));
//  pnl.DrawMode:=dmNone;

//  for i:=0 to _mask.w*_mask.h-1 do
//    if _mask.b^[i]=1 then
//      mask_inner.b^[i]:=0;

  pnl.DrawMode:=mode;
  off(true);
  pnl.DrawImage(p^, mask_inner);
  UpdateLegendLabels;
end;

procedure TForm1.N31Click(Sender: TObject);
var p: PMyInfernalType;
    i: integer;
begin
  p:=GetCurrentArray;
  if not p^.loaded then exit;

  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmRect;
  CopyMemory(_mask.b, mask_outer.b, cfg.cam_w*cfg.cam_h);
  off(false);
  pnl.DrawImage(p^, _mask);
  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;

  pnl.GetMask(p, @(_mask));
  pnl.DrawMode:=dmNone;

  for i:=0 to _mask.w*_mask.h-1 do
    if _mask.b^[i]=1 then
      mask_outer.b^[i]:=0;
  off(true);
  pnl.DrawImage(p^, mask_outer);
end;


procedure TForm1.N33Click(Sender: TObject);
begin
  RecMode:=rmNorm;
  cfg.do_seq:=false;
  RecSeqThread_start;
end;

procedure TForm1.N34Click(Sender: TObject);
begin
  {RecSeqThreadForm.Show;
  RecMode:=rmBase;
  RecSeqThread:=TRecSeqThread.Create(true);
  RecSeqThread.FreeOnTerminate:=true;
  RecSeqThread.Resume;
   }
  RecMode:=rmBase;
  cfg.do_seq:=false;
  RecSeqThread_start;
  {BaseRunThread:=TBaseRunThread.Create(true);
  BaseRunThread.FreeOnTerminate:=true;
  BaseRunThread.Resume;}
end;

procedure TForm1.N35Click(Sender: TObject);
var i, w, h: integer;
    cnt1, cnt2, n: integer;
    mean1, mean2, raz1, raz2, m1, h0, dh: treal;
begin
  if not final_phase.loaded then
    exit;

  w:=final_phase.w;
  h:=final_phase.h;

  cnt1:=0;
  cnt2:=0;
  mean1:=0;
  mean2:=0;
  for i:=0 to w*h-1 do
  begin
    if mask_inner.b^[i]=1 then
    begin
      mean1:=mean1+final_phase.a^[i];
      inc(cnt1);
    end;

    if mask_outer.b^[i]=1 then
    begin
      mean2:=mean2+final_phase.a^[i];
      inc(cnt2);
    end;
  end;
  if cnt1 <> 0 then
    mean1:=mean1/cnt1
  else
    mean1:=0;
  if cnt2 <> 0 then
    mean2:=mean2/cnt2
  else
    mean2:=0;

  razn:=Abs(mean1-mean2);

  (*
  h0:=cfg.step_height;
  dh:=cfg.lambda/2;

  raz1:=abs(razn-h0);
  m1:=mean1+dh;
  raz2:=abs(abs(m1-mean2)-h0);
  n:=1;

  while raz1 > raz2 do
  begin
    raz1:=raz2;
    inc(n);
    m1:=mean1+n*dh;
    raz2:=abs(abs(m1-mean2)-h0);
  end;

  dec(n);
  dh:=n*dh;

  {for i:=0 to w*h-1 do
    if mask_inner.b^[i]=1 then
      final_phase.a^[i]:=final_phase.a^[i]+dh;}

//  CreateBin(final_phase, final_mask, 'temp.bin');

  mean1:=mean1+dh;
  razn:=Abs(mean1-mean2);
    *)

  pnl.DrawImage(final_phase, final_mask);
  ShowMessage('Высота ступеньки = ' + FloatToStrF(razn, ffFixed, 5, 3)+' нм.');

end;

procedure TForm1.N36Click(Sender: TObject);
begin
 with LoadSeqForm do
 begin
   Edit1.Text:=cfg.img_path;
   Edit4.Text:=IntToStr(cfg.num_seq);
   Edit2.Text:=IntToStr(cfg.steps);
   ShowModal;
 end;
end;

procedure TForm1.N37Click(Sender: TObject);
begin
  RecMode:=rmBase;
  cfg.do_seq:=true;
  RecSeqThread_start;
end;

procedure TForm1.N38Click(Sender: TObject);
begin
  RecMode:=rmNorm;
  cfg.do_seq:=true;
  RecSeqThread_start;
end;

procedure TForm1.N39Click(Sender: TObject);
var p: PMyInfernalType;
begin
  p:=GetCurrentArray;
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmCross;
  pnl.DrawImage(p^, mask_inner);
  Off(false);
  pnl.Cursor:=crMyShittyCursor;
  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;
  pnl.Cursor:=crDefault;
  Off(true);
  Origin01:=pnl.GetOrigin;
  pnl.DrawMode:=dmNone;
  pnl.DrawImage(p^, mask_inner);
  _origin:=true;
end;

procedure TForm1.N40Click(Sender: TObject);
var s: string;
    f: TextFile;
    i,j,w,h: integer;
begin
  if not final_phase.loaded then
    exit;
  SaveDialog1.Filter:='Text files|*.txt';
  SaveDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  if not SaveDialog1.Execute then
    exit;
  s:=ChangeFileExt(SaveDialog1.FileName, '.txt');
  AssignFile(f, s);
  Rewrite(f);

  w:=final_phase.w;
  h:=final_phase.h;
  for i:=0 to h-1 do
  begin
    for j:=0 to w-1 do
      if final_mask.b^[i*w+j]=1 then
        write(f, final_phase.a^[i*w+j]:5:3, ' ')
      else
        write(f, 0.0:5:3, ' ');
    writeln(f);
  end;

  CloseFile(f);
end;

procedure TForm1.N41Click(Sender: TObject);
var p: PMyInfernalType;
begin
  OpenDialog1.Filter:='Bin files|*.bin';
  OpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  if not OpenDialog1.Execute then
    exit;
  LoadBin(mask_inner, OpenDialog1.FileName);
  p:=GetCurrentArray;

 { with p^ do
  begin
    x_hist:=x_img;
    y_hist:=y_img;
    w_hist:=w_img;
    h_hist:=h_img;
    ColorScale:=byArea_hist;
  end;}

  CurrentMask:=cmMask1;
  pnl.DrawImage(p^, mask_inner);
  UpdateLegendLabels;
end;

procedure TForm1.N42Click(Sender: TObject);
var s: string;
begin
  SaveDialog1.Filter:='Bin files|*.bin';
  SaveDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  if not SaveDialog1.Execute then
    exit;
  s:=SaveDialog1.FileName;
  s:=ChangeFileExt(s, '.bin');

  CreateBin(mask_inner, s);
end;

procedure TForm1.N43Click(Sender: TObject);
var p: PMyInfernalType;
begin
  OpenDialog1.Filter:='Bin files|*.bin';
  OpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  if not OpenDialog1.Execute then
    exit;
  LoadBin(mask_outer, OpenDialog1.FileName);
  p:=GetCurrentArray;
  pnl.DrawImage(p^, mask_outer);
  CurrentMask:=cmMask2;
end;

procedure TForm1.N44Click(Sender: TObject);
var s: string;
begin
  SaveDialog1.Filter:='Bin files|*.bin';
  SaveDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  if not SaveDialog1.Execute then
    exit;
  s:=SaveDialog1.FileName;
  s:=ChangeFileExt(s, '.bin');

  CreateBin(mask_outer, s);
end;

procedure TForm1.N45Click(Sender: TObject);
var p: PMyInfernalType;
begin
  p:=GetCurrentArray;
  pnl.DrawImage(p^, mask_inner);
end;

procedure TForm1.N46Click(Sender: TObject);
var p: PMyInfernalType;
begin
  p:=GetCurrentArray;
  pnl.DrawImage(p^, mask_outer);
end;

procedure TForm1.N48Click(Sender: TObject);
var p: PMyInfernalType;
    i: integer;
begin
  p:=GetCurrentArray;
  if not p^.loaded then exit;

  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmCirc;

  pnl.DrawImage(p^, p^);
  off(false);
  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;

  pnl.GetMask(p, @(mask_inner));
  pnl.DrawMode:=dmNone;
  off(true);
  pnl.DrawImage(p^, mask_inner);
end;

procedure TForm1.N49Click(Sender: TObject);
var s: string;
begin
  SaveDialog1.Filter:='Bin files|*.bin';
  SaveDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  if not SaveDialog1.Execute then
    exit;
  s:=SaveDialog1.FileName;
  s:=ChangeFileExt(s, '.bin');

  CreateBin(mask_inner, s);
end;

procedure TForm1.N50Click(Sender: TObject);
var p: PMyInfernalType;
begin
  OpenDialog1.Filter:='Bin files|*.bin';
  OpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  if not OpenDialog1.Execute then
    exit;
  LoadBin(mask_inner, varByte, OpenDialog1.FileName);
  p:=GetCurrentArray;
  pnl.DrawImage(mask_inner, mask_inner);
end;

procedure TForm1.N52Click(Sender: TObject);
var p: PMyInfernalType;
    i,j,w,h: integer;
begin
  if not mask_inner.loaded then
  begin
    ShowMessage('Сначала введите внутреннюю маску!');
    exit;
  end;

  p:=GetCurrentArray;
  if not p^.loaded then exit;
  w:=p^.w;
  h:=p^.h;
  for i:=0 to w*h-1 do
    mask_inner.b^[i]:=1-mask_inner.b^[i];

  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmCirc;

  pnl.DrawImage(p^, mask_inner);
  off(false);
  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;

  pnl.GetMask(p, @(mask_outer));
  pnl.DrawMode:=dmNone;

  for i:=0 to h-1 do
    for j:=0 to w-1 do
      if (i <= 9) or (i >= (h-11)) or (j <= 9) or (j >= w-11) then
        mask_outer.b^[i*w+j]:=0
      else
        mask_outer.b^[i*w+j]:=1-mask_outer.b^[i*w+j];

  for i:=0 to w*h-1 do
    mask_inner.b^[i]:=1-mask_inner.b^[i];

  off(true);
  pnl.DrawImage(p^, mask_outer);
end;

procedure TForm1.N53Click(Sender: TObject);
var s: string;
begin
  if not mask_outer.loaded then
    exit;

  SaveDialog1.Filter:='Bin files|*.bin';
  SaveDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  if not SaveDialog1.Execute then
    exit;
  s:=SaveDialog1.FileName;
  s:=ChangeFileExt(s, '.bin');

  CreateBin(mask_outer, s);
end;

procedure TForm1.N54Click(Sender: TObject);
var p: PMyInfernalType;
begin
  OpenDialog1.Filter:='Bin files|*.bin';
  OpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  if not OpenDialog1.Execute then
    exit;
  LoadBin(mask_outer, varByte, OpenDialog1.FileName);
  p:=GetCurrentArray;
  pnl.DrawImage(mask_outer, mask_outer);
end;


procedure TForm1.N55Click(Sender: TObject);
var
  i, w, h: integer;
  n_ref_t, n_rab_t, n_rab_abs: treal;
  mean, rms1, n_vol, n_vova: treal;
  cnt: Integer;
  min1, min2, min3: treal;
  origin1, origin2, origin3, dr, dr2: tpoint;
  j, di, dj: Integer;
  buf: PRealArray;
  a, b, c: treal;
  sw: boolean;
  mask1, mask2: TMyInfernalType;
  q1, q2, k: treal;
begin
  sw:=phase_exp1.loaded and  phase_exp2.loaded and mask_inner.loaded {and super_lunka.loaded} and mask_outer.loaded;
  if not sw then
    exit;
  w:=phase_exp1.w;
  h:=phase_exp1.h;
  mask1:=TMyInfernalType.Create;
//  mask2:=TMyInfernalType.Create;
  mask1.Init(h, w, varByte);
//  mask2.Init(h, w, varByte);

  min1:=MaxInt;
  min2:=MaxInt;
//  min3:=MaxInt;
  for i:=0 to h-1 do
    for j:=0 to w-1 do
      begin
        if min1 > phase_exp1.a^[i*w+j] then
        begin
          min1:=phase_exp1.a^[i*w+j];
          origin1.x:=j;
          origin1.y:=i;
        end;
        if min2 > phase_exp2.a^[i*w+j] then
        begin
          min2:=phase_exp2.a^[i*w+j];
          origin2.x:=j;
          origin2.y:=i;
        end;
        {if min3 > super_lunka.a^[i*w+j] then
        begin
          min3:=super_lunka.a^[i*w+j];
          origin3.x:=j;
          origin3.y:=i;
        end;}
      end;
  dr.x:=origin2.x-origin1.x;
  dr.y:=origin2.y-origin1.y;
//  dr2.x:=origin3.x-origin1.x;
//  dr2.y:=origin3.y-origin1.y;
  {for i:=0 to h*w-1 do
  begin
    phase_exp1.a^[i]:=phase_exp1.a^[i]-min1;
    phase_exp2.a^[i]:=phase_exp2.a^[i]-min2;
  end;}
  GetMem(buf, w*h*sizeof(treal));
  CopyMemory(buf, phase_exp2.a, w*h*sizeof(treal));
  for i:=10 to h-11 do
    for j:=10 to w-11 do
    begin
      di:=i+dr.y;
      dj:=j+dr.x;
      if (di >= 10) and (di < (h-10)) and (dj >= 10) and (dj < (w-11)) then
      begin
        phase_exp2.a^[i*w+j]:=buf^[di*w+dj];
        mask1.b^[i*w+j]:=1;
      end
      else
      begin
        {phase_exp2.a^[i*w+j]:=0;
        mask_outer.b^[i*w+j]:=0;
        mask_inner.b^[i*w+j]:=0;}
      end;
    end;
     (*
  CopyMemory(buf, super_lunka.a, w*h*sizeof(treal));
  for i:=15 to h-16 do
    for j:=15 to w-16 do
    begin
      di:=i+dr2.y;
      dj:=j+dr2.x;
      if (di >= 15) and (di < (h-16)) and (dj >= 15) and (dj < (w-16)) then
      begin
        super_lunka.a^[i*w+j]:=buf^[di*w+dj];
        mask2.b^[i*w+j]:=1;
      end
      else
      begin

        {phase_exp2.a^[i*w+j]:=0;
        mask_outer.b^[i*w+j]:=0;
        mask_inner.b^[i*w+j]:=0;}
      end;
    end; *)
  FreeMem(buf, w*h*sizeof(treal));

  for i:=0 to w*h-1 do
  begin
    mask_outer.b^[i]:=mask_outer.b^[i]*mask1.b^[i]{*mask2.b^[i]};
    final_mask.b^[i]:=mask1.b^[i]{*mask2.b^[i]};
  end;

  mask1.Destroy;
//  mask2.Destroy;

  TiltRemove(phase_exp1.a^, mask_outer.b^, final_mask.b^, h, w);
  TiltRemove(phase_exp2.a^, mask_outer.b^, final_mask.b^, h, w);
//  TiltRemove(super_lunka.a^, mask_outer.b^, final_mask.b^, h, w);

  Grad(phase_exp1);
  Grad(phase_exp2);

  q1:=0;
  q2:=0;

  vol1:=0;
  vol2:=0;
  vol3:=0;
  for i:=0 to w*h-1 do
    if mask_inner.b^[i] =  1 then
    begin
      q1:=q1+phase_exp1.a^[i]*phase_exp2.a^[i];
      q2:=q2+sqr(phase_exp1.a^[i]);
      vol1:=vol1+phase_exp1.a^[i];
      vol2:=vol2+phase_exp2.a^[i];
//      vol3:=vol3+super_lunka.a^[i];
    end;
  k:=q1/q2;


//  n_ref_t:=nabs2nt(cfg.lambda*1e-3, cfg._t, cfg._p, cfg._f, cfg.n_ref, cfg.b_ref);
  n_ref_t:=N_vozd(cfg.lambda*1e-3, cfg._p, cfg._t, cfg._f);
 (* cnt:=0;
  mean:=0;
  ZeroMemory(final_phase.a, w*h*sizeof(treal));
  for i:=0 to w*h-1 do
    if (mask_inner.b^[i] = 1) and (super_lunka.a^[i] <> 0) then
    begin
      final_phase.a^[i]:=n_ref_t*(1-(phase_exp1.a^[i]-phase_exp2.a^[i])/super_lunka.a^[i]);
      final_phase.a^[i]:=nt2nabs(cfg.lambda*1e-3, cfg._t, cfg._p, cfg._f, final_phase.a^[i], cfg.b_rab);
//      final_phase.a^[i]:=n_ref_t*phase_exp2.a^[i]/phase_exp1.a^[i];
//      final_phase.a^[i]:=nt2nabs(cfg.lambda*1e-3, cfg._t, cfg._p, cfg._f, final_phase.a^[i], cfg.b_rab);
      inc(cnt);
      mean:=mean+final_phase.a^[i];
    end;
  mean:=mean/cnt;
  rms1:=0;
  for i:=0 to w*h-1 do
    if mask_inner.b^[i] = 1 then
      rms1:=rms1+sqr(final_phase.a^[i]-mean);
  rms1:=sqrt(rms1/(cnt-1));

  *)
  n_vol:=nt2nabs(cfg.lambda*1e-3, cfg._t, cfg._p, cfg._f, n_ref_t*vol2/vol1{(1-(vol1-vol2)/vol3)}, cfg.b_rab);
  n_vova:=nt2nabs(cfg.lambda*1e-3, cfg._t, cfg._p, cfg._f, n_ref_t*k{(1-(vol1-vol2)/vol3)}, cfg.b_rab);

  {TiltRemove(final_phase, mask_inner, a, b, c);
  for i:=0 to h-1 do
    for j:=0 to w-1 do
      final_phase.a^[i*w+j]:=final_phase.a^[i*w+j]-a*i-b*j;

  cnt:=0;
  mean:=0;
  for i:=0 to w*h-1 do
    if (mask_inner.b^[i] = 1) then
    begin
      inc(cnt);
      mean:=mean+final_phase.a^[i];
    end;
   }


//  CopyMemory(final_mask.b, mask_inner.b, w*h);
  pnl.DrawImage(final_phase, mask_inner);
  ShowMessage({'Показатель преломления:'+FloatToStr(mean)+#13#10+'RMS: '+FloatToStr(rms1)+#13#10+}'По объемам: '+FloatToStr(n_vol)+
  #13#10+'По Вове: '+FloatToStr(n_vova));

//  n_rab_t:=vol2/vol1*n_ref_t;
//  n_rab_abs:=nt2nabs(cfg.lambda*1e-3, cfg._t, cfg._p, cfg._f, n_rab_t, cfg.b_rab);
//  ShowMessage('Показатель преломления:'+#13#10+FloatToStr(n_rab_abs));

end;

procedure TForm1.N56Click(Sender: TObject);
begin
  cfg.do_seq:=false;
  LunkaThread_start(1);
end;

procedure TForm1.N57Click(Sender: TObject);
begin
  if not phase_exp1.loaded then
    exit;
  final_phase.Clear;
  final_phase.Init(phase_exp1.h, phase_exp1.w, varDouble);
  CopyMemory(final_phase.a, phase_exp1.a, phase_exp1.w*phase_exp1.h*sizeof(treal));
  pnl.DrawImage(final_phase, final_mask);
  CurrentMatrix:=cmUnwrap;
end;

procedure TForm1.N58Click(Sender: TObject);
begin
  cfg.do_seq:=false;
  LunkaThread_start(2);
end;

procedure TForm1.N59Click(Sender: TObject);
begin
  if not phase_exp2.loaded then
    exit;
  final_phase.Clear;
  final_phase.Init(phase_exp2.h, phase_exp2.w, varDouble);
  CopyMemory(final_phase.a, phase_exp2.a, phase_exp2.w*phase_exp2.h*sizeof(treal));
  pnl.DrawImage(final_phase, final_mask);
  CurrentMatrix:=cmUnwrap;
end;


procedure TForm1.N60Click(Sender: TObject);
var p: PMyInfernalType;
begin
  p:=GetCurrentArray;
  if p^.loaded then
    pnl.DrawImage(p^, mask_inner);
end;

procedure TForm1.N61Click(Sender: TObject);
var p: PMyInfernalType;
begin
  p:=GetCurrentArray;
  if p^.loaded then
    pnl.DrawImage(p^, mask_outer);
end;

procedure TForm1.N62Click(Sender: TObject);
begin
  OpenDialog1.Filter:='Bin files|*.bin';
  OpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  if not OpenDialog1.Execute then
    exit;
  LoadBin(super_lunka, final_mask, OpenDialog1.FileName);
  Form1.N57Click(Sender);

{  n_ref_t:=nabs2nt(cfg.lambda*1e-3, cfg._t, cfg._p, cfg._f, cfg.n_ref, cfg.b_ref);
  ShowMessage(FloatToStr(N_vozd(cfg.lambda*1e-3, cfg._p, cfg._t, cfg._f)));
    _n1:=nabs2nt(cfg.lambda*1e-3, cfg._t, cfg._p, cfg._f, 1, cfg.b_ref);
    _n2:=nt2nabs(cfg.lambda*1e-3, cfg._t, cfg._p, cfg._f, _n1, cfg.b_ref);
    ShowMessage(FloatToStr(_n2));}
end;

procedure TForm1.N63Click(Sender: TObject);
var s: string;
begin
  if (not phase_exp1.loaded) or (not final_mask.loaded)then
    exit;

  SaveDialog1.Filter:='Bin files|*.bin';
  SaveDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  if not SaveDialog1.Execute then
    exit;
  s:=SaveDialog1.FileName;
  s:=ChangeFileExt(s, '.bin');

  CreateBin(phase_exp1, final_mask, s);
end;

procedure TForm1.N64Click(Sender: TObject);
begin
  OpenDialog1.Filter:='Bin files|*.bin';
  OpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  if not OpenDialog1.Execute then
    exit;
  LoadBin(phase_exp1, final_mask, OpenDialog1.FileName);
  Form1.N57Click(Sender);
end;

procedure TForm1.N65Click(Sender: TObject);
var s: string;
begin
  if (not phase_exp2.loaded) or (not final_mask.loaded)then
    exit;

  SaveDialog1.Filter:='Bin files|*.bin';
  SaveDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  if not SaveDialog1.Execute then
    exit;
  s:=SaveDialog1.FileName;
  s:=ChangeFileExt(s, '.bin');

  CreateBin(phase_exp2, final_mask, s);
end;

procedure TForm1.N66Click(Sender: TObject);
begin
  OpenDialog1.Filter:='Bin files|*.bin';
  OpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  if not OpenDialog1.Execute then
    exit;
  LoadBin(phase_exp2, final_mask, OpenDialog1.FileName);
  Form1.N59Click(Sender);
end;

procedure TForm1.N68Click(Sender: TObject);
begin
  if not super_lunka.loaded then
    exit;
  final_phase.Clear;
  final_phase.Init(super_lunka.h, super_lunka.w, varDouble);
  CopyMemory(final_phase.a, super_lunka.a, super_lunka.w*super_lunka.h*sizeof(treal));
  pnl.DrawImage(final_phase, final_mask);
  CurrentMatrix:=cmUnwrap;
end;

procedure TForm1.N69Click(Sender: TObject);
begin
  if not tilt1.loaded then
    exit;
  final_phase.Clear;
  final_phase.Init(tilt1.h, tilt1.w, varDouble);
  CopyMemory(final_phase.a, tilt1.a, tilt1.w*tilt1.h*sizeof(treal));
  pnl.DrawImage(final_phase, final_mask);
  CurrentMatrix:=cmUnwrap;
end;

procedure TForm1.N70Click(Sender: TObject);
begin
  if not tilt2.loaded then
    exit;
  final_phase.Clear;
  final_phase.Init(tilt2.h, tilt2.w, varDouble);
  CopyMemory(final_phase.a, tilt2.a, tilt2.w*tilt2.h*sizeof(treal));
  pnl.DrawImage(final_phase, final_mask);
  CurrentMatrix:=cmUnwrap;
end;

procedure TForm1.N71Click(Sender: TObject);
begin
  if not phase_exp1.loaded then
    exit;
  SecondDerivative(phase_exp1, final_mask);
  final_phase.Clear;
  final_phase.Init(phase_exp1.h, phase_exp1.w, varDouble);
  CopyMemory(final_phase.a, phase_exp1.a, phase_exp1.w*phase_exp1.h*sizeof(treal));
  pnl.DrawImage(final_phase, final_mask);
  CurrentMatrix:=cmUnwrap;
end;

procedure TForm1.N72Click(Sender: TObject);
begin
  if not phase_exp2.loaded then
    exit;
  SecondDerivative(phase_exp2, final_mask);
  final_phase.Clear;
  final_phase.Init(phase_exp2.h, phase_exp2.w, varDouble);
  CopyMemory(final_phase.a, phase_exp2.a, phase_exp2.w*phase_exp2.h*sizeof(treal));
  pnl.DrawImage(final_phase, final_mask);
  CurrentMatrix:=cmUnwrap;
end;

procedure TForm1.N73Click(Sender: TObject);
begin
  if not phase_exp1.loaded then
    exit;
  Grad(phase_exp1);
  final_phase.Clear;
  final_phase.Init(phase_exp1.h, phase_exp1.w, varDouble);
  CopyMemory(final_phase.a, phase_exp1.a, phase_exp1.w*phase_exp1.h*sizeof(treal));
  pnl.DrawImage(final_phase, final_mask);
  CurrentMatrix:=cmUnwrap;
end;

procedure TForm1.N74Click(Sender: TObject);
begin
  if not phase_exp2.loaded then
    exit;
  Grad(phase_exp2);
  final_phase.Clear;
  final_phase.Init(phase_exp2.h, phase_exp2.w, varDouble);
  CopyMemory(final_phase.a, phase_exp2.a, phase_exp2.w*phase_exp2.h*sizeof(treal));
  pnl.DrawImage(final_phase, final_mask);
  CurrentMatrix:=cmUnwrap;
end;

procedure TForm1.N75Click(Sender: TObject);
var p: PMyInfernalType;
    i: integer;
begin
  p:=GetCurrentArray;
  if not p^.loaded then exit;

  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmCirc;
//  CopyMemory(_mask.b, mask_inner.b, cfg.cam_w*cfg.cam_h);
  off(false);
  pnl.DrawImage(p^, mask_inner);
  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;

  pnl.GetMask(p, @(_mask));
  pnl.DrawMode:=dmNone;

  for i:=0 to _mask.w*_mask.h-1 do
    if _mask.b^[i]=1 then
      mask_inner.b^[i]:=0;
  off(true);
  pnl.DrawImage(p^, mask_inner);
end;

procedure TForm1.N76Click(Sender: TObject);
begin
  if (not mask_inner.loaded) or (not mask_outer.loaded) then
    exit;

  with LoadSeqLunkaForm do
  begin
    edit2.Text:=IntToStr(cfg.steps);
    edit4.Text:=IntToStr(cfg.num_seq);
    edit1.Text:=cfg.img_path;
    edit3.Text:=cfg.img_path_izm;
    if ShowModal <> mrOk then
      exit;
    cfg.steps:=StrToInt(edit2.Text);
    cfg.num_seq:=StrToInt(edit4.Text);
    cfg.img_path:=edit1.Text;
    cfg.img_path_izm:=edit3.Text;
  end;
  cfg.do_seq:=true;
  LunkaThread_start(0);
end;

procedure TForm1.N77Click(Sender: TObject);
begin
  LunkaSeqResultsForm.Show;
end;

procedure TForm1.N78Click(Sender: TObject);
var s: string;
begin
  if not final_phase.loaded then
    exit;

  SaveDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  SaveDialog1.Filter:='Bin-files|*.bin';

  if not SaveDialog1.Execute  then
    exit;

  s:=SaveDialog1.FileName;
  s:=ChangeFileExt(s, '.bin');

  CreateBin(final_phase, mask_inner, s);

//  ShowMessage('Файл ошибки записан в директорию программы.');
end;

procedure TForm1.N80Click(Sender: TObject);
begin
  if not N80.Checked then
  begin
    {Form3.Show;
    Form4.Show;}

    panel1.Visible:=true;
    Splitter2.Visible:=true;
    pnl.DrawMode:=dmNone;
    pnl.DrawMode:=dmLargeCross;
    chart1.Width:=Panel1.Width div 2;
  end
  else
  begin
    {Form3.close;
    Form4.close;}
    Splitter2.Visible:=false;
    panel1.Visible:=false;
    pnl.DrawMode:=dmNone;
    pnl.Repaint;
  end;
  N80.Checked:=not N80.Checked;
end;

procedure TForm1.N81Click(Sender: TObject);
begin
  if not n81.Checked then
    form8.Show
  else
    form8.close;

  n81.Checked:=not n81.Checked;
end;

procedure TForm1.N83Click(Sender: TObject);
var mode: TDrawMode;
    i: integer;
begin
  {if not int.loaded then
  begin
    ShowMessage('Интерферограммы незагружены');
    exit;
  end;
  if not unwrap.loaded then
  begin
    ShowMessage('Расчет не проведен');
    exit;
  end;
   }
  mode:=pnl.DrawMode;
  off(false);
  TraceLinesMode:=tlmH;
  RaznForm.Show;
  Form5.Show;
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmTraceLines;
  pnl.CounLines:=1;
  pnl.SetScale_x(cfg.scl_eye);
  pnl.Cursor:=crMyShittyCursor;

  repeat
    Application.ProcessMessages;
  until pnl.Finalized;
  pnl.Cursor:=crDefault;
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=mode;
  RaznForm.Close;
  Form5.Close;
  off(true);
end;

procedure TForm1.N87Click(Sender: TObject);
var i, j, h, w: integer;
    p: PMyInfernalType;
begin
  if not phase.loaded then
    exit;

  w:= ProjectData.prop_.w;
  h:= ProjectData.prop_.h;

  for i:=10 to h-9 do
    for j:=10 to w-9 do
      mask_inner.b^[i*w+j]:=1;

  SaveMaskAndUpdateVt(amMask1);

  pnl.DrawImage(phase, mask_inner);
  exit;


  p:=GetCurrentArray;
  if not p^.loaded then exit;
  w:=cfg.cam_w;
  h:=cfg.cam_h;

  ZeroMemory(mask_inner.b, w*h);
  for i:=10 to h-9 do
    for j:=10 to w-9 do
      mask_inner.b^[i*w+j]:=1;

 { with p^ do
  begin
    x_hist:=x_img;
    y_hist:=y_img;
    w_hist:=w_img;
    h_hist:=h_img;
    ColorScale:=byArea_hist;
  end;
  }
  pnl.DrawImage(p^, mask_inner);
  CurrentMask:=cmMask1;
  UpdateLegendLabels;
end;

procedure TForm1.N88Click(Sender: TObject);
var m: PMyInfernalType;
begin
  m:=GetCurrentMask;
  if phase.loaded and m^.loaded then
  begin
    CurrentMatrix:=cmPhase;
    pnl.DrawImage(phase, m^);
    UpdateLegendLabels;
  end
  else
    ShowMessage('Расчет не проведен. Увы...');
end;

procedure TForm1.N90Click(Sender: TObject);
var w,h: integer;
begin

  TwoWaveLengthDialogForm.Edit1.Text:=FloatToStr(cfg.n_photo);
  if TwoWaveLengthDialogForm.ShowModal = mrOk then
  begin
    cfg.n_photo:=CheckString(TwoWaveLengthDialogForm.Edit1.Text);

    LoadBmp(int, izm1.int_list.Strings[0], varByte);
    w:=int.w;
    h:=int.h;

    with cfg do
    begin
      cam_w:=w;
      cam_h:=h;
      scl_eye:=(w1/cam_w+h1/cam_h)/2;
    end;

    _origin:=false;
    mask_b:=false;

    _mask.Clear;
    _mask.Init(h, w, varByte, 1);
    mask_inner.Clear;
    mask_inner.Init(h, w, varByte, 0);
    mask_outer.Clear;
    mask_outer.Init(h, w, varByte);
    final_mask.Clear;
    final_mask.Init(h, w, varByte, 1);

    pnl.Contrast_mask:=0.5;
    pnl.DrawImage(int, mask_inner);
    pnl.Contrast_mask:=1;


    CurrentMatrix:=cmInt;
    pnl.InterpMode:=imNearest;
    UpdateLegend;
    UpdateLegendLabels;
  end;
end;

procedure TForm1.N91Click(Sender: TObject);
begin
  TwoWaveLengthThread:=TTwoWaveLengthThread.Create(true);
  TwoWaveLengthThread.FreeOnTerminate:=true;
  TwoWaveLengthThread.Resume;
  Off(false);
end;

procedure TForm1.N92Click(Sender: TObject);
var p: PMyInfernalType;
    i, w, h, cnt: integer;
    mode: TDrawMode;
begin
  p:=GetCurrentArray;
  if not p^.loaded then exit;

  w:=p^.w;
  h:=p^.h;
  pnl.Contrast_mask:=1;

  cnt:=0;
  for i:=0 to w*h-1 do
    if mask_outer.b^[i] = 1 then
      inc(cnt);

  if cnt = 0 then
    exit;

  pnl.DrawImage(p^, mask_outer);

  mode:=pnl.DrawMode;
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmLine;


  off(false);
  pnl.Cursor:=crMyShittyCursor;

  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;
  pnl.Cursor:=crDefault;

  pnl.GetMask(p, @(_mask));

  for i:=0 to w*h-1 do
    if _mask.b^[i]=1 then
      mask_outer.b^[i]:=0;

  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=mode;

  pnl.DrawImage(p^, mask_outer);

  off(true);
  UpdateLegendLabels;
  CurrentMask:=cmMask2;

end;

procedure TForm1.N93Click(Sender: TObject);
var p: PMyInfernalType;
    i, j: integer;
    p1, p2: TPoint;
    mode: TDrawMode;
begin
  p:=GetCurrentArray;
  if not p^.loaded then exit;

  mode:=pnl.DrawMode;
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmLine;
//  CopyMemory(_mask.b, mask_inner.b, cfg.cam_w*cfg.cam_h);
  off(false);
//  pnl.DrawImage(p^, _mask);
  pnl.Cursor:=crMyShittyCursor;
  pnl.DrawImage(p^, mask_inner);
  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;
  pnl.Cursor:=crDefault;

  pnl.GetMask(@(int), @(_mask));

  for i:=0 to mask_inner.w*mask_inner.h-1 do
    if _mask.b^[i]=1 then
      mask_inner.b^[i]:=0;

{
  p1:=pnl.GetPoint1;
  p2:=pnl.GetPoint2;

  for i:=p1.y to p2.y do
    for j:=p1.x to p2.x do
      mask_inner.b^[i*cfg.cam_w+j]:=0;
 }
  {with p^ do
  begin
    x_hist:=x_img;
    y_hist:=y_img;
    w_hist:=w_img;
    h_hist:=h_img;
    ColorScale:=byArea_hist;
  end;}

//  pnl.GetMask(p, @(_mask));
//  pnl.DrawMode:=dmNone;

//  for i:=0 to _mask.w*_mask.h-1 do
//    if _mask.b^[i]=1 then
//      mask_inner.b^[i]:=0;

  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=mode;
  off(true);
  pnl.DrawImage(p^, mask_inner);
  UpdateLegendLabels;

end;

procedure TForm1.N94Click(Sender: TObject);
var m: PMyInfernalType;
begin
  m:=GetCurrentMask;
  if amp.loaded and m^.loaded then
  begin
    CurrentMatrix:=cmAmp;
    pnl.DrawImage(amp, m^);
    UpdateLegendLabels;
  end
  else
    ShowMessage('Расчет не проведен. Увы...');
end;

procedure TForm1.N95Click(Sender: TObject);
begin
  SaveAsForm.CheckBox5.Checked:=boolean(cfg.SaveAS and WP_SAVE_AMPLITUDE);
  SaveAsForm.CheckBox6.Checked:=boolean(cfg.SaveAS and WP_SAVE_PHASE);
  SaveAsForm.CheckBox7.Checked:=boolean(cfg.SaveAS and WP_SAVE_UNWRAP);
  SaveAsForm.CheckBox1.Checked:=boolean(cfg.SaveAS and WP_SAVE_BMP);
  SaveAsForm.CheckBox2.Checked:=boolean(cfg.SaveAS and WP_SAVE_MATLAB);
  SaveAsForm.CheckBox3.Checked:=boolean(cfg.SaveAS and WP_SAVE_TXT);
  SaveAsForm.CheckBox4.Checked:=boolean(cfg.SaveAS and WP_SAVE_BIN);
  SaveAsForm.Edit1.Text:=cfg.SavePath;
  SaveAsForm.CheckBox8.Checked:=cfg.SaveOnlyMaskedArea;

  if SaveAsForm.ShowModal <> mrOk then
    exit;

  cfg.SaveAS:=0;
  if SaveAsForm.CheckBox5.Checked then cfg.SaveAS:=cfg.SaveAS or WP_SAVE_AMPLITUDE;
  if SaveAsForm.CheckBox6.Checked then cfg.SaveAS:=cfg.SaveAS or WP_SAVE_PHASE;
  if SaveAsForm.CheckBox7.Checked then cfg.SaveAS:=cfg.SaveAS or WP_SAVE_UNWRAP;
  if SaveAsForm.CheckBox1.Checked then cfg.SaveAS:=cfg.SaveAS or WP_SAVE_BMP;
  if SaveAsForm.CheckBox2.Checked then cfg.SaveAS:=cfg.SaveAS or WP_SAVE_MATLAB;
  if SaveAsForm.CheckBox3.Checked then cfg.SaveAS:=cfg.SaveAS or WP_SAVE_TXT;
  if SaveAsForm.CheckBox4.Checked then cfg.SaveAS:=cfg.SaveAS or WP_SAVE_BIN;
  cfg.SavePath:=SaveAsForm.Edit1.Text;
  cfg.SaveOnlyMaskedArea:=SaveAsForm.CheckBox8.Checked;

  SaveAS;
end;

procedure TForm1.N97Click(Sender: TObject);
var p: PMyInfernalType;
begin
  p:=GetCurrentArray;
  if p^.loaded and final_mask.loaded then
  begin
    CurrentMask:=cmFinal;
    pnl.DrawImage(p^, final_mask);
    UpdateLegendLabels;
  end;

end;

procedure TForm1.N98Click(Sender: TObject);
var p: PMyInfernalType;
    w, h, i, j: integer;
begin
  p:=GetCurrentArray;
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmCross;

  w:=cfg.cam_w;
  h:=cfg.cam_h;
  final_mask.Clear;
  final_mask.Init(h, w, varByte);

  for i:=0 to w*h-1 do
    if (mask_inner.b^[i*w+j]=1) or (mask_outer.b^[i*w+j]=1) then
      final_mask.b^[i*w+j]:=1;

  pnl.DrawImage(p^, final_mask);
  Off(false);
  pnl.Cursor:=crMyShittyCursor;
  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;
  pnl.Cursor:=crDefault;
  Off(true);
  Origin:=pnl.GetOrigin;
  pnl.DrawMode:=dmNone;
  pnl.DrawImage(p^, final_mask);
  _origin:=true;

end;

procedure TForm1.bmp1Click(Sender: TObject);
var
  s: string;
begin
  if not unwrap.loaded then
  begin
    ShowMessage('Расчет не проведен. Нечего сохранять!');
    exit;
  end;
  SaveDialog1.InitialDir:=cfg.path;
  SaveDialog1.Filter:='Bitmap files|*.bmp';
  SaveDialog1.Title:='Сохранить изображение';
  if  SaveDialog1.Execute then
  begin
    s:=SaveDialog1.FileName;
    s:=ChangeFileExt(s, '.bmp');
    pnl.bitmap.SaveToFile(s);
  end;

end;

procedure TForm1.Matlabfilem1Click(Sender: TObject);
var scl: treal;
begin
   if not unwrap.loaded then
   begin
     ShowMessage('Расчет не проведен. Нечего сохранять!');
     exit;
   end;
   SaveDialog1.InitialDir:=cfg.path;
   SaveDialog1.Filter:='Matlab files|*.m';
   SaveDialog1.Title:='Сохранить m-файл';
   if cfg.input = 1 then
     scl:=(cfg.h1/int.h + cfg.w1/int.w)/2
   else
     scl:=(cfg.h2/int.h + cfg.w2/int.w)/2;
   if  SaveDialog1.Execute then
   begin
     cfg.path:=ExtractFilePath(SaveDialog1.FileName);
     case cfg.input of
       1: SaveRealArray2Matlab(final_phase, scl, SaveDialog1.FileName+'.m');
       2: SaveRealArray2Matlab(final_phase, scl, SaveDialog1.FileName+'.m');
     end;
   end;
end;

procedure TForm1.Move2Start;
begin
  if cfg.Step_Motor_Curr_Pos > 0 then
    Shift(cfg.Step_Motor_Curr_Pos, 50, true, false, true)
  else
    Shift(abs(cfg.Step_Motor_Curr_Pos), 50,  true, true, true);
end;

procedure TForm1.MoveMirrorCom(pos: word);
var p: array[0..2] of byte;
begin
{  p[0]:=0;
  p[1]:=32;
  p[2]:=1;
  CommPortDriver1.SendData(@(p), 3);
 }

//  CopyMemory(@(p[0]), @(pos), 2);
//  p[0]:=0;
//  p[1]:=128;
//  p[1]:=p[1]+128;
  p[0]:=LowByte(pos);
  p[1]:=HiByte(pos)+128;
  p[2]:=15;
  CommPortDriver1.SendData(@(p), 3);



end;

procedure TForm1.Off(b: boolean);
var i, j: integer;
begin
  ToolBar2.Enabled:=b;
//  ToolBar4.Enabled:=b;
  for i:=0 to ToolBar4.ButtonCount-1 do
    ToolBar4.Buttons[i].Enabled:=b;

  for i:=0 to MainMenu1.Items.Count-1 do
  begin
    MainMenu1.Items[i].Enabled:=b;
    for j:=0 to MainMenu1.Items[i].Count-1 do
      MainMenu1.Items[i].Items[j].Enabled:=b;
  end;
  {n1.Enabled:=b;
  n2.Enabled:=b;
  n15.Enabled:=b;
  n22.Enabled:=b;}
end;


procedure TForm1.ToolButton43Click(Sender: TObject);
var mode: TDrawMode;
    i: integer;
begin
  if not int.loaded then
  begin
    ShowMessage('Интерферограммы незагружены');
    ToolButton43.Down:=false;
    exit;
  end;
  if not unwrap.loaded then
  begin
    ShowMessage('Расчет не проведен');
    ToolButton43.Down:=false;
    exit;
  end;
  N13Click(Self);

  if ToolButton43.Down then
  begin
    mode:=pnl.DrawMode;

    for i:=0 to MainMenu1.Items.Count - 1 do
      MainMenu1.Items[i].Enabled:=false;
    for i:=0 to ToolBar2.ButtonCount-1 do
      ToolBar2.Buttons[i].Enabled:=false;
    ToolButton43.Enabled:=true;



    {n1.Enabled:=false;
    n2.Enabled:=false;
    n15.Enabled:=false;
    n22.Enabled:=false;
    ToolButton13.Enabled:=false;
    ToolButton14.Enabled:=false;
    ToolButton15.Enabled:=false;
    ToolButton16.Enabled:=false;
    ToolButton17.Enabled:=false;
    ToolButton33.Enabled:=false;
    ToolButton44.Enabled:=false;
    ToolButton34.Enabled:=false;
    ToolButton35.Enabled:=false;
    ToolButton37.Enabled:=false;
    ToolButton39.Enabled:=false;
    ToolButton40.Enabled:=false;
    ToolButton42.Enabled:=false;
    ToolButton32.Enabled:=false;
     }

    TraceLinesMode:=tlmH;
    RaznForm.Show;
    Form3.Show;


    pnl.DrawMode:=dmNone;
    pnl.DrawMode:=dmTraceLines;
    pnl.CounLines:=1;
    pnl.SetScale_x(cfg.scl_eye);

    repeat
      Application.ProcessMessages;
    until pnl.Finalized;

    {n1.Enabled:=true;
    n2.Enabled:=true;
    n15.Enabled:=true;
    n22.Enabled:=true;
    ToolButton13.Enabled:=true;
    ToolButton14.Enabled:=true;
    ToolButton15.Enabled:=true;
    ToolButton16.Enabled:=true;
    ToolButton17.Enabled:=true;
    ToolButton33.Enabled:=true;
    ToolButton44.Enabled:=true;
    ToolButton34.Enabled:=true;
    ToolButton35.Enabled:=true;
    ToolButton37.Enabled:=true;
    ToolButton39.Enabled:=true;
    ToolButton40.Enabled:=true;
    ToolButton42.Enabled:=true;
    ToolButton32.Enabled:=true;
     }
    pnl.DrawMode:=dmNone;
    pnl.DrawMode:=mode;
    RaznForm.Close;

    if not (mode = dmLargeCross) then
      Form3.Close;




    for i:=0 to MainMenu1.Items.Count - 1 do
      MainMenu1.Items[i].Enabled:=true;
    for i:=0 to ToolBar2.ButtonCount-1 do
      ToolBar2.Buttons[i].Enabled:=true;

  end;
  ToolButton43.Down:=not ToolButton43.Down;

{  int.Init(0,0,varByte);
  for i:=0 to cfg.steps-1 do
  begin
    LoadBin(int, int, int, cfg.img_path+'\int'+inttostr(i+1)+'.bin');
    pnl.DrawImage(int, int);
    sleep(500);
  end;
  //VideoThread.Destroy;}
end;

procedure TForm1.LoadBitmaps(p: TMyInfernalArray);
var i: integer;
begin
  for i:=0 to cfg.steps-1 do
    LoadBin(p[i], p[i], int, cfg.img_path+'\int'+IntToStr(i+1)+'.bin');
{}
end;

procedure TForm1.ToolButton44Click(Sender: TObject);
var mode: TDrawMode;
begin
  if not int.loaded then
  begin
    ShowMessage('Интерферограммы незагружены');
    ToolButton44.Down:=false;
    exit;
  end;
  if not unwrap.loaded then
  begin
    ShowMessage('Расчет не проведен');
    ToolButton44.Down:=false;
    exit;
  end;
  N13Click(Self);

  if ToolButton44.Down then
  begin
    //Off(False);
    mode:=pnl.DrawMode;

    n1.Enabled:=false;
    n2.Enabled:=false;
    n15.Enabled:=false;
    n22.Enabled:=false;
    ToolButton13.Enabled:=false;
    ToolButton14.Enabled:=false;
    ToolButton15.Enabled:=false;
    ToolButton16.Enabled:=false;
    ToolButton17.Enabled:=false;
    ToolButton33.Enabled:=false;
    ToolButton44.Enabled:=false;
    ToolButton34.Enabled:=false;
    ToolButton35.Enabled:=false;
    ToolButton37.Enabled:=false;
    ToolButton39.Enabled:=false;
    ToolButton40.Enabled:=false;
    ToolButton42.Enabled:=false;
    ToolButton32.Enabled:=false;

    TraceLinesMode:=tlmRZ;
//    RaznForm.Show;
    if not (mode = dmLargeCross) then
//    begin
      Form3.Show;
//      Form4.Show;
//    end;
    RaRzRmaxForm.Show;
    pnl.DrawMode:=dmNone;
    pnl.DrawMode:=dmTraceLines;
    pnl.CounLines:=1;
    pnl.SetScale_x(cfg.scl_eye);

    repeat
      Application.ProcessMessages;
    until pnl.Finalized;
    //Off(true);
    n1.Enabled:=true;
    n2.Enabled:=true;
    n15.Enabled:=true;
    n22.Enabled:=true;
    ToolButton13.Enabled:=true;
    ToolButton14.Enabled:=true;
    ToolButton15.Enabled:=true;
    ToolButton16.Enabled:=true;
    ToolButton17.Enabled:=true;
    ToolButton33.Enabled:=true;
    ToolButton44.Enabled:=true;
    ToolButton34.Enabled:=true;
    ToolButton35.Enabled:=true;
    ToolButton37.Enabled:=true;
    ToolButton39.Enabled:=true;
    ToolButton40.Enabled:=true;
    ToolButton42.Enabled:=true;
    ToolButton32.Enabled:=true;

    pnl.DrawMode:=dmNone;
    pnl.DrawMode:=mode;
//    RaznForm.Close;
//
    if not (mode = dmLargeCross) then
//    begin
      Form3.Close;
//      Form4.Close;
//    end;
    RaRzRmaxForm.Close;
  end;
  ToolButton44.Down:=not ToolButton44.Down;

end;

procedure TForm1.Button2Click(Sender: TObject);
begin
// Off(false);
//  Timer1.Enabled:=false;
//  CommPortDriver1.Disconnect;
//  WatchComThread.Resume;
// EscapeCommFunction(CommPortDriver1.ComHandle, 5);
  Shift(0, 10, true, true, true);
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Shift(30, 70, true, true, true);

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  Shift(10, 10, true, false, true);
end;

procedure TForm1.Button5Click(Sender: TObject);
begin

  InitComThread:=TInitComThread.Create(true);
  InitComThread.FreeOnTerminate:=true;
  InitComThread.Start;
  InitComThreadForm.Show;
end;

procedure TForm1.N102Click(Sender: TObject);
var p: PMyInfernalType;
    i, w, h, cnt: integer;
    mode: TDrawMode;
begin
//  p:=GetCurrentArray;
//  if not p^.loaded then exit;


//  w:=p^.w;
//  h:=p^.h;

  if not phase.loaded then exit;
  w:= ProjectData.prop_.w;
  h:= ProjectData.prop_.h;

  pnl.Contrast_mask:=1;

  cnt:=0;
  for i:=0 to w*h-1 do
    if mask_inner.b^[i] = 1 then
      inc(cnt);

  if cnt = 0 then
    pnl.DrawImage(p^, p^)
  else
    pnl.DrawImage(p^, mask_inner);


  mode:=pnl.DrawMode;
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmCirc;


  off(false);
  pnl.Cursor:=crMyShittyCursor;

  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;
  pnl.Cursor:=crDefault;

  pnl.GetMask(p, @(_mask));

  for i:=0 to w*h-1 do
    if _mask.b^[i]=1 then
      mask_inner.b^[i]:=1;

  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=mode;

  pnl.DrawImage(p^, mask_inner);

  off(true);
  CurrentMask:=cmMask1;
  UpdateLegendLabels;

end;

procedure TForm1.N103Click(Sender: TObject);
var p: PMyInfernalType;
    i, w, h, cnt: integer;
    mode: TDrawMode;
begin
  p:=GetCurrentArray;
  if not p^.loaded then exit;

  w:=p^.w;
  h:=p^.h;
  pnl.Contrast_mask:=1;

  cnt:=0;
  for i:=0 to w*h-1 do
    if mask_inner.b^[i] = 1 then
      inc(cnt);

  if cnt = 0 then
    pnl.DrawImage(p^, p^)
  else
    pnl.DrawImage(p^, mask_inner);


  mode:=pnl.DrawMode;
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmRect;


  off(false);
  pnl.Cursor:=crMyShittyCursor;

  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;
  pnl.Cursor:=crDefault;

  pnl.GetMask(p, @(_mask));

  for i:=0 to w*h-1 do
    if _mask.b^[i]=1 then
      mask_inner.b^[i]:=1;

  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=mode;

  pnl.DrawImage(p^, mask_inner);

  off(true);
  CurrentMask:=cmMask1;
  UpdateLegendLabels;
end;

procedure TForm1.N104Click(Sender: TObject);
var p: PMyInfernalType;
    i, w, h, cnt: integer;
    mode: TDrawMode;
begin
  p:=GetCurrentArray;
  if not p^.loaded then exit;

  w:=p^.w;
  h:=p^.h;
  pnl.Contrast_mask:=1;

  cnt:=0;
  for i:=0 to w*h-1 do
    if mask_inner.b^[i] = 1 then
      inc(cnt);

  if cnt = 0 then
    pnl.DrawImage(p^, p^)
  else
    pnl.DrawImage(p^, mask_inner);


  mode:=pnl.DrawMode;
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmLine;


  off(false);
  pnl.Cursor:=crMyShittyCursor;

  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;
  pnl.Cursor:=crDefault;

  pnl.GetMask(p, @(_mask));

  for i:=0 to w*h-1 do
    if _mask.b^[i]=1 then
      mask_inner.b^[i]:=1;

  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=mode;

  pnl.DrawImage(p^, mask_inner);

  off(true);
  UpdateLegendLabels;
  CurrentMask:=cmMask1;
end;

procedure TForm1.N105Click(Sender: TObject);
var p: PMyInfernalType;
    i, w, h, cnt: integer;
    mode: TDrawMode;
begin
  p:=GetCurrentArray;
  if not p^.loaded then exit;

  w:=p^.w;
  h:=p^.h;

  cnt:=0;
  for i:=0 to w*h-1 do
    if mask_inner.b^[i] = 1 then
      inc(cnt);

  if cnt = 0 then
    exit;

  mode:=pnl.DrawMode;
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmCirc;
  pnl.Contrast_mask:=1;

  pnl.DrawImage(p^, mask_inner);
  off(false);
  pnl.Cursor:=crMyShittyCursor;

  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;
  pnl.Cursor:=crDefault;

  pnl.GetMask(p, @(_mask));

  for i:=0 to w*h-1 do
    if _mask.b^[i]=1 then
      mask_inner.b^[i]:=0;

  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=mode;

  pnl.DrawImage(p^, mask_inner);

  off(true);
  CurrentMask:=cmMask1;
  UpdateLegendLabels;
end;

procedure TForm1.N106Click(Sender: TObject);
var p: PMyInfernalType;
    i, w, h, cnt: integer;
    mode: TDrawMode;
begin
  p:=GetCurrentArray;
  if not p^.loaded then exit;

  w:=p^.w;
  h:=p^.h;

  cnt:=0;
  for i:=0 to w*h-1 do
    if mask_inner.b^[i] = 1 then
      inc(cnt);

  if cnt = 0 then
    exit;



  mode:=pnl.DrawMode;
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmRect;
  pnl.Contrast_mask:=1;

  pnl.DrawImage(p^, mask_inner);
  off(false);
  pnl.Cursor:=crMyShittyCursor;

  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;
  pnl.Cursor:=crDefault;

  pnl.GetMask(p, @(_mask));

  for i:=0 to w*h-1 do
    if _mask.b^[i]=1 then
      mask_inner.b^[i]:=0;

  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=mode;

  pnl.DrawImage(p^, mask_inner);

  off(true);
  CurrentMask:=cmMask1;
  UpdateLegendLabels;

end;

procedure TForm1.N107Click(Sender: TObject);
var p: PMyInfernalType;
    i, w, h, cnt: integer;
    mode: TDrawMode;
begin
  p:=GetCurrentArray;
  if not p^.loaded then exit;

  w:=p^.w;
  h:=p^.h;

  cnt:=0;
  for i:=0 to w*h-1 do
    if mask_inner.b^[i] = 1 then
      inc(cnt);

  if cnt = 0 then
    exit;

  mode:=pnl.DrawMode;
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmLine;
  pnl.Contrast_mask:=1;

  pnl.DrawImage(p^, mask_inner);
  off(false);
  pnl.Cursor:=crMyShittyCursor;

  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;
  pnl.Cursor:=crDefault;

  pnl.GetMask(p, @(_mask));

  for i:=0 to w*h-1 do
    if _mask.b^[i]=1 then
      mask_inner.b^[i]:=0;

  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=mode;

  pnl.DrawImage(p^, mask_inner);

  off(true);
  CurrentMask:=cmMask1;
  UpdateLegendLabels;
end;

procedure TForm1.N108Click(Sender: TObject);
var p: PMyInfernalType;
    i, w, h, cnt: integer;
    mode: TDrawMode;
begin
  p:=GetCurrentArray;
  if not p^.loaded then exit;

  w:=p^.w;
  h:=p^.h;
  pnl.Contrast_mask:=1;

  cnt:=0;
  for i:=0 to w*h-1 do
    if mask_outer.b^[i] = 1 then
      inc(cnt);

  if cnt = 0 then
    pnl.DrawImage(p^, p^)
  else
    pnl.DrawImage(p^, mask_outer);


  mode:=pnl.DrawMode;
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmCirc;


  off(false);
  pnl.Cursor:=crMyShittyCursor;

  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;
  pnl.Cursor:=crDefault;

  pnl.GetMask(p, @(_mask));

  for i:=0 to w*h-1 do
    if _mask.b^[i]=1 then
      mask_outer.b^[i]:=1;

  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=mode;

  pnl.DrawImage(p^, mask_outer);

  off(true);
  UpdateLegendLabels;
  CurrentMask:=cmMask2;

end;

procedure TForm1.N109Click(Sender: TObject);
var p: PMyInfernalType;
    i, w, h, cnt: integer;
    mode: TDrawMode;
begin
  p:=GetCurrentArray;
  if not p^.loaded then exit;

  w:=p^.w;
  h:=p^.h;
  pnl.Contrast_mask:=1;

  cnt:=0;
  for i:=0 to w*h-1 do
    if mask_outer.b^[i] = 1 then
      inc(cnt);

  if cnt = 0 then
    pnl.DrawImage(p^, p^)
  else
    pnl.DrawImage(p^, mask_outer);


  mode:=pnl.DrawMode;
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmRect;


  off(false);
  pnl.Cursor:=crMyShittyCursor;

  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;
  pnl.Cursor:=crDefault;

  pnl.GetMask(p, @(_mask));

  for i:=0 to w*h-1 do
    if _mask.b^[i]=1 then
      mask_outer.b^[i]:=1;

  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=mode;

  pnl.DrawImage(p^, mask_outer);

  off(true);
  UpdateLegendLabels;
  CurrentMask:=cmMask2;
end;

procedure TForm1.N10Click(Sender: TObject);
begin
  ToolButton23.Click;
end;

procedure TForm1.N111Click(Sender: TObject);
var p: PMyInfernalType;
begin
  p:=GetCurrentArray;
  if p^.loaded and mask_inner.loaded then
  begin
    CurrentMask:=cmMask1;
    pnl.DrawImage(p^, mask_inner);
    UpdateLegendLabels;
  end;

end;

procedure TForm1.N112Click(Sender: TObject);
var p: PMyInfernalType;
    i, w, h, cnt: integer;
    mode: TDrawMode;
begin
  p:=GetCurrentArray;
  if not p^.loaded then exit;

  w:=p^.w;
  h:=p^.h;
  pnl.Contrast_mask:=1;

  cnt:=0;
  for i:=0 to w*h-1 do
    if mask_outer.b^[i] = 1 then
      inc(cnt);

  if cnt = 0 then
    pnl.DrawImage(p^, p^)
  else
    pnl.DrawImage(p^, mask_outer);


  mode:=pnl.DrawMode;
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmLine;


  off(false);
  pnl.Cursor:=crMyShittyCursor;

  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;
  pnl.Cursor:=crDefault;

  pnl.GetMask(p, @(_mask));

  for i:=0 to w*h-1 do
    if _mask.b^[i]=1 then
      mask_outer.b^[i]:=1;

  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=mode;

  pnl.DrawImage(p^, mask_outer);

  off(true);
  UpdateLegendLabels;
  CurrentMask:=cmMask2;
end;

procedure TForm1.N113Click(Sender: TObject);
var p: PMyInfernalType;
    i, w, h, cnt: integer;
    mode: TDrawMode;
begin
  p:=GetCurrentArray;
  if not p^.loaded then exit;

  w:=p^.w;
  h:=p^.h;
  pnl.Contrast_mask:=1;

  cnt:=0;
  for i:=0 to w*h-1 do
    if mask_outer.b^[i] = 1 then
      inc(cnt);

  if cnt = 0 then
    exit;

  pnl.DrawImage(p^, mask_outer);

  mode:=pnl.DrawMode;
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmCirc;


  off(false);
  pnl.Cursor:=crMyShittyCursor;

  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;
  pnl.Cursor:=crDefault;

  pnl.GetMask(p, @(_mask));

  for i:=0 to w*h-1 do
    if _mask.b^[i]=1 then
      mask_outer.b^[i]:=0;

  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=mode;

  pnl.DrawImage(p^, mask_outer);

  off(true);
  UpdateLegendLabels;
  CurrentMask:=cmMask2;

end;

procedure TForm1.N114Click(Sender: TObject);
var p: PMyInfernalType;
    i, w, h, cnt: integer;
    mode: TDrawMode;
begin
  p:=GetCurrentArray;
  if not p^.loaded then exit;

  w:=p^.w;
  h:=p^.h;
  pnl.Contrast_mask:=1;

  cnt:=0;
  for i:=0 to w*h-1 do
    if mask_outer.b^[i] = 1 then
      inc(cnt);

  if cnt = 0 then
    exit;

  pnl.DrawImage(p^, mask_outer);

  mode:=pnl.DrawMode;
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmRect;


  off(false);
  pnl.Cursor:=crMyShittyCursor;

  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;
  pnl.Cursor:=crDefault;

  pnl.GetMask(p, @(_mask));

  for i:=0 to w*h-1 do
    if _mask.b^[i]=1 then
      mask_outer.b^[i]:=0;

  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=mode;

  pnl.DrawImage(p^, mask_outer);

  off(true);
  UpdateLegendLabels;
  CurrentMask:=cmMask2;

end;

procedure TForm1.N115Click(Sender: TObject);
var i, j, h, w: integer;
    p: PMyInfernalType;
begin
  p:=GetCurrentArray;
  if not p^.loaded then exit;
  w:=cfg.cam_w;
  h:=cfg.cam_h;

  ZeroMemory(mask_outer.b, w*h);
  for i:=10 to h-9 do
    for j:=10 to w-9 do
      mask_outer.b^[i*w+j]:=1;

  pnl.DrawImage(p^, mask_outer);
  CurrentMask:=cmMask2;
  UpdateLegendLabels;
end;

procedure TForm1.N116Click(Sender: TObject);
var p, m: PMyInfernalType;
    x, y, z, r, k: treal;

begin
  p:=GetCurrentArray;
  m:=GetCurrentMask;

  with cfg do
    scl_eye:=(w1/cam_w+h1/cam_h)/2;

  k:=cfg.scl_eye*1e3;
  MNK_Sphere(p^.a^, m^.b^, x, y, z, r, k, p^.w, p^.h);

  r:=r*1e-6;
  ShowMessage('Радиус поверхности ' + FloatToStrF(r, ffFixed, 7, 2)+ ' мм.');
end;

procedure TForm1.N117Click(Sender: TObject);
begin
  OpenDialog1.Filter:='winPhast project files|*.winPhast';

  if not OpenDialog1.Execute() then
    exit;

  if OpenProject(AnsiString(OpenDialog1.FileName), ProjectData) then
  begin
    vt.Clear;
    AddToVt(ProjectData);
  end;

end;

procedure TForm1.N11Click(Sender: TObject);
begin
  ToolButton16.Click;
end;

procedure TForm1.N211Click(Sender: TObject);
var p: PMyInfernalType;
begin
  p:=GetCurrentArray;
  pnl.DrawMode:=dmNone;
  pnl.DrawMode:=dmCross;
  pnl.DrawImage(p^, mask_outer);
  Off(false);
  pnl.Cursor:=crMyShittyCursor;
  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;
  pnl.Cursor:=crDefault;
  Off(true);
  Origin02:=pnl.GetOrigin;
  pnl.DrawMode:=dmNone;
  pnl.DrawImage(p^, mask_outer);
  _origin:=true;
end;

procedure TForm1.N212Click(Sender: TObject);
var p: PMyInfernalType;
begin
  p:=GetCurrentArray;
  if p^.loaded and mask_outer.loaded then
  begin
    CurrentMask:=cmMask2;
    pnl.DrawImage(p^, mask_outer);
    UpdateLegendLabels;
  end;
end;

procedure TForm1.N21Click(Sender: TObject);
begin
  ToolButton42.Click;
end;

procedure TForm1.ToolButton45Click(Sender: TObject);
begin
  pnl.DrawImage(int, int);


  pnl.DrawMode:=dmNewSpline;
  repeat
    Application.ProcessMessages;
  until pnl.Finalized;
  pnl.GetMask(@(int), @(mask_inner));
  pnl.DrawImage(int, mask_inner);


end;

procedure TForm1.ToolButton49Click(Sender: TObject);
begin
  What2CalcForm.ind:=-1;
  if What2CalcForm.ShowModal <> mrOk then
    exit;

 case What2CalcForm.ind of
   1: N33Click(nil);
   2: N38Click(nil);
   3: N34Click(nil);
   4: N37Click(nil);
 end;

end;

end.
