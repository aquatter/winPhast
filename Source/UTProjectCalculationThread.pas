unit UTProjectCalculationThread;

interface

uses
  Classes, UProjectData, UPhast2Vars, Generics.Collections, t666;

type


  TProjectCalculationThread = class(TThread)
  private
    { Private declarations }
  public
    pd_: TProjectData;
    phase, amp, unwrap, base, base_mask, final_mask,
    mask1, mask2, mean_unwrap: TMyInfernalType;
    doBase: boolean;
    function CalculatePhase(img: TList<AnsiString>; num_seq, num_rec: integer; what_to_calc: TCalculationList = calcPhase): boolean;
    function CalculateUnwrap(num_seq, num_rec: integer): boolean;
    function need_to_load_base(): boolean;
    procedure init_masks;
    procedure sync(m: integer; seq_num: integer = 0; rec_num: integer = 0; s: string = '');
  protected
    procedure Execute; override;
  end;


var
  ProjectCalculationThread: TProjectCalculationThread;

procedure StartCalculationThread(pd: TProjectData);

implementation

uses
  Unit1, Crude, SysUtils, Dialogs, UPTree, Uvt, Windows, UUnwrap, UFiltr,
  URecSeqThreadForm;

{
  Important: Methods and properties of objects in visual components can only be
  used in a method called using Synchronize, for example,

      Synchronize(UpdateCaption);

  and UpdateCaption could look like,

    procedure TProjectCalculationThread.UpdateCaption;
    begin
      Form1.Caption := 'Updated in a thread';
    end;

    or

    Synchronize(
      procedure
      begin
        Form1.Caption := 'Updated in thread via an anonymous method'
      end
      )
    );

  where an anonymous method is passed.

  Similarly, the developer can call the Queue method with similar parameters as
  above, instead passing another TThread class as the first parameter, putting
  the calling thread in a queue with the other thread.

}

{ TProjectCalculationThread }

function TProjectCalculationThread.CalculatePhase(img: TList<AnsiString>; num_seq, num_rec: integer; what_to_calc: TCalculationList): boolean;
var images: TPointerArray;
    w, h, i: integer;
    s, phase_path, amp_path: string;
begin
  w:= pd_.prop_.w;
  h:= pd_.prop_.h;
  SetLength(images, img.Count);

  for i:=0 to img.Count-1 do
  begin
    GetMem(images[i], w*h);
    s:= string(pd_.prop_.file_path + img[i]);
    if not FileExists(s) then
    begin
      Synchronize(
        procedure
        begin
          ShowMessage('Файл не найден: ' + s);
        end
      );
      Result:= false;
      exit;
    end;

    LoadBmp(images[i]^, w, h, s);
  end;

  phase.Init(h, w, varDouble);
  amp.Init(h, w, varDouble);

  FindPhase(phase, amp, phase, images, img.Count);

  case what_to_calc of
    calcPhase, calcAmp:
    begin
      phase_path:= string(pd_.prop_.file_path) + 'phase_'+IntToStr(num_seq+1)+'_'+IntToStr(num_rec+1)+'.bin';
      amp_path:= string(pd_.prop_.file_path) + 'amp_'+IntToStr(num_seq+1)+'_'+IntToStr(num_rec+1)+'.bin';
      pd_[num_seq][num_rec].phase:= AnsiString('phase_'+IntToStr(num_seq+1)+'_'+IntToStr(num_rec+1)+'.bin');
      pd_[num_seq][num_rec].amp:= AnsiString('amp_'+IntToStr(num_seq+1)+'_'+IntToStr(num_rec+1)+'.bin');
    end;
    calcPhase2, calcAmp2:
    begin
      phase_path:= string(pd_.prop_.file_path) + 'phase2_'+IntToStr(num_seq+1)+'_'+IntToStr(num_rec+1)+'.bin';
      amp_path:= string(pd_.prop_.file_path) + 'amp2_'+IntToStr(num_seq+1)+'_'+IntToStr(num_rec+1)+'.bin';
      pd_[num_seq][num_rec].phase2:= AnsiString('phase2_'+IntToStr(num_seq+1)+'_'+IntToStr(num_rec+1)+'.bin');
      pd_[num_seq][num_rec].amp2:= AnsiString('amp2_'+IntToStr(num_seq+1)+'_'+IntToStr(num_rec+1)+'.bin');
    end;
  end;

  CreateBin(phase, phase_path);
  CreateBin(amp, amp_path);

  Synchronize(
  procedure
  begin
    case what_to_calc of
      calcPhase, calcPhase2: pnl.DrawImage(phase, phase);
      calcAmp, calcAmp2: pnl.DrawImage(amp, amp);
    end;
  end
  );

  for i:=0 to img.Count-1 do
    FreeMem(images[i], w*h);
  Finalize(images);

  pd_[num_seq][num_rec].phase_calculated:= true;
  Result:= true;
end;

function TProjectCalculationThread.CalculateUnwrap(num_seq, num_rec: integer): boolean;
var w, h, i, cnt: integer;
    s: string;
    unwrap_second: TMyInfernalType;
    mean: double;
begin
  w:= pd_.prop_.w;
  h:= pd_.prop_.h;

  s:= string(pd_.prop_.file_path + pd_[num_seq][num_rec].phase);

  if {pd_[num_seq][num_rec].phase_calculated} FileExists(string(s)) then
  begin
//    s:= string(pd_.prop_.file_path + pd_[num_seq][num_rec].phase);
//    if not FileExists(s) then
//      raise Exception.Create('Файл с фазой не найден');
    LoadBin(phase, varDouble, s);
  end
  else
  begin
    if not CalculatePhase(pd_[num_seq][num_rec].img, num_seq, num_rec) then
      raise Exception.Create('Ошибка вычисления фазы');
  end;

  Synchronize(procedure begin pnl.DrawImage(phase, phase); end);
  sync(0, num_seq+1, num_rec+1);

  unwrap.Clear;
  unwrap.Init(h, w, varDouble);

  if cfg.UnwrapPhaseSeparately then
  begin
    UnWrapPhaseSt(Origin01.x, Origin01.y, w, h, phase.a^, unwrap.a^, mask1.b^);

    unwrap_second:=TMyInfernalType.Create;
    unwrap_second.InitByArray(unwrap);
    UnWrapPhaseSt(Origin02.x, Origin02.y, w, h, phase.a^, unwrap_second.a^, mask2.b^);

    for i:=0 to w*h-1 do
      if mask2.b^[i]=1 then
        unwrap.a^[i]:=unwrap_second.a^[i];

    unwrap_second.Destroy;
  end
  else
    UnWrapPhaseSt(Origin.X, Origin.Y, w, h, phase.a^, unwrap.a^, final_mask.b^);

//  CreateBin(final_mask, 'c:\files\final_mask.bin');

  if cfg.invert then
    for i:=0 to w*h-1 do
      unwrap.a^[i]:=-unwrap.a^[i];

  if cfg.do_phase2z then
    for i:=0 to w*h-1 do
      unwrap.a^[i]:=unwrap.a^[i]*pd_.prop_.WaveLength/(4*Pi);

  if doBase then
    for i:=0 to w*h-1 do
      unwrap.a^[i]:=unwrap.a^[i]-base.a^[i];

  if cfg.tilt then
    case cfg.TiltMask of
      0: TiltRemove(unwrap.a^, mask1.b^, final_mask.b^, h, w);
      1: TiltRemove(unwrap.a^, mask2.b^, final_mask.b^, h, w);
      2: TiltRemove(unwrap.a^, final_mask.b^, final_mask.b^, h, w);
    end;

  Synchronize(procedure begin pnl.DrawImage(unwrap, final_mask); end);

  if cfg.do_gauss then
    RAFilterGaussianMaskOutBad(w, h, round(cfg.gauss_aper), cfg.gauss_aper/2, unwrap.a^, unwrap.a^, final_mask.b^);

  Synchronize(procedure begin pnl.DrawImage(unwrap, final_mask); end);

  if cfg.do_filtr then
  begin
    cnt:=0;
    mean:=0;
    for i:=0 to w*h-1 do
      if final_mask.b^[i] = 1 then
      begin
        inc(cnt);
        mean:= mean + unwrap.a^[i];
      end;
    if cnt <> 0 then
      mean:= mean/cnt;

    for i:=0 to w*h-1 do
      if final_mask.b^[i] <> 1 then
        unwrap.a^[i]:=mean;

    GaussHighPass(unwrap);

    Synchronize(procedure begin pnl.DrawImage(unwrap, final_mask); end);
  end;

  s:= string(pd_.prop_.file_path) + 'unwrap_'+IntToStr(num_seq+1)+'_'+IntToStr(num_rec+1)+'.bin';

  CreateBin(unwrap, s);
  pd_[num_seq][num_rec].unwrap:= AnsiString('unwrap_'+IntToStr(num_seq+1)+'_'+IntToStr(num_rec+1)+'.bin');

  pd_[num_seq][num_rec].unwrap_calculated:= true;
  pd_.active:= amCombined;
  mask_inner.Clear;
  mask_inner.InitByArray(final_mask);

  sync(1);
  Result:= true;
end;

procedure TProjectCalculationThread.sync(m: integer; seq_num: integer = 0; rec_num: integer = 0; s: string = '');
begin
  case m of
    0: Synchronize( procedure
                    begin
                      RecSeqThreadForm.Show;
                      RecSeqThreadForm.Label1.Alignment:=taCenter;
                      RecSeqThreadForm.Label1.Caption:='Реконструируется объект '+IntToStr(seq_num)+' из '+IntToStr(rec_num);
                    end );
    1: Synchronize(procedure begin RecSeqThreadForm.Close; end);
  end;
end;

procedure TProjectCalculationThread.Execute;
var i,j,k, mean_cnt: integer;
    rec_: TRec;
    s: AnsiString;
    img_list: TList<AnsiString>;
begin
  phase:= TMyInfernalType.Create;
  amp:= TMyInfernalType.Create;
  unwrap:= TMyInfernalType.Create;
  base:= TMyInfernalType.Create;
  base_mask:= TMyInfernalType.Create;
  final_mask:= TMyInfernalType.Create;
  mask1:= TMyInfernalType.Create;
  mask2:= TMyInfernalType.Create;
  mean_unwrap:= TMyInfernalType.Create;

  doBase:= need_to_load_base;


  try
    try
    init_masks;

    for i:=0 to pd_.Count-1 do
    begin

      if pd_[i].doMean then
      begin
        mean_unwrap.Clear;
        mean_unwrap.Init(pd_.prop_.h, pd_.prop_.w, varDouble);
        mean_cnt:=0;
      end;

      for j:=0 to pd_[i].Count-1 do
      begin
        rec_:= pd_[i][j];
        for k:=0 to Length(rec_.what_to_calc)-1 do
          case rec_.what_to_calc[k] of
            calcPhase, calcAmp, calcPhase2, calcAmp2:
                                begin
                                  case rec_.what_to_calc[k] of
                                    calcPhase, calcAmp: img_list:= rec_.img;
                                    calcPhase2, calcAmp2: img_list:= rec_.img2;
                                  end;

                                  if not CalculatePhase(img_list, i, j, rec_.what_to_calc[k]) then
                                    raise Exception.Create('Ошибка вычисления фазы');
                                end;
            calcUnwrap:
                        begin
                          if not CalculateUnwrap(i,j) then
                            raise Exception.Create('Ошибка вычисления сшитой фазы');
                        end;
          end;

        if pd_[i].doMean then
        begin

          s:= pd_.prop_.file_path + rec_.unwrap;
          if FileExists(string(s)) then
          begin
            LoadBin(unwrap, varDouble, string(s));
          end
          else
          begin
            if not CalculateUnwrap(i,j) then
              raise Exception.Create('Ошибка вычисления сшитой фазы');

          end;

          for k:=0 to unwrap.w*unwrap.h-1 do
            mean_unwrap.a^[k]:= mean_unwrap.a^[k] + unwrap.a^[k];
          inc(mean_cnt);
        end;

      end;

      if pd_[i].doMean then
        if mean_cnt <> 0 then
        begin
          for k:=0 to mean_unwrap.w*mean_unwrap.h-1 do
            mean_unwrap.a^[k]:= mean_unwrap.a^[k]/mean_cnt;

          Synchronize(procedure begin pnl.DrawImage(mean_unwrap, final_mask); end);

          s:= AnsiString( pd_.prop_.file_path + 'mean_' + IntToStr(i+1) + '.bin' );

          CreateBin(mean_unwrap, string(s));
          pd_[i].mean_unwrap:= AnsiString( 'mean_' + IntToStr(i+1) + '.bin' );
        end;
    end;
    except
      on e: Exception do
        Synchronize( procedure begin ShowMessage(e.Message); end );
    end;

  finally
//    s:= pd_.prop_.file_path + pd_.prop_.file_name;
    //SaveProject(pd_);
    pd_.changed:= true;

    Synchronize( procedure begin UpdateVt; end );

    phase.Destroy;
    unwrap.Destroy;
    amp.Destroy;
    base.Destroy;
    base_mask.Destroy;
    final_mask.Destroy;
    mask1.Destroy;
    mask2.Destroy;
    mean_unwrap.Destroy;
  end;
end;

procedure TProjectCalculationThread.init_masks;
var s: string;
    fill_mask: boolean;
    i, j, h, w, k, border: integer;
    pnt0, pnt1, pnt: tpoint;
    need_for_masks: boolean;

begin

  need_for_masks:= false;
  for i:=0 to pd_.Count-1 do
    for j:=0 to pd_[i].Count-1 do
      for k:=0 to length(pd_[i][j].what_to_calc)-1 do
        if pd_[i][j].what_to_calc[k] = calcUnwrap then
        begin
          need_for_masks:= true;
          break;
        end;

  for i:=0 to pd_.Count-1 do
    if pd_[i].doMean then
    begin
      need_for_masks:= true;
      break;
    end;

  if not need_for_masks then
    exit;

  w:= pd_.prop_.w;
  h:= pd_.prop_.h;
  border:= 10;

  final_mask.Clear;
  final_mask.Init(h, w, varByte);

  fill_mask:= false;
  if FileExists(string(pd_.prop_.file_path + pd_.mask1)) then
  begin
    LoadBin(mask1, varByte, string(pd_.prop_.file_path + pd_.mask1));
    fill_mask:= not CheckMask(mask1, @pnt0);

    if not fill_mask then
      for i:=0 to w*h-1 do
        if mask1.b^[i] = 1 then
          final_mask.b^[i]:=1;
  end
  else
    fill_mask:= true;

  if fill_mask then
  begin
    mask1.Clear;
    mask1.Init(h, w, varByte);

    for i:=border to h-border-1 do
      for j:=border to w-border-1 do
        mask1.b^[i*w+j]:=1;

    Origin01.x:= w div 2;
    Origin01.y:= h div 2;
  end
  else
  begin
    if mask1.b^[Origin01.y*w + Origin01.x] = 0 then
    begin
      if mask1.b^[pnt0.y*w + pnt0.x] = 1 then
        Origin01:= pnt0
      else
        raise Exception.Create('Точка начала сшивки вне области маски 1');
    end;
  end;

  if doBase then
  begin
    for i:=0 to w*h-1 do
      if base_mask.b^[i] = 0 then
        mask1.b^[i]:= 0;

    if mask1.b^[Origin01.y*w + Origin01.x] = 0 then
      raise Exception.Create('Точка начала сшивки вне области маски 1');
  end;

  fill_mask:= false;

  if FileExists(string(pd_.prop_.file_path + pd_.mask2)) then
  begin
    LoadBin(mask2, varByte, string(pd_.prop_.file_path + pd_.mask2));
    fill_mask:= not CheckMask(mask2, @pnt1);

    if not fill_mask then
      for i:=0 to w*h-1 do
        if mask2.b^[i] = 1 then
          final_mask.b^[i]:=1;
  end
  else
    fill_mask:= true;

  if fill_mask then
  begin
    mask2.Clear;
    mask2.Init(h, w, varByte);

    for i:=border to h-border-1 do
      for j:=border to w-border-1 do
        mask2.b^[i*w+j]:=1;

    Origin02.x:= w div 2;
    Origin02.y:= h div 2;
  end
  else
    if mask2.b^[Origin02.y*w + Origin02.x] = 0 then
    begin
      if mask2.b^[pnt1.y*w + pnt1.x] = 1 then
        Origin02:= pnt1
      else
        raise Exception.Create('Точка начала сшивки вне области маски 2');
    end;

  if doBase then
  begin
    for i:=0 to w*h-1 do
      if base_mask.b^[i] = 0 then
        mask2.b^[i]:= 0;

    if mask2.b^[Origin02.y*w + Origin02.x] = 0 then
      raise Exception.Create('Точка начала сшивки вне области маски 2');
  end;

  if not CheckMask(final_mask, @pnt) then
  begin
    for i:=border to h-border-1 do
      for j:=border to w-border-1 do
        final_mask.b^[i*w+j]:=1;

    Origin.x:= w div 2;
    Origin.y:= h div 2;
  end
  else
    if final_mask.b^[Origin.y*w + Origin.x] = 0 then
    begin
      if final_mask.b^[pnt.y*w + pnt.x] = 1 then
        Origin:= pnt
      else
        raise Exception.Create('Точка начала сшивки вне области общей маски!');
    end;

  if doBase then
  begin
    for i:=0 to w*h-1 do
      if base_mask.b^[i] = 0 then
        final_mask.b^[i]:= 0;

    if final_mask.b^[Origin.y*w + Origin.x] = 0 then
      raise Exception.Create('Точка начала сшивки вне области общей маски!');
  end;

end;

function TProjectCalculationThread.need_to_load_base: boolean;
var i,j,k: integer;
begin

  Result:= false;
  for i:=0 to pd_.Count-1 do
    if pd_[i].doMean and cfg.base and FileExists(cfg.base_path) then
    begin
      LoadBin(base, base_mask, cfg.base_path);
      if (base.w = pd_.prop_.w) and (base.h = pd_.prop_.h) then
        Result:= true;
      exit;
    end;

  for i:=0 to pd_.Count-1 do
    for j:=0 to pd_[i].Count-1 do
      for k:=0 to length(pd_[i][j].what_to_calc)-1 do
        if (pd_[i][j].what_to_calc[k] = calcUnwrap) and cfg.base and FileExists(cfg.base_path) then
        begin
          LoadBin(base, base_mask, cfg.base_path);
          if (base.w = pd_.prop_.w) and (base.h = pd_.prop_.h) then
            Result:= true;
          exit;
        end;



end;

procedure StartCalculationThread(pd: TProjectData);
begin
  ProjectCalculationThread:= TProjectCalculationThread.Create(true);
  ProjectCalculationThread.pd_:= pd;
  ProjectCalculationThread.FreeOnTerminate:= true;
  ProjectCalculationThread.Start;
end;

end.
