unit UWinPhast_INI;

interface

uses IniFiles, UPhast2Vars, SysUtils, forms;

procedure ReadINI(var p: TConfig; path: string);
procedure WriteINI(var p: TConfig; path: string);
function CheckString(s: string): double;

implementation


function CheckString(s: string): double;
var i: integer;
begin
  for i:=1 to length(s) do
    case s[i] of
      '.', ',': s[i]:=DecimalSeparator;
    end;
  Result:=StrToFloat(s);
end;


procedure ReadINI(var p: TConfig; path: string);
var f: TIniFile;
    s: string;
begin
  f:=TIniFile.Create(path);
  try
    s:=f.ReadString('Microscope', 'fow_width', '100');
    p.w1:=CheckString(s);
    s:=f.ReadString('Microscope', 'fow_height', '100');
    p.h1:=CheckString(s);
    s:=f.ReadString('Microscope', 'lambda', '437');
    p.lambda:=CheckString(s);
    p.steps:=f.ReadInteger('Microscope', 'Steps', 9);
    p.port:=f.ReadInteger('Microscope', 'LPT_Port', $378);
    p.cam_w:=f.ReadInteger('Microscope', 'cam_w', 1392);
    p.cam_h:=f.ReadInteger('Microscope', 'cam_h', 1040);
    p.amp:=f.ReadInteger('Microscope', 'amp', 0);
    p.expos:=f.ReadInteger('Microscope', 'expos', 0);
    p.m_shift:=f.ReadInteger('Microscope', 'm_shift', 0);
    p.Step_Motor_Shift:=f.ReadInteger('Microscope', 'Step_Motor_Shift', 0);
    p.CameraType:=f.ReadString('Microscope', 'CameraType', 'VideoScan');
    p.DeviceNum:=f.ReadInteger('Microscope', 'DeviceNum', 0);
    p.LazerNum:=f.ReadInteger('Microscope', 'LazerNum', 1);
    p.LazerPos[0]:=f.ReadInteger('Microscope', 'Lazer0Pos', 16);
    p.LazerPos[1]:=f.ReadInteger('Microscope', 'Lazer1Pos', 31);
    p.LazerPos[2]:=f.ReadInteger('Microscope', 'Lazer2Pos', 45);
    s:=f.ReadString('Microscope', 'Lazer0Lambda', '10');
    p.LazerLambda[0]:=CheckString(s);
    s:=f.ReadString('Microscope', 'Lazer1Lambda', '20');
    p.LazerLambda[1]:=CheckString(s);
    s:=f.ReadString('Microscope', 'Lazer2Lambda', '30');
    p.LazerLambda[2]:=CheckString(s);
    p.ComPort:=f.ReadInteger('Microscope', 'ComPort', 3);
    p.Shifts[0]:=f.ReadInteger('Microscope', 'Shift0', 0);
    p.Shifts[1]:=f.ReadInteger('Microscope', 'Shift1', 0);
    p.Shifts[2]:=f.ReadInteger('Microscope', 'Shift2', 0);
    p.ComMode:=f.ReadBool('Microscope', 'ComMode', false);
    p.Com_phase_shift:=f.ReadBool('Microscope', 'ComShift', false);
    p.Com_Step_Motor:=f.ReadBool('Microscope', 'Com_Step_Motor', false);
    s:=f.ReadString('Microscope', 'N_photo', '2');
    p.n_photo:=CheckString(s);

    p.q:=f.ReadInteger('3D', 'Quality', 1);
    p.pal:=f.ReadInteger('3D', 'Pallete', 1);
    s:=f.ReadString('3D', 'Scale_Z', '1');
    p.z:=CheckString(s);

    p.tilt:=f.ReadBool('Algorithm', 'Do_Tilt', true);
    p.base:=f.ReadBool('Algorithm', 'Do_Base', true);
    p.invert:=f.ReadBool('Algorithm', 'Do_Invert', true);
    p.do_seq:=f.ReadBool('Algorithm', 'Do_Seq', true);
    p.do_mean:=f.ReadBool('Algorithm', 'Do_Mean', true);
    p.do_filtr:=f.ReadBool('Algorithm', 'Do_filtr', true);
    p.do_step:=f.ReadBool('Algorithm', 'Do_step', false);
    p.do_gauss:=f.ReadBool('Algorithm', 'Do_gauss', false);
    p.num_seq:=f.ReadInteger('Algorithm', 'Num_seq', 1);
    p.num_mean:=f.ReadInteger('Algorithm', 'Num_mean', 1);
    p.num_skip:=f.ReadInteger('Algorithm', 'Num_skip', 5);
    s:=f.ReadString('Algorithm', 'Cut_off', '1');
    p.gauss_cut_off:=CheckString(s);
    s:=f.ReadString('Algorithm', 'gauss_aper', '1');
    p.gauss_aper:=CheckString(s);
    s:=f.ReadString('Algorithm', 'step_height', '18');
    p.step_height:=CheckString(s);
    p.do_unwrap:=f.ReadBool('Algorithm', 'do_unwrap', true);
    p.do_phase2z:=f.ReadBool('Algorithm', 'do_phase2z', true);


    p.img_path:=f.ReadString('Algorithm', 'Int_path', 'c:\');
    p.base_path:=f.ReadString('Algorithm', 'Base_path', 'c:\');
    p.SaveAS:=f.ReadInteger('Algorithm', 'SaveAs', 0);
    p.SavePath:=f.ReadString('Algorithm', 'SavePath', 'c:\');

    p.UnwrapPhaseSeparately:=f.ReadBool('Algorithm', 'UnwrapPhaseSeparately', false);
    p.FinalMaskFullScreen:=f.ReadBool('Algorithm', 'FinalMaskFullScreen', false);
    p.SeriesPause:=f.ReadInteger('Algorithm', 'SeriesPause', 0);
    p.PhaseShiftPause:=f.ReadInteger('Algorithm', 'PhaseShiftPause', 0);
    p.AverageSerie:=f.ReadBool('Algorithm', 'AverageSerie', false);
    p.SaveOnlyMaskedArea:=f.ReadBool('Algorithm', 'SaveOnlyMaskedArea', false);

    p.Fizo:=f.ReadBool('Fizo', 'Fizo', false);
    p.Fizo_Frames:=f.ReadInteger('Fizo', 'Fizo_Frames', 10);
    p.Fizo_pedestal:=f.ReadInteger('Fizo', 'Fizo_pedestal', 0);
    p.Fizo_amp:=f.ReadInteger('Fizo', 'Fizo_amp', 50);
    p.Fizo_t:=f.ReadInteger('Fizo', 'Fizo_t', 0);

    p.r:=f.ReadInteger('Fizo', 'r', 30);
    p.r0:=f.ReadInteger('Fizo', 'r0', 10);
    p.r1:=f.ReadInteger('Fizo', 'r1', 30);

    p.x_left:=f.ReadInteger('Windows', 'x_left', 0);
    p.x_top:=f.ReadInteger('Windows', 'x_top', 0);
    p.y_left:=f.ReadInteger('Windows', 'y_left', 0);
    p.y_top:=f.ReadInteger('Windows', 'y_top', 0);
    p.legend_left:=f.ReadInteger('Windows', 'legend_left', 0);
    p.legend_top:=f.ReadInteger('Windows', 'legend_top', 0);
    p.slice_left:=f.ReadInteger('Windows', 'slice_left', 0);
    p.slice_top:=f.ReadInteger('Windows', 'slice_top', 0);
    p.capture_left:=f.ReadInteger('Windows', 'capture_left', 0);
    p.capture_top:=f.ReadInteger('Windows', 'capture_top', 0);
    p.transp:=f.ReadInteger('Windows', 'transp', 255);
  finally
    f.Destroy;
  end;
end;


procedure WriteINI(var p: TConfig; path: string);
var f: TIniFile;
begin
  f:=TIniFile.Create(path);
  try
    f.WriteFloat('Microscope', 'fow_width', p.w1);
    f.WriteFloat('Microscope', 'fow_height', p.h1);
    f.WriteFloat('Microscope', 'lambda', p.lambda);
    f.WriteInteger('Microscope', 'Steps', p.steps);
    f.WriteInteger('Microscope', 'LPT_Port', p.port);
    f.WriteInteger('Microscope', 'cam_w', p.cam_w);
    f.WriteInteger('Microscope', 'cam_h', p.cam_h);
    f.WriteInteger('Microscope', 'amp', p.amp);
    f.WriteInteger('Microscope', 'expos', p.expos);
    f.WriteInteger('Microscope', 'm_shift', p.m_shift);
    f.WriteInteger('Microscope', 'Step_Motor_Shift', p.Step_Motor_Shift);
    f.WriteString('Microscope', 'CameraType', p.CameraType);
    f.WriteInteger('Microscope', 'DeviceNum', p.DeviceNum);
    f.WriteInteger('Microscope', 'LazerNum', p.LazerNum);
    f.WriteInteger('Microscope', 'Shift0', p.Shifts[0]);
    f.WriteInteger('Microscope', 'Shift1', p.Shifts[1]);
    f.WriteInteger('Microscope', 'Shift2', p.Shifts[2]);
    f.WriteFloat('Microscope', 'N_photo', p.n_photo);

    f.WriteInteger('3D', 'Quality', p.q);
    f.WriteInteger('3D', 'Pallete', p.pal);
    f.WriteFloat('3D', 'Scale_Z', p.z);

    f.WriteBool('Algorithm', 'Do_Tilt', p.tilt);
    f.WriteBool('Algorithm', 'Do_Base', p.base);
    f.WriteBool('Algorithm', 'Do_Invert', p.invert);
    f.WriteBool('Algorithm', 'Do_Seq', p.do_seq);
    f.WriteInteger('Algorithm', 'Num_seq', p.num_seq);
    f.WriteInteger('Algorithm', 'Num_skip', p.num_skip);
    f.WriteBool('Algorithm', 'Do_Mean', p.do_mean);
    f.WriteInteger('Algorithm', 'Num_mean', p.num_mean);
    f.WriteBool('Algorithm', 'Do_filtr', p.do_filtr);
    f.WriteBool('Algorithm', 'Do_step', p.do_step);
    f.WriteBool('Algorithm', 'Do_gauss', p.do_gauss);
    f.WriteFloat('Algorithm', 'Cut_off', p.gauss_cut_off);
    f.WriteFloat('Algorithm', 'gauss_aper', p.gauss_aper);
    f.WriteFloat('Algorithm', 'step_height', p.step_height);
    f.WriteBool('Algorithm', 'do_unwrap', p.do_unwrap);
    f.WriteBool('Algorithm', 'do_phase2z', p.do_phase2z);
    f.WriteBool('Algorithm', 'SaveOnlyMaskedArea', p.SaveOnlyMaskedArea);

    f.WriteString('Algorithm', 'Int_path', p.img_path);
    f.WriteString('Algorithm', 'Base_path', p.base_path);
    f.WriteInteger('Algorithm', 'SaveAs', p.SaveAS);
    f.WriteString('Algorithm', 'SavePath', p.SavePath);
    f.WriteInteger('Algorithm', 'TiltMask', p.TiltMask);
    f.WriteBool('Algorithm', 'UnwrapPhaseSeparately', p.UnwrapPhaseSeparately);
    f.WriteBool('Algorithm', 'FinalMaskFullScreen', p.FinalMaskFullScreen);
    f.WriteInteger('Algorithm', 'SeriesPause', p.SeriesPause);
    f.WriteInteger('Algorithm', 'PhaseShiftPause', p.PhaseShiftPause);
    f.WriteBool('Algorithm', 'AverageSerie', p.AverageSerie);


    f.WriteBool('Fizo', 'Fizo', p.Fizo);
    f.WriteInteger('Fizo', 'Fizo_Frames', p.Fizo_Frames);
    f.WriteInteger('Fizo', 'Fizo_pedestal', p.Fizo_pedestal);
    f.WriteInteger('Fizo', 'Fizo_amp', p.Fizo_amp);
    f.WriteInteger('Fizo', 'Fizo_t', p.Fizo_t);
    f.WriteInteger('Fizo', 'r', p.r);
    f.WriteInteger('Fizo', 'r0', p.r0);
    f.WriteInteger('Fizo', 'r1', p.r1);

    f.WriteInteger('Windows', 'x_left', p.x_left);
    f.WriteInteger('Windows', 'x_top', p.x_top);
    f.WriteInteger('Windows', 'y_left', p.y_left);
    f.WriteInteger('Windows', 'y_top', p.y_top);
    f.WriteInteger('Windows', 'legend_left', p.legend_left);
    f.WriteInteger('Windows', 'legend_top', p.legend_top);
    f.WriteInteger('Windows', 'slice_left', p.slice_left);
    f.WriteInteger('Windows', 'slice_top', p.slice_top);
    f.WriteInteger('Windows', 'capture_left', p.capture_left);
    f.WriteInteger('Windows', 'capture_top', p.capture_top);
    f.WriteInteger('Windows', 'transp', p.transp);
  finally
    f.Destroy;
  end;

end;








end.
