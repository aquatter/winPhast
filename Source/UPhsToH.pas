unit UPhsToH;

interface

uses UType;

{
�������� : ������������ �������������� ���� � �������� � ������ � ����������
           ��� ������ ������ � ������ ��������� ��������� ��-�� ������� �����
����     : iW , iH  - ������� �������� �� � � �� Y
           rA1, rA2, rA3 - ������������ �������������� ����
           rA, rB - ������������ �������������� ���������
           rXCCD, rYCCD - ������ ��� �������
           raPhase - ���� � ��������
�����    : raHeight - ������ � ����������
           !!! �������� ������� ��������� ���������� ����������
�������� : ����������� ���������� �.
}
procedure PhaseToHeight(iW, iH : Integer;
                        rA1, rA2, rA3, rA, rB, rXCCD, rYCCD : TReal;
                        var raPhase, raHeight : TRealArray);

implementation

procedure PhaseToHeight(iW, iH : Integer;
                        rA1, rA2, rA3, rA, rB, rXCCD, rYCCD : TReal;
                        var raPhase, raHeight : TRealArray);
var
  praX, praY, praZ : PRealArray;
  iX, iY : Integer;
begin
  // �������� ������
  GetMem(praX, iW * iH * SizeOf(TReal));
  GetMem(praY, iW * iH * SizeOf(TReal));
  GetMem(praZ, iW * iH * SizeOf(TReal));
  // ���� ������ � ���������� � ����������� ����������
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      praZ^[iY * iW + iX] := rA1 * Sqr(raPhase[iY * iW + iX]) +
                             rA2 * raPhase[iY * iW + iX] + rA3;
      praX^[iY * iW + iX] := (rA + rB * praZ^[iY * iW + iX]) * iX / iW * rXCCD;
      praY^[iY * iW + iX] := (rA + rB * praZ^[iY * iW + iX]) * iY / iH * rYCCD;
    end;
  // ��������� �������� ������ � ����������� �������������
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
    
    end;
  // ����������� ������
  FreeMem(praX, iW * iH * SizeOf(TReal));
  FreeMem(praY, iW * iH * SizeOf(TReal));
  FreeMem(praZ, iW * iH * SizeOf(TReal));
end;

end.
