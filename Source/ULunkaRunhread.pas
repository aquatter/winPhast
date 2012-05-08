unit ULunkaRunhread;

interface

uses
  Classes, crude, utype;

type
  TLunkaRunhread = class(TThread)
  public
    _exp, mm, num_seq, curr_seq: integer;
    w, h, steps: integer;
    s: string;
    temp: TPointerArray;
    n_arr: array of treal;
    n_mean, n_rms: treal;
  protected
    procedure Execute; override;
    procedure Draw;
    procedure OneLunka;
    procedure SeqLunka;
  end;

procedure LunkaThread_start(_exp: integer);
function N_vozd(lambda, p, t, f: treal): treal;
function nabs2nt(lambda, t, p, f, nabs, babs: treal): treal;
function nt2nabs(lambda, t, p, f, nt, babs: treal): treal;
procedure RaschetPokazatelia;

var LunkaRunhread: TLunkaRunhread;

implementation

uses unit1, UUnwrap, SysUtils, forms, windows, UPhast2Vars, URecSeqThreadForm,
dialogs, t666, unit2, ufiltr, UTLunkaRunForm, ULunkaSeqRunForm, ULunkaSeqResultsForm;

procedure TLunkaRunhread.Draw;
begin
  case mm of
    0: pnl.DrawImage(phase, final_mask);
    1: pnl.DrawImage(unwrap, final_mask);
    2: begin
         LunkaRunForm.Close;
         form1.Off(true);
       end;
    3: ShowMessage('Файл '+s+' не найден!');
    4: begin
         LunkaSeqRunForm.Label1.Caption:='Вычисляется референтная лунка';
         LunkaSeqRunForm.Label2.Caption:=inttostr(curr_seq)+'/'+inttostr(num_seq);
       end;
    5: begin
         LunkaSeqRunForm.Label1.Caption:='Вычисляется измерительная лунка';
         LunkaSeqRunForm.Label2.Caption:=inttostr(curr_seq)+'/'+inttostr(num_seq);
       end;
    6: begin
         LunkaSeqRunForm.Label1.Caption:='Вычисляется показатель преломления';
         LunkaSeqRunForm.Label2.Caption:='';
       end;
    7: begin
         LunkaSeqRunForm.Close;
         form1.Off(true);
       end;
    8: LunkaSeqResultsForm.Memo1.Lines.Add(FloatToStrF(n_vol, ffFixed, 8, 6));
    9: begin
         LunkaSeqResultsForm.Memo1.Lines.Add('');
         LunkaSeqResultsForm.Memo1.Lines.Add('---');
         LunkaSeqResultsForm.Memo1.Lines.Add('Результат: '+ FloatToStrF(n_mean, ffFixed, 8, 6)+' '+
         #177+' '+FloatToStrF(n_rms, ffFixed, 8, 6));
       end;

  end;
end;

procedure TLunkaRunhread.Execute;
var i,j: integer;
begin
  w:=cfg.cam_w;
  h:=cfg.cam_h;
  steps:=cfg.steps;

  phase.Clear;
  phase.Init(h, w, varDouble);
  unwrap.Clear;
  unwrap.Init(h, w, varDouble);
  final_mask.Clear;
  final_mask.Init(h, w, varByte);
  final_phase.Clear;
  final_phase.Init(h, w, varDouble);

  for i:=10 to h-11 do
    for j:=10 to w-11 do
      final_mask.b^[i*w+j]:=1;

  SetLength(temp, steps);
  for i:=0 to steps-1 do
    GetMem(temp[i], w*h);

  if cfg.do_seq then
  begin
    num_seq:=cfg.num_seq;
    SeqLunka;
  end
  else
    OneLunka;



  for i:=0 to steps-1 do
    FreeMem(temp[i], w*h);
  Finalize(temp);
end;

procedure TLunkaRunhread.OneLunka;
var  _base, base_mask: TMyInfernalType;
     i,j: integer;
     a, b, c: treal;
begin
  try
    for i:=0 to steps-1 do
    begin
      case from of
        fromCamera: s:=format(cfg.img_path+'\cadr_i%d_s%d_c%d.bmp',[1, i+1, 1]);
        fromHDD: s:=Form2.ListView2.Items[i].SubItems[1];
      end;
      if not FileExists(s) then
        raise EAbort.Create('');

      LoadBmp(temp[i]^, w, h, s);
    end;

    FindPhase(phase, final_mask, temp, steps);
    mm:=0;
    Synchronize(draw);

    UnWrapPhaseSt(Origin.x, Origin.y, w, h, phase.a^, unwrap.a^, final_mask.b^);

    if cfg.invert then
      for i:=0 to w*h-1 do
        unwrap.a^[i]:=-unwrap.a^[i];

    if cfg.base and FileExists(ExtractFilePath(Application.ExeName)+'base.bin') then
    begin
      _base:=TMyInfernalType.Create;
      base_mask:=TMyInfernalType.Create;
      LoadBin(_base, base_mask, ExtractFilePath(Application.ExeName)+'base.bin');
      for i:=0 to w*h-1 do
      begin
        if base_mask.b^[i] = 1 then
          unwrap.a^[i]:=unwrap.a^[i]-_base.a^[i]
        else
        begin
          final_mask.b^[i]:=0;
          mask_outer.b^[i]:=0;
        end;
      end;
      _base.Destroy;
      base_mask.Destroy;
    end;

    for i:=0 to w*h-1 do
      unwrap.a^[i]:=unwrap.a^[i]*cfg.lambda/(4*Pi);


    if cfg.tilt then
    begin
      TiltRemove(unwrap.a^, mask_outer.b^, final_mask.b^, h, w, a, b, c);
      case _exp of
        1: begin
             tilt1.Clear;
             tilt1.Init(h, w, varDouble);
             for i:=0 to h-1 do
               for j:=0 to w-1 do
                 tilt1.a^[i*w+j]:=a*i+b*j+c;
           end;
        2: begin
             tilt2.Clear;
             tilt2.Init(h, w, varDouble);
             for i:=0 to h-1 do
               for j:=0 to w-1 do
                 tilt2.a^[i*w+j]:=a*i+b*j+c;
           end;
      end;
    end;

    mm:=1;
    Synchronize(draw);

    if cfg.do_filtr then
    begin
      RAFilterGaussianMaskOutBad(w, h, round(cfg.gauss_aper), cfg.gauss_aper/2, unwrap.a^, unwrap.a^, final_mask.b^);
      Synchronize(draw);
    end;

    CopyMemory(final_phase.a, unwrap.a, w*h*sizeof(treal));
    case _exp of
      1: phase_exp1.InitByArray(unwrap);
      2: phase_exp2.InitByArray(unwrap);
    end;

  except
    on EAbort do
    begin
      mm:=3;
      Synchronize(draw);
    end;
  end;

  CurrentMatrix:=cmUnwrap;
  mm:=2;
  Synchronize(draw);
end;

procedure TLunkaRunhread.SeqLunka;
var _base, base_mask: TMyInfernalType;
    i,l,k,j: integer;
    base_loaded: boolean;
    temp_mask: TMyInfernalType;
begin
  SetLength(n_arr, num_seq);
  base_loaded:=false;
  if cfg.base and FileExists(ExtractFilePath(Application.ExeName)+'base.bin') then
  begin
    _base:=TMyInfernalType.Create;
    base_mask:=TMyInfernalType.Create;
    LoadBin(_base, base_mask, ExtractFilePath(Application.ExeName)+'base.bin');
    base_loaded:=true;
  end;

  try
    for l:=0 to num_seq-1 do
    begin
      curr_seq:=l+1;
      phase_exp1.Clear;
      phase_exp2.Clear;

      ZeroMemory(final_mask.b, w*h);
      for i:=10 to h-11 do
        for j:=10 to w-11 do
          final_mask.b^[i*w+j]:=1;

      for k:=0 to 1 do
      begin
        if k=0 then
        begin
          mm:=4;
          Synchronize(draw);
        end
        else
        begin
          mm:=5;
          Synchronize(draw);
        end;

        for i:=0 to steps-1 do
        begin
          if k=0 then
            s:=format(cfg.img_path+'\cadr_i%d_s%d_c%d.bmp',[1, i+1, l+1])
          else
            s:=format(cfg.img_path_izm+'\cadr_i%d_s%d_c%d.bmp',[1, i+1, l+1]);

          if not FileExists(s) then
            raise EAbort.Create('');

          LoadBmp(temp[i]^, w, h, s);
        end;

        FindPhase(phase, final_mask, temp, steps);
        mm:=0;
        Synchronize(draw);

        UnWrapPhaseSt(Origin.x, Origin.y, w, h, phase.a^, unwrap.a^, final_mask.b^);

        if cfg.invert then
          for i:=0 to w*h-1 do
            unwrap.a^[i]:=-unwrap.a^[i];

        if base_loaded then
          for i:=0 to w*h-1 do
            unwrap.a^[i]:=unwrap.a^[i]-_base.a^[i];

        for i:=0 to w*h-1 do
          unwrap.a^[i]:=unwrap.a^[i]*cfg.lambda/(4*Pi);

        if cfg.tilt then
          TiltRemove(unwrap.a^, mask_outer.b^, final_mask.b^, h, w);

        mm:=1;
        Synchronize(draw);

        if cfg.do_filtr then
        begin
          RAFilterGaussianMaskOutBad(w, h, round(cfg.gauss_aper), cfg.gauss_aper/2, unwrap.a^, unwrap.a^, final_mask.b^);
          Synchronize(draw);
        end;

        case k of
          0: phase_exp1.InitByArray(unwrap);
          1: phase_exp2.InitByArray(unwrap);
        end;
      end;

      mm:=6;
      Synchronize(draw);
      RaschetPokazatelia;
      n_arr[l]:=n_vol;
      mm:=8;
      Synchronize(draw);
    end;

  except
    on EAbort do
    begin
      mm:=3;
      Synchronize(draw);
    end;
  end;

  if base_loaded then
  begin
    _base.Destroy;
    base_mask.Destroy;
  end;

  n_mean:=0;
  n_rms:=0;
  if num_seq > 0 then
  begin
    for i:=0 to num_seq - 1 do
      n_mean:=n_mean+n_arr[i];
    n_mean:=n_mean/num_seq;
  end;
  if num_seq > 1 then
  begin
    for i:=0 to num_seq-1 do
      n_rms:=n_rms+sqr(n_arr[i]-n_mean);
    n_rms:=sqrt(n_rms/(num_seq*(num_seq-1)));
  end;

  mm:=9;
  Synchronize(draw);

  Finalize(n_arr);
  mm:=7;
  Synchronize(draw);
end;

procedure LunkaThread_start(_exp: integer);
var w,h,i,j,cnt: integer;
begin



  w:=cfg.cam_w;
  h:=cfg.cam_h;

  origin.x:=w div 2;
  origin.y:=h div 2;

{  cnt:=0;
  for i:=0 to w*h-1 do
    cnt:=cnt+mask_inner.b^[i];

  if cnt=0 then
    for i:=10 to h-9 do
      for j:=10 to w-9 do
        mask_inner.b^[i*w+j]:=1;  }

  {if (mask_inner.b^[Origin.y*w+Origin.x] = 0) then
  begin
    ShowMessage('Точка начала сшивки вне области выделения!');
    exit;
  end;}
  form1.Off(false);
  if _exp <> 0  then
  begin
    if not int.loaded then
      exit;
    LunkaRunForm.Show;
  end
  else
  begin
    LunkaSeqRunForm.Show;
    LunkaSeqResultsForm.Memo1.Clear;
    LunkaSeqResultsForm.Show;
  end;

  LunkaRunhread:=TLunkaRunhread.Create(true);
  LunkaRunhread.FreeOnTerminate:=true;
  LunkaRunhread._exp:=_exp;
  LunkaRunhread.Resume;
end;

function N_vozd(lambda, p, t, f: treal): treal;
var k0: treal;
begin
  k0:=1/lambda;
  Result:=1e-8*((8342.13+2406030/(130-sqr(k0))+15997/(38.9-sqr(k0)))*p*((1+p*(6.13-0.1*t)*1e-6)/(1+0.003661*t))/96.0955-f*(42.92-0.343*sqr(k0)))+1;
end;

function nabs2nt(lambda, t, p, f, nabs, babs: treal): treal;
var N_lambda: treal;
begin
  N_lambda:=N_vozd(lambda, 101.325, 20, 1.33);
  Result:=N_lambda*(nabs+babs*(t-20)/N_lambda)/N_vozd(lambda, p, t, f);
end;

function nt2nabs(lambda, t, p, f, nt, babs: treal): treal;
var N_lambda: treal;
begin
//  N_lambda:=N_vozd(lambda, 101.325, 20, 1.33);
  Result:=(nt{*N_vozd(lambda, p, t, f)}-babs*(t-20)){/N_lambda};
end;


procedure RaschetPokazatelia;
var min1, min2: treal;
    origin1, origin2, dr: tpoint;
    i, j, w, h, di, dj: integer;
    buf: PRealArray;
    mask1: TMyInfernalType;
    n_ref_t: treal;
begin
  w:=phase_exp1.w;
  h:=phase_exp1.h;
  mask1:=TMyInfernalType.Create;
  mask1.Init(h, w, varByte);

  min1:=MaxInt;
  min2:=MaxInt;
  for i:=0 to h-1 do
    for j:=0 to w-1 do
      begin
        if min1 > phase_exp1.a^[i*w+j] then
        begin
          min1:=phase_exp1.a^[i*w+j];
          origin1.x:=j;
          origin1.y:=i;
        end;
        if min2 > phase_exp2.a^[i*w+j] then
        begin
          min2:=phase_exp2.a^[i*w+j];
          origin2.x:=j;
          origin2.y:=i;
        end;
      end;
  dr.x:=origin2.x-origin1.x;
  dr.y:=origin2.y-origin1.y;

  GetMem(buf, w*h*sizeof(treal));
  CopyMemory(buf, phase_exp2.a, w*h*sizeof(treal));

  for i:=10 to h-11 do
    for j:=10 to w-11 do
    begin
      di:=i+dr.y;
      dj:=j+dr.x;
      if (di >= 10) and (di < (h-10)) and (dj >= 10) and (dj < (w-11)) then
      begin
        phase_exp2.a^[i*w+j]:=buf^[di*w+dj];
        mask1.b^[i*w+j]:=1;
      end
    end;

  FreeMem(buf, w*h*sizeof(treal));

  for i:=0 to w*h-1 do
    mask1.b^[i]:=mask1.b^[i]*mask_outer.b^[i];

  TiltRemove(phase_exp1.a^, mask1.b^, final_mask.b^, h, w);
  TiltRemove(phase_exp2.a^, mask1.b^, final_mask.b^, h, w);
//  CreateBin(phase_exp1, mask1, 'phase_exp1_.bin');
//  CreateBin(phase_exp2, mask1, 'phase_exp2_.bin');


  Grad(phase_exp1);
  Grad(phase_exp2);

  vol1:=0;
  vol2:=0;

  for i:=0 to w*h-1 do
    if mask_inner.b^[i] =  1 then
    begin
      vol1:=vol1+phase_exp1.a^[i];
      vol2:=vol2+phase_exp2.a^[i];
    end;
//  CreateBin(mask_outer, 'mask_outer.bin');
//  CreateBin(mask_inner, 'mask_inner.bin');
//  CreateBin(phase_exp1, mask_inner, 'phase_exp1.bin');
//  CreateBin(phase_exp2, mask_inner, 'phase_exp2.bin');

  n_ref_t:=N_vozd(cfg.lambda*1e-3, cfg._p, cfg._t, cfg._f);
  n_vol:=nt2nabs(cfg.lambda*1e-3, cfg._t, cfg._p, cfg._f, n_ref_t*vol2/vol1, cfg.b_rab);
end;

end.
