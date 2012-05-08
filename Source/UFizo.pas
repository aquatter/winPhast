unit UFizo;

interface
uses crude, t666, Utype, UCATool;

procedure Fizo_Shift(var int: TPointerArray; w, h, n: integer);
procedure Fizo_FftMask(var fft, mask: TMyInfernalType; r, r0, r1: treal);

implementation

uses UPhast2Vars, math, UFFT, windows, types;


procedure Fizo_Shift(var int: TPointerArray; w, h, n: integer);
var fft1, fft2, p, m, temp_mask: TMyInfernalType;
    i,j,k, cnt, l: integer;
    plan: pointer;
    mean1, mean2{, r0, r1, r}: treal;
begin
  fft1:=TMyInfernalType.Create;
  fft2:=TMyInfernalType.Create;
  p:=TMyInfernalType.Create;
  m:=TMyInfernalType.Create;
  temp_mask:=TMyInfernalType.Create;

  fft1.Init(h, 2*w, varDouble);
  fft2.Init(h, 2*w, varDouble);
  p.Init(h, w, varDouble);
  m.Init(h, w, varDouble);
  temp_mask.Init(h, w, varByte);


  Fizo_Steps.Clear;
  Fizo_Steps.Init(1, n, varDouble);

  for i:=0 to h-1 do
    for j:=0 to w-1 do
    begin
      fft1.a^[(i*w+j)*2]:=int[0]^[i*w+j]*Power(-1, i+j);
      fft1.a^[(i*w+j)*2+1]:=0;
    end;

  plan:=fftw_plan_dft_2d(h, w, fft1.a, fft1.a, FFTW_FORWARD, FFTW_ESTIMATE);
  fftw_execute(plan);
  fftw_destroy_plan(plan);

//  r:=30;
//  r0:=10;
//  r1:=30;

  Fizo_FftMask(fft1, m, cfg.r, cfg.r0, cfg.r1);
//  CreateBin(m, 'mask.bin');

  for i:=0 to w*h-1 do
  begin
    fft1.a^[2*i]:=fft1.a^[2*i]*m.a^[i];
    fft1.a^[2*i+1]:=fft1.a^[2*i+1]*m.a^[i];
  end;

  plan:=fftw_plan_dft_2d(h, w, fft1.a, fft1.a, FFTW_BACKWARD, FFTW_ESTIMATE);
  fftw_execute(plan);
  fftw_destroy_plan(plan);

  for k:=1 to n-1 do
  begin
    for i:=0 to h-1 do
      for j:=0 to w-1 do
      begin
        fft2.a^[(i*w+j)*2]:=int[k]^[i*w+j]*Power(-1, i+j);
        fft2.a^[(i*w+j)*2+1]:=0;
      end;

      plan:=fftw_plan_dft_2d(h, w, fft2.a, fft2.a, FFTW_FORWARD, FFTW_ESTIMATE);
      fftw_execute(plan);
      fftw_destroy_plan(plan);

      for i:=0 to w*h-1 do
      begin
        fft2.a^[2*i]:=fft2.a^[2*i]*m.a^[i];
        fft2.a^[2*i+1]:=fft2.a^[2*i+1]*m.a^[i];
      end;

      plan:=fftw_plan_dft_2d(h, w, fft2.a, fft2.a, FFTW_BACKWARD, FFTW_ESTIMATE);
      fftw_execute(plan);
      fftw_destroy_plan(plan);

      CADiv(w, h, fft2.a^, fft1.a^, fft1.a^);

      mean1:=0;
      for i:=0 to w*h-1 do
      begin
        p.a^[i]:=ArcTan2(fft1.a^[2*i+1], fft1.a^[2*i]);
        mean1:=mean1+p.a^[i];
      end;

      mean1:=mean1/(w*h);
      FillMemory(temp_mask.b, w*h, 1);

      for l:=0 to 4 do
      begin
        cnt:=0;
        mean2:=0;
        for i:=0 to w*h-1 do
          if temp_mask.b^[i] = 1 then
            if (abs(p.a^[i]-mean1) < 0.8/(l+1)) then
            begin
              inc(cnt);
              mean2:=mean2+p.a^[i];
            end
            else
              temp_mask.b^[i]:=0;
        mean2:=mean2/cnt;
        mean1:=mean2;
      end;

      Fizo_Steps.a^[k]:=mean2+Fizo_Steps.a^[k-1];
      CopyMemory(fft1.a, fft2.a, 2*w*h*sizeof(treal));

  end;


//  CreateBin(p, temp_mask, 'shift.bin');
  fft1.Destroy;
  fft2.Destroy;
  p.Destroy;
  m.Destroy;
  temp_mask.Destroy;
end;

procedure Fizo_FftMask(var fft, mask: TMyInfernalType; r, r0, r1: treal);
var i, j, w, h, w0, h0: integer;
  amp: TMyInfernalType;
  max, _r, _r1: treal;
  cp: TPoint;
begin
  w:=fft.w div 2;
  h:=fft.h;

  w0:=w div 2;
  h0:=h div 2;

  mask.Clear;
  mask.Init(h, w, varDouble);
  amp:=TMyInfernalType.Create;
  amp.Init(h, w, varDouble);

  for i:=0 to w*h-1 do
    amp.a^[i]:=Hypot(fft.a^[2*i], fft.a^[2*i+1]);

//  CreateBin(amp, 'amp.bin');

  max:=-MaxTReal;

  cp:=Point(0,0);

  for i:=0 to h0+10 do
    for j:=0 to w-1 do
    begin
      _r:=Hypot(i-h0, j-w0);
      if (_r > r0) and (_r < r1) and (amp.a^[i*w+j] > max) then
      begin
        max:=amp.a^[i*w+j];
        cp.x:=j;
        cp.y:=i;
      end;
    end;
  amp.Destroy;

  for i:=0 to h-1 do
    for j:=0 to w-1 do
    begin
      _r:=Hypot(i-h0, j-w0);
      _r1:=Hypot(i-cp.y, j-cp.x);
      if _r1 < r1 then
        mask.a^[i*w+j]:=NuttallWin(_r1, 0, 2*r)*(1-NuttallWin(_r, 0, 2*r0));
    end;

end;


end.
