unit UPhShAlg;

interface

uses SysUtils, Dialogs, Math, UType, UBadPts, ULinAlg;

{
  �������� : ������������ �������� �������� ����, ������ � �������� �� 4
             ����������������� ������� ������������ ���������
             ����� ���������� � ������� ���� ����������
  ����     : Int1, Int2, Int3, Int4 - ������� � ������������������
             SizeX, SizeY - ������ ���� ��������
             Porog - ����� ��� ���������� ������� �����
  �����    : Phase, Amplitude, DeltaAll, Beta - ����, ������� ��������, �����,
             �������� �����
             BadPoints - ������ ����� (����� � ������� ������ ����������)
             !!! �������� ������� ��������� ���������� �������� !!!    
  �������� : ������ �������� � �
}
function FindPhaseApr4(var Int1, Int2, Int3, Int4,
                       Phase, Amplitude, DeltaAll, Beta, BadPoints : TRealArray;
                       Porog, SizeX, SizeY : Integer) : Integer; cdecl;

{
  �������� : ������������ �������� �������� ����, ������ � �������� �� 5
             ����������������� ������� ������������ ���������
             ����� ���������� � ������� ���� ����������
  ����     : Int1, Int2, Int3, Int4, Int5 - ������� � ������������������
             SizeX, SizeY - ������ ���� ��������
             Porog - ����� ��� ���������� ������� �����
  �����    : Phase, Amplitude, DeltaAll, Beta - ����, ������� ��������, �����,
             �������� �����
             BadPoints - ������ ����� (����� � ������� ������ ����������)
             !!! �������� ������� ��������� ���������� �������� !!!
  �������� : ������ �������� � �
}
function FindPhaseApr5(var Int1, Int2, Int3, Int4, Int5,
                       Phase, Amplitude, DeltaAll, Beta, BadPoints : TRealArray;
                       Porog, SizeX, SizeY : Integer) : Integer; cdecl;

{
  �������� : ������������ �������� �������� ����, ������ � �������� �� 6
             ����������������� ������� ������������ ���������
             ����� ���������� � ������� ���� ����������
  ����     : Int1, Int2, Int3, Int4, Int5, Int6 - ������� � ������������������
             SizeX, SizeY - ������ ���� ��������
             Porog - ����� ��� ���������� ������� �����
  �����    : Phase, Amplitude, DeltaAll, Beta - ����, ������� ��������, �����,
             �������� �����
             BadPoints - ������ ����� (����� � ������� ������ ����������)
             !!! �������� ������� ��������� ���������� �������� !!!
  �������� : ������ �������� � �
}
function FindPhaseApr6(var Int1, Int2, Int3, Int4, Int5, Int6,
                       Phase, Amplitude, DeltaAll, Beta, BadPoints : TRealArray;
                       Porog, SizeX, SizeY : Integer) : Integer; cdecl;

{
  �������� : ������������ �������� �������� ����, ������ � �������� �� 7
             ����������������� ������� ������������ ���������
             ����� ���������� � ������� ���� ����������
  ����     : Int1, Int2, Int3, Int4, Int5, Int6, Int7 - ������� � ������������������
             SizeX, SizeY - ������ ���� ��������
             Porog - ����� ��� ���������� ������� �����
  �����    : Phase, Amplitude, DeltaAll, Beta - ����, ������� ��������, �����,
             �������� �����
             BadPoints - ������ ����� (����� � ������� ������ ����������)
             !!! �������� ������� ��������� ���������� �������� !!!
  �������� : ������ �������� � �
}
function FindPhaseApr7(var Int1, Int2, Int3, Int4, Int5, Int6, Int7,
                       Phase, Amplitude, DeltaAll, Beta, BadPoints : TRealArray;
                       Porog, SizeX, SizeY : Integer) : Integer; cdecl;

{
  �������� : ������������ �������� �������� ����, ������ � �������� �� 4
             ����������������� ������� ����
  ����     : Int1, Int2, Int3, Int4 - ������� � ������������������
             SizeX, SizeY - ������ ���� ��������
  �����    : Phase, Amplitude, Delta, Beta - ����, ������� ��������, �����,
             �������� �����
             BadPoints - ������ ����� (����� � ������� ������ ����������)
             !!! �������� ������� ��������� ���������� �������� !!!
  �������� : ������ ���� �� ������� �����
}
function FindPhaseSlau4Old(var Int1, Int2, Int3, Int4,
                           Phase, Amplitude : TRealArray;
                           SizeX, SizeY : Integer) : Integer; cdecl;
                           
{
  �������� : ������������ �������� �������� ����, ������ � �������� �� 4
             ����������������� ������� ����
  ����     : Int1, Int2, Int3, Int4 - ������� � ������������������
             SizeX, SizeY - ������ ���� ��������
             Porog - ����� ��� ���������� ������� �����
  �����    : Phase, Amplitude, Delta, Beta - ����, ������� ��������, �����,
             �������� �����
             BadPoints - ������ ����� (����� � ������� ������ ����������)
             !!! �������� ������� ��������� ���������� �������� !!!
  �������� : �������� �����, �������� ��������� � �
}
procedure FindPhaseSlau4(var Int1, Int2, Int3, Int4,
                        Phase, Amplitude, Delta, Beta, BadPoints : TRealArray;
                        Porog, SizeX, SizeY : Integer);

{
  �������� : ������������ �������� �������� ����, ������ � �������� �� 5
             ����������������� ������� ����
  ����     : Int1, Int2, Int3, Int4, Int5 - ������� � ������������������
             SizeX, SizeY - ������ ���� ��������
             Porog - ����� ��� ���������� ������� �����
  �����    : Phase, Amplitude, Delta, Beta - ����, ������� ��������, �����,
             �������� �����
             BadPoints - ������ ����� (����� � ������� ������ ����������)
             !!! �������� ������� ��������� ���������� �������� !!!
  �������� : �������� ����������, �������� ��������� � �
}
function FindPhaseSlau5(var Int1, Int2, Int3, Int4, Int5,
                        Phase, Amplitude, Delta, Beta, BadPoints : TRealArray;
                        Porog, SizeX, SizeY : Integer) : Integer; cdecl;

{
  �������� : ������������ �������� �������� ����, ������ � �������� �� 6
             ����������������� ������� ����
  ����     : Int1, Int2, Int3, Int4, Int5, Int6 - ������� � ������������������
             SizeX, SizeY - ������ ���� ��������
             Porog - ����� ��� ���������� ������� �����
  �����    : Phase, Amplitude, Delta, Beta - ����, ������� ��������, �����,
             �������� �����
             BadPoints - ������ ����� (����� � ������� ������ ����������)
             !!! �������� ������� ��������� ���������� �������� !!!
  �������� : ��� ��������
}
function FindPhaseSlau6(var Int1, Int2, Int3, Int4, Int5, Int6,
                        Phase, Amplitude, Delta, Beta, BadPoints : TRealArray;
                        Porog, SizeX, SizeY : Integer) : Integer; cdecl;

{
  �������� : ������������ �������� �������� ����, ������ � �������� �� 5
             ����������������� ������� ����
  ����     : Int1, Int2, Int3, Int4, Int5, Int6, Int7 - ������� � ������������������
             SizeX, SizeY - ������ ���� ��������
             Porog - ����� ��� ���������� ������� �����
  �����    : Phase, Amplitude, Delta, Beta - ����, ������� ��������, �����,
             �������� �����
             BadPoints - ������ ����� (����� � ������� ������ ����������)
             !!! �������� ������� ��������� ���������� �������� !!!
  �������� : �������� �������, �������� ��������� � �
}
function FindPhaseSlau7(var Int1, Int2, Int3, Int4, Int5, Int6, Int7,
                        Phase, Amplitude, DeltaAll, Beta, BadPoints : TRealArray;
                        Porog, SizeX, SizeY : Integer) : Integer; cdecl;
                        
implementation

function FindPhaseSlau4Old(var Int1, Int2, Int3, Int4,
                           Phase, Amplitude : TRealArray;
                           SizeX, SizeY : Integer) : Integer; cdecl;
const
  LevelB = 0.8;
  MaxCos = 0.8;
var
  T1, T2, ApB, H, B, BMax, BThr, AbsB : TReal;
  N, I, J : INteger;
  fifl, K1, K2, K3, K4, SinDel, CosDel : TReal;
begin
  // ����� cosdel
  if False then begin
    // ������ max |b|
    BMax := 0;
    for I := 0 to SizeY - 1 do begin
      for J := 0 to SizeX - 1 do begin
        AbsB := Abs(Int2[I*SizeX + J] - Int3[I*SizeX + J]);
        if BMax < AbsB then BMax := AbsB;
      end;
    end;
    BThr := Trunc(BMax * LevelB);
    CosDel := 0;
    N := 0;
    for I := 0 to SizeY - 1 do begin
      for J := 0 to SizeX - 1 do begin
        B := Int2[I*SizeX + J] - Int3[I*SizeX + J];
        if BThr < Abs(B) then begin
          CosDel := CosDel + (Int1[I*SizeX + J] - Int4[I*SizeX + J] - B)/2/B;
          Inc(N);
        end;
      end;
    end;
    if N <> 0 then CosDel := CosDel/n;
    if CosDel > MaxCos  then CosDel := MaxCos;
    if CosDel < - MaxCos then CosDel := -MaxCos;
  end
  else CosDel := 0;
  SinDel := Sqrt(1.0 - Sqr(CosDel));
  // ������ ��������� � ����. ��� ��������� ��� ������� �������!
  K1 := 1.0/(4.0*Sqr(SinDel)*(1.0 + CosDel));
  K2 := 1.0/(4.0*Sqr(SinDel)*(1.0 - CosDel));
  K3 := SinDel/(1.0 + CosDel);
  K4 := 128.0/PI;
  for I := 0 to SizeY - 1 do begin
    for J := 0 to SizeX - 1 do begin
      T1 := Int1[I*SizeX + J] - Int3[I*SizeX + J];
      T2 := Int2[I*SizeX + J] - Int4[I*SizeX + J];
      ApB := T1 + T2;
      H := T2 - T1;
      if H = 0.0 then begin
        if ApB >= 0 then Phase[I*SizeX + J] := 0 else Phase[I*SizeX + J] := 128;
      end
      else begin
        fifl := K4*ArcTan(K3*ApB/H);
        if fifl > 0 then fifl := fifl + 0.5 else fifl := fifl - 0.5;
        if H < 0 then Phase[I*SizeX + J] := Byte(Trunc(fifl) + 64)
        else Phase[I*SizeX + J] := Byte(Trunc(fifl) - 64);
      end;
      Amplitude[I*SizeX + J] := Round(Sqrt(K1*Sqr(ApB) + K2*Sqr(H)));
    end;
  end;
  for I := 0 to SizeY - 1 do
    for J := 0 to SizeX - 1 do
      Phase[I*SizeX + J] := 2 * Pi - Phase[I*SizeX + J] * 2 * Pi / 255;
end;

procedure FindDelta7(iW, iH : Integer;
                     var raInt1, raInt2, raInt3, raInt4, raInt5, raInt6,
                     raInt7, raDelta : TRealArray;
                     var rDelta : TReal);
var
  iX, iY : Integer;
  rTemp, rInBadDelta : TReal;
begin
  // ������� ������� ������
  rInBadDelta := 2 * Pi / 7;
  rDelta := 0;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      rTemp := Abs(raInt2[iY * iW + iX] - raInt6[iY * iW + iX]);
      if rTemp < 0.1 then begin
        raDelta[iY * iW + iX] := rInBadDelta;
        rDelta := rDelta + Tan(rInBadDelta);
      end
      else begin
        rTemp := Sqrt(Abs((raInt3[iY * iW + iX] - raInt5[iY * iW + iX]) *
                      (raInt1[iY * iW + iX] - 3 * raInt3[iY * iW + iX] +
                       3 * raInt5[iY * iW + iX] - raInt7[iY * iW + iX]))) / rTemp;
        // ��������� ��������
        rDelta := rDelta + rTemp;
        // � ���������� �����������
        raDelta[iY * iW + iX] := ArcTan(rTemp);
      end;
    end;
  rDelta := ArcTan(rDelta / iW / iH);
end;

procedure FindDelta6(iW, iH : Integer;
                     var raInt1, raInt2, raInt3, raInt4, raInt5, raInt6,
                     raDelta : TRealArray;
                     var rDelta : TReal);
var
  iX, iY : Integer;
  rTemp, rInBadDelta : TReal;
begin
  // ������� ������� ������
  rInBadDelta := 2 * Pi / 6;
  rDelta := 0;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      rTemp := Abs((raInt2[iY * iW + iX] + raInt3[iY * iW + iX] -
        raInt4[iY * iW + iX] - raInt5[iY * iW + iX]) * (- raInt1[iY * iW + iX] -
        raInt6[iY * iW + iX] + 2 * raInt3[iY * iW + iX] +
        2 * raInt4[iY * iW + iX] - raInt2[iY * iW + iX] - raInt5[iY * iW + iX]));
      if rTemp < 0.1 then begin
        raDelta[iY * iW + iX] := rInBadDelta;
        rDelta := rDelta + Tan(rInBadDelta / 2);
      end
      else begin
        rTemp := Sqrt(Abs((raInt2[iY * iW + iX] - raInt3[iY * iW + iX] -
          raInt4[iY * iW + iX] + raInt5[iY * iW + iX]) * (raInt1[iY * iW + iX] -
          raInt6[iY * iW + iX] - 2 * raInt3[iY * iW + iX] +
          2 * raInt4[iY * iW + iX] - raInt2[iY * iW + iX] + raInt5[iY * iW + iX]))
          / rTemp);
        // ��������� ��������
        rDelta := rDelta + rTemp;
        // � ���������� �����������
        raDelta[iY * iW + iX] := 2 * ArcTan(rTemp)
      end;
    end;
  rDelta := 2 * ArcTan( rDelta / iW / iH);
end;

procedure FindDelta5(iW, iH : Integer;
                     var raInt1, raInt2, raInt3, raInt4, raInt5,
                     raDelta : TRealArray;
                     var rDelta : TReal);
var
  iX, iY : Integer;
  rTemp, rInBadDelta : TReal;
begin
  // ������� ������� ������
  rInBadDelta := 2 * Pi / 5;
  rDelta := 0;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      rTemp := Abs(raInt2[iY * iW + iX] - raInt4[iY * iW + iX]);
      if rTemp = 0.0 then begin
        raDelta[iY * iW + iX] := rInBadDelta;
        rDelta := rDelta + 2 * Sin(rInBadDelta);
      end
      else begin
        rTemp := Sqrt(Abs(4 * Sqr(raInt2[iY * iW + iX] - raInt4[iY * iW + iX]) -
          Sqr(raInt1[iY * iW + iX] - raInt5[iY * iW + iX]))) / rTemp;
        // ��������� ��������
        rDelta := rDelta + rTemp;
        // � ���������� �����������
        if Abs(rTemp) < 2 then raDelta[iY * iW + iX] := ArcSin(rTemp / 2);
      end;
    end;
  if Abs(rDelta / iW / iH / 2) < 1 then rDelta := ArcSin(rDelta / iW / iH / 2)
  else  rDelta := 2 * Pi / 5;
end;

procedure FindDelta4(iW, iH : Integer;
                     var raInt1, raInt2, raInt3, raInt4,
                     raDelta : TRealArray;
                     var rDelta : TReal);
var
  iX, iY : Integer;
  rTemp, rInBadDelta : TReal;
begin
  // ������� ������� ������
  rInBadDelta := 2 * Pi / 4;
  rDelta := 0;
  for iY := 0 to iH - 1 do
    for iX := 0 to iW - 1 do begin
      rTemp := Abs(raInt2[iY * iW + iX] - raInt3[iY * iW + iX] +
        raInt1[iY * iW + iX] - raInt4[iY * iW + iX]);
      if rTemp < 0.1 then begin
        raDelta[iY * iW + iX] := rInBadDelta;
        rDelta := rDelta + Tan(rInBadDelta / 2);
      end
      else begin
        rTemp := Sqrt(Abs(3 * raInt2[iY * iW + iX] - 3 * raInt3[iY * iW + iX] -
          raInt1[iY * iW + iX] + raInt4[iY * iW + iX]) / rTemp);
        // ��������� ��������
        rDelta := rDelta + rTemp;
        // � ���������� �����������
        raDelta[iY * iW + iX] := 2 * ArcTan(rTemp);
      end;
    end;
  rDelta := ArcTan(rDelta / iW / iH) * 2;
end;

function FindPhaseApr4(var Int1, Int2, Int3, Int4,
                       Phase, Amplitude, DeltaAll, Beta, BadPoints : TRealArray;
                       Porog, SizeX, SizeY : Integer) : Integer; cdecl;
var
  N, I, J : Integer;
  Delta, A, T, C, S : TReal;
  M : array [1..12] of TReal;
  MSol : array [1..3] of TReal;
  Signal : Boolean;
  InBadDelta : TReal;
begin
  // ������� ������ �����
  FindBadPoints4(Int1, Int2, Int3, Int4, Badpoints, Porog, SizeX, SizeY);
  {  �������������  }
  N := 4;
  // ������� ������� ������
  FindDelta4(SizeX, SizeY, Int1, Int2, Int3, Int4, DeltaAll, Delta);
  // ������� ���� � ������
  for I := 0 to SizeY - 1 do
    for J := 0 to SizeX - 1 do begin
      // ��������� ������� ������������� ��� ������� ��������� ��������������� �������
      M[1] := 1;
      M[2] := 1/N*Cos(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2);
      M[3] := - 1/N*Sin(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2);
      M[4] := (Int1[I*SizeX + J] + Int2[I*SizeX + J] + Int3[I*SizeX + J] +
               Int4[I*SizeX + J])/N;

      M[5] := 1/N*Cos(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2);
      M[6] := (1 + 1/N*Cos(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2))/2;
      M[7] := - 1/N*Sin(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2)/2;
      M[8] := (Int1[I*SizeX + J]*cos(0*delta) + Int2[I*SizeX + J]*cos(1*delta) +
               Int3[I*SizeX + J]*cos(2*delta) + Int4[I*SizeX + J]*cos(3*delta))/N;

      M[9]  := 1/N*Sin(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2);
      M[10] := 1/N*Sin(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2)/2;
      M[11] := (1 - 1/N*Cos(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2))/2;
      M[12] := (Int1[I*SizeX + J]*sin(0*delta) + Int2[I*SizeX + J]*sin(1*delta) +
                Int3[I*SizeX + J]*sin(2*delta) + Int4[I*SizeX + J]*sin(3*delta))/N;

      {  ������ ������� �������� ��������� - ������������ � ������� }
      Gauss126(3, M, MSol, Signal);
      // ���������� � �������� �������
      if ((MSol[2] = 0) and (MSol[3] = 0)) then begin
        Phase[I*SizeX + J] := 0;
        Beta[I*SizeX + J] := 0;
        Amplitude[I*SizeX + J] := 0;
      end
      else begin
        Phase[I*SizeX + J] := ArcTan2(MSol[3], MSol[2]) + Pi;
        Amplitude[I*SizeX + J] := MSol[1];
        Beta[I*SizeX + J] := Sqrt(Sqr(MSol[3]) + Sqr(MSol[2]));
      end;
    end;
{  FreeMem(M, 3 * 4 * SizeOf(TReal));
  FreeMem(MSol, 3*SizeOf(TReal));}
end;

function FindPhaseApr5(var Int1, Int2, Int3, Int4, Int5,
                       Phase, Amplitude, DeltaAll, Beta, BadPoints : TRealArray;
                       Porog, SizeX, SizeY : Integer) : Integer; cdecl;
var
  N, I, J : Integer;
  Delta, A, T, C, S : TReal;
  M : array [1..12] of TReal;
  MSol : array [1..3] of TReal;
  Signal : Boolean;
  InBadDelta : TReal;
  temp: PRealArray;
begin
  // ������� ������ �����
 // FindBadPoints5(Int1, Int2, Int3, Int4, Int5, Badpoints, Porog, SizeX, SizeY);
  N := 5;
  // ������� ������� ������
  GetMem(temp, SizeX*SizeY*sizeof(treal));
  FindDelta5(SizeX, SizeY, Int1, Int2, Int3, Int4, Int5, temp^, Delta);
  // ������� ���� � ������
  for I := 0 to SizeY - 1 do
    for J := 0 to SizeX - 1 do begin
      // ��������� ������� ������������� ��� ������� ��������� ��������������� �������
      M[1] := 1;
      M[2] := 1/N*Cos(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2);
      M[3] := - 1/N*Sin(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2);
      M[4] := (Int1[I*SizeX + J] + Int2[I*SizeX + J] + Int3[I*SizeX + J] +
               Int4[I*SizeX + J] + Int5[I*SizeX + J])/N;

      M[5] := 1/N*Cos(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2);
      M[6] := (1 + 1/N*Cos(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2))/2;
      M[7] := - 1/N*Sin(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2)/2;
      M[8] := (Int1[I*SizeX + J]*cos(0*delta) + Int2[I*SizeX + J]*cos(1*delta) +
               Int3[I*SizeX + J]*cos(2*delta) + Int4[I*SizeX + J]*cos(3*delta) +
               Int5[I*SizeX + J]*cos(4*delta))/N;

      M[9]  := 1/N*Sin(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2);
      M[10] := 1/N*Sin(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2)/2;
      M[11] := (1 - 1/N*Cos(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2))/2;
      M[12] := (Int1[I*SizeX + J]*sin(0*delta) + Int2[I*SizeX + J]*sin(1*delta) +
                Int3[I*SizeX + J]*sin(2*delta) + Int4[I*SizeX + J]*sin(3*delta) +
                Int5[I*SizeX + J]*sin(4*delta))/N;

      {  ������ ������� �������� ��������� - ������������ � ������� }
      Gauss126(3, M, MSol, Signal);
      // ���������� � �������� �������
      if ((MSol[2] = 0) and (MSol[3] = 0)) then begin
        Phase[I*SizeX + J] := 0;
        Beta[I*SizeX + J] := 0;
        Amplitude[I*SizeX + J] := 0;
      end
      else begin
        Phase[I*SizeX + J] := ArcTan2(MSol[3], MSol[2]) + Pi;
        Amplitude[I*SizeX + J] := MSol[1];
        Beta[I*SizeX + J] := Sqrt(Sqr(MSol[3]) + Sqr(MSol[2]));
      end;
    end;
    FreeMem(temp, SizeX*SizeY*sizeof(treal));
end;

function FindPhaseApr6(var Int1, Int2, Int3, Int4, Int5, Int6,
                       Phase, Amplitude, DeltaAll, Beta, BadPoints : TRealArray;
                       Porog, SizeX, SizeY : Integer) : Integer; cdecl;
var
  N, I, J : Integer;
  Delta, A, T, C, S : TReal;
  M : array [1..12] of TReal;
  MSol : array [1..3] of TReal;
  Signal : Boolean;
  InBadDelta : TReal;
begin
  // ������� ������ �����
  FindBadPoints6(Int1, Int2, Int3, Int4, Int5, Int6, Badpoints, Porog, SizeX, SizeY);
  N := 6;
  // ������� ������� ������
  FindDelta6(SizeX, SizeY, Int1, Int2, Int3, Int4, Int5, Int6, DeltaAll, Delta);
  // ������� ���� � ������
  for I := 0 to SizeY - 1 do
    for J := 0 to SizeX - 1 do begin
      // ��������� ������� ������������� ��� ������� ��������� ��������������� �������
      M[1] := 1;
      M[2] := 1/N*Cos(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2);
      M[3] := - 1/N*Sin(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2);
      M[4] := (Int1[I*SizeX + J] + Int2[I*SizeX + J] + Int3[I*SizeX + J] +
               Int4[I*SizeX + J] + Int5[I*SizeX + J] + Int6[I*SizeX + J])/N;

      M[5] := 1/N*Cos(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2);
      M[6] := (1 + 1/N*Cos(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2))/2;
      M[7] := - 1/N*Sin(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2)/2;
      M[8] := (Int1[I*SizeX + J]*cos(0*delta) + Int2[I*SizeX + J]*cos(1*delta) +
               Int3[I*SizeX + J]*cos(2*delta) + Int4[I*SizeX + J]*cos(3*delta) +
               Int5[I*SizeX + J]*cos(4*delta) + Int6[I*SizeX + J]*cos(5*delta))/N;

      M[9]  := 1/N*Sin(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2);
      M[10] := 1/N*Sin(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2)/2;
      M[11] := (1 - 1/N*Cos(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2))/2;
      M[12] := (Int1[I*SizeX + J]*sin(0*delta) + Int2[I*SizeX + J]*sin(1*delta) +
                Int3[I*SizeX + J]*sin(2*delta) + Int4[I*SizeX + J]*sin(3*delta) +
                Int5[I*SizeX + J]*sin(4*delta) + Int6[I*SizeX + J]*sin(5*delta))/N;

      {  ������ ������� �������� ��������� - ������������ � ������� }
      Gauss126(3, M, MSol, Signal);
      // ���������� � �������� �������
      if ((MSol[2] = 0) and (MSol[3] = 0)) then begin
        Phase[I*SizeX + J] := 0;
        Beta[I*SizeX + J] := 0;
        Amplitude[I*SizeX + J] := 0;
      end
      else begin
        Phase[I*SizeX + J] := ArcTan2(MSol[3], MSol[2]) + Pi;
        Amplitude[I*SizeX + J] := MSol[1];
        Beta[I*SizeX + J] := Sqrt(Sqr(MSol[3]) + Sqr(MSol[2]));
      end;
    end;
end;

function FindPhaseApr7(var Int1, Int2, Int3, Int4, Int5, Int6, Int7,
                       Phase, Amplitude, DeltaAll, Beta, BadPoints : TRealArray;
                       Porog, SizeX, SizeY : Integer) : Integer; cdecl;
var
  N, I, J : Integer;
  Delta, A, T, C, S : TReal;
  M : array [1..12] of TReal;
  MSol : array [1..3] of TReal;
  Signal : Boolean;
  InBadDelta : TReal;
begin
  // ������� ������ �����
  FindBadPoints7(Int1, Int2, Int3, Int4, Int5, Int6, Int7, Badpoints, Porog, SizeX, SizeY);
  N := 7;
  FindDelta7(SizeX, SizeY, Int1, Int2, Int3, Int4, Int5, Int6, Int7, DeltaAll, Delta);
  // ������� ���� � ������
  for I := 0 to SizeY - 1 do
    for J := 0 to SizeX - 1 do begin
      // ��������� ������� ������������� ��� ������� ��������� ��������������� �������
      M[1] := 1;
      M[2] := 1/N*Cos(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2);
      M[3] := - 1/N*Sin(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2);
      M[4] := (Int1[I*SizeX + J] + Int2[I*SizeX + J] + Int3[I*SizeX + J] +
               Int4[I*SizeX + J] + Int5[I*SizeX + J] + Int6[I*SizeX + J] +
               Int7[I*SizeX + J])/N;

      M[5] := 1/N*Cos(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2);
      M[6] := (1 + 1/N*Cos(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2))/2;
      M[7] := - 1/N*Sin(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2)/2;
      M[8] := (Int1[I*SizeX + J]*cos(0*delta) + Int2[I*SizeX + J]*cos(1*delta) +
               Int3[I*SizeX + J]*cos(2*delta) + Int4[I*SizeX + J]*cos(3*delta) +
               Int5[I*SizeX + J]*cos(4*delta) + Int6[I*SizeX + J]*cos(5*delta) +
               Int7[I*SizeX + J]*cos(6*delta))/N;

      M[9]  := 1/N*Sin(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2);
      M[10] := 1/N*Sin(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2)/2;
      M[11] := (1 - 1/N*Cos(delta/2*(N - 1))*Sin(N*Delta/2)/Sin(Delta/2))/2;
      M[12] := (Int1[I*SizeX + J]*sin(0*delta) + Int2[I*SizeX + J]*sin(1*delta) +
                Int3[I*SizeX + J]*sin(2*delta) + Int4[I*SizeX + J]*sin(3*delta) +
                Int5[I*SizeX + J]*sin(4*delta) + Int6[I*SizeX + J]*sin(5*delta) +
                Int7[I*SizeX + J]*sin(6*delta))/N;

      {  ������ ������� �������� ��������� - ������������ � ������� }
      Gauss126(3, M, MSol, Signal);
      // ���������� � �������� �������
      if ((MSol[2] = 0) and (MSol[3] = 0)) then begin
        Phase[I*SizeX + J] := 0;
        Beta[I*SizeX + J] := 0;
        Amplitude[I*SizeX + J] := 0;
      end
      else begin
        Phase[I*SizeX + J] := ArcTan2(MSol[3], MSol[2]) + Pi;
        Amplitude[I*SizeX + J] := MSol[1];
        Beta[I*SizeX + J] := Sqrt(Sqr(MSol[3]) + Sqr(MSol[2]));
      end;
    end;
end;

{
  �������� : ��������� ����������� ����������
  ����     : A - �������� ����������� �� - ��/2 �� ��/2
             C - ����� ������������ ���� ��������
             S - ����� ������������ ���� ������
  �����    : IsBad - ����� �� ���������
             AtanUnwrap - ����������� �� 0 �� 2 �� ����������
  �������� : �������� ��������� � �
}
function AtanUnwrap(A, C, S : TReal) : TReal;
var
  D : TReal;
begin
  D := 0.0;
  if S > D then begin
    if C > D then AtanUnWrap := A
    else begin
      if Abs(C) < D then AtanUnWrap := Pi/2
      else AtanUnWrap := Pi - A;
    end;
  end
  else begin
    if Abs(S) < D then begin
      if C > D then AtanUnWrap := 0
      else begin
        if Abs(C) < D then AtanUnWrap := 0
        else AtanUnWrap := Pi;
      end;
    end
    else begin
      if C > D then AtanUnWrap := 2*Pi - A
      else begin
        if Abs(C) < D then AtanUnWrap := 3*Pi/2
        else AtanUnWrap := Pi + A;
      end;
    end;
  end;
end;

procedure FindPhaseSlau4(var Int1, Int2, Int3, Int4,
                        Phase, Amplitude, Delta, Beta, BadPoints : TRealArray;
                        Porog, SizeX, SizeY : Integer);
var
  DeltaCount, I, J : Integer;
  rTemp, A, T, C, S, DeltaMiddle, InBadDelta : TReal;
begin
  // ������� ������ �����
  FindBadPoints4(Int1, Int2, Int3, Int4, Badpoints, Porog, SizeX, SizeY);
  // ������� ������� ������
  FindDelta4(SizeX, SizeY, Int1, Int2, Int3, Int4, Delta, DeltaMiddle);
  // ������� ���� � ������ ;)
  for I := 0 to SizeY - 1 do
    for J := 0 to SizeX - 1 do begin
      t := abs(Int2[I*SizeX + J] + Int3[I*SizeX + J] - Int1[I*SizeX + J] -
               Int4[I*SizeX + J]);
      rTemp := Int2[I*SizeX + J] - Int3[I*SizeX + J] + Int1[I*SizeX + J] -
           Int4[I*SizeX + J];
      if not(t > 0.0) then begin
        if rTemp < 0 then A := 3 * Pi / 2 else A := Pi / 2;
      end
      else begin
        // ���������� ���� - �� - �� / 2 �� �� /2
        A := arctan(Abs(rTemp) / t * Tan(DeltaMiddle / 2));
        // ���� ��������
        C := -Int1[I*SizeX + J] + Int2[I*SizeX + J] +
              Int3[I*SizeX + J] - Int4[I*SizeX + J];
        // ���� ������
        S := Int2[I*SizeX + J] - Int3[I*SizeX + J];
        // ������������� ����� ���� ���� �� ���� �� 2 ��
        A := AtanUnWrap(A, C, S);
      end;
      Phase[I*SizeX + J] := 2 * Pi - A;
      Amplitude[I*SizeX + J] := 0;
      Beta[I*SizeX + J] := 0;
    end;
end;

function FindPhaseSlau5(var Int1, Int2, Int3, Int4, Int5,
                        Phase, Amplitude, Delta, Beta, BadPoints : TRealArray;
                        Porog, SizeX, SizeY : Integer) : Integer; cdecl;
var
  I, J : Integer;
  rTemp, A, T, C, S, DeltaMiddle, InBadDelta : TReal;
begin
  // ������� ������ �����
  FindBadPoints5(Int1, Int2, Int3, Int4, Int5, Badpoints, Porog, SizeX, SizeY);
  // ������� ������� ������
  FindDelta5(SizeX, SizeY, Int1, Int2, Int3, Int4, Int5, Delta, DeltaMiddle);
  // ������� ���� � ������ ;)
  for I := 0 to SizeY - 1 do
    for J := 0 to SizeX - 1 do begin
      t := Abs(Int1[I*SizeX + J] - 2*Int3[I*SizeX + J] + Int5[I*SizeX + J]);
      rTemp := Int4[I*SizeX + J] - Int2[I*SizeX + J];
      if not(t > 0.0) then begin
        if rTemp > 0 then A := 3 * Pi / 2 else A := Pi / 2;
      end
      else begin
        // ���������� ���� - �� - �� / 2 �� �� /2
        A := ArcTan(Abs(rTemp) * 2 * Sin(DeltaMiddle) / t);
        // ���� ��������
        C := 2*Int3[I*SizeX + J] - Int1[I*SizeX + J] - Int5[I*SizeX + J];
        // ���� ������
        S := Int2[I*SizeX + J] - Int4[I*SizeX + J];
        // ������������� ����� ���� ���� �� ���� �� 2 ��
        A := AtanUnWrap(A, C, S);
      end;
      Phase[I*SizeX + J] := 2 * Pi - A;
      Amplitude[I*SizeX + J] := 0;
      Beta[I*SizeX + J] := 0;
    end;
end;

function FindPhaseSlau6(var Int1, Int2, Int3, Int4, Int5, Int6,
                        Phase, Amplitude, Delta, Beta, BadPoints : TRealArray;
                        Porog, SizeX, SizeY : Integer) : Integer; cdecl;
var
  I, J : Integer;
  rTemp, A, T, C, S, DeltaMiddle, InBadDelta : TReal;
begin
  // ������� ������ �����
  FindBadPoints6(Int1, Int2, Int3, Int4, Int5, Int6, Badpoints, Porog, SizeX, SizeY);
  // ������� ������� ������
  FindDelta6(SizeX, SizeY, Int1, Int2, Int3, Int4, Int5, Int6, Delta, DeltaMiddle);
  // ������� ���� � ������ ;)
  for I := 0 to SizeY - 1 do
    for J := 0 to SizeX - 1 do begin
      t := Abs(- Int1[I*SizeX + J] - Int6[I*SizeX + J] + 2*Int3[I*SizeX + J] +
               2*Int4[I*SizeX + J] - Int2[I*SizeX + J] - Int5[I*SizeX + J]);
      rTemp := Int1[I*SizeX + J] - Int6[I*SizeX + J] - 2*Int3[I*SizeX + J] +
        2*Int4[I*SizeX + J] - Int2[I*SizeX + J] + Int5[I*SizeX + J];
      if not(t > 0.0) then begin
        if rTemp < 0 then A := 3 * Pi / 2 else A := Pi / 2;
      end
      else begin
        // ���������� ���� - �� - �� / 2 �� �� /2
        A := ArcTan(Abs(rTemp) / t / Tan(DeltaMiddle / 2));
        // ���� ��������
        C := - (- Int1[I*SizeX + J] - Int6[I*SizeX + J] + 2*Int3[I*SizeX + J] +
               2*Int4[I*SizeX + J] - Int2[I*SizeX + J] - Int5[I*SizeX + J]);
        // ���� ������
        S := (Int1[I*SizeX + J] - Int6[I*SizeX + J] - 2*Int3[I*SizeX + J] +
              2*Int4[I*SizeX + J] - Int2[I*SizeX + J] + Int5[I*SizeX + J]);
        // ������������� ����� ���� ���� �� ���� �� 2 ��
        A := AtanUnWrap(A, C, S);
      end;
      Phase[I*SizeX + J] := 2 * Pi - A;
      Amplitude[I*SizeX + J] := 0;
      Beta[I*SizeX + J] := 0;
    end;
end;

function FindPhaseSlau7(var Int1, Int2, Int3, Int4, Int5, Int6, Int7,
                        Phase, Amplitude, DeltaAll, Beta, BadPoints : TRealArray;
                        Porog, SizeX, SizeY : Integer) : Integer; cdecl;
var
  I, J : Integer;
  rTemp, A, T, C, S, DeltaMiddle, InBadDelta : TReal;
begin
  // ������� ������ �����
  FindBadPoints7(Int1, Int2, Int3, Int4, Int5, Int6, Int7, Badpoints, Porog, SizeX, SizeY);
  // ������� ������� ������
  FindDelta7(SizeX, SizeY, Int1, Int2, Int3, Int4, Int5, Int6, Int7, DeltaAll, DeltaMiddle);
  // ������� ���� � ������ ;)
  for I := 0 to SizeY - 1 do
    for J := 0 to SizeX - 1 do begin
      t := Abs(Int2[I*SizeX + J] - 2*Int4[I*SizeX + J] + Int6[I*SizeX + J]);
      rTemp := Int6[I*SizeX + J] - Int2[I*SizeX + J];
      if not(t > 0.0) then begin
        if rTemp > 0 then A := 3 * Pi / 2 else A := Pi / 2;
      end
      else begin
        // ���������� ���� - �� - �� / 2 �� �� /2
        A := ArcTan(Abs(rTemp) / t * Tan(DeltaMiddle));
        // ���� ��������
        C := - Int2[I*SizeX + J] + 2*Int4[I*SizeX + J] - Int6[I*SizeX + J];
        // ���� ������
        S := Int3[I*SizeX + J] - Int5[I*SizeX + J];
        // ������������� ����� ���� ���� �� ���� �� 2 ��
        A := AtanUnWrap(A, C, S);
      end;
      Phase[I*SizeX + J] := 2 * Pi - A;
      Amplitude[I*SizeX + J] := 0;
      Beta[I*SizeX + J] := 0;
    end;
end;

end.
