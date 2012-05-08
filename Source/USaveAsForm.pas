unit USaveAsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, StdCtrls;

type
  TSaveAsForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    Edit1: TEdit;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    Label3: TLabel;
    CheckBox8: TCheckBox;
    procedure ToolButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  SaveAsForm: TSaveAsForm;

implementation

{$R *.dfm}

uses unit1;

procedure TSaveAsForm.ToolButton1Click(Sender: TObject);
var s: string;
begin
  form1.SaveDialog1.InitialDir:=ExtractFileDir(Application.ExeName);
  form1.SaveDialog1.Filter:='';
  if not form1.SaveDialog1.Execute() then
    exit;

  s:=Form1.SaveDialog1.FileName;
  s:=ChangeFileExt(s, '');

  Edit1.Text:=s;


end;

end.
