unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, EditR, StdCtrls, ExtCtrls, Crude, Spin, utype, ToolWin,
  Grids, ValEdit;

type
  TMyEdit = class(TEdit)
    protected
    procedure CreateParams(var Params: TCreateParams); override;
    procedure KeyPress(var Key: Char); override;
  end;

  TForm6 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Button1: TButton;
    Button2: TButton;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    Label10: TLabel;
    Label11: TLabel;
    CheckBox1: TCheckBox;
    Bevel1: TBevel;
    TabSheet3: TTabSheet;
    Label12: TLabel;
    Edit1: TEdit;
    Button3: TButton;
    Label15: TLabel;
    Label16: TLabel;
    CheckBox2: TCheckBox;
    SpinEdit1: TSpinEdit;
    Label3: TLabel;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Edit4: TEdit;
    CheckBox5: TCheckBox;
    Label4: TLabel;
    CheckBox6: TCheckBox;
    Edit5: TEdit;
    Label13: TLabel;
    CheckBox7: TCheckBox;
    Label14: TLabel;
    Edit6: TEdit;
    Label17: TLabel;
    Edit7: TEdit;
    Label18: TLabel;
    Лунка: TTabSheet;
    Label19: TLabel;
    Label20: TLabel;
    Edit9: TEdit;
    Edit8: TEdit;
    GroupBox2: TGroupBox;
    Edit10: TEdit;
    Label21: TLabel;
    Label22: TLabel;
    Edit11: TEdit;
    GroupBox3: TGroupBox;
    Label24: TLabel;
    Edit13: TEdit;
    Label23: TLabel;
    Edit12: TEdit;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    CheckBox8: TCheckBox;
    Label29: TLabel;
    Edit2: TEdit;
    Label30: TLabel;
    Button4: TButton;
    Label31: TLabel;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    RadioGroup1: TRadioGroup;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    Edit3: TEdit;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Edit14: TEdit;
    Label35: TLabel;
    CheckBox13: TCheckBox;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    TabSheet4: TTabSheet;
    Edit15: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Label36: TLabel;
    Edit18: TEdit;
    Button8: TButton;
    Label37: TLabel;
    Label38: TLabel;
    Label39: TLabel;
    Panel2: TPanel;
    ToolBar2: TToolBar;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    Label40: TLabel;
    Edit19: TEdit;
    Edit20: TEdit;
    Edit21: TEdit;
    Image1: TImage;
    Lambda2_edit: TEdit;
    Lambda3_edit: TEdit;
    How_many_wavelengths_group: TRadioGroup;
    height_edit: TEdit;
    width_edit: TEdit;
    Lambda1_edit: TEdit;
    Lazer_num_group: TRadioGroup;
    procedure FormCreate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure Edit15KeyPress(Sender: TObject; var Key: Char);
    procedure Edit16KeyPress(Sender: TObject; var Key: Char);
    procedure Edit17KeyPress(Sender: TObject; var Key: Char);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ed: array[0..6] of TEditR;
    ed1: TMyEdit;
  end;

function CheckString(s: string): treal;

var
  Form6: TForm6;



implementation

{$R *.dfm}

uses unit1, UPhast2Vars, FileCtrl, ShellApi, USaveAsForm;

procedure TForm6.FormCreate(Sender: TObject);
var i: integer;
begin
  for i:=5 to 6 do
  begin
    ed[i]:=TEditR.Create(Self);
    ed[i].Parent:=GroupBox1;
    ed[i].Width:=44;
    ed[i].Height:=21;
  end;
//  ed[4].Parent:=TabSheet1;
  ed[5].Parent:=TabSheet2;
//  ed[0].Top:=52;
//  ed[0].Left:=104;
//  ed[1].Top:=52;
//  ed[1].Left:=176;
//  ed[2].Top:=52;
//  ed[2].Left:=176;
//  ed[2].Visible:=false;
//  ed[3].Top:=80;
//  ed[3].Left:=130;
//  ed[3].Visible:=false;
//  ed[4].Top:=135;
//  ed[4].Left:=88;
//  ed[4].Visible:=not cfg.ComMode;
  ed[5].Top:=144;
  ed[5].Left:=174;
  ed[6].Parent:=TabSheet3;
  ed[6].Left:=184;
  ed[6].Top:=64;
  ed1:=TMyEdit.Create(Self);
  ed1.Parent:=TabSheet3;
  ed1.Width:=44;
  ed1.Height:=21;
  ed1.Left:=184;
  ed1.Top:=96;

  if ParamStr(1) <> '' then
  begin
    CheckBox7.Visible:=true;
    Label14.Visible:=true;
    edit6.Visible:=true;
    Label17.Visible:=true;
  end;
end;

procedure TForm6.ToolButton1Click(Sender: TObject);
begin
  SaveAsForm.CheckBox5.Checked:=boolean(cfg.SaveAS and WP_SAVE_AMPLITUDE);
  SaveAsForm.CheckBox6.Checked:=boolean(cfg.SaveAS and WP_SAVE_PHASE);
  SaveAsForm.CheckBox7.Checked:=boolean(cfg.SaveAS and WP_SAVE_UNWRAP);
  SaveAsForm.CheckBox1.Checked:=boolean(cfg.SaveAS and WP_SAVE_BMP);
  SaveAsForm.CheckBox2.Checked:=boolean(cfg.SaveAS and WP_SAVE_MATLAB);
  SaveAsForm.CheckBox3.Checked:=boolean(cfg.SaveAS and WP_SAVE_TXT);
  SaveAsForm.CheckBox4.Checked:=boolean(cfg.SaveAS and WP_SAVE_BIN);
  SaveAsForm.Edit1.Text:=cfg.SavePath;

  if SaveAsForm.ShowModal <> mrOk then
    exit;

  cfg.SaveAS:=0;
  if SaveAsForm.CheckBox5.Checked then cfg.SaveAS:=cfg.SaveAS or WP_SAVE_AMPLITUDE;
  if SaveAsForm.CheckBox6.Checked then cfg.SaveAS:=cfg.SaveAS or WP_SAVE_PHASE;
  if SaveAsForm.CheckBox7.Checked then cfg.SaveAS:=cfg.SaveAS or WP_SAVE_UNWRAP;
  if SaveAsForm.CheckBox1.Checked then cfg.SaveAS:=cfg.SaveAS or WP_SAVE_BMP;
  if SaveAsForm.CheckBox2.Checked then cfg.SaveAS:=cfg.SaveAS or WP_SAVE_MATLAB;
  if SaveAsForm.CheckBox3.Checked then cfg.SaveAS:=cfg.SaveAS or WP_SAVE_TXT;
  if SaveAsForm.CheckBox4.Checked then cfg.SaveAS:=cfg.SaveAS or WP_SAVE_BIN;
  cfg.SavePath:=SaveAsForm.Edit1.Text;
end;

procedure TForm6.ToolButton2Click(Sender: TObject);
var p: array[0..2] of byte;
begin
  p[0]:=0;
  p[1]:=32;
  p[2]:=15;
  Form1.CommPortDriver1.SendData(@(p), 3);
end;

procedure TForm6.ToolButton3Click(Sender: TObject);
var p: array[0..2] of byte;
begin
  p[0]:=0;
  p[1]:=16;
  p[2]:=15;
  Form1.CommPortDriver1.SendData(@(p), 3);
end;

procedure TForm6.Button2Click(Sender: TObject);
begin
//  Close;
end;

procedure TForm6.Button1Click(Sender: TObject);
begin
{  with cfg do
  begin
    h1:=round(StrToFloat(ed[0].Text));
    w1:=round(StrToFloat(ed[1].Text));
  //  h2:=round(StrToFloat(ed[2].Text));
  //  w2:=round(StrToFloat(ed[3].Text));
    //input:=RadioGroup2.ItemIndex+1;
    lambda:=StrToFloat(ed[4].Text);
    q:=ComboBox1.ItemIndex;
    pal:=ComboBox2.ItemIndex;
    z:=round(StrToFloat(ed[5].Text));
    tilt:=CheckBox1.Checked;
    img_path:=Edit1.Text;
    steps:=StrToInt(ed[6].Text);
    port:=StrToInt('$'+ed1.Text);
//    int_filtr:=CheckBox2.Checked;
    scl_eye:=(w1/cam_w+h1/cam_h)/2;
    poly_order:=SpinEdit1.Value;
    base:=CheckBox3.Checked;
    invert:=CheckBox4.Checked;
    do_seq:=CheckBox5.Checked;
    num_seq:=StrToInt(Edit4.Text);
    do_mean:=CheckBox6.Checked;
    num_mean:=StrToInt(Edit5.Text);
    do_step:=CheckBox7.Checked;
    step_height:=StrToInt(Edit6.Text);
    do_filtr:=CheckBox2.Checked;
    gauss_aper:=StrToInt(Edit7.Text);

    _t:=CheckString(Edit8.Text);
    _p:=CheckString(Edit9.Text);
    _f:=CheckString(Edit12.Text);
    n_ref:=CheckString(Edit10.Text);
    b_ref:=CheckString(Edit11.Text);
    b_rab:=CheckString(Edit13.Text);

    // save_bmp_int:=CheckBox3.Checked;
  end;
  Close;   }
end;

{ TMyEdit }

procedure TMyEdit.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_RIGHT;
end;

procedure TMyEdit.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  if not (key in ['0'..'9','A'..'F','a'..'f',#8]) then
    key:=#0;
end;

procedure TForm6.Button3Click(Sender: TObject);
var dir: string;
    opt: TSelectDirOpts;

begin
  dir:=Edit1.Text;
  if  AdvSelectDirectory('Выберите директорию для сохранения интерферограмм', '', dir, false, false, True) then
  begin
    Edit1.Text:=dir;
//    cfg.img_path:=dir;

  end;

  {dir:=ExtractFilePath(Application.ExeName);

  opt:=[sdAllowCreate];
  SelectDirectory(dir, opt, 0);
  Edit1.Text:=dir;}

  {
  form1.OpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  form1.OpenDialog1.FileName:='';
  form1.OpenDialog1.Filter:='';
  if not Form1.OpenDialog1.Execute then
    exit;

  Edit1.Text:=Form1.OpenDialog1.FileName;
   }

end;

procedure TForm6.Button4Click(Sender: TObject);
begin
  form1.OpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  form1.OpenDialog1.Filter:='bin-files|*.bin';

  if not form1.OpenDialog1.Execute then
    exit;

  Label31.Caption:=form1.OpenDialog1.FileName;
  Label31.Hint:=form1.OpenDialog1.FileName;
//  StaticText1.Caption:=form1.OpenDialog1.FileName;


end;

procedure TForm6.Button8Click(Sender: TObject);
var p: array[0..2] of byte;
    d: word;
begin
  {d:=StrToInt(Edit15.Text);
  p[0]:=LowByte(d);
  p[1]:=HiByte(d)+32;
  p[2]:=15;
  Form1.CommPortDriver1.SendData(@(p), 3);
  cfg.Fizo_pedestal:=d;
  sleep(200);
   }

  d:=StrToInt(Edit16.Text);
  p[0]:=LowByte(d);
  p[1]:=HiByte(d)+128;
  p[2]:=15;
  Form1.CommPortDriver1.SendData(@(p), 3);
  cfg.Fizo_amp:=d;
  sleep(200);

  d:=StrToInt(Edit17.Text);
  p[0]:=LowByte(d);
  p[1]:=HiByte(d)+64;
  p[2]:=15;
  Form1.CommPortDriver1.SendData(@(p), 3);
  cfg.Fizo_t:=d;

end;

procedure TForm6.Edit15KeyPress(Sender: TObject; var Key: Char);
var p: array[0..2] of byte;
    d: word;
begin
  d:=word(key);
  if d=13 then
  begin
    d:=StrToInt(Edit15.Text);
    p[0]:=LowByte(d);
    p[1]:=HiByte(d)+32;
    p[2]:=15;
    Form1.CommPortDriver1.SendData(@(p), 3);
    cfg.Fizo_pedestal:=d;
  end;
end;

procedure TForm6.Edit16KeyPress(Sender: TObject; var Key: Char);
var p: array[0..2] of byte;
    d: word;
begin
  d:=word(key);
  if d=13 then
  begin
    d:=StrToInt(Edit16.Text);
    p[0]:=LowByte(d);
    p[1]:=HiByte(d)+128;
    p[2]:=15;
    Form1.CommPortDriver1.SendData(@(p), 3);
    cfg.Fizo_amp:=d;
  end;
end;

procedure TForm6.Edit17KeyPress(Sender: TObject; var Key: Char);
var p: array[0..2] of byte;
    d: word;
begin
  d:=word(key);
  if d=13 then
  begin
    d:=StrToInt(Edit17.Text);
    p[0]:=LowByte(d);
    p[1]:=HiByte(d)+64;
    p[2]:=15;
    Form1.CommPortDriver1.SendData(@(p), 3);
    cfg.Fizo_t:=d;
  end;
end;

function CheckString(s: string): treal;
var i: integer;
begin
  for i:=1 to length(s) do
    case s[i] of
      ',','.': s[i]:=DecimalSeparator;
      '0'..'9','-','E','e': ;
    else
      s[i]:='0';
    end;
  Result:=StrToFloat(s);
end;

end.
