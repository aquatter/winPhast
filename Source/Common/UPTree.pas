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
      s:='Project.Serie_' + IntToStr(i)+'.Num';
      ptree_set_int(pt, PAnsiChar(s), pd.Get(i).Count);

      for j:=0 to pd.Get(i).Count-1 do
      begin
        s:='Project.Serie_' + IntToStr(i)+'.Measurement_'+IntToStr(j)+'.Num';
        ptree_set_int(pt, PAnsiChar(s), pd.Get(i).Get(j).img.Count);

        for k:=0 to pd.Get(i).Get(j).img.Count-1 do
        begin
          s:='Project.Serie_' + IntToStr(i)+'.Measurement_'+IntToStr(j)+'.Image_'+IntToStr(k);
          ptree_set_string(pt, PAnsiChar(s), PAnsiChar(pd.Get(i).Get(j).img[k]));
        end;

        s:='Project.Serie_' + IntToStr(i)+'.Measurement_'+IntToStr(j)+'.Phase';
        ptree_set_string(pt, PAnsiChar(s), PAnsiChar(pd.Get(i).Get(j).phase));
        s:='Project.Serie_' + IntToStr(i)+'.Measurement_'+IntToStr(j)+'.Unwrap';
        ptree_set_string(pt, PAnsiChar(s), PAnsiChar(pd.Get(i).Get(j).unwrap));
      end;
    end;

    ptree_write_xml(pt, PAnsiChar(name));
    ptree_shutdown(pt);
  end;

end.
