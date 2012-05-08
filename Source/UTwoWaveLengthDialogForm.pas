unit UTwoWaveLengthDialogForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, UPhast2Vars, ToolWin, ComCtrls;

type
  TTwoWaveLengthDialogForm = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Button3: TButton;
    Button6: TButton;
    Bevel2: TBevel;
    Label3: TLabel;
    Edit1: TEdit;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    Panel2: TPanel;
    ToolBar2: TToolBar;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    Bevel1: TBevel;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton6Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TwoWaveLengthDialogForm: TTwoWaveLengthDialogForm;

procedure OpenOptionsForm(var opt: TConfig);

implementation

{$R *.dfm}

uses UTwoWaveLengthClass, unit6, unit2, unit1, UWinPhast_INI;

procedure OpenOptionsForm(var opt: TConfig);
begin

  with Form6, opt do
  begin
    ed[0].Text:=FloatToStr(h1);
    ed[1].Text:=FloatToStr(w1);
    ed[4].Text:=FloatToStr(lambda);
    ed[6].Text:=IntToStr(steps);
    ed1.Text:=IntToHex(port, 4);
    ComboBox2.ItemIndex:=pal;
    CheckBox1.Checked:=tilt;
    Edit1.Text:=img_path;
    CheckBox3.Checked:=base;
    CheckBox4.Checked:=invert;
    CheckBox5.Checked:=do_seq;
    CheckBox6.Checked:=do_mean;
    CheckBox7.Checked:=do_step;
    CheckBox8.Checked:=do_gauss;

    Edit4.Text:=IntToStr(num_seq);
    Edit5.Text:=IntToStr(num_mean);
    Edit6.Text:=FloatToStr(step_height);
    Edit7.Text:=FloatToStr(gauss_cut_off);
    CheckBox2.Checked:=do_filtr;
    Edit2.Text:=FloatToStr(gauss_aper);

    Edit8.Text:=FloatToStr(_t);
    Edit9.Text:=FloatToStr(_p);
    Edit12.Text:=FloatToStr(_f);
    Edit10.Text:=FloatToStr(n_ref);
    Edit11.Text:=FloatToStr(b_ref);
    Edit13.Text:=FloatToStr(b_rab);
    Label31.Caption:=base_path;

    if cfg.Com_phase_shift then
    begin
      Label16.Visible:=false;
      ed1.Visible:=false;
    end;

    if ShowModal <> mrOk then
      exit;

    h1:=StrToFloat(ed[0].Text);
    w1:=StrToFloat(ed[1].Text);
    lambda:=StrToFloat(ed[4].Text);
    pal:=ComboBox2.ItemIndex;
    tilt:=CheckBox1.Checked;
    img_path:=Edit1.Text;
    base_path:=Label31.Caption;

    steps:=StrToInt(ed[6].Text);
    port:=StrToInt('$'+ed1.Text);

    base:=CheckBox3.Checked;
    invert:=CheckBox4.Checked;
    do_seq:=CheckBox5.Checked;
    num_seq:=StrToInt(Edit4.Text);
    do_mean:=CheckBox6.Checked;
    do_step:=CheckBox7.Checked;
    do_gauss:=CheckBox8.Checked;

    num_mean:=StrToInt(Edit5.Text);
    do_filtr:=CheckBox2.Checked;
    gauss_cut_off:=CheckString(Edit7.Text);
    gauss_aper:=CheckString(Edit2.Text);

    step_height:=CheckString(Edit6.Text);

    scl_eye:=(w1/cam_w+h1/cam_h)/2;
  end;

end;

procedure TTwoWaveLengthDialogForm.Button1Click(Sender: TObject);
begin
  OpenOptionsForm(izm1.opt);
end;

procedure TTwoWaveLengthDialogForm.Button2Click(Sender: TObject);
begin
  OpenOptionsForm(izm2.opt);
end;

procedure TTwoWaveLengthDialogForm.Button4Click(Sender: TObject);
var i: integer;
begin
  Form2.FileMask:='bmp';
  form2.ListView2.Clear;
  if Form2.ShowModal = mrOk then
  begin
    izm1.int_list.Clear;
    for i:=0 to form2.ListView2.Items.Count-1 do
      izm1.int_list.Add(form2.ListView2.Items[i].SubItems[1]);
  end;
end;

procedure TTwoWaveLengthDialogForm.Button5Click(Sender: TObject);
var i: integer;
begin
  Form2.FileMask:='bmp';
  form2.ListView2.Clear;
  if Form2.ShowModal = mrOk then
  begin
    izm2.int_list.Clear;
    for i:=0 to form2.ListView2.Items.Count-1 do
      izm2.int_list.Add(form2.ListView2.Items[i].SubItems[1]);
  end;
end;

procedure TTwoWaveLengthDialogForm.ToolButton5Click(Sender: TObject);
var
  s: string;
begin
  form1.SaveDialog1.Filter:='any-files|*.*';
  form1.SaveDialog1.InitialDir:=ExtractFileDir(Application.ExeName);
  if not Form1.SaveDialog1.Execute then
    exit;

  s:=form1.SaveDialog1.FileName;
  s:=ChangeFileExt(s, '');
  WriteINI(izm1.opt, s+'.ini');
  izm1.int_list.SaveToFile(s+'.txt');

end;

procedure TTwoWaveLengthDialogForm.ToolButton6Click(Sender: TObject);
var
  s: string;
begin
  form1.OpenDialog1.Filter:='any-files|*.*';
  form1.OpenDialog1.InitialDir:=ExtractFileDir(Application.ExeName);
  if not Form1.OpenDialog1.Execute then
    exit;

  s:=form1.OpenDialog1.FileName;
  s:=ChangeFileExt(s, '');

  ReadINI(izm1.opt, s+'.ini');
  izm1.int_list.Clear;
  izm1.int_list.LoadFromFile(s+'.txt');


end;

procedure TTwoWaveLengthDialogForm.ToolButton7Click(Sender: TObject);
var
  s: string;
begin
  form1.SaveDialog1.Filter:='any-files|*.*';
  form1.SaveDialog1.InitialDir:=ExtractFileDir(Application.ExeName);
  if not Form1.SaveDialog1.Execute then
    exit;

  s:=form1.SaveDialog1.FileName;
  s:=ChangeFileExt(s, '');
  WriteINI(izm2.opt, s+'.ini');
  izm2.int_list.SaveToFile(s+'.txt');
end;

procedure TTwoWaveLengthDialogForm.ToolButton8Click(Sender: TObject);
var
  s: string;
begin
  form1.OpenDialog1.Filter:='any-files|*.*';
  form1.OpenDialog1.InitialDir:=ExtractFileDir(Application.ExeName);
  if not Form1.OpenDialog1.Execute then
    exit;

  s:=form1.OpenDialog1.FileName;
  s:=ChangeFileExt(s, '');

  ReadINI(izm2.opt, s+'.ini');
  izm2.int_list.Clear;
  izm2.int_list.LoadFromFile(s+'.txt');

end;

end.
