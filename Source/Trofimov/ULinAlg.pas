unit ULinAlg;

interface

uses Math, UType;

// calculates a * *x + b * *y = gcd(a, b) = *d
procedure extended_euclid(A, B : Integer; var gcd, x, y : Integer);
// computes the inverse of a modulo n
function moduloinverse(a, n : Integer) : Integer;

function FindByRemaindersGarner(T : Integer; var R, M : TIntegerArray1) : Integer;

procedure ArithmeticMean(W, H : Integer;
                         var PIn1, PIn2, POut1 : TRealArray);

{
  Описание : Решает систему u линейных алгебраических уравнений
  Вход     : в матрице a[u,u+1] содержаться левые и правые части;
  Выход    : y - решение
  Источник : CACM Algorithm 126b
}
procedure Gauss126(u : Integer;
                   var a0, y0;
                   var signal : boolean);

implementation

{
  Описание : Решает систему u линейных алгебраических уравнений
  Вход     : в матрице a[u,u+1] содержаться левые и правые части;
  Выход    : y - решение
  Источник : CACM Algorithm 126b
}
procedure Gauss126(u : Integer;
                   var a0, y0;
                   var signal : boolean);

function Indx(n,i,j : integer):integer;
begin
  Indx:=n*pred(i)+j
end;

label
  10,11,12;

var
  temp : TReal;
  i,j,k,m,n: integer;
  a : TRealArray1 absolute a0;
  y : TRealArray1 absolute y0;
begin
  // А далее все как в библиотеке
  n:=0;
  signal:=true;
10:
  n:=n+1;
  for k:=n to u do if a[Indx(u+1,k,n)]<>0 then goto 11;
  signal:=false;
  exit;
11:
  if k=n then goto 12;
  j:=u+1;
  for m:=n to j do begin
    temp:=a[Indx(u+1,n,m)];
    a[Indx(u+1,n,m)]:=a[Indx(u+1,k,m)];
    a[Indx(u+1,k,m)]:=temp
  end;
12:
  for j:=u+1 downto n do a[Indx(u+1,n,j)]:=a[Indx(u+1,n,j)]/a[Indx(u+1,n,n)];
  m:=u+1;
  for i:=k+1 to u do
    for j:=n+1 to m do
      a[Indx(u+1,i,j)]:=a[Indx(u+1,i,j)]-a[Indx(u+1,i,n)]*a[Indx(u+1,n,j)];
  if n<>u then goto 10;
  for i:=u downto 1 do begin
    y[i]:=a[Indx(u+1,i,m)];
    for k:=i-1 downto 1 do
      a[Indx(u+1,k,m)]:=a[Indx(u+1,k,m)]-a[Indx(u+1,k,i)]*y[i]
  end;
end;

// calculates a * *x + b * *y = gcd(a, b) = *d
procedure extended_euclid(A, B : Integer; var gcd, x, y : Integer);
var
    X1, Y1, X2, Y2, Q, R, SA, SB : Integer;
begin
    if (b<>0) and (a<>0) then begin
        x2 := 1;
        x1 := 0;
        y2 := 0;
        y1 := 1;
        SA := Sign(A);
        SB := Sign(B);
        A := Abs(A);
        B := Abs(B);
        repeat
            q := a div b;
            r := a mod b;
            x := x2-q*x1;
            y := y2-q*y1;
            a := b;
            b := r;
            x2 := x1;
            x1 := x;
            y2 := y1;
            y1 := y;
        until (b  <= 0);
        gcd := a;
        x := SA*x2;
        y := SB*y2;
    end
    else begin
        gcd := 0;
        x := 0;
        y := 0;
    end;
end;

// computes the inverse of a modulo n
function moduloinverse(a, n : Integer) : Integer;
var
  d, x, y : Integer;
begin
  d := 0;
  x := 0;
  y := 0;
  extended_euclid(a, n, d, x, y);
  if d = 1 then Result := x else Result := 0;
end;

function FindByRemaindersGarner(T : Integer; var R, M : TIntegerArray1) : Integer;
var
  C : array [2..100] of Integer;
  MALL, U, X, I, J : Integer;
begin
  for I := 2 to T do begin
    C[I] := 1;
    for J := 1 to I - 1 do begin
      U := moduloinverse(M[J], M[I]);
      if U < 0 then U := M[I] + U;  // вот так ляп...
      C[I] := U * C[I] mod M[I];
    end;
  end;
  U := R[1];
  X := U;
  MALL := 1;
  for I := 2 to T do begin
    U := (R[I] - X) * C[I] mod M[I];
    if U < 0 then U := M[I] + U; // вот так ляп...
    MALL := MALL * M[I - 1];
    X := X + U * MALL;
  end;
  Result := X;
end;

procedure ArithmeticMean(W, H : Integer;
                         var PIn1, PIn2, POut1 : TRealArray);
var
  I, J : Integer;
begin
  for I := 0 to H - 1 do
    for J := 0 to W - 1 do
      POut1[I * W + J] := (PIn1[I * W + J] + PIn2[I * W + J]) / 2;
end;

end.
