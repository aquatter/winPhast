unit ULoadSeqLunkaForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, ToolWin, ExtCtrls, StdCtrls;

type
  TLoadSeqLunkaForm = class(TForm)
    Label12: TLabel;
    Label4: TLabel;
    Label15: TLabel;
    Bevel1: TBevel;
    Edit1: TEdit;
    Edit4: TEdit;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ImageList1: TImageList;
    Edit3: TEdit;
    Panel2: TPanel;
    ToolBar2: TToolBar;
    ToolButton2: TToolButton;
    Label1: TLabel;
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoadSeqLunkaForm: TLoadSeqLunkaForm;

implementation

{$R *.dfm}
uses unit1, crude, UPhast2Vars;

procedure TLoadSeqLunkaForm.ToolButton1Click(Sender: TObject);
var dir: string;
begin
  dir:=cfg.img_path;
  if  AdvSelectDirectory('Выберите директорию загрузки интерферограмм', '', dir, false, false, True) then
    Edit1.Text:=dir;
end;

procedure TLoadSeqLunkaForm.ToolButton2Click(Sender: TObject);
var dir: string;
begin
  dir:=cfg.img_path_izm;
  if  AdvSelectDirectory('Выберите директорию загрузки интерферограмм', '', dir, false, false, True) then
    Edit3.Text:=dir;
end;

end.
