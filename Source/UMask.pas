unit UMask;

interface

uses UType;

procedure AddByMask(iW, iH : Integer;
                    var raIn1, raIn2, raMask, raOut : TRealArray);

procedure FindMaskCenter(iW, iH : Integer;
                         var raMask : TRealArray;
                         var iCX, iCY : Integer);

procedure MaskAnd3(iW, iH : Integer;
                   var raMask1, raMask2, raMask3, raMaskAnd : TRealArray);
                         
procedure MaskAnd2(iW, iH : Integer;
                   var raMask1, raMask2, raMaskAnd : TRealArray);

implementation

procedure MaskAnd2(iW, iH : Integer;
                   var raMask1, raMask2, raMaskAnd : TRealArray);
var
  iX, iY : Integer;
begin
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      if (raMask1[iY * iW + iX] = 1) and (raMask2[iY * iW + iX] = 1) then
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

procedure FindMaskCenter(iW, iH : Integer;
                         var raMask : TRealArray;
                         var iCX, iCY : Integer);
var
  iMinX, iMinY, iMaxX, iMaxY, iX, iY : Integer;
begin
  iMaxX := 0;
  iMinX := iW;
  iMaxY := 0;
  iMinY := iH;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do if raMask[iY * iW + iX] = 1 then begin
      if iY < iMinY then iMinY := iY;
      if iY > iMaxY then iMaxY := iY;
      if iX < iMinX then iMinX := iX;
      if iX > iMaxX then iMaxX := iX;
    end;
  iCX := (iMaxX - iMinX) div 2;
  iCY := (iMaxY - iMinY) div 2;
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
      
end.
 