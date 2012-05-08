unit ULoadSeqForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ImgList, ComCtrls, ToolWin, ExtCtrls, StdCtrls;

type
  TLoadSeqForm = class(TForm)
    Label12: TLabel;
    Edit1: TEdit;
    Label4: TLabel;
    Edit4: TEdit;
    Label15: TLabel;
    Edit2: TEdit;
    Button1: TButton;
    Button2: TButton;
    Bevel1: TBevel;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ToolButton1: TToolButton;
    ImageList1: TImageList;
    procedure Button1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  LoadSeqForm: TLoadSeqForm;

implementation

uses unit1, crude, UPhast2Vars;
{$R *.dfm}

procedure TLoadSeqForm.Button1Click(Sender: TObject);
begin
  with cfg do
  begin
    img_path:=Edit1.Text;
    steps:=StrToInt(Edit2.Text);
    num_seq:=StrToInt(Edit4.Text);
    do_seq:=true;
    from:=fromCamera;
    form1.InitialiseArrays;
  end;
end;

procedure TLoadSeqForm.ToolButton1Click(Sender: TObject);
var dir: string;
begin
  dir:=cfg.img_path;
  if  AdvSelectDirectory('Выберите директорию загрузки интерферограмм', '', dir, false, false, True) then
    Edit1.Text:=dir;
end;

end.
