unit UPalette;

interface

uses Windows;

function CreateSpectrPalette  : HPalette;
function CreateBWPalette  : HPalette;
function CreateTermoPalette  : HPalette;

type
  TPaletteEntryArray = array [0..255] of TPaletteEntry;

var
  peaBW, peaSpectr, peaTermo : array [0..255] of TPaletteEntry;

implementation

{  �������� ��������� ������  }

function CreateBWPalette  : HPalette;
var
  I : Integer;
  Pal : PLogPalette;
begin
  {  �������� ������ ��� �������  }
  GetMem(Pal, SizeOf(TLogPalette) + (256 - 1)*SizeOf(TPaletteEntry));
  {  ������� �������  }
  Pal^.palVersion := $300;
  Pal^.palNumEntries := 256;
  CopyMemory(Addr(Pal^.palPalEntry[0]), Addr(peaBW[0]), (256 - 1)*SizeOf(TPaletteEntry));
  {  ������������ �������  }
  CreateBWPalette := CreatePalette(Pal^);
  {  ����������� ������  }
  FreeMem(Pal, SizeOf(TLogPalette) + (256 - 1)*SizeOf(TPaletteEntry));
end;

function CreateSpectrPalette  : HPalette;
var
  I : Integer;
  Pal : PLogPalette;
begin
  {  �������� ������ ��� �������  }
  GetMem(Pal, SizeOf(TLogPalette) + (256 - 1)*SizeOf(TPaletteEntry));
  {  ������� �������  }
  Pal^.palVersion := $300;
  Pal^.palNumEntries := 256;
  CopyMemory(Addr(Pal^.palPalEntry[0]), Addr(peaSpectr[0]), (256 - 1)*SizeOf(TPaletteEntry));
  {  ������������ �������  }
  CreateSpectrPalette := CreatePalette(Pal^);
  {  ����������� ������  }
  FreeMem(Pal, SizeOf(TLogPalette) + (256 - 1)*SizeOf(TPaletteEntry));
end;

function CreateTermoPalette  : HPalette;
var
  I : Integer;
  Pal : PLogPalette;
begin
  {  �������� ������ ��� �������  }
  GetMem(Pal, SizeOf(TLogPalette) + (256 - 1)*SizeOf(TPaletteEntry));
  {  ������� �������  }
  Pal^.palVersion := $300;
  Pal^.palNumEntries := 256;
  CopyMemory(Addr(Pal^.palPalEntry[0]), Addr(peaTermo[0]), (256 - 1)*SizeOf(TPaletteEntry));
  {  ������������ �������  }
  CreateTermoPalette := CreatePalette(Pal^);
  {  ����������� ������  }
  FreeMem(Pal, SizeOf(TLogPalette) + (256 - 1)*SizeOf(TPaletteEntry));
end;

var
  iCounter : Integer;

begin
  // �����
  for iCounter := 0 to 255 do begin
    peaBW[iCounter].peRed := iCounter;
    peaBW[iCounter].peGreen := iCounter;
    peaBW[iCounter].peBlue := iCounter;
    peaBW[iCounter].peFlags := 0;
  end;
  // ������
  {  ���������� - �����  }
  for iCounter := 0 to 63 do begin
    peaSpectr[iCounter].peRed := 128 - iCounter*2;
    peaSpectr[iCounter].peGreen := 0;
    peaSpectr[iCounter].peBlue := 128 + iCounter*2;
    peaSpectr[iCounter].peFlags := 0;
  end;
  {  ����� - �������  }
  for iCounter := 64 to 127 do begin
    peaSpectr[iCounter].peRed := 0;
    peaSpectr[iCounter].peGreen := (iCounter - 64)*4 + 1;
    peaSpectr[iCounter].peBlue := 255 - (iCounter - 64)*4;
    peaSpectr[iCounter].peFlags := 0;
  end;
  {  ������� - ������  }
  for iCounter := 128 to 191 do begin
    peaSpectr[iCounter].peRed := (iCounter - 128)*4;
    peaSpectr[iCounter].peGreen := 255;
    peaSpectr[iCounter].peBlue := 0;
    peaSpectr[iCounter].peFlags := 0;
  end;
  {  ������ - �������  }
  for iCounter := 192 to 255 do begin
    peaSpectr[iCounter].peRed := 255;
    peaSpectr[iCounter].peGreen := 255 - (iCounter - 192)*4;
    peaSpectr[iCounter].peBlue := 0;
    peaSpectr[iCounter].peFlags := 0;
  end;
  // ����������
  // ����� - ������
  for iCounter := 0 to 51 do begin
    peaTermo[iCounter].peRed := 255;
    peaTermo[iCounter].peGreen := 255;
    peaTermo[iCounter].peBlue := 255 - iCounter * 5;
    peaTermo[iCounter].peFlags := 0;
  end;
  // ������ - �������
  for iCounter := 51 to 102 do begin
    peaTermo[iCounter].peRed := 255;
    peaTermo[iCounter].peGreen := 255 - (iCounter - 51) * 5;
    peaTermo[iCounter].peBlue := 0;
    peaTermo[iCounter].peFlags := 0;
  end;
  // ������� - �������
  for iCounter := 102 to 153 do begin
    peaTermo[iCounter].peRed := 255 - (iCounter - 102) * 5;
    peaTermo[iCounter].peGreen := (iCounter - 102) * 5;
    peaTermo[iCounter].peBlue := 0;
    peaTermo[iCounter].peFlags := 0;
  end;
  // ������� - �����
  for iCounter := 153 to 204 do begin
    peaTermo[iCounter].peRed := 0;
    peaTermo[iCounter].peGreen := 255 - (iCounter - 153) * 5;
    peaTermo[iCounter].peBlue := (iCounter - 153) * 5;
    peaTermo[iCounter].peFlags := 0;
  end;
  // ����� - ������
  for iCounter := 204 to 255 do begin
    peaTermo[iCounter].peRed := 0;
    peaTermo[iCounter].peGreen := 0;
    peaTermo[iCounter].peBlue := (255 - (iCounter - 204) * 5);
    peaTermo[iCounter].peFlags := 0;
  end;
end.
