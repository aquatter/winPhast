unit URecSeqThreadForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TRecSeqThreadForm = class(TForm)
    Label1: TLabel;
    Button1: TButton;
    Label2: TLabel;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  RecSeqThreadForm: TRecSeqThreadForm;

implementation

{$R *.dfm}

uses URecSeqThread;

procedure TRecSeqThreadForm.Button1Click(Sender: TObject);
begin
  RecSeqThread.cancel:=true;
end;

procedure TRecSeqThreadForm.FormCreate(Sender: TObject);
begin
  Label1.Alignment:=taCenter;
end;

end.
