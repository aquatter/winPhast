unit UTwoWaveLengthClass;

interface

uses
  Classes, utype, windows, UPhast2Vars;

type
  TTwoWaveLengthClass = class
  private
  protected
  public
    int_list: TStringList;
    opt: TConfig;
    constructor Create;
    destructor Destroy; override;
  end;



var izm1: TTwoWaveLengthClass;
    izm2: TTwoWaveLengthClass;


implementation

{ TTwoWaveLengthClass }

constructor TTwoWaveLengthClass.Create;
begin
  int_list:=TStringList.Create;

end;


destructor TTwoWaveLengthClass.Destroy;
begin
  int_list.Clear;
  int_list.Destroy;
  inherited;
end;

initialization
  izm1:=TTwoWaveLengthClass.Create;
  izm2:=TTwoWaveLengthClass.Create;

finalization
  izm1.Destroy;
  izm2.Destroy;


end.
