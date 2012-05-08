unit Unit3;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, Series, ExtCtrls, TeeProcs, Chart;

type
  TForm3 = class(TForm)
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
  Form3: TForm3;

implementation

{$R *.dfm}

uses unit1, UPhast2Vars;

procedure TForm3.FormCreate(Sender: TObject);
begin
  with cfg do
  begin
    Left:=x_left;
    Top:=x_top;
  end;
end;

end.
