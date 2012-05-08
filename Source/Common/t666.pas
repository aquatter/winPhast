unit t666;

interface

uses utype, dialogs, windows;

type
  PMyInfernalType = ^TMyInfernalType;
  TMyInfernalTypeArray = array of PMyInfernalType;
  TMyInfernalType = class
  private
  public
    a: PRealArray;
    b: PBtArr;
    c: PIntegerArray;
    d: PPointArray;
    w, h: integer; //размер массива
    x_img, y_img, w_img, h_img: integer; //размер и смещение изображаемой части
    x_hist, y_hist, w_hist, h_hist: integer; //размер и смещение области расчета гистограммы
    loaded: boolean;
    _type: TVarType;
    output: pointer;
    ColorScale: (byArea_hist, byMinMax_hist, noScale);
    min_hist, max_hist: Treal;
    procedure Add1D(dim: integer = 1);
    function Get(i,j: integer): variant;
    procedure Put(i,j: integer; value: variant);
    procedure Init(height, width: integer; _type_: TVarType; const Fill: treal = 0);
    procedure InitByArray(p: TMyInfernalType);
    procedure Clear;
    constructor Create;
    destructor Destroy; override;
  end;

implementation

procedure TMyInfernalType.Init(height, width: integer; _type_: TVarType; const Fill: treal);
var i,j: integer;
begin
  if not loaded then
  begin
    h:=height;
    w:=width;
    x_img:=0;
    y_img:=0;
    w_img:=w;
    h_img:=h;
    x_hist:=0;
    y_hist:=0;
    w_hist:=w;
    h_hist:=h;
    ColorScale:=byArea_hist;
    case _type_ of
      varDouble:
      begin
        GetMem(a, h*w*sizeof(treal));
        for i:=0 to h-1 do
          for j:=0 to w-1 do
            a^[i*w+j]:=Fill;
      end;
      varByte:
      begin
        GetMem(b, h*w*sizeof(tbt));
        for i:=0 to h-1 do
          for j:=0 to w-1 do
            b^[i*w+j]:=byte(round(Fill));
      end;
      varInteger:
      begin
        GetMem(c, h*w*sizeof(integer));
        for i:=0 to h-1 do
          for j:=0 to w-1 do
            c^[i*w+j]:=round(Fill);
      end;
      varArray:
      begin
        GetMem(d, h*w*sizeof(tpoint));
        for i:=0 to h-1 do
          for j:=0 to w-1 do
          begin
            d^[i*w+j].x:=round(Fill);
            d^[i*w+j].y:=round(Fill);
          end;
      end;
    end;
    _type:=_type_;
    loaded:=true;
  end{
  else
    ShowMessage('Already loaded');}
end;

function TMyInfernalType.Get(i, j: integer): variant;
begin
  if (i<=h) and (i>=0) and (j>=0) and (j<=w) then
    case _type of
      varDouble: Result:= a^[i*w+j];
      varByte: Result:= b^[i*w+j];
      varInteger: Result:= c^[i*w+j];
    end
  else
    ShowMessage('Index out of bounds');
end;

procedure TMyInfernalType.Put(i, j: integer; value: variant);
begin
  if (i<=h) and (i>=0) and (j>=0) and (j<=w) then
    case _type of
      varDouble: a^[i*w+j]:=value;
      varByte: b^[i*w+j]:=value;
      varInteger: c^[i*w+j]:=value;
    end
  else
    ShowMessage('Index out of bounds');
end;

procedure TMyInfernalType.Clear;
begin
  if loaded then
  begin
    case _type of
      varDouble: FreeMem(a, h*w*sizeof(treal));
      varByte: FreeMem(b, h*w*sizeof(tbt));
      varInteger: FreeMem(c, h*w*sizeof(integer));
      varArray: FreeMem(d, h*w*sizeof(tpoint));
    end;
    loaded:=false;
    w:=0;
    h:=0;
    w_img:=0;
    h_img:=0;
  end;{
  else
    ShowMessage('Not loaded');}
end;

constructor TMyInfernalType.Create;
begin
  loaded:=false;
end;

destructor TMyInfernalType.Destroy;
begin
  Clear;
  inherited Destroy;
end;

procedure TMyInfernalType.Add1D(dim: integer = 1);
var tmp_byte: PBtArr;
    tmp_Treal: PRealArray;
    tmp_Int: PIntegerArray;
//    i,j: integer;
begin
  if not loaded then
  begin
    ShowMessage('Not loaded');
    exit;
  end;
  case _type of
    varByte: begin
               GetMem(tmp_byte, w*sizeof(tbt));
               CopyMemory(tmp_byte, b, w*sizeof(tbt));
               FreeMem(b, w*sizeof(tbt));
               inc(w);
               GetMem(b, w*sizeof(tbt));
               CopyMemory(b, tmp_byte,(w-1)*sizeof(tbt));
               FreeMem(tmp_byte, (w-1)*sizeof(tbt));
             end;
    varDouble: begin
                 GetMem(tmp_Treal, w*sizeof(treal));
                 CopyMemory(tmp_Treal, a, w*sizeof(treal));
                 FreeMem(a, w*sizeof(treal));
                 inc(w);
                 GetMem(a, w*sizeof(treal));
                 CopyMemory(a, tmp_Treal,(w-1)*sizeof(treal));
                 FreeMem(tmp_Treal, (w-1)*sizeof(treal));
               end;
    varInteger: begin
                  GetMem(tmp_Int, w*sizeof(integer));
                  CopyMemory(tmp_Int, c, w*sizeof(integer));
                  FreeMem(c, w*sizeof(integer));
                  inc(w);
                  GetMem(c, w*sizeof(integer));
                  CopyMemory(c, tmp_Int,(w-1)*sizeof(integer));
                  FreeMem(tmp_Int, (w-1)*sizeof(integer));
                end;
  end;
  {case dim of
    1: case _type of
         varByte: begin
                    GetMem(tmp_byte, w*h*sizeof(tbt));
                    CopyMemory(b, tmp_byte, w*h*sizeof(tbt));
                    FreeMem(b, w*h*sizeof(tbt));
                    inc(w);
                    GetMem(b, w*h*sizeof(tbt));
                    if h=1 then
                      CopyMemory(b, tmp_byte,(w-1)*h*sizeof(tbt))
                    else
                      for i:=0 to h-1 do
                        for j:=0 to w-2 do
                          b^[i*w+j]:=tmp_byte^[i*(w-1)+j];
                    FreeMem(tmp_byte, (w-1)*h*sizeof(tbt));
                  end;
         varDouble: begin
                      GetMem(tmp_Treal, w*h*sizeof(treal));
                      CopyMemory(a, tmp_Treal, w*h*sizeof(treal));
                      FreeMem(a, w*h*sizeof(treal));
                      inc(w);
                      GetMem(a, w*h*sizeof(treal));
                      if h=1 then
                        CopyMemory(a, tmp_Treal,(w-1)*h*sizeof(treal))
                      else
                        for i:=0 to h-1 do
                          for j:=0 to w-2 do
                            a^[i*w+j]:=tmp_treal^[i*(w-1)+j];
                      FreeMem(tmp_Treal, (w-1)*h*sizeof(treal));
                    end;
       end;
    2: case _type of
         varByte: begin
                    GetMem(tmp_byte, w*h*sizeof(tbt));
                    CopyMemory(b, tmp_byte, w*h*sizeof(tbt));
                    FreeMem(b, w*h*sizeof(tbt));
                    inc(h);
                    GetMem(b, w*h*sizeof(tbt));
                    CopyMemory(b, tmp_byte,w*(h-1)*sizeof(tbt));
                    FreeMem(tmp_byte, w*(h-1)*sizeof(tbt));
                  end;
         varDouble: begin
                      GetMem(tmp_Treal, w*h*sizeof(treal));
                      CopyMemory(a, tmp_Treal, w*h*sizeof(treal));
                      FreeMem(a, w*h*sizeof(treal));
                      inc(h);
                      GetMem(a, w*h*sizeof(treal));
                      CopyMemory(a, tmp_Treal, w*(h-1)*sizeof(treal));
                      FreeMem(tmp_Treal, w*(h-1)*sizeof(treal));
                    end;
       end;
  end;  }

end;

procedure TMyInfernalType.InitByArray(p: TMyInfernalType);
begin
    Clear;
  _type:=p._type;
  h:=p.h;
  w:=p.w;
  x_img:=p.x_img;
  y_img:=p.y_img;
  w_img:=p.w_img;
  h_img:=p.h_img;
  x_hist:=p.x_hist;
  y_hist:=p.y_hist;
  w_hist:=p.w_hist;
  h_hist:=p.h_hist;
  ColorScale:=p.ColorScale;
  case _type of
    varDouble: begin
                 GetMem(a, h*w*sizeof(treal));
                 CopyMemory(a, p.a, w*h*sizeof(treal));
               end;
    varByte:  begin
                GetMem(b, h*w*sizeof(tbt));
                CopyMemory(b, p.b, w*h*sizeof(tbt));
              end;
    varInteger: begin
                  GetMem(c, h*w*sizeof(integer));
                  CopyMemory(c, p.c, w*h*sizeof(integer));
                end;
    varArray: begin
                GetMem(d, h*w*sizeof(tpoint));
                CopyMemory(d, p.d, w*h*sizeof(tpoint));
              end;
  end;
  loaded:=true;
end;

end.
