unit ini_file;

interface

uses
  {Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UType,} IniFiles;


type
  trecParam = record
    i01, //mask 0
    i02, //preprocessing 1
    i03, //viewnumber 1
    i04, //spectrummax 0
    i05, //spectrummax2 1
    i06, //spectrummax3 0
    i07, //klindo 0
    i08, //unwrapbegin 1
    i09, //ffwinsize 76
    i10, //regionsize 1000
    i11, //maskcutsize 5
    i12, //framesnumber 3
    i13, //delaynumber 4
    i14, // palcolor 0
    i15, // palbits 6
    i16, // upthr 250
    i17, // lothr 5
    i18, // brightness 128
    i19, // contrast 128
    i20, // top win image
    i21, // left win image
    i22, // width win image
    i23, // height win image
    i24, // winhistot
    i25, // winhistol
    i26, // winhistow
    i27, // winhistoh
    i28, // winlinext
    i29, // winlinexl
    i30, // winlinexw
    i31, // winlinexh
    i32, // winlineyt
    i33, // winlineyl
    i34, // winlineyw
    i35, // winlineyh
    i36, // lang
    i37, // rotate
    i38, // mirror
    i39, // Gaussian win size
    i40, // whatOutMask
    i41, // winlineusert
    i42, // winlineuserl
    i43, // winlineuserw
    i44, // winlineuserh
    i45, // whatoutmaskview
    i46, //  number of series
    i47 : Integer;  // current image

    b01, // cutrectbymask true
    b02, //makeenorm True
    b03, //unwrap True
    b04, //furfiltr True
    b05, //betteredge True
    b06, //converttomm True
    b07, //transform True
    b08, //maskcut True
    b09, //autocontrast True
    b10, //showhisto False
    b11, // load windows bitmap true
    b12, // load jpeg true
    b13, // load phast img true
    b14, // load phast asc true
    b15, // load smtcam bin true
    b16, // load smtcam bn2 true
    b17, // load mathcad prn true
    b18, // load german asc true
    b19, // load windows bitmap true
    b20, // save jpeg true
    b21, // save phast img true
    b22, // save phast asc true
    b23, // save smtcam bin true
    b24, // save smtcam bn2 true
    b25, // save mathcad prn true
    b26, // save german asc true
    b27, // save with mask
    b28, // showfd true
    b29, // showsd true
    b30, // showupthr true
    b31, // showlothr true
    b32, // makegamma
    b33, // show intermediate results (showresults)
    b34, // show histogram
    b35, // show graph x
    b36, // show graph y
    b37, // move phase to nil
    b38, // freemaskonopen
    b39, // sector window
    b40, // apodise
    b41, // cut lines
    b42, // makegaussian
    b43, // makecontrastnorm
    b44 : Boolean; // show graph user

    f01, //koeffa 0.024
    f02, //koeffb -0.0002172
    f03, //gamma 1.0
    f04, // rKWinX 1.5
    f05 : Extended; //rKWinY 4.0

    s01, //imagename image
    s02, // basepath
    s03, // camerapath
    s04 : AnsiString; // smtcampath
  end;

  procedure recParamLoadFile(var recParam: TRecParam; path: string);
  function CheckString(s: string): double;
{type
  TFormParam = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
  public
     recParam : trecParam;
     procedure SaveParam;
     procedure recParamLoadFile;
     procedure recParamSaveFile;
     procedure recParamSaveWinPos;
     procedure recParamLoadWinPos;
  end;

var
  FormParam: TFormParam;
}
implementation

uses SysUtils;

//uses Unit1, Registry, IniFiles, Unit7, Unit8, Unit9, UFormLine;

procedure recParamLoadFile(var recParam: trecParam; path: string);
var
  ifIn : TIniFile;
  s: string;
begin
  ifIn := TIniFile.Create({ChangeFileExt(Application.ExeName, '.INI')}path);
  try
    recParam.i01 := ifIn.ReadInteger('Preprocessing', 'mask', 0);
    recParam.i02 := ifIn.ReadInteger('Preprocessing', 'preprocessing', 1);
    recParam.i10 := ifIn.ReadInteger('Preprocessing', 'regionsize', 1000);
    recParam.b01 := ifIn.ReadBool('Preprocessing', 'cutrectbymask', True);
    recParam.b02 := ifIn.ReadBool('Preprocessing', 'makeenorm', True);
    recParam.b32 := ifIn.ReadBool('Preprocessing', 'makegamma', True);
    recParam.i37 := ifIn.ReadInteger('Preprocessing', 'rotate', 0);
    recParam.i38 := ifIn.ReadInteger('Preprocessing', 'mirror', 0);
    recParam.b40 := ifIn.ReadBool('Preprocessing', 'apodise', True);
    recParam.b43 := ifIn.ReadBool('Preprocessing', 'makecontrastnorm', True);
    recParam.i40 := ifIn.ReadInteger('Preprocessing', 'whatoutmask', 0);

    recParam.i03 := ifIn.ReadInteger('FourierReconstruct', 'viewnumber', 1);
    recParam.i04 := ifIn.ReadInteger('FourierReconstruct', 'spectrummax', 0);
    recParam.i05 := ifIn.ReadInteger('FourierReconstruct', 'spectrummax2', 1);
    recParam.i06 := ifIn.ReadInteger('FourierReconstruct', 'spectrummax3', 0);
    recParam.i07 := ifIn.ReadInteger('FourierReconstruct', 'klindo', 0);
    recParam.b39 := ifIn.ReadBool('FourierReconstruct', 'sectorwin', True);
    s:=ifIn.ReadString('FourierReconstruct', 'rkwinx', '1.5');
    recParam.f04 := CheckString(s);  //ifIn.ReadFloat('FourierReconstruct', 'rkwinx', 1.5);
    s:=ifIn.ReadString('FourierReconstruct', 'rkwiny', '4.0');
    recParam.f05 := CheckString(s);
    recParam.b41 := ifIn.ReadBool('FourierReconstruct', 'cutlines', False);

    recParam.i08 := ifIn.ReadInteger('Unwrap', 'unwrapbegin', 1);
    recParam.b03 := ifIn.ReadBool('Unwrap', 'unwrap', True);

    recParam.i09 := ifIn.ReadInteger('PostProcessing', 'ffwinsize', 76);
    recParam.i11 := ifIn.ReadInteger('PostProcessing', 'maskcutsize', 5);
    recParam.b04 := ifIn.ReadBool('PostProcessing', 'furfiltr', True);
    recParam.b05 := ifIn.ReadBool('PostProcessing', 'betteredge', True);
    recParam.b06 := ifIn.ReadBool('PostProcessing', 'converttomm', True);
    recParam.b07 := ifIn.ReadBool('PostProcessing', 'transform', True);
    recParam.b08 := ifIn.ReadBool('PostProcessing', 'maskcut', True);
    s:=ifIn.ReadString('PostProcessing', 'koeffa', '0.024');
    recParam.f01 := CheckString(s);
    s:=ifIn.ReadString('PostProcessing', 'koeffb', '-0.0002172');
    recParam.f02 := CheckString(s);
    recParam.b37 := ifIn.ReadBool('PostProcessing', 'shiftphase', True);
    recParam.b38 := ifIn.ReadBool('PostProcessing', 'transformmask', True);
    recParam.b42 := ifIn.ReadBool('PostProcessing', 'gaussian', True);
    recParam.i39 := ifIn.ReadInteger('PostProcessing', 'gwinsize', 15);

    recParam.i12 := ifIn.ReadInteger('TVMicro', 'framesnumber', 3);
    recParam.i13 := ifIn.ReadInteger('TVMicro', 'delaynumber', 4);
    recParam.b09 := ifIn.ReadBool('TVMicro', 'autocontrast', True);
    recParam.b10 := ifIn.ReadBool('TVMicro', 'showhisto', False);
    recParam.s01 := ifIn.ReadString('TVMicro', 'imagename', 'image');

    recParam.b11 := ifIn.ReadBool('Formats', 'loadbmp', True);
    recParam.b12 := ifIn.ReadBool('Formats', 'loadjpg', True);
    recParam.b13 := ifIn.ReadBool('Formats', 'loadimg', True);
    recParam.b14 := ifIn.ReadBool('Formats', 'loadasc', True);
    recParam.b15 := ifIn.ReadBool('Formats', 'loadbin', True);
    recParam.b16 := ifIn.ReadBool('Formats', 'loadbn2', True);
    recParam.b17 := ifIn.ReadBool('Formats', 'loadprn', True);
    recParam.b18 := ifIn.ReadBool('Formats', 'loadgasc', True);
    recParam.b19 := ifIn.ReadBool('Formats', 'writebmp', True);
    recParam.b20 := ifIn.ReadBool('Formats', 'writejpg', True);
    recParam.b21 := ifIn.ReadBool('Formats', 'writeimg', True);
    recParam.b22 := ifIn.ReadBool('Formats', 'writeasc', True);
    recParam.b23 := ifIn.ReadBool('Formats', 'writebin', True);
    recParam.b24 := ifIn.ReadBool('Formats', 'writebn2', True);
    recParam.b25 := ifIn.ReadBool('Formats', 'writeprn', True);
    recParam.b26 := ifIn.ReadBool('Formats', 'writegasc', True);
    recParam.b27 := ifIn.ReadBool('Formats', 'writemask', True);

    recParam.b38 := ifIn.ReadBool('DataFiles', 'freemaskonopen', False);
    recParam.s02 := ifIn.ReadString('DataFiles', 'basepath', '');
    recParam.s03 := ifIn.ReadString('DataFiles', 'imagepath', '');

    recParam.b28 := ifIn.ReadBool('Visualisation', 'showfd', True);
    recParam.b29 := ifIn.ReadBool('Visualisation', 'showsd', True);
    recParam.b30 := ifIn.ReadBool('Visualisation', 'showupthr', True);
    recParam.b31 := ifIn.ReadBool('Visualisation', 'showlothr', True);
    recParam.i14 := ifIn.ReadInteger('Visualisation', 'palcolor', 0);
    recParam.i15 := ifIn.ReadInteger('Visualisation', 'palbit', 6);
    recParam.i16 := ifIn.ReadInteger('Visualisation', 'upthr', 250);
    recParam.i17 := ifIn.ReadInteger('Visualisation', 'lothr', 5);
    recParam.i18 := ifIn.ReadInteger('Visualisation', 'brightness', 128);
    recParam.i19 := ifIn.ReadInteger('Visualisation', 'contrast', 128);
    s:=ifIn.ReadString('Visualisation', 'gamma', '1.0');
    recParam.f03 := CheckString(s);
    recParam.b33 := ifIn.ReadBool('Visualisation', 'showresults', True);
    recParam.s04 := ifIn.ReadString('Visualisation', 'smtcampath', '');
    recParam.i36 := ifIn.ReadInteger('Visualisation', 'lang', 0);
    recParam.i45 := ifIn.ReadInteger('Visualisation', 'whatoutmaskview', 0);

    recParam.i20 := ifIn.ReadInteger('WinPosition', 'winimaget', 0);
    recParam.i21 := ifIn.ReadInteger('WinPosition', 'winimagel', 0);
    recParam.i22 := ifIn.ReadInteger('WinPosition', 'winimagew', 800);
    recParam.i23 := ifIn.ReadInteger('WinPosition', 'winimageh', 600);
    recParam.i24 := ifIn.ReadInteger('WinPosition', 'winhistot', 0);
    recParam.i25 := ifIn.ReadInteger('WinPosition', 'winhistol', 0);
    recParam.i26 := ifIn.ReadInteger('WinPosition', 'winhistow', 100);
    recParam.i27 := ifIn.ReadInteger('WinPosition', 'winhistoh', 100);
    recParam.i28 := ifIn.ReadInteger('WinPosition', 'winlinext', 0);
    recParam.i29 := ifIn.ReadInteger('WinPosition', 'winlinexl', 0);
    recParam.i30 := ifIn.ReadInteger('WinPosition', 'winlinexw', 100);
    recParam.i31 := ifIn.ReadInteger('WinPosition', 'winlinexh', 100);
    recParam.i32 := ifIn.ReadInteger('WinPosition', 'winlineyt', 0);
    recParam.i33 := ifIn.ReadInteger('WinPosition', 'winlineyl', 0);
    recParam.i34 := ifIn.ReadInteger('WinPosition', 'winlineyw', 100);
    recParam.i35 := ifIn.ReadInteger('WinPosition', 'winlineyh', 100);
    recParam.i41 := ifIn.ReadInteger('WinPosition', 'winlineusert', 0);
    recParam.i42 := ifIn.ReadInteger('WinPosition', 'winlineuserl', 0);
    recParam.i43 := ifIn.ReadInteger('WinPosition', 'winlineuserw', 100);
    recParam.i44 := ifIn.ReadInteger('WinPosition', 'winlineuserh', 100);
    recParam.b44 := ifIn.ReadBool('WinPosition', 'winlineusershow', True);
    recParam.b34 := ifIn.ReadBool('WinPosition', 'winhistoshow', True);
    recParam.b35 := ifIn.ReadBool('WinPosition', 'winlinexshow', True);
    recParam.b36 := ifIn.ReadBool('WinPosition', 'winlineyshow', True);
  finally
    ifIn.Free;
  end;
end;

function CheckString(s: string): double;
var i: integer;
begin
  for i:=1 to length(s) do
    case s[i] of
      '.', ',': s[i]:=DecimalSeparator;
    end;
  Result:=StrToFloat(s);
end;

{procedure TFormParam.recParamSaveFile;
var
  ifIn : TIniFile;
begin
  ifIn := TIniFile.Create(ChangeFileExt(Application.ExeName, '.INI'));
  try
    ifIn.WriteInteger('Preprocessing', 'mask', recParam.i01);
    ifIn.WriteInteger('Preprocessing', 'preprocessing', recParam.i02);
    ifIn.WriteInteger('Preprocessing', 'regionsize', recParam.i10);
    ifIn.WriteBool('Preprocessing', 'cutrectbymask', recParam.b01);
    ifIn.WriteBool('Preprocessing', 'makeenorm', recParam.b02);
    ifIn.WriteBool('Preprocessing', 'makegamma', recParam.b32);
    ifIn.WriteInteger('Preprocessing', 'rotate', recParam.i37);
    ifIn.WriteInteger('Preprocessing', 'mirror', recParam.i38);
    ifIn.WriteBool('Preprocessing', 'apodise', recParam.b40);
    ifIn.WriteBool('Preprocessing', 'makecontrastnorm', recParam.b43);
    ifIn.WriteInteger('Preprocessing', 'whatoutmask', recParam.i40);

    ifIn.WriteInteger('FourierReconstruct', 'viewnumber', recParam.i03);
    ifIn.WriteInteger('FourierReconstruct', 'spectrummax', recParam.i04);
    ifIn.WriteInteger('FourierReconstruct', 'spectrummax2', recParam.i05);
    ifIn.WriteInteger('FourierReconstruct', 'spectrummax3', recParam.i06);
    ifIn.WriteInteger('FourierReconstruct', 'klindo', recParam.i07);
    ifIn.WriteBool('FourierReconstruct', 'sectorwin', recParam.b39);
    ifIn.WriteFloat('FourierReconstruct', 'rkwinx', recParam.f04);
    ifIn.WriteFloat('FourierReconstruct', 'rkwiny', recParam.f05);
    ifIn.WriteBool('FourierReconstruct', 'cutlines', recParam.b41);

    ifIn.WriteInteger('Unwrap', 'unwrapbegin', recParam.i08);
    ifIn.WriteBool('Unwrap', 'unwrap', recParam.b03);

    ifIn.WriteInteger('PostProcessing', 'ffwinsize', recParam.i09);
    ifIn.WriteInteger('PostProcessing', 'maskcutsize', recParam.i11);
    ifIn.WriteBool('PostProcessing', 'furfiltr', recParam.b04);
    ifIn.WriteBool('PostProcessing', 'betteredge', recParam.b05);
    ifIn.WriteBool('PostProcessing', 'converttomm', recParam.b06);
    ifIn.WriteBool('PostProcessing', 'transform', recParam.b07);
    ifIn.WriteBool('PostProcessing', 'maskcut', recParam.b08);
    ifIn.WriteFloat('PostProcessing', 'koeffa', recParam.f01);
    ifIn.WriteFloat('PostProcessing', 'koeffb', recParam.f02);
    ifIn.WriteBool('PostProcessing', 'shiftphase', recParam.b37);
    ifIn.WriteBool('PostProcessing', 'transformmask', recParam.b38);
    ifIn.WriteBool('PostProcessing', 'gaussian', recParam.b42);
    ifIn.WriteInteger('PostProcessing', 'gwinsize', recParam.i39);

    ifIn.WriteInteger('TVMicro', 'framesnumber', recParam.i12);
    ifIn.WriteInteger('TVMicro', 'delaynumber', recParam.i13);
    ifIn.WriteBool('TVMicro', 'autocontrast', recParam.b09);
    ifIn.WriteBool('TVMicro', 'showhisto', recParam.b10);
    ifIn.WriteString('TVMicro', 'imagename', recParam.s01);

    ifIn.WriteString('DataFiles', 'basepath', recParam.s02);
    ifIn.WriteString('DataFiles', 'imagepath', recParam.s03);
    ifIn.WriteBool('DataFiles', 'freemaskonopen', recParam.b38);

    ifIn.WriteBool('Formats', 'loadbmp', recParam.b11);
    ifIn.WriteBool('Formats', 'loadjpg', recParam.b12);
    ifIn.WriteBool('Formats', 'loadimg', recParam.b13);
    ifIn.WriteBool('Formats', 'loadasc', recParam.b14);
    ifIn.WriteBool('Formats', 'loadbin', recParam.b15);
    ifIn.WriteBool('Formats', 'loadbn2', recParam.b16);
    ifIn.WriteBool('Formats', 'loadprn', recParam.b17);
    ifIn.WriteBool('Formats', 'loadgasc', recParam.b18);
    ifIn.WriteBool('Formats', 'writebmp', recParam.b19);
    ifIn.WriteBool('Formats', 'writejpg', recParam.b20);
    ifIn.WriteBool('Formats', 'writeimg', recParam.b21);
    ifIn.WriteBool('Formats', 'writeasc', recParam.b22);
    ifIn.WriteBool('Formats', 'writebin', recParam.b23);
    ifIn.WriteBool('Formats', 'writebn2', recParam.b24);
    ifIn.WriteBool('Formats', 'writeprn', recParam.b25);
    ifIn.WriteBool('Formats', 'writegasc', recParam.b26);
    ifIn.WriteBool('Formats', 'writemask', recParam.b27);

    ifIn.WriteBool('Visualisation', 'showfd', recParam.b28);
    ifIn.WriteBool('Visualisation', 'showsd', recParam.b29);
    ifIn.WriteBool('Visualisation', 'showupthr', recParam.b30);
    ifIn.WriteBool('Visualisation', 'showlothr', recParam.b31);
    ifIn.WriteInteger('Visualisation', 'palcolor', recParam.i14);
    ifIn.WriteInteger('Visualisation', 'palbit', recParam.i15);
    ifIn.WriteInteger('Visualisation', 'upthr', recParam.i16);
    ifIn.WriteInteger('Visualisation', 'lothr', recParam.i17);
    ifIn.WriteInteger('Visualisation', 'brightness', recParam.i18);
    ifIn.WriteInteger('Visualisation', 'contrast', recParam.i19);
    ifIn.WriteFloat('Visualisation', 'gamma', recParam.f03);
    ifIn.WriteBool('Visualisation', 'showresults', recParam.b33);
    ifIn.WriteString('Visualisation', 'smtcampath', recParam.s04);
    ifIn.WriteInteger('Visualisation', 'lang', recParam.i36);
    ifIn.WriteInteger('Visualisation', 'whatoutmaskview', recParam.i45);

    ifIn.WriteInteger('WinPosition', 'winimaget', recParam.i20);
    ifIn.WriteInteger('WinPosition', 'winimagel', recParam.i21);
    ifIn.WriteInteger('WinPosition', 'winimagew', recParam.i22);
    ifIn.WriteInteger('WinPosition', 'winimageh', recParam.i23);
    ifIn.WriteInteger('WinPosition', 'winhistot', recParam.i24);
    ifIn.WriteInteger('WinPosition', 'winhistol', recParam.i25);
    ifIn.WriteInteger('WinPosition', 'winhistow', recParam.i26);
    ifIn.WriteInteger('WinPosition', 'winhistoh', recParam.i27);
    ifIn.WriteInteger('WinPosition', 'winlinext', recParam.i28);
    ifIn.WriteInteger('WinPosition', 'winlinexl', recParam.i29);
    ifIn.WriteInteger('WinPosition', 'winlinexw', recParam.i30);
    ifIn.WriteInteger('WinPosition', 'winlinexh', recParam.i31);
    ifIn.WriteInteger('WinPosition', 'winlineyt', recParam.i32);
    ifIn.WriteInteger('WinPosition', 'winlineyl', recParam.i33);
    ifIn.WriteInteger('WinPosition', 'winlineyw', recParam.i34);
    ifIn.WriteInteger('WinPosition', 'winlineyh', recParam.i35);
    ifIn.WriteInteger('WinPosition', 'winlineusert', recParam.i41);
    ifIn.WriteInteger('WinPosition', 'winlineuserl', recParam.i42);
    ifIn.WriteInteger('WinPosition', 'winlineuserw', recParam.i43);
    ifIn.WriteInteger('WinPosition', 'winlineuserh', recParam.i44);
    ifIn.WriteBool('WinPosition', 'winlineusershow', recParam.b44);
    ifIn.WriteBool('WinPosition', 'winhistoshow', recParam.b34);
    ifIn.WriteBool('WinPosition', 'winlinexshow', recParam.b35);
    ifIn.WriteBool('WinPosition', 'winlineyshow', recParam.b36);
  finally
    ifIn.Free;
  end;
end;
     }
     {
procedure TFormParam.FormCreate(Sender: TObject);
begin
  recParamLoadFile;
end;
}
{
procedure TFormParam.SaveParam;
begin
//  recParamLoadWin;
  if Form1.bIsExtVer then FormParam.recParamSaveWinPos;
  recParamSaveFile;
end;
}
{
procedure TFormParam.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  SaveParam;
end;
}
{
procedure TFormParam.recParamSaveWinPos;
begin
  recParam.i20 := Form1.Top;
  recParam.i21 := Form1.Left;
  recParam.i22 := Form1.Width;
  recParam.i23 := Form1.Height;
  recParam.i24 := FormHisto.Top;
  recParam.i25 := FormHisto.Left;
  recParam.i26 := FormHisto.Width;
  recParam.i27 := FormHisto.Height;
  recParam.i28 := FormLineX.Top;
  recParam.i29 := FormLineX.Left;
  recParam.i30 := FormLineX.Width;
  recParam.i31 := FormLineX.Height;
  recParam.i32 := FormLineY.Top;
  recParam.i33 := FormLineY.Left;
  recParam.i34 := FormLineY.Width;
  recParam.i35 := FormLineY.Height;
  recParam.b34 := FormHisto.Visible;
  recParam.b35 := FormLineX.Visible;
  recParam.b36 := FormLineY.Visible;
  recParam.b44 := Form5.Visible;
  recParam.i41 := Form5.Top;
  recParam.i42 := Form5.Left;
  recParam.i43 := Form5.Width;
  recParam.i44 := Form5.Height;
end;
}
{
procedure TFormParam.recParamLoadWinPos;
begin
  Form1.Top := recParam.i20;
  Form1.Left := recParam.i21;
  Form1.Width := recParam.i22;
  Form1.Height := recParam.i23;
  FormHisto.Top := recParam.i24;
  FormHisto.Left := recParam.i25;
  FormHisto.Width := recParam.i26;
  FormHisto.Height := recParam.i27;
  FormLineX.Top := recParam.i28;
  FormLineX.Left := recParam.i29;
  FormLineX.Width := recParam.i30;
  FormLineX.Height := recParam.i31;
  FormLineY.Top := recParam.i32;
  FormLineY.Left := recParam.i33;
  FormLineY.Width := recParam.i34;
  FormLineY.Height := recParam.i35;
  FormHisto.Visible := recParam.b34;
  FormLineX.Visible := recParam.b35;
  FormLineY.Visible := recParam.b36;
  Form5.Visible := recParam.b44;
  Form5.Top := recParam.i41;
  Form5.Left := recParam.i42;
  Form5.Width := recParam.i43;
  Form5.Height := recParam.i44;
end;
}
end.
