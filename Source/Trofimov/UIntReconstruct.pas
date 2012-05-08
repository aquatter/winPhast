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

  // ����� ������� �����
  UPhsrecn.bChangeMax := bMax;
  // ��� �������� � ������
  UPhsrecn.bMoveMax := bPlane;
  // ����� ����� �����������
  UPhsrecn.bIsSector := bWindow;
  // �������� �� ������
  UPhsrecn.bCutLines := bLines;
  // ������� ����
  UPhsrecn.rKWinX := rWinX;
  UPhsrecn.rKWinY := rWinY;
  // ���������������
  // � ����������
  if bSubBW then begin
    PhaseByFFTSub1View(iW, iH, raBW, raInt, raBWSpectrum, raIntSpectrum,
      raIntSpectrumFilt, caInt);
    PhaseByFFTSub1View(iW, iH, raBWBase, raBase, raBWBaseSpectrum, raBaseSpectrum,
      raBaseSpectrumFilt, caBase);
    LogarithmFltr(iW, iH, raBWSpectrum, raBWSpectrum);
    LogarithmFltr(iW, iH, raBWBaseSpectrum, raBWBaseSpectrum);
  end
  // ��� ���������
  else begin
    PhaseByFFT1View(iW, iH, raInt, raIntSpectrum, raIntSpectrumFilt, caInt);
    PhaseByFFT1View(iW, iH, raBase, raBaseSpectrum, raBaseSpectrumFilt, caBase);
  end;
  LogarithmFltr(iW, iH, raIntSpectrum, raIntSpectrum);
  LogarithmFltr(iW, iH, raIntSpectrumFilt, raIntSpectrumFilt);
  LogarithmFltr(iW, iH, raBaseSpectrum, raBaseSpectrum);
  LogarithmFltr(iW, iH, raBaseSpectrumFilt, raBaseSpectrumFilt);
  // ���������� ����������� ������
  CANorm(iW, iH, caBase, caBase);
  CANorm(iW, iH, caInt, caInt);

  CAMakeAmpMask(iW, iH, 10, 100, caBase, pbaMaskBase^);
  CAMakeAmpMask(iW, iH, 10, 100, caInt, pbaMaskInt^);
  BAAnd2(iW, iH, pbaMaskBase^, pbaMaskInt^, baMask);
//  BAMaskDestroyHoles(iW, iH, 1000, baMask, baMask);

  // ��������� �� ����
  if not(bPlane) then CADiv(iW, iH, caInt, caBase, caOut)
  else CopyMemory(Addr(caOut[0]), Addr(caBase[0]), 2 * iW * iH * SizeOf(TReal));

  FreeMem(pbaMaskInt, iByteArraySize);
  FreeMem(pbaMaskBase, iByteArraySize);
end;

end.
