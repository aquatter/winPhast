unit UIntPrepare;

interface

uses utype;
  
procedure IntPrepare(iW, iH : Integer;
                     var raBW, raInt, raBWBase, raBase, raMask,
                       raBWOut, raIntOut, raBWBaseOut, raBaseOut : TRealArray;
                     bGamma, bEnergyNorm, bApodise, bNormContrast : Boolean;
                     iQuality, iOutMask : Integer); overload

procedure IntPrepare(iW, iH : Integer;
                     var raBW, raInt, raBWBase, raBase, raMask: TBtArr;
                     var raBWOut, raIntOut, raBWBaseOut, raBaseOut: TRealArray;
                     bGamma, bEnergyNorm, bApodise, bNormContrast: Boolean;
                     iQuality, iOutMask: Integer); overload;

implementation

uses UFiltr, UIntPreP, URATool, UFFT, UMask, Windows;

procedure IntPrepare(iW, iH : Integer;
                     var raBW, raInt, raBWBase, raBase, raMask,
                       raBWOut, raIntOut, raBWBaseOut, raBaseOut : TRealArray;
                     bGamma, bEnergyNorm, bApodise, bNormContrast : Boolean;
                     iQuality, iOutMask : Integer); overload;
begin

//  MakeCorrectInt(iW, iH, raInt, raInt);
//  MakeCorrectInt(iW, iH, raBase, raBase);

  // Гамма коррекция
  if bGamma then begin
    GammaCorrection(iW, iH, 0.45, raInt, raIntOut);
    GammaCorrection(iW, iH, 0.45, raBase, raBaseOut);
    GammaCorrection(iW, iH, 0.45, raBW, raBWOut);
    GammaCorrection(iW, iH, 0.45, raBWBase, raBWBaseOut);
  end
  else begin
    CopyMemory(Addr(raIntOut[0]), Addr(raInt[0]), iW * iH * SizeOf(TReal));
    CopyMemory(Addr(raBaseOut[0]), Addr(raBase[0]), iW * iH * SizeOf(TReal));
    CopyMemory(Addr(raBWOut[0]), Addr(raBW[0]), iW * iH * SizeOf(TReal));
    CopyMemory(Addr(raBWBaseOut[0]), Addr(raBWBase[0]), iW * iH * SizeOf(TReal));
  end;
  // Гомоморфная обработка
  case iQuality of
    0 : begin
      IntHomoMorph(iW, iH, raBWOut, raIntOut, raIntOut);
      IntHomoMorph(iW, iH, raBWBaseOut, raBaseOut, raBaseOut);
    end;
    3 : begin
      IntGrayScaleNorm(iW, iH, raBWOut, raIntOut, raIntOut);
      IntGrayScaleNorm(iW, iH, raBWBaseOut, raBaseOut, raBaseOut);
    end;
  end;
  // выравнивание контраста
  if bNormContrast then begin
    RAFilterHistoRaiseLocal(iW, iH, 9, raIntOut, raIntOut, raMask);
    RAFilterHistoRaiseLocal(iW, iH, 9, raBaseOut, raBaseOut, raMask);
    RAFilterHistoRaiseLocal(iW, iH, 9, raBWOut, raBWOut, raMask);
    RAFilterHistoRaiseLocal(iW, iH, 9, raBWBaseOut, raBWBaseOut, raMask);
  end;
  // Добавление за маской
  case iOutMask of
    0 : begin
      NormRealArray(iW, iH, raBaseOut, 0, 128);
      NormRealArray(iW, iH, raBWBaseOut, 0, 128);
      AddByMask(iW, iH, raIntOut, raBaseOut, raMask, raIntOut);
      AddByMask(iW, iH, raBWOut, raBWBaseOut, raMask, raBWOut);
    end;
    1 : begin
      FillRealArrayMiddleMask(iW, iH, raIntOut, raMask);
      FillRealArrayMiddleMask(iW, iH, raBaseOut, raMask);
      FillRealArrayMiddleMask(iW, iH, raBWOut, raMask);
      FillRealArrayMiddleMask(iW, iH, raBWBaseOut, raMask);
    end;
  end;
  // аподизация
  if bApodise then begin
    ApodisFltr(iW, iH, raIntOut, raIntOut);
    ApodisFltr(iW, iH, raBaseOut, raBaseOut);
    ApodisFltr(iW, iH, raBWOut, raBWOut);
    ApodisFltr(iW, iH, raBWBaseOut, raBWBaseOut);
  end;
  // Энергетическая нормировка
  if bEnergyNorm then begin
    MakeEnergyNorm(iW, iH, raIntOut, raIntOut);
    MakeEnergyNorm(iW, iH, raBaseOut, raBaseOut);
    MakeEnergyNorm(iW, iH, raBWOut, raBWOut);
    MakeEnergyNorm(iW, iH, raBWBaseOut, raBWBaseOut);
  end;
end;

procedure IntPrepare(iW, iH : Integer;
                     var raBW, raInt, raBWBase, raBase, raMask: TBtArr;
                     var raBWOut, raIntOut, raBWBaseOut, raBaseOut: TRealArray;
                     bGamma, bEnergyNorm, bApodise, bNormContrast: Boolean;
                     iQuality, iOutMask: Integer); overload;
var i: integer;
begin
  // Гамма коррекция
  if bGamma then begin
    GammaCorrection(iW, iH, 0.45, raInt, raIntOut);
    GammaCorrection(iW, iH, 0.45, raBase, raBaseOut);
    GammaCorrection(iW, iH, 0.45, raBW, raBWOut);
    GammaCorrection(iW, iH, 0.45, raBWBase, raBWBaseOut);
  end
  else
  begin
    for i:=0 to iw*ih-1 do raIntOut[i]:=raInt[i];
    for i:=0 to iw*ih-1 do raBaseOut[i]:=raBase[i];
    for i:=0 to iw*ih-1 do raBWOut[i]:=raBW[i];
    for i:=0 to iw*ih-1 do raBWBaseOut[i]:=raBWBase[i];

  end;
  // Гомоморфная обработка
  case iQuality of
    0 : begin
      IntHomoMorph(iW, iH, raBWOut, raIntOut, raIntOut);
      IntHomoMorph(iW, iH, raBWBaseOut, raBaseOut, raBaseOut);
    end;
    3 : begin
      IntGrayScaleNorm(iW, iH, raBWOut, raIntOut, raIntOut);
      IntGrayScaleNorm(iW, iH, raBWBaseOut, raBaseOut, raBaseOut);
    end;
  end;
  // выравнивание контраста
  if bNormContrast then begin
    RAFilterHistoRaiseLocal(iW, iH, 9, raIntOut, raIntOut, raMask);
    RAFilterHistoRaiseLocal(iW, iH, 9, raBaseOut, raBaseOut, raMask);
    RAFilterHistoRaiseLocal(iW, iH, 9, raBWOut, raBWOut, raMask);
    RAFilterHistoRaiseLocal(iW, iH, 9, raBWBaseOut, raBWBaseOut, raMask);
  end;
  // Добавление за маской
  case iOutMask of
    0 : begin
      NormRealArray(iW, iH, raBaseOut, 0, 128);
      NormRealArray(iW, iH, raBWBaseOut, 0, 128);
      AddByMask(iW, iH, raIntOut, raBaseOut, raMask, raIntOut);
      AddByMask(iW, iH, raBWOut, raBWBaseOut, raMask, raBWOut);
    end;
    1 : begin
      FillRealArrayMiddleMask(iW, iH, raIntOut, raMask);
      FillRealArrayMiddleMask(iW, iH, raBaseOut, raMask);
      FillRealArrayMiddleMask(iW, iH, raBWOut, raMask);
      FillRealArrayMiddleMask(iW, iH, raBWBaseOut, raMask);
    end;
  end;
  // аподизация
  if bApodise then begin
    ApodisFltr(iW, iH, raIntOut, raIntOut);
    ApodisFltr(iW, iH, raBaseOut, raBaseOut);
    ApodisFltr(iW, iH, raBWOut, raBWOut);
    ApodisFltr(iW, iH, raBWBaseOut, raBWBaseOut);
  end;
  // Энергетическая нормировка
  if bEnergyNorm then begin
    MakeEnergyNorm(iW, iH, raIntOut, raIntOut);
    MakeEnergyNorm(iW, iH, raBaseOut, raBaseOut);
    MakeEnergyNorm(iW, iH, raBWOut, raBWOut);
    MakeEnergyNorm(iW, iH, raBWBaseOut, raBWBaseOut);
  end;  
end;


end.
