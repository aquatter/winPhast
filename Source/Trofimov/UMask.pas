unit UMask;

interface

uses UType;

procedure BAMaskDestroyHoles(W, H, S : Integer;
                             var InM, OutM : TByteArray);

procedure BAAnd3(iW, iH : Integer;
                 var baMask1, baMask2, baMask3, baMaskAnd : TByteArray);

procedure BAAnd2(iW, iH : Integer;
                 var baMask1, baMask2, baMaskAnd : TByteArray);

procedure BAOr3(iW, iH : Integer;
                 var baMask1, baMask2, baMask3, baMaskAnd : TByteArray);

procedure BAOr2(iW, iH : Integer;
                 var baMask1, baMask2, baMaskAnd : TByteArray);

procedure MaskMakeIndent(iW, iH : Integer;
                         var raMask : TRealArray;
                         iT : Integer);

procedure AddByMask(iW, iH : Integer;
                    var raIn1, raIn2, raMask, raOut : TRealArray); overload;

procedure AddByMask(iW, iH: Integer;
                    var raIn1, raIn2: TRealArray; var raMask: TBtArr; var raOut: TRealArray); overload;

procedure FindMaskCenter(iW, iH : Integer;
                         var raMask : TRealArray;
                         var iCX, iCY : Integer);

procedure MaskAnd3(iW, iH : Integer;
                   var raMask1, raMask2, raMask3, raMaskAnd : TRealArray);

procedure MaskAnd2(iW, iH : Integer;
                   var raMask1, raMask2, raMaskAnd : TRealArray);

procedure RiseMask(iW, iH : Integer;
                   var raMaskIn, raMaskOut : TRealArray;
                   iCutSize : Integer);

procedure GrowMask(iW, iH : Integer;
                   var raMaskIn, raMaskOut : TRealArray;
                   iGrowSize : Integer); overload;

procedure GrowMask(iW, iH : Integer;
                   var raMaskIn, raMaskOut : TBtArr;
                   iGrowSize : Integer); overload;
implementation

uses Windows, Math, Graphics, UPalette;

function BAFindNextNum2(W, H : Integer;
                     Num : TReal;
                     var M, M2 : TByteArray;
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
  BAFindNextNum2 := IsEnd;
end;

procedure BAFillAreaNumIn(W, H : Integer;
                        var B : TBitmap;
                        rNum : Byte;
                        BX, BY : Integer;
                        IsFillArea : Boolean;
                        var MaskIn, MaskOut : TByteArray);
var
  I, J : Integer;
  PB : PByteArray;
begin
  for I := 0 to H - 1 do begin
    PB := B.ScanLine[I];
    for J := 0 to W - 1 do if MaskIn[I*W + J] = 1 then
      PB^[J] := 0 else PB^[J] := 255;
  end;
  B.Canvas.Brush.Color := $00808080;
  B.Canvas.Brush.Style := bsSolid;
  if IsFillArea then B.Canvas.FloodFill(BX, BY, clBlack, fsSurface)
  else B.Canvas.FloodFill(BX, BY, clBlack, fsBorder);
  for I := 0 to H - 1 do begin
    PB := B.ScanLine[I];
    for J := 0 to W - 1 do if PB^[J] = 128 then MaskOut[I*W + J] := rNum
  end;
end;

function BAFindSpace(W, H : INteger; var FindArea : TByteArray) : Integer;
var
  I, J, CX : Integer;
begin
  CX := 0;
  for I := 0 to H - 1 do
    for J := 0 to W - 1 do if FindArea[I * W + J] = 1 then Inc(CX);
  BAFindSpace := CX;
end;

procedure BAMaskDestroyHoles(W, H, S : Integer;
                             var InM, OutM : TByteArray);

var
  iCount, iByteArraySize, K, L, BX, BY : Integer;
  FindArea, InspectArea : PByteArray;
  IsPaint : Boolean;
  B : TBitmap;
begin
  B := TBitmap.Create;
  B.Height := H;
  B.Width := W;
  B.PixelFormat := pf8bit;
  B.Palette := CreateBWPalette;

  iByteArraySize := W * H;
  GetMem(FindArea, iByteArraySize);
  GetMem(InspectArea, iByteArraySize);

  FillMemory(FindArea, iByteArraySize, 0);
  FillMemory(InspectArea, iByteArraySize, 0);
  CopyMemory(Addr(OutM[0]), Addr(InM[0]), iByteArraySize);

  repeat
    IsPaint := False;
    while BAFindNextNum2(W, H, 1, OutM, InspectArea^, BX, BY) do begin
      BAFillAreaNumIn(W, H, B, 1, BX, BY, True, OutM, FindArea^);
      BAFillAreaNumIn(W, H, B, 1, BX, BY, True, OutM, InspectArea^);
      if BAFindSpace(W, H, FindArea^) < S then begin
        BAFillAreaNumIn(W, H, B, 0, BX, BY, True, FindArea^, OutM);
        IsPaint := True;
      end;
      for K := 0 to H - 1 do
        for L := 0 to W - 1 do FindArea^[K * W + L] := 0;
    end;
    for K := 0 to H - 1 do
      for L := 0 to W - 1 do InspectArea^[K * W + L] := 0;
    while BAFindNextNum2(W, H, 0, OutM, InspectArea^, BX, BY) do begin
      BAFillAreaNumIn(W, H, B, 1, BX, BY, False, OutM, FindArea^);
      BAFillAreaNumIn(W, H, B, 1, BX, BY, False, OutM, InspectArea^);
      if BAFindSpace(W, H, FindArea^) < S then begin
        BAFillAreaNumIn(W, H, B, 1, BX, BY, True, FindArea^, OutM);
        IsPaint := True;
      end;
      for K := 0 to H - 1 do
        for L := 0 to W - 1 do FindArea^[K * W + L] := 0;
    end;
    for K := 0 to H - 1 do
      for L := 0 to W - 1 do InspectArea^[K * W + L] := 0;
  until not(IsPaint);

  FreeMem(FindArea, iByteArraySize);
  FreeMem(InspectArea, iByteArraySize);

  B.Free;
end;

procedure RiseMask(iW, iH : Integer;
                   var raMaskIn, raMaskOut : TRealArray;
                   iCutSize : Integer);
var
  iX2, iY2, iMinX, iMaxX, iMinY, iMaxY, iX, iY : Integer;
  rCounter : TReal;
  praMaskTemp : PRealArray;
begin
  GetMem(praMaskTemp, iW * iH * SizeOf(TReal));
  CopyMemory(praMaskTemp, Addr(raMaskIn[0]), iW * iH * SizeOf(TReal));
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      if raMaskIn[iY * iW + iX] = 1 then begin
        if iX > 0 then iMinX := iX - 1 else iMinX := 0;
        if iX < iW - 1 then iMaxX := iX + 1 else iMaxX := iW - 1;
        if iY > 0 then iMinY := iY - 1 else iMinY := 0;
        if iY < iH - 1 then iMaxY := iY + 1 else iMaxY := iH - 1;
        rCounter := 0;
        for iY2 := iMinY to iMaxY do
          for iX2 := iMinX to iMaxX do
            rCounter := rCounter + raMaskIn[iY2 * iW + iX2];
        if rCounter < 9 then begin
          if iX > iCutSize - 1 then iMinX := iX - iCutSize + 1 else iMinX := 0;
          if iX < iW - iCutSize then iMaxX := iX + iCutSize - 1
          else iMaxX := iW - 1;
          if iY > iCutSize - 1 then iMinY := iY - iCutSize + 1 else iMinY := 0;
          if iY < iH - iCutSize then iMaxY := iY + iCutSize - 1
          else iMaxY := iH - 1;
          for iY2 := iMinY to iMaxY do
            for iX2 := iMinX to iMaxX do praMaskTemp^[iY2 * iW + iX2] := 0;
        end;
      end;
  CopyMemory(Addr(raMaskOut[0]), praMaskTemp, iW * iH * SizeOf(TReal));
end;

procedure GrowMask(iW, iH : Integer;
                   var raMaskIn, raMaskOut : TBtArr;
                   iGrowSize : Integer); overload;
var
  iX2, iY2, iMinX, iMaxX, iMinY, iMaxY, iX, iY : Integer;
  rCounter : TReal;
  praMaskTemp : PBtArr;
begin
  GetMem(praMaskTemp, iW * iH );
  CopyMemory(praMaskTemp, Addr(raMaskIn[0]), iW * iH);
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      if raMaskIn[iY * iW + iX] = 1 then begin
        if iX > 0 then iMinX := iX - 1 else iMinX := 0;
        if iX < iW - 1 then iMaxX := iX + 1 else iMaxX := iW - 1;
        if iY > 0 then iMinY := iY - 1 else iMinY := 0;
        if iY < iH - 1 then iMaxY := iY + 1 else iMaxY := iH - 1;
        rCounter := 0;
        for iY2 := iMinY to iMaxY do
          for iX2 := iMinX to iMaxX do
            rCounter := rCounter + raMaskIn[iY2 * iW + iX2];
        if rCounter < 9 then begin
          if iX > iGrowSize - 1 then iMinX := iX - iGrowSize + 1 else iMinX := 0;
          if iX < iW - iGrowSize then iMaxX := iX + iGrowSize - 1
          else iMaxX := iW - 1;
          if iY > iGrowSize - 1 then iMinY := iY - iGrowSize + 1 else iMinY := 0;
          if iY < iH - iGrowSize then iMaxY := iY + iGrowSize - 1
          else iMaxY := iH - 1;
          for iY2 := iMinY to iMaxY do
            for iX2 := iMinX to iMaxX do praMaskTemp^[iY2 * iW + iX2] := 1;
        end;
      end;
  CopyMemory(Addr(raMaskOut[0]), praMaskTemp, iW * iH);
  FreeMem(praMaskTemp, iW * iH);
end;

procedure GrowMask(iW, iH : Integer;
                   var raMaskIn, raMaskOut : TRealArray;
                   iGrowSize : Integer);
var
  iX2, iY2, iMinX, iMaxX, iMinY, iMaxY, iX, iY : Integer;
  rCounter : TReal;
  praMaskTemp : PRealArray;
begin
  GetMem(praMaskTemp, iW * iH * SizeOf(TReal));
  CopyMemory(praMaskTemp, Addr(raMaskIn[0]), iW * iH * SizeOf(TReal));
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      if raMaskIn[iY * iW + iX] = 1 then begin
        if iX > 0 then iMinX := iX - 1 else iMinX := 0;
        if iX < iW - 1 then iMaxX := iX + 1 else iMaxX := iW - 1;
        if iY > 0 then iMinY := iY - 1 else iMinY := 0;
        if iY < iH - 1 then iMaxY := iY + 1 else iMaxY := iH - 1;
        rCounter := 0;
        for iY2 := iMinY to iMaxY do
          for iX2 := iMinX to iMaxX do
            rCounter := rCounter + raMaskIn[iY2 * iW + iX2];
        if rCounter < 9 then begin
          if iX > iGrowSize - 1 then iMinX := iX - iGrowSize + 1 else iMinX := 0;
          if iX < iW - iGrowSize then iMaxX := iX + iGrowSize - 1
          else iMaxX := iW - 1;
          if iY > iGrowSize - 1 then iMinY := iY - iGrowSize + 1 else iMinY := 0;
          if iY < iH - iGrowSize then iMaxY := iY + iGrowSize - 1
          else iMaxY := iH - 1;
          for iY2 := iMinY to iMaxY do
            for iX2 := iMinX to iMaxX do praMaskTemp^[iY2 * iW + iX2] := 1;
        end;
      end;
  CopyMemory(Addr(raMaskOut[0]), praMaskTemp, iW * iH * SizeOf(TReal));
end;

procedure BAOr2(iW, iH : Integer;
                 var baMask1, baMask2, baMaskAnd : TByteArray);
var
  iCount : Integer;
begin
  for iCount := 0 to iH * iW - 1 do
    baMaskAnd[iCount] := baMask1[iCount] + baMask2[iCount]
end;

procedure BAOr3(iW, iH : Integer;
                 var baMask1, baMask2, baMask3, baMaskAnd : TByteArray);
var
  iCount : Integer;
begin
  for iCount := 0 to iH * iW - 1 do
    baMaskAnd[iCount] := baMask1[iCount] + baMask2[iCount] + baMask3[iCount]
end;

procedure BAAnd2(iW, iH : Integer;
                 var baMask1, baMask2, baMaskAnd : TByteArray);
var
  iCount : Integer;
begin
  for iCount := 0 to iH * iW - 1 do
    if (baMask1[iCount] > 0) and (baMask2[iCount] > 0) then
      baMaskAnd[iCount] := 1
    else baMaskAnd[iCount] := 0;
end;

procedure BAAnd3(iW, iH : Integer;
                 var baMask1, baMask2, baMask3, baMaskAnd : TByteArray);
var
  iCount : Integer;
begin
  for iCount := 0 to iH * iW - 1 do
    if (baMask1[iCount] > 0) and (baMask2[iCount] > 0) and (baMask3[iCount] > 0) then
      baMaskAnd[iCount] := 1
    else baMaskAnd[iCount] := 0;
end;

procedure MaskAnd2(iW, iH : Integer;
                   var raMask1, raMask2, raMaskAnd : TRealArray);
var
  iX, iY : Integer;
begin
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      if (raMask1[iY * iW + iX] > 0) and (raMask2[iY * iW + iX] > 0) then
        raMaskAnd[iY * iW + iX] := 1
      else raMaskAnd[iY * iW + iX] := 0;
end;

procedure MaskAnd3(iW, iH : Integer;
                   var raMask1, raMask2, raMask3, raMaskAnd : TRealArray);
var
  iX, iY : Integer;
begin
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      if (raMask1[iY * iW + iX] = 1) and (raMask2[iY * iW + iX] = 1) and
         (raMask3[iY * iW + iX] = 1) then raMaskAnd[iY * iW + iX] := 1
      else raMaskAnd[iY * iW + iX] := 0;
end;

procedure FindNearOnMask(iW, iH : Integer;
                         var raMask : TRealArray;
                         iCX, iCY : Integer;
                         var iNX, iNY : Integer);
var
  iTX, iTY, iX, iY : Integer;
  rTemp, rMax : TReal;
begin
  rMax := MaxDouble;
  iTX := 0;
  iTY := 0;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      if (raMask[iY * iW + iX] = 1) and ((iCX <> iX) and (iCY <> iY)) then begin
        rTemp := Sqr(iX - iCX) + Sqr(iY - iCY);
        if rTemp < rMax then begin
          iTX := iX;
          iTY := iY;
          rMax := rTemp;
        end;
      end;
  iNX := iTX;
  iNY := iTY;
end;

procedure MaskMakeIndent(iW, iH : Integer;
                         var raMask : TRealArray;
                         iT : Integer);
var
  iX, iY : Integer;
begin
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      if (iY < iT) or (iX < iT) or
         (iY > iH - 1 - iT) or (iX > iW - 1 - iT) then raMask[iY * iW + iX] := 0.0;
end;

procedure FindMaskCenter(iW, iH : Integer;
                         var raMask : TRealArray;
                         var iCX, iCY : Integer);
var
  iMinX, iMinY, iMaxX, iMaxY, iX, iY : Integer;
  rNum, rNumX, rNumY : TReal;
begin
  iMaxX := 0;
  iMinX := iW;
  iMaxY := 0;
  iMinY := iH;
  rNum := 0;
  rNumX := 0;
  rNumY := 0;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do if raMask[iY * iW + iX] = 1 then begin
      rNumY := rNumY + iY;
      rNumX := rNumX + iX;
      rNum := rNum + 1;
    end;
//    if raMask[iY * iW + iX] = 1 then begin
//      if iY < iMinY then iMinY := iY;
//      if iY > iMaxY then iMaxY := iY;
//      if iX < iMinX then iMinX := iX;
//      if iX > iMaxX then iMaxX := iX;
//    end;
//  iCX := (iMaxX - iMinX) div 2;
//  iCY := (iMaxY - iMinY) div 2;
    if rNum = 0 then begin
      iCX := 0;
      iCY := 0;
    end
    else begin
      iCX := Round(rNumX / rNum);
      iCY := Round(rNumY / rNum);
      if raMask[iCX + iCY * iW] = 0 then FindNearOnMask(iW, iH, raMask, iCX,
        iCY, iCX, iCY);
    end;
end;

procedure AddByMask(iW, iH : Integer;
                    var raIn1, raIn2, raMask, raOut : TRealArray);
var
  iX, iY : Integer;
begin
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      if raMask[iY * iW + iX] = 1 then raOut[iY * iW + iX] := raIn1[iY * iW + iX]
      else raOut[iY * iW + iX] := raIn2[iY * iW + iX]
end;

procedure AddByMask(iW, iH: Integer;
                    var raIn1, raIn2: TRealArray; var raMask: TBtArr; var raOut: TRealArray); overload;
var
  iX, iY : Integer;
begin
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      if raMask[iY * iW + iX] = 1 then raOut[iY * iW + iX] := raIn1[iY * iW + iX]
      else raOut[iY * iW + iX] := raIn2[iY * iW + iX]
end;


end.
