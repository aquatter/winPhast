unit UIntReconstruct;

interface

uses utype;
  
procedure IntReconstruct(iW, iH : Integer;
                         var raBW, raInt, raBWBase, raBase,
                           raBWSpectrum, raIntSpectrum, raIntSpectrumFilt,
                           raBWBaseSpectrum, raBaseSpectrum, raBaseSpectrumFilt,
                           caBase, caInt, caOut : TRealArray;
                         var baMask : TByteArray;
                         bMax, bPlane, bWindow, bLines, bSubBW : Boolean;
                         rWinX, rWinY : TReal);

implementation

uses UFiltr, UIntPreP, URATool, UFFT, UMask, Windows, UPhsrecn, UCATool;

procedure IntReconstruct(iW, iH : Integer;
                         var raBW, raInt, raBWBase, raBase,
                           raBWSpectrum, raIntSpectrum, raIntSpectrumFilt,
                           raBWBaseSpectrum, raBaseSpectrum, raBaseSpectrumFilt,
                           caBase, caInt, caOut : TRealArray;
                         var baMask : TByteArray;
                         bMax, bPlane, bWindow, bLines, bSubBW : Boolean;
                         rWinX, rWinY : TReal);
var
  pbaMaskInt, pbaMaskBase: PByteArray;
  iByteArraySize: Integer;
begin
  iByteArraySize := iW * iH;
  GetMem(pbaMaskInt, iByteArraySize);
  GetMem(pbaMaskBase, iByteArraySize);

  // Какой порядок берем
  UPhsrecn.bChangeMax := bMax;
  // как поступим с клином
  UPhsrecn.bMoveMax := bPlane;
  // Каким окном фильтровать
  UPhsrecn.bIsSector := bWindow;
  // Вырезать ли хвосты
  UPhsrecn.bCutLines := bLines;
  // Размеры окна
  UPhsrecn.rKWinX := rWinX;
  UPhsrecn.rKWinY := rWinY;
  // Восстанавливаем
  // С вычитанием
  if bSubBW then begin
    PhaseByFFTSub1View(iW, iH, raBW, raInt, raBWSpectrum, raIntSpectrum,
      raIntSpectrumFilt, caInt);
    PhaseByFFTSub1View(iW, iH, raBWBase, raBase, raBWBaseSpectrum, raBaseSpectrum,
      raBaseSpectrumFilt, caBase);
    LogarithmFltr(iW, iH, raBWSpectrum, raBWSpectrum);
    LogarithmFltr(iW, iH, raBWBaseSpectrum, raBWBaseSpectrum);
  end
  // без вычитания
  else begin
    PhaseByFFT1View(iW, iH, raInt, raIntSpectrum, raIntSpectrumFilt, caInt);
    PhaseByFFT1View(iW, iH, raBase, raBaseSpectrum, raBaseSpectrumFilt, caBase);
  end;
  LogarithmFltr(iW, iH, raIntSpectrum, raIntSpectrum);
  LogarithmFltr(iW, iH, raIntSpectrumFilt, raIntSpectrumFilt);
  LogarithmFltr(iW, iH, raBaseSpectrum, raBaseSpectrum);
  LogarithmFltr(iW, iH, raBaseSpectrumFilt, raBaseSpectrumFilt);
  // Нормировка комплексных матриц
  CANorm(iW, iH, caBase, caBase);
  CANorm(iW, iH, caInt, caInt);

  CAMakeAmpMask(iW, iH, 10, 100, caBase, pbaMaskBase^);
  CAMakeAmpMask(iW, iH, 10, 100, caInt, pbaMaskInt^);
  BAAnd2(iW, iH, pbaMaskBase^, pbaMaskInt^, baMask);
//  BAMaskDestroyHoles(iW, iH, 1000, baMask, baMask);

  // Умножение на базу
  if not(bPlane) then CADiv(iW, iH, caInt, caBase, caOut)
  else CopyMemory(Addr(caOut[0]), Addr(caBase[0]), 2 * iW * iH * SizeOf(TReal));

  FreeMem(pbaMaskInt, iByteArraySize);
  FreeMem(pbaMaskBase, iByteArraySize);
end;

end.
