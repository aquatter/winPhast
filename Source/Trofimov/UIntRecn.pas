unit UIntRecn;

interface

uses Math, UType, UPhsRecn, ULinAlg, UBadPts, UFill, UUnwrap, URATool;

procedure FindAbsoletePhase(W, H, R1, R2, Teta : Integer;
                            var Int1, Base1, Int2, Base2, PhaseOut, Mask : TRealArray);

procedure PhaseAbsByLessSense(iW, iH : Integer;
                              var raInt1, raBase1, raInt2, raBase2,
                              raPhase1, raPhase2, raBadPts1, raBadPts2,
                              raPhaseAbs : TRealArray);

implementation

procedure FindAbsoletePhase(W, H, R1, R2, Teta : Integer;
                            var Int1, Base1, Int2, Base2, PhaseOut, Mask : TRealArray);























  PhaseByFFT_BaseAuto_ShiftMax(W, H, 0, FX2, Int2, Base2, Phase2^, Amp2^);
  // ������ ������ ������
  for I := 0 to H - 1 do























  // ������ ������ ������ � �������� ����� � ������ ������










































procedure CalcAbsHeight(iW, iH : Integer;
                        var raPhase1, raPhase2 : TRealArray;
                        iX1, iY1, iX2, iY2, iX3, iY3, iX0, iY0 : Integer;
                        var rZ : TReal;
                        var iNPi : Integer);
var
  rX1, rX2, rY1, rY2, rK, rB : TReal;
begin
  // ������������ ������������ �������� ����
  rX1 := raPhase2[iY1 * iW + iX1];
  rX2 := raPhase2[iY2 * iW + iX2];
  rY1 := raPhase1[iY1 * iW + iX1];
  rY2 := raPhase1[iY2 * iW + iX2];
  rK := (rY2 - rY1) / (rX2 - rX1);
  rB := rY1 - rK * rX1;
  // ������������ ����
  rZ := raPhase2[iY0 * iW + iX0] * rK + rB;
  // ������������ ���������� ��
  iNPi := Round(rZ - (raPhase1[iY0 * iW + iX0]) / Pi);
end;

procedure CalcAbsHeight3(iW, iH : Integer;
                         var raPhase1, raPhase2 : TRealArray;
                         iX1, iY1, iX2, iY2 : Integer;
                         var rZ : TReal;
                         var iNPi : Integer);
var
  rX1, rX2, rX3, rY1, rY2, rY3, rA, rB, rC : TReal;
begin
  // ������������ ������������ �������� ����
  rX1 := raPhase2[iY2 * iW + iX2];
  rX2 := raPhase2[iY2 * iW + iX2 + 1];
  rX3 := raPhase2[iY2 * iW + iX2 + 2];
  rY1 := raPhase1[iY2 * iW + iX2];
  rY2 := raPhase1[iY2 * iW + iX2 + 1];
  rY3 := raPhase1[iY2 * iW + iX2 + 2];
  rA := ((rX2 - rX1) * (rY3 - rY1) - (rX3 - rX1) * (rY2 - rY1)) /
        ((rX2 - rX1) * (Sqr(rX3) - Sqr(rX1)) - (rX3 - rX1) * (Sqr(rX2) - Sqr(rX1)));
  rB :=  (rY2 - rY1 - rA * (Sqr(rX2) - Sqr(rX1))) / (rX2 - rX1);
  rC := rY1 - rA * Sqr(rX1) - rB * rX1;
  // ������������ ����
  rZ := Sqr(raPhase2[iY1 * iW + iX1]) * rA + rB * raPhase2[iY1 * iW + iX1] + rC;
  // ������������ ���������� ��
  iNPi := Round((raPhase1[iY1 * iW + iX1] - rZ) / Pi);
end;

procedure CalcAbsHeight1(iW, iH : Integer;
                         var raPhase1, raPhase2 : TRealArray;
                         iX1, iY1, iX2, iY2 : Integer;
                         var rZ : TReal;
                         var iNPi : Integer);
var
  rX1, rY1, rB : TReal;
begin
  // ������������ ������������ �������� ����
  rX1 := raPhase2[iY2 * iW + iX2];
  rY1 := raPhase1[iY2 * iW + iX2];
  rB :=  rY1 - rX1;
  // ������������ ����
  rZ := raPhase2[iY1 * iW + iX1] + rB;
  // ������������ ���������� ��
  iNPi := Round((raPhase1[iY1 * iW + iX1] - rZ) / Pi);
end;

procedure PhaseAbsByLessSense(iW, iH : Integer;
                              var raInt1, raBase1, raInt2, raBase2,
                              raPhase1, raPhase2, raBadPts1, raBadPts2,
                              raPhaseAbs : TRealArray);
var
  praAmp, praTemp : PRealArray;
  iNewPi, iX, iY : Integer;
  rNewZ : TReal;
begin
  // �������� ������
  GetMem(praAmp, iW * iH * SizeOf(TReal));
  GetMem(praTemp, iW * iH * SizeOf(TReal));
  // ����� ��������������
  PhaseByFFT_BaseAuto(iW, iH, raBase1, raInt1, raPhase1,
                      raBadPts1, praTemp^, praTemp^);
  PhaseByFFT_BaseAuto(iW, iH, raInt2, raBase2, raPhase2,
                      raBadPts2, praTemp^, praTemp^);
  // ����� ������ ���� � ������� ���� � �����
  BadPhaseGrade(iW, iH, 0.1, 5, raBadPts1, raPhaseAbs);
  DestroyHoles(iW, iH, 3000, raPhaseAbs, raBadPts1);
  BadPhaseGrade(iW, iH, 0.1, 5, raBadPts2, raPhaseAbs);
  DestroyHoles(iW, iH, 3000, raPhaseAbs, raBadPts2);
  // ��������
  FillRealArrayNum(iW, iH, raBase1, 0.0);
  FillRealArrayNum(iW, iH, raBase2, 0.0);
  // ������� ������ � ������ ����
  UnwrapPhaseSomeArea(iW, iH, raPhase1, raBadPts1, raBase1);
  UnwrapPhaseSomeArea(iW, iH, raPhase2, raBadPts2, raBase2);
  // ���� ����������������� ������
  CalcAbsHeight(iW, iH, raBase1, raBase2,
                340, 340, 440, 110, 490, 380, 450, 240, rNewZ, iNewPi);
  // ��������� �������              
  AreaIncNum(iW, iH, 450, 240, raBase1, raBadPts1, raBase1, iNewPi * Pi);
  // ����������� ������
  FreeMem(praAmp, iW * iH * SizeOf(TReal));
  FreeMem(praTemp, iW * iH * SizeOf(TReal));
end;

end.