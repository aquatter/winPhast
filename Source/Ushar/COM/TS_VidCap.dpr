library TS_VidCap;

{ Important note about DLL memory management: ShareMem must be the
  first unit in your library's USES clause AND your project's (select
  Project-View Source) USES clause if your DLL exports any procedures or
  functions that pass strings as parameters or function results. This
  applies to all strings passed to and from your DLL--even those that
  are nested in records and classes. ShareMem is the interface unit to
  the BORLNDMM.DLL shared memory manager, which must be deployed along
  with your DLL. To avoid using BORLNDMM.DLL, pass string information
  using PChar or ShortString parameters. }

uses
  SysUtils,
  Classes,
  Windows,
  UVidCap in 'UVidCap.pas',
  UVidCap_ini,
  Utype,
  UAutoReg in 'UAutoReg.pas',
  UComWatcher in 'UComWatcher.pas';

function Create(var p: TTS_VidCap; Handle: HWND; BasePath: PChar): integer;  StdCall;
begin
  p:=TTS_VidCap.Create(BasePath, Handle);
  if p._err <> erNone{not p.cap_dev} then
  begin
    p.Destroy;
    Result:=-1;
    exit;
  end;
  Result:=0;
end;


procedure Capture_Stop(p: TTS_VidCap); StdCall;
begin
  p.Capture_Stop;
end;

procedure Capture_Stop_Phase_Shift(p: TTS_VidCap); StdCall;
begin
  p.Capture_Stop_Phase_Shift;
end;

procedure Capture_Start(p: TTS_VidCap); StdCall;
begin
  p.Capture_Start;
end;

procedure Capture_Start_Phase_Shift(p: TTS_VidCap); StdCall;
begin
  p.Capture_Start_Phase_Shift;
end;

procedure Destroy(var p: TTS_VidCap); StdCall;
begin
  p.Destroy;
end;

procedure GetVidCapParam(p: TTS_VidCap; var VidCapParam: TVidCapParam); StdCall;
begin
  p.GetVidCapParam(VidCapParam);
end;

procedure GetCapturedBitmaps(p: TTS_VidCap; frame1, frame2, frame3: PBtArr); StdCall;
begin
  p.GetCapturedBitmaps(frame1, frame2, frame3);
end;

procedure GetCapturedBitmaps5(p: TTS_VidCap; frame1, frame2, frame3, frame4, frame5: PBtArr); StdCall;
begin
  p.GetCapturedBitmaps(frame1, frame2, frame3, frame4, frame5);
end;

procedure GetCapturedBitmap(p: TTS_VidCap; frame: PBtArr); StdCall;
begin
  p.GetCapturedBitmap(frame);
end;

procedure MallocCaptureFrame(p: TTS_VidCap; var frame: PBtArr; var w, h: integer); StdCall;
begin
  p.MallocCaptureFrame(frame, w, h);
end;

procedure MallocVideoFrame(p: TTS_VidCap; var frame: PBtArr; var w, h: integer); StdCall;
begin
  p.MallocVideoFrame(frame, w, h);
end;

procedure FreeVideoFrame(p: TTS_VidCap; var frame: PBtArr); StdCall;
begin
  p.FreeVideoFrame(frame);
end;

procedure FreeCaptureFrame(p: TTS_VidCap; var frame: PBtArr); StdCall;
begin
  p.FreeCaptureFrame(frame);
end;

function ImageOK(p: TTS_VidCap): boolean; StdCall;
begin
  Result:=p._ImageOK;
end;

procedure Capture(p: TTS_VidCap; nFrames: integer); StdCall;
begin
  p.StartCapture(nFrames);
end;

procedure GetAverageFrame(p: TTS_VidCap; frame: PBtArr); StdCall
begin
  p.GetAverageFrame(frame);
end;

procedure GetPlanBFrames(p: TTS_VidCap; frames: PBtPointerArr); StdCall;
begin
  p.GetPlanBFrames(frames);
end;

procedure SetBrightness(p: TTS_VidCap; val: integer); StdCall;
begin
  p.SetBrightness(val);
end;

procedure SetContrast(p: TTS_VidCap; val: integer);  StdCall;
begin
  p.SetContrast(val);
end;

procedure GetHist(p: TTS_VidCap; hist: PByteArray); StdCall;
begin
  p.GetHist(hist);
end;

procedure AutoRegON(p: TTS_VidCap); StdCall;
begin
  p.AutoRegON;
end;

procedure AutoRegOFF(p: TTS_VidCap); StdCall;
begin
  p.AutoRegOFF;
end;

exports
  Create name 'TS_VidCap_Create',
  Destroy name 'TS_VidCap_Destroy',
  Capture_Stop name 'TS_VidCap_Capture_Stop',
  Capture_Start name 'TS_VidCap_Capture_Start',
  Capture_Stop_Phase_Shift name 'TS_VidCap_Capture_Stop_Phase_Shift',
  Capture_Start_Phase_Shift name 'TS_VidCap_Capture_Start_Phase_Shift',
  GetVidCapParam name 'TS_VidCap_GetVidCapParam',
  GetCapturedBitmaps name 'TS_VidCap_GetCapturedFrames',
  GetCapturedBitmaps5 name 'TS_VidCap_GetCapturedFrames5',
  GetCapturedBitmap name 'TS_VidCap_GetVideoFrame',
  MallocCaptureFrame name 'TS_VidCap_MallocCaptureFrame',
  MallocVideoFrame name 'TS_VidCap_MallocVideoFrame',
  FreeVideoFrame name 'TS_VidCap_FreeVideoFrame',
  FreeCaptureFrame name 'TS_VidCap_FreeCaptureFrame',
  ImageOK name 'TS_VidCap_ImageOK',
  Capture name 'TS_Capture',
  GetAverageFrame name 'TS_GetAverageFrame',
  GetPlanBFrames name 'TS_GetPlanBFrames',
  SetBrightness name 'TS_SetBrightness',
  SetContrast name 'TS_SetContrast',
  GetHist name 'TS_VidCap_GetHist',
  AutoRegON name 'TS_AutoRegON',
  AutoRegOFF name 'TS_AutoRegOFF';

{$R *.res}

begin
end.
