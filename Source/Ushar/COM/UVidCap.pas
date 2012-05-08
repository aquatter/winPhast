unit UVidCap;

interface
uses Dialogs, Windows, SysUtils, UVidCap_ini, VidCap, crude, giveio, ULPTWatcher2,
     ExtCtrls, utype, Classes, Comm32, UComWatcher;

type
  TTS_VidCap = class
  public


    capture, cap_run, cap_dev: boolean;
    i: integer;
    LPTWatcher: TLPTWatcher2;
    Timer: TTimer;
    Comm321: TComm32;
    _WaitEvent: THandle;
    _handle: HWND;
    _err: (erINIFile, erLPT, erCOM, erFlyVideo, erNone);
    status: byte;
    procedure GetVidCapParam(var pVidCapParam: TVidCapParam);
    procedure Capture_Stop;
    procedure Capture_Stop_Phase_Shift;
    procedure Capture_Start;
    procedure Capture_Start_Phase_Shift;
    procedure AutoRegON;
    procedure AutoRegOFF;
    procedure GetCapturedBitmaps(frame1, frame2, frame3: PBtArr); overload;
    procedure GetCapturedBitmaps(frame1, frame2, frame3, frame4, frame5: PBtArr); overload;
    procedure GetAverageFrame(frame: PBtArr);
    procedure GetPlanBFrames(frames: PBtPointerArr);
    procedure GetCapturedBitmap(frame: PBtArr);
    procedure OnTimer(Sender: TObject);
    procedure OnTimer2(Sender: TObject);
    procedure CommEvent(Sender: TObject);
    procedure MallocCaptureFrame(var p: PBtArr; var w, h: integer);
    procedure MallocVideoFrame(var p: PBtArr; var w, h: integer);
    procedure FreeVideoFrame(var p: PBtArr);
    procedure FreeCaptureFrame(var p: PBtArr);
    procedure StartCapture(nFrames: integer);
    procedure SetBrightness(val: integer);
    procedure SetContrast(val: integer);
    procedure GetHist(p: PByteArray);
    function _ImageOK: boolean;
    procedure ReceiveData(Sender:TObject; Buffer: Pointer; BufferLength: Word);
    procedure ComThreadTerminate(Sender: TObject);
    procedure AutoRegThreadTerminate(Sender: TObject);

    constructor Create(_BasePath: string; Handle: HWND);
    destructor Destroy; override;
  end;

var
  ImageOK: boolean;
  VidCapParam: TVidCapParam;
  VidCap: TVidCap;

implementation

uses UAutoReg;

procedure TTS_VidCap.AutoRegOFF;
begin
  AutoReg.Suspend;
end;

procedure TTS_VidCap.AutoRegON;
begin
//  if capture then
    AutoReg.Resume;
end;

procedure TTS_VidCap.AutoRegThreadTerminate(Sender: TObject);
begin
  AutoRegTerminated:=true;
end;

procedure TTS_VidCap.Capture_Start;
begin
  VidCap.Run;
  {case VidCapParam.Mode of
    0: LPTWatcher.Resume;
    1: begin
         ComWatcher.Resume;
       end;
  end;
  AutoReg.Resume;}
//  Timer.Enabled:=true;
//  Timer2.Enabled:=true;
  capture:=true;
end;

procedure TTS_VidCap.Capture_Start_Phase_Shift;
begin
  VidCap.Run;
  //Timer.Enabled:=true;
  capture:=true;
//  AutoReg.Resume;
end;

procedure TTS_VidCap.Capture_Stop;
begin
{  case VidCapParam.Mode of
    0: LPTWatcher.Suspend;
    1: ComWatcher.Suspend;
  end;
  AutoReg.Suspend;
 }
  VidCap.Pause;


  //Timer.Enabled:=false;
//  Timer2.Enabled:=false;
  capture:=false;
end;

procedure TTS_VidCap.Capture_Stop_Phase_Shift;
begin
  VidCap.Pause;
//  Timer.Enabled:=false;
  capture:=false;
//  AutoReg.Suspend;
end;

procedure TTS_VidCap.CommEvent(Sender: TObject);
begin
  MessageBox(_handle, 'Com Port is not connected', 'Warning', MB_OK	or MB_ICONWARNING or MB_SYSTEMMODAL);
//  ShowMessage('Com Port is not connected');
end;

procedure TTS_VidCap.ComThreadTerminate(Sender: TObject);
begin
  ComWatcherTerminated:=true;
end;

constructor TTS_VidCap.Create(_BasePath: string; Handle: HWND);
var port: byte;
begin
  _err:=erNone;
  cap_dev:=false;
  if not FileExists(_BasePath+'Scanner.ini') then
  begin
    ShowMessage('Scanner.ini not found!');
    _err:= erINIFile;
    exit;
  end;
  VidCapParamFile(VidCapParam, _BasePath+'Scanner.ini');
  if CheckVidCapDev = 0 then
  begin
    ShowMessage('Capture Device not found!');
    _err:= erFlyVideo;
    exit;
  end;
  cap_dev:=true;
  if VidCapParam.Mode = 1 then
  begin
    {Comm321:=TComm32.Create(nil);
    Comm321.BaudRate:=19200;
    Comm321.Bits:=8;
    Comm321.CommPort:='COM1';
    Comm321.Name:='Comm321';
    Comm321.ReadInterval:=5;
    Comm321.StopBits:=1;
    Comm321.OnReceiveData:=ReceiveData;
    Comm321.StartComm;
    _WaitEvent:=CreateEvent(nil, true, false, nil);
    port:=$12;
    Comm321.WriteCommData(PChar(@port), 1);
    if WAIT_TIMEOUT = WaitForSingleObject(_WaitEvent, 1000) then
    begin
      ShowMessage('COM Device not found!');
      _err:=erCOM;
      CloseHandle(_WaitEvent);
      Comm321.StopComm;
      Comm321.Destroy;
      exit;
    end
    else
      ResetEvent(_WaitEvent);}
    _err:=erNone;
  end;

  _handle:=Handle;
  VidCap:=TVidCap.Create(nil, VidCapParam, Handle);

  
  if VidCapParam.Mode = 1 then
  begin
    {ComWatcher:=TComWatcher.Create(true);
    ComWatcher.Priority:=tpHighest;
    ComWatcher.FreeOnTerminate:=true;
    ComWatcher.VidCap:=VidCap;
    ComWatcher.WaitEvent:=_WaitEvent;
    ComWatcher.Comm321:=Comm321;
    ComWatcher.Frames:=VidCapParam.Frames;
    ComWatcher.OnTerminate:=ComThreadTerminate;
    ComWatcherTerminated:=false;
     }
  end;

  cap_run:=false;
  VidCap.SetBrightness(VidCapParam.Brightness);
  VidCap.SetContrast(VidCapParam.Contrast);
end;

destructor TTS_VidCap.Destroy;
var i: integer;
begin

  if capture then
    case VidCapParam.Mode of
      0: Capture_Stop;
      1: Capture_Stop_Phase_Shift;
    end;

  case _err of
    erINIFile: exit;
    erLPT: begin
             
             exit;
           end;
    erFlyVideo: exit;
    erCOM: begin
             DoneDriver;
             exit;
           end;
    erNone: begin
              VidCap.Destroy;
            //  ShowMessage('1');

              if VidCapParam.Mode = 1 then
              begin
                {if not ComWatcherTerminated then
                begin
                  ComWatcher.Terminate;
                  ComWatcher.WaitFor;
                end;
                Comm321.StopComm;
                Comm321.Destroy;}
              end;
             // ShowMessage('3');

             // ShowMessage('4');
              DoneDriver;
            end;

  end;

  (*
  if cap_dev then
  begin
    with VidCap do
    begin
     { aGrabber.SetCallback(nil, 1);
      FCaptureGraphBuilder:=nil;
      aConf:= nil;
      aVidProcAmp:= nil;
      aAnalogVideo:= nil;
      aCapPin:= nil;
      aCrossBar:=nil;
      aGrabber:=nil;
      FFilterGraph:=nil;
      FMediaControl:=nil;
      FMediaEvent:=nil;
      FMediaSeek:=nil;
      for i:=0 to FCapDevs.Count-1 do
        TSave(FCapDevs.Objects[i]).filter:=nil;
      with cb do
      begin
        Finalize(Frames);
        if Assigned(Buf) then
          FreeMem(Buf, Len);
      end;}

    end;
   // Timer.Destroy;
    if VidCapParam.Mode = 0 then
    begin
      //LPTWatcher.Stop;
      //LPTWatcher.Resume;
      LPTWatcher.Terminate;
    end;
    if VidCapParam.Mode = 1 then
    begin
      if Assigned(ComWatcher) then
        ComWatcher.Terminate;
      sleep(100);
      Comm321.StopComm;
    end;

    AutoReg.Terminate;

  end;   *)

  inherited Destroy;
end;

procedure TTS_VidCap.FreeCaptureFrame(var p: PBtArr);
var w,h: integer;
begin
  w:=VidCapParam.Width;
  h:=VidCapParam.Height;
  FreeMem(p, w*h);
end;

procedure TTS_VidCap.FreeVideoFrame(var p: PBtArr);
var w,h: integer;
begin
  w:=VidCapParam.Height;
  h:=VidCapParam.Width-2*VidCapParam.cut;
  FreeMem(p, w*h);
end;

procedure TTS_VidCap.GetAverageFrame(frame: PBtArr);
begin
  VidCap.GetAverageFrame(frame);
end;

procedure TTS_VidCap.GetCapturedBitmap(frame: PBtArr);
begin
  VidCap.GetCapturedBitmap(frame);
end;

procedure TTS_VidCap.GetCapturedBitmaps(frame1, frame2, frame3: PBtArr);
begin
  VidCap.GetCapturedBitmaps(frame1, frame2, frame3);
end;

procedure TTS_VidCap.GetCapturedBitmaps(frame1, frame2, frame3, frame4,
  frame5: PBtArr);
begin
  VidCap.GetCapturedBitmaps(frame1, frame2, frame3, frame4, frame5);
end;

procedure TTS_VidCap.GetHist(p: PByteArray);
begin
  CopyMemory(p, @(VidCap.cb.Hist), 256*sizeof(integer));
end;

procedure TTS_VidCap.GetPlanBFrames(frames: PBtPointerArr);
begin
  VidCap.GetPlanBFrame(frames);
end;

procedure TTS_VidCap.GetVidCapParam(var pVidCapParam: TVidCapParam);
begin
  pVidCapParam:=VidCapParam;
end;


procedure TTS_VidCap.MallocCaptureFrame(var p: PBtArr; var w, h: integer);
begin
  w:=VidCapParam.Width;
  h:=VidCapParam.Height;
  GetMem(p, w*h);
end;

procedure TTS_VidCap.MallocVideoFrame(var p: PBtArr; var w, h: integer);
begin
  w:=VidCapParam.Height;
  h:=VidCapParam.Width-2*VidCapParam.cut;
  GetMem(p, w*h);
end;

procedure TTS_VidCap.OnTimer(Sender: TObject);
begin
  if VidCapParam.AutoReg then
    ImageOK:=VidCap.AutoReg;
end;

procedure TTS_VidCap.OnTimer2(Sender: TObject);
var port: byte;
begin
  port:=InPort(VidCapParam.Port+1);
  if (port and 16) <> 0 then
    VidCap.Capture;
end;

procedure TTS_VidCap.ReceiveData(Sender:TObject; Buffer: Pointer; BufferLength: Word);
var p: PByteArray;
begin
  if not ComWatcherTerminated then
    ComWatcher.status:=p^[1];
  status:=p^[1];
  SetEvent(_WaitEvent);
end;

procedure TTS_VidCap.SetBrightness(val: integer);
begin
  VidCap.SetBrightness(val);
end;

procedure TTS_VidCap.SetContrast(val: integer);
begin
  VidCap.SetContrast(val);
end;

procedure TTS_VidCap.StartCapture(nFrames: integer);
begin
  VidCap.Capture(nFrames);
end;

function TTS_VidCap._ImageOK: boolean;
begin
  Result:=ImageOK;
end;

end.
