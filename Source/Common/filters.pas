unit Filters;

interface

uses Crude, Utype;

type
  TTypeFilter = (ffMed, ffExtreme, ffRang, ffBinar);
  TFilter = class
  private
    mask: TBoolArray;
    int: TIntArray;
    width, height: word;
    procedure Extreme;
    procedure Med;
    procedure Rang;
    procedure Binar;
  public
    Relatively{, Absolutely}: boolean;
    MedOrder, RangOrder, ExtremeOrder, border: word;
    threshold: real;
    procedure GetTRealArray(var t: TRealArray);
    procedure GetTByteArray(var t: PBtArr);
    procedure GetBoolMask(var b: TBoolArray; invert: boolean);
    procedure GetTRealMask(var t: TRealArray);
    procedure GetTbtMask(var t: TbtArr; invert: boolean);
    procedure RefreshMask;
    procedure Processing(param: array of TTypeFilter);
    Procedure Init(var p: TRealArray); overload;
    Procedure Init(var p: TBtArr); overload;
    constructor Create(h, w: word{; t: real = 0});
    destructor Destroy; override;
  end;

implementation
{ TFilter }

procedure TFilter.Binar;
var i,j: word;
    min, max, tmp: integer;
begin
  if Relatively then
  begin
    FindMin_Max(min,max,int);
    tmp:=min+round((max-min)*threshold);
  end
  else
     tmp:=round(threshold);

  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if int[i,j] > tmp then
        int[i,j]:=1
      else
        int[i,j]:=0;
end;


constructor TFilter.Create(h, w: word{; t: real = 0});
begin
  width:=w;
  height:=h;
  threshold:=0.5;
  SetLength(int, height, width);
 // SetLength(mask, height, width);
  border:=0;
  Relatively:=true;
  MedOrder:=5;
  RangOrder:=3;
  ExtremeOrder:=7;
end;

destructor TFilter.Destroy;
begin
  Finalize(int);
//  Finalize(mask);
  inherited Destroy;
end;

procedure TFilter.Extreme;
var i, j, min, max, i_max, i_min, ind:  integer;
    hist: array of byte;
    k1, k2, low, high: Shortint;
    temp: TIntArray;

begin
  low:=round((ExtremeOrder-1)/2);
  high:=round((ExtremeOrder+1)/2);
  SetLength(temp, height, width);
  FindMin_Max(min, max, int);

  for i:=low to height - high do
    for j:=low to width - high do
    begin
      if j = low then
      begin
        SetLength(hist,max+1);
        for k1:=-low to low do
          for k2:=-low to low do
            inc(hist[int[i+k1,j+k2]])
      end
      else
        for k1:=-low to low do
        begin
          dec(hist[int[i+k1,j-low-1]]);
          inc(hist[int[i+k1,j+low]]);
        end;
      ind:=max;
      while hist[ind] = 0 do
        dec(ind);
      i_max:=ind;
      ind:=0;
      while hist[ind] = 0 do
        inc(ind);
      i_min:=ind;
      if (i_max-int[i,j]) > (int[i,j]-i_min) then
        temp[i,j]:=i_min
      else
        temp[i,j]:=i_max;

      if j = width-high then
        Finalize(hist);
    end;

  Finalize(int);
  int:=temp;
end;


procedure TFilter.GetBoolMask(var b: TBoolArray; invert: boolean);
var i,j: word;
begin
  for i := 0 to Length(b)-1 do
    for j := 0 to Length(b[0])-1 do
      if (int[i,j]=1) and (i > border-1) and (i < height-border-1)
      and (j > border-1) and (j < width-border-1) then
        b[i,j]:=true xor invert
      else
        b[i,j]:=false xor invert;
end;

procedure TFilter.GetTbtMask(var t: TbtArr; invert: boolean);
var i,j: word;
begin
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if (int[i,j]=1) and (i > border-1) and (i < height-border-1)
      and (j > border-1) and (j < width-border-1) then
        t[i*width+j]:=byte(true xor invert)
      else
        t[i*width+j]:=byte(false xor invert);
end;

procedure TFilter.GetTByteArray(var t: PBtArr);
var i,j: word;
begin
    for i:=0 to height-1 do
      for j:=0 to width-1 do
        t^[i*width+j]:=int[i,j];
end;

procedure TFilter.GetTRealArray(var t: TRealArray);
var i,j: word;
begin
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      t[i*width+j]:=int[i,j];
end;

procedure TFilter.GetTRealMask(var t: TRealArray);
var i,j: word;
begin
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      if mask[i,j] then
        t[i*width+j]:=1
      else
        t[i*width+j]:=0;
end;

procedure TFilter.Init(var p: TRealArray);
var i,j: word;
begin
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      int[i,j]:=round(p[i*width+j]);
end;

procedure TFilter.Init(var p: TBtArr);
var i,j: word;
begin
  for i:=0 to height-1 do
    for j:=0 to width-1 do
      int[i,j]:=p[i*width+j];
end;

procedure TFilter.Med;
var i, j, min, max, ind, len, tmp:  integer;
    hist: array of byte;
    k1, k2, low, high: Shortint;
    temp: TIntArray;

begin
  low:=round((MedOrder-1)/2);
  high:=round((MedOrder+1)/2);
  SetLength(temp, height, width);
  FindMin_Max(min, max, int);
  len:=round((sqr(MedOrder)-1)/2);

  for i:=low to height - high do
    for j:=low to width - high do
    begin
      if j = low then
      begin
        SetLength(hist,max+1);
        for k1:=-low to low do
          for k2:=-low to low do
            inc(hist[int[i+k1,j+k2]])
      end
      else
        for k1:=-low to low do
        begin
          dec(hist[int[i+k1,j-low-1]]);
          inc(hist[int[i+k1,j+low]]);
        end;

       tmp:=0;
       ind:=0;
       while tmp <= len do
       begin
         inc(tmp,hist[ind]);
         inc(ind);
       end;

       temp[i,j]:=ind-1;

      if j = width-high then
        Finalize(hist);
    end;

  Finalize(int);
  int:=temp;
end;


procedure TFilter.Processing(param: array of TTypeFilter);
var i: byte;
begin
  for i:=0 to length(param)-1 do
  begin
    case param[i] of
      ffMed: Med;
      ffRang: Rang;
      ffExtreme: Extreme;
      ffBinar: Binar;
    end;
  end;
  {if MedEnabled then Med;
  if ExtremeEnabled then Extreme;
  if RangEnabled then Rang;
  if BinarEnabled then Binar;}
end;

procedure TFilter.Rang;
var i, j, min, max, i_max, i_min, ind:  integer;
    hist: array of byte;
    k1, k2, low, high: Shortint;
    temp: TIntArray;

begin
  low:=round((RangOrder-1)/2);
  high:=round((RangOrder+1)/2);
  SetLength(temp, height, width);
  FindMin_Max(min, max, int);

  for i:=low to height - high do
    for j:=low to width - high do
    begin
      if j = low then
      begin
        SetLength(hist,max+1);
        for k1:=-low to low do
          for k2:=-low to low do
            inc(hist[int[i+k1,j+k2]])
      end
      else
        for k1:=-low to low do
        begin
          dec(hist[int[i+k1,j-low-1]]);
          inc(hist[int[i+k1,j+low]]);
        end;
      ind:=max;
      while hist[ind] = 0 do
        dec(ind);
      i_max:=ind;
      ind:=0;
      while hist[ind] = 0 do
        inc(ind);
      i_min:=ind;

      temp[i,j]:=i_max-i_min;

      if j = width-high then
        Finalize(hist);
    end;

  Finalize(int);
  int:=temp;
end;

procedure TFilter.RefreshMask;
begin
  Finalize(mask);
  SetLength(mask, height, width);
end;

end.
