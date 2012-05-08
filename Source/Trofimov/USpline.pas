unit USpline;

interface

uses Types, UType;

procedure CMRSpline(var p : array of TPoint; T : TReal; var pointOut : TPoint);

implementation

procedure CMRSpline(var p : array of TPoint; T : TReal; var pointOut : TPoint);
var
  S, t2, t3 : TReal;
begin
	s := 1.0 - t;
  t2 := t * t;
  t3 := t2 * t;
  pointOut.x := Round(0.5 * ((2.0 - 5.0 * t2 + 3.0 * t3) * p[1].x -
    t * s * s * p[0].x + t * (1.0 + 4.0 * t - 3.0 * t2) * p[2].x -
    t2 * s * p[3].x ));
  pointOut.y := Round(0.5 * ((2.0 - 5.0 * t2 + 3.0 * t3) * p[1].y -
    t * s * s * p[0].y + t * (1.0 + 4.0 * t - 3.0 * t2) * p[2].y -
    t2 * s * p[3].y ));
end;

end.
