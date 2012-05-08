unit UTS_VidCap;

interface

uses Windows, UVidCap_ini, Utype;

const
  vc = 'TS_VidCap.dll';

  function TS_VidCap_Create(var ID: integer; Handle: HWND; BasePath: PChar): integer; StdCall; external vc;
  procedure TS_VidCap_Destroy(var ID: integer); StdCall; external vc;
  procedure TS_Capture(ID, nFrames: integer); StdCall; external vc;
  procedure TS_VidCap_Capture_Start(ID: integer); StdCall; external vc;
  procedure TS_VidCap_Capture_Start_Phase_Shift(ID: integer); StdCall; external vc;
  procedure TS_VidCap_Capture_Stop(ID: integer); StdCall; external vc;
  procedure TS_VidCap_Capture_Stop_Phase_Shift(ID: integer); StdCall; external vc;
  procedure TS_VidCap_GetVidCapParam(ID: integer; var VidCapParam: TVidCapParam); StdCall; external vc;
  procedure TS_VidCap_GetCapturedFrames(ID: integer; frame1, frame2, frame3: PBtArr); StdCall; external vc;
  procedure TS_VidCap_GetCapturedFrames5(ID: integer; frame1, frame2, frame3, frame4, frame5: PBtArr); StdCall; external vc;
  procedure TS_VidCap_GetVideoFrame(ID: integer; VideoFrame: PBtArr); StdCall; external vc;
  procedure TS_GetAverageFrame(ID: integer; VideoFrame: PBtArr); StdCall; external vc;
  procedure TS_VidCap_MallocCaptureFrame(ID: integer; var CaptureFrame: Pointer; var Width, Height: integer); StdCall; external vc;
  procedure TS_VidCap_MallocVideoFrame(ID: integer; var VideoFrame: PBtArr; var Width, Height: integer); StdCall; external vc;
  procedure TS_VidCap_FreeVideoFrame(ID: integer; var VideoFrame: PBtArr); StdCall; external vc;
  procedure TS_VidCap_FreeCaptureFrame(ID: integer; var CaptureFrame: Pointer); StdCall; external vc;
  procedure TS_GetPlanBFrames(ID: integer; frames: PBtPointerArr); StdCall; external vc;
  function TS_VidCap_ImageOK(ID: integer): boolean; StdCall; external vc;
  procedure TS_SetBrightness(ID: integer; val: integer); StdCall; external vc;
  procedure TS_SetContrast(ID: integer; val: integer); StdCall; external vc;
  procedure TS_VidCap_GetHist(ID: integer; p: PBtArr); StdCall; external vc;
  procedure TS_AutoRegON(ID: integer); StdCall; external vc;
  procedure TS_AutoRegOFF(ID: integer); StdCall; external vc;

implementation

end.
