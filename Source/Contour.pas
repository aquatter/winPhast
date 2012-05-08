unit Contour;

interface

uses Crude, math, t666, utype;

type
  TContour = class
  private
    obl_map, obl_ind, gravity, meandist: TIntArray;
    area, obl: TInt;
    procedure FindObl(var input: TBoolArray);
    procedure FindWeights;
    procedure MeanDistance(x0,y0: integer);
  public
    nearest: boolean;
    threshold: integer;
    procedure CreateMaskByDistance(var b: TBoolArray; x,y: word); overload;
    procedure CreateMaskByDistance(var b: TMyInfernalType; x,y: word); overload;
    procedure CreateMaskByMeanDistance(var b: TBoolArray; x0,y0: word);
    procedure CreateMaskByMeanDistanceInRing(var b: TBoolArray; x0, y0, rmin, rmax: word);
    procedure CreateMaskByWeights(var b: TBoolArray); overload;
    procedure CreateMaskByWeights(var b: TMyInfernalType); overload;
    procedure Processing(var b: TBoolArray); overload;
    procedure Processing(var p: TMyInfernalType); overload;
    procedure Test(var x, y, r, rms, _mask: TMyInfernalType; w, h: integer); overload;
    procedure Test(var lc: TCircleCoordArray;  var rms: TDouble1DArray; w, h: integer); overload;
    constructor Create(height, width: word);
    destructor Destroy; override;
  end;

implementation
{ TContour }

constructor TContour.Create(height, width: word);
begin
  SetLength(obl_map, height, width);
  SetLength(gravity, 3);
  SetLength(meandist,2);
  nearest:=true;
  threshold:=1000;
{  FindWeights(1000);
  CreateMaskByWeights(b, length(b[0]) div 2, length(b) div 2);}

end;

procedure TContour.FindWeights;
var i, k, m, ind_i, ind_j, temp: integer;
begin
  for k:=0 to length(area)-1 do
    if area[k] > threshold then
    begin
      temp:=length(gravity[0]);
      SetLength(gravity[0], temp+1);
      SetLength(gravity[1], temp+1);
      SetLength(gravity[2], temp+1);
      gravity[0,temp]:=k+1;
      ind_i:=0;
      ind_j:=0;
      for m:=0 to length(obl)-1 do
        if obl[m] = k+1 then
          for i:=0 to length(obl_ind[2*m])-1 do
          begin
            ind_i:=ind_i+obl_ind[2*m,i];
            ind_j:=ind_j+obl_ind[2*m+1,i];
          end;
      gravity[1,temp]:=round(ind_i/area[k]);
      gravity[2,temp]:=round(ind_j/area[k]);
    end;
end;

destructor TContour.Destroy;
begin
  Finalize(obl_map);
  Finalize(obl_ind);
  Finalize(area);
  Finalize(obl);
  Finalize(gravity);
  Finalize(meandist);
  inherited Destroy;
end;

procedure TContour.FindObl(var input: TBoolArray);
var i, j, k, l, num_obl, D1, D2, tmp, minx, miny, maxx, maxy: integer;
    prow, pcol: boolean;

procedure AddSymbol(m,n,D: integer);
var temp: integer;
begin
  obl_map[m,n]:=D;
  inc(area[D-1]);
  temp:=length(obl_ind[2*(D-1)]);
  SetLength(obl_ind[2*(D-1)], temp+1);
  SetLength(obl_ind[2*D-1], temp+1);
  obl_ind[2*(D-1),temp]:=m;
  obl_ind[2*D-1,temp]:=n;
end;

begin
  AreaBounds(input, minx, miny, maxx, maxy);
  num_obl:=0;
  D1:=0;
  D2:=0;
  for i:=miny to maxy do
  for j:=minx to maxx do
  if input[i,j] then
  begin
    if i=0 then
      prow:=false
    else
    begin
      prow:=input[i-1,j];
      D1:=obl_map[i-1,j];
    end;
    if j=0 then
      pcol:=false
    else
    begin
      pcol:=input[i,j-1];
      D2:=obl_map[i,j-1];
    end;
    if pcol then
      if prow then
        if D1=D2 then
          AddSymbol(i,j,D2)
        else
        begin
          if area[D1-1] < area[D2-1] then
          begin
           tmp:=D1;
           D1:=D2;
           D2:=tmp;
          end;
          AddSymbol(i,j,D1);
          inc(area[D1-1],area[D2-1]);
          area[D2-1]:=0;
          for l:=0 to length(obl)-1 do
            if obl[l] = D2 then
            begin
              obl[l]:=D1;
              for k:=0 to length(obl_ind[2*l])-1 do
              obl_map[obl_ind[2*l,k],obl_ind[2*l+1,k]]:=D1;
            end;
        end
      else
        AddSymbol(i,j,D2)
    else
      if prow then
        AddSymbol(i,j, D1)
      else
      begin
        inc(num_obl);
        SetLength(area, num_obl);
        area[num_obl-1]:=1;
        SetLength(obl, num_obl);
        obl[num_obl-1]:=num_obl;
        obl_map[i,j]:=num_obl;
        SetLength(obl_ind, 2*num_obl);
        SetLength(obl_ind[2*(num_obl-1)],1);
        SetLength(obl_ind[2*num_obl-1],1);
        obl_ind[2*(num_obl-1),0]:=i;
        obl_ind[2*num_obl-1,0]:=j;
      end;
  end;
end;

procedure TContour.CreateMaskByDistance(var b: TBoolArray; x,y: word);
var i,j, temp, temp1, num_obl: integer;
begin
  num_obl:=0;
  if nearest then
  begin
    temp:=MaxInt;
    for i:=0 to length(gravity[0])-1 do
      begin
        temp1:=round(sqrt(sqr(gravity[1,i]-y)+sqr(gravity[2,i]-x)));
        if  temp1 < temp then
        begin
          temp:= temp1;
          num_obl:=gravity[0,i];
        end;
      end;
  end
  else
  begin
    temp:=0;
    for i:=0 to length(gravity[0])-1 do
      begin
        temp1:=round(sqrt(sqr(gravity[1,i]-y)+sqr(gravity[2,i]-x)));
        if  temp1 > temp then
        begin
          temp:= temp1;
          num_obl:=gravity[0,i];
        end;
      end
  end;

  for i:=0 to Length(b)-1 do
    for j:=0 to Length(b[0])-1 do
      b[i,j]:=false;

  for i:=0 to length(obl)-1 do
    if obl[i] = num_obl then
      for j:=0 to length(obl_ind[2*i])-1 do
        b[obl_ind[2*i,j], obl_ind[2*i+1,j]]:=true;
end;

procedure TContour.Processing(var b: TBoolArray);
begin
  FindObl(b);
  FindWeights;
end;

procedure TContour.CreateMaskByWeights(var b: TBoolArray);
var i, j, k: integer;
begin
   for i:=0 to Length(b)-1 do
    for j:=0 to Length(b[0])-1 do
      b[i,j]:=false;

   for k:=0 to length(gravity[0])-1 do
     for i:=0 to length(obl)-1 do
       if obl[i] = gravity[0,k] then
         for j:=0 to length(obl_ind[2*i])-1 do
           b[obl_ind[2*i,j], obl_ind[2*i+1,j]]:=true;
end;

procedure TContour.MeanDistance(x0,y0: integer);
var i, k, m, temp, dist: integer;

begin
  for k:=0 to length(area)-1 do
    if area[k] > threshold then
    begin
      temp:=length(meandist[0]);
      SetLength(meandist[0],temp+1);
      SetLength(meandist[1],temp+1);
      meandist[0,temp]:=k+1;
      dist:=0;
      for m:=0 to length(obl)-1 do
        if obl[m] = k+1 then
          for i:=0 to length(obl_ind[2*m])-1 do
            dist:= dist + round(Hypot(x0-obl_ind[2*m+1,i],y0-obl_ind[2*m,i]));
      meandist[1, temp]:=round(dist/area[k]);
    end;
end;

procedure TContour.CreateMaskByMeanDistance(var b: TBoolArray; x0,
  y0: word);
  var i,j, temp, num_obl: integer;
begin
  num_obl:=0;
  MeanDistance(x0,y0);

  if nearest then
  begin
    temp:=MaxInt;
    for i:=0 to length(meandist[0])-1 do
      if meandist[1,i] < temp then
      begin
        temp:=meandist[1,i];
        num_obl:=meandist[0,i];
      end;
  end
  else
  begin
    temp:=0;
    for i:=0 to length(meandist[0])-1 do
      if meandist[1,i] > temp then
      begin
        temp:=meandist[1,i];
        num_obl:=meandist[0,i];
      end;
  end;

  for i:=0 to Length(b)-1 do
    for j:=0 to Length(b[0])-1 do
      b[i,j]:=false;

  for i:=0 to length(obl)-1 do
    if obl[i] = num_obl then
      for j:=0 to length(obl_ind[2*i])-1 do
        b[obl_ind[2*i,j], obl_ind[2*i+1,j]]:=true;

end;

procedure TContour.CreateMaskByMeanDistanceInRing(var b: TBoolArray; x0,
  y0, rmin, rmax: word);
var i, j, k, m, temp, num_obl: integer;
begin
  num_obl:=0;
  MeanDistance(x0,y0);

  for i:=0 to Length(b)-1 do
    for j:=0 to Length(b[0])-1 do
      b[i,j]:=false;

  for k:=0 to length(meandist[0])-1 do
    if (meandist[1,k] >= rmin) and (meandist[1,k] <= rmax) then
      for i:=0 to length(obl)-1 do
        if obl[i] = meandist[0,k] then
          for j:=0 to length(obl_ind[2*i])-1 do
            b[obl_ind[2*i,j], obl_ind[2*i+1,j]]:=true;



  {for k:=0 to length(area)-1 do
    if area[k] > threshold then
      for m:=0 to length(obl)-1 do
        if obl[m] = k+1 then
          for i:=0 to length(obl_ind[2*m])-1 do
            b[obl_ind[2*m,i], obl_ind[2*m+1,i]]:=true;
   }
end;

procedure TContour.Processing(var p: TMyInfernalType);
var b: TBoolArray;
    i,j: integer;
begin
  SetLength(b, p.h, p.w);
  case p._type of
    varByte:  for i:=0 to p.h-1 do
                for j:=0 to p.w-1 do
                 b[i,j]:=boolean(p.b^[i*p.w+j]);
    varDouble:  for i:=0 to p.h-1 do
                  for j:=0 to p.w-1 do
                    b[i,j]:=boolean(round(p.a^[i*p.w+j]));
  end;


  FindObl(b);
  FindWeights;
  Finalize(b);
end;

procedure TContour.Test(var lc: TCircleCoordArray; var rms: TDouble1DArray; w, h: integer);
var k, m, i, j, n, cnt: integer;
    b: PBtArr;
begin
  n:=0;
  for k:=0 to length(area)-1 do
    if area[k] > threshold then
      inc(n);
  Finalize(lc);
  SetLength(lc, n);
  Finalize(rms);
  SetLength(rms, n);

  GetMem(b, w*h);
  n:=0;

  for k:=0 to length(area)-1 do
    if area[k] > threshold then
    begin
      FillChar(b^, w*h, 0);
      for m:=0 to length(obl)-1 do
        if obl[m] = k+1 then
          for j:=0 to length(obl_ind[2*m])-1 do
          begin
            b^[obl_ind[2*m,j]*w+obl_ind[2*m+1,j]]:=1;
          end;

      MNK_Circle(b^, lc[n].x, lc[n].y, lc[n].r, w, h);

      rms[n]:=0;
      cnt:=0;
      for i:=0 to h-1 do
        for j:=0 to w-1 do
          if b^[i*w+j]=1 then
          begin
            inc(cnt);
            rms[n]:=rms[n]+sqr(sqr(j-lc[n].x)+sqr(i-lc[n].y)-sqr(lc[n].r));
          end;

      rms[n]:=sqrt(rms[n]/cnt);
      inc(n);
    end;
  FreeMem(b, w*h);
end;

procedure TContour.CreateMaskByWeights(var b: TMyInfernalType);
var i, j, k, w, h: integer;
    _type: TVarType;
begin
  w:=b.w;
  h:=b.h;
  _type:=b._type;
  b.Clear;
  b.Init(h, w, _type);
  case _type of
    varDouble:  for k:=0 to length(gravity[0])-1 do
                  for i:=0 to length(obl)-1 do
                    if obl[i] = gravity[0,k] then
                      for j:=0 to length(obl_ind[2*i])-1 do
                        b.a^[obl_ind[2*i,j]*b.w+obl_ind[2*i+1,j]]:=1;
    varByte:    for k:=0 to length(gravity[0])-1 do
                  for i:=0 to length(obl)-1 do
                    if obl[i] = gravity[0,k] then
                      for j:=0 to length(obl_ind[2*i])-1 do
                        b.b^[obl_ind[2*i,j]*w+obl_ind[2*i+1,j]]:=1;
  end;
end;

procedure TContour.CreateMaskByDistance(var b: TMyInfernalType; x,
  y: word);
var i,j, temp, temp1, num_obl: integer;
begin
  num_obl:=0;
  if nearest then
  begin
    temp:=MaxInt;
    for i:=0 to length(gravity[0])-1 do
      begin
        temp1:=round(sqrt(sqr(gravity[1,i]-y)+sqr(gravity[2,i]-x)));
        if  temp1 < temp then
        begin
          temp:= temp1;
          num_obl:=gravity[0,i];
        end;
      end;
  end
  else
  begin
    temp:=0;
    for i:=0 to length(gravity[0])-1 do
      begin
        temp1:=round(sqrt(sqr(gravity[1,i]-y)+sqr(gravity[2,i]-x)));
        if  temp1 > temp then
        begin
          temp:= temp1;
          num_obl:=gravity[0,i];
        end;
      end
  end;

  for i:=0 to b.h-1 do
    for j:=0 to b.w-1 do
      b.b^[i*b.w+j]:=0;

  for i:=0 to length(obl)-1 do
    if obl[i] = num_obl then
      for j:=0 to length(obl_ind[2*i])-1 do
        b.b^[obl_ind[2*i,j]*b.w+obl_ind[2*i+1,j]]:=1;

end;

procedure TContour.Test(var x, y, r, rms, _mask: TMyInfernalType; w, h: integer);
var k, m, i, j, n, cnt: integer;
    b: PBtArr;
begin
  n:=0;
  for k:=0 to length(area)-1 do
    if area[k] > threshold then
      inc(n);
  x.Clear;
  x.Init(1, n, varDouble);
  y.Clear;
  y.Init(1, n, varDouble);
  r.Clear;
  r.Init(1, n, varDouble);
  rms.Clear;
  rms.Init(1, n, varDouble);
  _mask.Clear;
  _mask.Init(h, w, varByte);

  GetMem(b, w*h);
  n:=0;

  for k:=0 to length(area)-1 do
    if area[k] > threshold then
    begin
      FillChar(b^, w*h, 0);
      for m:=0 to length(obl)-1 do
        if obl[m] = k+1 then
          for j:=0 to length(obl_ind[2*m])-1 do
          begin
            b^[obl_ind[2*m,j]*w+obl_ind[2*m+1,j]]:=1;
            //_mask.b^[obl_ind[2*m,j]*w+obl_ind[2*m+1,j]]:=1;
          end;

      MNK_Circle(b^, x.a^[n], y.a^[n], r.a^[n], w, h);

      rms.a^[n]:=0;
      cnt:=0;
      for i:=0 to h-1 do
        for j:=0 to w-1 do
          if b^[i*w+j]=1 then
          begin
            inc(cnt);
            rms.a^[n]:=rms.a^[n]+sqr(sqr(j-x.a^[n])+sqr(i-y.a^[n])-sqr(r.a^[n]));
          end;

      rms.a^[n]:=sqrt(rms.a^[n]/cnt);
      inc(n);
    end;
  FreeMem(b, w*h);
end;

end.

