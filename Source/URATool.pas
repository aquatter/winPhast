unit URATool;

interface

uses Math, UType;

procedure FindMaxMinRealArray(XSize, YSize : Integer;
                              var P : TRealArray;
                              var MaxRA, MinRA : TReal);

procedure FindMaxMinRealArrayAbs(XSize, YSize : Integer;
                                 var P : TRealArray;
                                 var MaxRA, MinRA : TReal);

procedure FindLocalMaxRealArray(XSize, YSize : Integer;
                               var P : TRealArray;
                               BeginR, EndR : TReal;
                               var MaxX, MaxY : Integer);

procedure NormRealArray(iW, iH : Integer;
                        var raIn  : TRealArray;
                        rNewMin, rNewMax : TReal);

function FindNextNum(W, H : Integer;
                     Num : TReal;
                     var M : TBtArr;
                     var BX, BY : Integer) : Boolean;

function Min(x,y: treal):treal;
function Max(x,y: treal):treal;

procedure FillRealArrayNum(XSize, YSize : Integer;
                           var PCFilt : TRealArray;
                           Num : TReal);

procedure AreaIncNum(iW, iH, iBX, iBY : Integer;
                     var raIn, raMask, raOut : TRealArray;
                     rNum : TReal);

procedure RAAdd(iW, iH : Integer;
                var raIn1, raIn2, raOut : TRealArray);

procedure FindMaxMinRealArrayNonZero(XSize, YSize : Integer;
                                     var P : TRealArray;
                                     var MaxRA, MinRA : TReal);

function FindNextNum2(W, H : Integer;
                     Num : TReal;
                     var M, M2 : TRealArray;
                     var BX, BY : Integer) : Boolean;

procedure RASub(iW, iH : Integer;
                var raIn1, raIn2, raOut : TRealArray);

procedure RATrueNorm(iW, iH : Integer;
                     var raIn, raMask, raOut : TRealArray);

procedure LimitArray(iW, iH : Integer;
                     var raLimiter, raToLimit, raOut : TRealArray);

implementation

uses UFill;

procedure LimitArray(iW, iH : Integer;
                     var raLimiter, raToLimit, raOut : TRealArray);
var
  iY, iX : Integer;
  rMax, rMin, rThreshold, rLimiter, rToLimit, rSign : TReal;
begin
  FindMaxMinRealArray(iW, iH, raLimiter, rMax, rMin);
  rThreshold := 0.01 * Abs(rMax);
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      rLimiter := raLimiter[iY * iW + iX];
      rToLimit := raToLimit[iY * iW + iX];
      rSign := Abs(rLimiter - rToLimit) / (rLimiter - rToLimit);
      if Abs(rLimiter - rToLimit) > rThreshold then
        raOut[iY * iW + iX] := rLimiter - rSign * rThreshold
      else raOut[iY * iW + iX] := raToLimit[iY * iW + iX];
    end;  
end;

procedure RATrueNorm(iW, iH : Integer;
                     var raIn, raMask, raOut : TRealArray);
var
  iY, iX : Integer;
  rR, rMin, rMax : TReal;
begin
  rMin := MaxDouble;
  rMax := - MaxDouble;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      if not(raMask[iY * iW + iX] <> 1) then begin
        if raIn[iY * iW + iX] > rMax then rMax := raIn[iY * iW + iX];
        if raIn[iY * iW + iX] < rMin then rMin := raIn[iY * iW + iX];
        raOut[iY * iW + iX] := raIn[iY * iW + iX];
      end;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      if (raMask[iY * iW + iX] <> 1) then
        raOut[iY * iW + iX] := (rMax + rMin) / 2;
end;


procedure RASub(iW, iH : Integer;
                var raIn1, raIn2, raOut : TRealArray);
var
  iY, iX : Integer;
begin
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      raOut[iY * iW + iX] := raIn1[iY * iW + iX] - raIn2[iY * iW + iX];
end;

procedure RAAdd(iW, iH : Integer;
                var raIn1, raIn2, raOut : TRealArray);
var
  iY, iX : Integer;
begin
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      raOut[iY * iW + iX] := raIn1[iY * iW + iX] + raIn2[iY * iW + iX];
end;

procedure AreaIncNum(iW, iH, iBX, iBY : Integer;
                     var raIn, raMask, raOut : TRealArray;
                     rNum : TReal);
var
  praTemp : PRealArray;
  iY, iX : Integer;
begin
  GetMem(praTemp, iW * iH * SizeOf(TReal));
  // Поднимаем область на число
  FillAreaFillZero(iBX, iBY, iW, iH, True, raMask, praTemp^);
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      if praTemp^[iY * iW + iX] = 1 then
        raOut[iY * iW + iX] := raIn[iY * iW + iX] + rNum;
  FreeMem(praTemp, iW * iH * SizeOf(TReal));
end;

function Max(x,y: treal):treal;
begin
 if x>y then Result:=x else Result:=y;
end;

function Min(x,y: treal):treal;
begin
 if x>y then Result:=y else Result:=x;
end;

function FindNextNum(W, H : Integer;
                     Num : TReal;
                     var M : TBtArr;
                     var BX, BY : Integer) : Boolean;
var
  I, J : Integer;
begin
  Result := False;
  for I := 0 to H - 1 do begin
    for J := 0 to W - 1 do
      if M[I * W + J] = Num then begin
        BX := J;
        BY := I;
        Result := True;
        Break;
      end;
    if M[I * W + J] = Num then Break;
  end;
end;

function FindNextNum2(W, H : Integer;
                     Num : TReal;
                     var M, M2 : TRealArray;
                     var BX, BY : Integer) : Boolean;
var
  I, J : Integer;
  IsEnd : Boolean;
begin
  I := 0;
  J := 0;
  IsEnd := False;
  while not(IsEnd) and (I < H) do begin
    while not(IsEnd) and (J < W) do begin
      IsEnd := (M[I * W + J] = Num) and (M2[I * W + J] = 0);
      if not(IsEnd) then Inc(J);
    end;
    if not(IsEnd) then begin
      Inc(I);
      J := 0;
    end;
  end;
  if IsEnd then begin
    BX := J;
    BY := I;
  end;
  FindNextNum2 := IsEnd;
end;

procedure NormRealArray(iW, iH : Integer;
                        var raIn  : TRealArray;
                        rNewMin, rNewMax : TReal);
var
  rMax, rMin : TReal;
  iY, iX : Integer;
begin
  // Ищем во входном массиве максимум и минимум
  FindMaxMinRealArray(iW, iH, raIn, rMax, rMin);
  // Нормируем
  if rMax - rMin <> 0.0 then
    for iY := 0 to iH - 1 do
      for iX := 0 to iW - 1 do
        raIn[iY * iW + iX] := (raIn[iY * iW + iX] - rMin) / (rMax - rMin) *
                              (rNewMax - rNewMin) + rNewMin;
end;

procedure FindMaxMinRealArray(XSize, YSize : Integer;
                              var P : TRealArray;
                              var MaxRA, MinRA : TReal);
var
  I, J : Integer;
  rNum, MinP, MaxP : TReal;
begin
  MaxP := - MaxDouble;
  MinP := MaxDouble;
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do begin
      rNum := P[I * XSize + J];
      if rNum > maxP then MaxP := rNum;
      if rNum < minP then MinP := rNum;
    end;
  MaxRA := MaxP;
  MinRA := MinP;
end;

procedure FindMaxMinRealArrayNonZero(XSize, YSize : Integer;
                                     var P : TRealArray;
                                     var MaxRA, MinRA : TReal);
var
  I, J : Integer;
  rNum, MinP, MaxP : TReal;
begin
  MaxP := - MaxDouble;
  MinP := MaxDouble;
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do begin
      rNum := P[I * XSize + J];
      if rNum > maxP then MaxP := rNum;
      if (rNum < minP) and (rNum <> 0.0) then MinP := rNum;
    end;
  MaxRA := MaxP;
  MinRA := MinP;
end;

procedure FindMaxMinRealArrayAbs(XSize, YSize : Integer;
                                 var P : TRealArray;
                                 var MaxRA, MinRA : TReal);
var
  I, J : Integer;
  rNum, MinP, MaxP : TReal;
begin
  MaxP := 0;
  MinP := MaxDouble;
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do begin
      rNum := Abs(P[I * XSize + J]);
      if rNum > maxP then MaxP := rNum;
      if rNum < minP then MinP := rNum;
    end;
  MaxRA := MaxP;
  MinRA := MinP;
end;

procedure FindLocalMaxRealArray(XSize, YSize : Integer;
                               var P : TRealArray;
                               BeginR, EndR : TReal;
                               var MaxX, MaxY : Integer);
var
  I, J : Integer;
  MaxP, CurR : TReal;
  MaxI, MaxJ : Integer;
begin
  MaxP := MinDouble;
  MaxI := 0;
  MaxJ := 0;
  for I := 0 to (YSize div 2) - 1 do
    for J := 0 to XSize - 1 do begin
      CurR := Sqrt(Sqr(YSize / 2 - I) + Sqr(J - XSize / 2));
      if (P[I * XSize + J] > maxP) and
         (CurR > BeginR) and (CurR < EndR) and
         (Abs(J - (XSize div 2)) > 2) then begin
        MaxP := P[I * XSize + J];
        MaxI := I;
        MaxJ := J;
      end;
    end;
  MaxX := Round(MaxJ - XSize / 2);
  MaxY := Round(YSize / 2 - MaxI);
end;

procedure FillRealArrayNum(XSize, YSize : Integer;
                           var PCFilt : TRealArray;
                           Num : TReal);
var
  I, J : Integer;                           
begin
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do PCFilt[I * XSize + J] := Num;
end;

end.
