unit UString;

interface

uses SysUtils;

procedure S2Up(var S : Ansistring);

implementation

procedure S2Up(var S : Ansistring);
  var
    I : Byte;
  begin
    for I := 1 to Length(S) do begin
      if (S[I] >= '�') and (S[I] <= '�') then S[I] := Char(Byte(S[I]) - 80);
      if (S[I] >= '�') and (S[I] <= '�') then S[I] := Char(Byte(S[I]) - 32);
      if (S[I] >= 'a') and (S[I] <= 'z') then S[I] := Char(223 and Byte(S[I]))
    end
  end;


end.
 