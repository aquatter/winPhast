unit UCATool;

interface

uses UType;

procedure CAMakeAmpMask(iW, iH, iMin, iMax : Integer;
                        var caIn : TRealArray;
                        var baMask : TByteArray);

procedure CADiv(iW, iH : Integer ; var caIn, caIn2, caOut : TRealArray);

procedure CAConjugacy(iW, iH : Integer ; var caIn : TRealArray);

procedure CAMiddle3(XSIze, YSize : Integer;
                    var PC, PC2, PC3, PCFilt : TRealArray);

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

procedure CANorm(iW, iH : Integer ; var caIn, caOut : TRealArray);

implementation

uses Math, UFFT, URATool;

procedure CANorm(iW, iH : Integer ; var caIn, caOut : TRealArray);
var
  iY, iX : Integer;
  rTemp, rMaxAmp : TReal;
begin
  rMaxAmp := -MaxSingle;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      rTemp := Sqr(caIn[(iY * iW + iX) * 2]) + Sqr(caIn[(iY * iW + iX) * 2 + 1]);
      if rMaxAmp < rTemp then rMaxAmp := rTemp;
    end;
  rMaxAmp := Sqrt(rMaxAmp);
  if rMaxAmp <> 0 then for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      caOut[(iY * iW + iX) * 2] := caOut[(iY * iW + iX) * 2] / rMaxAmp;
      caOut[(iY * iW + iX) * 2 + 1] := caOut[(iY * iW + iX) * 2 + 1] / rMaxAmp;
    end;
end;

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

procedure CADiv(iW, iH : Integer ; var caIn, caIn2, caOut : TRealArray);
var
  iY, iX : Integer;
  rRe1, rRe2, rIm1, rIm2, rTemp : TReal;
begin
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      rRe1 := caIn[(iY * iW + iX) * 2];
      rIm1 := caIn[(iY * iW + iX) * 2 + 1];
      rRe2 := caIn2[(iY * iW + iX) * 2];
      rIm2 := caIn2[(iY * iW + iX) * 2 + 1];
      {rTemp := Sqr(rRe2) + Sqr(rIm2);
      caOut[(iY * iW + iX) * 2] := 0;
      caOut[(iY * iW + iX) * 2 + 1] := 0;
      if rTemp > 0 then begin            }
        caOut[(iY * iW + iX) * 2] := (rRe1 * rRe2 + rIm1 * rIm2) {/ rTemp};
        caOut[(iY * iW + iX) * 2 + 1] := (rRe2 * rIm1 - rRe1 * rIm2){ / rTemp};
      {end
      else begin
        caOut[(iY * iW + iX) * 2] := 10000;
        caOut[(iY * iW + iX) * 2 + 1] := 10000;
      end}
    end;
end;

procedure CAMakeAmpMask(iW, iH, iMin, iMax : Integer;
                        var caIn : TRealArray;
                        var baMask : TByteArray);
var
  praTemp : PRealArray;
  rMax, rMin, rMaxOut, rMinOut : TReal;
  iCount : Integer;
begin
  GetMem(praTemp, iW * iH * SizeOf(TReal));
  Complex2RealArray(iW, iH, caIn, praTemp^, 4, True);
  FindMaxMinRealArray(iW, iH, praTemp^, rMax, rMin);
  rMaxOut := (rMax - rMin) / 100 * iMax + rMin;
  rMinOut := (rMax - rMin) / 100 * iMin + rMin;
  for iCount := 0 to iW * iH - 1 do begin
    baMask[iCount] := 1;
    if praTemp^[iCount] < rMinOut then baMask[iCount] := 0;
    if praTemp^[iCount] > rMaxOut then baMask[iCount] := 0;
  end;
  FreeMem(praTemp, iW * iH * SizeOf(TReal));
end;

procedure CAConjugacy(iW, iH : Integer ; var caIn : TRealArray);
var
  I, J : Integer;
begin
  for I := 0 to iH - 1 do
    for J := 0 to iW - 1 do begin
      caIn[(I * iW + J) * 2] := - caIn[(I * iW + J) * 2];    
//      caIn[(I * iW + J) * 2 + 1] := - caIn[(I * iW + J) * 2 + 1];
    end;
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
//      if (Abs(rRe + rIm) > 0) and (Abs(rRe2 + rIm2) > 0) then begin
//        PCFilt[(I * XSize + J) * 2] := (rRe + rRe2) / 2.0;
//        PCFilt[(I * XSize + J) * 2 + 1] := (rIm + rIm2) / 2.0;
//      end
//      else begin
//        PCFilt[(I * XSize + J) * 2] := (rRe + rRe2);
//        PCFilt[(I * XSize + J) * 2 + 1] := (rIm + rIm2);
//      end;
      PCFilt[(I * XSize + J) * 2] := (rRe + rRe2);
      PCFilt[(I * XSize + J) * 2 + 1] := (rIm + rIm2);
    end;
end;

procedure CAMiddle3(XSIze, YSize : Integer;
                    var PC, PC2, PC3, PCFilt : TRealArray);
var
  I, J : Integer;
  rRe3, rIm3, rRe, rIm, rRe2, rIm2 : TReal;
begin
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do begin
      rRe := PC[(I * XSize + J) * 2];
      rIm := PC[(I * XSize + J) * 2 + 1];
      rIm3 := PC3[(I * XSize + J) * 2 + 1];
      rRe3 := PC3[(I * XSize + J) * 2];
      rRe2 := PC2[(I * XSize + J) * 2];
      rIm2 := PC2[(I * XSize + J) * 2 + 1];
//      if (Abs(rRe + rIm) > 0) and (Abs(rRe2 + rIm2) > 0) and
//        (Abs(rRe3 + rIm3) > 0) then begin
//        PCFilt[(I * XSize + J) * 2] := (rRe + rRe2 + rRe3) / 3.0;
//        PCFilt[(I * XSize + J) * 2 + 1] := (rIm + rIm2 + rIm3) / 3.0;
//      end
//      else begin
//        PCFilt[(I * XSize + J) * 2] := (rRe + rRe2 + rRe3);
//        PCFilt[(I * XSize + J) * 2 + 1] := (rIm + rIm2 + rIm3);
//      end;
      PCFilt[(I * XSize + J) * 2] := (rRe + rRe2 + rRe3);
      PCFilt[(I * XSize + J) * 2 + 1] := (rIm + rIm2 + rIm3);
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
