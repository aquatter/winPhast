program Project1;



uses
  Forms,
  Unit1 in 'Source\Unit1.pas' {Form1},
  Unit2 in 'Source\Unit2.pas' {Form2},
  Unit3 in 'Source\Unit3.pas' {Form3},
  interp in 'Source\interp.pas',
  Unit4 in 'Source\Unit4.pas' {Form4},
  calibr in 'Source\calibr.pas',
  fftw in 'Source\fftw.pas',
  Unit5 in 'Source\Unit5.pas' {Form5},
  Unit6 in 'Source\Unit6.pas' {Form6},
  Unit7 in 'Source\Unit7.pas' {Form7},
  Unit8 in 'Source\Unit8.pas' {Form8},
  VideoStream in 'Source\VideoStream.pas',
  Unit9 in 'Source\Unit9.pas' {Form9},
  giveio in 'Source\giveio.pas',
  Unit10 in 'Source\Unit10.pas' {Form10},
  UBaseRunThread in 'Source\UBaseRunThread.pas',
  URaznForm in 'Source\URaznForm.pas' {RaznForm},
  UVideoCaptureSeqThread in 'Source\UVideoCaptureSeqThread.pas',
  URecSeqThread in 'Source\URecSeqThread.pas',
  UPhast2Vars in 'Source\UPhast2Vars.pas',
  URecSeqThreadForm in 'Source\URecSeqThreadForm.pas' {RecSeqThreadForm},
  ULoadSeqForm in 'Source\ULoadSeqForm.pas' {LoadSeqForm},
  ULunkaRunhread in 'Source\ULunkaRunhread.pas',
  UTLunkaRunForm in 'Source\UTLunkaRunForm.pas' {LunkaRunForm},
  ULoadSeqLunkaForm in 'Source\ULoadSeqLunkaForm.pas' {LoadSeqLunkaForm},
  ULunkaSeqRunForm in 'Source\ULunkaSeqRunForm.pas' {LunkaSeqRunForm},
  ULunkaSeqResultsForm in 'Source\ULunkaSeqResultsForm.pas' {LunkaSeqResultsForm},
  URaRzRmaxForm in 'Source\URaRzRmaxForm.pas' {RaRzRmaxForm},
  UWinPhast_INI in 'Source\UWinPhast_INI.pas',
  UWhat2CalcForm in 'Source\UWhat2CalcForm.pas' {What2CalcForm},
  UReportForm in 'Source\UReportForm.pas' {ReportForm},
  UDirectShowVideoForm in 'Source\UDirectShowVideoForm.pas' {DirectShowVideoForm},
  UDirectShowCaptureThread in 'Source\UDirectShowCaptureThread.pas',
  UInitComThread in 'Source\UInitComThread.pas',
  UTInitComThreadForm in 'Source\UTInitComThreadForm.pas' {InitComThreadForm},
  UWatchComThread in 'Source\UWatchComThread.pas',
  USetLazerThread in 'Source\USetLazerThread.pas',
  UCapture_with_Averaging_DirectShow_Thread in 'Source\UCapture_with_Averaging_DirectShow_Thread.pas',
  UTwoWaveLengthDialogForm in 'Source\UTwoWaveLengthDialogForm.pas' {TwoWaveLengthDialogForm},
  UTwoWaveLengthClass in 'Source\UTwoWaveLengthClass.pas',
  UTwoWaveLengthThread in 'Source\UTwoWaveLengthThread.pas',
  UTest_Com_Port_Form in 'Source\UTest_Com_Port_Form.pas' {Test_Com_Port_Form},
  USaveAsForm in 'Source\USaveAsForm.pas' {SaveAsForm},
  UFizo in 'Source\UFizo.pas',
  UPTree in 'Source\Common\UPTree.pas',
  UProjectData in 'Source\UProjectData.pas',
  Uvt in 'Source\Uvt.pas';

{$R *.res}
{$R new.res}

begin
  InitDriver;
  Application.Initialize;
  Application.Title := 'winPhast';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm3, Form3);
  Application.CreateForm(TForm4, Form4);
  Application.CreateForm(TForm5, Form5);
  Application.CreateForm(TForm6, Form6);
  Application.CreateForm(TForm7, Form7);
  Application.CreateForm(TForm8, Form8);
  Application.CreateForm(TForm9, Form9);
  Application.CreateForm(TForm10, Form10);
  Application.CreateForm(TRaznForm, RaznForm);
  Application.CreateForm(TRecSeqThreadForm, RecSeqThreadForm);
  Application.CreateForm(TLoadSeqForm, LoadSeqForm);
  Application.CreateForm(TLunkaRunForm, LunkaRunForm);
  Application.CreateForm(TLoadSeqLunkaForm, LoadSeqLunkaForm);
  Application.CreateForm(TLunkaSeqRunForm, LunkaSeqRunForm);
  Application.CreateForm(TLunkaSeqResultsForm, LunkaSeqResultsForm);
  Application.CreateForm(TRaRzRmaxForm, RaRzRmaxForm);
  Application.CreateForm(TWhat2CalcForm, What2CalcForm);
  Application.CreateForm(TReportForm, ReportForm);
  Application.CreateForm(TDirectShowVideoForm, DirectShowVideoForm);
  Application.CreateForm(TInitComThreadForm, InitComThreadForm);
  Application.CreateForm(TTwoWaveLengthDialogForm, TwoWaveLengthDialogForm);
  Application.CreateForm(TTest_Com_Port_Form, Test_Com_Port_Form);
  Application.CreateForm(TSaveAsForm, SaveAsForm);
  Application.Run;
end.
