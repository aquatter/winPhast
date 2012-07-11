unit UDirectShowCaptureThread;

interface

uses
  Classes, t666;

type
  TDirectShowCaptureThread = class(TThread)
  public
    WaitEvent: THandle;
    class var DataReady: THandle;
    _step, seq, step, num_seq, num_mean: integer;
    buff_mean: TMyInfernalType;
    cancel: boolean;
  protected
    procedure Execute; override;
    procedure Draw;
    procedure Draw2;
    procedure Draw3;
  end;

var
  DirectShowCaptureThread: TDirectShowCaptureThread;

implementation

uses UPhast2Vars, windows, unit10, sysutils, crude, VidCap, utype, unit1,
  UProjectData, Uvt, UPTree, Dialogs;

procedure TDirectShowCaptureThread.Draw;
begin
  form10.ProgressBar1.Position:=step;
  form10.Label1.Caption:='Шаг '+IntToStr(step)+' из '+IntToStr(cfg.steps);
  form10.Label2.Caption:='Серия '+IntToStr(seq)+' из '+IntToStr(num_seq);
end;

procedure TDirectShowCaptureThread.Draw2;
begin
  VidCap1.Pause;
  VidCap1.VideoRect:=Rect(0, 0, 0, 0);
  form10.Close;
  form1.off(true);
  CurrentMatrix:=cmInt;
  from:=fromCamera;
  SaveProject(ProjectData);
  UpdateVt;

//  form1.InitialiseArrays;
end;

procedure TDirectShowCaptureThread.Draw3;
begin
  VidCap1.Pause;
  VidCap1.VideoRect:=Rect(0, 0, 0, 0);
  form10.Close;
  form1.off(true);
  CurrentMatrix:=cmInt;
  pnl.Repaint;
end;

procedure TDirectShowCaptureThread.Execute;
var i, l, j, k, w, h, q: integer;
    p: PByteArray;
    rec_: TRec;
    seq_: TSeq;
begin
  WaitEvent:=CreateEvent(nil, true, false, nil);
//  DataReady:=CreateEvent(nil, true, false, nil);

  cancel:=false;

  if cfg.do_seq then
    num_seq:=cfg.num_seq
  else
    num_seq:=1;

  if cfg.do_mean then
    num_mean:=cfg.num_mean
  else
    num_mean:=1;


  if cfg.Fizo then
  begin
    num_mean:=cfg.steps;
    Synchronize(procedure
                begin
                  form10.ProgressBar1.Visible:=false;
                  form10.Label1.Visible:=false;
                end );
  end;


  w:=cfg.cam_w;
  h:=cfg.cam_h;

  buff_mean:=TMyInfernalType.Create;
  buff_mean.Init(h, w, varDouble);

  VidCap1.CB.SetCaptureParams(num_mean, cfg.cam_w, cfg.cam_h);

  for l:=0 to num_seq-1 do
  begin
    seq_:= ProjectData.Add;
    rec_:= seq_.Add;

    for q:=0 to ProjectData.prop_.how_many_wavelengths-1 do
    begin

    if cfg.Fizo then
    begin
      seq:=l+1;
      Synchronize(Draw);

      VidCap1.CB.start;
      WaitForSingleObject(DataReady, 5000);
      ResetEvent(DataReady);

      for i:=0 to num_mean-1 do
      begin
        p:=VidCap1.CB.Frames[i].Buf;

        for k:=0 to w*h-1 do
          buff_mean.a^[k]:=p^[3*k];

        if q = 0 then
        begin
          CreateBmp(buff_mean, false,  string(ProjectData.prop_.file_path) + 'cadr_i1_s'+IntToStr(i+1)+'_c'+IntToStr(l+1)+'.bmp');
          rec_.img.Add(AnsiString('cadr_i1_s'+IntToStr(i+1)+'_c'+IntToStr(l+1)+'.bmp'));
        end
        else
        begin
          CreateBmp(buff_mean, false,  string(ProjectData.prop_.file_path) + 'cadr2_i1_s'+IntToStr(i+1)+'_c'+IntToStr(l+1)+'.bmp');
          rec_.img2.Add(AnsiString('cadr2_i1_s'+IntToStr(i+1)+'_c'+IntToStr(l+1)+'.bmp'));
        end;
      end;

      WaitForSingleObject(WaitEvent, cfg.SeriesPause);
      break;
    end;

    for i:=0 to cfg.steps-1 do
    begin

      if cancel then break;
      step:=i+1;
      seq:=l+1;
      Synchronize(Draw);


      if ProjectData.prop_.how_many_wavelengths = 1 then
        _step:=round(i*cfg.Shifts[cfg.LazerNum]/(cfg.steps-1))
      else
       _step:=round(i*cfg.Shifts[q+1]/(cfg.steps-1));

//      _step:=round(i*cfg.m_shift/(cfg.steps-1));

      if cfg.Com_phase_shift then
        form1.MoveMirrorCom(_step)
      else
        MoveMirror(cfg.port, _step);

      WaitForSingleObject(WaitEvent, 500);

      ZeroMemory(buff_mean.a, w*h*sizeof(treal));

      VidCap1.CB.start;
      WaitForSingleObject(DataReady, 5000);
      ResetEvent(DataReady);

      for j:=0 to num_mean-1 do
      begin
        p:=VidCap1.CB.Frames[j].Buf;

       for k:=0 to w*h-1 do
         buff_mean.a^[k]:=buff_mean.a^[k]+p^[3*k];
      end;

      for k:=0 to w*h-1 do
        buff_mean.a^[k]:=buff_mean.a^[k]/num_mean;

      if q = 0 then
      begin
        CreateBmp(buff_mean, false,  string(ProjectData.prop_.file_path) + 'cadr_i1_s'+IntToStr(i+1)+'_c'+IntToStr(l+1)+'.bmp');
        rec_.img.Add(AnsiString('cadr_i1_s'+IntToStr(i+1)+'_c'+IntToStr(l+1)+'.bmp'));
      end
      else
      begin
        CreateBmp(buff_mean, false,  string(ProjectData.prop_.file_path) + 'cadr2_i1_s'+IntToStr(i+1)+'_c'+IntToStr(l+1)+'.bmp');
        rec_.img2.Add(AnsiString('cadr2_i1_s'+IntToStr(i+1)+'_c'+IntToStr(l+1)+'.bmp'));
      end;
      if cancel then break;
    end;

    if ProjectData.prop_.how_many_wavelengths = 2 then
    begin
      if q = 0 then
        Form1.write_to_com(0, 32)
      else
        Form1.write_to_com(0, 64);

      Synchronize(procedure begin ShowMessage('Смена лазера. Подождите...'); end);
    end;
    end;
  end;

  if cancel then
    Synchronize(Draw3)
  else
    Synchronize(Draw2);

  VidCap1.CB.ClearCaptureParams;
  CloseHandle(WaitEvent);
//  CloseHandle(DataReady);
  buff_mean.Destroy;

  if cfg.Fizo then
    Synchronize(procedure
                var p: array[0..2] of byte;
                begin
                  p[0]:=0;
                  p[1]:=16;
                  p[2]:=15;
                  Form1.CommPortDriver1.SendData(@(p), 3);
                end );
end;

initialization
  TDirectShowCaptureThread.DataReady:=CreateEvent(nil, true, false, nil);

finalization
  CloseHandle(TDirectShowCaptureThread.DataReady);


end.
