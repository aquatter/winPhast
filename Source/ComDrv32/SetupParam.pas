unit SetupParam;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls;

type
  TfrmSetupParam = class(TForm)
    Label2: TLabel;
    cmbPort: TComboBox;
    Label1: TLabel;
    cmbSpeed: TComboBox;
    Bevel2: TBevel;
    btnOk: TButton;
    btnCancel: TButton;
    Bevel1: TBevel;
    Bevel3: TBevel;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSetupParam: TfrmSetupParam;

{===============}
Implementation
{===============}

{$R *.dfm}

end.

