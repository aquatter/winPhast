unit VideoStream;

interface
uses Windows, Dialogs, Classes, SysUtils, Controls, VideoScan, Utype, Crude, t666;

type
  TVideoStreamMode = (vsmVideo, vsmCapture);
  TVideoThreadFunction = function: boolean of object;
  TVideoStream = class
  private
  public
    run: boolean;
    m_ShowErrMes, m_IsInit: boolean;
    m_syncMode: UINT;
    err_list: PVS_LIST;
    err: VS_ERROR_DATA;
    ID: Word;
    CInterfaceTransferControl, CInterfaceAmplify, CInterfaceExpos, CInterfaceSync,
    InputControlInterface, InDInterface, sys_id, SizeX, SizeY: UINT;
    OutDInterface: UINT;
    pDataHeader: PVSLIB3_DATAHEADER;
    procedure InitVsLib3;
    procedure SetAmplify(val: integer);
    procedure GetAmplify(var val: integer);
    procedure SetExpos(val: integer; _unit: UINT);
    function ProcessLastError: boolean;
    function GetImageSizeX: UINT;
    function GetImageSizeY: UINT;
    procedure SetSyncMode(mode: UINT);
    constructor Create;
    destructor Destroy; override;
  end;

  TVideoThread = class(TThread)
  public
  procedure Init(_InDInterface, _InputControlInterface, _CInterfaceSync, _SizeX, _SizeY: UINT);
  private
    err: VS_ERROR_DATA;
//    err_list: PVS_LIST;
    InDInterface: UINT;
    SizeX, SizeY: UINT;
    InputControlInterface: UINT;
    CInterfaceSync: UINT;
  protected
    procedure Execute; override;
    procedure Draw;
  published
  public
    ProcessLastError: TVideoThreadFunction;
  published
  end;

  TVideoCaptuteThread = class(TThread)
  public

  procedure Init(_InDInterface, _InputControlInterface, _CInterfaceSync, _SizeX, _SizeY: UINT);
  private
    err: VS_ERROR_DATA;
 //   err_list: PVS_LIST;
    InDInterface: UINT;
    SizeX, SizeY: UINT;
    InputControlInterface: UINT;
    CInterfaceSync: UINT;
    step: integer;
  protected
    procedure Execute; override;
    procedure Draw;
  published
  public
    ProcessLastError: TVideoThreadFunction;
  published
  end;


//function ProcessLastError(err: VS_ERROR_DATA; m_ShowErrMes: boolean = true): boolean;

implementation

uses unit1, unit9, unit10, UPhast2Vars;
{ TVideoStream }

constructor TVideoStream.Create;
begin
  m_ShowErrMes:= true;
  m_IsInit:= false;
  m_SyncMode:=VSLIB3_ENUM_ID_SOFT_SYNC;
  InitVsLib3;
  run:=false;
end;

destructor TVideoStream.Destroy;
begin
 //Уничтожаем созданную систему
 VsLib3SystemDestroy(sys_id, Addr(err));
 ProcessLastError;
 //Закрытие библиотеки
 VsLib3Exit(Addr(err));
 ProcessLastError;
 inherited Destroy;
end;

{function ProcessLastError(err: VS_ERROR_DATA; m_ShowErrMes: boolean = true): boolean;
var s: PChar;
    err_list: PVS_LIST;
begin
  GetMem(s, 128);
  err_list:= VsLib3ListGetStdList(VSLIB3_STDLIST_ERROR_SHORT_NAME);
  Result:= true;
  if err.Id <> 0 then
  begin
    VsLib3ErrorSPrintf(s, 255, '%t: %m. ', Addr(err), err_list);
    if m_ShowErrMes then
      ShowMessage(s);
    err.Id:=0;
    Result:= False;
  end;
  FreeMem(s, 128);
end;}

procedure TVideoStream.GetAmplify(var val: integer);
var _unit: integer;
begin
   _unit:=0;
   VsLib3OptionGetScalar(CInterfaceAmplify, val, _unit, Addr(err));
   ProcessLastError;
end;

function TVideoStream.GetImageSizeX: UINT;
var SizeX: UINT;
begin
  VsLib3DataheaderGetU32(pDataHeader, VSLIB3_DATAHEADER_FIELD_SIZE_X, Addr(SizeX), Addr(err));
  Result:=SizeX;
end;

function TVideoStream.GetImageSizeY: UINT;
var SizeY: UINT;
begin
  VsLib3DataheaderGetU32(pDataHeader, VSLIB3_DATAHEADER_FIELD_SIZE_Y, Addr(SizeY), Addr(err));
  Result:=SizeY;
end;

procedure TVideoStream.InitVsLib3;
begin
  VsLib3Init(Addr(err));                                                              //Инициализируем библиотеку
  if not ProcessLastError then exit;


  VsLib3SystemCreate(VSLIB3_SYSTEM_TYPE_VS_USB_CAMERA, sys_id,  err);                 //Создаем систему для USB-камеры
  if not ProcessLastError then exit;
  VsLib3SystemInit(sys_id, err);                                                       //Инициализируем созданную систему
  err.Id:=0;
  VsLib3SystemGetCInterface(sys_id, VSLIB3_CINTERFACE_TRANSFER_CONTROL, 0, CInterfaceTransferControl, err);  //Получаем CInterface
  if not ProcessLastError then exit;
  VsLib3SystemGetCInterface(sys_id, VSLIB3_CINTERFACE_OPTION_AMPLIFY, 0, CInterfaceAmplify, err);  //Получаем CInterface для настройки усиления
  if not ProcessLastError then exit;
  SetAmplify(1); //устанавливаем стандартное усиление
  VsLib3SystemGetCInterface(sys_id, VSLIB3_CINTERFACE_OPTION_EXPOS, 0, CInterfaceExpos, err);  //Получаем CInterface для настройки экспозиции
  if not ProcessLastError then exit;
  SetExpos(125, VSLIB3_SCALAR_UNIT_MS);//устанавливаем стандартную экспозицию 120мс
  VsLib3SystemGetCInterface(sys_id, VSLIB3_CINTERFACE_OPTION_SYNC_BEGIN, 0, CInterfaceSync, err); //получаем интерфейс для установки режима синхронизации (внутренний/програмный/внешний)
  if not ProcessLastError then exit;
  VsLib3SystemGetCInterface(sys_id, VSLIB3_CINTERFACE_INPUT_CONTROL, 0, InputControlInterface, err); //получаем интерфейс для управления программной синхронизацией
  if not ProcessLastError then exit;
  VsLib3OptionSetEnumVal(CInterfaceSync,VSLIB3_ENUM_ID_INTERNAL_SYNC , Addr(err));  //установка режима внутренней синхронизации
  if not ProcessLastError then exit;
  m_syncMode:=VSLIB3_ENUM_ID_INTERNAL_SYNC;
  VsLib3SystemGetInDInterface(sys_id, VSLIB3_DPORT_ININTERFACE0, 0, Addr(InDInterface), Addr(err)); //Получаем DInterface (выходной)
  if not ProcessLastError then exit;

//  VsLib3DPortOutGetDInterface(sys_id, VSLIB3_DPORT_ININTERFACE0, OutDInterface, err);
//  if not ProcessLastError then exit;
  VsLib3SystemGetOutDInterface(sys_id, VSLIB3_DPORT_OUTINTERFACE0, 0, OutDInterface, err);

  //Определяем тип данных для InDInterface
  VsLib3DataheaderCreate(Addr(pDataHeader), Addr(err));
  VsLib3InDInterfaceGetType(InDInterface, pDataHeader, Addr(err));
  if not ProcessLastError then exit;

  SizeX:=GetImageSizeX;
  SizeY:=GetImageSizeY;

  m_IsInit:=true;
end;

function TVideoStream.ProcessLastError: boolean;
var s: PChar;
begin
  GetMem(s, 128);
  err_list:= VsLib3ListGetStdList(VSLIB3_STDLIST_ERROR_SHORT_NAME);
  Result:= true;
  if err.Id <> 0 then
  begin
    VsLib3ErrorSPrintf(s, 255, '%t: %m. ', Addr(err), err_list);
    if m_ShowErrMes then
      ShowMessage('Ошибка подключения видеокамеры'+#13#10+s);
    err.Id:=0;
    Result:= False;
  end;
  FreeMem(s, 128);
end;

procedure TVideoStream.SetAmplify(val: integer);
var
  min, max: integer;
  _unit: UINT;
begin
  if not m_IsInit then exit;
  _unit:=0;
  VsLib3OptionGetScalarRange(CInterfaceAmplify, Addr(min), Addr(max), _unit, Addr(err));
  ProcessLastError;
  if (val < max) then
    VsLib3OptionSetScalar(CInterfaceAmplify, val, _unit, Addr(err));
  ProcessLastError;
end;

procedure TVideoStream.SetExpos(val: integer; _unit: UINT);
begin
 if not m_IsInit then exit;
 VsLib3OptionSetScalar(CInterfaceExpos, val, _unit, Addr(err));
 ProcessLastError;
end;

procedure TVideoStream.SetSyncMode(mode: UINT);
//var ReadySize: UINT;
begin
  VsLib3OptionSetEnumVal(CInterfaceSync, mode, @err);  //устанавливаем режим синхронизации видеокамеры
  if not ProcessLastError then exit;
  {
  VsLib3InDInterfaceQueryReady(InDInterface, @ReadySize, @err);
  if ReadySize <> 0 then
    VsLib3CallCInterface_0(CInterfaceTransferControl, VSLIB3_FUNC_TRANSFER_CLEAR, @err);
  if not ProcessLastError then exit;}
end;

{ TVideoThread }

procedure TVideoThread.Init(_InDInterface, _InputControlInterface, _CInterfaceSync, _SizeX, _SizeY: UINT);
begin
  SizeX:=_SizeX;
  SizeY:=_SizeY;
  InDInterface:=_InDInterface;
  InputControlInterface:=_InputControlInterface;
  CInterfaceSync:=_CInterfaceSync;
end;

procedure TVideoThread.Draw;
var shift: TShiftState;
begin
  with form1 do pnl.DrawImage(int, int);
  form9.UpdateHist;
  form1.PnlMouseDown(form1, mbLeft, shift, 0, 0);
  if Terminated then
    int.Clear;
end;

procedure TVideoThread.Execute;
var ReadySize, TransferSize: VS_SIZE_T;
begin
  FreeOnTerminate:=True;
  ReturnValue:=1;
  form1.vs.run:=true;
  VsLib3OptionSetEnumVal(CInterfaceSync, VSLIB3_ENUM_ID_INTERNAL_SYNC, @err);
  while true do            
   begin
     err.Id:=0;
     ReadySize:=0;
     VsLib3InDInterfaceQueryReady(InDInterface, @ReadySize, @err);
     if not ProcessLastError then
     begin
       ReturnValue:=0;
       break;
     end;

     Sleep(1);
     if ReadySize = 0 then Continue;

     VsLib3InDInterfaceBeginBlock(InDInterface, @err);
     if not ProcessLastError then break;
     VsLib3InDInterfacePIOTransfer(InDInterface, int.b, SizeX*SizeY, @TransferSize, @err);
     if not ProcessLastError then break;
     VsLib3InDInterfaceEndBlock(InDInterface, @err);
     if not ProcessLastError then break;
     Synchronize(Draw);
     if Terminated then break;
   end;

end;

{function TVideoThread.ProcessLastError: boolean;
var s: PChar;
begin
  GetMem(s, 128);
  err_list:= VsLib3ListGetStdList(VSLIB3_STDLIST_ERROR_SHORT_NAME);
  Result:= true;
  if err.Id <> 0 then
  begin
    VsLib3ErrorSPrintf(s, 255, '%t: %m. ', Addr(err), err_list);
    ShowMessage(s);
    err.Id:=0;
    Result:= False;
  end;
  FreeMem(s, 128);
end;}

{ TVideoCaptuteThread }

procedure TVideoCaptuteThread.Draw;
begin
  with form1 do
  begin
    pnl.DrawImage(int, int);
    pnl.bitmap.SaveToFile(cfg.img_path+'\cadr_i1_s'+IntToStr(step)+'_c1.bmp');
    form10.ProgressBar1.Position:=step;
    if step = cfg.steps then
    begin
      form10.Close;
      form10.ProgressBar1.Position:=0;
      InitialiseArrays;
      form1.vs.run:=false;

    end;
  end;
end;

procedure TVideoCaptuteThread.Execute;
var ReadySize, TransferSize: VS_SIZE_T;
    i: integer;
begin
  with form1 do
  begin
    repeat
      sleep(1);
    until  not int.loaded;

    if not int.loaded then
    begin
      int.Init(vs.SizeY, vs.SizeX, varByte);
      int.ColorScale:=noScale;
    end;
    vs.run:=true;
    VsLib3OptionSetEnumVal(CInterfaceSync, VSLIB3_ENUM_ID_SOFT_SYNC, @err);
    for i:=0 to cfg.steps-1 do
    begin
      MoveMirror(cfg.port, round(i*cfg.m_shift/(cfg.steps-1)));
      sleep(20);
      err.Id:=0;
      ReadySize:=0;

      VsLib3CallCInterface_0(InputControlInterface, VSLIB3_FUNC_SOFT_START, @err);

      if not ProcessLastError then exit;
      while true do
      begin
        sleep(1);
        VsLib3InDInterfaceQueryReady(InDInterface, @ReadySize, @err);
        if not ProcessLastError then exit;
        if ReadySize <> 0 then
         begin
          err.Id:=0;
          Break;
         end;
        if Terminated then break;
      end;
      VsLib3InDInterfaceBeginBlock(InDInterface, @err);
      if not ProcessLastError then exit;
      VsLib3InDInterfacePIOTransfer(InDInterface, int.b, SizeX*SizeY, @TransferSize, @err);
      if not ProcessLastError then exit;
      VsLib3InDInterfaceEndBlock(InDInterface, @err);
      if not ProcessLastError then exit;
      step:=i+1;
      Synchronize(Draw);
    end;
  end;
end;

procedure TVideoCaptuteThread.Init(_InDInterface, _InputControlInterface,
  _CInterfaceSync, _SizeX, _SizeY: UINT);
begin
  SizeX:=_SizeX;
  SizeY:=_SizeY;
  InDInterface:=_InDInterface;
  InputControlInterface:=_InputControlInterface;
  CInterfaceSync:=_CInterfaceSync;
end;

end.
