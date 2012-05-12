unit UProjectData;

interface

uses
  Generics.Collections, utype;

type
  TProjectProp = record
    type_: (ptPhaseShift, ptFizo, ptDynamic);
    WaveLength: treal;
    w,h: integer;
    file_name, file_path: AnsiString;
  end;

  PRec = ^TRec;
  TRec = class
    img: TList<AnsiString>;
    phase, unwrap: AnsiString;

    constructor Create;
    destructor Destroy; override;
  end;

  PSeq = ^TSeq;
  TSeq = class

    rec_: TObjectList<TRec>;

    function Add(): TRec;
    function Get(i: integer): TRec;
    function Count(): integer;
    procedure Clear;
    constructor Create;
    destructor Destroy; override;
  end;

  TProjectData = class
  public

    prop_: TProjectProp;
    seq_: TObjectList<TSeq>;


    function Add(): TSeq;
    function Get(i: integer): TSeq;
    function Count(): integer;
    procedure Clear;
    constructor Create;
    destructor Destroy; override;
  end;


implementation

constructor TProjectData.Create;
begin
  seq_:=TObjectList<TSeq>.Create;

end;

destructor TProjectData.Destroy;
begin
  seq_.Clear;
  seq_.Free;
  inherited;
end;

function TProjectData.Add(): TSeq;
var p: PSeq;
begin
  seq_.Add(TSeq.Create);
  Result:= (seq_.Last);
end;

function TProjectData.Get(i: integer): TSeq;
begin
  Result:= seq_[i];
end;

procedure TProjectData.Clear;
begin
  seq_.Clear;
end;

function TProjectData.Count():integer;
begin
  Result:= seq_.Count;
end;

{ TSeq }

constructor TSeq.Create;
begin
  rec_:=TObjectList<TRec>.Create;
end;

destructor TSeq.Destroy;
begin
  rec_.Clear;
  rec_.Free;
  inherited;
end;

function TSeq.Add(): TRec;
begin
  rec_.Add(TRec.Create);
  Result:= (rec_.Last);
end;

function TSeq.Get(i: integer): TRec;
begin
  Result:=rec_[i];
end;

procedure TSeq.Clear;
begin
  rec_.Clear;
end;

function TSeq.Count: integer;
begin
  Result:= rec_.Count;
end;

{ TRec }

constructor TRec.Create;
begin
  img:=TList<AnsiString>.Create;
end;

destructor TRec.Destroy;
begin
  img.Clear;
  img.Free;

  inherited;
end;

end.