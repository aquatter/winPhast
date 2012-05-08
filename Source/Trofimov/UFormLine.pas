unit UFormLine;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart;

type
  TForm5 = class(TForm)
    Chart1: TChart;
    Series1: TLineSeries;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses Unit1;

{$R *.dfm}

procedure TForm5.FormShow(Sender: TObject);
begin
  Form1.GraphUser1.Checked := True;
end;

procedure TForm5.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Form1.GraphUser1.Checked := False;
end;

end.
