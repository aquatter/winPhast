unit UTest_Com_Port_Form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TTest_Com_Port_Form = class(TForm)
    Button1: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Test_Com_Port_Form: TTest_Com_Port_Form;

implementation

{$R *.dfm}

uses unit1;


procedure TTest_Com_Port_Form.Button1Click(Sender: TObject);
var p: array[0..2] of byte;
begin
  p[0]:=StrToInt(Edit1.Text);
  p[1]:=StrToInt(Edit2.Text);
  p[2]:=StrToInt(Edit3.Text);

  form1.CommPortDriver1.SendData(@(p), 3);
end;

end.
