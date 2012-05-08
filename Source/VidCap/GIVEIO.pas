
  {*====================================================================*}
  {*                               DELPHI                               *}
  {*                    "WinNT/Win2000/WinXP/Win2003"                   *}
  {*                   Модуль для работы с портами I/O.                 *}
  {*    В этом модуле был использован всем известный драйвер "giveio"   *}
  {*          Автор Модуля   : Nurzhanov Askar (NikNet/Arazel).         *}
  {*                  Автор Драйвера : Дейл Робертс.                    *}
  {*                                2005                                *}
  {*====================================================================*}

// !!!! файл giveio.sys должен находится в папке программы !!!!
unit giveio;


interface

uses windows, winsvc;

{*====================================================================*}
{* Основные ф-ций *----------------------------------------------------}
{*====================================================================*}
  // ВНИМАНИЕ!!! Использовать в самом начале
  Procedure InitDriver;

  // После ф-ций InitDrv можете использовать эти

  Procedure OutPort(port:word; value:byte);stdcall;
  Function  InPort(port:word):byte;stdcall;

  Procedure OutPortW(port:word; value:word);stdcall;
  Function  InPortW(port:word):word;stdcall;

  Function  InPortDW(Port: Word):cardinal;stdcall;
  procedure OutPortDW( Port: word; value:cardinal);stdcall;

  // ВНИМАНИЕ!!! Использовать в самом конце
  Procedure DoneDriver;

implementation


uses sysutils;

Var
  hSCMan,
  hService,
  hDevice             : SC_HANDLE;
  lpServiceArgVectors : PChar;
  temp                : LongBool;
  serviceStatus       : TServiceStatus;
  DeviceName,          
  DriverPath          : String;


  Procedure InitDriver;
  Begin
     lpServiceArgVectors:=nil;
     DeviceName:='giveio';
     DriverPath:=ExtractFilePath(ParamStr(0))+'giveio.sys';

     hSCMan:=OpenSCManager(Nil,Nil,SC_MANAGER_ALL_ACCESS);

     hService:=CreateService(
     hSCMan,
     pChar(DeviceName),
     pChar(DeviceName),
     SERVICE_ALL_ACCESS,
     SERVICE_KERNEL_DRIVER,
     SERVICE_DEMAND_START,
     SERVICE_ERROR_NORMAL,
     PChar(@DriverPath[1]), //указатель на начало строки!!!
     nil,nil,nil,nil,nil);

     If hService<>0 then CloseServiceHandle(hService);
     hService:=OpenService(hSCMan,pChar(DeviceName),SERVICE_ALL_ACCESS);
     If hService<>0 then
     begin
       StartService(hService,0,PChar(lpServiceArgVectors));
       CloseServiceHandle(hService);
     end;
     hDevice:=CreateFile(pChar('\\.\'+DeviceName),
     GENERIC_READ or GENERIC_WRITE,0,PSECURITY_DESCRIPTOR(nil),
     OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0);
  end;

  Procedure DoneDriver;
  Begin
  CloseHandle(hDevice);
  hService := OpenService(hSCMan,PChar(DeviceName), SERVICE_ALL_ACCESS);
  if hService <> 0 then
  Temp := ControlService(hService,SERVICE_CONTROL_STOP,ServiceStatus);
  if (hService <> 0) then
  CloseServiceHandle(hService);
  hService := OpenService(hSCMan,PChar(DeviceName), SERVICE_ALL_ACCESS);
  temp := DeleteService(hService);
  CloseServiceHandle(hService);
  end;


  Procedure OutPort(port:word; value:byte);assembler;stdcall;
  asm
    mov al, value
    mov dx, port
    out dx, al  //al а не ax!!!
  end;

  function InPort(port:word):byte;assembler;stdcall;
  asm
    mov dx,port
    in al,dx
    mov Result,al
  end;

  Procedure OutPortW(port:word; value:word);assembler;stdcall;
  asm
    mov ax, value
    mov dx, port
    out dx, ax
  end;

  function InPortW(port:word):word;assembler;stdcall;
  asm
    mov dx,port
    in ax,dx
    mov Result,ax
  end;

  Function  InPortDW(Port: Word):cardinal;stdcall;
  Begin
   asm
     mov DX, Port;
     in  EAX, DX;
     mov Result, EAX;
   end;
  end;

  procedure OutPortDW( Port: word; value:cardinal);stdcall;
   Begin
    asm
      mov DX, Port;
      mov EAX, value;
      out DX, EAX;
    end;
   end;




end.

