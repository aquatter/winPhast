unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, VidCap, ExtCtrls, giveio;

type
  TForm1 = class(TForm)

    Button1: TButton;
    Button2: TButton;
    Panel1: TPanel;
    Button3: TButton;
    ComboBox1: TComboBox;
    ListBox1: TListBox;
    Button4: TButton;
    Memo1: TMemo;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    VidCap1: TVidCap;
    procedure WM_WMCapDone(var msg: TMessage);message WM_CapDone;
    procedure WM_WMNewFrame(var msg: TMessage);message WM_NewFrame;
    procedure WM_MMNotify(var msg: TMessage);message WM_MMNotify;

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses Unit2, Unit3;

procedure TForm1.Button1Click(Sender: TObject);
var
  r:TRect;
  min,max:Integer;

begin
  try
    VidCap1.SelectCapDevice(1);

    r.Left:=0; r.Top:=0;
    r.Right:=Panel1.Width; r.Bottom:=Panel1.Height;
    VidCap1.Handle:=Handle;
    VidCap1.StartStream;
    VidCap1.Control:=Panel1;
    VidCap1.VideoRect:=r;
    VidCap1.NeedHist:=True;
    Form2.Visible:=True;

    //VidCap1.GetBrightMinMax(min, max);
    //VidCap1.GetCntrstMinMax(min, max);
    //VidCap1.Brightness:=1500;
    //VidCap1.Contrast:=1500;
  except
    on E:Exception do
      begin
        MessageDlg(E.Message, mtError, [mbOk], 0);
        VidCap1.RemoveAllFilters
      end
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var adr: Word;
    port: byte;
begin
  adr:=$b400+1;
  OutPort(adr, 0);
 while True do
  begin
    Application.ProcessMessages;
    port:=InPort(adr);
    if (port and 16) <> 0 then
    begin
      //sleep(1);
      break;
    end;
  end;


  VidCap1.Capture;
  Form3.Show;
//  Image1.Picture.Bitmap:=VidCap1.Bmp;
end;

procedure TForm1.Button4Click(Sender: TObject);
var i: integer;
begin
//  for i:=0 to VidCap1.CapDevs.Count-1 do
//    Memo1.Lines.Add(VidCap1.CapDevs.Strings[i]);



end;

procedure TForm1.ComboBox1Change(Sender: TObject);
begin
  case ComboBox1.ItemIndex of
    0:VidCap1.SetResolution(320, 240);
    1:VidCap1.SetResolution(640, 480);
    2:VidCap1.SetResolution(720, 576);
  end
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  VidCap1:=TVidCap.Create(Self);
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  VidCap1.Destroy;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  VidCap1.ShowPropertyPages
end;

procedure TForm1.WM_WMCapDone(var msg: TMessage);
var
  Lst:TList;
  i:Integer;
  time:array of Double;
  bmp:TBitmap;

begin
  Lst:=TList.Create;

  ListBox1.Clear;
  SetLength(time, 5);
  VidCap1.GetCapturedBitmaps(Lst, time);

  Form3.Image1.Picture.Bitmap:=TBitmap(Lst.Items[0]);
  TBitmap(Lst.Items[0]).SaveToFile('1.bmp');
  Form3.Label1.Caption:=FloatToStr(time[0]);  ListBox1.Items.Add(FloatToStr(time[1]-time[0]));
  TBitmap(Lst.Items[0]).Free;

  Form3.Image2.Picture.Bitmap:=TBitmap(Lst.Items[1]);
  Form3.Label2.Caption:=FloatToStr(time[1]);  ListBox1.Items.Add(FloatToStr(time[2]-time[1]));
  TBitmap(Lst.Items[1]).SaveToFile('2.bmp');
  TBitmap(Lst.Items[1]).Free;

  Form3.Image3.Picture.Bitmap:=TBitmap(Lst.Items[2]);
  Form3.Label3.Caption:=FloatToStr(time[2]);  ListBox1.Items.Add(FloatToStr(time[3]-time[2]));
  TBitmap(Lst.Items[2]).Free;

  Form3.Image4.Picture.Bitmap:=TBitmap(Lst.Items[3]);
  Form3.Label4.Caption:=FloatToStr(time[3]);
  TBitmap(Lst.Items[3]).Free;

  Form3.Show;
  Lst.Free
end;

procedure TForm1.WM_WMNewFrame(var msg: TMessage);
var
  Hist:PHistArr;
  i:Integer;

begin
  Hist:=VidCap1.GetHist;
  Form2.Series1.Clear;
  for i:=0 to 255 do Form2.Series1.Add(Hist[i]);
  FreeMem(Hist)
end;


procedure TForm1.WM_MMNotify(var msg: TMessage);
begin

end;

procedure TForm1.Timer1Timer(Sender: TObject);
var adr: Word;
    port: byte;
begin
  adr:=$b400+1;
  port:=InPort(adr);
  if (port and 16) <> 0 then
  begin
     Timer1.Enabled:=false;

     VidCap1.Capture;
     Form3.Show;
  end;

end;

end.
