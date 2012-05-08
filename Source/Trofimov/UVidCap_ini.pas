unit UVidCap_ini;

interface

uses
  IniFiles;


type
  TVidCapParam = record
    Width,
    Height,
    Cstep,
    ith,
    r254,
    g255th,
    Port,
    VideoSource,
    Rotate,
    min,
    max,
    Brightness,
    Contrast,
    cut,
    LedBright,
    CameraPort,
    Mode,
    Frames,
    Led0,
    Led1,
    Led2,
    Led3,
    Led4,
    ComPort,
    Device: integer;
    AutoReg,
    Demo: boolean;
  end;

  procedure VidCapParamFile(var VidCapParam: TVidCapParam; path: string);
//  function CheckString(s: string): double;

implementation

uses SysUtils;

procedure VidCapParamFile(var VidCapParam: TVidCapParam; path: string);
var
  ifIn: TIniFile;
  //s: string;
begin
  ifIn := TIniFile.Create(path);
  try
    with VidCapParam, ifIn do
    begin
      Width:=ReadInteger('Video','Width', 760);
      Height:=ReadInteger('Video','Height', 576);
      Cstep:=ReadInteger('Video','Cstep', 200);
      ith:=ReadInteger('Video','ith', 254);
      r254:=ReadInteger('Video','r254', 16);
      g255th:=ReadInteger('Video','g255th', 200);
      Port:=ReadInteger('Video','Port', $b400);
      VideoSource:=ReadInteger('Video','VideoSource', 1);
      Rotate:=ReadInteger('Video','Rotate', 1);
      min:=ReadInteger('Video', 'Min', 0);
      max:=ReadInteger('Video', 'Max', 255);
      Brightness:=ReadInteger('Video', 'Brightness', 255);
      Contrast:=ReadInteger('Video', 'Contrast', 255);
      cut:=ReadInteger('Video', 'Cut', 30);
      LedBright:=ReadInteger('Video', 'LedBright', 255);
      CameraPort:=ReadInteger('Video','CameraPort', $b400);
      Mode:=ReadInteger('Video','Mode', 0);
      AutoReg:=ReadBool('Video', 'AutoReg', true);
      Frames:=ReadInteger('Video','Frames', 3);
      Led0:=ReadInteger('Video','Led0', 15);
      Led1:=ReadInteger('Video','Led1', 255);
      Led2:=ReadInteger('Video','Led2', 255);
      Led3:=ReadInteger('Video','Led3', 255);
      Led4:=ReadInteger('Video','Led4', 255);
      ComPort:=ReadInteger('Video','ComPort', 3);
      Device:=ReadInteger('Video','Device', 1);
      Demo:=ReadBool('Video','Demo', false);
    end;
  finally
    ifIn.Free;
  end;
end;

{function CheckString(s: string): double;
var i: integer;
begin
  for i:=1 to length(s) do
    case s[i] of
      '.', ',': s[i]:=DecimalSeparator;
    end;
  Result:=StrToFloat(s);
end;   }


end.
