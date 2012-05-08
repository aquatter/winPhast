unit URATool;

interface

uses Math, UType;

procedure RAFindMiddle(iW, iH : Integer;
                       var raIn : TRealArray;
                       var rMiddle : TReal);

procedure RAFillByteMask(iW, iH : Integer;
                         var raIn : TRealArray;
                         var baMask : TByteArray;
                         iFillWhat : Integer);

procedure RAGetHistogram(iW, iH : Integer; var raIn : TRealArray;
                         var iaHistogram : TIntegerArray);

procedure RAFillMinNotMask(XSize, YSize : Integer;
                           var PCFilt, raMask : TRealArray);

procedure RAMakeFromByte(iW, iH : Integer;
                         var baIn : TByteArray;
                         rk, rB : TReal;
                         var raOut : TRealArray);

procedure RAMakeByte(iW, iH : Integer;
                     var baOut : TByteArray;
                     var rk, rB : TReal;
                     var raIn : TRealArray);

procedure RAFillMask(iW, iH : Integer;
                     var raIn, raMask : TRealArray;
                     iFillWhat : Integer);

procedure RAAddNum(iW, iH : Integer;
                       var raIn, raOut : TRealArray;
                       rNum : TReal);

procedure FindMaxMinRealArrayMask(XSize, YSize : Integer;
                                  var P, raMask : TRealArray;
                                  var MaxRA, MinRA : TReal);

procedure FillRealArrayMiddleMask(XSize, YSize : Integer;
                                  var PCFilt, raMask : TRealArray);  overload;

procedure FillRealArrayMiddleMask(XSize, YSize : Integer;
                                  var PCFilt: TRealArray; var raMask: TBtArr);  overload;

procedure FillRealArrayNumMask(XSize, YSize : Integer;
                               var PCFilt, raMask : TRealArray;
                               Num : TReal);

procedure RAAdd3(iW, iH : Integer;
                 var raIn1, raIn2, raIn3, raOut : TRealArray);

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
                     var M : TRealArray;
                     var BX, BY : Integer) : Boolean; overload;

function FindNextNum(W, H : Integer;
                     Num : TReal;
                     var M : TBtArr;
                     var BX, BY : Integer) : Boolean;  overload;

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

procedure RASubNum(iW, iH : Integer;
                   var raIn, raOut : TRealArray;
                   rNum : TReal);
                     
procedure LimitArray(iW, iH : Integer;
                     var raLimiter, raToLimit, raOut : TRealArray);

procedure FillRealArrayMinMask(XSize, YSize : Integer;
                               var PCFilt, raMask : TRealArray);                     

procedure RARotate180(iW, iH : Integer;
                      var raIn : TRealArray);

procedure RAMirrorX(iW, iH : Integer;
                    var raIn : TRealArray);

procedure RAMirrorY(iW, iH : Integer;
                    var raIn : TRealArray);

implementation

uses Windows, UFill;

procedure RAMakeFromByte(iW, iH : Integer;
                         var baIn : TByteArray;
                         rk, rB : TReal;
                         var raOut : TRealArray);
var
  iCount : Integer;
begin
  for iCount := 0 to iW * iH - 1 do
    raOut[iCount] := baIn[iCount] * rK + rB;
end;

procedure RAMakeByte(iW, iH : Integer;
                     var baOut : TByteArray;
                     var rk, rB : TReal;
                     var raIn : TRealArray);
var
  iCount : Integer;
  rMax, rMin : TReal;
begin
  FindMaxMinRealArray(iW, iH, raIn, rMax, rMin);
  rK := (rMax - rMin) / 255;
  rB := rMin;
  if rK <> 0 then
    for iCount := 0 to iW * iH - 1 do
      baOut[iCount] := Round((raIn[iCount] - rB) / rK)
  else FillMemory(Addr(baOut), iW * iH, 0);
end;

procedure RAMirrorY(iW, iH : Integer;
                    var raIn : TRealArray);
var
  iY, iX : Integer;
  praTemp : PRealArray;
begin
  GetMem(praTemp, iW * iH * SizeOf(TReal));
  CopyMemory(praTemp, Addr(raIn), iW * iH * SizeOf(TReal));
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      raIn[iW - iX - 1 + iW * iY] := praTemp^[iW * iY + iX];
  FreeMem(praTemp, iW * iH * SizeOf(TReal));
end;

procedure RAMirrorX(iW, iH : Integer;
                    var raIn : TRealArray);
var
  iY, iX : Integer;
  praTemp : PRealArray;
begin
  GetMem(praTemp, iW * iH * SizeOf(TReal));
  CopyMemory(praTemp, Addr(raIn), iW * iH * SizeOf(TReal));
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      raIn[iX + iW * (iH - iY - 1)] := praTemp^[iW * iY + iX];
  FreeMem(praTemp, iW * iH * SizeOf(TReal));
end;

procedure RARotate180(iW, iH : Integer;
                      var raIn : TRealArray);
var
  iY, iX : Integer;
  praTemp : PRealArray;
begin
  GetMem(praTemp, iW * iH * SizeOf(TReal));
  CopyMemory(praTemp, Addr(raIn), iW * iH * SizeOf(TReal));
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      raIn[IW - iX - 1 + iW * (iH - iY - 1)] := praTemp^[iW * iY + iX];
  FreeMem(praTemp, iW * iH * SizeOf(TReal));
end;

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
  rMin := MaxTReal;
  rMax := - MaxTReal;
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

procedure RASubNum(iW, iH : Integer;
                   var raIn, raOut : TRealArray;
                   rNum : TReal);
var
  iCounter : Integer;
begin
  for iCounter := 0 to iW * iH - 1 do
    raOut[iCounter] := raIn[iCounter] - rNum;
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

procedure RAAddNum(iW, iH : Integer;
                       var raIn, raOut : TRealArray;
                       rNum : TReal);
var
  iY, iX : Integer;
begin
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      raOut[iY * iW + iX] := raIn[iY * iW + iX] + rNum;
end;

procedure RAAdd3(iW, iH : Integer;
                 var raIn1, raIn2, raIn3, raOut : TRealArray);
var
  iY, iX : Integer;
begin
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      raOut[iY * iW + iX] := raIn1[iY * iW + iX] + raIn2[iY * iW + iX]
         + raIn3[iY * iW + iX];
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
                     var M : TRealArray;
                     var BX, BY : Integer) : Boolean; overload;
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

function FindNextNum(W, H : Integer;
                     Num : TReal;
                     var M : TBtArr;
                     var BX, BY : Integer) : Boolean;  overload;
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

procedure RAGetHistogram(iW, iH : Integer; var raIn : TRealArray;
                         var iaHistogram : TIntegerArray);
var
  iCount : Integer;
  rMax, rMin, rK : TReal;
begin
  FindMaxMinRealArray(iW, iH, raIn, rMAx, rMin);
  FillMemory(Addr(iaHistogram[0]), 256 * SizeOf(Integer), 0);
  if rMax - rMin <> 0.0 then begin
    rK :=  255 / (rMax - rMin);
    for iCount := 0 to iH * iW - 1 do
      Inc(iaHistogram[Round(raIn[iCount] * rK)]);
  end;
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
  MaxP := - MaxTReal;
  MinP := MaxTReal;
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do begin
      rNum := P[I * XSize + J];
      if (rNum > maxP) and (rNum <> MaxDouble) then MaxP := rNum;
      if (rNum < minP) and (rNum <> -MaxDouble) then MinP := rNum;
    end;
  MaxRA := MaxP;
  MinRA := MinP;
end;

procedure FindMaxMinRealArrayMask(XSize, YSize : Integer;
                                  var P, raMask : TRealArray;
                                  var MaxRA, MinRA : TReal);
var
  I, J : Integer;
  rNum, MinP, MaxP : TReal;
begin
  MaxP := - MaxTReal;
  MinP := MaxTReal;
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do if raMask[I * XSize + J] = 1 then begin
      rNum := P[I * XSize + J];
      if (rNum > maxP) and (rNum <> MaxDouble) then MaxP := rNum;
      if (rNum < minP) and (rNum <> -MaxDouble) then MinP := rNum;
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
  MaxP := - MaxTReal;
  MinP := MaxTReal;
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
  MinP := MaxTReal;
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
  MaxP := -MaxTReal;
  MaxI := 0;
  MaxJ := 0;
  for I := 0 to YSize{ div 2} - 1 do
    for J := 0 to (XSize div 2) - 1 do begin
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

procedure FillRealArrayNumMask(XSize, YSize : Integer;
                               var PCFilt, raMask : TRealArray;
                               Num : TReal);
var
  I, J : Integer;
begin
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do if raMask[I * XSize + J] = 0 then PCFilt[I * XSize + J] := Num
end;

procedure RAFillMinNotMask(XSize, YSize : Integer;
                           var PCFilt, raMask : TRealArray);
var
  I, J : Integer;
  rMin : TReal;
begin
  rMin := MaxDouble;
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do if (raMask[I * XSize + J] = 1) and
      (PCFilt[I * XSize + J] < rMin) then rMin := PCFilt[I * XSize + J];
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do
      if raMask[I * XSize + J] = 1 then PCFilt[I * XSize + J] := rMin
end;

procedure FillRealArrayMinMask(XSize, YSize : Integer;
                               var PCFilt, raMask : TRealArray);
var
  I, J : Integer;
  rMin : TReal;
begin
  rMin := MaxDouble;
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do if (raMask[I * XSize + J] = 1) and
      (PCFilt[I * XSize + J] < rMin) then rMin := PCFilt[I * XSize + J];
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do if raMask[I * XSize + J] = 0 then
      PCFilt[I * XSize + J] := rMin;
end;


procedure FillRealArrayMaxMask(XSize, YSize : Integer;
                               var PCFilt, raMask : TRealArray);
var
  I, J : Integer;
  rMax : TReal;
begin
  rMax := -MaxDouble;
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do if (raMask[I * XSize + J] = 1) and
      (PCFilt[I * XSize + J] > rMax) then rMax := PCFilt[I * XSize + J];
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do if raMask[I * XSize + J] = 0 then
      PCFilt[I * XSize + J] := rMax;
end;

procedure RAFillMask(iW, iH : Integer;
                     var raIn, raMask : TRealArray;
                     iFillWhat : Integer);
var i,j: integer;
begin
  {for i:=0 to ih-1 do
    for j:=0 to iw-1 do
      if raMask[i*iw+j]=0 then
        raIn[i*iw+j]:=-MaxDouble;}
  case iFillWhat of
    0 : FillRealArrayMiddleMask(iW, iH, raIn, raMask);
    1 : FillRealArrayMinMask(iW, iH, raIn, raMask);
    2 : FillRealArrayMaxMask(iW, iH, raIn, raMask);
  end;
end;

procedure RAFillNumByteMask(iW, iH : Integer;
                            var raIn : TRealArray;
                            var baMask : TByteArray;
                            rNum : TReal);
var
  iCount : Integer;
begin
  for iCount := 0 to iW * iH - 1 do
    if baMask[iCount] = 0 then raIn[iCount] := rNum
end;

procedure RAFindMiddleByteMask(iW, iH : Integer;
                               var raIn : TRealArray;
                               var baMask : TByteArray;
                               var rMiddle : TReal);
var
  iPoints, iCount : Integer;
  rSum : TReal;
begin
  rSum := 0;
  iPoints := 0;
  for iCount := 0 to iW * iH - 1 do if baMask[iCount] > 0 then begin
    rSum := rSum + raIn[iCount];
    Inc(iPoints);
  end;
  if iPoints > 0 then rMiddle := rSum / iPoints else rMiddle := 0;
end;

procedure RAFindMiddle(iW, iH : Integer;
                       var raIn : TRealArray;
                       var rMiddle : TReal);
var
  iCount : Integer;
  rSum : TReal;
begin
  rSum := 0;
  for iCount := 0 to iW * iH - 1 do
    rSum := rSum + raIn[iCount];
  rMiddle := rSum / iW / iH;
end;

procedure RAFindMaxMinByteMask(iW, iH : Integer;
                               var raIn : TRealArray;
                               var baMask : TByteArray;
                               var rMax, rMin : TReal);
var
  iCount : Integer;
begin
  rMax := -MaxSingle;
  rMin := MaxSingle;
  for iCount := 0 to iW * iH - 1 do if baMask[iCount] > 0 then begin
    if rMax < raIn[iCount] then rMax := raIn[iCount];
    if rMin > raIn[iCount] then rMin := raIn[iCount];
  end;
end;

procedure RAFillMiddleByteMask(iW, iH : Integer;
                               var raIn : TRealArray;
                               var baMask : TByteArray);
var
  rMiddle : TReal;
begin
  RAFindMiddleByteMask(iW, iH, raIn, baMask, rMiddle);
  RAFillNumByteMask(iW, iH, raIn, baMask, rMiddle);
end;

procedure RAFillMinByteMask(iW, iH : Integer;
                            var raIn : TRealArray;
                            var baMask : TByteArray);
var
  rMax, rMin : TReal;
begin
  RAFindMaxMinByteMask(iW, iH, raIn, baMask, rMax, rMin);
  RAFillNumByteMask(iW, iH, raIn, baMask, rMin);
end;

procedure RAFillMaxByteMask(iW, iH : Integer;
                            var raIn : TRealArray;
                            var baMask : TByteArray);
var
  rMax, rMin : TReal;
begin
  RAFindMaxMinByteMask(iW, iH, raIn, baMask, rMax, rMin);
  RAFillNumByteMask(iW, iH, raIn, baMask, rMax);
end;

procedure RAFillByteMask(iW, iH : Integer;
                         var raIn : TRealArray;
                         var baMask : TByteArray;
                         iFillWhat : Integer);
begin
  case iFillWhat of
    0 : RAFillMiddleByteMask(iW, iH, raIn, baMask);
    1 : RAFillMinByteMask(iW, iH, raIn, baMask);
    2 : RAFillMaxByteMask(iW, iH, raIn, baMask);
  end;
end;

procedure FillRealArrayMiddleMask(XSize, YSize : Integer;
                                  var PCFilt: TRealArray; var raMask: TBtArr);  overload;
var
  iCount, I, J : Integer;
  rNum, rMax, rMin : TReal;
begin
  rMin := MaxDouble;
  rMax := - MaxDouble;
  iCount := 0;
  rNum := 0;
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do if (raMask[I * XSize + J] = 1) then begin
//      if (PCFilt[I * XSize + J] < rMin) then rMin := PCFilt[I * XSize + J];
//      if (PCFilt[I * XSize + J] > rMax) then rMax := PCFilt[I * XSize + J];
      rNum := rNum + PCFilt[I * XSize + J];
      Inc(iCount);
    end;
//  rMin := (rMax - rMin) / 2;
  if iCount <> 0 then begin
    rNum := rNum / iCount;
    for I := 0 to YSize - 1 do
      for J := 0 to XSize - 1 do if raMask[I * XSize + J] = 0 then
        PCFilt[I * XSize + J] := rNum;
  end;
end;

procedure FillRealArrayMiddleMask(XSize, YSize : Integer;
                                  var PCFilt, raMask : TRealArray);
var
  iCount, I, J : Integer;
  rNum, rMax, rMin : TReal;
begin
  rMin := MaxDouble;
  rMax := - MaxDouble;
  iCount := 0;
  rNum := 0;
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do if (raMask[I * XSize + J] = 1) then begin
//      if (PCFilt[I * XSize + J] < rMin) then rMin := PCFilt[I * XSize + J];
//      if (PCFilt[I * XSize + J] > rMax) then rMax := PCFilt[I * XSize + J];
      rNum := rNum + PCFilt[I * XSize + J];
      Inc(iCount);
    end;
//  rMin := (rMax - rMin) / 2;
  if iCount <> 0 then begin
    rNum := rNum / iCount;
    for I := 0 to YSize - 1 do
      for J := 0 to XSize - 1 do if raMask[I * XSize + J] = 0 then
        PCFilt[I * XSize + J] := rNum;
  end;
end;

end.
