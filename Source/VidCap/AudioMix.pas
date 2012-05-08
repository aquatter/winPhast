unit AudioMix;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, mmsystem, directShow9;

const
  WM_MMNOTIFY=WM_APP+$1234;

  CLSID_MPEGLayer3Decoder:TGUID =   '{38BE3000-DBF4-11D0-860E-00A024CFEF6D}';      //Раскодировщик  MPEG Layer 3 Decoder
  //CLSID_MPEGLayer3Encoder:TGUID = '{6A08CF80-0E18-11CF-A24D-0020AFD79767}';      //Кодировщик MP3. Он же CLSID_ACMWrapper
  CLSID_MPEGLayer3Encoder:TGUID =   '{33D9A761-90C8-11D0-BD43-00A0C911CE86}';
  CLSID_LameMPG3AE: TGUID =         '{B8D27088-FF5F-4B7C-98DC-0E91A1696286}';
  CLSID_WaveDest:TGUID =            '{3C78B8E2-6C4D-11D1-ADE2-0000F8754B99}';
  CLSID_WaveParser:TGUID =          '{D51BD5A1-7548-11CF-A520-0080C77EF58A}';

const //Фильтр для наложения звуков
  CLSID_MixFilter :TGUID = '{E7CD6496-F525-4350-A375-2F56F5DF6FBE}';
  IID_ISetupMixFilter :TGUID = '{E7CD6496-F525-4350-A375-2F56F5DF6FBE}';

type
  ISetupMixFilter = interface(IUnknown)
    ['{E7CD6496-F525-4350-A375-2F56F5DF6FBE}']
    function SetMixBuffer(buf:Pointer; len:Int64; pos:Int64):HRESULT;stdcall;
    function SetVolume(vol:Double):HRESULT;stdcall;
  end;

type //Класс для реализации callback процедуры при использовании Sample Grabber-а
  TSampleGrabberCB = class(TComponent, ISampleGrabberCB)
  private
    function  SampleCB(SampleTime: Double; pSample: IMediaSample): HResult; stdcall;
    function  BufferCB(SampleTime: Double; pBuffer: PByte; BufferLen: longint): HResult; stdcall;
  public
    Pos:Double;
    
    constructor Create(AOwner:TComponent);virtual;
    destructor Destroy;override;
  end;

type
  TPlayPosition=record
    Current:int64;
    Stop:int64;
  end;

type
  PSample = ^TSample;
  TSample = record
    Buf:Pointer;
    Len:Int64;
    Pos:Int64;
  end;

type
  TAudioMix = class(TComponent)
  private
    FFilterGraph:IGraphBuilder;
    FMediaControl:IMediaControl;
    FMediaEvent:IMediaEventEx;
    FMediaSeek:IMediaSeeking;

    FHandle: HWND;
    FControl: TWinControl;

    FSampList:TList;

    CB: TSampleGrabberCB;

    FSrcFilename: string;
    FDstFilename: string;

    buf:array of SmallInt; //Буффер для WAVE данных

    procedure SetHandle(const Value: HWND);

    function GetDuration: int64;
    function GetPosition: TPlayPosition;
    procedure SetPosition(const Value: TPlayPosition);

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
    constructor Create(AOwner:TComponent);override;
    destructor Destroy;override;

    procedure BuildFilterGraph(Play:Boolean);
    procedure RemoveAllFilters;

    procedure AddSample(_buf:Pointer; _len:Int64; _pos:Int64);
    procedure DeleteSample(ind:Integer);
    procedure ClearList;

    procedure Run;
    procedure Play;
    procedure Stop;
    procedure Pause;
    procedure Rewind;
    procedure Convert;

    function GetPos:Double;
  published
    property Handle:HWND read FHandle write SetHandle;

    property GraphObj:IGraphBuilder read FFilterGraph;
    property ControlObj:IMediaControl read FMediaControl;
    property EventObj:IMediaEventEx read FMediaEvent;
    property SeekObj:IMediaSeeking read FMediaSeek;

    property Position:TPlayPosition read GetPosition write SetPosition;
    property Duration:int64 read GetDuration;

    property SrcFilename:string read FSrcFilename write FSrcFilename;
    property DstFilename:string read FDstFilename write FDstFilename;
  end;

//Заголовок WAV файла
type
  TWaveHeader = record
    ident1: array[0..3] of Char; // Must be "RIFF"
    len: DWORD; // Remaining length after this header
    ident2: array[0..3] of Char; // Must be "WAVE"
    ident3: array[0..3] of Char; // Must be "fmt "
    reserv: DWORD; // Reserved 4 bytes
    wFormatTag: Word; // format type
    nChannels: Word; // number of channels (i.e. mono, stereo, etc.)
    nSamplesPerSec: DWORD; //sample rate
    nAvgBytesPerSec: DWORD; //for buffer estimation
    nBlockAlign: Word; //block size of data
    wBitsPerSample: Word; //number of bits per sample of mono data
    cbSize: Word; //the count in bytes of the size of
    ident4: array[0..3] of Char; //Must be "data"
    //ident5: array[0..3] of Char;
    //ident6: array[0..3] of Char;
    //ident7: array[0..3] of Char;
  end;

function GetWAVEDataSize(FileName:AnsiString):Integer;
function ReadWAVE(FileName:AnsiString; var buf:array of SmallInt):Boolean;

procedure Register;

implementation

uses ActiveX;

//------------------------------------------------------------------------------
function GetWAVEDataSize(FileName:AnsiString):Integer;
var
  strm:TFileStream;
  head:TWaveHeader;

begin
  strm:=TFileStream.Create(FileName, fmOpenRead);
  strm.Read(head, SizeOf(head));

  if (not (head.ident1 = 'RIFF') or
      not (head.ident2 = 'WAVE') or
      not (head.ident3 = 'fmt ')    ) then
  begin
    Result:=0;
    exit
  end;

  Result:=strm.Size-Strm.Position;
  strm.Destroy
end;
//------------------------------------------------------------------------------
function ReadWAVE(FileName:AnsiString; var buf:array of SmallInt):Boolean;
var
  strm:TFileStream;
  head:TWaveHeader;
  sum:Double;
  i,avg,cnt:LongInt;
begin
  strm:=TFileStream.Create(FileName, fmOpenRead);
  strm.Read(head, SizeOf(head));

  if (not (head.ident1 = 'RIFF') or
      not (head.ident2 = 'WAVE') or
      not (head.ident3 = 'fmt ')    ) then
  begin
    Result:=true;
    exit
  end;

  strm.Read(buf[0], Length(buf));
  strm.Destroy;

  sum:=0; cnt:=0;
  for i:=0 to 10000 do
   if Abs(buf[i]) < 1000 then
    begin
     sum:=sum+buf[i];
     Inc(cnt)
    end;
  avg:=Round(sum/cnt);

  for i:=0 to Length(buf) div 2 do buf[i]:=buf[i]-avg;
  Result:=false;
end;
//------------------------------------------------------------------------------
function SetPlayPosition(const curr,stop:int64):TPlayPosition;
begin
  result.Current:=curr;
  result.Stop:=stop;
end;
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
begin
  Pos:=0;
  inherited Create(Owner);
end;
//------------------------------------------------------------------------------
destructor TSampleGrabberCB.Destroy;
begin
end;
//------------------------------------------------------------------------------
function TSampleGrabberCB.SampleCB(SampleTime: Double; pSample: IMediaSample): HResult; stdcall;
begin
  Result:=0
end;
//------------------------------------------------------------------------------
function TSampleGrabberCB.BufferCB(SampleTime: Double; pBuffer: PByte; BufferLen: longint): HResult; stdcall;
begin
  if pBuffer = nil then
   begin
    Result:=E_POINTER;
    exit
   end;

  Pos:=SampleTime;
end;
//------------------------------------------------------------------------------
//--------------------------------- TAudioMix ----------------------------------
//------------------------------------------------------------------------------
constructor TAudioMix.Create(AOwner:TComponent);
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

  FSampList:=TList.Create;
end;
//------------------------------------------------------------------------------
destructor TAudioMix.Destroy;
var
 i:Integer;
begin
  RemoveAllFilters;

  FFilterGraph:=nil;
  FMediaControl:=nil;
  FMediaEvent:=nil;
  FMediaSeek:=nil;

  if FSampList <> nil then
    begin
      for i:=0 to FSampList.Count-1 do FreeMem(FSampList.Items[i]);
      FSampList.Destroy;
    end;

  inherited;
end;
//------------------------------------------------------------------------------
function TAudioMix.GetPos:Double;
begin
  if CB <> nil then Result:=CB.Pos
  else Result:=0;
end;
//------------------------------------------------------------------------------
procedure TAudioMix.Run;
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
procedure TAudioMix.Stop;
begin
  FMediaControl.Stop;
end;
//------------------------------------------------------------------------------
procedure TAudioMix.Pause;
begin
  FMediaControl.Pause;
end;
//------------------------------------------------------------------------------
procedure TAudioMix.SetHandle(const Value: HWND);
begin
  if FHandle<>Value then
  begin
    FHandle := Value;
    SetWindow(FHandle);
  end;
end;
//------------------------------------------------------------------------------
procedure TAudioMix.SetWindow(const aHAndle: HWND);
begin
  SetNotifyWindow(AHandle);
end;
//------------------------------------------------------------------------------
procedure TAudioMix.SetNotifyWindow(const ahandle: HWND);
begin
  FMediaEvent.SetNotifyWindow(aHandle,WM_MMNOTIFY,integer(self));
end;
//------------------------------------------------------------------------------
function TAudioMix.GetDuration: int64;
begin
  if FMediaSeek <> nil then FMediaSeek.GetDuration(result)
  else result:=0
end;
//------------------------------------------------------------------------------
function TAudioMix.GetPosition: TPlayPosition;
begin
  if FMediaSeek <> nil then FMediaSeek.GetPositions(result.current, result.Stop)
  else begin result.current:=0; result.Stop:=0 end
end;
//------------------------------------------------------------------------------
procedure TAudioMix.SetPosition(const Value: TPlayPosition);
var
  apos:TPlayPosition;
begin
  if FMediaSeek = nil then exit;
  
  apos:=value;
  FMediaSeek.SetPositions(aPos.Current,
                 AM_SEEKING_AbsolutePositioning,
                 aPos.Stop,
                 AM_SEEKING_AbsolutePositioning);
end;
//------------------------------------------------------------------------------
procedure TAudioMix.Rewind;
begin
  SetPosition(SetPlayPosition(0,GetDuration));
end;
//------------------------------------------------------------------------------
procedure TAudioMix.Convert;
begin
  BuildFilterGraph(False);
  Run
end;
//------------------------------------------------------------------------------
procedure TAudioMix.Play;
begin
  BuildFilterGraph(True);
  Run
end;
//------------------------------------------------------------------------------
procedure TAudioMix.RemoveAllFilters;
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
function TAudioMix.GetPin(aFilter: IBaseFilter; const PinDir: TPinDirection;
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
function TAudioMix.ConnectFilter(OutFilter, InFilter: IBaseFilter): HResult;
var outpin,inPin:IPin;
begin
  outPin:=GetPin(OutFilter,PINDIR_OUTPUT,0);
  inPin:=GetPin(InFilter,PINDIR_INPUT,0);
  result:=FFilterGraph.Connect(outPin,inPin);
end;
//------------------------------------------------------------------------------
function TAudioMix.AddFilterByCLSID(clsid: TGUID; const name: string):IBaseFilter;
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
function TAudioMix.FindFilterByFriendlyName(const classid:TGUID; const friendlyname: string): IBaseFilter;
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
procedure TAudioMix.AddSample(_buf:Pointer; _len:Int64; _pos:Int64);
var
 Samp:PSample;
begin
  New(Samp);
  Samp.Buf:=_buf;
  Samp.Len:=_len;
  Samp.Pos:=_pos;

  FSampList.Add(Samp)
end;
//------------------------------------------------------------------------------
procedure TAudioMix.DeleteSample(ind:Integer);
begin
  if ind < FSampList.Count then
    begin
      FreeMem(FSampList.Items[ind]);
      FSampList.Delete(ind);
    end;
end;
//------------------------------------------------------------------------------
procedure TAudioMix.ClearList;
var
 i:Integer;
begin
  for i:=0 to FSampList.Count - 1 do FreeMem(FSampList.Items[i]);
  FSampList.Clear;
end;
//------------------------------------------------------------------------------
procedure TAudioMix.BuildFilterGraph(Play: Boolean);
var
  pFileSink:IFileSinkFilter;
  pFileSource:IFileSourceFilter;

  afileReader, aMPEG1Splitter, aWaveDest,
  aMPEGLayer3, aFileWriter, aSampleGrabber,
  aMPEGLayer3enc, aAudioRender, aDSoundRender: IBaseFilter;

  aGrabber:ISampleGrabber;

  aMixFilters:array of IBaseFilter;
  aSetupMixFilter:ISetupMixFilter;

  aSrcFilename, aDestFilename:widestring;

  hr:HResult;

//-----------------------------
  enum:IEnumPins;
  pin:IPin;
  pinDirection:TPinDirection;
  tot_fetched_pin:cardinal;

  streamConfig:IAMStreamConfig;
  am:_AMMediaType;
  wfx:^TWaveFormatEx;

  r,i:LongInt;
  len,dur:Int64;
  Samp:TSample;

begin
  if (FFilterGraph<>nil) then
  begin
    //add file reader filter
    afileReader:=AddFilterByCLSID(CLSID_AsyncReader,'File Reader');
    //add MPEG-1 Stream Splitter filter
    aMPEG1Splitter:=AddFilterByCLSID(CLSID_MPEG1Splitter,'MPEG-1 Stream Splitter');
    //Add MPEG Layer 3 Decoder
    aMPEGLayer3:=AddFilterByCLSID(CLSID_MPEGLayer3Decoder,'MPEG Layer-3 Decoder');
    //add Sample Grabber filter
    aSampleGrabber:=AddFilterByCLSID(CLSID_SampleGrabber,'Sample Grabber');

    if Play then
      begin
        //add Audio Render filter
        //aAudioRender:=AddFilterByCLSID(CLSID_AudioRender,'Audio Render');
        aDSoundRender:=AddFilterByCLSID(CLSID_DSoundRender,'Direct Sound Render');
      end
    else
      begin
        //Add MPEG Layer 3 Encoder
        aMPEGLayer3enc:=AddFilterByCLSID(CLSID_LameMPG3AE, 'LAME Audio Encoder');
        //add Wave Dest filter
        awaveDest:=AddFilterByCLSID(CLSID_WaveDest,'Wave Dest');
        //add file writer filter
        afileWriter:=AddFilterByCLSID(CLSID_FileWriter,'File Writer');
      end;


    //add Mix Filters
    SetLength(aMixFilters, FSampList.Count);
    for i:=0 to FSampList.Count-1 do
     aMixFilters[i]:=AddFilterByCLSID(CLSID_MixFilter,'Mix Filter '+IntToStr(i));

    if (afileReader<>nil) and
       (aMPEG1Splitter<>nil) and
       (aMPEGLayer3<>nil) and
       //(aMPEGLayer3enc<>nil) and
       (aSampleGrabber<>nil) {and
       (aWaveDest<>nil) and
       (aFileWriter<>nil)} then
    begin
      //ambil instance IFileSourceFilter
      afileReader.QueryInterface(IID_IFileSourceFilter,pFileSource);
      if pFileSource<>nil then
      begin
        aSrcFilename:=FSrcFilename;
        pFileSource.Load(PWideChar(aSrcFilename),nil);
      end;

      //connect output pin file reader ke
      //input pin MPEG-1 Splitter
      hr:=ConnectFilter(aFileReader,aMPEG1Splitter);
      if hr<>S_OK then
        RaiseDirectShowException(hr,'Koneksi File Reader ke MPEG-1 Splitter gagal. ');

      //connect output MPEG-1 Splitter ke
      //input pin MPEG Layer 3 Decoder
      hr:=ConnectFilter(aMPEG1Splitter, aMPEGLayer3);
      if hr<>S_OK then
        RaiseDirectShowException(hr,'Koneksi MPEG-1 Splitter ke MPEG Layer 3 gagal. ');

      //Цепочка фильтров для наложения звуковых семплов
      for i:=0 to FSampList.Count-1 do
        begin
          aMixFilters[i].QueryInterface(IID_ISetupMixFilter, aSetupMixFilter);
          Samp:=PSample(FSampList.Items[i])^;
          aSetupMixFilter.SetMixBuffer(Samp.Buf, Samp.Len, Samp.Pos);

          if i = 0 then hr:=ConnectFilter(aMPEGLayer3, aMixFilters[0])
          else hr:=ConnectFilter(aMixFilters[i-1], aMixFilters[i]);

          if hr<>S_OK then
            RaiseDirectShowException(hr,'Не могу подключить Mix-фильтр.');
        end;

      hr:=ConnectFilter(aMixFilters[FSampList.Count-1], aSampleGrabber);
      if hr<>S_OK then
        RaiseDirectShowException(hr,'Не могу подключить MPEG3 decoder к Sample Grabber.');

      if Play then
        begin
          hr:=ConnectFilter(aSampleGrabber, aDSoundRender);
          if hr<>S_OK then
            RaiseDirectShowException(hr,'Не могу подключить aAudioRender');
        end
      else
        begin
          hr:=ConnectFilter(aSampleGrabber, aMPEGLayer3enc);
          if hr<>S_OK then
            RaiseDirectShowException(hr,'Не могу подключить aMixFilter');

          hr:=ConnectFilter({aSampleGrabber}aMPEGLayer3enc, aWaveDest);
          if hr<>S_OK then
            RaiseDirectShowException(hr,'Не могу подключить aMixFilter');

          //ambil instance IFileSinkFilter
          afileWriter.QueryInterface(IID_IFileSinkFilter,pFileSink);
          if pFileSink<>nil then
            begin
              aDestFilename:=FDstFilename;
              pFileSink.SetFileName(PWideChar(aDestFilename),nil);
            end;

          //Без фильтра WaveDest всё почему-то работает с декодером LAME
          //connect output wave Dest ke
          //input pin FileWriter
          hr:=ConnectFilter(aWaveDest, aFileWriter);
          if hr<>S_OK then
            RaiseDirectShowException(hr,'Koneksi Wave Dest ke File Writer gagal. ');
        end;

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
      hr := aGrabber.SetCallback( CB, 1 );
      if hr<>S_OK then
        RaiseDirectShowException(hr,'Error with SampleGrabber');

      aMPEGLayer3.EnumPins(enum);
      if enum<>nil then
        while enum.Next(1,pin,@tot_fetched_pin)=S_OK do
          begin
            pin.QueryDirection(pinDirection);
            if pinDirection=PINDIR_OUTPUT then
              hr:=pin.QueryInterface(IID_IMediaSeeking, FMediaSeek);
          end;
      hr:=FMediaSeek.GetDuration(dur);
      if hr<>S_OK then
        RaiseDirectShowException(hr,'Не могу получить интерфейс MediaSeek.');

    end;

  end;
end;

//------------------------------------------------------------------------------

procedure Register;
begin
  RegisterComponents('Samples', [TAudioMix]);
end;

end.
