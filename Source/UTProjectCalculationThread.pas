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
    phase, amp, unwrap: TMyInfernalType;
    function CalculatePhase(img: TList<AnsiString>; num_seq, num_rec: integer): boolean;
  protected
    procedure Execute; override;
  end;


var
  ProjectCalculationThread: TProjectCalculationThread;

procedure StartCalculationThread(pd: TProjectData);

implementation

uses
  Unit1, Crude, SysUtils, Dialogs, UPTree, Uvt;

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

function TProjectCalculationThread.CalculatePhase(img: TList<AnsiString>; num_seq, num_rec: integer): boolean;
var images: TPointerArray;
    w, h, i: integer;
    s: string;
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

  s:= 'phase_'+IntToStr(num_seq+1)+'_'+IntToStr(num_rec+1)+'.bin';

  CreateBin(phase, s);
  pd_.Get(num_seq).Get(num_rec).phase:= AnsiString(s);

  Synchronize(
  procedure
  begin
    pnl.DrawImage(phase, phase);
  end
  );

  for i:=0 to img.Count-1 do
    FreeMem(images[i], w*h);
  Finalize(images);

  Result:= true;
end;

procedure TProjectCalculationThread.Execute;
var i,j,k: integer;
    rec_: TRec;
    s: AnsiString;
begin
  phase:= TMyInfernalType.Create;
  amp:= TMyInfernalType.Create;
  unwrap:= TMyInfernalType.Create;

  try
    try

    for i:=0 to pd_.Count-1 do
      for j:=0 to pd_.Get(i).Count-1 do
      begin
        rec_:= pd_.Get(i).Get(j);
        for k:=0 to Length(rec_.what_to_calc)-1 do
          case rec_.what_to_calc[k] of
            calcPhase: begin
                         if not CalculatePhase(rec_.img, i, j) then
                           raise Exception.Create('Ошибка вычисления фазы');



                       end;
            calcUnwrap: begin

                        end;

          end;



      end;

    except
      on e: Exception do
        Synchronize(
        procedure
        begin
          ShowMessage(e.Message);
        end
        );
    end;

  finally
    s:= pd_.prop_.file_path + pd_.prop_.file_name;
    SaveProject(s, pd_);

    Synchronize(
    procedure
    begin
      UpdateVt;
    end
    );

    phase.Destroy;
    unwrap.Destroy;
    amp.Destroy;
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
