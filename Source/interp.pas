unit interp;

interface

uses utype, crude, Classes, t666, windows;

type
  TInterpMode = (imDDA, imBrezenhem, imBilinInterp);
  TInterp = class(TObject)
  private
    FInterpMode: TInterpMode;
    Trace_Map: TMyInfernalType;
    count: integer;
    Input_array: PMyInfernalType;
  public
    {Line1, Line2: PRealArray;
    l1, l2: Integer;}
    Line: TList;
    procedure Run;
    constructor Create(var _Trace_Map: TMyInfernalType; _Input_array: PMyInfernalType);
    destructor Destroy; override;
  published
    property InterpMode: TInterpMode read FInterpMode write FInterpMode;
  end;



implementation

{ TInterp }

constructor TInterp.Create(var _Trace_Map: TMyInfernalType; _Input_array: PMyInfernalType);
begin
  inherited Create;
  Trace_Map:=TMyInfernalType.Create;
  CopyT666(_Trace_Map, Trace_Map);
  count:=Trace_Map.w div 2;
  Input_array:=_Input_array;
  FInterpMode:=imBilinInterp;
  Line:=TList.Create;
end;

destructor TInterp.Destroy;
var i: integer;
begin
  Trace_Map.Destroy;
  for i:=0 to Line.Count-1 do
  begin
    PMyInfernalType(Line.Items[i])^.Destroy;
    FreeMem(PMyInfernalType(Line.Items[i]), sizeof(TMyInfernalType));
  end;
  Line.Destroy;
  inherited Destroy;
end;

procedure TInterp.Run;
var i, len: integer;
    trace: PRealArray;
    temp: PMyInfernalType;
begin
  case FInterpMode of
    imBilinInterp:  for i:=0 to count-1 do
                    begin
                      BilinInterp(Input_array^, trace, len,
                      Trace_Map.d^[2*i].x, Trace_Map.d^[2*i].y, Trace_Map.d^[2*i+1].x, Trace_Map.d^[2*i+1].y);
                      GetMem(temp, sizeof(TMyInfernalType));
                      temp^:=TMyInfernalType.Create;
                      temp^.Init(1, len, varDouble);
                      CopyMemory(temp^.a, trace, len*sizeof(treal));
                      FreeMem(trace, len*sizeof(treal));
                      Line.Add(temp);
                    end;
  end;
end;

end.
 