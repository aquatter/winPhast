unit UTreeParam;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ComCtrls, Unit2;

type
  TfTreeParam = class(TForm)
    TreeView1: TTreeView;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure TreeView1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormShow(Sender: TObject);
    procedure Button2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    iOldIndex : Integer;
    recparamTemp : trecParam;
    procedure SaveToRec(iPanel : Integer);
    procedure LoadFromRec(iPanel : Integer);    
  end;

var
  fTreeParam: TfTreeParam;

implementation

{$R *.dfm}

uses ULang, Unit1;

procedure TfTreeParam.FormCreate(Sender: TObject);
begin
  iOldIndex := 0;
end;

procedure TfTreeParam.Button1Click(Sender: TObject);
var
  sFileName : AnsiString;
begin
  SaveToRec(iOldIndex);
  Close;
  // перезагрузка баз
  if FormParam.recparam.s02 <> recparamTemp.s02 then begin
    sFileName := paramstr(0);
    sFileName := ExtractFilePath(sFileName);
    Form1.LoadArrayWOSet(4, sFileName + recparamTemp.s02 + '\base_1.bmp');
    Form1.LoadArrayWOSet(5, sFileName + recparamTemp.s02 + '\base_2.bmp');
    Form1.LoadArrayWOSet(6, sFileName + recparamTemp.s02 + '\base_3.bmp');
    Form1.LoadArrayWOSet(7, sFileName + recparamTemp.s02 + '\base_4.bmp');
    Form1.LoadArrayWOSet(8, sFileName + recparamTemp.s02 + '\k1.bin');
    Form1.LoadArrayWOSet(9, sFileName + recparamTemp.s02 + '\k2.bin');
    Form1.LoadArrayWOSet(10, sFileName + recparamTemp.s02 + '\k3.bin');
  end;
  FormParam.recparam := recparamTemp;
end;

procedure TfTreeParam.LoadFromRec(iPanel : Integer);
var
  labelTemp : TLabel;
  radiogroupTemp : TRadioGroup;
  checkboxTemp : TCheckBox;
  editTemp : TEdit;
  groupboxTemp : TGroupBox;
  comboboxTemp : TComboBox;
  iCount : Integer;
  eTemp : Extended;
begin
  case iPanel of
    0 : begin
      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := Panel1;
      checkboxTemp.Caption := slLang.Strings[102];
      checkboxTemp.Top := 10;
      checkboxTemp.Left := 20;
      checkboxTemp.Width := 180;
      checkboxTemp.Checked := recparamTemp.b09;
      checkboxTemp.Name := 'c01';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := Panel1;
      checkboxTemp.Caption := slLang.Strings[103];
      checkboxTemp.Top := 35;
      checkboxTemp.Left := 20;
      checkboxTemp.Width := 180;
      checkboxTemp.Checked := recparamTemp.b10;
      checkboxTemp.Name := 'c02';

      labelTemp := TLabel.Create(nil);
      labelTemp.Parent := Panel1;
      labelTemp.Caption := slLang.Strings[104] + ' :';
      labelTemp.Top := 90;
      labelTemp.Left := 10;
      labelTemp.Width := 180;
      labelTemp.Name := 'c03';

      editTemp := TEdit.Create(nil);
      editTemp.Parent := Panel1;
      editTemp.Text := recparamTemp.s01;
      editTemp.Top := 90;
      editTemp.Left := 220;
      editTemp.Name := 'c04';

      labelTemp := TLabel.Create(nil);
      labelTemp.Parent := Panel1;
      labelTemp.Caption := slLang.Strings[105] + ' :';
      labelTemp.Top := 115;
      labelTemp.Left := 10;
      labelTemp.Name := 'c05';

      editTemp := TEdit.Create(nil);
      editTemp.Parent := Panel1;
      editTemp.Text := IntToStr(recparamTemp.i12);
      editTemp.Top := 115;
      editTemp.Left := 220;
      editTemp.Name := 'c06';

      labelTemp := TLabel.Create(nil);
      labelTemp.Parent := Panel1;
      labelTemp.Caption := slLang.Strings[106] + ' :';
      labelTemp.Top := 140;
      labelTemp.Left := 10;
      labelTemp.Width := 180;
      labelTemp.Name := 'c07';

      editTemp := TEdit.Create(nil);
      editTemp.Parent := Panel1;
      editTemp.Text := IntToStr(recparamTemp.i13);
      editTemp.Top := 140;
      editTemp.Left := 220;
      editTemp.Name := 'c08';

      labelTemp := TLabel.Create(nil);
      labelTemp.Parent := Panel1;
      labelTemp.Caption := slLang.Strings[107] + ' :';
      labelTemp.Top := 165;
      labelTemp.Left := 10;
      labelTemp.Width := 180;
      labelTemp.Name := 'c09';

      editTemp := TEdit.Create(nil);
      editTemp.Parent := Panel1;
      editTemp.Text := recparamTemp.s03;
      editTemp.Top := 165;
      editTemp.Left := 220;
      editTemp.Name := 'c10';
    end;
    1 : begin
      labelTemp := TLabel.Create(nil);
      labelTemp.Parent := Panel1;
      labelTemp.Caption := slLang.Strings[110] + ' :';
      labelTemp.Top := 10;
      labelTemp.Left := 20;
      labelTemp.Width := 180;
      labelTemp.Name := 'c13';

      comboboxTemp := TComboBox.Create(nil);
      comboboxTemp.Parent := Panel1;
      comboboxTemp.Top := 10;
      comboboxTemp.Left := 200;
      comboboxTemp.Width := 170;      
      comboboxTemp.Items.Add(slLang.Strings[108]);
      comboboxTemp.Items.Add(slLang.Strings[109]);
      comboboxTemp.ItemIndex := recparamTemp.i01;
      comboboxTemp.Name := 'c01';
      comboboxTemp.Style := csDropDownList;

      labelTemp := TLabel.Create(nil);
      labelTemp.Parent := Panel1;
      labelTemp.Caption := slLang.Strings[111] + ' :';
      labelTemp.Top := 30;
      labelTemp.Left := 20;
      labelTemp.Width := 180;
      labelTemp.Name := 'c02';

      editTemp := TEdit.Create(nil);
      editTemp.Parent := Panel1;
      editTemp.Text := IntToStr(recparamTemp.i10);
      editTemp.Top := 30;
      editTemp.Left := 200;
      editTemp.Name := 'c03';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := Panel1;
      checkboxTemp.Caption := slLang.Strings[112];
      checkboxTemp.Top := 50;
      checkboxTemp.Left := 20;
      checkboxTemp.Width := 180;
      checkboxTemp.Checked := recparamTemp.b32;
      checkboxTemp.Name := 'c04';

      labelTemp := TLabel.Create(nil);
      labelTemp.Parent := Panel1;
      labelTemp.Caption := slLang.Strings[116] + ' :';
      labelTemp.Top := 70;
      labelTemp.Left := 20;
      labelTemp.Width := 180;
      labelTemp.Name := 'c14';

      comboboxTemp := TComboBox.Create(nil);
      comboboxTemp.Parent := Panel1;
      comboboxTemp.Top := 70;
      comboboxTemp.Left := 200;
      comboboxTemp.Width := 170;
      comboboxTemp.Items.Add(slLang.Strings[113]);
      comboboxTemp.Items.Add(slLang.Strings[114]);
      comboboxTemp.Items.Add(slLang.Strings[115]);
      comboboxTemp.Items.Add(slLang.Strings[188]);
      comboboxTemp.ItemIndex := recparamTemp.i02;
      comboboxTemp.Name := 'c05';
      comboboxTemp.Style := csDropDownList;

      labelTemp := TLabel.Create(nil);
      labelTemp.Parent := Panel1;
      labelTemp.Caption := slLang.Strings[189] + ' :';
      labelTemp.Top := 90;
      labelTemp.Left := 20;
      labelTemp.Width := 180;
      labelTemp.Name := 'c16';

      comboboxTemp := TComboBox.Create(nil);
      comboboxTemp.Parent := Panel1;
      comboboxTemp.Top := 90;
      comboboxTemp.Left := 200;
      comboboxTemp.Width := 170;
      comboboxTemp.Items.Add(slLang.Strings[117]);
      comboboxTemp.Items.Add(slLang.Strings[190]);
      comboboxTemp.Items.Add(slLang.Strings[191]);
      comboboxTemp.ItemIndex := recparamTemp.i40;
      comboboxTemp.Name := 'c06';
      comboboxTemp.Style := csDropDownList;

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := Panel1;
      checkboxTemp.Caption := slLang.Strings[118];
      checkboxTemp.Top := 110;
      checkboxTemp.Left := 20;
      checkboxTemp.Width := 180;
      checkboxTemp.Checked := recparamTemp.b02;
      checkboxTemp.Name := 'c07';

      labelTemp := TLabel.Create(nil);
      labelTemp.Parent := Panel1;
      labelTemp.Caption := slLang.Strings[164] + ' :';
      labelTemp.Top := 130;
      labelTemp.Left := 20;
      labelTemp.Width := 180;
      labelTemp.Name := 'c08';

      comboboxTemp := TComboBox.Create(nil);
      comboboxTemp.Parent := Panel1;
      comboboxTemp.Top := 130;
      comboboxTemp.Left := 200;
      comboboxTemp.Width := 170;
      comboboxTemp.Items.Add('0°');
      comboboxTemp.Items.Add('90°');
      comboboxTemp.Items.Add('180°');
      comboboxTemp.Items.Add('270°');
      comboboxTemp.ItemIndex := recparamTemp.i37;
      comboboxTemp.Name := 'c09';
      comboboxTemp.Style := csDropDownList;

      labelTemp := TLabel.Create(nil);
      labelTemp.Parent := Panel1;
      labelTemp.Caption := slLang.Strings[165] + ' :';
      labelTemp.Top := 150;
      labelTemp.Left := 20;
      labelTemp.Width := 180;
      labelTemp.Name := 'c10';

      comboboxTemp := TComboBox.Create(nil);
      comboboxTemp.Parent := Panel1;
      comboboxTemp.Top := 150;
      comboboxTemp.Left := 200;
      comboboxTemp.Width := 170;
      comboboxTemp.Items.Add('No');
      comboboxTemp.Items.Add(slLang.Strings[166] + ' X');
      comboboxTemp.Items.Add(slLang.Strings[166] + ' Y');
      comboboxTemp.ItemIndex := recparamTemp.i38;
      comboboxTemp.Name := 'c11';
      comboboxTemp.Style := csDropDownList;

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := Panel1;
      checkboxTemp.Caption := slLang.Strings[183];
      checkboxTemp.Top := 170;
      checkboxTemp.Left := 20;
      checkboxTemp.Width := 180;
      checkboxTemp.Checked := recparamTemp.b40;
      checkboxTemp.Name := 'c12';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := Panel1;
      checkboxTemp.Caption := slLang.Strings[187];
      checkboxTemp.Top := 190;
      checkboxTemp.Left := 20;
      checkboxTemp.Width := 180;
      checkboxTemp.Checked := recparamTemp.b43;
      checkboxTemp.Name := 'c15';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := Panel1;
      checkboxTemp.Caption := slLang.Strings[202];
      checkboxTemp.Top := 210;
      checkboxTemp.Left := 20;
      checkboxTemp.Width := 180;
      checkboxTemp.Checked := recparamTemp.b01;
      checkboxTemp.Name := 'c17';
    end;
    2 : begin
      radiogroupTemp := TRadioGroup.Create(nil);
      radiogroupTemp.Parent := Panel1;
      radiogroupTemp.Top := 10;
      radiogroupTemp.Left := 10;
      radiogroupTemp.Height := 75;
      radiogroupTemp.Items.Add(slLang.Strings[119]);
      radiogroupTemp.Items.Add(slLang.Strings[120]);
      radiogroupTemp.Items.Add(slLang.Strings[121]);
      radiogroupTemp.Caption := slLang.Strings[122];
      radiogroupTemp.ItemIndex := recparamTemp.i03;
      radiogroupTemp.Name := 'c01';

      radiogroupTemp := TRadioGroup.Create(nil);
      radiogroupTemp.Parent := Panel1;
      radiogroupTemp.Top := 85;
      radiogroupTemp.Left := 10;
      radiogroupTemp.Height := 50;
      radiogroupTemp.Width := 75;
      radiogroupTemp.Items.Add('+1');
      radiogroupTemp.Items.Add('-1');
      radiogroupTemp.Caption := slLang.Strings[123];
      radiogroupTemp.ItemIndex := recparamTemp.i04;
      radiogroupTemp.Name := 'c02';

      radiogroupTemp := TRadioGroup.Create(nil);
      radiogroupTemp.Parent := Panel1;
      radiogroupTemp.Top := 85;
      radiogroupTemp.Left := 85;
      radiogroupTemp.Height := 50;
      radiogroupTemp.Width := 75;
      radiogroupTemp.Items.Add('+1');
      radiogroupTemp.Items.Add('-1');
      radiogroupTemp.Caption := slLang.Strings[124];
      radiogroupTemp.ItemIndex := recparamTemp.i05;
      radiogroupTemp.Name := 'c03';

      radiogroupTemp := TRadioGroup.Create(nil);
      radiogroupTemp.Parent := Panel1;
      radiogroupTemp.Top := 85;
      radiogroupTemp.Left := 160;
      radiogroupTemp.Height := 50;
      radiogroupTemp.Width := 75;
      radiogroupTemp.Items.Add('+1');
      radiogroupTemp.Items.Add('-1');
      radiogroupTemp.Caption := slLang.Strings[125];
      radiogroupTemp.ItemIndex := recparamTemp.i06;
      radiogroupTemp.Name := 'c04';

      radiogroupTemp := TRadioGroup.Create(nil);
      radiogroupTemp.Parent := Panel1;
      radiogroupTemp.Top := 135;
      radiogroupTemp.Left := 10;
      radiogroupTemp.Height := 75;
      radiogroupTemp.Items.Add(slLang.Strings[126]);
      radiogroupTemp.Items.Add(slLang.Strings[127]);
      radiogroupTemp.Items.Add(slLang.Strings[175]);
      radiogroupTemp.Caption := slLang.Strings[128];
      radiogroupTemp.ItemIndex := recparamTemp.i07;
      radiogroupTemp.Name := 'c05';

      labelTemp := TLabel.Create(nil);
      labelTemp.Parent := Panel1;
      labelTemp.Caption := slLang.Strings[182] + ' :';
      labelTemp.Top := 210;
      labelTemp.Left := 10;
      labelTemp.Width := 180;
      labelTemp.Name := 'c11';

      comboboxTemp := TComboBox.Create(nil);
      comboboxTemp.Parent := Panel1;
      comboboxTemp.Top := 210;
      comboboxTemp.Left := 220;
      comboboxTemp.Items.Add(slLang.Strings[178]);
      comboboxTemp.Items.Add(slLang.Strings[181]);
      if recparamTemp.b39 then comboboxTemp.ItemIndex := 0
      else comboboxTemp.ItemIndex := 1;
      comboboxTemp.Name := 'c06';
      comboboxTemp.Style := csDropDownList;

      labelTemp := TLabel.Create(nil);
      labelTemp.Parent := Panel1;
      labelTemp.Caption := slLang.Strings[179];
      labelTemp.Top := 235;
      labelTemp.Left := 10;
      labelTemp.Width := 180;
      labelTemp.Name := 'c07';

      editTemp := TEdit.Create(nil);
      editTemp.Parent := Panel1;
      eTemp := recparamTemp.f04;
      editTemp.Text := FloatToStr(recparamTemp.f04);
      editTemp.Top := 235;
      editTemp.Left := 220;
      editTemp.Name := 'c08';

      labelTemp := TLabel.Create(nil);
      labelTemp.Parent := Panel1;
      labelTemp.Caption := slLang.Strings[180];
      labelTemp.Top := 260;
      labelTemp.Left := 10;
      labelTemp.Width := 180;
      labelTemp.Name := 'c09';

      editTemp := TEdit.Create(nil);
      editTemp.Parent := Panel1;
      editTemp.Text := FloatToStr(recparamTemp.f05);
      editTemp.Top := 260;
      editTemp.Left := 220;
      editTemp.Name := 'c10';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := Panel1;
      checkboxTemp.Caption := slLang.Strings[184];
      checkboxTemp.Top := 275;
      checkboxTemp.Left := 20;
      checkboxTemp.Width := 180;
      checkboxTemp.Checked := recparamTemp.b41;
      checkboxTemp.Name := 'c12';
    end;
    3 : begin
      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := Panel1;
      checkboxTemp.Caption := slLang.Strings[129];
      checkboxTemp.Top := 10;
      checkboxTemp.Left := 20;
      checkboxTemp.Width := 180;
      checkboxTemp.Checked := recparamTemp.b03;
      checkboxTemp.Name := 'c01';

      radiogroupTemp := TRadioGroup.Create(nil);
      radiogroupTemp.Parent := Panel1;
      radiogroupTemp.Top := 35;
      radiogroupTemp.Left := 10;
      radiogroupTemp.Height := 50;
      radiogroupTemp.Items.Add(slLang.Strings[130]);
      radiogroupTemp.Items.Add(slLang.Strings[131]);
      radiogroupTemp.Caption := slLang.Strings[132];
      radiogroupTemp.ItemIndex := recparamTemp.i08;
      radiogroupTemp.Name := 'c02';
    end;
    4 : begin
      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := Panel1;
      checkboxTemp.Caption := slLang.Strings[133];
      checkboxTemp.Top := 10;
      checkboxTemp.Left := 20;
      checkboxTemp.Width := 100;
      checkboxTemp.Checked := recparamTemp.b04;
      checkboxTemp.Name := 'c01';

      labelTemp := TLabel.Create(nil);
      labelTemp.Parent := Panel1;
      labelTemp.Caption := slLang.Strings[134];
      labelTemp.Top := 10;
      labelTemp.Left := 130;
      labelTemp.Width := 180;
      labelTemp.Name := 'c02';

      editTemp := TEdit.Create(nil);
      editTemp.Parent := Panel1;
      editTemp.Text := IntToStr(recparamTemp.i09);
      editTemp.Top := 10;
      editTemp.Left := 220;
      editTemp.Name := 'c03';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := Panel1;
      checkboxTemp.Caption := slLang.Strings[185];
      checkboxTemp.Top := 30;
      checkboxTemp.Left := 20;
      checkboxTemp.Width := 100;
      checkboxTemp.Checked := recparamTemp.b42;
      checkboxTemp.Name := 'c16';

      labelTemp := TLabel.Create(nil);
      labelTemp.Parent := Panel1;
      labelTemp.Caption := slLang.Strings[186];
      labelTemp.Top := 30;
      labelTemp.Left := 130;
      labelTemp.Width := 180;
      labelTemp.Name := 'c17';

      editTemp := TEdit.Create(nil);
      editTemp.Parent := Panel1;
      editTemp.Text := IntToStr(recparamTemp.i39);
      editTemp.Top := 30;
      editTemp.Left := 220;
      editTemp.Name := 'c18';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := Panel1;
      checkboxTemp.Caption := slLang.Strings[135];
      checkboxTemp.Top := 50;
      checkboxTemp.Left := 20;
      checkboxTemp.Width := 180;
      checkboxTemp.Checked := recparamTemp.b05;
      checkboxTemp.Name := 'c04';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := Panel1;
      checkboxTemp.Caption := slLang.Strings[136];
      checkboxTemp.Top := 70;
      checkboxTemp.Left := 20;
      checkboxTemp.Width := 180;
      checkboxTemp.Checked := recparamTemp.b06;
      checkboxTemp.Name := 'c05';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := Panel1;
      checkboxTemp.Caption := slLang.Strings[137];
      checkboxTemp.Top := 100;
      checkboxTemp.Left := 20;
      checkboxTemp.Width := 170;
      checkboxTemp.Checked := recparamTemp.b07;
      checkboxTemp.Name := 'c06';

      labelTemp := TLabel.Create(nil);
      labelTemp.Parent := Panel1;
      labelTemp.Caption := 'A :';
      labelTemp.Top := 90;
      labelTemp.Left := 200;
      labelTemp.Width := 180;
      labelTemp.Name := 'c07';

      editTemp := TEdit.Create(nil);
      editTemp.Parent := Panel1;
      editTemp.Text := FloatToStr(recparamTemp.f01);
      editTemp.Top := 90;
      editTemp.Left := 220;
      editTemp.Name := 'c08';

      labelTemp := TLabel.Create(nil);
      labelTemp.Parent := Panel1;
      labelTemp.Caption := 'B :';
      labelTemp.Top := 110;
      labelTemp.Left := 200;
      labelTemp.Width := 180;
      labelTemp.Name := 'c09';

      editTemp := TEdit.Create(nil);
      editTemp.Parent := Panel1;
      editTemp.Text := FloatToStr(recparamTemp.f02);
      editTemp.Top := 110;
      editTemp.Left := 220;
      editTemp.Name := 'c10';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := Panel1;
      checkboxTemp.Caption := slLang.Strings[138];
      checkboxTemp.Top := 130;
      checkboxTemp.Left := 20;
      checkboxTemp.Width := 140;
      checkboxTemp.Checked := recparamTemp.b08;
      checkboxTemp.Name := 'c11';

      labelTemp := TLabel.Create(nil);
      labelTemp.Parent := Panel1;
      labelTemp.Caption := slLang.Strings[139] + ' :';
      labelTemp.Top := 130;
      labelTemp.Left := 160;
      labelTemp.Width := 180;
      labelTemp.Name := 'c12';

      editTemp := TEdit.Create(nil);
      editTemp.Parent := Panel1;
      editTemp.Text := IntToStr(recparamTemp.i11);
      editTemp.Top := 130;
      editTemp.Left := 220;
      editTemp.Name := 'c13';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := Panel1;
      checkboxTemp.Caption := slLang.Strings[173];
      checkboxTemp.Top := 150;
      checkboxTemp.Left := 20;
      checkboxTemp.Width := 180;
      checkboxTemp.Checked := recparamTemp.b37;
      checkboxTemp.Name := 'c14';

    end;
    5 : begin
      groupboxTemp := TGroupBox.Create(nil);
      groupboxTemp.Parent := Panel1;
      groupboxTemp.Caption := slLang.Strings[140];
      groupboxTemp.Left := 10;
      groupboxTemp.Top := 10;
      groupboxTemp.Height := 140;
      groupboxTemp.Width := 160;
      groupboxTemp.Name := 'c01';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := groupboxTemp;
      checkboxTemp.Caption := 'Windows bitmap, *.bmp';
      checkboxTemp.Top := 15;
      checkboxTemp.Left := 10;
      checkboxTemp.Width := 140;
      checkboxTemp.Checked := recparamTemp.b11;
      checkboxTemp.Name := 'c02';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := groupboxTemp;
      checkboxTemp.Caption := 'Jpeg, *.jpg';
      checkboxTemp.Top := 30;
      checkboxTemp.Left := 10;
      checkboxTemp.Width := 140;
      checkboxTemp.Checked := recparamTemp.b12;
      checkboxTemp.Name := 'c03';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := groupboxTemp;
      checkboxTemp.Caption := 'Phast image, *.img';
      checkboxTemp.Top := 45;
      checkboxTemp.Left := 10;
      checkboxTemp.Width := 140;
      checkboxTemp.Checked := recparamTemp.b13;
      checkboxTemp.Name := 'c04';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := groupboxTemp;
      checkboxTemp.Caption := 'Phast ascii, *.phasc';
      checkboxTemp.Top := 60;
      checkboxTemp.Left := 10;
      checkboxTemp.Width := 140;
      checkboxTemp.Checked := recparamTemp.b14;
      checkboxTemp.Name := 'c05';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := groupboxTemp;
      checkboxTemp.Caption := 'Smtcam float bin, *.bin';
      checkboxTemp.Top := 75;
      checkboxTemp.Left := 10;
      checkboxTemp.Width := 140;
      checkboxTemp.Checked := recparamTemp.b15;
      checkboxTemp.Name := 'c06';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := groupboxTemp;
      checkboxTemp.Caption := 'Smtcam byte bin, *.bn2';
      checkboxTemp.Top := 90;
      checkboxTemp.Left := 10;
      checkboxTemp.Width := 140;
      checkboxTemp.Checked := recparamTemp.b16;
      checkboxTemp.Name := 'c07';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := groupboxTemp;
      checkboxTemp.Caption := 'Mathcad prn, *.prn';
      checkboxTemp.Top := 105;
      checkboxTemp.Left := 10;
      checkboxTemp.Width := 140;
      checkboxTemp.Checked := recparamTemp.b17;
      checkboxTemp.Name := 'c08';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := groupboxTemp;
      checkboxTemp.Caption := 'German ascii, *.asc';
      checkboxTemp.Top := 120;
      checkboxTemp.Left := 10;
      checkboxTemp.Width := 140;
      checkboxTemp.Checked := recparamTemp.b18;
      checkboxTemp.Name := 'c09';

      groupboxTemp := TGroupBox.Create(nil);
      groupboxTemp.Parent := Panel1;
      groupboxTemp.Caption := slLang.Strings[141];
      groupboxTemp.Left := 170;
      groupboxTemp.Top := 10;
      groupboxTemp.Height := 140;
      groupboxTemp.Width := 160;
      groupboxTemp.Name := 'c10';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := groupboxTemp;
      checkboxTemp.Caption := 'Windows bitmap, *.bmp';
      checkboxTemp.Top := 15;
      checkboxTemp.Left := 10;
      checkboxTemp.Width := 140;
      checkboxTemp.Checked := recparamTemp.b19;
      checkboxTemp.Name := 'c11';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := groupboxTemp;
      checkboxTemp.Caption := 'Jpeg, *.jpg';
      checkboxTemp.Top := 30;
      checkboxTemp.Left := 10;
      checkboxTemp.Width := 140;
      checkboxTemp.Checked := recparamTemp.b20;
      checkboxTemp.Name := 'c12';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := groupboxTemp;
      checkboxTemp.Caption := 'Phast image, *.img';
      checkboxTemp.Top := 45;
      checkboxTemp.Left := 10;
      checkboxTemp.Width := 140;
      checkboxTemp.Checked := recparamTemp.b21;
      checkboxTemp.Name := 'c13';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := groupboxTemp;
      checkboxTemp.Caption := 'Phast ascii, *.phasc';
      checkboxTemp.Top := 60;
      checkboxTemp.Left := 10;
      checkboxTemp.Width := 140;
      checkboxTemp.Checked := recparamTemp.b22;
      checkboxTemp.Name := 'c14';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := groupboxTemp;
      checkboxTemp.Caption := 'Smtcam float bin, *.bin';
      checkboxTemp.Top := 75;
      checkboxTemp.Left := 10;
      checkboxTemp.Width := 140;
      checkboxTemp.Checked := recparamTemp.b23;
      checkboxTemp.Name := 'c15';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := groupboxTemp;
      checkboxTemp.Caption := 'Smtcam byte bin, *.bn2';
      checkboxTemp.Top := 90;
      checkboxTemp.Left := 10;
      checkboxTemp.Width := 140;
      checkboxTemp.Checked := recparamTemp.b24;
      checkboxTemp.Name := 'c16';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := groupboxTemp;
      checkboxTemp.Caption := 'Mathcad prn, *.prn';
      checkboxTemp.Top := 105;
      checkboxTemp.Left := 10;
      checkboxTemp.Width := 140;
      checkboxTemp.Checked := recparamTemp.b25;
      checkboxTemp.Name := 'c17';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := groupboxTemp;
      checkboxTemp.Caption := 'German ascii, *.asc';
      checkboxTemp.Top := 120;
      checkboxTemp.Left := 10;
      checkboxTemp.Width := 140;
      checkboxTemp.Checked := recparamTemp.b26;
      checkboxTemp.Name := 'c18';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := Panel1;
      checkboxTemp.Caption := slLang.Strings[142];
      checkboxTemp.Top := 150;
      checkboxTemp.Left := 20;
      checkboxTemp.Width := 180;
      checkboxTemp.Checked := recparamTemp.b27;
      checkboxTemp.Name := 'c19';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := Panel1;
      checkboxTemp.Caption := slLang.Strings[197];
      checkboxTemp.Top := 170;
      checkboxTemp.Left := 20;
      checkboxTemp.Width := 220;
      checkboxTemp.Checked := recparamTemp.b38;
      checkboxTemp.Name := 'c22';

      labelTemp := TLabel.Create(nil);
      labelTemp.Parent := Panel1;
      labelTemp.Caption := slLang.Strings[143] + ' :';
      labelTemp.Top := 190;
      labelTemp.Left := 10;
      labelTemp.Width := 180;
      labelTemp.Name := 'c20';

      editTemp := TEdit.Create(nil);
      editTemp.Parent := Panel1;
      editTemp.Text := recparamTemp.s02;
      editTemp.Top := 190;
      editTemp.Left := 220;
      editTemp.Name := 'c21';
    end;
    6 : begin
      labelTemp := TLabel.Create(nil);
      labelTemp.Parent := Panel1;
      labelTemp.Caption := slLang.Strings[147] + ' :';
      labelTemp.Top := 10;
      labelTemp.Left := 10;
      labelTemp.Width := 180;
      labelTemp.Name := 'c15';

      comboboxTemp := TComboBox.Create(nil);
      comboboxTemp.Parent := Panel1;
      comboboxTemp.Top := 10;
      comboboxTemp.Left := 220;
      comboboxTemp.Items.Add(slLang.Strings[144]);
      comboboxTemp.Items.Add(slLang.Strings[145]);
      comboboxTemp.Items.Add(slLang.Strings[146]);
      comboboxTemp.Items.Add(slLang.Strings[176]);
      comboboxTemp.ItemIndex := recparamTemp.i14;
      comboboxTemp.Name := 'c01';
      comboboxTemp.Style := csDropDownList;

      labelTemp := TLabel.Create(nil);
      labelTemp.Parent := Panel1;
      labelTemp.Caption := slLang.Strings[148] + ' :';
      labelTemp.Top := 30;
      labelTemp.Left := 10;
      labelTemp.Width := 180;
      labelTemp.Name := 'c02';

      comboboxTemp := TComboBox.Create(nil);
      comboboxTemp.Parent := Panel1;
      comboboxTemp.Top := 30;
      comboboxTemp.Left := 220;
      comboboxTemp.Items.Add(slLang.Strings[149]);
      comboboxTemp.Items.Add(slLang.Strings[150]);
      comboboxTemp.Items.Add(slLang.Strings[151]);
      comboboxTemp.Items.Add(slLang.Strings[152]);
      comboboxTemp.Items.Add(slLang.Strings[153]);
      comboboxTemp.Items.Add(slLang.Strings[154]);
      comboboxTemp.Items.Add(slLang.Strings[155]);
      comboboxTemp.ItemIndex := recparamTemp.i15;
      comboboxTemp.Name := 'c03';
      comboboxTemp.Style := csDropDownList;

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := Panel1;
      checkboxTemp.Caption := slLang.Strings[156];
      checkboxTemp.Top := 50;
      checkboxTemp.Left := 10;
      checkboxTemp.Width := 180;
      checkboxTemp.Checked := recparamTemp.b28;
      checkboxTemp.Name := 'c04';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := Panel1;
      checkboxTemp.Caption := slLang.Strings[157];
      checkboxTemp.Top := 70;
      checkboxTemp.Left := 10;
      checkboxTemp.Width := 180;
      checkboxTemp.Checked := recparamTemp.b29;
      checkboxTemp.Name := 'c05';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := Panel1;
      checkboxTemp.Caption := slLang.Strings[158];
      checkboxTemp.Top := 90;
      checkboxTemp.Left := 10;
      checkboxTemp.Width := 180;
      checkboxTemp.Checked := recparamTemp.b30;
      checkboxTemp.Name := 'c06';

      editTemp := TEdit.Create(nil);
      editTemp.Parent := Panel1;
      editTemp.Text := IntToStr(recparamTemp.i16);
      editTemp.Top := 90;
      editTemp.Left := 220;
      editTemp.Name := 'c08';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := Panel1;
      checkboxTemp.Caption := slLang.Strings[160];
      checkboxTemp.Top := 110;
      checkboxTemp.Left := 10;
      checkboxTemp.Width := 180;
      checkboxTemp.Checked := recparamTemp.b31;
      checkboxTemp.Name := 'c09';

      editTemp := TEdit.Create(nil);
      editTemp.Parent := Panel1;
      editTemp.Text := IntToStr(recparamTemp.i17);
      editTemp.Top := 110;
      editTemp.Left := 220;
      editTemp.Name := 'c11';

      checkboxTemp := TCheckBox.Create(nil);
      checkboxTemp.Parent := Panel1;
      checkboxTemp.Caption := slLang.Strings[161];
      checkboxTemp.Top := 130;
      checkboxTemp.Left := 10;
      checkboxTemp.Width := 180;
      checkboxTemp.Checked := recparamTemp.b33;
      checkboxTemp.Name := 'c12';

      labelTemp := TLabel.Create(nil);
      labelTemp.Parent := Panel1;
      labelTemp.Caption := slLang.Strings[162] + ' :';
      labelTemp.Top := 150;
      labelTemp.Left := 10;
      labelTemp.Width := 180;
      labelTemp.Name := 'c13';

      editTemp := TEdit.Create(nil);
      editTemp.Parent := Panel1;
      editTemp.Text := recparamTemp.s04;
      editTemp.Top := 150;
      editTemp.Left := 220;
      editTemp.Name := 'c14';

      labelTemp := TLabel.Create(nil);
      labelTemp.Parent := Panel1;
      labelTemp.Caption := slLang.Strings[198] + ' :';
      labelTemp.Top := 170;
      labelTemp.Left := 10;
      labelTemp.Width := 180;
      labelTemp.Name := 'c15';

      comboboxTemp := TComboBox.Create(nil);
      comboboxTemp.Parent := Panel1;
      comboboxTemp.Top := 170;
      comboboxTemp.Left := 220;
      comboboxTemp.Items.Add(slLang.Strings[199]);
      comboboxTemp.Items.Add(slLang.Strings[200]);
      comboboxTemp.Items.Add(slLang.Strings[201]);
      comboboxTemp.ItemIndex := recparamTemp.i45;
      comboboxTemp.Name := 'c16';
      comboboxTemp.Style := csDropDownList;
    end;
  end;
end;

procedure TfTreeParam.SaveToRec(iPanel : Integer);
var
  iCount2, iCount : Integer;
  groupboxTemp : TGroupBox;
begin
  case iPanel of
    0 :  for iCount := 0 to Panel1.ControlCount - 1 do begin
      if Panel1.Controls[iCount].Name = 'c01' then
        recparamTemp.b09 := TCheckBox(Panel1.Controls[iCount]).Checked;
      if Panel1.Controls[iCount].Name = 'c02' then
        recparamTemp.b10 := TCheckBox(Panel1.Controls[iCount]).Checked;
      if Panel1.Controls[iCount].Name = 'c04' then
        recparamTemp.s01 := TEdit(Panel1.Controls[iCount]).Text;
      if Panel1.Controls[iCount].Name = 'c06' then
        recparamTemp.i12 := StrToInt(TEdit(Panel1.Controls[iCount]).Text);
      if Panel1.Controls[iCount].Name = 'c08' then
        recparamTemp.i13 := StrToInt(TEdit(Panel1.Controls[iCount]).Text);
      if Panel1.Controls[iCount].Name = 'c10' then
        recparamTemp.s03 := TEdit(Panel1.Controls[iCount]).Text;
    end;
    1 : for iCount := 0 to Panel1.ControlCount - 1 do begin
      if Panel1.Controls[iCount].Name = 'c01' then
        recparamTemp.i01 := TComboBox(Panel1.Controls[iCount]).ItemIndex;
      if Panel1.Controls[iCount].Name = 'c03' then
        recparamTemp.i10 := StrToInt(TEdit(Panel1.Controls[iCount]).Text);
      if Panel1.Controls[iCount].Name = 'c04' then
        recparamTemp.b32 := TCheckBox(Panel1.Controls[iCount]).Checked;
      if Panel1.Controls[iCount].Name = 'c05' then
        recparamTemp.i02 := TComboBox(Panel1.Controls[iCount]).ItemIndex;
      if Panel1.Controls[iCount].Name = 'c06' then
        recparamTemp.i40 := TComboBox(Panel1.Controls[iCount]).ItemIndex;
      if Panel1.Controls[iCount].Name = 'c07' then
        recparamTemp.b02 := TCheckBox(Panel1.Controls[iCount]).Checked;
      if Panel1.Controls[iCount].Name = 'c09' then
        recparamTemp.i37 := TComboBox(Panel1.Controls[iCount]).ItemIndex;
      if Panel1.Controls[iCount].Name = 'c11' then
        recparamTemp.i38 := TComboBox(Panel1.Controls[iCount]).ItemIndex;
      if Panel1.Controls[iCount].Name = 'c12' then
        recparamTemp.b40 := TCheckBox(Panel1.Controls[iCount]).Checked;
      if Panel1.Controls[iCount].Name = 'c15' then
        recparamTemp.b43 := TCheckBox(Panel1.Controls[iCount]).Checked;
      if Panel1.Controls[iCount].Name = 'c17' then
        recparamTemp.b01 := TCheckBox(Panel1.Controls[iCount]).Checked;
    end;
    2 :  for iCount := 0 to Panel1.ControlCount - 1 do begin
      if Panel1.Controls[iCount].Name = 'c01' then
        recparamTemp.i03 := TRadioGroup(Panel1.Controls[iCount]).ItemIndex;
      if Panel1.Controls[iCount].Name = 'c02' then
        recparamTemp.i04 := TRadioGroup(Panel1.Controls[iCount]).ItemIndex;
      if Panel1.Controls[iCount].Name = 'c03' then
        recparamTemp.i05 := TRadioGroup(Panel1.Controls[iCount]).ItemIndex;
      if Panel1.Controls[iCount].Name = 'c04' then
        recparamTemp.i06 := TRadioGroup(Panel1.Controls[iCount]).ItemIndex;
      if Panel1.Controls[iCount].Name = 'c05' then
        recparamTemp.i07 := TRadioGroup(Panel1.Controls[iCount]).ItemIndex;
      if Panel1.Controls[iCount].Name = 'c06' then begin
        if TComboBox(Panel1.Controls[iCount]).ItemIndex = 0 then
          recparamTemp.b39 := True else recparamTemp.b39 := False;
      end;
      if Panel1.Controls[iCount].Name = 'c08' then
        recparamTemp.f04 := StrToFloat(TEdit(Panel1.Controls[iCount]).Text);
      if Panel1.Controls[iCount].Name = 'c10' then
        recparamTemp.f05 := StrToFloat(TEdit(Panel1.Controls[iCount]).Text);
      if Panel1.Controls[iCount].Name = 'c12' then
        recparamTemp.b41 := TCheckBox(Panel1.Controls[iCount]).Checked;
    end;
    3 : for iCount := 0 to Panel1.ControlCount - 1 do begin
      if Panel1.Controls[iCount].Name = 'c01' then
        recparamTemp.b03 := TCheckBox(Panel1.Controls[iCount]).Checked;
      if Panel1.Controls[iCount].Name = 'c02' then
        recparamTemp.i08 := TRadioGroup(Panel1.Controls[iCount]).ItemIndex;
    end;
    4 : for iCount := 0 to Panel1.ControlCount - 1 do begin
      if Panel1.Controls[iCount].Name = 'c01' then
        recparamTemp.b04 := TCheckBox(Panel1.Controls[iCount]).Checked;
      if Panel1.Controls[iCount].Name = 'c03' then
        recparamTemp.i09 := StrToInt(TEdit(Panel1.Controls[iCount]).Text);
      if Panel1.Controls[iCount].Name = 'c16' then
        recparamTemp.b42 := TCheckBox(Panel1.Controls[iCount]).Checked;
      if Panel1.Controls[iCount].Name = 'c18' then
        recparamTemp.i39 := StrToInt(TEdit(Panel1.Controls[iCount]).Text);
      if Panel1.Controls[iCount].Name = 'c04' then
        recparamTemp.b05 := TCheckBox(Panel1.Controls[iCount]).Checked;
      if Panel1.Controls[iCount].Name = 'c05' then
        recparamTemp.b06 := TCheckBox(Panel1.Controls[iCount]).Checked;
      if Panel1.Controls[iCount].Name = 'c06' then
        recparamTemp.b07 := TCheckBox(Panel1.Controls[iCount]).Checked;
      if Panel1.Controls[iCount].Name = 'c08' then
        recparamTemp.f01 := StrToFloat(TEdit(Panel1.Controls[iCount]).Text);
      if Panel1.Controls[iCount].Name = 'c10' then
        recparamTemp.f02 := StrToFloat(TEdit(Panel1.Controls[iCount]).Text);
      if Panel1.Controls[iCount].Name = 'c11' then
        recparamTemp.b08 := TCheckBox(Panel1.Controls[iCount]).Checked;
      if Panel1.Controls[iCount].Name = 'c13' then
        recparamTemp.i11 := StrToInt(TEdit(Panel1.Controls[iCount]).Text);
      if Panel1.Controls[iCount].Name = 'c14' then
        recparamTemp.b37 := TCheckBox(Panel1.Controls[iCount]).Checked;
    end;
    5 : for iCount := 0 to Panel1.ControlCount - 1 do begin
      if Panel1.Controls[iCount].Name = 'c22' then
        recparamTemp.b38 := TCheckBox(Panel1.Controls[iCount]).Checked;
      if Panel1.Controls[iCount].Name = 'c19' then
        recparamTemp.b27 := TCheckBox(Panel1.Controls[iCount]).Checked;
      if Panel1.Controls[iCount].Name = 'c21' then
        recparamTemp.s02 := TEdit(Panel1.Controls[iCount]).Text;
      if Panel1.Controls[iCount].Name = 'c01' then begin
        groupboxTemp := TGroupBox(Panel1.Controls[iCount]);
        for iCount2 := 0 to groupboxTemp.ControlCount - 1 do begin
          if groupboxTemp.Controls[iCount2].Name = 'c02' then
            recparamTemp.b11 := TCheckBox(groupboxTemp.Controls[iCount2]).Checked;
          if groupboxTemp.Controls[iCount2].Name = 'c03' then
            recparamTemp.b12 := TCheckBox(groupboxTemp.Controls[iCount2]).Checked;
          if groupboxTemp.Controls[iCount2].Name = 'c04' then
            recparamTemp.b13 := TCheckBox(groupboxTemp.Controls[iCount2]).Checked;
          if groupboxTemp.Controls[iCount2].Name = 'c05' then
            recparamTemp.b14 := TCheckBox(groupboxTemp.Controls[iCount2]).Checked;
          if groupboxTemp.Controls[iCount2].Name = 'c06' then
            recparamTemp.b15 := TCheckBox(groupboxTemp.Controls[iCount2]).Checked;
          if groupboxTemp.Controls[iCount2].Name = 'c07' then
            recparamTemp.b16 := TCheckBox(groupboxTemp.Controls[iCount2]).Checked;
          if groupboxTemp.Controls[iCount2].Name = 'c08' then
            recparamTemp.b17 := TCheckBox(groupboxTemp.Controls[iCount2]).Checked;
          if groupboxTemp.Controls[iCount2].Name = 'c09' then
            recparamTemp.b18 := TCheckBox(groupboxTemp.Controls[iCount2]).Checked;
        end;
      end;
      if Panel1.Controls[iCount].Name = 'c10' then begin
        groupboxTemp := TGroupBox(Panel1.Controls[iCount]);
        for iCount2 := 0 to groupboxTemp.ControlCount - 1 do begin
          if groupboxTemp.Controls[iCount2].Name = 'c11' then
            recparamTemp.b19 := TCheckBox(groupboxTemp.Controls[iCount2]).Checked;
          if groupboxTemp.Controls[iCount2].Name = 'c12' then
            recparamTemp.b20 := TCheckBox(groupboxTemp.Controls[iCount2]).Checked;
          if groupboxTemp.Controls[iCount2].Name = 'c13' then
            recparamTemp.b21 := TCheckBox(groupboxTemp.Controls[iCount2]).Checked;
          if groupboxTemp.Controls[iCount2].Name = 'c14' then
            recparamTemp.b22 := TCheckBox(groupboxTemp.Controls[iCount2]).Checked;
          if groupboxTemp.Controls[iCount2].Name = 'c15' then
            recparamTemp.b23 := TCheckBox(groupboxTemp.Controls[iCount2]).Checked;
          if groupboxTemp.Controls[iCount2].Name = 'c16' then
            recparamTemp.b24 := TCheckBox(groupboxTemp.Controls[iCount2]).Checked;
          if groupboxTemp.Controls[iCount2].Name = 'c17' then
            recparamTemp.b25 := TCheckBox(groupboxTemp.Controls[iCount2]).Checked;
          if groupboxTemp.Controls[iCount2].Name = 'c18' then
            recparamTemp.b26 := TCheckBox(groupboxTemp.Controls[iCount2]).Checked;
        end;
      end;
    end;
    6 : for iCount := 0 to Panel1.ControlCount - 1 do begin
      if Panel1.Controls[iCount].Name = 'c16' then
        recparamTemp.i45 := TComboBox(Panel1.Controls[iCount]).ItemIndex;
      if Panel1.Controls[iCount].Name = 'c01' then
        recparamTemp.i14 := TComboBox(Panel1.Controls[iCount]).ItemIndex;
      if Panel1.Controls[iCount].Name = 'c03' then
        recparamTemp.i15 := TComboBox(Panel1.Controls[iCount]).ItemIndex;
      if Panel1.Controls[iCount].Name = 'c04' then
        recparamTemp.b28 := TCheckBox(Panel1.Controls[iCount]).Checked;
      if Panel1.Controls[iCount].Name = 'c05' then
        recparamTemp.b29 := TCheckBox(Panel1.Controls[iCount]).Checked;
      if Panel1.Controls[iCount].Name = 'c06' then
        recparamTemp.b30 := TCheckBox(Panel1.Controls[iCount]).Checked;
      if Panel1.Controls[iCount].Name = 'c08' then
        recparamTemp.i16 := StrToInt(TEdit(Panel1.Controls[iCount]).Text);
      if Panel1.Controls[iCount].Name = 'c09' then
        recparamTemp.b31 := TCheckBox(Panel1.Controls[iCount]).Checked;
      if Panel1.Controls[iCount].Name = 'c11' then
        recparamTemp.i17 := StrToInt(TEdit(Panel1.Controls[iCount]).Text);
      if Panel1.Controls[iCount].Name = 'c12' then
        recparamTemp.b33 := TCheckBox(Panel1.Controls[iCount]).Checked;
      if Panel1.Controls[iCount].Name = 'c14' then
        recparamTemp.s04 := TEdit(Panel1.Controls[iCount]).Text;
{      if Panel1.Controls[iCount].Name = 'c16' then
        recparamTemp.i36 := TComboBox(Panel1.Controls[iCount]).ItemIndex;}
    end;
  end;
end;

procedure TfTreeParam.TreeView1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  tnTemp : TTreeNode;
begin
  tnTemp := TreeView1.GetNodeAt(X,Y);
  if (tnTemp <> nil) and (iOldIndex <> tnTemp.Index) then begin
    SaveToRec(iOldIndex);
    iOldIndex := tnTemp.Index;
    while Panel1.ControlCount > 0 do Panel1.RemoveControl(Panel1.Controls[0]);
    LoadFromRec(tnTemp.Index);
  end;
end;

procedure TfTreeParam.FormShow(Sender: TObject);
begin
  recparamTemp := FormParam.recParam;
  LoadFromRec(iOldIndex);
end;

procedure TfTreeParam.Button2Click(Sender: TObject);
begin
  Close;
end;

end.
