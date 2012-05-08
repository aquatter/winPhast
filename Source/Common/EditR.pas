unit EditR;

interface

uses
  Windows, Messages, SysUtils, Classes, Controls, StdCtrls;

type
  TEditR = class(TEdit)
  private
    { Private declarations }
  protected
    { Protected declarations }
  public
    { Public declarations }
    procedure CreateParams(var Params: TCreateParams); Override;
    procedure KeyPress(var Key: Char); override;

  published
    { Published declarations }
  end;

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('Samples', [TEditR]);
end;

{ TEditR }

procedure TEditR.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
  Params.Style := Params.Style or ES_RIGHT;
end;

procedure TEditR.KeyPress(var Key: Char);
begin
  inherited KeyPress(Key);
  case key of
    '0'..'9': ;
    #8: ;
    '.', ',':
      if Pos(DecimalSeparator, Text) = 0 then
        Key := DecimalSeparator
      else
        Key := #0;
    else
      key := #0;
  end;

end;

end.
