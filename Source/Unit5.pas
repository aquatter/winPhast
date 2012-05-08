unit Unit5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, TeEngine, TeeFunci, Series, ExtCtrls, TeeProcs, Chart, crude, utype;

type
  TForm5 = class(TForm)
    Chart1: TChart;
    Series2: TFastLineSeries;
    Series3: TFastLineSeries;
    Series1: TLineSeries;
    procedure Chart1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure FormCreate(Sender: TObject);
    procedure Chart1DblClick(Sender: TObject);
  private
  public
    min, max: treal;
    mode: (mdNone, mdLeft, mdRight);
    procedure start;
  end;

var
  Form5: TForm5;


implementation

uses Unit1, UPhast2Vars;

{$R *.dfm}

procedure TForm5.Chart1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 { if (x>= Chart1.ChartRect.Left) and (x<=Chart1.ChartRect.Right) and (y>=Chart1.ChartRect.Top) and (y<=Chart1.ChartRect.Bottom) then
  begin
    Series2.Clear;
    Series3.Clear;
    case mode of
      mdLeft: begin
              min:=Chart1.BottomAxis.Minimum+(x-Chart1.ChartRect.Left)*(Chart1.BottomAxis.Maximum-Chart1.BottomAxis.Minimum)/Chart1.ChartWidth;
              Series2.AddXY(min, Chart1.LeftAxis.Minimum, '', clBlue);
              Series2.AddXY(min, Chart1.LeftAxis.Maximum, '', clBlue);
            end;
      mdRight: begin
               max:=Chart1.BottomAxis.Minimum+(x-Chart1.ChartRect.Left)*(Chart1.BottomAxis.Maximum-Chart1.BottomAxis.Minimum)/Chart1.ChartWidth;
               Series2.AddXY(min, Chart1.LeftAxis.Minimum, '', clBlue);
               Series2.AddXY(min, Chart1.LeftAxis.Maximum, '', clBlue);
               Series3.AddXY(max, Chart1.LeftAxis.Minimum, '', clBlue);
               Series3.AddXY(max, Chart1.LeftAxis.Maximum, '', clRed);
             end;
    end;
  Chart1.Update;
  end;
  }
end;

procedure TForm5.FormCreate(Sender: TObject);
begin
  Left:=cfg.slice_left;
  Top:=cfg.slice_top;
//  mode:=mdNone;
end;

procedure TForm5.start;
begin
//  mode:=mdLeft;
end;

procedure TForm5.Chart1DblClick(Sender: TObject);
begin
 {  case mode of
     mdLeft: mode:=mdRight;
     mdRight: mode:=mdNone;
   end;}
end;

end.
