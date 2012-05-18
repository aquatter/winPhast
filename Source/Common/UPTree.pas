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


  procedure SaveProject(name: AnsiString; var pd: TProjectData);
  function OpenProject(name: AnsiString; var pd: TProjectData): boolean;

implementation

  uses SysUtils;

  procedure SaveProject(name: AnsiString; var pd: TProjectData);
  var i,j,k: integer;
      pt: pointer;
      s: AnsiString;
  begin
    pt:= ptree_init;
    ptree_set_int(pt, 'Project.Properties.Type', integer(pd.prop_.type_));
    ptree_set_double(pt, 'Project.Properties.WaveLength', pd.prop_.WaveLength);
    ptree_set_int(pt, 'Project.Properties.Width', pd.prop_.w);
    ptree_set_int(pt, 'Project.Properties.Height', pd.prop_.h);
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
          ptree_set_string(pt, PAnsiChar(s), PAnsiChar(pd.Get(i).Get(j).img[k]));
        end;

        s:=AnsiString('Project.Serie_' + IntToStr(i)+'.Measurement_'+IntToStr(j)+'.Phase');
        ptree_set_string(pt, PAnsiChar(s), PAnsiChar(pd.Get(i).Get(j).phase));
        s:=AnsiString('Project.Serie_' + IntToStr(i)+'.Measurement_'+IntToStr(j)+'.Unwrap');
        ptree_set_string(pt, PAnsiChar(s), PAnsiChar(pd.Get(i).Get(j).unwrap));
      end;
    end;

    ptree_write_xml(pt, PAnsiChar(name));
    ptree_shutdown(pt);
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

    pt:= ptree_init;
    ptree_read_xml(pt, PAnsiChar(name));
    pd.prop_.type_:= TProjectType( ptree_get_int(pt, 'Project.Properties.Type') );
    pd.prop_.WaveLength:= ptree_get_double(pt, 'Project.Properties.WaveLength');
    pd.prop_.w:= ptree_get_int(pt, 'Project.Properties.Width');
    pd.prop_.h:= ptree_get_int(pt, 'Project.Properties.Height');
    n_seq:= ptree_get_int(pt, 'Project.Num');
    pd.prop_.project_name:= ChangeFileExt(ExtractFileName(string(name)),'');

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
          if not FileExists(string(s1)) then
            s1:='‘айл не найден';

          rec_.img.Add(s1);
        end;

        s:=AnsiString('Project.Serie_' + IntToStr(i)+'.Measurement_'+IntToStr(j)+'.Phase');
        s1:=ptree_get_string(pt, PAnsiChar(s));
        rec_.phase_calculated:= true;
        if not FileExists(string(s1)) then
        begin
          s1:='‘аза: файл не найден';
          rec_.phase_calculated:= false;
        end;
        rec_.phase:= s1;

        rec_.unwrap_calculated:= true;
        s:=AnsiString('Project.Serie_' + IntToStr(i)+'.Measurement_'+IntToStr(j)+'.Unwrap');
        s1:=ptree_get_string(pt, PAnsiChar(s));
        if not FileExists(string(s1)) then
        begin
          s1:='—шита€ фаза: файл не найден';
          rec_.unwrap_calculated:= false;
        end;
        rec_.unwrap:= s1;
      end;
    end;

    ptree_shutdown(pt);
    Result:= true;
  end;

end.
