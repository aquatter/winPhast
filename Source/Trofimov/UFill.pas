unit UFill;

interface

uses Graphics, UPalette, UType, URATool;
{
  Описание : Заполняет область единицами - все остальное ноль.
             Алгоритм FloodFill из объекта TCanvas который использует
             FloodFill из GDI32.DLL
  Вход     : BeginX, BeginY - точка начала нахождения области
             SizeX, SizeY - размер массива
             IsFillArea - если True - заполняем пока единицы
             если False - пока не встретим единицы
             Mask - массив с предварительной маской
  Выход    : Mask - массив с окончательной маской
  Источник : Мои исходники
}
procedure FillArea(BeginX, BeginY,
                   SizeX, SizeY : Integer;
                   IsFillArea : Boolean;
                   var MaskIn, MaskOut : TRealArray); overload;

procedure FillArea(BeginX, BeginY,
                   SizeX, SizeY : Integer;
                   IsFillArea : Boolean;
                   var MaskIn, MaskOut : TBtArr); overload;

procedure FillAreaNum(BeginX, BeginY,
                      SizeX, SizeY : Integer;
                      rNum : TReal;
                      IsFillArea : Boolean;
                      var MaskIn, MaskOut : TRealArray);

procedure FillAreaFillZero(BeginX, BeginY,
                           SizeX, SizeY : Integer;
                           IsFillArea : Boolean;
                           var MaskIn, MaskOut : TRealArray);

procedure DestroyHoles(W, H, S : Integer;
                       var InM, OutM : TRealArray);

implementation

procedure FillArea(BeginX, BeginY,
                   SizeX, SizeY : Integer;
                   IsFillArea : Boolean;
                   var MaskIn, MaskOut : TBtArr); overload;
var
  B : TBitmap;
  I, J : Integer;
  PB : PByteArray;
begin
  B := TBitmap.Create;
  B.Height := SizeY;
  B.Width := SizeX;
  B.PixelFormat := pf8bit;
  B.Palette := CreateBWPalette;
  for I := 0 to SizeY - 1 do begin
    PB := B.ScanLine[I];
    for J := 0 to SizeX - 1 do if MaskIn[I*SizeX + J] = 1 then
      PB^[J] := 0 else PB^[J] := 255;
  end;
  B.Canvas.Brush.Color := $00808080;
  B.Canvas.Brush.Style := bsSolid;
  if IsFillArea then B.Canvas.FloodFill(BeginX, BeginY, clBlack, fsSurface)
  else B.Canvas.FloodFill(BeginX, BeginY, clBlack, fsBorder);
  for I := 0 to SizeY - 1 do begin
    PB := B.ScanLine[I];
    for J := 0 to SizeX - 1 do if PB^[J] = 128 then MaskOut[I*SizeX + J] := 1
  end;
  B.Free;
end;


procedure FillArea(BeginX, BeginY,
                   SizeX, SizeY : Integer;
                   IsFillArea : Boolean;
                   var MaskIn, MaskOut : TRealArray);
var
  B : TBitmap;
  I, J : Integer;
  PB : PByteArray;
begin
  B := TBitmap.Create;
  B.Height := SizeY;
  B.Width := SizeX;
  B.PixelFormat := pf8bit;
  B.Palette := CreateBWPalette;
  for I := 0 to SizeY - 1 do begin
    PB := B.ScanLine[I];
    for J := 0 to SizeX - 1 do if MaskIn[I*SizeX + J] = 1 then
      PB^[J] := 0 else PB^[J] := 255;
  end;
  B.Canvas.Brush.Color := $00808080;
  B.Canvas.Brush.Style := bsSolid;
  if IsFillArea then B.Canvas.FloodFill(BeginX, BeginY, clBlack, fsSurface)
  else B.Canvas.FloodFill(BeginX, BeginY, clBlack, fsBorder);
  for I := 0 to SizeY - 1 do begin
    PB := B.ScanLine[I];
    for J := 0 to SizeX - 1 do if PB^[J] = 128 then MaskOut[I*SizeX + J] := 1
  end;
  B.Free;
end;

procedure FillAreaNum(BeginX, BeginY,
                      SizeX, SizeY : Integer;
                      rNum : TReal;
                      IsFillArea : Boolean;
                      var MaskIn, MaskOut : TRealArray);
var
  B : TBitmap;
  I, J : Integer;
  PB : PByteArray;
begin
  B := TBitmap.Create;
  B.Height := SizeY;
  B.Width := SizeX;
  B.PixelFormat := pf8bit;
  B.Palette := CreateBWPalette;
  for I := 0 to SizeY - 1 do begin
    PB := B.ScanLine[I];
    for J := 0 to SizeX - 1 do if MaskIn[I*SizeX + J] = 1 then
      PB^[J] := 0 else PB^[J] := 255;
  end;
  B.Canvas.Brush.Color := $00808080;
  B.Canvas.Brush.Style := bsSolid;
  if IsFillArea then B.Canvas.FloodFill(BeginX, BeginY, clBlack, fsSurface)
  else B.Canvas.FloodFill(BeginX, BeginY, clBlack, fsBorder);
  for I := 0 to SizeY - 1 do begin
    PB := B.ScanLine[I];
    for J := 0 to SizeX - 1 do if PB^[J] = 128 then MaskOut[I*SizeX + J] := rNum
  end;
  B.Free;
end;

procedure FillAreaFillZero(BeginX, BeginY,
                           SizeX, SizeY : Integer;
                           IsFillArea : Boolean;
                           var MaskIn, MaskOut : TRealArray);
var
  B : TBitmap;
  I, J : Integer;
  PB : PByteArray;
begin
  B := TBitmap.Create;
  B.Height := SizeY;
  B.Width := SizeX;
  B.PixelFormat := pf8bit;
  B.Palette := CreateBWPalette;
  for I := 0 to SizeY - 1 do begin
    PB := B.ScanLine[I];
    for J := 0 to SizeX - 1 do if MaskIn[I*SizeX + J] = 1 then
      PB^[J] := 0 else PB^[J] := 255;
  end;
  B.Canvas.Brush.Color := $00808080;
  B.Canvas.Brush.Style := bsSolid;
  if IsFillArea then B.Canvas.FloodFill(BeginX, BeginY, clBlack, fsSurface)
  else B.Canvas.FloodFill(BeginX, BeginY, clBlack, fsBorder);
  for I := 0 to SizeY - 1 do begin
    PB := B.ScanLine[I];
    for J := 0 to SizeX - 1 do if PB^[J] = 128 then MaskOut[I*SizeX + J] := 1
      else MaskOut[I*SizeX + J] := 0;
  end;
  B.Free;
end;

procedure FillAreaNumIn(W, H : Integer;
                        var B : TBitmap;
                        rNum : TReal;
                        BX, BY : Integer;
                        IsFillArea : Boolean;
                        var MaskIn, MaskOut : TRealArray);
var
  I, J : Integer;
  PB : PByteArray;
begin
  for I := 0 to H - 1 do begin
    PB := B.ScanLine[I];
    for J := 0 to W - 1 do if MaskIn[I*W + J] = 1 then
      PB^[J] := 0 else PB^[J] := 255;
  end;
  B.Canvas.Brush.Color := $00808080;
  B.Canvas.Brush.Style := bsSolid;
  if IsFillArea then B.Canvas.FloodFill(BX, BY, clBlack, fsSurface)
  else B.Canvas.FloodFill(BX, BY, clBlack, fsBorder);
  for I := 0 to H - 1 do begin
    PB := B.ScanLine[I];
    for J := 0 to W - 1 do if PB^[J] = 128 then MaskOut[I*W + J] := rNum
  end;
end;

function FindSpace(W, H : INteger; var FindArea : TRealArray) : Integer;
var
  I, J, CX : Integer;
begin
  CX := 0;
  for I := 0 to H - 1 do
    for J := 0 to W - 1 do if FindArea[I * W + J] = 1 then Inc(CX);
  FindSpace := CX;
end;

procedure DestroyHoles(W, H, S : Integer;
                       var InM, OutM : TRealArray);

var
  K, L, BX, BY : Integer;
  FindArea, InspectArea : PRealArray;
  IsPaint : Boolean;
  B : TBitmap;
begin
  B := TBitmap.Create;
  B.Height := H;
  B.Width := W;
  B.PixelFormat := pf8bit;
  B.Palette := CreateBWPalette;
  GetMem(FindArea, W * H * SizeOf(TReal));
  GetMem(InspectArea, W * H * SizeOf(TReal));
  for K := 0 to H - 1 do
    for L := 0 to W - 1 do begin
      FindArea^[K * W + L] := 0;
      InspectArea^[K * W + L] := 0;
      OutM[K * W + L] := InM[K * W + L];
    end;
  repeat
    IsPaint := False;
    while FindNextNum2(W, H, 1, OutM, InspectArea^, BX, BY) do begin
      FillAreaNumIn(W, H, B, 1, BX, BY, True, OutM, FindArea^);
      FillAreaNumIn(W, H, B, 1, BX, BY, True, OutM, InspectArea^);
      if FindSpace(W, H, FindArea^) < S then begin
        FillAreaNumIn(W, H, B, 0, BX, BY, True, FindArea^, OutM);
        IsPaint := True;
      end;
      for K := 0 to H - 1 do
        for L := 0 to W - 1 do FindArea^[K * W + L] := 0;
    end;
    for K := 0 to H - 1 do
      for L := 0 to W - 1 do InspectArea^[K * W + L] := 0;
    while FindNextNum2(W, H, 0, OutM, InspectArea^, BX, BY) do begin
      FillAreaNumIn(W, H, B, 1, BX, BY, False, OutM, FindArea^);
      FillAreaNumIn(W, H, B, 1, BX, BY, False, OutM, InspectArea^);
      if FindSpace(W, H, FindArea^) < S then begin
        FillAreaNumIn(W, H, B, 1, BX, BY, True, FindArea^, OutM);
        IsPaint := True;
      end;
      for K := 0 to H - 1 do
        for L := 0 to W - 1 do FindArea^[K * W + L] := 0;
    end;
    for K := 0 to H - 1 do
      for L := 0 to W - 1 do InspectArea^[K * W + L] := 0;
  until not(IsPaint);
  FreeMem(FindArea, W * H * SizeOf(TReal));
  FreeMem(InspectArea, W * H * SizeOf(TReal));
  B.Free;
end;

end.
