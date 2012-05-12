unit VidCap;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, directShow9, ActiveX, Graphics, Dialogs;

const
  WM_MMNOTIFY=WM_APP+$1234;
  WM_CAPDONE=WM_APP+$1235;
  WM_NEWFRAME=WM_APP+$1236;
  
  IID_IPropertyBag:TGUID = '{55272A00-42CB-11CE-8135-00AA004BB851}';

type
  PFrame = ^TFrame;
  TFrame = record
    Buf:Pointer;
    Len:LongInt;
    Time:Double;
  end;

type //Класс для реализации callback процедуры при использовании Sample Grabber-а
  TSampleGrabberCB = class(TComponent, ISampleGrabberCB)
  private
    FFrameCount, Cnt:Integer;

    function  SampleCB(SampleTime: Double; pSample: IMediaSample): HResult; stdcall;
    function  BufferCB(SampleTime: Double; pBuffer: PByte; BufferLen: longint): HResult; stdcall;

  public
    Pos:Double;
    Buf:Pointer;
    Len:LongInt;
    Frames:array of TFrame;
    FHandle:HWND;
    Hist: array [0..255] of Integer;
    NeedHist:Boolean;

    constructor Create(AOwner:TComponent);virtual;
    destructor Destroy;override;

    procedure StartCapture(FrameCount, w, h:Integer);
    procedure Start;
    procedure SetCaptureParams(FrameCount, w, h:Integer);
    procedure ClearCaptureParams;
  end;

type
  TPlayPosition=record
    Current:int64;
    Stop:int64;
  end;

type
  TDShowComp = class(TComponent)
  private
    { Private declarations }

    procedure SetHandle(const Value: HWND);
    procedure SetVideoRect(const Value: TRect);
    procedure UpdateVideoWindowPos;
    procedure SetControl(const Value: TWinControl);

  protected


    procedure SetNotifyWindow(const ahandle:HWND);
    procedure SetWindow(const aHandle:HWND);virtual;

    function GetPin(aFilter:IBaseFilter;
                    const PinDir:TPinDirection;
                    const indx:integer):IPin;
    function ConnectFilter(OutFilter,InFilter:IBaseFilter):HResult;
    function AddFilterByCLSID(clsid:TGUID;const name:string):IBaseFilter;
    function FindFilterByFriendlyName(const classid:TGUID; const friendlyname:string):IBaseFilter;

  public
    { Public declarations }

    FFilterGraph:IGraphBuilder;
    FMediaControl:IMediaControl;
    FMediaEvent:IMediaEventEx;
    FMediaSeek:IMediaSeeking;
    FVideoWindow:IVideoWindow;

    FHandle: HWND;
    FControl: TWinControl;
    FVideoRect:TRect;
    aAnalogVideo: IAMAnalogVideoDecoder;

    CB: TSampleGrabberCB;
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;

    procedure BuildFilterGraph;virtual;
    procedure RemoveAllFilters;

    procedure Run;
    procedure Stop;
    procedure Pause;

  published
    { Published declarations }
    property Control:TWinControl read FControl write SetControl;
    property Handle:HWND read FHandle write SetHandle;
    property VideoRect:TRect read FVideoRect write SetVideoRect;

    property GraphObj:IGraphBuilder read FFilterGraph;
    property ControlObj:IMediaControl read FMediaControl;
    property EventObj:IMediaEventEx read FMediaEvent;
    property SeekObj:IMediaSeeking read FMediaSeek;
  end;

type
  THistArr =array [0..255] of Integer;
  PHistArr = ^THistArr;

  TVidCap = class(TDShowComp)
  private
    function  GetNeedHist:Boolean;
    procedure SetNeedHist(nh:Boolean);
    function  GetBrightness:Integer;
    procedure SetBrightness(val:Integer);
    function  GetContrast:Integer;
    procedure SetContrast(val:Integer);


  protected
    mt: AM_MEDIA_TYPE;
    aConf:IAMStreamConfig;

    aVidProcAmp:IAMVideoProcAmp;

    FCapDevs:TStringList;

    procedure GetVidCapDevs(Lst:TStringList);

  public
    aGrabber: ISampleGrabber;
    aCapFilter: IBaseFilter;
    aSampleGrabber: IBaseFilter;
    aRender: IBaseFilter;

    constructor Create(AOwner:TComponent);override;
    destructor Destroy; override;

    procedure BuildFilterGraph;virtual;
    procedure ShowPropertyPages;
    procedure SetResolution(w,h:Integer);
    procedure GetResolution(var w, h: integer);
    procedure SetVideoMode(val:Integer);
    procedure GetVideoMode(var val: integer);
    procedure UpdateCapDevList;
    procedure SelectCapDevice(index:Integer);

    procedure StartStream;
    procedure Capture;
    procedure GetCapturedBitmaps(Lst:TList;  var time:array of Double);
    function GetHist:PHistArr;

    procedure GetBrightMinMax(var min, max:Integer);
    procedure GetCntrstMinMax(var min, max:Integer);

    property CapDevs:TStringList read FCapDevs;
    property NeedHist:Boolean read GetNeedHist write SetNeedHist;
    property Brightness:Integer read GetBrightness write SetBrightness;
    property Contrast:Integer read GetContrast write SetContrast;
  end;

procedure Register;

implementation

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
procedure TSampleGrabberCB.ClearCaptureParams;
var i: integer;
begin

  for i:=0 to FFrameCount-1 do
    FreeMem(Frames[i].Buf, Len);

  Finalize(Frames);
  FFrameCount:=0;
end;

constructor TSampleGrabberCB.Create(AOwner:TComponent);
begin
  Pos:=0; Cnt:=0; NeedHist:=False;
  inherited Create(Owner);
end;
//------------------------------------------------------------------------------
destructor TSampleGrabberCB.Destroy;
begin
  SetLength(Frames, 0)
end;
//------------------------------------------------------------------------------
function TSampleGrabberCB.SampleCB(SampleTime: Double; pSample: IMediaSample): HResult; stdcall;
begin
  Result:=0
end;

procedure TSampleGrabberCB.SetCaptureParams(FrameCount, w, h: Integer);
var i: integer;
begin
  SetLength(Frames, FrameCount);
  Len:=w*h*3;
  for i:=0 to FrameCount-1 do
    GetMem(Frames[i].Buf, w*h*3);

  FFrameCount:=FrameCount;
end;

//------------------------------------------------------------------------------
function TSampleGrabberCB.BufferCB(SampleTime: Double; pBuffer: PByte; BufferLen: longint): HResult; stdcall;
var
  i:Integer;
  pw:PWordArray;

begin
//  if NeedHist then
    begin
      pw:=PWordArray(pBuffer);
      ZeroMemory(@Hist, 256*SizeOf(Integer));
      for i:=0 to BufferLen div 2 - 1 do Inc(Hist[pw[i] and $FF]);
      SendMessage(FHandle, WM_NEWFRAME, 0, 0)
    end;

  if Cnt = 0 then exit;

 { if pBuffer = nil then
   begin
    Result:=E_POINTER;
    exit
   end;
  }
  if Cnt > 0 then
    begin
      //Frames[FFrameCount-Cnt].Time:=SampleTime;
      Frames[FFrameCount-Cnt].Len:=BufferLen;
     // Frames[FFrameCount-Cnt].Buf:=nil;
  //    GetMem(Frames[FFrameCount-Cnt].Buf, BufferLen);
//     Move(Frames[FFrameCount-Cnt].Buf^, pBuffer^, BufferLen);
      CopyMemory(Frames[FFrameCount-Cnt].Buf, pBuffer, BufferLen);
      Dec(Cnt);

      if Cnt = 0 then
        begin
          SendMessage(FHandle, WM_CAPDONE, LPARAM(@Frames[0]), WPARAM(FFrameCount))
        end;
    end;
end;
//------------------------------------------------------------------------------
procedure TSampleGrabberCB.Start;
begin
  Cnt:=FFrameCount
end;

procedure TSampleGrabberCB.StartCapture(FrameCount, w, h:Integer);
var i: integer;
begin
  SetLength(Frames,FrameCount);
  for i:=0 to FrameCount-1 do
    GetMem(Frames[i].Buf, w*h*3);

  FFrameCount:=FrameCount;
  Cnt:=FrameCount
end;
//------------------------------------------------------------------------------
//--------------------------------- TDShowComp ---------------------------------
//------------------------------------------------------------------------------
constructor TDShowComp.Create(AOwner:TComponent);
var
  aEvent:IMediaEvent;
begin
  inherited Create(AOwner);

  CoCreateInstance(CLSID_FilterGraph,nil,
                   CLSCTX_INPROC_SERVER,
                   IID_IGraphBuilder,FFilterGraph);

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
var
 i:Integer;
begin
  RemoveAllFilters;

  FFilterGraph:=nil;
  FMediaControl:=nil;
  FMediaEvent:=nil;
  FMediaSeek:=nil;
  cb.Destroy;

  inherited;
end;
//------------------------------------------------------------------------------
procedure TDShowComp.Run;
var
  hr:HResult;
  fs:FILTER_STATE;
begin
  hr:=FMediaControl.Run;
  hr:=FMediaControl.GetState(INFINITE, fs);

  if fs<>State_Running then
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
  enum:IEnumFilters;
  aFilter:IBaseFilter;
begin
  if (FFilterGraph = nil) then exit;

  Stop;
  FFilterGraph.EnumFilters(enum);
  while (enum.Next(1,afilter,nil)=S_OK) do
  begin
    FFilterGraph.RemoveFilter(aFilter);
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
function TDShowComp.AddFilterByCLSID(clsid: TGUID; const name: string):IBaseFilter;
var
  afilter:IBaseFilter;
  awideName:wideString;
  hr:HResult;

begin
  awidename:=name;
  hr:=CoCreateInstance(clsid,
                       nil,
                       CLSCTX_INPROC{_SERVER},
                       IID_IBaseFilter,
                       afilter);
  if hr <> S_OK then
    RaiseDirectshowException(hr,'Create filter '+awideName+' failed.');

  hr:=FFilterGraph.AddFilter(afilter,PWideChar(awideName));
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
type
  TSave = class(TObject)
    filter:IBaseFilter;
  end;
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

  inherited {Create(AOwner)};
end;
//------------------------------------------------------------------------------
destructor TVidCap.Destroy;
begin
  if CB <> nil then CB.NeedHist:=False;
  inherited
end;
//------------------------------------------------------------------------------
type
  PBMI = ^BITMAPINFO;

procedure TVidCap.BuildFilterGraph;
var


  hr:HRESULT;
  Lst:TStringList;
  s:TSave;
  smt:PAMMediaType;
  psmt:Pointer;
  vh:^VIDEOINFOHEADER;
  bmh:^BITMAPINFOHEADER;
  scc:VIDEO_STREAM_CONFIG_CAPS;

  i,j:Integer;

  enum:IEnumPins;
  pin:IPin;
  tot_fetched_pin:cardinal;
  pinDirection:TPinDirection;


begin
  //Lst:=TStringList.Create;
  //GetVidCapDevs(Lst);

  //s:=TSave(Lst.Objects[0]);
  //aCapFilter:=s.filter;
  GraphObj.AddFilter(aCapFilter, 'Video capture');
  aSampleGrabber:=AddFilterByCLSID(CLSID_SampleGrabber, 'Sample Grabber');
  aRender:=AddFilterByCLSID(CLSID_VideoRenderer, 'Video Render');

  aCapFilter.EnumPins(enum);
  if enum<>nil then
    while enum.Next(1,pin,@tot_fetched_pin)=S_OK do
      begin
        pin.QueryDirection(pinDirection);
        if pinDirection=PINDIR_OUTPUT then
          begin
            hr:=pin.QueryInterface(IID_IAMStreamConfig, aConf);
            break
          end;
      end;


  hr:=aCapFilter.QueryInterface(IID_IAMAnalogVideoDecoder, aAnalogVideo);

  hr:=aCapFilter.QueryInterface(IID_IAMVideoProcAmp, aVidProcAmp);

  hr:=ConnectFilter(aCapFilter, aSampleGrabber);
  hr:=ConnectFilter(aSampleGrabber, aRender);

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
  if CB <> nil then CB.Destroy;
  CB := TSampleGrabberCB.Create(nil);
  CB.FHandle:=FHandle;
  hr := aGrabber.SetCallback( CB, 1 );
  if hr<>S_OK then
    RaiseDirectShowException(hr,'Error with SampleGrabber');



  {aConf.GetFormat(PAMMediaType(smt));
  mt:=smt^;
  New(smt);
  ZeroMemory(smt, SizeOf(smt^));

  smt^.majortype := MEDIATYPE_Video;
  smt^.subtype := MEDIASUBTYPE_RGB24;
  smt^.formattype:=FORMAT_VideoInfo;


  New(vh); ZeroMemory(vh, SizeOf(vh^));
  New(bmh); ZeroMemory(bmh, SizeOf(bmh^));

  bmh^.biBitCount:=16;
  bmh^.biPlanes:=1;
  bmh^.biCompression:=BI_RGB;
  bmh^.biWidth:=100;
  bmh^.biHeight:=100;
  vh^.bmiHeader:=bmh^;
  vh^.dwBitRate:=4608000;
  vh^.AvgTimePerFrame:=333667;
  smt^.pbFormat:=vh;
  hr:=aConf.SetFormat(smt^);
  aConf.GetFormat(smt);}
end;
//------------------------------------------------------------------------------
procedure TVidCap.ShowPropertyPages;
var
  pPropPage:ISpecifyPropertyPages;
  pUnk:IUnknown;
  pages:CAUUID;
  hr:HRESULT;

begin
  hr:=aCapFilter.QueryInterface(ISpecifyPropertyPages, pPropPage);
  if pPropPage = nil then exit;

  hr:=aCapFilter.QueryInterface(IUnknown, pUnk);
  hr:=pPropPage.GetPages(pages);
  hr:=OleCreatePropertyFrame(FHandle, 100, 100, 'Properties', 1, @pUnk, pages.cElems, pages.pElems, LOCALE_USER_DEFAULT, 0, 0);
end;
//------------------------------------------------------------------------------
procedure TVidCap.SelectCapDevice(index:Integer);
var
  s:TSave;

begin
  if FCapDevs.Count = 0 then exit;

  s:=TSave(FCapDevs.Objects[index]);
  aCapFilter:=s.filter;
end;
//------------------------------------------------------------------------------
procedure TVidCap.SetResolution(w,h:Integer);
var
  pmt:PAMMediaType;
  vh:^VIDEOINFOHEADER;
  scc:VIDEO_STREAM_CONFIG_CAPS;
  hr:HRESULT;

begin
  if aConf = nil then exit;

  hr:=aConf.GetStreamCaps(1, pmt, scc);
  vh:=pmt^.pbFormat;
  vh.bmiHeader.biWidth:=w;
  vh.bmiHeader.biHeight:=h;
  vh.bmiHeader.biSize:=((w shr 2) shl 2)*((h shr 2) shl 2)*16;
  pmt.lSampleSize:=vh.bmiHeader.biSize;
  Stop;
  hr:=aConf.SetFormat(pmt^);
//  Run;
  mt:=pmt^;
end;
procedure TVidCap.SetVideoMode(val: Integer);
begin
  if aAnalogVideo <> nil then
    aAnalogVideo.put_TVFormat(val);
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
procedure TVidCap.GetVidCapDevs(Lst:TStringList);
var
  pFilter:IBaseFilter;
  pClassEnum:ICreateDevEnum;
  pEnumCat:IEnumMoniker;
  pMoniker:IMoniker;
  cFetched:LongWord;
  pPropBag:IPropertyBag;
  pbc: IBindCtx;

  varName:OleVariant;
  s:TSave;
  hr:HRESULT;

begin
  hr:=CoCreateInstance(CLSID_SystemDeviceEnum,
                       nil,
                       CLSCTX_INPROC_SERVER,
                       IID_ICreateDevEnum,
                       pClassEnum);

  hr:=pClassEnum.CreateClassEnumerator(CLSID_VideoInputDeviceCategory, pEnumCat, 0);

  if hr = S_OK then
    begin
      while pEnumCat.Next(1, pMoniker, @cFetched) = S_OK do
        begin
			    pMoniker.BindToStorage(pbc, nil, IID_IPropertyBag, pPropBag);

			    // Получаем имя устройства в виде текстовой строки
			    VariantInit(varName);
			    hr:=pPropBag.Read('FriendlyName', varName, nil);
			    if SUCCEEDED(hr) then
            begin
			        pMoniker.BindToObject(nil, nil, IID_IBaseFilter, pFilter);
              s:=TSave.Create; s.filter:=pFilter;
              Lst.AddObject(varName, s);
            end;
          VariantClear(varName)
        end;

        // Clean up
        //pPropBag._Release;
        //pMoniker._Release;
        //pEnumCat._Release;
    end;
end;
procedure TVidCap.GetVideoMode(var val: integer);
begin
  aAnalogVideo.get_TVFormat(val);
end;

//------------------------------------------------------------------------------
procedure TVidCap.StartStream;
begin
  BuildFilterGraph;
  Run;
  SetResolution(760, 576)
end;
//------------------------------------------------------------------------------
type
  TArr = array of LongWord;

procedure TVidCap.Capture;
begin
  if CB <> nil then CB.StartCapture(5, 760, 576);
end;
//------------------------------------------------------------------------------
function MAKELANGID(p,s:Word):Word;
begin
  Result:=( (Word(s) shl 10) or WORD(p) )
end;

type
  TColorArray = array [0..16383] of TColor;
  PColorArray = ^TColorArray;

procedure TVidCap.GetCapturedBitmaps(Lst:TList; var time:array of Double);
var
 vh:VIDEOINFOHEADER;
 smt:PAMMediaType;
 i, k, m, res:Integer;
 err:Cardinal;
 dst:PColorArray;
 src:PByteArray;
 pc:PColor;
 Msg:String;
 bmp:TBitmap;
 cnv:TCanvas;

begin
  if CB = nil then exit;

  if Length(CB.Frames) = 0 then exit;

  aConf.GetFormat(smt);
  vh:=VIDEOINFOHEADER(smt.pbFormat^);

  for i:=0 to Length(CB.Frames)-1 do
    begin
      bmp:=TBitmap.Create;
      time[i]:=CB.Frames[i].Time;

      bmp.Width:=vh.bmiHeader.biWidth;
      bmp.Height:=vh.bmiHeader.biHeight;
      bmp.PixelFormat:=pf24bit;

      src:=CB.Frames[i].Buf;
      for k:=0 to bmp.Height-1 do
        for m:=0 to bmp.Width-1 do
          begin
            dst:=bmp.ScanLine[bmp.Height-1-k];
            dst[m]:=PColor(@src[(m+k*bmp.Width)*3])^
          end;

      {err:=0;
      res:=SetDIBitsToDevice(
        bmp.Canvas.Handle, 0, 0,
        vh.bmiHeader.biWidth,
        vh.bmiHeader.biHeight,
        0, 0,
        0,
        vh.bmiHeader.biHeight,
        src,//CB.Frames[i].Buf,
        (PBMI(@vh.bmiHeader))^,
        DIB_RGB_COLORS);}

      {SetLength(Msg, 256);
      err:=GetLastError;
      FormatMessage(
        FORMAT_MESSAGE_ALLOCATE_BUFFER or FORMAT_MESSAGE_FROM_SYSTEM,
        nil,
        err,
        MAKELANGID(LANG_NEUTRAL, SUBLANG_DEFAULT), // Default language
        PAnsiChar(Msg),
        0,
        nil);}

      Lst.Add(bmp);
      FreeMem(CB.Frames[i].Buf, vh.bmiHeader.biWidth*vh.bmiHeader.biHeight*3);
    end;

end;
//------------------------------------------------------------------------------
function TVidCap.GetHist:PHistArr;
var
  _hist:PHistArr;
begin
  if CB = nil then exit;

  {if not CB.NeedHist then
    begin
      Result:=nil;
      exit
    end;}

  GetMem(_hist, 256*SizeOf(Integer));
  CopyMemory(_hist,@CB.Hist[0], 256*SizeOf(Integer));
  Result:=_hist
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


procedure TVidCap.GetResolution(var w, h: integer);
var vh: VIDEOINFOHEADER;
    smt: PAMMediaType;
begin
  aConf.GetFormat(smt);
  vh:=VIDEOINFOHEADER(smt.pbFormat^);
  w:=vh.bmiHeader.biWidth;
  h:=vh.bmiHeader.biHeight;
end;

//------------------------------------------------------------------------------
function  TVidCap.GetBrightness:Integer;
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

procedure Register;
begin
  RegisterComponents('Samples', [TVidCap]);
end;

end.
