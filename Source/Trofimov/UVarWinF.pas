unit UVarWinF;

interface

uses UType;

procedure RAFindMiddle(iW, iH : Integer;
                       var raIn : TRealArray; var rMiddle : TReal);

procedure RAFindMiddleMask(iW, iH : Integer;
                           var raIn : TRealArray;
                           var baMask : TByteArray;
                           var rMiddle : TReal);

procedure RAFindQuadrMean(iW, iH : Integer;
                          var raIn : TRealArray;
                          var rQMean : TReal);

procedure RAFindQuadrMeanMask(iW, iH : Integer;
                              var raIn : TRealArray;
                              var baMask : TByteArray;
                              var rQMean : TReal);

procedure RAFiltLinearVarWind(iW, iH : Integer;
                              var raIn, raOut, raL, raR, raT, raB, raMask : TRealArray;
                              iWindMax : Integer); overload;

procedure RAFiltLinearVarWind(iW, iH: Integer;
                              var raIn, raOut: TRealArray;
                              var raMask: TBtArr;
                              iWindMax: Integer); overload;

implementation

uses Math, Windows;

procedure RAFindMiddle(iW, iH : Integer;
                       var raIn : TRealArray; var rMiddle : TReal);
var
  iX, iY : Integer;
  rTemp : TReal;
begin
  rTemp := 0.0;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do rTemp := rTemp + raIn[iW * iY + iX];
  rMiddle := rTemp / iW / iH;
end;

procedure RAFindMiddleMask(iW, iH : Integer;
                           var raIn : TRealArray;
                           var baMask : TByteArray;
                           var rMiddle : TReal);
var
  iPointsNum, iX, iY : Integer;
  rTemp : TReal;
begin
  rTemp := 0.0;
  iPointsNum := 0;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do if baMask[iW * iY + iX] = 1 then begin
      rTemp := rTemp + raIn[iW * iY + iX];
      Inc(iPointsNum);
    end;
  rMiddle := rTemp / iPointsNum;
end;

procedure RAFindQuadrMean(iW, iH : Integer;
                          var raIn : TRealArray;
                          var rQMean : TReal);
var
  iX, iY : Integer;
  rMiddle, rTemp : TReal;
begin
  RAFindMiddle(iW, iH, raIn, rMiddle);
  rTemp := 0.0;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do rTemp := rTemp + Sqr(raIn[iW * iY + iX] - rMiddle);
  rQMean := rTemp / iW / iH;
end;

procedure RAFindQuadrMeanMask(iW, iH : Integer;
                              var raIn : TRealArray;
                              var baMask : TByteArray;
                              var rQMean : TReal);
var
  iPointsNum, iX, iY : Integer;
  rMiddle, rTemp : TReal;
begin
  RAFindMiddleMask(iW, iH, raIn, baMask, rMiddle);
  rTemp := 0.0;
  iPointsNum := 0;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do if baMask[iW * iY + iX] = 1 then begin
      rTemp := rTemp + Sqr(raIn[iW * iY + iX] - rMiddle);
      Inc(iPointsNum);
    end;
  rQMean := rTemp / iPointsNum;
end;

const
  ChiSqrQuant_0_95 : array [1..30] of TReal =
    (0.0069, 0.103, 0.352, 0.71, 1.14, 1.65, 2.17, 2.73, 3.32, 3.94,
     6.6, 5.2, 5.9, 6.6, 7.3, 8.0, 8.7, 9.4, 10, 10.9,
     11.6, 12.3, 13.1, 13.8, 14.6, 15.4, 16.2, 16.9, 17.7, 18.5);
  ChiSqrQuant_0_05 : array [1..30] of TReal =
    (3.8, 5.9, 7.8, 9.5, 11.1, 12.6, 14.1, 15.5, 16.9, 18.3,
     19.7, 21.0, 22.4, 23.7, 25.0, 26.3, 27.6, 28.9, 30.1, 31.4,
     32.7, 33.9, 35.2, 36.4, 37.7, 38.9, 40.1, 41.3, 42.6, 43.6);




procedure RAFiltLinearVarWind(iW, iH: Integer; var raIn, raOut: TRealArray;
                              var raMask: TBtArr; iWindMax: Integer); overload;
var
  iIncL, iIncR, iIncT, iIncB, iM, iK, iR, iL, iT, iB, iX, iY, iCount, iLCount,
    iRCount, iTCount, iBCount : Integer;
  rMiddle, rSum, rThrB, rThrT, rThrR, rThrL, rS2T, rS2B, rS2L, rS2R,
    rQMean : TReal;
  bIsStopL, bIsStopR, bIsStopT, bIsStopB : Boolean;
  pbaMask : PByteArray;
  praOut : PRealArray;
begin
  GetMem(pbaMask, iW * iH);
  GetMem(praOut, iW * iH * SizeOf(TReal));

  {for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      if raMask[iY * iW + iX] = 1 then pbaMask^[iY * iW + iX] := 1
      else pbaMask^[iY * iW + iX] := 0;}
  CopyMemory(pbaMask, @(raMask[0]), iW * iH);

  RAFindQuadrMeanMask(iW, iH, raIn, pbaMask^, rQMean);

  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do if pbaMask^[iY * iW + iX] = 1 then begin

      iR := 1;
      iL := 1;
      iT := 1;
      iB := 1;

      iIncL := 0;
      iIncR := 0;
      iIncT := 0;
      iIncB := 0;
      bIsStopL := False;
      bIsStopR := False;
      bIsStopT := False;
      bIsStopB := False;

      while not(bIsStopL and bIsStopR and bIsStopT and bIsStopB) do begin

        rS2L := 0.0;
        rS2R := 0.0;
        rS2T := 0.0;
        rS2B := 0.0;
        iLCount := 0;
        iRCount := 0;
        iTCount := 0;
        iBCount := 0;
        for iK := -iT to iB do begin
          if pbaMask^[(iY + iK) * iW + iX - iL] = 1 then begin
            rS2L := rS2L + Sqr(raIn[(iY + iK) * iW + iX - iL] - raIn[iY * iW + iX]);
            Inc(iLCount);
          end;
          if pbaMask^[(iY + iK) * iW + iX + iR] = 1 then begin
            rS2R := rS2R + Sqr(raIn[(iY + iK) * iW + iX + iR] - raIn[iY * iW + iX]);
            Inc(iRCount);
          end;
        end;
        for iK := -iL to iR do begin
          if pbaMask^[(iY - iT) * iW + iX + iK] = 1 then begin
            rS2T := rS2T + Sqr(raIn[(iY - iT) * iW + iX + iK] - raIn[iY * iW + iX]);
            Inc(iTCount);
          end;
          if pbaMask^[(iY + iB) * iW + iX + iK] = 1 then begin
            rS2B := rS2B + Sqr(raIn[(iY + iB) * iW + iX + iK] - raIn[iY * iW + iX]);
            Inc(iBCount);
          end;
        end;
        if iLCount <> 0 then begin
          rS2L := rS2L / iLCount;
          rThrL := 100 / (ChiSqrQuant_0_05[iLCount] / (iLCount));
        end
        else bIsStopL := True;
        if iRCount <> 0 then begin
          rS2R := rS2R / iRCount;
          rThrR := 100 / (ChiSqrQuant_0_05[iRCount] / (iRCount));
        end
        else bIsStopR := True;
        if iTCount <> 0 then begin
          rS2T := rS2T / iTCount;
          rThrT := 100 / (ChiSqrQuant_0_05[iTCount] / (iTCount));
        end
        else bIsStopT := True;
        if iBCount <> 0 then begin
          rS2B := rS2B / iBCount;
          rThrB := 100 / (ChiSqrQuant_0_05[iBCount] / (iBCount));
        end
        else bIsStopB := True;

        if not(bIsStopL) then begin
          if rS2L * rThrL < rQMean then begin
            if (iL = iWindMax) or (iX - iL = 0) then bIsStopL := True
            else iL := iL + 1;
            if iIncL = 0 then iIncL := 1;
            if iIncL = -1 then bIsStopL := True;
          end
          else begin
            if iL = 0 then bIsStopL := True else iL := iL - 1;
            if iIncL = 0 then iIncL := -1;
            if iIncL = 1 then bIsStopL := True;
          end;
        end;
        if not(bIsStopR) then begin
          if rS2R * rThrR < rQMean then begin
            if (iR = iWindMax) or (iX + iR = iW - 1) then bIsStopR := True
            else iR := iR + 1;
            if iIncR = 0 then iIncR := 1;
            if iIncR = -1 then bIsStopR := True;
          end
          else begin
            if iR = 0 then bIsStopR := True else iR := iR - 1;
            if iIncR = 0 then iIncR := -1;
            if iIncR = 1 then bIsStopR := True;
          end;
        end;
        if not(bIsStopT) then begin
          if rS2T * rThrT < rQMean then begin
            if (iT = iWindMax) or (iY - iT = 0) then bIsStopT := True
            else iT := iT + 1;
            if iIncT = 0 then iIncT := 1;
            if iIncT = -1 then bIsStopT := True;
          end
          else begin
            if iT = 0 then bIsStopT := True else iT := iT - 1;
            if iIncT = 0 then iIncT := -1;
            if iIncT = 1 then bIsStopT := True;
          end;
        end;
        if not(bIsStopB) then begin
          if rS2B * rThrB < rQMean then begin
            if (iB = iWindMax) or (iY + iB = iH - 1) then bIsStopB := True
            else iB := iB + 1;
            if iIncB = 0 then iIncB := 1;
            if iIncB = -1 then bIsStopB := True;
          end
          else begin
            if iB = 0 then bIsStopB := True else iB := iB - 1;
            if iIncB = 0 then iIncB := -1;
            if iIncB = 1 then bIsStopB := True;
          end;
        end;
      end;

      rSum := 0.0;
      iCount := 0;
      for iK := -iL to iR do
        for iM := -iT to iB do
          if pbaMask^[(iY + iM) * iW + iX + iK] =  1 then begin
            rSum := rSum + raIn[(iY + iM) * iW + iX + iK];
            Inc(iCount);
          end;
      if iCount = (iL + iR + 1) * (iT + iB + 1) then
        praOut^[iY * iW + iX] := rSum / iCount
      else praOut^[iY * iW + iX] := raIn[iY * iW + iX];
      {raL[iY * iW + iX] := iL;
      raR[iY * iW + iX] := iR;
      raT[iY * iW + iX] := iT;
      raB[iY * iW + iX] := iB;}
    end;

//  RAFindMiddleMask(iW, iH, praOut^, pbaMask^, rMiddle);
//  for iY := 0 to iH - 1 do
//    for iX := 0 to iW - 1 do if pbaMask^[iY * iW + iX] = 0 then
//      praOut^[iY * iW + iX] := rMiddle;

  CopyMemory(Addr(raOut[0]), praOut, iW * iH * SizeOf(TReal));

  FreeMem(pbaMask, iW * iH);
  FreeMem(praOut, iW * iH * SizeOf(TReal));
end;






procedure RAFiltLinearVarWind(iW, iH : Integer;
                              var raIn, raOut, raL, raR, raT, raB, raMask : TRealArray;
                              iWindMax : Integer);
var
  iIncL, iIncR, iIncT, iIncB, iM, iK, iR, iL, iT, iB, iX, iY, iCount, iLCount,
    iRCount, iTCount, iBCount : Integer;
  rMiddle, rSum, rThrB, rThrT, rThrR, rThrL, rS2T, rS2B, rS2L, rS2R,
    rQMean : TReal;
  bIsStopL, bIsStopR, bIsStopT, bIsStopB : Boolean;
  pbaMask : PByteArray;
  praOut : PRealArray;
begin
  GetMem(pbaMask, iW * iH);
  GetMem(praOut, iW * iH * SizeOf(TReal));

  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do
      if raMask[iY * iW + iX] = 1 then pbaMask^[iY * iW + iX] := 1
      else pbaMask^[iY * iW + iX] := 0;

  RAFindQuadrMeanMask(iW, iH, raIn, pbaMask^, rQMean);

  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do if pbaMask^[iY * iW + iX] = 1 then begin

      iR := 1;
      iL := 1;
      iT := 1;
      iB := 1;

      iIncL := 0;
      iIncR := 0;
      iIncT := 0;
      iIncB := 0;
      bIsStopL := False;
      bIsStopR := False;
      bIsStopT := False;
      bIsStopB := False;

      while not(bIsStopL and bIsStopR and bIsStopT and bIsStopB) do begin

        rS2L := 0.0;
        rS2R := 0.0;
        rS2T := 0.0;
        rS2B := 0.0;
        iLCount := 0;
        iRCount := 0;
        iTCount := 0;
        iBCount := 0;
        for iK := -iT to iB do begin
          if pbaMask^[(iY + iK) * iW + iX - iL] = 1 then begin
            rS2L := rS2L + Sqr(raIn[(iY + iK) * iW + iX - iL] - raIn[iY * iW + iX]);
            Inc(iLCount);
          end;
          if pbaMask^[(iY + iK) * iW + iX + iR] = 1 then begin
            rS2R := rS2R + Sqr(raIn[(iY + iK) * iW + iX + iR] - raIn[iY * iW + iX]);
            Inc(iRCount);
          end;
        end;
        for iK := -iL to iR do begin
          if pbaMask^[(iY - iT) * iW + iX + iK] = 1 then begin
            rS2T := rS2T + Sqr(raIn[(iY - iT) * iW + iX + iK] - raIn[iY * iW + iX]);
            Inc(iTCount);
          end;
          if pbaMask^[(iY + iB) * iW + iX + iK] = 1 then begin
            rS2B := rS2B + Sqr(raIn[(iY + iB) * iW + iX + iK] - raIn[iY * iW + iX]);
            Inc(iBCount);
          end;
        end;
        if iLCount <> 0 then begin
          rS2L := rS2L / iLCount;
          rThrL := 100 / (ChiSqrQuant_0_05[iLCount] / (iLCount));
        end
        else bIsStopL := True;
        if iRCount <> 0 then begin
          rS2R := rS2R / iRCount;
          rThrR := 100 / (ChiSqrQuant_0_05[iRCount] / (iRCount));
        end
        else bIsStopR := True;
        if iTCount <> 0 then begin
          rS2T := rS2T / iTCount;
          rThrT := 100 / (ChiSqrQuant_0_05[iTCount] / (iTCount));
        end
        else bIsStopT := True;
        if iBCount <> 0 then begin
          rS2B := rS2B / iBCount;
          rThrB := 100 / (ChiSqrQuant_0_05[iBCount] / (iBCount));
        end
        else bIsStopB := True;

        if not(bIsStopL) then begin
          if rS2L * rThrL < rQMean then begin
            if (iL = iWindMax) or (iX - iL = 0) then bIsStopL := True
            else iL := iL + 1;
            if iIncL = 0 then iIncL := 1;
            if iIncL = -1 then bIsStopL := True;
          end
          else begin
            if iL = 0 then bIsStopL := True else iL := iL - 1;
            if iIncL = 0 then iIncL := -1;
            if iIncL = 1 then bIsStopL := True;
          end;
        end;
        if not(bIsStopR) then begin
          if rS2R * rThrR < rQMean then begin
            if (iR = iWindMax) or (iX + iR = iW - 1) then bIsStopR := True
            else iR := iR + 1;
            if iIncR = 0 then iIncR := 1;
            if iIncR = -1 then bIsStopR := True;
          end
          else begin
            if iR = 0 then bIsStopR := True else iR := iR - 1;
            if iIncR = 0 then iIncR := -1;
            if iIncR = 1 then bIsStopR := True;
          end;
        end;
        if not(bIsStopT) then begin
          if rS2T * rThrT < rQMean then begin
            if (iT = iWindMax) or (iY - iT = 0) then bIsStopT := True
            else iT := iT + 1;
            if iIncT = 0 then iIncT := 1;
            if iIncT = -1 then bIsStopT := True;
          end
          else begin
            if iT = 0 then bIsStopT := True else iT := iT - 1;
            if iIncT = 0 then iIncT := -1;
            if iIncT = 1 then bIsStopT := True;
          end;
        end;
        if not(bIsStopB) then begin
          if rS2B * rThrB < rQMean then begin
            if (iB = iWindMax) or (iY + iB = iH - 1) then bIsStopB := True
            else iB := iB + 1;
            if iIncB = 0 then iIncB := 1;
            if iIncB = -1 then bIsStopB := True;
          end
          else begin
            if iB = 0 then bIsStopB := True else iB := iB - 1;
            if iIncB = 0 then iIncB := -1;
            if iIncB = 1 then bIsStopB := True;
          end;
        end;
      end;

      rSum := 0.0;
      iCount := 0;
      for iK := -iL to iR do
        for iM := -iT to iB do
          if pbaMask^[(iY + iM) * iW + iX + iK] =  1 then begin
            rSum := rSum + raIn[(iY + iM) * iW + iX + iK];
            Inc(iCount);
          end;
      if iCount = (iL + iR + 1) * (iT + iB + 1) then
        praOut^[iY * iW + iX] := rSum / iCount
      else praOut^[iY * iW + iX] := raIn[iY * iW + iX];
      raL[iY * iW + iX] := iL;
      raR[iY * iW + iX] := iR;
      raT[iY * iW + iX] := iT;
      raB[iY * iW + iX] := iB;
    end;

//  RAFindMiddleMask(iW, iH, praOut^, pbaMask^, rMiddle);
//  for iY := 0 to iH - 1 do
//    for iX := 0 to iW - 1 do if pbaMask^[iY * iW + iX] = 0 then
//      praOut^[iY * iW + iX] := rMiddle;

  CopyMemory(Addr(raOut[0]), praOut, iW * iH * SizeOf(TReal));

  FreeMem(pbaMask, iW * iH);
  FreeMem(praOut, iW * iH * SizeOf(TReal));
end;

end.
 