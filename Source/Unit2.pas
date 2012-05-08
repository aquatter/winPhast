unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, ShellApi, StrUtils, ExtCtrls, XPMan;

type
  TForm2 = class(TForm)
    ListView1: TListView;
    ComboBoxEx1: TComboBoxEx;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    ListView2: TListView;
    Button4: TButton;
    Label1: TLabel;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Image1: TImage;
    Label2: TLabel;
    Button8: TButton;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ListView1DblClick(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure ComboBoxEx1Click(Sender: TObject);
    procedure ListView2Click(Sender: TObject);
    procedure ListView1Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
  private
    { Private declarations }
    bitmap: TBitmap;
    path: string;
    procedure AddFile;
  public
    { Public declarations }
    FileMask: string;
    destructor Destroy; override;
  end;

function SlashSep(Path, FName: string): string;

var
  Form2: TForm2;

implementation

{$R *.dfm}

procedure TForm2.FormCreate(Sender: TObject);
var SysImageList: uint;
    SFI: TSHFileInfo;
    ld: DWORD;
    i: integer;
    s: string;
    ShInfo: TSHFileInfo;
begin
  ListView1.LargeImages:=TImageList.Create(self);
  ListView1.SmallImages:=TImageList.Create(self);
  ListView2.LargeImages:=TImageList.Create(self);
  ListView2.SmallImages:=TImageList.Create(self);
  ComboBoxEx1.Images:=TImageList.Create(self);

  SysImageList := SHGetFileInfo('', 0, SFI, SizeOf(TSHFileInfo), SHGFI_SYSICONINDEX or SHGFI_LARGEICON);
  if SysImageList <> 0 then
  begin
    ListView1.LargeImages.Handle:=SysImageList;
    ListView1.LargeImages.ShareImages:= true;
    ListView2.LargeImages.Handle:=SysImageList;
    ListView2.LargeImages.ShareImages:= true;
  end;
  SysImageList:= SHGetFileInfo('', 0, SFI, SizeOf(TSHFileInfo),SHGFI_SYSICONINDEX or SHGFI_SMALLICON);
  if SysImageList <> 0 then
  begin
    ListView1.Smallimages.Handle := SysImageList;
    ListView1.Smallimages.ShareImages := TRUE;
    ListView2.Smallimages.Handle := SysImageList;
    ListView2.Smallimages.ShareImages := TRUE;
    ComboBoxEx1.Images.Handle:= SysImageList;
    ComboBoxEx1.Images.ShareImages:=true;
  end;
 path:=ExtractFilePath(Application.ExeName);
 ld := GetLogicalDrives;
  for i := 0 to 25 do
    if (ld and (1 shl i)) <> 0 then
    begin
      s:=Char(Ord('A') + i) + ':\';
      SHGetFileInfo(PChar(s), 0, ShInfo, SizeOf(ShInfo), SHGFI_TYPENAME or SHGFI_SYSICONINDEX);
      with  ComboBoxEx1.ItemsEx.Add do
      begin
        Caption:=s;
        ImageIndex:=ShInfo.iIcon;
      end;
    end;
  ComboBoxEx1.ItemIndex:=ComboBoxEx1.Items.IndexOfName(ExtractFileDrive(Application.ExeName)+'\');
  bitmap:=TBitmap.Create;
  Caption:=path;
end;

procedure TForm2.AddFile;
var
  ShInfo: TSHFileInfo;
  FileName:  string;
  SearchRec: TSearchRec;
begin
  Caption:=path;
  ListView1.Items.BeginUpdate;
  ListView1.Items.Clear;

  //сперва ищу директории
  FindFirst(path+'*.*', faAnyFile, SearchRec);
  try
    repeat
      with SearchRec.FindData do
      if ((FILE_ATTRIBUTE_DIRECTORY and dwFileAttributes) > 0) then
      begin
        if (SearchRec.Name = '.') or (SearchRec.Name = '') then continue;
        FileName:= SlashSep(path, SearchRec.Name);
        SHGetFileInfo(PChar(FileName), 0, ShInfo, SizeOf(ShInfo), SHGFI_TYPENAME or SHGFI_SYSICONINDEX);
        with ListView1.Items.Add do
        begin
          Caption := SearchRec.Name;
          ImageIndex := ShInfo.iIcon;
          SubItems.Add('');
          SubItems.Add(ShInfo.szTypeName);
          SubItems.Add(path + cFileName);
          SubItems.Add('dir')
        end;
      end;
    until (FindNext(SearchRec) <> 0);
  finally
    FindClose(SearchRec);
  end;
  //затем ищу bmp-файлы
  FindFirst(path+'*.*', faAnyFile, SearchRec);
  try
    repeat
      if copy(SearchRec.Name, length(SearchRec.Name)-2, 3) = FileMask then
      with SearchRec.FindData do
      begin
        FileName:= SlashSep(path, SearchRec.Name);
        SHGetFileInfo(PChar(FileName), 0, ShInfo, SizeOf(ShInfo), SHGFI_TYPENAME or SHGFI_SYSICONINDEX);
        with ListView1.Items.Add do
        begin
          //Присваиваю его имя
          Caption := SearchRec.Name;
          //Присваиваю индекс из системного списка изображений
          ImageIndex := ShInfo.iIcon;
          //Присваиваю размер
          SubItems.Add(IntToStr(SearchRec.Size));
          SubItems.Add(ShInfo.szTypeName);
          SubItems.Add(path + cFileName);
          SubItems.Add('file');
        end;
      end;
    until (FindNext(SearchRec) <> 0);
  finally
    FindClose(SearchRec);
  end;
  ListView1.Items.EndUpdate;
end;

function SlashSep(Path, FName: string): string;
begin
  if path <> '' then
    if Path[Length(Path)] <> '\' then
      Result:= Path + '\' + FName
    else
      Result:= Path + FName;
end;


procedure TForm2.FormShow(Sender: TObject);
begin
  AddFile;
end;

procedure TForm2.Button1Click(Sender: TObject);
var i: integer;
begin
  ListView2.Items.BeginUpdate;
  for i:=0 to ListView1.Items.Count-1 do
    if ListView1.Items[i].Selected and (ListView1.Items[i].SubItems[3] = 'file') then
      with ListView2.Items.Add do
      begin
        Caption:=ListView1.Items[i].Caption;
        ImageIndex:=ListView1.Items[i].ImageIndex;
        SubItems.Add(IntToStr(ListView2.Items.Count));
        SubItems.Add(ListView1.Items[i].SubItems[2]);
      end;
  ListView2.Items.EndUpdate;
  ListView1.SetFocus;
end;

procedure TForm2.Button5Click(Sender: TObject);
begin
  ListView2.Items.Clear;
  ListView1.SetFocus;
end;

procedure TForm2.Button4Click(Sender: TObject);
var i, tmp: integer;
begin
  ListView2.Items.BeginUpdate;
  if ListView2.Selected <> nil then
  begin
    tmp:=StrToInt(ListView2.Selected.SubItems[0]);
    ListView2.Selected.Delete;
    for i:=0 to ListView2.Items.Count-1 do
      if StrToInt(ListView2.Items[i].SubItems[0]) > tmp then
        ListView2.Items[i].SubItems[0]:=IntToStr(StrToInt(ListView2.Items[i].SubItems[0])-1);
  end;
  ListView2.Items.EndUpdate;
end;

procedure TForm2.Button3Click(Sender: TObject);
var tmp: string;
begin
  ListView2.Items.BeginUpdate;
  if ListView2.Selected <> nil then
    if ListView2.Selected.Index <> 0 then
    begin
      tmp:=ListView2.Selected.Caption;
      ListView2.Selected.Caption:=ListView2.Items[ListView2.Selected.index-1].Caption;
      ListView2.Items[ListView2.Selected.index-1].Caption:=tmp;
      tmp:=ListView2.Selected.SubItems[0];
{      ListView2.Selected.SubItems[0]:=ListView2.Items[ListView2.Selected.index-1].SubItems[0];
      ListView2.Items[ListView2.Selected.index-1].SubItems[0]:=tmp;}
      tmp:=ListView2.Selected.SubItems[1];
      ListView2.Selected.SubItems[1]:=ListView2.Items[ListView2.Selected.index-1].SubItems[1];
      ListView2.Items[ListView2.Selected.index-1].SubItems[1]:=tmp;
      ListView2.ItemIndex:= ListView2.Selected.Index-1;
      ListView2.SetFocus;
    end;
  ListView2.Items.EndUpdate;
end;

procedure TForm2.Button2Click(Sender: TObject);
var tmp: string;
begin
  ListView2.Items.BeginUpdate;
  if ListView2.Selected <> nil then
    if ListView2.Selected.Index <> (ListView2.Items.Count-1) then
    begin
      tmp:=ListView2.Selected.Caption;
      ListView2.Selected.Caption:=ListView2.Items[ListView2.Selected.index+1].Caption;
      ListView2.Items[ListView2.Selected.index+1].Caption:=tmp;
      tmp:=ListView2.Selected.SubItems[0];
{      ListView2.Selected.SubItems[0]:=ListView2.Items[ListView2.Selected.index+1].SubItems[0];
      ListView2.Items[ListView2.Selected.index+1].SubItems[0]:=tmp;}
      tmp:=ListView2.Selected.SubItems[1];
      ListView2.Selected.SubItems[1]:=ListView2.Items[ListView2.Selected.index+1].SubItems[1];
      ListView2.Items[ListView2.Selected.index+1].SubItems[1]:=tmp;
      ListView2.ItemIndex:= ListView2.Selected.Index+1;
      ListView2.SetFocus;
    end;
  ListView2.Items.EndUpdate;
end;

procedure TForm2.ListView1DblClick(Sender: TObject);
begin
  if ListView1.Selected <> nil then
    if ListView1.Selected.SubItems[3] = 'dir' then
    begin
      if ListView1.Selected.Caption = '..' then
      repeat
        Delete(path, length(path), 1);
      until path[Length(path)] = '\'
      else
        path:=path + ListView1.Selected.Caption + '\';
      AddFile;
      Caption:=path;
    end;
end;

procedure TForm2.Button7Click(Sender: TObject);
begin
  Form2.Close;
end;

procedure TForm2.ComboBoxEx1Click(Sender: TObject);
begin
  if ComboBoxEx1.ItemIndex >= 0 then
  begin
    path:=ComboBoxEx1.Items[ComboBoxEx1.ItemIndex];
    AddFile;
    Caption:=path;
  end;
end;

destructor TForm2.Destroy;
begin
  bitmap.Free;
  inherited Destroy;
end;

procedure TForm2.ListView2Click(Sender: TObject);
begin
  if ListView2.Selected <> nil then
  begin
    bitmap.LoadFromFile(ListView2.Selected.SubItems[1]);
    Label2.Caption:='Размер: '+IntToStr(bitmap.Height)+' x '+intToStr(bitmap.Width);
    Image1.Canvas.StretchDraw(Rect(0,0,Image1.Width, Image1.Height), bitmap);
    bitmap.FreeImage;
  end;
end;

procedure TForm2.ListView1Click(Sender: TObject);
begin
  if (ListView1.Selected <> nil) and (ListView1.Selected.SubItems[3] = 'file') then
  begin
    bitmap.LoadFromFile(ListView1.Selected.SubItems[2]);
    Label2.Caption:='Размер: '+IntToStr(bitmap.Height)+' x '+intToStr(bitmap.Width);
    Image1.Canvas.StretchDraw(Rect(0,0,Image1.Width, Image1.Height), bitmap);
    bitmap.FreeImage;
  end;
end;

procedure TForm2.Button8Click(Sender: TObject);
begin
  ListView1.SelectAll;
  ListView1.SetFocus;
end;

end.
