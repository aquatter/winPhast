unit calibr;

interface

uses utype, crude, t666, math;

type
{  TCalibrMode = (cmBlackOnWhite, cmWhiteOnBlack);}
  TCalibr = class(TObject)
  private
{    FCalibrMode: TCalibrMode;
    line1, line2: PMyInfernalType;}
    a, b: TReal;
    procedure Filtr(line: PMyInfernalType; var q: TReal);
    procedure Run(points: PMyInfernalType);
  public
    h1{, h2}: Treal;
    constructor Create(_line1, _line2, _points: PMyInfernalType);
    destructor Destroy; override;
  published
{    property CalibrMode: TCalibrMode read FCalibrMode write FCalibrMode;}
  end;



implementation

{ TCalibr }

constructor TCalibr.Create(_line1, _line2, _points: PMyInfernalType);
begin
 { line1:=_line1;
  line2:=_line2;}
  Filtr(_line1, a);
  Filtr(_line2, b);
  Run(_points);
end;

destructor TCalibr.Destroy;
begin

  inherited Destroy;
end;

procedure TCalibr.Filtr(line: PMyInfernalType; var q: TReal);
var i: integer;
    mean: TReal;
    plus, minus: TMyInfernalType;
begin
  mean:=0;
  plus:=TMyInfernalType.Create;
  minus:=TMyInfernalType.Create;
  plus.Init(1, 0, varDouble);
  minus.Init(1, 0, varDouble);
  for i:=0 to line^.w-1 do
    mean:=mean+line^.a^[i];
  mean:=mean/line^.w;
  for i:=0 to line^.w-2 do
  begin
    if ((line^.a^[i]-mean) < 0) and ((line^.a^[i+1]-mean) > 0) then
    begin
      plus.Add1D;
      plus.a^[plus.w-1]:=(2*i+1)/2;
    end;
    if ((line^.a^[i]-mean) > 0) and ((line^.a^[i+1]-mean) < 0) then
    begin
      minus.Add1D;
      minus.a^[minus.w-1]:=(2*i+1)/2;
    end;
  end;
  q:=0;
  for i:=0 to plus.w-2 do
    q:=q+abs(plus.a^[i]-plus.a^[i+1]);
  for i:=0 to minus.w-2 do
    q:=q+abs(minus.a^[i]-minus.a^[i+1]);
  q:=q/(minus.w+plus.w-2);

  plus.Destroy;
  minus.Destroy;
end;

procedure TCalibr.Run(points: PMyInfernalType);
var k1, k2, phi: TReal;
begin
  k1:=(points^.d^[1].y-points^.d^[0].y)/(points^.d^[1].x-points^.d^[0].x);
  k2:=(points^.d^[3].y-points^.d^[2].y)/(points^.d^[3].x-points^.d^[2].x);
  phi:=ArcTan2(k2-k1, 1+k2*k1);
  h1:=abs(a*b*sin(phi)/sqrt(sqr(a)+sqr(b)-2*a*b*cos(phi)));
  //h2:=a*b*sin(pi-phi)/sqrt(sqr(a)+sqr(b)-2*a*b*cos(pi-phi));
end;

end.
