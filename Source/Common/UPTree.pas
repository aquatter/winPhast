unit UPTree;

interface

  uses UProjectData;

  const ptree_dll = 'ptree.dll';
  //function Add(a, b: double): double; cdecl; external ptree_dll;

  function ptree_init(): Pointer; cdecl; external ptree_dll;
  procedure ptree_shutdown(pt: pointer); cdecl; external ptree_dll;
  procedure ptree_read_xml(pt: pointer; path: PAnsiChar); cdecl; external ptree_dll;
  procedure ptree_write_xml(pt: pointer; path: PAnsiChar); cdecl; external ptree_dll;
  function ptree_get_int(pt: pointer; path: PAnsiChar): integer; cdecl; external ptree_dll;
  procedure ptree_set_int(pt: pointer; path: PAnsiChar; value: integer); cdecl; external ptree_dll;
  function ptree_get_double(pt: pointer; path: PAnsiChar): double; cdecl; external ptree_dll;
  procedure ptree_set_double(pt: pointer; path: PAnsiChar; value: double); cdecl; external ptree_dll;
  function ptree_get_string(pt: pointer; path: PAnsiChar): PAnsiChar; cdecl; external ptree_dll;
  procedure ptree_set_string(pt: pointer; path: PAnsiChar; value: PAnsiChar); cdecl; external ptree_dll;
  function ptree_get_boolean(pt: pointer; path: PAnsiChar): boolean; cdecl; external ptree_dll;
  procedure ptree_set_boolean(pt: pointer; path: PAnsiChar; value: boolean); cdecl; external ptree_dll;


  procedure SaveProject(var pd: TProjectData);
  function OpenProject(name: AnsiString; var pd: TProjectData): boolean;

implementation

  uses SysUtils, uphast2vars;

  procedure SaveProject(var pd: TProjectData);
  var i,j,k: integer;
      pt: pointer;
      s, s1: AnsiString;
  begin

    if not pd.changed then
      exit;

    pt:= ptree_init;
    ptree_set_int(pt, 'Project.Properties.Type', integer(pd.prop_.type_));
    ptree_set_double(pt, 'Project.Properties.WaveLength', pd.prop_.WaveLength);
    ptree_set_int(pt, 'Project.Properties.Width', pd.prop_.w);
    ptree_set_int(pt, 'Project.Properties.Height', pd.prop_.h);

    ptree_set_boolean(pt, 'Project.Properties.Tilt', pd.prop_.doTilt);
    ptree_set_boolean(pt, 'Project.Properties.Mean', pd.prop_.doMean);
    ptree_set_boolean(pt, 'Project.Properties.Unwrap', pd.prop_.doUnwrap);
    ptree_set_boolean(pt, 'Project.Properties.Base', pd.prop_.doBase);

    s1:= pd.mask1;
    if not FileExists(string(pd.prop_.file_path + s1)) then
      s1:= 'None';
    ptree_set_string(pt, 'Project.Masks.Mask1', PAnsiChar(s1));
    s1:= pd.mask2;
    if not FileExists(string(pd.prop_.file_path + s1)) then
      s1:= 'None';
    ptree_set_string(pt, 'Project.Masks.Mask2', PAnsiChar(s1));

    ptree_set_int(pt, 'Project.Num', pd.Count);


    for i:=0 to pd.Count-1 do
    begin
      s:=AnsiString( 'Project.Serie_' + IntToStr(i)+'.Num' );
      ptree_set_int(pt, PAnsiChar(s), pd.Get(i).Count);

      for j:=0 to pd.Get(i).Count-1 do
      begin
        s:=AnsiString( 'Project.Serie_' + IntToStr(i)+'.Measurement_'+IntToStr(j)+'.Num' );
        ptree_set_int(pt, PAnsiChar(s), pd.Get(i).Get(j).img.Count);

        for k:=0 to pd.Get(i).Get(j).img.Count-1 do
        begin
          s:=AnsiString('Project.Serie_' + IntToStr(i)+'.Measurement_'+IntToStr(j)+'.Image_'+IntToStr(k));
          s1:= pd.Get(i).Get(j).img[k];
          if not FileExists(string(pd.prop_.file_path + s1)) then
            s1:= 'None';
          ptree_set_string(pt, PAnsiChar(s), PAnsiChar(s1));
        end;

        s:=AnsiString('Project.Serie_' + IntToStr(i)+'.Measurement_'+IntToStr(j)+'.Phase');
        s1:= pd.Get(i).Get(j).phase;
        if not FileExists(string(pd.prop_.file_path + s1)) then
          s1:= 'None';
        ptree_set_string(pt, PAnsiChar(s), PAnsiChar(s1));

        s1:= pd.Get(i).Get(j).unwrap;
        if not FileExists(string(pd.prop_.file_path + s1)) then
          s1:= 'None';
        s:=AnsiString('Project.Serie_' + IntToStr(i)+'.Measurement_'+IntToStr(j)+'.Unwrap');
        ptree_set_string(pt, PAnsiChar(s), PAnsiChar(s1));
      end;
    end;

    if pd.prop_.file_name <> AnsiString(pd.prop_.project_name + '.winPhast') then
      if FileExists(string(pd.prop_.file_path + pd.prop_.file_name)) then
        DeleteFile(string(pd.prop_.file_path + pd.prop_.file_name));

    pd.prop_.file_name:= AnsiString(pd.prop_.project_name + '.winPhast');

    s:= pd.prop_.file_path + AnsiString(pd.prop_.file_name);
    ptree_write_xml(pt, PAnsiChar(s));
    ptree_shutdown(pt);
    pd.changed:= false;

  end;


  function OpenProject(name: AnsiString; var pd: TProjectData): boolean;
  var i,j,k, n_seq, n_rec, n_int: integer;
      pt: pointer;
      s, s1: AnsiString;
      seq_: TSeq;
      rec_: TRec;
  begin
    if not FileExists(string(name)) then
    begin
      Result:= false;
      exit;
    end;

    pd.Clear;
    pd.prop_.file_name:= AnsiString(ExtractFileName(string(name)));
    pd.prop_.file_path:= AnsiString(ExtractFilePath(string(name)));
    pd.prop_.project_name:= ChangeFileExt(ExtractFileName(string(name)),'');

    pt:= ptree_init;
    ptree_read_xml(pt, PAnsiChar(name));
    pd.prop_.type_:= TProjectType( ptree_get_int(pt, 'Project.Properties.Type') );
    pd.prop_.WaveLength:= ptree_get_double(pt, 'Project.Properties.WaveLength');
    pd.prop_.w:= ptree_get_int(pt, 'Project.Properties.Width');
    pd.prop_.h:= ptree_get_int(pt, 'Project.Properties.Height');

    pd.prop_.doTilt:= ptree_get_boolean(pt, 'Project.Properties.Tilt');
    pd.prop_.doMean:= ptree_get_boolean(pt, 'Project.Properties.Mean');
    pd.prop_.doUnwrap:= ptree_get_boolean(pt, 'Project.Properties.Unwrap');
    pd.prop_.doBase:= ptree_get_boolean(pt, 'Project.Properties.Base');

    s:= ptree_get_string(pt, 'Project.Masks.Mask1');
    if FileExists(string(pd.prop_.file_path + s)) then
      pd.mask1:= s
    else
      pd.mask1:= 'файл не найден';

    s:= ptree_get_string(pt, 'Project.Masks.Mask2');
    if FileExists(string(pd.prop_.file_path + s)) then
      pd.mask2:= s
    else
      pd.mask2:= 'файл не найден';

    n_seq:= ptree_get_int(pt, 'Project.Num');

    for i:=0 to n_seq-1 do
    begin
      seq_:= pd.Add;
      s:=AnsiString('Project.Serie_' + IntToStr(i)+'.Num');
      n_rec:= ptree_get_int(pt, PAnsiChar(s));
      for j:=0 to n_rec-1 do
      begin
        rec_:= seq_.Add;
        s:=AnsiString('Project.Serie_' + IntToStr(i)+'.Measurement_'+IntToStr(j)+'.Num');
        n_int:= ptree_get_int(pt, PAnsiChar(s));
        for k:=0 to n_int-1 do
        begin
          s:=AnsiString('Project.Serie_' + IntToStr(i)+'.Measurement_'+IntToStr(j)+'.Image_'+IntToStr(k));
          s1:= ptree_get_string(pt, PAnsiChar(s));
          if not FileExists(string(pd.prop_.file_path + s1)) then
            s1:='Файл не найден';

          rec_.img.Add(s1);
        end;

        s:=AnsiString('Project.Serie_' + IntToStr(i)+'.Measurement_'+IntToStr(j)+'.Phase');
        s1:=ptree_get_string(pt, PAnsiChar(s));
        rec_.phase_calculated:= true;
        if not FileExists(string(pd.prop_.file_path + s1)) then
        begin
          s1:='файл не найден';
          rec_.phase_calculated:= false;
        end;
        rec_.phase:= s1;

        rec_.unwrap_calculated:= true;
        s:=AnsiString('Project.Serie_' + IntToStr(i)+'.Measurement_'+IntToStr(j)+'.Unwrap');
        s1:=ptree_get_string(pt, PAnsiChar(s));
        if not FileExists(string(pd.prop_.file_path + s1)) then
        begin
          s1:='файл не найден';
          rec_.unwrap_calculated:= false;
        end;
        rec_.unwrap:= s1;
      end;
    end;

    ptree_shutdown(pt);
    Result:= true;
    pd.changed:= false;

    phase.Clear;
    phase.Init(pd.prop_.h, pd.prop_.w, varDouble);
    mask_inner.Clear;
    mask_inner.Init(pd.prop_.h, pd.prop_.w, varByte);

  end;

end.
