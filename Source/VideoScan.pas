unit VideoScan;

interface

uses
  Windows, Messages, SysUtils;

const
   vs = 'vslib3.dll';

   VSLIB3_SYSTEM_TYPE_VS2001_CTT =                     $00000000;
   VSLIB3_SYSTEM_TYPE_VS2001_ADC =                     $00000001;
   VSLIB3_SYSTEM_TYPE_VS2001_CTT_COLOR_CAN =           $00000002;
   VSLIB3_SYSTEM_TYPE_VSFAST_V1 =                      $00000003;
   VSLIB3_SYSTEM_TYPE_VS2001_CTT_STREAM_ARIFMETIC_DAC= $00000004;
   VSLIB3_SYSTEM_TYPE_VS2001_CTT_COLOR =               $00000005;
   VSLIB3_SYSTEM_TYPE_VS2001_CTT_DAC =                 $00000006;
   VSLIB3_SYSTEM_TYPE_RENG_MULTICAM =                  $00000007;
   VSLIB3_SYSTEM_TYPE_VS2001_ILX =                     $00000008;
   VSLIB3_SYSTEM_TYPE_VS_USB_CAMERA =                  $00000009;
   VSLIB3_SYSTEM_TYPE_VS2001_CTT_VGA =                 $0000000A;
   VSLIB3_DATAHEADER_FIELD_PIXEL_BITS =                $0000000B;


   VSLIB3_STDLIST_ERROR_SHORT_NAME            = 1;
   VSLIB3_STDLIST_OPTION_SHORT_NAME           = 2;
   VSLIB3_STDLIST_UNIT_SHORT_NAME             = 3;
   VSLIB3_STDLIST_ENUM_VAL_SHORT_NAME         = 4;
   VSLIB3_STDLIST_STATUS_VAL_SHORT_NAME       = 5;
   VSLIB3_STDLIST_ADDON_ATTRIBUTE_SHORT_NAME  = 7;
   VSLIB3_STDLIST_DATA_TYPE_SHORT_NAME        = 8;
   VSLIB3_STDLIST_DATA_TYPE_FILD_SHORT_NAME   = 9;
   VSLIB3_STDLIST_SYSTEM_NAME                 = 10;
   VSLIB3_STDLIST_SYSTEM_PARAMETER            = 11;
   VSLIB3_STDLIST_INFO_SHORT_NAME             = 12;

   VSLIB3_SCALAR_UNIT_RAW           = 0;
   VSLIB3_SCALAR_UNIT_NS            = 1;
   VSLIB3_SCALAR_UNIT_US            = 2;
   VSLIB3_SCALAR_UNIT_MS            = 3;
   VSLIB3_SCALAR_UNIT_S             = 4;
   VSLIB3_SCALAR_UNIT_LINE          = 5;
   VSLIB3_SCALAR_UNIT_FRAME         = 6;
   VSLIB3_SCALAR_UNIT_HZ            = 7;
   VSLIB3_SCALAR_UNIT_CELSIUS       = 8;
   VSLIB3_SCALAR_UNIT_CELSIUS_D10   = 9;
   VSLIB3_SCALAR_UNIT_CELSIUS_D100  = 10;
   VSLIB3_SCALAR_UNIT_CELSIUS_D1000 = 11;
   VSLIB3_SCALAR_UNIT_V             = 12;
   VSLIB3_SCALAR_UNIT_MV            = 13;
   VSLIB3_SCALAR_UNIT_UV            = 14;
   VSLIB3_SCALAR_UNIT_KV            = 15;
   VSLIB3_SCALAR_UNIT_DB            = 16;
   VSLIB3_SCALAR_UNIT_PERCENT       = 17;
   VSLIB3_SCALAR_UNIT_MUL           = 18;
   VSLIB3_SCALAR_UNIT_MUL_D10       = 22;
   VSLIB3_SCALAR_UNIT_MUL_D100      = 23;
   VSLIB3_SCALAR_UNIT_BLOCK         = 24;
   VSLIB3_SCALAR_UNIT_WORD          = 25;
   VSLIB3_SCALAR_UNIT_BIT           = 26;
   VSLIB3_SCALAR_UNIT_CHANEL        = 27;
   VSLIB3_SCALAR_UNIT_PERCENT_D10   = 28;
   VSLIB3_SCALAR_UNIT_PERCENT_D100  = 29;
   VSLIB3_SCALAR_UNIT_PIXEL         = 30;


   VSLIB3_PORT_CLASS_INTERFACE = $C0000000;
   VSLIB3_CPORT_SUBCLASS_COMMAND = $00300000;
   VSLIB3_CPORT_SUBCLASS_OPTIONS = $00400000;
   VSLIB3_CINTERFACE_TRANSFER_CONTROL =  VSLIB3_PORT_CLASS_INTERFACE or VSLIB3_CPORT_SUBCLASS_COMMAND or 3;

   //для настройки параметров камеры
   VSLIB3_CINTERFACE_OPTION_AMPLIFY = VSLIB3_CPORT_SUBCLASS_OPTIONS or 10;
   VSLIB3_CINTERFACE_OPTION_EXPOS = VSLIB3_CPORT_SUBCLASS_OPTIONS or 2;
   VSLIB3_CINTERFACE_OPTION_SYNC_BEGIN =  VSLIB3_CPORT_SUBCLASS_OPTIONS or 4;
   VSLIB3_CINTERFACE_OPTION_GAMMA = VSLIB3_CPORT_SUBCLASS_OPTIONS or 36;

   //для синхронизации (программной и внутренней)
   VSLIB3_CINTERFACE_INPUT_CONTROL = VSLIB3_PORT_CLASS_INTERFACE or VSLIB3_CPORT_SUBCLASS_COMMAND or 2;
   VSLIB3_ENUM_ID_SOFT_SYNC        =  4;
   VSLIB3_ENUM_ID_EXTERNAL_SYNC    =  5;
   VSLIB3_ENUM_ID_INTERNAL_SYNC    =  6;

   VSLIB3_DPORT_ININTERFACE0 = VSLIB3_PORT_CLASS_INTERFACE or 0;
   VSLIB3_DPORT_OUTINTERFACE0 = VSLIB3_PORT_CLASS_INTERFACE or 0;
   VSLIB3_DATAHEADER_FIELD_SIZE_X = $0004;
   VSLIB3_DATAHEADER_FIELD_SIZE_Y = $0005;
   VSLIB3_CPORT_FUNC_CLASS_INPUT_COMMAND = $A0000000;
   VSLIB3_CPORT_FUNC_CLASS_TRANSFER_COMMAND = $B0000000;
   VSLIB3_FUNC_SOFT_START = VSLIB3_CPORT_FUNC_CLASS_INPUT_COMMAND or 101;
   VSLIB3_FUNC_TRANSFER_CLEAR = VSLIB3_CPORT_FUNC_CLASS_TRANSFER_COMMAND or 3;


type
  VS_SIZE_T = INT64;
  PVS_SIZE_T = ^VS_SIZE_T;

  VS_ERROR_DATA = record
    Id: integer;
    Line: UINT;
    ObjId: UINT;
    ObjFile: PChar;
    _File: PChar;
    Date: PChar;
    Remark: PChar;
  end;

  PVS_ERROR_DATA = ^VS_ERROR_DATA;



  VSLIB3_DATA_ATTRIBUTE_VS_LINK_FRAME = record
    Format: UINT;
    BitPacker: UINT;
    PixelBits: UINT;
    SizeX: UINT;
    SizeY: UINT;
    HeaderSize: UINT;
    Interlace: UINT;
  end;

  VSLIB3_DATA_ATTRIBUTE_GATED_OPTIC = record
    SyncSource: UINT;
    SyncPeriodA,SyncPeriodB: UINT;
    MinSyncPeriodA,MinSyncPeriodB: UINT;
    SyncDelayA,SyncDelayB: UINT;
    GlowTimeA,GlowTimeB: UINT;
  end;

  VSLIB3_DATA_ATTRIBUTE_STREAM_MULTIFRAME = record
    FromBit: VS_SIZE_T;
    BlockStepBit: UINT;
    PixelBits: UINT;
    StreamBitsShift: array[0..31] of word;
    SizeX,SizeY: UINT;
  end;


  VSLIB3_DATA_ATTRIBUTE_STREAM_VSFAST = record
    TotalBlocks: UINT;
    Format: UINT;
    PackType: UINT;
    SizeX,SizeY: UINT;
  end;

  VSLIB3_DATA_ATTRIBUTE_STREAM_LINE = record
    Format: UINT;
    BitPacker: UINT;
    PixelBits: UINT;
    LineSize: UINT;
    BlockLines: UINT;
  end;

  VSLIB3_DATA_ATTRIBUTE_STREAM_FRAME  = record
    Format: UINT;
    BitPacker: UINT;
    PixelBits: UINT;

    SizeX: UINT;
    SizeY: UINT;
    OriginX: UINT;
    OriginY: UINT;

    Interlace: UINT;
  end;

  VSLIB3_DATA_ATTRIBUTE = record
    case integer of
      0: (StreamFrame: VSLIB3_DATA_ATTRIBUTE_STREAM_FRAME);
      1: (StreamLine: VSLIB3_DATA_ATTRIBUTE_STREAM_LINE);
      2: (StreamVsFast: VSLIB3_DATA_ATTRIBUTE_STREAM_VSFAST);
      3: (VsMultiFrame: VSLIB3_DATA_ATTRIBUTE_STREAM_MULTIFRAME);
      4: (GatedOptic: VSLIB3_DATA_ATTRIBUTE_GATED_OPTIC);
      5: (VsLinkFrame: VSLIB3_DATA_ATTRIBUTE_VS_LINK_FRAME);
  end;

  VSLIB3_DATAHEADER = record
    TransferBits: UINT;
    TransferSize: VS_SIZE_T;
    _Type: UINT;
    AddOnDataType: UINT;
    AddOnDataSize: UINT;
    Attribute: VSLIB3_DATA_ATTRIBUTE;
    Inited: UINT;
  end;

  VS_LIST = record
   Id: UINT;
   char: PChar;
  end;

  PVS_LIST = ^VS_LIST;




  PVSLIB3_DATAHEADER = ^VSLIB3_DATAHEADER;
  PPVSLIB3_DATAHEADER = ^PVSLIB3_DATAHEADER;

function VsLib3SystemSetOption_SCALAR(SystemID, OptionId, Num: UINT; Val: integer; ErrorD: PVS_ERROR_DATA): integer; stdcall; external vs;
//INT VsLib3SystemSetOption_SCALAR(UINT SystemID, UINT OptionId, UINT Num, INT Val,VS_ERROR_DATA *ErrorD);

//char* VsLib3Version();
function VsLib3Version: pchar; stdcall; external vs;

function VsLib3CPortGetCInterface(ObjId, CPortId: UINT; CInterface: PUINT; ErrorD: PVS_ERROR_DATA): integer; stdcall; external vs;
//INT VsLib3CPortGetCInterface(UINT ObjId, UINT CPortId, UINT *CInterface, VS_ERROR_DATA *ErrorD);

function VsLib3ListGetAll(var char: pchar; var Id: UINT; Num: UINT; var List: VS_LIST): integer; stdcall; external 'vslib3.dll';

function VsLib3ErrorSPrintf(StrOut: PChar; StrOutSize: UINT; Format: PChar; ErrorData: PVS_ERROR_DATA; ErrorNames: PVS_LIST): integer; stdcall; external 'vslib3.dll';
//  INT VSLIB3_APIFUNC VsLib3ErrorSPrintf(char *StrOut,UINT StrOutSize,const char *Format,VS_ERROR_DATA *ErrorData,VS_LIST *ErrorNames);

function VsLib3SystemCreate(SystemTypeID: UINT; var SystemID: UINT; var ErrorD: VS_ERROR_DATA): integer; stdcall; external vs;
 //INT VSLIB3_APIFUNC VsLib3SystemCreate(UINT SystemTypeID,UINT *SystemID,VS_ERROR_DATA *ErrorD);

function VsLib3ListGetStdList(ListId: UINT): PVS_LIST; stdcall; external 'vslib3.dll';
//PVS_LIST VSLIB3_APIFUNC VsLib3ListGetStdList(UINT ListId);

function VsLib3Init(ErrorD: PVS_ERROR_DATA): integer; stdcall; external 'vslib3.dll';
//INT VSLIB3_APIFUNC  VsLib3Init(VS_ERROR_DATA *ErrorD);

function VsLib3SystemInit(SystemID: UINT; var ErrorD: VS_ERROR_DATA): integer; stdcall; external 'vslib3.dll';
//INT VSLIB3_APIFUNC VsLib3SystemInit(UINT SystemID, VS_ERROR_DATA *ErrorD);

function VsLib3SystemGetCInterface(SystemID, IntefaceID, Num: UINT; var CInterface: UINT; var ErrorD: VS_ERROR_DATA): integer; stdcall; external vs;
//INT VSLIB3_APIFUNC VsLib3SystemGetCInterface(UINT SystemID,UINT IntefaceID, UINT Num,UINT *CInterface,VS_ERROR_DATA *ErrorD);

function VsLib3OptionGetScalarRange(CInterface: UINT; MinVal, MaxVal: PINT; _Unit: UINT; ErrorD: PVS_ERROR_DATA): integer; stdcall; external vs;
//INT VSLIB3_APIFUNC VsLib3OptionGetScalarRange(UINT CInterface,INT *MinVal,INT *MaxVal,UINT Unit,VS_ERROR_DATA *ErrorD);

function VsLib3OptionSetScalar(CInterface: UINT; val: integer; _Unit: UINT; ErrorD: PVS_ERROR_DATA): integer; stdcall; external vs;
function VsLib3OptionGetScalar(CInterface: UINT; var val: integer; _Unit: integer; ErrorD: PVS_ERROR_DATA): integer; stdcall; external vs;
//INT VSLIB3_APIFUNC VsLib3OptionSetScalar(UINT CInterface,INT Val,UINT Unit,VS_ERROR_DATA *ErrorD);

function VsLib3OptionSetEnumVal(CInterface, Val: UINT; ErrorD: PVS_ERROR_DATA): integer; stdcall; external vs;
 //INT VSLIB3_APIFUNC VsLib3OptionSetEnumVal(UINT CInterface,UINT Val,VS_ERROR_DATA *ErrorD);

function VsLib3SystemGetInDInterface(SystemID, IntefaceID, Num: UINT; CInterface: PUINT; ErrorD: PVS_ERROR_DATA): integer; stdcall; external vs;
//INT VSLIB3_APIFUNC VsLib3SystemGetInDInterface(UINT SystemID,UINT IntefaceID, UINT Num,UINT *CInterface,VS_ERROR_DATA *ErrorD);

function VsLib3DPortOutGetDInterface(SystemID, DPortOutId: UINT; var DInterface: UINT; var ErrorD: VS_ERROR_DATA): integer; stdcall; external vs;

function VsLib3SystemGetOutDInterface(SystemID, IntefaceID, Num: UINT; var OutDInterface: UINT; var ErrorD: VS_ERROR_DATA): integer; stdcall; external vs;

function VsLib3DataheaderGetType(pDataHeader: PVSLIB3_DATAHEADER; var pType: UINT32; var pTransferBit: UINT; var pTransferSize: VS_SIZE_T; var ErrorD: VS_ERROR_DATA): integer; stdcall; external vs;

//function VsLib3SystemGetInDInterface(SystemID, IntefaceID, Num: UINT; CInterface: PUINT; ErrorD: PVS_ERROR_DATA): integer; stdcall; external vs;

function VsLib3DataheaderCreate(ppDataHeader: PPVSLIB3_DATAHEADER; ErrorD: PVS_ERROR_DATA): integer; stdcall; external vs;
//INT VSLIB3_APIFUNC VsLib3DataheaderCreate(VSLIB3_DATAHEADER** ppDataHeader, VS_ERROR_DATA* ErrorD);

function VsLib3InDInterfaceGetType(InDInterface: UINT; DataHeader: PVSLIB3_DATAHEADER; ErrorD: PVS_ERROR_DATA): integer; stdcall; external vs;
//INT VSLIB3_APIFUNC VsLib3InDInterfaceGetType(UINT InDInterface,VSLIB3_DATAHEADER *DataHeader,VS_ERROR_DATA *ErrorD);

function  VsLib3OutDInterfaceGetType(DInterface: UINT; DataHeader: PVSLIB3_DATAHEADER; var ErrorD: VS_ERROR_DATA): integer; stdcall; external vs;

function  VsLib3OutDInterfaceSetType(OutDInterface: UINT; DataHeader: PVSLIB3_DATAHEADER; var ErrorD: VS_ERROR_DATA): integer; stdcall; external vs;


function VsLib3SystemDestroy(SystemID: UINT; ErrorD: PVS_ERROR_DATA): integer; stdcall; external vs;
//INT VSLIB3_APIFUNC VsLib3SystemDestroy(UINT SystemID, VS_ERROR_DATA *ErrorD);

function VsLib3Exit(ErrorD: PVS_ERROR_DATA): integer; stdcall; external vs;
//INT VSLIB3_APIFUNC VsLib3Exit(VS_ERROR_DATA *ErrorD);

function VsLib3DataheaderGetU32(pDataHeader: PVSLIB3_DATAHEADER; FieldID: UINT; pValue: PUINT; ErrorD: PVS_ERROR_DATA): integer; stdcall; external vs;
//INT VSLIB3_APIFUNC VsLib3DataheaderGetU32(VSLIB3_DATAHEADER* pDataHeader, UINT FieldID, UINT32* pValue, VS_ERROR_DATA* ErrorD);


function VsLib3DataheaderSetU32(pDataHeader: PVSLIB3_DATAHEADER; FieldID: UINT; Value: UINT32; var ErrorD: VS_ERROR_DATA): integer; stdcall; external vs;


function VsLib3CallCInterface_0(CInterface, _Function: UINT; ErrorD: PVS_ERROR_DATA): integer; stdcall; external vs;
//INT VSLIB3_APIFUNC VsLib3CallCInterface_0(UINT CInterface,UINT Function,VS_ERROR_DATA *ErrorD);

function VsLib3InDInterfaceQueryReady(InDInterface: UINT; ReadySize: PVS_SIZE_T; ErrorD: PVS_ERROR_DATA): integer; stdcall; external vs;
//INT VSLIB3_APIFUNC VsLib3InDInterfaceQueryReady(UINT InDInterface,VS_SIZE_T *ReadySize,VS_ERROR_DATA *ErrorD);

function VsLib3InDInterfaceBeginBlock(InDInterface: UINT; ErrorD: PVS_ERROR_DATA): integer; stdcall; external vs;
//INT VSLIB3_APIFUNC VsLib3InDInterfaceBeginBlock(UINT InDInterface,VS_ERROR_DATA *ErrorD);

function VsLib3InDInterfacePIOTransfer(InDInterface: UINT; Buffer: pointer; Size: VS_SIZE_T; Tranfered: PVS_SIZE_T; ErrorD: PVS_ERROR_DATA): integer; stdcall; external vs;
//INT VSLIB3_APIFUNC VsLib3InDInterfacePIOTransfer(UINT InDInterface,void *Buffer,VS_SIZE_T Size,VS_SIZE_T *Tranfered,VS_ERROR_DATA *ErrorD);

function VsLib3InDInterfaceEndBlock(InDInterface: UINT; ErrorD: PVS_ERROR_DATA): integer; stdcall; external vs;
//INT VSLIB3_APIFUNC VsLib3InDInterfaceEndBlock(UINT InDInterface,VS_ERROR_DATA *ErrorD)

//function VsLib3DataheaderGetU32(pDataHeader: PVSLIB3_DATAHEADER; FieldID: UINT; var pValue: UINT32; var ErrorD:  VS_ERROR_DATA): integer; stdcall; external vs;


implementation

end.



