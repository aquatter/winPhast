unit VidCap;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, directShow9, ActiveX, Graphics,
  Dialogs, t666, utype, UVidCap_ini;

const
  WM_MMNOTIFY=WM_APP+$1234;
  WM_CAPDONE=WM_APP+$1235;
  WM_NEWFRAME=WM_APP+$1236;
  
  IID_IPropertyBag: TGUID = '{55272A00-42CB-11CE-8135-00AA004BB851}';

type
  TColorArray = array [0..16383] of TColor;
  PColorArray = ^TColorArray;

type
  PBMI = ^BITMAPINFO;

type
  PFrame = ^TFrame;
  TFrame = record
    Buf:Pointer;
    Len:LongInt;
    Time:Double;
  end;

type
  TSave = class(TObject)
    filter: IBaseFilter;
  end;

type //Класс для реализации callback процедуры при использовании Sample Grabber-а
  TSampleGrabberCB = class(TComponent, ISampleGrabberCB)
  private
    function  SampleCB(SampleTime: Double; pSample: IMediaSample): HResult; stdcall;
    function  BufferCB(SampleTime: Double; pBuffer: PByte; BufferLen: longint): HResult; stdcall;
  public
    Buf: Pointer;
    Pos: Double;
    Len: LongInt;
    sw: boolean;
    w, h: integer;
    p1, p2: TPoint;
    Frames: array of TFrame;
    FHandle: HWND;
    Hist: array [0..255] of Integer;
    NeedHist: Boolean;
    AutoRender: Boolean;
    AutoReg: Boolean;
    FFrameCount, Cnt: Integer;
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure StartCapture(FrameCount:Integer);
  end;

  TDShowComp = class(TComponent)
  private
    FHandle: HWND;
    FControl: TWinControl;
    FVideoRect: TRect;
    procedure SetHandle(const Value: HWND);
    procedure SetVideoRect(const Value: TRect);
    procedure UpdateVideoWindowPos;
    procedure SetControl(const Value: TWinControl);
  protected
    procedure SetNotifyWindow(const ahandle:HWND);
    procedure SetWindow(const aHandle:HWND);virtual;
    function GetPin(aFilter:IBaseFilter; const PinDir:TPinDirection; const indx:integer):IPin;
    function ConnectFilter(OutFilter,InFilter:IBaseFilter):HResult;
    function AddFilterByCLSID(clsid:TGUID;const name:string):IBaseFilter;
    function FindFilterByFriendlyName(const classid:TGUID; const friendlyname:string):IBaseFilter;
  public

    cb: TSampleGrabberCB;
    FFilterGraph: IGraphBuilder;
    FMediaControl: IMediaControl;
    FMediaEvent: IMediaEventEx;
    FMediaSeek: IMediaSeeking;
    FVideoWindow: IVideoWindow;
    aCapFilter, aSampleGrabber, aRender: IBaseFilter;
    aGrabber: ISampleGrabber;
    FCaptureGraphBuilder: ICaptureGraphBuilder2;
    aCrossBar: IAMCrossbar;
    aConf: IAMStreamConfig;
    aVidProcAmp: IAMVideoProcAmp;
    aAnalogVideo: IAMAnalogVideoDecoder;
    aCapPin: IPin;
    constructor Create(AOwner:TComponent); override;
    destructor Destroy; override;
    procedure BuildFilterGraph; virtual;
    procedure RemoveAllFilters;
    procedure Run;
    procedure Stop;
    procedure Pause;
  published
    property Control:TWinControl read FControl write SetControl;
    property Handle: HWND read FHandle write SetHandle;
    property VideoRect:TRect read FVideoRect write SetVideoRect;
    property GraphObj: IGraphBuilder read FFilterGraph;
    property ControlObj:IMediaControl read FMediaControl;
    property EventObj:IMediaEventEx read FMediaEvent;
    property SeekObj:IMediaSeeking read FMediaSeek;
  end;

type
  THistArr =array [0..255] of Integer;
  PHistArr = ^THistArr;

  TVidCap = class(TDShowComp)
  private
    FAutoContrast:Boolean;
    FAutoRender:Boolean;
    FSampleWidth, FSampleHeight: Integer;
    FFramesCount: integer;
    function  GetNeedHist:Boolean;
    procedure SetNeedHist(nh:Boolean);
    function  GetBrightness: Integer;

    function  GetContrast: Integer;

    function  GetVideoMode:Integer;
    procedure SetVideoMode(val:Integer);
    function  GetVideoSource:Integer;
    procedure SetVideoSource(val:Integer);
    procedure SetFramesCount(Frames: integer);
  protected
    mt: AM_MEDIA_TYPE;

    C_max, C_min: Integer;
    procedure GetVidCapDevs(Lst:TStringList);
  public
    FCapDevs: TStringList;
    Buf: Pointer; //Указатель на буффер, куда помещается изображение при ручной прорисовке
    C_step, r254, Ith1, g255th, Cut, Rotate: Integer; //Параметры автоподстройки контраста
    function AutoReg{(var hist:array of Integer)}: Boolean;
    constructor Create(AOwner: TComponent);  overload;
    constructor Create(AOwner: TComponent; VidCapParam: TVidCapParam; _hdnl: HWND);  overload;
    procedure Test;
    destructor Destroy; override;
    procedure SetBrightness(val: Integer);
    procedure SetContrast(val: Integer);
    procedure BuildFilterGraph; override;
    procedure ShowPropertyPages;   //Установка рижма (PAL, NTSC), а также яркости и контраста
    procedure ShowPropertyPages1;  //Настройка разрешения. При выводе этого окна видеопоток останавливается
    procedure SetResolution(w, h: Integer);
    procedure GetResolution(var w, h: Integer);
    procedure GetCurBMI(var bmi:BITMAPINFOHEADER);
    procedure UpdateCapDevList;
    procedure SelectCapDevice(index:Integer);
    procedure StartStream;
    procedure Capture;  overload; //Комманда видеозахвата. Вызывать только при запущенном видеопотоке.
    procedure Capture(Nframes: integer);  overload;
    procedure GetCapturedBitmaps(p: array of PMyInfernalType); overload;
    procedure GetCapturedBitmaps(frame1, frame2, frame3, frame4, frame5: PBtArr); overload;
    procedure GetCapturedBitmaps(frame1, frame2, frame3: PBtArr); overload;
    procedure GetAverageFrame(frame: PBtArr);
    procedure GetPlanBFrame(frames: PBtPointerArr);
    procedure GetCapturedBitmap(frame: PBtArr); overload;
    function GetHist: PHistArr;
    procedure GetBrightMinMax(var min, max:Integer);
    procedure GetCntrstMinMax(var min, max:Integer);
    procedure GetAllVideoModes(lst: TStringList);    //Режимы (PAL, NTSC и т.д)
    procedure GetAllVideoSources(lst: TStringList);  //Видеовходы (композитный, SVideo и др.)
    property CapDevs:TStringList read FCapDevs;
    property NeedHist:Boolean read GetNeedHist write SetNeedHist;
    property Brightness:Integer read GetBrightness write SetBrightness;
    property Contrast: Integer read GetContrast write SetContrast;
    property VideoMode: Integer read GetVideoMode write SetVideoMode;
    property VideoSource: Integer read GetVideoSource write SetVideoSource;
    property AutoContrast: Boolean read FAutoContrast write FAutoContrast;
    property AutoRender: Boolean read FAutoRender write FAutoRender;
    property SampleWidth: Integer read FSampleWidth write FSampleWidth;
    property SampleHeight: Integer read FSampleHeight write FSampleHeight;
    property FramesCount: integer read FFramesCount write SetFramesCount;
  end;

implementation

uses Math;

//------------------------------------------------------------------------------
procedure RaiseDirectShowException(const hr:HResult; const additionalMsg:string);
var
  err_text:array[0..1023] of char;
begin
  AMGetErrorText(hr,@err_text,sizeof(err_text));
  raise Exception.Create(additionalMsg+' ['+IntToHex(Int64(hr),8)+']'+err_text);
end;
//------------------------------------------------------------------------------
procedure SetFilterMediaType(aFilter:IBaseFilter; aMediaType:PAMMediaType);
var
  enum:IEnumPins;
  pin:IPin;
  pinDirection:TPinDirection;
  tot_fetched_pin:cardinal;
  streamConfig:IAMStreamConfig;
  hr:HResult;
begin
  if aFilter<>nil then
  begin
    aFilter.EnumPins(enum);
    if enum<>nil then
    begin
      while enum.Next(1,pin,@tot_fetched_pin)=S_OK do
      begin
        pin.QueryDirection(pinDirection);
        if pinDirection=PINDIR_OUTPUT then
        begin
          hr:=pin.QueryInterface(IID_IAMStreamConfig,
                                 StreamConfig);
          if succeeded(hr) then
          begin
            hr:=StreamConfig.SetFormat(aMediaType^);
            if hr<>S_OK then
               RaiseDirectShowException(hr,'Set format gagal. ');
          end;
        end;
        pin:=nil;
      end;
    end;
  end;
end;
//------------------------------------------------------------------------------
//---------------------------- TSampleGrabberCB --------------------------------
//------------------------------------------------------------------------------
constructor TSampleGrabberCB.Create(AOwner:TComponent);
var i: integer;
begin
  Pos:=0;
  Cnt:=0;
  NeedHist:=true;
  sw:=true;
  inherited Create(Owner);
end;
//------------------------------------------------------------------------------
destructor TSampleGrabberCB.Destroy;
var i: integer;
begin
 { for i:=0 to FFrameCount-1 do
    FreeMem(Frames[i].Buf, Frames[i].Len); }

  Finalize(Frames);
  if Assigned(Buf) then
    FreeMem(Buf, Len);
end;
//------------------------------------------------------------------------------
function TSampleGrabberCB.SampleCB(SampleTime: Double; pSample: IMediaSample): HResult; stdcall;
begin
  Result:=0
end;
//------------------------------------------------------------------------------
function TSampleGrabberCB.BufferCB(SampleTime: Double; pBuffer: PByte; BufferLen: longint): HResult; stdcall;
var
  i, j, tmp: Integer;
  //pw: PWordArray;
  pb: PByteArray;

begin
  {if not sw then
    exit;}

  if pBuffer = nil then
   begin
    Result:=E_POINTER;
    exit
   end;

  if Cnt > 0 then
  begin
      //Frames[FFrameCount-Cnt].Time:=SampleTime;

    Frames[FFrameCount-Cnt].Len:=BufferLen;
    Move(pBuffer^, Frames[FFrameCount-Cnt].Buf^, BufferLen);
    Dec(Cnt);
    if Cnt = 0 then
      //PostThreadMessage(FHandle, WM_CAPDONE, 0, 0);
      SendMessage(FHandle, WM_CAPDONE, 0, 0);

    (*
    try
       // GetMem(Frames[FFrameCount-Cnt].Buf, BufferLen);
      CopyMemory(Frames[FFrameCount-Cnt].Buf, pBuffer, BufferLen);
    except
      Dec(cnt);
      Result:=0;
      exit;
    end;
    Dec(Cnt);
    if Cnt = 0 then
    begin
      sw:=false;
      SendMessage(FHandle, WM_CAPDONE, 0{LPARAM(@Frames[0])}, {WPARAM(FFrameCount)}0);
    end;   *)
    Result:=0;
    exit;
  end;

  (*
  if (NeedHist or not AutoRender) and (Cnt = 0) then
    begin
      pb:=PByteArray(pBuffer);
      //if AutoReg then
      ZeroMemory(@Hist, 256*SizeOf(Integer));
      tmp:=(BufferLen div 2{3})-1;
      for i:=0 to tmp do
          inc(hist[pb^[i*2{3}]]);
     (*
      if not AutoRender then
      try
       // GetMem(Buf, BufferLen);
        CopyMemory(Buf, pBuffer, len{BufferLen})
      except
        Result:=0;
        exit;
      end;

      SendMessage(FHandle, WM_NEWFRAME, WPARAM(Buf), 0);
      Result:=0;
      exit;*)
    {end;}


  CopyMemory(Buf, pBuffer, len);
  //PostThreadMessage(FHandle, WM_NEWFRAME, 0, 0);
  SendMessage(FHandle, WM_NEWFRAME, WPARAM(Buf), 0);
  Result:=0;
end;
//------------------------------------------------------------------------------
procedure TSampleGrabberCB.StartCapture(FrameCount: Integer);
var i: integer;
begin
  SetLength(Frames, FrameCount);
  for i:=0 to FrameCount-1 do
    GetMem(Frames[i].Buf, Len);

  FFrameCount:= FrameCount;
  Cnt:=FrameCount;
end;
//------------------------------------------------------------------------------
//--------------------------------- TDShowComp ---------------------------------
//------------------------------------------------------------------------------
constructor TDShowComp.Create(AOwner:TComponent);
var
  aEvent:IMediaEvent;
begin
  inherited Create(AOwner);

  CoCreateInstance(CLSID_FilterGraph,nil, CLSCTX_INPROC_SERVER, IID_IGraphBuilder, FFilterGraph);

  if FFilterGraph=nil then
    raise Exception.Create('Ошибка инициализации графа фильтров');

  FFilterGraph.QueryInterface(IID_IMediaControl, FMediaControl);
  FFilterGraph.QueryInterface(IID_IMediaEvent, aEvent);
  aEvent.QueryInterface(IID_IMediaEventEx, FMediaEvent);
  //FFilterGraph.QueryInterface(IID_IMediaSeeking, FMediaSeek);
  FFilterGraph.QueryInterface(IID_IVideoWindow,FVideoWindow);
end;
//------------------------------------------------------------------------------
destructor TDShowComp.Destroy;
begin
 { RemoveAllFilters;
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
  cb.Destroy;}
  inherited Destroy;
  //ShowMessage('!');
end;
//------------------------------------------------------------------------------
procedure TDShowComp.Run;
var
  hr: HResult;
  fs: FILTER_STATE;
begin
  FMediaControl.Run;
  hr:=FMediaControl.GetState(INFINITE, fs);

  if fs <> State_Running then
    RaiseDirectshowException(hr,'Run failed. ');
end;
//------------------------------------------------------------------------------
procedure TDShowComp.Stop;
begin
  FMediaControl.Stop;
end;
//------------------------------------------------------------------------------
procedure TDShowComp.Pause;
begin
  FMediaControl.Pause;
end;
//------------------------------------------------------------------------------
procedure TDShowComp.SetHandle(const Value: HWND);
begin
  if FHandle<>Value then
  begin
    FHandle := Value;
    if CB <> nil then CB.FHandle := Value;
    SetWindow(FHandle);
  end;
end;
//------------------------------------------------------------------------------
procedure TDShowComp.SetWindow(const aHAndle: HWND);
begin
  SetNotifyWindow(AHandle);
end;
//------------------------------------------------------------------------------
procedure TDShowComp.SetNotifyWindow(const ahandle: HWND);
begin
  FMediaEvent.SetNotifyWindow(aHandle,WM_MMNOTIFY,integer(self));
end;
//------------------------------------------------------------------------------
procedure TDShowComp.SetControl(const Value: TWinControl);
begin
  FControl:= Value;
  if FControl<>nil then
  begin
    FVideoWindow.put_Owner(OAHWND(FControl.handle));
    FVideoWindow.put_WindowStyle(WS_CHILD or WS_CLIPSIBLINGS);

    FVideoRect:=Rect(0, 0, FControl.ClientWidth, FControl.ClientHeight);
    UpdateVideoWindowPos;

    FVideoWindow.put_Visible(true);
    FVideoWindow.SetWindowForeground(1);
  end;
end;
//------------------------------------------------------------------------------
procedure TDShowComp.SetVideoRect(const Value: TRect);
begin
  FVideoRect := Value;
  UpdateVideoWindowPos;
end;
//------------------------------------------------------------------------------
procedure TDShowComp.UpdateVideoWindowPos;
begin
  FVideoWindow.SetWindowPosition(FVideoRect.Left,
                           FVideoRect.Top,
                           FVideoRect.Right,
                           FVideoRect.Bottom);
end;
//------------------------------------------------------------------------------
procedure TDShowComp.RemoveAllFilters;
var
  enum: IEnumFilters;
  aFilter: IBaseFilter;
begin
  if (FFilterGraph = nil) then
    exit;

  {FFilterGraph.RemoveFilter(aCapFilter);
  FFilterGraph.RemoveFilter(aSampleGrabber);
  FFilterGraph.RemoveFilter(aRender);
  aCapFilter:=nil;
  aSampleGrabber:=nil;
  aRender:=nil;}
  {FMediaControl.Pause;

  FFilterGraph.RemoveFilter(aCapFilter);
  FFilterGraph.RemoveFilter(aSampleGrabber);
  FFilterGraph.RemoveFilter(aRender);

  aCapFilter:=nil;
  aSampleGrabber:=nil;
  aRender:=nil;}


  FMediaControl.Stop;
//   Stop;
//  ShowMessage('2');
  //Pause;
  FFilterGraph.EnumFilters(enum);
  while (enum.Next(1,afilter,nil)=S_OK) do
  begin
    FFilterGraph.RemoveFilter(aFilter);
    aFilter:=nil;
    enum.Reset;
  end;
  enum:=nil;
end;
//------------------------------------------------------------------------------
function TDShowComp.GetPin(aFilter: IBaseFilter; const PinDir: TPinDirection;
                          const indx: integer): IPin;
var
  pPins:IEnumPins;
  ctr:integer;
  aPin:IPin;
  CurPinDir:TPinDirection;

begin
  result:=nil;
  //start pin enumeration
  aFilter.EnumPins(pPins);
  if pPins<>nil then
  begin
    //pin enumeration ok
    ctr:=0;
    while pPins.Next(1,aPin,nil)=S_OK do
    begin
      aPin.QueryDirection(curPinDir);
      if (ctr=indx) and (curPinDir=PinDir) then
      begin
        result:=aPin;
        exit;
      end;
    end;
  end;
end;
//------------------------------------------------------------------------------
function TDShowComp.ConnectFilter(OutFilter, InFilter: IBaseFilter): HResult;
var outpin,inPin:IPin;
begin
  outPin:=GetPin(OutFilter,PINDIR_OUTPUT,0);
  inPin:=GetPin(InFilter,PINDIR_INPUT,0);
  result:=FFilterGraph.Connect(outPin,inPin);
end;
//------------------------------------------------------------------------------
function TDShowComp.AddFilterByCLSID(clsid: TGUID; const name: string): IBaseFilter;
var
  afilter: IBaseFilter;
  awideName: wideString;
  hr: HResult;
begin
  awidename:=name;
  hr:=CoCreateInstance(clsid, nil, CLSCTX_INPROC_SERVER, IID_IBaseFilter, afilter);
  if hr <> S_OK then
    RaiseDirectshowException(hr,'Create filter '+awideName+' failed.');

  hr:=FFilterGraph.AddFilter(afilter, PWideChar(awideName));
  if hr <> S_OK then
    RaiseDirectshowException(hr,'Add filter '+awideName+' failed.');

  result:=aFilter;
end;
//------------------------------------------------------------------------------
function TDShowComp.FindFilterByFriendlyName(const classid:TGUID; const friendlyname: string): IBaseFilter;
var
  sysEnum:ICreateDevEnum;
  enumMoniker:IEnumMoniker;
  moniker:IMoniker;
  propBag:IPropertyBag;
  hr:HRESULT;

  afriendlyName:OleVariant;
  propName,aname:widestring;

begin
  result:=nil;

  CoCreateInstance(CLSID_SystemDeviceEnum,
                   nil,
                   CLSCTX_INPROC_SERVER,
                   IID_ICreateDevEnum,
                   sysenum);
  if sysEnum<>nil then
  begin
    aname:=FriendlyName;
    propName:='FriendlyName';

    hr:=sysEnum.CreateClassEnumerator(classid,
                       enumMoniker,0);
    if hr=S_OK then
    begin
      while enumMoniker.Next(1,moniker,nil)=S_OK do
      begin
        hr:=moniker.BindToStorage(nil,nil,IPropertyBag,propBag);
        if succeeded(hr) then
        begin
          propBag.Read(PWideChar(propName),
                       afriendlyName,nil);
          if afriendlyName=aname then
          begin
            moniker.BindToObject(nil,nil,
                                 IID_IBaseFilter,
                                 result);
            exit;
          end;
        end;
      end;
    end else
      RaiseDirectshowException(hr,'Create Class Enumerator failed');
  end;
end;
//------------------------------------------------------------------------------
procedure TDShowComp.BuildFilterGraph;
begin
end;
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
//--------------------------------- TVidCap ------------------------------------
//------------------------------------------------------------------------------
constructor TVidCap.Create(AOwner:TComponent);
begin
  FCapDevs:=TStringList.Create;
  GetVidCapDevs(FCapDevs);

  aCapFilter:=nil;
  aVidProcAmp:=nil;
  aConf:=nil;
  {if FCapDevs.Count = 0 then
  begin
    ShowMessage('Capture Device not Found!');
    exit;
  end;}
  SelectCapDevice(0);
  FAutoRender:=false;
  C_max:=0;
  C_min:=0;
  C_step:=200;
  Ith1:=254;
  r254:=16;
  g255th:=200;
  cb:=TSampleGrabberCB.Create(nil);

  CoCreateInstance(CLSID_CaptureGraphBuilder2, nil, CLSCTX_INPROC_SERVER, IID_ICaptureGraphBuilder2, FCaptureGraphBuilder);
  inherited Create(AOwner);
end;
//------------------------------------------------------------------------------
destructor TVidCap.Destroy;
var i: integer;
begin

{  aGrabber.SetCallback(nil, 1);
  if cb <> nil then
    cb.NeedHist:=False;

  for i:=0 to FCapDevs.Count-1 do
  begin
    TSave(FCapDevs.Objects[i]).filter:=nil;
    FCapDevs.Objects[i].Destroy;
  end;
  FCapDevs.Destroy;
 }
  inherited Destroy;
end;
//------------------------------------------------------------------------------
procedure TVidCap.BuildFilterGraph;
var
  

  hr:HRESULT;
//  Lst:TStringList;
//  s:TSave;
//  smt:PAMMediaType;
//  psmt:Pointer;
//  vh:^VIDEOINFOHEADER;
//  bmh:^BITMAPINFOHEADER;
//  scc:VIDEO_STREAM_CONFIG_CAPS;
  p_inf: PIN_INFO;

 // i,j:Integer;

  enum:IEnumPins;
  pin:IPin;
  tot_fetched_pin:cardinal;
  pinDirection:TPinDirection;


begin
  FFilterGraph.AddFilter(aCapFilter, 'Video capture');
  aSampleGrabber:=AddFilterByCLSID(CLSID_SampleGrabber, 'Sample Grabber');
  if FAutoRender then aRender:=AddFilterByCLSID(CLSID_VideoRenderer, 'Video Render')
  else aRender:=AddFilterByCLSID(CLSID_NullRenderer, 'Null Render');

  hr:=FCaptureGraphBuilder.SetFiltergraph(FFilterGraph);

  if hr<>S_OK then
    RaiseDirectShowException(hr,'Error');

  hr:=FCaptureGraphBuilder.RenderStream(@PIN_CATEGORY_CAPTURE, nil, aCapFilter, aSampleGrabber, aRender);
  FCaptureGraphBuilder.FindInterface(@LOOK_UPSTREAM_ONLY, nil, aCapFilter, IID_IAMCrossbar, aCrossBar);

  if hr<>S_OK then
    RaiseDirectShowException(hr,'Error');

  aCapFilter.EnumPins(enum);
  if enum<>nil then
    while enum.Next(1,pin,@tot_fetched_pin)=S_OK do
      begin
        pin.QueryDirection(pinDirection);
        pin.QueryPinInfo(p_inf);
        if pinDirection=PINDIR_OUTPUT then
          begin
            pin.QueryInterface(IID_IAMStreamConfig, aConf);
            aCapPin:=Pin;
            break
          end;
      end;

  aCapFilter.QueryInterface(IID_IAMAnalogVideoDecoder, aAnalogVideo);

  aCapFilter.QueryInterface(IID_IAMVideoProcAmp, aVidProcAmp);

  //Получаем интерфейс для настройки Sample Grabber-а
  hr := aSampleGrabber.QueryInterface(IID_ISampleGrabber, aGrabber);
  if hr<>S_OK then
    RaiseDirectShowException(hr,'Error');

  //Режим собирания семплов в буффер
  hr := aGrabber.SetBufferSamples( FALSE );
  if hr<>S_OK then
    RaiseDirectShowException(hr,'Error');

  //Сохранить весь поток
  hr := aGrabber.SetOneShot( FALSE );
  if hr<>S_OK then
    RaiseDirectShowException(hr,'Error');

  //Устанавливаем callback процедуру
  if cb <> nil then
    cb.Destroy;
  cb:=TSampleGrabberCB.Create(nil);
  CB.FHandle:=FHandle;
  CB.AutoRender:=FAutoRender;
  cb.AutoReg:=FAutoContrast;

 // hr:=aGrabber.SetCallback(CB, 1);
  {if hr<>S_OK then
    RaiseDirectShowException(hr,'Error with SampleGrabber');}
end;

//------------------------------------------------------------------------------
procedure TVidCap.ShowPropertyPages;
var
  pPropPage:ISpecifyPropertyPages;
  pUnk:IUnknown;
  pages:CAUUID;
begin
  if aCapFilter = nil then exit;

  aCapFilter.QueryInterface(ISpecifyPropertyPages, pPropPage);
  if pPropPage = nil then exit;

  aCapFilter.QueryInterface(IUnknown, pUnk);
  pPropPage.GetPages(pages);
  OleCreatePropertyFrame(FHandle, 100, 100, 'Properties', 1, @pUnk, pages.cElems, pages.pElems, LOCALE_USER_DEFAULT, 0, nil);
end;
//------------------------------------------------------------------------------
procedure TVidCap.ShowPropertyPages1;
var
  pPropPage:ISpecifyPropertyPages;
  pUnk:IUnknown;
  pages:CAUUID;
begin
  if aCapPin = nil then exit;

  aCapPin.QueryInterface(ISpecifyPropertyPages, pPropPage);
  if pPropPage = nil then exit;

  aCapPin.QueryInterface(IUnknown, pUnk);
  pPropPage.GetPages(pages);

  //Stop;
  Pause;
  OleCreatePropertyFrame(FHandle, 100, 100, 'Properties', 1, @pUnk, pages.cElems, pages.pElems, LOCALE_USER_DEFAULT, 0, nil);
  Run
end;
//------------------------------------------------------------------------------
procedure TVidCap.SelectCapDevice(index:Integer);
var
  s: TSave;
begin
  if FCapDevs.Count = 0 then exit;
  s:=TSave(FCapDevs.Objects[index]);
  aCapFilter:=s.filter;
end;
//------------------------------------------------------------------------------
procedure TVidCap.SetResolution(w, h: Integer);
var
  pmt: PAMMediaType;
  vh: ^VIDEOINFOHEADER;
  scc: VIDEO_STREAM_CONFIG_CAPS;
  hr: HRESULT;
  i: integer;
begin
  if aConf = nil then exit;

 // Stop;

  aConf.GetStreamCaps(1, pmt, scc);
  vh:=pmt^.pbFormat;
  vh.bmiHeader.biWidth:=w;
  vh.bmiHeader.biHeight:=h;
//  vh.bmiHeader.biSize:=((w shr 2) shl 2)*((h shr 2) shl 2)*16;
  pmt.lSampleSize:=vh.bmiHeader.biSize;
  hr:=aConf.SetFormat(pmt^);
  if hr = S_OK then
  begin
    if Not Assigned(cb.Buf) then
      GetMem(cb.Buf, w*h*2{3})
    else
    begin
      FreeMem(cb.Buf, cb.Len);
      GetMem(cb.Buf, w*h*2{3});
    end;
    FSampleWidth:=w;
    FSampleHeight:=h;
    cb.Len:=w*h*2{3};
    cb.w:=w;
    cb.h:=h;
    cb.FFrameCount:=FFramesCount;

    {SetLength(cb.Frames, cb.FFrameCount);
    for i:=0 to cb.FFrameCount-1 do
      GetMem(cb.Frames[i].Buf, cb.Len);}

    {cb.p1.x:=(w div 2)-200;
    cb.p2.x:=(w div 2)+200;
    cb.p1.y:=(h div 2)-150;
    cb.p2.y:=(h div 2)+150;}
  end;
  mt:=pmt^;
 // Run
end;
//------------------------------------------------------------------------------
procedure TVidCap.GetResolution(var w, h: Integer);
var
  pmt:PAMMediaType;
  vh:^VIDEOINFOHEADER;
  scc:VIDEO_STREAM_CONFIG_CAPS;
begin
  if aConf = nil then exit;
  aConf.GetStreamCaps(1, pmt, scc);
  vh:=pmt^.pbFormat;
  w:=vh.bmiHeader.biWidth;
  h:=vh.bmiHeader.biHeight
end;
//------------------------------------------------------------------------------
procedure TVidCap.UpdateCapDevList;
var
  i:Integer;
begin
  for i:=0 to FCapDevs.Count-1 do FCapDevs.Objects[i].Free;
  FCapDevs.Clear;
  GetVidCapDevs(FCapDevs)
end;
//------------------------------------------------------------------------------
procedure TVidCap.GetVidCapDevs(Lst: TStringList);
var
  pFilter: IBaseFilter;
  pClassEnum: ICreateDevEnum;
  pEnumCat: IEnumMoniker;
  pMoniker: IMoniker;
  cFetched: LongWord;
  pPropBag: IPropertyBag;
  varName: OleVariant;
  s: TSave;
  hr: HRESULT;
begin
  CoCreateInstance(CLSID_SystemDeviceEnum, nil, CLSCTX_INPROC_SERVER, IID_ICreateDevEnum, pClassEnum);
  hr:=pClassEnum.CreateClassEnumerator(CLSID_VideoInputDeviceCategory, pEnumCat, 0);
  if hr = S_OK then
    begin
      while pEnumCat.Next(1, pMoniker, @cFetched) = S_OK do
        begin
			    pMoniker.BindToStorage(nil, nil, IID_IPropertyBag, pPropBag);
			    // Получаем имя устройства в виде текстовой строки
			    VariantInit(varName);
			    hr:=pPropBag.Read('FriendlyName', varName, nil);
			    if SUCCEEDED(hr) then
            begin
			        pMoniker.BindToObject(nil, nil, IID_IBaseFilter, pFilter);
              s:=TSave.Create;
              s.filter:= pFilter;
              Lst.AddObject(varName, s);
            end;
          VariantClear(varName)
        end;

        // Clean up
        //pPropBag._Release;
        //pMoniker._Release;
        //pEnumCat._Release;
    end;
  pClassEnum:=nil;
  pEnumCat:=nil;
  pMoniker:=nil;
  pPropBag:=nil;
end;
//------------------------------------------------------------------------------
procedure TVidCap.StartStream;
begin
  BuildFilterGraph;
  //Run;
  SetResolution(760, 576);
  Run;
end;
//------------------------------------------------------------------------------
type
  TArr = array of LongWord;

procedure TVidCap.Capture;
begin
  if cb <> nil then
    cb.StartCapture(cb.FFrameCount);
end;
//------------------------------------------------------------------------------
procedure TVidCap.GetCapturedBitmaps(p: array of PMyInfernalType);
var
 vh: TVideoInfoHeader;
 smt: PAMMediaType;
 i, j, k, w, h, r, g, b: Integer;
 src: PByteArray;
begin
  if CB = nil then exit;

  if Length(CB.Frames) = 0 then exit;

  aConf.GetFormat(smt);
  vh:= TVideoInfoHeader(smt.pbFormat^);

  w:= vh.bmiHeader.biWidth;
  h:= vh.bmiHeader.biHeight;
  for k:=0 to Length(p)-1 do
  begin
    p[k]^.Clear;
    p[k]^.Init(h, w, varByte);
    src:=cb.Frames[k].Buf;
    for i:=0 to h-1 do
      for j:=0 to w-1 do
      begin
        r:=src^[(i*w+j)*3]*30;
        g:=src^[(i*w+j)*3+1]*59;
        b:=src^[(i*w+j)*3+2]*11;
        p[k]^.b^[(h-i-1)*w+j]:=round((r+g+b)/100);
      end;
     {for i:=0 to w*h-1 do
     begin
       r:=src^[3*i]*30;
       g:=src^[3*i+1]*59;
       b:=src^[3*i+2]*11;
       p[k]^.b^[i]:=round((r+g+b)/100);
     end;}
  end;
 // FreeMem(Buf, Len);

  for i:=0 to CB.FFrameCount-1 do
    FreeMem(cb.Frames[i].Buf, cb.Frames[i].Len);

  Finalize(cb.Frames);


  {for i:=0 to Length(CB.Frames)-1 do
    begin
      bmp:=TBitmap.Create;
      time[i]:=CB.Frames[i].Time;

      bmp.Width:=vh.bmiHeader.biWidth;
      bmp.Height:=vh.bmiHeader.biHeight;
      bmp.PixelFormat:=pf32bit;

      src:=CB.Frames[i].Buf;
      for k:=0 to bmp.Height-1 do
        for m:=0 to bmp.Width-1 do
          begin
            dst:=bmp.ScanLine[bmp.Height-1-k];
            dst[m]:=PColor(@src[(m+k*bmp.Width)*3])^;
          end;
      Lst.Add(bmp);
      FreeMem(CB.Frames[i].Buf)
    end;
     }
end;
//------------------------------------------------------------------------------
function TVidCap.GetHist: PHistArr;

begin
  Result:=PHistArr(@CB.Hist[0]);
end;
//------------------------------------------------------------------------------
procedure TVidCap.SetNeedHist(nh:Boolean);
begin
  if CB <> nil then CB.NeedHist:=nh
end;
//------------------------------------------------------------------------------
function TVidCap.GetNeedHist:Boolean;
begin
  if CB <> nil then Result:=CB.NeedHist else Result:=False
end;
//------------------------------------------------------------------------------
function  TVidCap.GetBrightness: Integer;
var
  val:Integer;
  flags:VideoProcAmpFlags;

begin
  if aVidProcAmp = nil then exit;
  aVidProcAmp.Get(VideoProcAmp_Brightness, val, flags);
  Result:=val
end;
//------------------------------------------------------------------------------
procedure TVidCap.SetBrightness(val:Integer);
begin
  if aVidProcAmp = nil then exit;
  aVidProcAmp.Set_(VideoProcAmp_Brightness, val, VideoProcAmp_Flags_Auto)
end;
//------------------------------------------------------------------------------
function  TVidCap.GetContrast:Integer;
var
  val:Integer;
  flags:VideoProcAmpFlags;

begin
  if aVidProcAmp = nil then exit;
  aVidProcAmp.Get(VideoProcAmp_Contrast, val, flags);
  Result:=val
end;
//------------------------------------------------------------------------------
procedure TVidCap.SetContrast(val:Integer);
begin
  if aVidProcAmp = nil then exit;
  aVidProcAmp.Set_(VideoProcAmp_Contrast, val, VideoProcAmp_Flags_Auto)
end;
//------------------------------------------------------------------------------
procedure TVidCap.GetBrightMinMax(var min, max:Integer);
var
  step, default:Integer;
  flags:VideoProcAmpFlags;

begin
  if aVidProcAmp <> nil then aVidProcAmp.GetRange(VideoProcAmp_Brightness, min, max, step, default, flags)
end;
//------------------------------------------------------------------------------
procedure TVidCap.GetCntrstMinMax(var min, max:Integer);
var
  step, default:Integer;
  flags:VideoProcAmpFlags;

begin
  if aVidProcAmp <> nil then aVidProcAmp.GetRange(VideoProcAmp_Contrast, min, max, step, default, flags)
end;
//------------------------------------------------------------------------------
procedure TVidCap.GetAllVideoModes(lst: TStringList);
var
  fmts:Integer;

begin
  aAnalogVideo.get_AvailableTVFormats(fmts);

  if fmts and AnalogVideo_NTSC_M      <> 0   then lst.Add('NTSC_M');
  if fmts and AnalogVideo_NTSC_M_J    <> 0   then lst.Add('NTSC_M_J');
  if fmts and AnalogVideo_NTSC_433    <> 0   then lst.Add('NTSC_433');
  if fmts and AnalogVideo_PAL_B       <> 0   then lst.Add('PAL_B');
  if fmts and AnalogVideo_PAL_D       <> 0   then lst.Add('PAL_D');
  if fmts and AnalogVideo_PAL_H       <> 0   then lst.Add('PAL_H');
  if fmts and AnalogVideo_PAL_I       <> 0   then lst.Add('PAL_I');
  if fmts and AnalogVideo_PAL_M       <> 0   then lst.Add('PAL_I');
  if fmts and AnalogVideo_PAL_N       <> 0   then lst.Add('PAL_N');
  if fmts and AnalogVideo_PAL_60      <> 0   then lst.Add('PAL_60');
  if fmts and AnalogVideo_SECAM_B     <> 0   then lst.Add('SECAM_B');
  if fmts and AnalogVideo_SECAM_D     <> 0   then lst.Add('SECAM_D');
  if fmts and AnalogVideo_SECAM_G     <> 0   then lst.Add('SECAM_G');
  if fmts and AnalogVideo_SECAM_H     <> 0   then lst.Add('SECAM_H');
  if fmts and AnalogVideo_SECAM_K     <> 0   then lst.Add('SECAM_K');
  if fmts and AnalogVideo_SECAM_K1    <> 0   then lst.Add('SECAM_K1');
  if fmts and AnalogVideo_SECAM_L     <> 0   then lst.Add('SECAM_L');
  if fmts and AnalogVideo_SECAM_L1    <> 0   then lst.Add('SECAM_L1');
  //if fmts and AnalogVideo_PAL_N_COMBO <> 0   then lst.Add('PAL_N_COMBO')
end;
//------------------------------------------------------------------------------
function  TVidCap.GetVideoMode:Integer;
var
  val:Integer;

begin
  aAnalogVideo.get_TVFormat(val);
  Result:=val
end;
//------------------------------------------------------------------------------
procedure TVidCap.SetVideoMode(val:Integer);
begin
  aAnalogVideo.put_TVFormat(val)
end;
//------------------------------------------------------------------------------
procedure TVidCap.GetAllVideoSources(lst: TStringList);
var
  opc, ipc, i:Integer;
  cor_pin:Integer;
  pin_type:TPhysicalConnectorType;
begin
  aCrossBar.get_PinCounts(opc, ipc);
  for i:=0 to ipc-1 do
    begin
      aCrossBar.get_CrossbarPinInfo(TRUE, i, cor_pin, pin_type);
      case pin_type of
        PhysConn_Video_Tuner: lst.Add('Video Tuner');
        PhysConn_Video_Composite: lst.Add('Composite input');
        PhysConn_Video_SVideo: lst.Add('SVideo input');
        PhysConn_Video_RGB: lst.Add('RGB input');
      end
    end
end;
//------------------------------------------------------------------------------
function  TVidCap.GetVideoSource:Integer;
var
  cor_pin:Integer;
  pin_type:TPhysicalConnectorType;

begin
  aCrossBar.get_CrossbarPinInfo(FALSE, 0, cor_pin, pin_type);
  Result:=cor_pin
end;
//------------------------------------------------------------------------------
procedure TVidCap.SetVideoSource(val:Integer);
var
  opc, ipc:Integer;
begin
  aCrossBar.get_PinCounts(opc, ipc);
  if val >= ipc then exit;
  if aCrossBar.CanRoute(0, val) <> S_OK then exit;

  aCrossBar.Route(0, val)
end;
//------------------------------------------------------------------------------
procedure TVidCap.GetCurBMI(var bmi:BITMAPINFOHEADER);
var
  vh:VIDEOINFOHEADER;
  smt:PAMMediaType;

begin
  aConf.GetFormat(smt);
  vh:=VIDEOINFOHEADER(smt.pbFormat^);
  CopyMemory(@bmi, @vh.bmiHeader, sizeof(BITMAPINFOHEADER))
end;
//------------------------------------------------------------------------------
function TVidCap.AutoReg{(var hist:array of Integer)}:Boolean;
var
 i, j, cntr: Integer;
 //hist: array [0..255] of integer;
 lhist: array [0..255] of Double;
 max: Double;
 a,b: Boolean;
 pb: PByteArray;
 p1, p2: tpoint;
 w: integer;

begin
 { ZeroMemory(@(hist), 256*SizeOf(Integer));
  pb:=PByteArray(cb.Buf);}
  {p1:=cb.p1;
  p2:=cb.p2;
  w:=cb.w;}
  {w:=(cb.Len div 3)-1;
  for i:=0 to w do
    inc(hist[pb^[i*3+1]]);}

  {for i:=p1.y to p2.y do
    for j:=p1.x to p2.x do
      inc(cb.hist[pb^[(i*w+j)*3+1]]);}

  cntr:=0;
  //Считаем логарифмическую гистограмму
  for i:=0 to 255 do
    if cb.hist[i] <> 0 then
      lhist[i]:= Log10(cb.hist[i])
    else
      lhist[i]:=0;
  //Ищем наибольшее значение на гистограмме
  max:=0; 
  for i:=0 to 255 do
    if lhist[i] > max then
      max:=lhist[i];

  //Ищем наиболее близкое к 255 значение интенсивности большее чем max/r254
  for i:=255 downto 0 do
    if lhist[i] > max/r254 then
      break;

  a:=cb.Hist[255] > g255th;
  b:=i < Ith1;
  if a then
    C_max:=GetContrast; //Число пересвеченых пикселей больше порога. Уменьшаем контраст.
  if abs(C_max-C_min) < 80 then
    C_min:=0;

  if b then
    C_min:=GetContrast; //Верхнее значение интенсивности меньше порога. Увиличиваем контраст.
  if abs(C_max-C_min) < 80 then
    C_max:=0;
  //Контраст установлен
  if not (a or b) then
    begin
      Result:=True;
    //  C_max:=0; C_min:=0;
      exit;
    end;
  //Настраиваем контраст
  if (C_max > 0) and (C_min > 0) then
    cntr:=(C_max+C_min) div 2;
  if C_max = 0 then
    cntr:=C_min+C_step;
  if C_min = 0 then
    cntr:=C_max-C_step;
  if cntr > 10000 then
    cntr:=10000;
  if cntr < 0 then
    cntr:=0;
  SetContrast(cntr);
  Result:=False
end;

procedure TVidCap.Test;
var i,j: integer;
begin
  j:=10456;
  i:=sqr(j);
end;

procedure TVidCap.GetCapturedBitmaps(frame1, frame2, frame3: PBtArr);
var
 vh: TVideoInfoHeader;
 smt: PAMMediaType;
 i, w, h{, t}, j, w1, h1: Integer;
 src: PByteArray;
begin
  if CB = nil then exit;

  if Length(CB.Frames) = 0 then exit;

  aConf.GetFormat(smt);
  vh:=TVideoInfoHeader(smt.pbFormat^);
  w:= vh.bmiHeader.biWidth;
  h:= vh.bmiHeader.biHeight;
  {t:=w*h-1;}
  w1:=w-1;
  h1:=h-1;

  src:=cb.Frames[0].Buf;
{  for i:=0 to t do
    frame1^[i]:=src^[i*3];}
  for i:=0 to h1 do
    for j:=0 to w1 do
      frame1^[(h1-i)*w+j]:=src^[(i*w+j)*3];

  src:=cb.Frames[1].Buf;
  {for i:=0 to t do
    frame2^[i]:=src^[i*3];}
  for i:=0 to h1 do
    for j:=0 to w1 do
      frame2^[(h1-i)*w+j]:=src^[(i*w+j)*3];

  src:=cb.Frames[2].Buf;
  for i:=0 to h1 do
    for j:=0 to w1 do
      frame3^[(h1-i)*w+j]:=src^[(i*w+j)*3];

  {for i:=0 to t do
    frame3^[i]:=src^[i*3];}

 for i:=0 to CB.FFrameCount-1 do
    FreeMem(cb.Frames[i].Buf, cb.Frames[i].Len);

  Finalize(cb.Frames);
end;

procedure TVidCap.GetCapturedBitmap(frame: PBtArr);
var w, h, i, j, h1, h2, w1, tmp: integer;
    src: PBtArr;
begin
  w:=FSampleWidth;
  h:=FSampleHeight;
  src:=cb.Buf;
  if rotate = 2 then
  begin
    for i:=0 to h-1 do
      for j:=0 to w-1 do
        frame^[{(h-1-i)}i*w+j]:=src^[(i*w+j)*2{3}];
    exit;
  end;

  h1:=w-1;
  h2:=h1-cut;
  w1:=h-1;
  for i:=cut to h2 do
  begin
    for j:=0 to w1 do
    begin
      if Rotate = 0 then
        tmp:=((w1-j)*w+h1-i)*2
      else
        tmp:=((w1-j)*w +i)*2;
    frame^[(i-cut)*h+j]:=src^[tmp];
    end;
  end;
end;

procedure TVidCap.Capture(Nframes: integer);
begin
    if CB <> nil then CB.StartCapture(Nframes);
end;

procedure TVidCap.GetAverageFrame(frame: PBtArr);
var w, h, i, j, k, l: integer;
   src: PBtArr;
   temp: PIntegerArray;
begin
  w:=SampleWidth;
  h:=SampleHeight;
  l:=length(cb.Frames);
  GetMem(temp, w*h*sizeof(integer));
  for k:=0 to l-1 do
  begin
    src:=cb.Frames[k].Buf;
    for i:=0 to h-1 do
      for j:=0 to w-1 do
        temp^[(h-1-i)*w+j]:=temp^[(h-1-i)*w+j]+src^[(i*w+j)*3];
  end;
  for i:=0 to h-1 do
    for j:=0 to w-1 do
      frame^[i*w+j]:=round(temp^[i*w+j]/l);
  FreeMem(temp, w*h*sizeof(integer));

  for i:=0 to l-1 do
    FreeMem(cb.Frames[i].Buf, cb.Frames[i].Len);

  Finalize(cb.Frames);
end;

procedure TVidCap.GetPlanBFrame(frames: PBtPointerArr);
var w, h, i, j, k, l: integer;
   src: PBtArr;
begin
  w:=SampleWidth;
  h:=SampleHeight;
  l:=length(cb.Frames);
  for k:=0 to l-1 do
  begin
    src:=cb.Frames[k].Buf;
    for i:=0 to h-1 do
      for j:=0 to w-1 do
        frames^[k]^[(h-1-i)*w+j]:=src^[(i*w+j)*2{3}];
  end;

  for i:=0 to l-1 do
    FreeMem(cb.Frames[i].Buf, cb.Frames[i].Len);

  Finalize(cb.Frames);
end;

procedure TVidCap.GetCapturedBitmaps(frame1, frame2, frame3, frame4, frame5: PBtArr);
var
 vh: TVideoInfoHeader;
 smt: PAMMediaType;
 i, w, h, j, w1, h1: Integer;
 src: PByteArray;
begin
  if CB = nil then exit;
  if (Length(cb.Frames) <> 5) then
    exit;

  aConf.GetFormat(smt);
  vh:=TVideoInfoHeader(smt.pbFormat^);
  w:= vh.bmiHeader.biWidth;
  h:= vh.bmiHeader.biHeight;
  w1:=w-1;
  h1:=h-1;

  src:=cb.Frames[0].Buf;
  for i:=0 to h1 do
    for j:=0 to w1 do
      frame1^[(h1-i)*w+j]:=src^[(i*w+j)*3];

  src:=cb.Frames[1].Buf;
  for i:=0 to h1 do
    for j:=0 to w1 do
      frame2^[(h1-i)*w+j]:=src^[(i*w+j)*3];

  src:=cb.Frames[2].Buf;
  for i:=0 to h1 do
    for j:=0 to w1 do
      frame3^[(h1-i)*w+j]:=src^[(i*w+j)*3];

  src:=cb.Frames[3].Buf;
  for i:=0 to h1 do
    for j:=0 to w1 do
      frame4^[(h1-i)*w+j]:=src^[(i*w+j)*3];

  src:=cb.Frames[4].Buf;
  for i:=0 to h1 do
    for j:=0 to w1 do
      frame5^[(h1-i)*w+j]:=src^[(i*w+j)*3];

  for i:=0 to CB.FFrameCount-1 do
    FreeMem(cb.Frames[i].Buf, cb.Frames[i].Len);

  Finalize(cb.Frames);
end;

procedure TVidCap.SetFramesCount(Frames: integer);
var i: integer;
begin
  if cb.FFrameCount <> 0 then
  begin
    for i:=0 to cb.FFrameCount-1 do
      FreeMem(cb.Frames[i].Buf, cb.Len);
    Finalize(cb.Frames);
  end;
  FFramesCount:=Frames;
  cb.FFrameCount:=Frames;

  SetLength(cb.Frames, Frames);
  for i:=0 to Frames-1 do
    GetMem(cb.Frames[i].Buf, cb.Len);
end;

constructor TVidCap.Create(AOwner: TComponent; VidCapParam: TVidCapParam; _hdnl: HWND);
begin
  inherited Create(AOwner);

  FCapDevs:=TStringList.Create;
  GetVidCapDevs(FCapDevs);
  aCapFilter:=nil;
  aVidProcAmp:=nil;
  aConf:=nil;
  SelectCapDevice(VidCapParam.Device);
  FAutoRender:=false;
  AutoContrast:=VidCapParam.AutoReg;
  C_step:=VidCapParam.Cstep;
  r254:=VidCapParam.r254;
  Ith1:=VidCapParam.ith;
  g255th:=VidCapParam.g255th;
  cut:=VidCapParam.cut;
  Rotate:=VidCapParam.Rotate;
  FFramesCount:=VidCapParam.Frames;
  FHandle:=_hdnl;
  CoCreateInstance(CLSID_CaptureGraphBuilder2, nil, CLSCTX_INPROC_SERVER, IID_ICaptureGraphBuilder2, FCaptureGraphBuilder);

  BuildFilterGraph;
  SetResolution(VidCapParam.Width, VidCapParam.Height);
  SetBrightness(VidCapParam.Brightness);
  SetContrast(VidCapParam.Contrast);
  SetVideoMode($10);
  SetVideoSource(VidCapParam.VideoSource);
  aGrabber.SetCallback(cb, 1);


end;

end.
