unit UCATool;

interface

uses UType;

procedure CAAdd(XSIze, YSize : Integer;
                var PC, PC2, PCFilt : TRealArray);

procedure CAMulCNum(XSIze, YSize : Integer;
                    var PC, PCFilt : TRealArray;
                    Re, Im : TReal);

procedure CASub(XSIze, YSize : Integer;
                var PC, PC2, PCFilt : TRealArray);

procedure CAMulAdjoint(XSIze, YSize : Integer;
                       var PC, PC2, PCFilt : TRealArray);

procedure CAMiddle(XSIze, YSize : Integer;
                var PC, PC2, PCFilt : TRealArray);

procedure CADivRA(iW, iH : Integer ; var caIn, raIn, caOut : TRealArray);

implementation

procedure CADivRA(iW, iH : Integer ; var caIn, raIn, caOut : TRealArray);
var
  iY, iX : Integer;
begin
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do if raIn[iY * iW + iX] <> 0.0 then begin
      caOut[(iY * iW + iX) * 2] := caIn[(iY * iW + iX) * 2] / raIn[iY * iW + iX];
      caOut[(iY * iW + iX) * 2 + 1] := caIn[(iY * iW + iX) * 2 + 1] / raIn[iY * iW + iX];
    end
    else begin
      caOut[(iY * iW + iX) * 2] := 0.0;
      caOut[(iY * iW + iX) * 2 + 1] := 0.0;
    end
end;

procedure CAMiddle(XSIze, YSize : Integer;
                var PC, PC2, PCFilt : TRealArray);
var
  I, J : Integer;
  rRe, rIm, rRe2, rIm2 : TReal;
begin
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do begin
      rRe := PC[(I * XSize + J) * 2];
      rIm := PC[(I * XSize + J) * 2 + 1];
      rRe2 := PC2[(I * XSize + J) * 2];
      rIm2 := PC2[(I * XSize + J) * 2 + 1];
      if (Abs(rRe + rIm) > 0) and (Abs(rRe2 + rIm2) > 0) then begin
        PCFilt[(I * XSize + J) * 2] := (rRe + rRe2) / 2.0;
        PCFilt[(I * XSize + J) * 2 + 1] := (rIm + rIm2) / 2.0;
      end
      else begin
        PCFilt[(I * XSize + J) * 2] := (rRe + rRe2);
        PCFilt[(I * XSize + J) * 2 + 1] := (rIm + rIm2);
      end;
    end;
end;

procedure CAMulAdjoint(XSIze, YSize : Integer;
                       var PC, PC2, PCFilt : TRealArray);
var
  I, J : Integer;
  rRe, rIm, rRe2, rIm2 : TReal;
begin
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do begin
      rRe := PC[(I * XSize + J) * 2];
      rIm := PC[(I * XSize + J) * 2 + 1];
      rRe2 := PC2[(I * XSize + J) * 2];
      rIm2 := PC2[(I * XSize + J) * 2 + 1];
      PCFilt[(I * XSize + J) * 2] := rRe * rRe2 + rIm * rIm2;
      PCFilt[(I * XSize + J) * 2 + 1] := rIm * rRe2 - rRe * rIm2;
    end;
end;

procedure CASub(XSIze, YSize : Integer;
                var PC, PC2, PCFilt : TRealArray);
var
  I, J : Integer;
  rRe, rIm, rRe2, rIm2 : TReal;
begin
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do begin
      rRe := PC[(I * XSize + J) * 2];
      rIm := PC[(I * XSize + J) * 2 + 1];
      rRe2 := PC2[(I * XSize + J) * 2];
      rIm2 := PC2[(I * XSize + J) * 2 + 1];
      PCFilt[(I * XSize + J) * 2] := rRe - rRe2;
      PCFilt[(I * XSize + J) * 2 + 1] := rIm - rIm2;
    end;
end;

procedure CAAdd(XSIze, YSize : Integer;
                var PC, PC2, PCFilt : TRealArray);
var
  I, J : Integer;
  rRe, rIm, rRe2, rIm2 : TReal;
begin
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do begin
      rRe := PC[(I * XSize + J) * 2];
      rIm := PC[(I * XSize + J) * 2 + 1];
      rRe2 := PC2[(I * XSize + J) * 2];
      rIm2 := PC2[(I * XSize + J) * 2 + 1];
      PCFilt[(I * XSize + J) * 2] := rRe + rRe2;
      PCFilt[(I * XSize + J) * 2 + 1] := rIm + rIm2;
    end;
end;

procedure CAMulCNum(XSIze, YSize : Integer;
                    var PC, PCFilt : TRealArray;
                    Re, Im : TReal);
var
  I, J : Integer;
  rRe, rIm : TReal;
begin
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do begin
      rRe := PC[(I * XSize + J) * 2];
      rIm := PC[(I * XSize + J) * 2 + 1];
      PCFilt[(I * XSize + J) * 2] := rRe * Re - rIm * Im;
      PCFilt[(I * XSize + J) * 2 + 1] := rIm * Re + rRe * Im;
    end;
end;

end.
