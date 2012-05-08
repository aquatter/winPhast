unit UWhat2CalcForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TWhat2CalcForm = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button3Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    ind: integer;
  end;

var
  What2CalcForm: TWhat2CalcForm;

implementation

{$R *.dfm}

uses unit1;

procedure TWhat2CalcForm.Button1Click(Sender: TObject);
begin
  ind:=1;
end;

procedure TWhat2CalcForm.Button2Click(Sender: TObject);
begin
  ind:=2;
end;

procedure TWhat2CalcForm.Button3Click(Sender: TObject);
begin
  form1.ToolButton33Click(nil);
end;

procedure TWhat2CalcForm.Button5Click(Sender: TObject);
begin
  ind:=3;
end;

procedure TWhat2CalcForm.Button6Click(Sender: TObject);
begin
  ind:=4;
end;

end.
