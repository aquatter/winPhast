unit UIntPreP;

interface

uses Windows, UType, UMask, UFFT, UFiltr, URATool;

procedure IntPreProcess(iW, iH : Integer;
                        var raGrayObject, raInt, raGrayBase, raBase, raMask,
                        raOut, raOutBase : TRealArray);

procedure IntHomoMorph(iW, iH : Integer ; var raGray, raIn, raOut : TRealArray);                        

implementation

procedure IntHomoMorph(iW, iH : Integer ; var raGray, raIn, raOut : TRealArray);
var
  praOut : PRealArray;
  iY, iX : Integer;
  rK : TReal;
begin
  // �����������
  rK := 1;
  // �������� ������
  GetMem(praOut, iW * iH * SizeOf(TReal));
  // �������� � �������� ������
  CopyMemory(Addr(raOut[0]), Addr(raIn[0]), iW * iH * SizeOf(TReal));
  CopyMemory(Addr(praOut^[0]), Addr(raGray[0]), iW * iH * SizeOf(TReal));
  // ��������� ��� ���������
  NormRealArray(iW, iH, raOut, 1, 256);
  NormRealArray(iW, iH, praOut^, 1, 256);
  // ������������� �������� � ��������������
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      raOut[iY * iW + iX] := Exp(Ln(raOut[iY * iW + iX]) -
        rK * Ln(praOut^[iY * iW + iX]));
      if raOut[iY * iW + iX] > 1.005 then raOut[iY * iW + iX] := 1.005;
    end;
  // ���������
  NormRealArray(iW, iH, raOut, 0, 255);
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      if raGray[iY * iW + iX] < 10 then raOut[iY * iW + iX] := 128;
    end;
  // ����������� ������
  FreeMem(praOut, iW * iH * SizeOf(TReal));
end;

procedure IntPreProcess(iW, iH : Integer;
                        var raGrayObject, raInt, raGrayBase, raBase, raMask,
                        raOut, raOutBase : TRealArray);
var
  praInt, praBase : PRealArray;
begin
  // �������� ������
  GetMem(praInt, iW * iH * SizeOf(TReal));
  GetMem(praBase, iW * iH * SizeOf(TReal));
  // ��������� ������ � ������� ������ �������
  FillRealArrayNum(iW, iH, praBase^, 0.0);
  CopyMemory(Addr(praInt^[0]), Addr(raInt[0]), iW * iH * SizeOf(TReal));
  AddByMask(iW, iH, raInt, raBase, raMask, praInt^);
  // ����������� ���������
  IntHomoMorph(iW, iH, raGrayObject, praInt^, praInt^);
  IntHomoMorph(iW, iH, raGrayBase, raBase, praBase^);
  // �������������� ���������� ��� ���������� �������� �������
  MakeMiddleNorm(iW, iH, praInt^, raOut);
  MakeMiddleNorm(iW, iH, praBase^, raOutBase);
{  // �� ����������
  GaussianFiltration(iW, iH, 5, 5, raOut, praInt^);}
  // ����������� ������
  FreeMem(praInt, iW * iH * SizeOf(TReal));
  FreeMem(praBase, iW * iH * SizeOf(TReal));
end;

end.
