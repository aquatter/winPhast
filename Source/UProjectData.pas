unit UProjectData;

interface

uses
  Generics.Collections, utype;

type
  TProjectType = (ptPhaseShift, ptFizo, ptDynamic);
  TCalculationList = (calcPhase, calcUnwrap, calcAmp, calcMean_Unwrap, calcPhase2, calcAmp2, calcEverythingElse);
  TActiveMask = (amNone, amMask1, amMask2, amCombined);

  TProjectProp = record
    type_: TProjectType;
    how_many_wavelengths: integer;
    WaveLength: treal;
    WaveLength2: treal;
    w,h: integer;
    file_name, file_path: AnsiString;
    project_name: string;
    doTilt, doMean, doUnwrap, doBase, doNm: boolean;
  end;

  PRec = ^TRec;
  TRec = class
    img, img2: TList<AnsiString>;
    phase, unwrap, amp, phase2, amp2: AnsiString;
    phase_calculated: boolean;
    unwrap_calculated: boolean;
    what_to_calc: array of TCalculationList;

    procedure Add2Calculation(item: TCalculationList);
    procedure ClearCalculation;
    constructor Create;
    destructor Destroy; override;
  end;

  PSeq = ^TSeq;
  TSeq = class
    mean_unwrap: AnsiString;
    mean_calculated: boolean;
    rec_: TObjectList<TRec>;
    doMean: boolean;

    function GetItem(Index: Integer): TRec;
    property Items[Index: Integer]: TRec read GetItem; default;
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
    changed: boolean;


    mask1, mask2: AnsiString;
    active: TActiveMask;

    function GetItem(Index: Integer): TSeq;
    property Items[Index: Integer]: TSeq read GetItem; default;

    function Add(): TSeq;
    function Get(i: integer): TSeq;
    function Count(): integer;
    procedure ClearCalculation;
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

function TProjectData.GetItem(Index: Integer): TSeq;
begin
  Result:= seq_[Index];
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

procedure TProjectData.ClearCalculation;
var i, j: integer;
begin

  for i:=0 to seq_.Count-1 do
    for j:=0 to seq_[i].Count-1 do
      seq_[i].Get(j).ClearCalculation;

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
  img2:=TList<AnsiString>.Create;
end;

destructor TRec.Destroy;
begin
  img.Clear;
  img.Free;
  img2.Clear;
  img2.Free;
  Finalize(what_to_calc);
  inherited;
end;

function TSeq.GetItem(Index: Integer): TRec;
begin
  Result:= rec_[Index];
end;

procedure TRec.Add2Calculation(item: TCalculationList);
var n: integer;
begin
  n:= Length(what_to_calc);
  SetLength(what_to_calc, n+1);
  what_to_calc[n]:= item;
end;

procedure TRec.ClearCalculation;
begin
  Finalize(what_to_calc);
end;

end.
