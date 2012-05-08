unit fftw;

interface

uses utype, crude, t666, math;

const
  FFTW_FORWARD        = -1;
  FFTW_BACKWARD        = 1;
  FFTW_UNALIGNED       = 2;
  FFTW_ESTIMATE        = 64;

procedure fftw_destroy_plan(plan: Pointer); cdecl; external 'FFTW3.DLL';
procedure fftw_execute(plan: Pointer); cdecl; external 'FFTW3.DLL';
function fftw_plan_dft_2d(ny, nx: Integer; inData, outData: PDouble; sign: Integer; flags: Longword): Pointer; cdecl; external 'FFTW3.DLL';

type
  TFFTMode = (fmAchh, fmFchh, fmLog_Achh);
  Tfftw = class(TObject)
  private
    FFFTMode: TFFTMode;
    norm: TReal;
    _fft: TMyInfernalType;
  public
    procedure fft(outData: PMyInfernalType);
    procedure ifft(outData: PMyInfernalType);
    function Get: PMyInfernalType;
    constructor Create(inData: PMyInfernalType);
    destructor Destroy; override;
  published
    property FFTMode: TFFTMode read FFFTMode write FFFTMode;
  end;

implementation

{ Tfftw }

constructor Tfftw.Create(inData: PMyInfernalType);
var i,j: integer;
begin
  norm:=1/inData^.h_img/inData^.w_img;
  _fft:=TMyInfernalType.Create;
  _fft.Init(inData^.h_img, 2*inData^.w_img, varDouble);
  case inData^._type of
    varDouble:  for i:=inData^.y_img to inData^.y_img+inData^.h_img-1 do
                  for j:=inData^.x_img to inData^.x_img+inData^.w_img-1 do
                  begin
                    if Odd(i+j-inData^.y_img-inData^.x_img) then
                      _fft.a^[(i-inData^.y_img)*_fft.w+2*(j-inData^.x_img)]:=-inData^.a^[i*inData^.w+j]
                    else
                      _fft.a^[(i-inData^.y_img)*_fft.w+2*(j-inData^.x_img)]:=inData^.a^[i*inData^.w+j];
                  end;
    varByte:  for i:=inData^.y_img to inData^.y_img+inData^.h_img-1 do
                for j:=inData^.x_img to inData^.x_img+inData^.w_img-1 do
                begin
                  if Odd(i+j-inData^.y_img-inData^.x_img) then
                    _fft.a^[(i-inData^.y_img)*_fft.w+2*(j-inData^.x_img)]:=-inData^.b^[i*inData^.w+j]
                  else
                    _fft.a^[(i-inData^.y_img)*_fft.w+2*(j-inData^.x_img)]:=inData^.b^[i*inData^.w+j];
                end;
    varInteger: for i:=inData^.y_img to inData^.y_img+inData^.h_img-1 do
                  for j:=inData^.x_img to inData^.x_img+inData^.w_img-1 do
                  begin
                    if Odd(i+j-inData^.y_img-inData^.x_img) then
                      _fft.a^[(i-inData^.y_img)*_fft.w+2*(j-inData^.x_img)]:=-inData^.c^[i*inData^.w+j]
                    else
                      _fft.a^[(i-inData^.y_img)*_fft.w+2*(j-inData^.x_img)]:=inData^.c^[i*inData^.w+j];
                  end;
  end;
  FFFTMode:=fmLog_Achh;
end;

destructor Tfftw.Destroy;
begin
  _fft.Destroy;
  inherited Destroy;
end;

procedure Tfftw.fft(outData: PMyInfernalType);
var plan: Pointer;
    i,j: integer;
begin
  plan:=fftw_plan_dft_2d(_fft.h, _fft.w div 2, PDouble(_fft.a), PDouble(_fft.a), FFTW_FORWARD, FFTW_ESTIMATE);
  fftw_execute(plan);
  fftw_destroy_plan(plan);
  outData^.Clear;
  outData^.Init(_fft.h, _fft.w div 2, varDouble);
  case FFFTMode of
    fmLog_Achh: for i:=0 to _fft.h-1 do
                  for j:=0 to outData^.w-1 do
                    outData^.a^[i*outData^.w+j]:=Log10(sqrt(sqr(_fft.a^[i*_fft.w+2*j])+sqr(_fft.a^[i*_fft.w+2*j+1]))+1);
    fmAchh:  for i:=0 to _fft.h-1 do
               for j:=0 to outData^.w-1 do
                 outData^.a^[i*outData^.w+j]:=sqrt(sqr(_fft.a^[i*_fft.w+2*j])+sqr(_fft.a^[i*_fft.w+2*j+1]));

  end;


end;

function Tfftw.Get: PMyInfernalType;
begin
  Result:=@(_fft);
end;

procedure Tfftw.ifft(outData: PMyInfernalType);
var plan: Pointer;
    i,j: integer;
begin
  plan:=fftw_plan_dft_2d(_fft.h, _fft.w div 2, PDouble(_fft.a), PDouble(_fft.a), FFTW_BACKWARD, FFTW_ESTIMATE);
  fftw_execute(plan);
  fftw_destroy_plan(plan);
  outData^.Clear;
  outData^.Init(_fft.h, _fft.w div 2, varDouble);
  for i:=0 to _fft.h-1 do
    for j:=0 to outData^.w-1 do
      if Odd(i+j) then
        outData^.a^[i*outData^.w+j]:=-_fft.a^[i*_fft.w+2*j]*norm
      else
        outData^.a^[i*outData^.w+j]:=_fft.a^[i*_fft.w+2*j]*norm;
end;

end.
