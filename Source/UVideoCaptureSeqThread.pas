unit UVideoCaptureSeqThread;

interface

uses
  Classes, windows, t666;

type
  TVideoCaptureMode = (cmVideo, cmCapture);
  TVideoCaptureSeqThread = class(TThread)
  private
    InDInterface, InputControlInterface: UINT;
    num_seq, num_mean, w, h, steps, step, seq: integer;
    buff_mean: TMyInfernalType;
    capture_OK: boolean;
    _step: integer;
    WaitEvent: THandle;
    dataready: THandle;
  protected
    procedure Execute; override;
    procedure VideoMode;
    procedure CaptureMode;
    procedure Draw;
    procedure Draw_final;
  end;

  TTestThread = class(TThread)
  public
    WaitEvent: THandle;
    _step, seq, step, num_seq, num_mean: integer;
    buff_mean: TMyInfernalType;
    cancel: boolean;
    mm: integer;
  protected
    procedure Draw;
    procedure Draw2;
    procedure Draw3;
    procedure Execute; override;
  end;

var VideoCaptureSeqThread: TVideoCaptureSeqThread;
    VideoCaptureMode: TVideoCaptureMode;
    TestThread: TTestThread;

implementation

uses unit1, VideoScan, unit9, crude, utype, sysutils, unit10, UPhast2Vars,
     Controls, panel1, UWatchComThread, UProjectData, Uvt, UPTree, Dialogs;

procedure TVideoCaptureSeqThread.CaptureMode;
var i, j, k, l: integer;
    ReadySize, TransferSize: VS_SIZE_T;
    err: VS_ERROR_DATA;
    rec_: TRec;
    seq_: TSeq;
begin


  for l:=0 to num_seq-1 do
  begin
    seq_:= ProjectData.Add;
    rec_:= seq_.Add;

    for i:=0 to steps-1 do
    begin
      _step:=round(i*cfg.m_shift/(steps-1));
      MoveMirror(cfg.port, _step);
      WaitForSingleObject(WaitEvent, 1000);
//      sleep(1000);

      ZeroMemory(buff_mean.a, w*h*sizeof(treal));

      for j:=0 to num_mean-1 do
      begin
        ReadySize:=0;
        while ReadySize=0 do
        begin
          VsLib3InDInterfaceQueryReady(InDInterface, @ReadySize, @err);
          WaitForSingleObject(WaitEvent, 10);
//          Sleep(10);
        end;

        ZeroMemory(buff.b, w*h);
        VsLib3InDInterfaceBeginBlock(InDInterface, @err);
        VsLib3InDInterfacePIOTransfer(InDInterface, buff.b, w*h, @TransferSize, @err);
        VsLib3InDInterfaceEndBlock(InDInterface, @err);

        for k:=0 to w*h-1 do
          buff_mean.a^[k]:=buff_mean.a^[k]+buff.b^[k];
      end;

      for k:=0 to w*h-1 do
        buff_mean.a^[k]:=buff_mean.a^[k]/num_mean;


      rec_.img.Add(AnsiString('cadr_i1_s'+IntToStr(i+1)+'_c'+IntToStr(l+1)+'.bmp'));
      CreateBmp(buff_mean, false,  string(ProjectData.prop_.file_path) + '\cadr_i1_s'+IntToStr(i+1)+'_c'+IntToStr(l+1)+'.bmp');
      step:=i+1;
      seq:=l+1;
      Synchronize(Draw);
    end;


  end;
  capture_OK:=true;
  Terminate;
end;

procedure TVideoCaptureSeqThread.Draw;
var shift: TShiftState;
    i, j: integer;
    pb: PByteArray;
    mode: TDrawMode;
begin
//  pnl.bitmap.Width:=w;
//  pnl.bitmap.Height:=h;
//  for i:=0 to h-1 do
//  begin
//    pb:=pnl.bitmap.ScanLine[i];
//    for j:=0 to w-1 do
//      pb^[j]:=buff.b^[i*w+j];
//  end;
//  pnl.NullPaint;

  pnl.DrawImage(buff, buff);
  MakeHist(@(buff), @(form1.hist), @(form1.x_hist), point(0, 0), point(w-1, h-1));
  form1.PnlMouseDown(form1, mbLeft, shift, 0, 0);

  form9.UpdateHist;
  if VideoCaptureMode = cmCapture then
  begin
    form10.ProgressBar1.Position:=step;
    form10.Label1.Caption:='Шаг '+IntToStr(step)+' из '+IntToStr(steps);
//    form10.Label2.Caption:='Серия '+IntToStr(seq)+' из '+IntToStr(num_seq);
    form10.Label2.Caption:=IntToStr(_step);
  end;
//  form9.UpdateHist;
end;

procedure TVideoCaptureSeqThread.Draw_final;
begin
{  form10.Close;
  form1.vs.run:=false;
  form1.off(true);
//  pnl.DrawMode:=dmNone;
  form1.int.ColorScale:=noScale;
  if capture_OK then
  begin
    from:=fromCamera;
    form1.InitialiseArrays;
  end;}
end;

procedure TVideoCaptureSeqThread.Execute;
begin
  w:=form1.vs.SizeX;
  h:=form1.vs.SizeY;
  capture_OK:=false;


  InDInterface:=Form1.vs.InDInterface;
  InputControlInterface:=Form1.vs.InputControlInterface;
//  buff:=TMyInfernalType.Create;
  buff.clear;
  buff.Init(h, w, varByte);
//  buff_mean:=TMyInfernalType.Create;
//  buff_mean.Init(h, w, varDouble);
  buff.ColorScale:=noScale;
  step:=1;
  seq:=1;
  WaitEvent:=CreateEvent(nil, true, false, nil);
  dataready:=CreateEvent(nil, true, false, nil);

  if cfg.do_seq then
    num_seq:=cfg.num_seq
  else
    num_seq:=1;

  if cfg.do_mean then
    num_mean:=cfg.num_mean
  else
    num_mean:=1;

  while not Terminated do
  begin
    case VideoCaptureMode of
      cmVideo: VideoMode;
      cmCapture: begin
                   if cfg.do_seq then
                     num_seq:=cfg.num_seq
                   else
                     num_seq:=1;

                   if cfg.do_mean then
                     num_mean:=cfg.num_mean
                   else
                     num_mean:=1;
                   steps:=cfg.steps;

                   CaptureMode;
                 end;
    end;
  end;

  CloseHandle(WaitEvent);
  CloseHandle(dataready);

//  buff.Destroy;
//  buff_mean.Destroy;
  Synchronize(Draw_final);

end;




procedure TVideoCaptureSeqThread.VideoMode;
var ReadySize, TransferSize: VS_SIZE_T;
    err: VS_ERROR_DATA;
begin
  while true do
   begin
     if Terminated or (VideoCaptureMode <> cmVideo) then
       break;


     ReadySize:=0;
     VsLib3InDInterfaceQueryReady(InDInterface, @ReadySize, @err);
     WaitForSingleObject(WaitEvent, 10);
//     Sleep(1);
     if ReadySize = 0 then
       Continue;

     VsLib3InDInterfaceBeginBlock(InDInterface, @err);
     VsLib3InDInterfacePIOTransfer(InDInterface, buff.b, w*h, @TransferSize, @err);
     VsLib3InDInterfaceEndBlock(InDInterface, @err);
     SetEvent(dataready);

     Synchronize(Draw);
   end;
end;

{ TTestThread }

procedure TTestThread.Draw;
begin
  case mm of
    0: begin
         form10.Caption:='Запись интерферограмм';
         form10.ProgressBar1.Position:=step;
         form10.Label1.Caption:='Шаг '+IntToStr(step)+' из '+IntToStr(cfg.steps);
         form10.Label2.Caption:='Серия '+IntToStr(seq)+' из '+IntToStr(num_seq);
       end;
    1: form10.Caption:='Пауза';
  end;
end;

procedure TTestThread.Draw2;
begin
  VideoCaptureSeqThread.Terminate;
  form10.Close;
  form1.vs.run:=false;
  form1.off(true);
//  pnl.DrawMode:=dmNone;
//  form1.int.ColorScale:=noScale;
//  if cfg.ComMode then
//    WatchComThread.Resume;
  from:=fromCamera;

  SaveProject(ProjectData);
  UpdateVt;

//  form1.InitialiseArrays;
end;

procedure TTestThread.Draw3;
begin
  VideoCaptureSeqThread.Terminate;
  form10.Close;
  form1.vs.run:=false;
  form1.off(true);
  pnl.Repaint;
//  if cfg.ComMode then
//    WatchComThread.Resume;
end;

procedure TTestThread.Execute;
var i, l, j, k, w, h, q: integer;
    sm_step: integer;
    rec_: TRec;
    seq_: TSeq;
begin
  inherited;

   WaitEvent:=CreateEvent(nil, true, false, nil);
   cancel:=false;

   if cfg.do_seq then
     num_seq:=cfg.num_seq
   else
     num_seq:=1;

   if cfg.do_mean then
     num_mean:=cfg.num_mean
   else
     num_mean:=1;

  w:=form1.vs.SizeX;
  h:=form1.vs.SizeY;

  buff_mean:=TMyInfernalType.Create;
  buff_mean.Init(h, w, varDouble);

  if cfg.Com_Step_Motor then
    sm_step:=round(cfg.Step_Motor_Shift/(cfg.steps-1));

  for l:=0 to num_seq-1 do
  begin
    seq_:= ProjectData.Add;
    rec_:= seq_.Add;

    for q:=0 to ProjectData.prop_.how_many_wavelengths-1 do
    begin

    for i:=0 to cfg.steps-1 do
    begin
      if cancel then break;
      step:=i+1;
      seq:=l+1;
      mm:=0;
      Synchronize(Draw);

//      _step:=round(i*cfg.m_shift/(cfg.steps-1));

      if ProjectData.prop_.how_many_wavelengths = 1 then
        _step:=round(i*cfg.Shifts[cfg.LazerNum]/(cfg.steps-1))
      else
        _step:=round(i*cfg.Shifts[q+1]/(cfg.steps-1));

      if cfg.Com_phase_shift then
        form1.MoveMirrorCom(_step)
      else
      begin
        if cfg.Com_Step_Motor then
        begin
          if i=0 then
            form1.Move2Start
          else
            form1.Shift(sm_step, 50, true, true, true);
        end
        else
          MoveMirror(cfg.port, _step);
      end;

      {if i=0 then
      begin
        for j:=0 to 10 do
        begin
          WaitForSingleObject(VideoCaptureSeqThread.dataready, 5000);
          ResetEvent(VideoCaptureSeqThread.dataready);
        end;
      end
      else
        for j:=0 to cfg.num_skip-1 do
        begin
          WaitForSingleObject(VideoCaptureSeqThread.dataready, 5000);
          ResetEvent(VideoCaptureSeqThread.dataready);
        end;}

//      sleep(5000);


      WaitForSingleObject(WaitEvent, cfg.PhaseShiftPause);

      ZeroMemory(buff_mean.a, w*h*sizeof(treal));
      for j:=0 to num_mean-1 do
      begin
       WaitForSingleObject(VideoCaptureSeqThread.dataready, 5000);
       ResetEvent(VideoCaptureSeqThread.dataready);
       for k:=0 to w*h-1 do
         buff_mean.a^[k]:=buff_mean.a^[k]+buff.b^[k];
      end;

      for k:=0 to w*h-1 do
        buff_mean.a^[k]:=buff_mean.a^[k]/num_mean;

      if q = 0 then
      begin
        rec_.img.Add( AnsiString('cadr_i1_s'+IntToStr(i+1)+'_c'+IntToStr(l+1)+'.bmp') );
        CreateBmp(buff_mean, false,  string(ProjectData.prop_.file_path) + 'cadr_i1_s'+IntToStr(i+1)+'_c'+IntToStr(l+1)+'.bmp');
      end
      else
      begin
        rec_.img2.Add( AnsiString('cadr2_i1_s'+IntToStr(i+1)+'_c'+IntToStr(l+1)+'.bmp') );
        CreateBmp(buff_mean, false,  string(ProjectData.prop_.file_path) + 'cadr2_i1_s'+IntToStr(i+1)+'_c'+IntToStr(l+1)+'.bmp');
      end;
      if cancel then break;
    end;

    if ProjectData.prop_.how_many_wavelengths = 2 then
    begin
      if q = 0 then
        Form1.write_to_com(0, 32)
      else
        Form1.write_to_com(0, 64);

//      form1.write_to_com(0, 32);
      Synchronize(procedure begin ShowMessage('Смена лазера. Подождите...'); end);

      {for i:=0 to cfg.steps-1 do
      begin
        if cancel then break;
        step:=i+1;
        seq:=l+1;
        mm:=0;
        Synchronize(Draw);

        _step:=round(i*cfg.m_shift/(cfg.steps-1));
        if cfg.Com_phase_shift then
          form1.MoveMirrorCom(_step)
        else
          MoveMirror(cfg.port, _step);

        WaitForSingleObject(WaitEvent, cfg.PhaseShiftPause);

        ZeroMemory(buff_mean.a, w*h*sizeof(treal));
        for j:=0 to num_mean-1 do
        begin
          WaitForSingleObject(VideoCaptureSeqThread.dataready, 5000);
          ResetEvent(VideoCaptureSeqThread.dataready);
          for k:=0 to w*h-1 do
            buff_mean.a^[k]:=buff_mean.a^[k]+buff.b^[k];
        end;

        for k:=0 to w*h-1 do
          buff_mean.a^[k]:=buff_mean.a^[k]/num_mean;


        rec_.img2.Add( AnsiString('cadr2_i1_s'+IntToStr(i+1)+'_c'+IntToStr(l+1)+'.bmp') );
        CreateBmp(buff_mean, false,  string(ProjectData.prop_.file_path) + 'cadr2_i1_s'+IntToStr(i+1)+'_c'+IntToStr(l+1)+'.bmp');
        if cancel then break;
      end;

      form1.write_to_com(0, 64);
      Synchronize(procedure begin ShowMessage('Смена лазера. Подождите...'); end);}
    end;

    end;
    mm:=1;
    Synchronize(Draw);
    WaitForSingleObject(WaitEvent, cfg.SeriesPause);
  end;

  if cfg.Com_Step_Motor then
    form1.Move2Start;

  CloseHandle(WaitEvent);
  buff_mean.Destroy;
  if cancel then
    Synchronize(Draw3)
  else
    Synchronize(Draw2);
end;

end.
