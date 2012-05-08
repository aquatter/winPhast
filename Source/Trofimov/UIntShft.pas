unit UIntShft;

interface

uses Math, UType, UFFT, URATool;

function Make5IntByOne(XSize, YSize, WX, WY, WX0, WY0 : Integer;
                       var PIn, POut1, POut2, POut3, POut4, POut5,
                       PSpectrDo, PSpectrPosle : TRealArray;
                       IsMakeSin : Boolean) : Integer;

implementation

function MultiplySpectrum4Shift(XSize, YSize, WX, WY, WX0, WY0 : Integer;
                                var PC, PCFilt : TRealArray;
                                N : TReal;
                                IsMakeSin : Boolean) : Integer;
var
  P : PRealArray;
  I, J : Integer;
  MaxX, MaxY, CurX, CurY : Integer;
  Fi, R, XMax1, YMax1, XMax2, YMax2, YMax0, XMax0 : TReal;
  D : TReal;
  WindowType : Integer;
begin
  // �������� ������
  GetMem(P, XSize*YSIze*SizeOf(TReal));
  // ����������� - � ������������� �� ������
  Complex2RealArray(XSize, YSize, PC, P^, 4, False);
  // ���� ��������� �������� - ������ �������
  FindLocalMaxRealArray(XSize, YSize, P^,
                        10, Sqrt(Sqr(XSize div 2) + Sqr(YSize div 2)),
                        MaxX, MaxY);
  // ���� ������� ������������ ���� � ���������� �� ������� �������
  Fi := Arctan2(MaxX, MaxY);
  R := Sqrt(Sqr(MaxX) + Sqr(MaxY));
  D := 1 * R;
  WindowType := fwHemming;
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do begin
      PCFilt[(I * XSize + J)*2] := 0;
      PCFilt[(I * XSize + J)*2 + 1] := 0;
    end;
  // ���������� ������ ������� � �������
  for I := 0 to YSize - 1 do
    for J := 0 to XSize - 1 do begin
      // ������� ���������� ������������ ������ ������
      CurX := J - (XSize div 2);
      CurY := (YSize div 2) - I;
      // ���������� � ������� ��������� ��������� � ������ ��������
      YMax1 := (CurY - MaxY) * Sin(Fi) + (CurX - MaxX) * Cos(Fi);
      XMax1 := (CurY - MaxY) * Cos(Fi) - (CurX - MaxX) * Sin(Fi);
      // ���������� � ������� ��������� ��������� �� ������ ��������
      YMax2 := (CurY + MaxY) * Sin(Fi) + (CurX + MaxX) * Cos(Fi);
      XMax2 := (CurY + MaxY) * Cos(Fi) - (CurX + MaxX) * Sin(Fi);
      // ���������� � ������� ��������� ��������� � ������� ��������
      YMax0 := CurY * Sin(Fi) + CurX * Cos(Fi);
      XMax0 := CurY * Cos(Fi) - CurX * Sin(Fi);
      // �������� ������� � �������� �� ��������������� �����
      if (Abs(XMax1) < WX) and (Abs(YMax1) < WY) then begin
        if (J - MaxX < XSize) and (J - MaxX > 0) and
           (I + MaxY < YSize) and (I + MaxY > 0) then begin
          PCFilt[((I) * XSize + J) * 2] := (PC[(I * XSize + J) * 2] * Cos(N) -
                                         PC[(I * XSize + J) * 2 + 1] * Sin(N)) *
            FltWin(XMax1, 2 * WX, WindowType) *
            FltWin(YMax1, 2 * WY, WindowType);
          PCFilt[((I) * XSize + J) * 2 + 1] := (PC[(I * XSize + J) * 2 + 1] * Cos(N) +
                                             PC[(I * XSize + J) * 2] * Sin(N)) *
            FltWin(XMax1, 2 * WX, WindowType) *
            FltWin(YMax1, 2 * WY, WindowType);
        end;
      end;
      if (Abs(XMax2) < WX) and (Abs(YMax2) < WY) then begin
        if (J - MaxX < XSize) and (J - MaxX > 0) and
           (I + MaxY < YSize) and (I + MaxY > 0) then begin
          PCFilt[((I) * XSize + J) * 2] := (PC[(I * XSize + J) * 2] * Cos(- N) -
                                         PC[(I * XSize + J) * 2 + 1] * Sin(- N)) *
            FltWin(XMax2, 2 * WX, WindowType) *
            FltWin(YMax2, 2 * WY, WindowType);
          PCFilt[((I) * XSize + J) * 2 + 1] := (PC[(I * XSize + J) * 2 + 1] * Cos(- N) +
                                             PC[(I * XSize + J) * 2] * Sin(- N)) *
            FltWin(XMax2, 2 * WX, WindowType) *
            FltWin(YMax2, 2 * WY, WindowType);
        end;
      end;
      if (Abs(XMax0) < WX0) and (Abs(YMax0) < WY0) then begin
        if (J - MaxX < XSize) and (J - MaxX > 0) and
           (I + MaxY < YSize) and (I + MaxY > 0) then begin
          PCFilt[((I) * XSize + J) * 2] := (PC[(I * XSize + J) * 2] * Cos(0) -
                                         PC[(I * XSize + J) * 2 + 1] * Sin(0)) *
            FltWin(XMax0, 2 * WX0, WindowType) *
            FltWin(YMax0, 2 * WY0, WindowType);
          PCFilt[((I) * XSize + J) * 2 + 1] := (PC[(I * XSize + J) * 2 + 1] * Cos(0) +
                                             PC[(I * XSize + J) * 2] * Sin(0)) *
            FltWin(XMax0, 2 * WX0, WindowType) *
            FltWin(YMax0, 2 * WY0, WindowType);
        end;
      end;
    end;
  // ����������� ������
  FreeMem(P, XSize*YSIze*SizeOf(TReal));
end;

function Make5IntByOne(XSize, YSize, WX, WY, WX0, WY0 : Integer;
                       var PIn, POut1, POut2, POut3, POut4, POut5,
                       PSpectrDo, PSpectrPosle : TRealArray;
                       IsMakeSin : Boolean) : Integer;
var
  PC, PCFilt : PRealArray;
  plan : Pointer;
begin
  // ������� ��������� �������
  GetMem(PC, XSize*YSize*2*SizeOf(TReal));
  GetMem(PCFilt, XSize*YSize*2*SizeOf(TReal));
  // ��������� ������� ������ � ����������� �������� ������ ������������� �����
  Real2ComplexArray(XSize, YSize, PC^, PIn, 1);
  // ������� ������ � ����� - ����� ������ ���� ���������� ���
  PrepareComplexArray4FFT(XSize, YSize, PC^);
  // ��������� ���� ��� �����
  plan := fftw_plan_dft_2d(YSize, XSize, Addr(PC^[0]), Addr(PC^[0]),
                           FFTW_FORWARD, FFTW_ESTIMATE);
  // ��������� �����
  fftw_execute(plan);
  // ���������� ����
  fftw_destroy_plan(plan);
  // ��������� ������ � �������� ������ �� ������������ ������ ��� ������
  Complex2RealArray(XSize, YSize, PC^, PSpectrDo, 4, True);
  // --- ������ ���������������� ---
  // ��������� ������
  MultiplySpectrum4Shift(XSize, YSize, WX, WY, WX0, WY0, PC^, PCFilt^, 0, IsMakeSin);
  // ������� ���� ��� ��������� �����
  plan := fftw_plan_dft_2d(YSize, XSize, Addr(PCFilt^[0]), Addr(PCFilt^[0]),
                           FFTW_BACKWARD, FFTW_ESTIMATE);
  // ��������� �����
  fftw_execute(plan);
  // ���������� ����
  fftw_destroy_plan(plan);
  // ������� ������ ����� ����� - ����� ����������� ����� ���������� ���
  PrepareComplexArray4FFT(XSize, YSize, PCFilt^);
  // ��������� ������ � �������� ������ �� ������������ ������ ��� ������
  Complex2RealArray(XSize, YSize, PCFilt^, POut1, 4, True);
  // --- ������ ���������������� ---
  // ��������� ������
  MultiplySpectrum4Shift(XSize, YSize, WX, WY, WX0, WY0, PC^, PCFilt^, 2 * Pi / 5, IsMakeSin);
  // ������� ���� ��� ��������� �����
  plan := fftw_plan_dft_2d(YSize, XSize, Addr(PCFilt^[0]), Addr(PCFilt^[0]),
                           FFTW_BACKWARD, FFTW_ESTIMATE);
  // ��������� �����
  fftw_execute(plan);
  // ���������� ����
  fftw_destroy_plan(plan);
  // ������� ������ ����� ����� - ����� ����������� ����� ���������� ���
  PrepareComplexArray4FFT(XSize, YSize, PCFilt^);
  // ��������� ������ � �������� ������ �� ������������ ������ ��� ������
  Complex2RealArray(XSize, YSize, PCFilt^, POut2, 4, True);
  // --- ������ ���������������� ---
  // ��������� ������
  MultiplySpectrum4Shift(XSize, YSize, WX, WY, WX0, WY0, PC^, PCFilt^, 4 * Pi / 5, IsMakeSin);
  // ������� ���� ��� ��������� �����
  plan := fftw_plan_dft_2d(YSize, XSize, Addr(PCFilt^[0]), Addr(PCFilt^[0]),
                           FFTW_BACKWARD, FFTW_ESTIMATE);
  // ��������� �����
  fftw_execute(plan);
  // ���������� ����
  fftw_destroy_plan(plan);
  // ������� ������ ����� ����� - ����� ����������� ����� ���������� ���
  PrepareComplexArray4FFT(XSize, YSize, PCFilt^);
  // ��������� ������ � �������� ������ �� ������������ ������ ��� ������
  Complex2RealArray(XSize, YSize, PCFilt^, POut3, 4, True);
  // --- ��������� ���������������� ---
  // ��������� ������
  MultiplySpectrum4Shift(XSize, YSize, WX, WY, WX0, WY0, PC^, PCFilt^, 6 * Pi / 5, IsMakeSin);
  // ������� ���� ��� ��������� �����
  plan := fftw_plan_dft_2d(YSize, XSize, Addr(PCFilt^[0]), Addr(PCFilt^[0]),
                           FFTW_BACKWARD, FFTW_ESTIMATE);
  // ��������� �����
  fftw_execute(plan);
  // ���������� ����
  fftw_destroy_plan(plan);
  // ������� ������ ����� ����� - ����� ����������� ����� ���������� ���
  PrepareComplexArray4FFT(XSize, YSize, PCFilt^);
  // ��������� ������ � �������� ������ �� ������������ ������ ��� ������
  Complex2RealArray(XSize, YSize, PCFilt^, POut4, 4, True);
  // --- ����� ���������������� ---
  // ��������� ������
  MultiplySpectrum4Shift(XSize, YSize, WX, WY, WX0, WY0, PC^, PCFilt^, 8 * Pi / 5, IsMakeSin);
  // ��������� ������ � �������� ������ �� ������������ ������ ��� ������
  Complex2RealArray(XSize, YSize, PCFilt^, PSpectrPosle, 4, True);
  // ������� ���� ��� ��������� �����
  plan := fftw_plan_dft_2d(YSize, XSize, Addr(PCFilt^[0]), Addr(PCFilt^[0]),
                           FFTW_BACKWARD, FFTW_ESTIMATE);
  // ��������� �����
  fftw_execute(plan);
  // ���������� ����
  fftw_destroy_plan(plan);
  // ������� ������ ����� ����� - ����� ����������� ����� ���������� ���
  PrepareComplexArray4FFT(XSize, YSize, PCFilt^);
  // ��������� ������ � �������� ������ �� ������������ ������ ��� ������
  Complex2RealArray(XSize, YSize, PCFilt^, POut5, 4, True);
  // ��������� ����������������
  NormRealArray(XSize, YSize, POut1, 0, 255);
  NormRealArray(XSize, YSize, POut2, 0, 255);
  NormRealArray(XSize, YSize, POut3, 0, 255);
  NormRealArray(XSize, YSize, POut4, 0, 255);
  NormRealArray(XSize, YSize, POut5, 0, 255);
  // ����������� ������
  FreeMem(PC, XSize*YSize*2*SizeOf(TReal));
  FreeMem(PCFilt, XSize*YSize*2*SizeOf(TReal));
end;

end.
 