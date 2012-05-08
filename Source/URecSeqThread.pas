unit URecSeqThread;

interface

uses
  Classes, crude;

type
  TRecMode = (rmBase, rmNorm);
  TRecSeqThread = class(TThread)
  private
    num_seq, w, h, steps, seq, mm: integer;
    temp: TPointerArray;
    s: string;
  public
    cancel: boolean;
  protected
    procedure Execute; override;
    procedure RecBase;
    procedure RecNorm;
    procedure Draw;
  end;

procedure RecSeqThread_start;

var RecSeqThread: TRecSeqThread;
    RecMode: TRecMode;

implementation

uses unit1, utype, UUnwrap, SysUtils, forms, windows, UPhast2Vars, URecSeqThreadForm,
     dialogs, t666, unit2, ufiltr, ufizo;

procedure TRecSeqThread.Draw;
begin

  case mm of
    0: begin
         pnl.DrawImage(phase, final_mask);
         form1.UpdateLegendLabels;
       end;
    1: begin
         pnl.DrawImage(unwrap, final_mask);
         form1.UpdateLegendLabels;
       end;
    2: begin
         RecSeqThreadForm.Label1.Alignment:=taCenter;
         RecSeqThreadForm.Label1.Caption:='Реконструируется объект '+IntToStr(seq)+' из '+IntToStr(num_seq);
       end;
    3: begin
         pnl.DrawImage(final_phase, final_mask);
         form1.UpdateLegendLabels;
         RecSeqThreadForm.Close;
         form1.Off(true);
       end;
    4: ShowMessage('Ошибка загрузки интерферограмм!'+#13#10+s);
    5: begin
         pnl.DrawImage(final_phase, final_mask);
         form1.UpdateLegendLabels;
         if cfg.do_step then
           form1.N35Click(Self);
       end;
    6: pnl.DrawImage(unwrap, mask_inner);
    7: pnl.DrawImage(unwrap, mask_outer);
    8: RecSeqThreadForm.Label2.Visible:=true;
    9: RecSeqThreadForm.Label2.Visible:=false;
  end;
end;

procedure TRecSeqThread.Execute;
var i,j: integer;
begin
  w:=cfg.cam_w;
  h:=cfg.cam_h;
  steps:=cfg.steps;
//  if cfg.Fizo then
//    steps:=cfg.Fizo_Frames;

  cancel:=false;

  if cfg.do_seq then
    num_seq:=cfg.num_seq
  else
    num_seq:=1;

  SetLength(temp, cfg.steps);
  for i:=0 to steps-1 do
    GetMem(temp[i], w*h);

  phase.Clear;
  phase.Init(h, w, varDouble);
  unwrap.Clear;
  unwrap.Init(h, w, varDouble);
//  final_mask.Clear;
//  final_mask.Init(h, w, varByte);
  final_phase.Clear;
  final_phase.Init(h, w, varDouble);
  amp.Clear;
  amp.Init(h, w, varDouble);

  {for i:=10 to h-9 do
    for j:=10 to w-9 do
      final_mask.b^[i*w+j]:=1;}


  case RecMode of
    rmBase: RecBase;
    rmNorm: RecNorm;
  end;

  for i:=0 to steps-1 do
    FreeMem(temp[i], w*h);
  Finalize(temp);
end;

procedure TRecSeqThread.RecBase;
var l, i, j: integer;
begin
  for l:=0 to num_seq-1 do
  begin
    seq:=l+1;
    mm:=2;
    Synchronize(draw);
    if cancel then break;
    

    for i:=0 to steps-1 do
    begin
      case from of
        fromCamera: s:=format(cfg.img_path+'\cadr_i%d_s%d_c%d.bmp',[1, i+1, l+1]);
        fromHDD: s:=Form2.ListView2.Items[i].SubItems[1];
      end;

      if not FileExists(s) then
      begin
         mm:=4;
         Synchronize(draw);
         Terminate;
         break;
      end;
      LoadBmp(temp[i]^, w, h, s);
    end;

    if Terminated then
      break;

    if cfg.Fizo then
    begin
      Synchronize(procedure
                  begin
                    RecSeqThreadForm.Label2.Visible:=true;
                  end);
      Fizo_Shift(temp, w, h, steps);
      Synchronize(procedure
                  begin
                    RecSeqThreadForm.Label2.Visible:=false;
                  end);
      FindPhaseApprox(phase, amp, final_mask, Fizo_Steps, temp, steps);

    end
    else
      FindPhase(phase, final_mask, temp, steps);

    mm:=0;
    Synchronize(draw);
//    CreateBin(amp, 'temp_amp.bin');

    UnWrapPhaseSt(Origin.x, Origin.y, w, h, phase.a^, unwrap.a^, final_mask.b^);

    if cfg.invert then
      for i:=0 to w*h-1 do
        if final_mask.b^[i]=1 then
          unwrap.a^[i]:=-unwrap.a^[i];

    TiltRemove(unwrap.a^, final_mask.b^, final_mask.b^, h, w);
    mm:=1;
    Synchronize(draw);

    for i:=0 to w*h-1 do
      if final_mask.b^[i]=1 then
        final_phase.a^[i]:= final_phase.a^[i]+unwrap.a^[i];

    if cancel then break;
  end;

  for i:=0 to w*h-1 do
    if final_mask.b^[i]=1 then
      final_phase.a^[i]:= final_phase.a^[i]/num_seq;

  {for i:=0 to w*h-1 do
    if final_mask.b^[i]=1 then
      final_phase.a^[i]:=final_phase.a^[i]*cfg.lambda/(4*Pi);}


{  if cfg.do_filtr then
    RAFilterGaussianMaskOutBad(w, h, cfg.gauss_aper, cfg.gauss_aper div 2, final_phase.a^, final_phase.a^, final_mask.b^);}

//  CreateBin(final_phase, final_mask, ExtractFilePath(Application.ExeName)+'temp.bin');
  CopyMemory(mask_inner.b, final_mask.b, w*h);

  CurrentMatrix:=cmUnwrap;
  mm:=3;
  Synchronize(draw);
end;

procedure TRecSeqThread.RecNorm;
var i, l: integer;
    _base, base_mask: TMyInfernalType;
    base_loaded: boolean;
    temp_mask, temp_unwrap: TMyInfernalType;
    mean: treal;
    cnt: integer;
    j: Integer;
begin
  temp_mask:=TMyInfernalType.Create;
  temp_mask.InitByArray(final_mask);

  base_loaded:=false;
  if cfg.base and FileExists(cfg.base_path) then
  begin
    _base:=TMyInfernalType.Create;
    base_mask:=TMyInfernalType.Create;

    LoadBin(_base, base_mask, cfg.base_path);

    for i:=0 to w*h-1 do
    begin
      final_mask.b^[i]:=final_mask.b^[i]*base_mask.b^[i];
      mask_inner.b^[i]:=mask_inner.b^[i]*base_mask.b^[i];
      mask_outer.b^[i]:=mask_outer.b^[i]*base_mask.b^[i];
    end;
    base_loaded:=true;
  end;

  if cfg.do_step then
  begin
    CopyMemory(final_mask.b, base_mask.b, w*h);

    {ZeroMemory(final_mask.b, w*h);
    for i:=10 to h-11 do
      for j:=10 to w-11 do
        final_mask.b^[i*w+j]:=1;}
  end;
  {else
    for i:=0 to w*h-1 do
      if (mask_inner.b^[i]=1) or (mask_outer.b^[i]=1) then
        final_mask.b^[i]:=1
      else
        final_mask.b^[i]:=0;}



  for l:=0 to num_seq-1 do
  begin
    seq:=l+1;
    mm:=2;
    Synchronize(draw);
    if cancel then break;

    for i:=0 to steps-1 do
    begin
      case from of
        fromCamera: s:=format(cfg.img_path+'\cadr_i%d_s%d_c%d.bmp',[1, i+1, l+1]);
        fromHDD: s:=Form2.ListView2.Items[i].SubItems[1];
      end;

      if not FileExists(s) then
      begin
         mm:=4;
         Synchronize(draw);
         Terminate;
         break;
      end;
      LoadBmp(temp[i]^, w, h, s);
    end;

    if Terminated then
      break;

    if cfg.Fizo then
    begin
      Synchronize(procedure
                  begin
                    RecSeqThreadForm.Label2.Visible:=true;
                  end);
      Fizo_Shift(temp, w, h, steps);
      Synchronize(procedure
                  begin
                    RecSeqThreadForm.Label2.Visible:=false;
                  end);
      FindPhaseApprox(phase, amp, final_mask, Fizo_Steps, temp, steps);
    end
    else
      FindPhase(phase, amp, final_mask, temp, steps);

//    CreateBin(amp, 'temp_amp.bin');
//    CreateBin(phase, temp_mask, ExtractFilePath(Application.ExeName)+'phase.bin');

    mm:=0;
    Synchronize(draw);

    if cfg.do_unwrap then
    begin
      if cfg.UnwrapPhaseSeparately then
      begin
        UnWrapPhaseSt(Origin01.x, Origin01.y, w, h, phase.a^, unwrap.a^, mask_inner.b^);

        temp_unwrap:=TMyInfernalType.Create;
        temp_unwrap.InitByArray(unwrap);
        UnWrapPhaseSt(Origin02.x, Origin02.y, w, h, phase.a^, temp_unwrap.a^, mask_outer.b^);

        for i:=0 to w*h-1 do
          if mask_outer.b^[i]=1 then
            unwrap.a^[i]:=temp_unwrap.a^[i];

        temp_unwrap.Destroy;
      end
      else
        UnWrapPhaseSt(Origin.x, Origin.y, w, h, phase.a^, unwrap.a^, final_mask.b^);

      {mm:=6;
      Synchronize(draw);
      _base:=TMyInfernalType.Create;
      _base.InitByArray(unwrap);

      UnWrapPhaseSt(Origin02.x, Origin02.y, w, h, phase.a^, unwrap.a^, mask_outer.b^);
      mm:=7;
      Synchronize(draw);

      for i:=0 to w*h-1 do
        if mask_inner.b^[i]=1 then
          unwrap.a^[i]:=_base.a^[i];

      _base.Destroy;
       }
    end
    else
      CopyMemory(unwrap.a, phase.a, w*h*sizeof(treal));


    if cfg.invert then
      for i:=0 to w*h-1 do
        unwrap.a^[i]:=-unwrap.a^[i];

    if base_loaded then
      for i:=0 to w*h-1 do
        unwrap.a^[i]:=unwrap.a^[i]-_base.a^[i];

    if cfg.do_phase2z then
      for i:=0 to w*h-1 do
        unwrap.a^[i]:=unwrap.a^[i]*cfg.lambda/(4*Pi);


    if cfg.tilt then
      case cfg.TiltMask of
        0: TiltRemove(unwrap.a^, mask_inner.b^, final_mask.b^, h, w);
        1: TiltRemove(unwrap.a^, mask_outer.b^, final_mask.b^, h, w);
        2: TiltRemove(unwrap.a^, final_mask.b^, final_mask.b^, h, w);
      end;


//    CreateBin(unwrap, temp_mask, ExtractFilePath(Application.ExeName)+'unwrap.bin');

    mm:=1;
    Synchronize(draw);

    for i:=0 to w*h-1 do
      if final_mask.b^[i]=1 then
        final_phase.a^[i]:= final_phase.a^[i]+unwrap.a^[i];

    if cancel then break;

    if cfg.AverageSerie then
      continue;


    if cfg.do_gauss then
      RAFilterGaussianMaskOutBad(w, h, round(cfg.gauss_aper), cfg.gauss_aper/2, unwrap.a^, final_phase.a^, final_mask.b^);

    CurrentMask:=cmFinal;
    SaveAS(cfg.SavePath+Format('_%.4d_', [l+1]));


  end;

  for i:=0 to w*h-1 do
    if final_mask.b^[i]=1 then
      final_phase.a^[i]:= final_phase.a^[i]/num_seq;

  if cfg.do_filtr then
  begin
    cnt:=0;
    mean:=0;
    for i:=0 to w*h-1 do
      if final_mask.b^[i] = 1 then
      begin
        inc(cnt);
        mean:=mean+final_phase.a^[i];
      end;
    if cnt <> 0 then
      mean:=mean/cnt;

    for i:=0 to w*h-1 do
      if final_mask.b^[i] <> 1 then
        final_phase.a^[i]:=mean;

    GaussHighPass(final_phase);
  end;

  if cfg.do_gauss then
  begin
    RAFilterGaussianMaskOutBad(w, h, round(cfg.gauss_aper), cfg.gauss_aper/2, final_phase.a^, final_phase.a^, final_mask.b^);
    RAFilterGaussianMaskOutBad(w, h, round(cfg.gauss_aper), cfg.gauss_aper/2, amp.a^, amp.a^, final_mask.b^);
  end;


//  for i:=0 to w*h-1 do
//    if final_mask.b^[i] = 1 then
//      final_phase.a^[i]:=final_phase.a^[i]/1e3;
//
//  CreateBin(final_phase, final_mask, ExtractFilePath(Application.ExeName)+'temp.bin');
//  if not cfg.do_step then
//    CopyMemory(mask_inner.b, final_mask.b, w*h);
  mm:=3;
  Synchronize(draw);

  if base_loaded then
  begin
    _base.Destroy;
    base_mask.Destroy;
  end;

  temp_mask.Destroy;
  CurrentMatrix:=cmUnwrap;
  CurrentMask:=cmFinal;
  mm:=5;
  Synchronize(draw);
end;

procedure RecSeqThread_start;
var w, h, i, j, cnt, cnt1, cnt2: integer;
    p0, p1, p2: tpoint;
begin
  if not int.loaded then
    exit;

  w:=cfg.cam_w;
  h:=cfg.cam_h;

  final_mask.Clear;
  final_mask.Init(h, w, varByte);
  cnt:=0;
  p0:=Point(0,0);

  if cfg.FinalMaskFullScreen then
  begin
    for i:=10 to h-9 do
      for j:=10 to w-9 do
        final_mask.b^[i*w+j]:=1;
    p0.x:=w div 2;
    p0.y:=h div 2;
    cnt:=1;
  end
  else
    for i:=0 to h-1 do
      for j:=0 to w-1 do
        if (mask_inner.b^[i*w+j]=1) or (mask_outer.b^[i*w+j]=1) then
        begin
          final_mask.b^[i*w+j]:=1;
          p0.x:=p0.x+j;
          p0.y:=p0.y+i;
          inc(cnt);
        end;

  {pnl.DrawImage(int, final_mask);
  exit;}


  if cnt=0 then
  begin
    for i:=10 to h-9 do
      for j:=10 to w-9 do
        final_mask.b^[i*w+j]:=1;

    origin.x:=w div 2;
    origin.y:=h div 2;
    cfg.TiltMask:=2;
    cfg.UnwrapPhaseSeparately:=false;
  end
  else
  begin
    cnt1:=0;
    cnt2:=0;
    p1:=Point(0,0);
    p2:=Point(0,0);


    if cfg.UnwrapPhaseSeparately and (mask_inner.b^[Origin01.y*w+Origin01.x] = 0) then
    begin
      for i:=0 to h-1 do
        for j:=0 to h-1 do
        begin
          if mask_inner.b^[i*w+j]=1 then
          begin
            p1.x:=p1.x+j;
            p1.y:=p1.y+i;
            inc(cnt1);
          end;
        end;

      if cnt1 <> 0 then
      begin
        p1.x:=round(p1.x/cnt1);
        p1.y:=round(p1.y/cnt1);
      end
      else
        p1:=Point(0,0);
    end
    else
      p1:=origin01;

    if cfg.UnwrapPhaseSeparately and (mask_outer.b^[Origin02.y*w+Origin02.x] = 0) then
    begin
      for i:=0 to h-1 do
        for j:=0 to h-1 do
        begin
          if mask_outer.b^[i*w+j]=1 then
          begin
            p2.x:=p2.x+j;
            p2.y:=p2.y+i;
            inc(cnt2);
          end;
        end;

      if cnt2 <> 0 then
      begin
        p2.x:=round(p2.x/cnt2);
        p2.y:=round(p2.y/cnt2);
      end
      else
        p2:=Point(0,0);
    end
    else
      p2:=origin02;


    if (not cfg.UnwrapPhaseSeparately) and (final_mask.b^[origin.y*w+origin.x] = 0) then
    begin
      p0.x:=round(p0.x/cnt);
      p0.y:=round(p0.y/cnt);
    end
    else
      p0:=origin;

    if (not cfg.UnwrapPhaseSeparately) and (final_mask.b^[p0.y*w+p0.x] = 0) then
    begin
      ShowMessage('Точка начала сшивки вне области общей маски!');
      exit;
    end;

    if cfg.UnwrapPhaseSeparately and (mask_inner.b^[p1.y*w+p1.x] = 0) then
    begin
      ShowMessage('Точка начала сшивки вне области маски 1');
      exit;
    end;

    if cfg.UnwrapPhaseSeparately and (mask_outer.b^[p2.y*w+p2.x] = 0) then
    begin
      ShowMessage('Точка начала сшивки вне области маски 2');
      exit;
    end;
    Origin:=p0;
    Origin01:=p1;
    Origin02:=p2;
  end;


    {
  if not _Origin then
  begin
    origin.x:=w div 2;
    origin.y:=h div 2;
  end;

  cnt:=0;
  for i:=0 to w*h-1 do
    cnt:=cnt+mask_inner.b^[i];

  if cnt=0 then
    for i:=10 to h-9 do
      for j:=10 to w-9 do
        mask_inner.b^[i*w+j]:=1;

  if (mask_inner.b^[Origin.y*w+Origin.x] = 0) then
  begin
    ShowMessage('Точка начала сшивки вне области выделения!');
    exit;
  end;
     }
  pnl.Contrast_mask:=1;
  form1.Off(false);

  if cfg.ComMode then
    cfg.lambda:=cfg.LazerLambda[cfg.LazerNum];

  RecSeqThreadForm.Show;
  RecSeqThread:=TRecSeqThread.Create(true);
  RecSeqThread.FreeOnTerminate:=true;
  RecSeqThread.Resume;
end;


end.

