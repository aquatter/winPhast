unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart;

type
  TForm4 = class(TForm)
    Chart1: TChart;
    Series1: TFastLineSeries;
    Series2: TPointSeries;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

{$R *.dfm}

uses unit1, UPhast2Vars;

procedure TForm4.FormCreate(Sender: TObject);
begin
  with cfg do
  begin
    Left:=y_left;
    Top:=y_top;
  end;
end;

end.
