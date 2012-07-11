unit Uvt;

interface

uses
  VirtualTrees, UProjectData, Controls, Classes, Messages, Windows, StdCtrls, Mask, Graphics, panel1, t666;

type
   TValueType = (
    vtNone,
    vtString,
    vtPickString,
    vtNumber,
    vtPickNumber,
    vtMemo,
    vtDate,
    vtBoolean
  );

  TParamType = (
    ptNone,
    ptWaveLength,
    ptWaveLength2,
    ptDoTilt,
    ptDoUnwrap,
    ptDoMean,
    ptDoBase
  );

  TNodeType = (
    ntImage,
    ntPhase,
    ntUnwrap,
    ntSeq,
    ntRec,
    ntImage_root,
    ntHeader,
    ntParam,
    ntMask1,
    ntMask2,
    ntAmp,
    ntCombinedMask,
    ntMean_Unwrap,
    ntWaveLength2_root,
    ntImage2_root,
    ntImage2,
    ntPhase2,
    ntAmp2
  );


  PVtNodeData = ^TVtNodeData;
  TVtNodeData = record
    pd: TProjectData;
    num_seq, num_rec, num_img: integer;
    name, value: string;
    type_: TNodeType;
    param_type_: TParamType;
    ValueType: TValueType;
  end;

  TDummyObject = class
    class procedure OnVtGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
    TextType: TVSTTextType; var CellText: UnicodeString);
    class procedure OnVtDblClick(Sender: TObject);
    class procedure OnVtEditing(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
    class procedure OnVtChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
    class procedure OnVtCreateEditor(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; out EditLink: IVTEditLink);
    class procedure OnVtPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
    class procedure OnVtKeyPress(Sender: TObject; var Key: Char);
  end;

  TVtEditLink = class(TInterfacedObject, IVTEditLink)
  private
    FEdit: TWinControl;
    FTree: TVirtualStringTree;
    FNode: PVirtualNode;
    FColumn: Integer;
  protected
    procedure EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  public
    destructor Destroy; override;

    function BeginEdit: Boolean; stdcall;
    function CancelEdit: Boolean; stdcall;
    function EndEdit: Boolean; stdcall;
    function GetBounds: TRect; stdcall;
    function PrepareEdit(Tree: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex): Boolean; stdcall;
    procedure ProcessMessage(var Message: TMessage); stdcall;
    procedure SetBounds(R: TRect); stdcall;
  end;


var
  vt: TVirtualStringTree;

procedure InitVt;
procedure AddToVt(var pd: TProjectData);
procedure UpdateVt;
procedure SaveMaskAndUpdateVt(pd: TProjectData; var mask: TMyInfernalType; maskType: TActiveMask);
procedure CheckAndLoadMask(pd: TProjectData; var mask: TMyInfernalType; maskType: TActiveMask);
procedure AddMask(pd: TProjectData; pnl_: tpanel1; Shape: TDrawMode; mask_: TActiveMask; var p, mask: TMyInfernalType);
procedure SubstructMask(pd: TProjectData; pnl_: tpanel1; Shape: TDrawMode; mask_: TActiveMask; var p, mask: TMyInfernalType);
procedure ClearMask(pd: TProjectData; pnl_: tpanel1; mask_: TActiveMask; var p, mask: TMyInfernalType);
procedure SelectAll(pd: TProjectData; pnl_: tpanel1; mask_: TActiveMask; var p, mask: TMyInfernalType);
procedure SaveVtNode;
procedure RecalculateNode;
procedure Project_rename(pd: TProjectData);

implementation

uses Unit1, Forms, SysUtils, crude, UPhast2Vars, UTProjectCalculationThread, Dialogs;

procedure InitVt;
var col: TVirtualTreeColumn;
    i,j: integer;
    p: PVirtualNode;
begin
  vt:= TVirtualStringTree.Create(Form1.Panel2);
  vt.Parent:= Form1.Panel2;
  vt.Align:= alClient;
  vt.NodeDataSize:= SizeOf(TVtNodeData);
  vt.TreeOptions.PaintOptions:= vt.TreeOptions.PaintOptions + [toShowHorzGridLines];
  vt.TreeOptions.SelectionOptions:= vt.TreeOptions.SelectionOptions + [toFullRowSelect, toLevelSelectConstraint, toRightClickSelect];
  vt.TreeOptions.AnimationOptions:= vt.TreeOptions.AnimationOptions + [toAnimatedToggle, toAdvancedAnimatedToggle];
  vt.DefaultText:= '';
  vt.BorderStyle:= bsNone;
  vt.PopupMenu:= form1.PopupMenu1;

//  vt.Header.Options:= vt.Header.Options + [hoVisible, hoColumnResize, hoAutoSpring];

//  col:= vt.Header.Columns.Add;
//  col.Width:= 150;
//  col.Position:= 0;
//  col.Options:= col.Options + [coVisible, coAllowFocus, coAutoSpring, coEnabled, coResizable, coAutoSpring, coSmartResize];

//  for i:=0 to 10 do
//  begin
//    p:=vt.AddChild(nil);
//    p^.States:= p^.States + [vsExpanded];
//      for j:=0 to 10 do
//        vt.AddChild(p);
//
//  end;





  vt.OnGetText:= TDummyObject.OnVtGetText;
  vt.OnDblClick:= TDummyObject.OnVtDblClick;
  vt.OnEditing:= TDummyObject.OnVtEditing;
  vt.OnChange:= TDummyObject.OnVtChange;
  vt.OnCreateEditor:= TDummyObject.OnVtCreateEditor;
  vt.OnPaintText:= TDummyObject.OnVtPaintText;
//  vt.OnKeyPress:= TDummyObject.OnVtKeyPress;

end;

procedure AddToVt(var pd: TProjectData);
var t, seq_, rec_, img, img_root, p, param_node, masks_node, wavelength2_node: PVirtualNode;
    d: PVtNodeData;
    i, j, k: integer;
begin
  t:= vt.AddChild(nil);
  if Assigned(t) then
  begin
    t^.States:= t^.States + [vsExpanded];
    d:= PVtNodeData(vt.GetNodeData(t));
    if Assigned(d) then
    begin
      d^.name:= pd.prop_.project_name; // string(pd.prop_.file_name);
      d^.pd:= pd;
      d^.ValueType:= vtNone;
      d^.type_:= ntHeader;
      d^.param_type_:= ptNone;
    end;

    param_node:= vt.AddChild(t);
    if Assigned(param_node) then
    begin
      param_node^.States:= param_node^.States + [vsExpanded];
      d:= vt.GetNodeData(param_node);
      if Assigned(d) then
        d^.name:= 'Параметры';

      p:= vt.AddChild(param_node);
      if Assigned(p) then
      begin
        d:= vt.GetNodeData(p);
        if Assigned(d) then
        begin
          d^.name:= 'Длина волны 1: ' + FloatToStrF(pd.prop_.WaveLength, ffFixed, 5, 2)+'нм.';
          d^.param_type_:= ptWaveLength;
          d^.ValueType:= vtString;
          d^.type_:= ntParam;
          d^.pd:= pd;
        end;
      end;

      if pd.prop_.how_many_wavelengths = 2 then
      begin
        p:= vt.AddChild(param_node);
        if Assigned(p) then
        begin
          d:= vt.GetNodeData(p);
          if Assigned(d) then
          begin
            d^.name:= 'Длина волны 2: ' + FloatToStrF(pd.prop_.WaveLength2, ffFixed, 5, 2)+'нм.';
            d^.param_type_:= ptWaveLength2;
            d^.ValueType:= vtString;
            d^.type_:= ntParam;
            d^.pd:= pd;
          end;
        end;
      end;
      {
      p:= vt.AddChild(param_node);
      if Assigned(p) then
      begin
        d:= vt.GetNodeData(p);
        if Assigned(d) then
        begin
          if pd.prop_.doTilt then
            d^.name:= 'Вычитать клин: да'
          else
            d^.name:= 'Вычитать клин: нет';
          d^.param_type_:= ptDoTilt;
          d^.ValueType:= vtBoolean;
          d^.type_:= ntParam;
          d^.pd:= pd;
        end;
      end;

      p:= vt.AddChild(param_node);
      if Assigned(p) then
      begin
        d:= vt.GetNodeData(p);
        if Assigned(d) then
        begin
          if pd.prop_.doUnwrap then
            d^.name:= 'Сшивать фазу: да'
          else
            d^.name:= 'Сшивать фазу: нет';
          d^.param_type_:= ptDoUnwrap;
          d^.ValueType:= vtBoolean;
          d^.type_:= ntParam;
          d^.pd:= pd;
        end;
      end;

      p:= vt.AddChild(param_node);
      if Assigned(p) then
      begin
        d:= vt.GetNodeData(p);
        if Assigned(d) then
        begin
          if pd.prop_.doBase then
            d^.name:= 'Вычитать базу: да'
          else
            d^.name:= 'Вычитать базу: нет';
          d^.param_type_:= ptDoBase;
          d^.ValueType:= vtBoolean;
          d^.type_:= ntParam;
          d^.pd:= pd;
        end;
      end;

      p:= vt.AddChild(param_node);
      if Assigned(p) then
      begin
        d:= vt.GetNodeData(p);
        if Assigned(d) then
        begin
          if pd.prop_.doMean then
            d^.name:= 'Усреднять результат: да'
          else
            d^.name:= 'Усреднять результат: нет';
          d^.param_type_:= ptDoMean;
          d^.ValueType:= vtBoolean;
          d^.type_:= ntParam;
          d^.pd:= pd;
        end;
      end;
      }
    end;

    masks_node:= vt.AddChild(t);
    if Assigned(masks_node) then
    begin
      masks_node.States:= masks_node.States + [vsExpanded];

      d:= vt.GetNodeData(masks_node);
      if Assigned(d) then
      begin
        d^.name:= 'Маски';
        d^.ValueType:= vtNone;
        d^.pd:= pd;
      end;

      p:= vt.AddChild(masks_node);
      if Assigned(p) then
      begin
        d:= vt.GetNodeData(p);
        if Assigned(d) then
        begin
          d^.name:= 'Маска 1: ';
          d^.value:= string(pd.mask1);
          d^.ValueType:= vtNone;
          d^.type_:= ntMask1;
          d^.pd:= pd;
        end;
      end;

      p:= vt.AddChild(masks_node);
      if Assigned(p) then
      begin
        d:= vt.GetNodeData(p);
        if Assigned(d) then
        begin
          d^.name:= 'Маска 2: ';
          d^.value:= string(pd.mask2);
          d^.ValueType:= vtNone;
          d^.type_:= ntMask2;
          d^.pd:= pd;
        end;
      end;

      p:= vt.AddChild(masks_node);
      if Assigned(p) then
      begin
        d:= vt.GetNodeData(p);
        if Assigned(d) then
        begin
          d^.name:= 'Общая маска';
          d^.ValueType:= vtNone;
          d^.type_:= ntCombinedMask;
          d^.pd:= pd;
        end;
      end;
    end;

    for i:=0 to pd.Count-1 do
    begin
      seq_:= vt.AddChild(t);
      if Assigned(seq_) then
      begin

        seq_^.States:= seq_^.States + [vsExpanded];
        d:= PVtNodeData(vt.GetNodeData(seq_));
        if Assigned(d) then
        begin
          d^.name:= 'Серия '+ IntToStr(i+1);
          d^.type_:= ntSeq;
          d^.num_seq:= i;
          d^.pd:= pd;
          d^.ValueType:= vtNone;
        end;

        for j:=0 to pd[i].Count-1 do
        begin
          rec_:= vt.AddChild(seq_);

          if Assigned(rec_) then
          begin
            rec_^.States:= rec_^.States + [vsExpanded];
            d:= PVtNodeData(vt.GetNodeData(rec_));

            if Assigned(d) then
            begin
              d^.name:= 'Измерение '+ IntToStr(j+1);
              d^.type_:= ntRec;
              d^.num_seq:= i;
              d^.num_rec:= j;
              d^.pd:= pd;
              d^.ValueType:= vtNone;
            end;

            img_root:= vt.AddChild(rec_);

            if Assigned(img_root) then
            begin
//              img_root^.States:= img_root^.States + [vsExpanded];
              d:= PVtNodeData(vt.GetNodeData(img_root));

              if Assigned(d) then
              begin
                d^.name:= 'Интерферограммы';
                d^.type_:= ntImage_root;
                d^.num_seq:= i;
                d^.num_rec:= j;
                d^.pd:= pd;
                d^.ValueType:= vtNone;
              end;

              for k:=0 to pd[i][j].img.Count-1 do
              begin
                img:= vt.AddChild(img_root);

                if Assigned(img) then
                begin
                  d:= PVtNodeData(vt.GetNodeData(img));

                  if Assigned(d) then
                  begin
                    d^.name:= string(pd.Get(i).Get(j).img[k]);
                    d^.type_:= ntImage;
                    d^.num_seq:= i;
                    d^.num_rec:= j;
                    d^.num_img:= k;
                    d^.pd:= pd;
                    d^.ValueType:= vtNone;
                  end;
                end;
              end;
            end;

            p:= vt.AddChild(rec_);

            if Assigned(p) then
            begin
              d:= PVtNodeData(vt.GetNodeData(p));
              if Assigned(d) then
              begin
                d^.name:= 'Фаза: ';
                d^.value:= string(pd[i][j].phase);
                d^.type_:= ntPhase;
                d^.num_seq:= i;
                d^.num_rec:= j;
                d^.pd:= pd;
                d^.ValueType:= vtNone;
              end;
            end;

            p:= vt.AddChild(rec_);

            if Assigned(p) then
            begin
              d:= PVtNodeData(vt.GetNodeData(p));
              if Assigned(d) then
              begin
                d^.name:= 'Амплитуда: ';
                d^.value:= string(pd[i][j].amp);
                d^.type_:= ntAmp;
                d^.num_seq:= i;
                d^.num_rec:= j;
                d^.pd:= pd;
                d^.ValueType:= vtNone;
              end;
            end;

            if pd.prop_.how_many_wavelengths = 2 then
            begin
              wavelength2_node:= vt.AddChild(rec_);
              if Assigned(wavelength2_node) then
              begin

                wavelength2_node.States:= wavelength2_node.States + [vsExpanded];

                d:= PVtNodeData(vt.GetNodeData(wavelength2_node));
                if Assigned(d) then
                begin
                  d^.name:= 'Длина волны 2';
                  d^.type_:= ntWaveLength2_root;
                  d^.num_seq:= i;
                  d^.num_rec:= j;
                  d^.pd:= pd;
                  d^.ValueType:= vtNone;
                end;


                img_root:= vt.AddChild(wavelength2_node);
                if Assigned(img_root) then
                begin
                  d:= PVtNodeData(vt.GetNodeData(img_root));
                  if Assigned(d) then
                  begin
                    d^.name:= 'Интерферограммы';
                    d^.type_:= ntImage2_root;
                    d^.num_seq:= i;
                    d^.num_rec:= j;
                    d^.pd:= pd;
                    d^.ValueType:= vtNone;
                  end;

                  for k:=0 to pd[i][j].img2.Count-1 do
                  begin
                    img:= vt.AddChild(img_root);

                    if Assigned(img) then
                    begin
                      d:= PVtNodeData(vt.GetNodeData(img));

                      if Assigned(d) then
                      begin
                        d^.name:= string(pd[i][j].img2[k]);
                        d^.type_:= ntImage2;
                        d^.num_seq:= i;
                        d^.num_rec:= j;
                        d^.num_img:= k;
                        d^.pd:= pd;
                        d^.ValueType:= vtNone;
                      end;
                    end;
                  end;
                end;

                p:= vt.AddChild(wavelength2_node);

                if Assigned(p) then
                begin
                  d:= PVtNodeData(vt.GetNodeData(p));
                  if Assigned(d) then
                  begin
                    d^.name:= 'Фаза: ';
                    d^.value:= string(pd[i][j].phase2);
                    d^.type_:= ntPhase2;
                    d^.num_seq:= i;
                    d^.num_rec:= j;
                    d^.pd:= pd;
                    d^.ValueType:= vtNone;
                  end;
                end;

                p:= vt.AddChild(wavelength2_node);

                if Assigned(p) then
                begin
                  d:= PVtNodeData(vt.GetNodeData(p));
                  if Assigned(d) then
                  begin
                    d^.name:= 'Амплитуда: ';
                    d^.value:= string(pd[i][j].amp2);
                    d^.type_:= ntAmp2;
                    d^.num_seq:= i;
                    d^.num_rec:= j;
                    d^.pd:= pd;
                    d^.ValueType:= vtNone;
                  end;
                end;
              end;
            end;

            p:= vt.AddChild(rec_);

            if Assigned(p) then
            begin
              d:= PVtNodeData(vt.GetNodeData(p));
              if Assigned(d) then
              begin
                d^.name:= 'Сшитая фаза: ';
                d^.value:= string(pd.Get(i).Get(j).unwrap);
                d^.type_:= ntUnwrap;
                d^.num_seq:= i;
                d^.num_rec:= j;
                d^.pd:= pd;
                d^.ValueType:= vtNone;
              end;
            end;
          end;
        end;

        p:= vt.AddChild(seq_);
        if Assigned(p) then
        begin
          p.States:= p.States + [vsExpanded];
          d:= vt.GetNodeData(p);
          if Assigned(d) then
          begin
            d^.name:= 'Среднее значение';
            d^.ValueType:= vtNone;
            d^.num_seq:= i;
            d^.num_rec:= -1;
            d^.pd:= pd;
          end;
          p:= vt.AddChild(p);
          if Assigned(p) then
          begin
            p.States:= p.States + [vsExpanded];
            d:= vt.GetNodeData(p);
            if Assigned(d) then
            begin
              d^.value:= string(pd[i].mean_unwrap);
              d^.type_:= ntMean_Unwrap;
              d^.ValueType:= vtNone;
              d^.num_seq:= i;
              d^.num_rec:= -1;
              d^.pd:= pd;
            end;
          end;
        end;

      end;
    end;
  end;
end;

{ TDummyObject }

class procedure TDummyObject.OnVtEditing(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; var Allowed: Boolean);
var p: PVtNodeData;
begin
  p:= Sender.GetNodeData(Node);
  if Assigned(p) then
    Allowed:= (p^.ValueType <> vtNone);
end;

class procedure TDummyObject.OnVtChange(Sender: TBaseVirtualTree; Node: PVirtualNode);
begin
  if Assigned(Node) then
    PostMessage(Form1.Handle, WM_STARTEDITING, Integer(Node), 0);
end;

class procedure TDummyObject.OnVtCreateEditor(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex; out EditLink: IVTEditLink);
begin
  EditLink:= TVtEditLink.Create;
end;

class procedure TDummyObject.OnVtDblClick(Sender: TObject);
var p: PVirtualNode;
    d: PVtNodeData;
    s: string;
    i: integer;
begin
  p:= vt.GetFirstSelected(false);
  if Assigned(p) then
  begin
    d:= PVtNodeData(vt.GetNodeData(p));
    if Assigned(d) then
    begin
      case d^.type_ of
        ntImage, ntImage2: begin

                   if d^.type_ = ntImage then
                     s:= string(d^.pd.prop_.file_path + d^.pd[d^.num_seq][d^.num_rec].img[d^.num_img])
                   else
                     s:= string(d^.pd.prop_.file_path + d^.pd[d^.num_seq][d^.num_rec].img2[d^.num_img]);

                   if FileExists(s) then
                   begin
                     LoadBmp(phase, s, varDouble);
                     pnl.DrawImage(phase, phase);
                   end;
                 end;

        ntPhase, ntPhase2: begin
                   if d^.type_ = ntPhase then
                     s:= string(d^.pd.prop_.file_path + d^.pd[d^.num_seq][d^.num_rec].phase)
                   else
                     s:= string(d^.pd.prop_.file_path + d^.pd[d^.num_seq][d^.num_rec].phase2);

                   if FileExists(s) then
                   begin
                     phase._type:= varDouble;
                     LoadBin(phase, s);
                     pnl.DrawImage(phase, phase);
                   end
                   else
                   begin
                     d^.pd.ClearCalculation;

                     if d^.type_ = ntPhase then
                       d^.pd[d^.num_seq][d^.num_rec].Add2Calculation(calcPhase)
                     else
                       d^.pd[d^.num_seq][d^.num_rec].Add2Calculation(calcPhase2);

                     d^.pd[d^.num_seq][d^.num_rec].phase_calculated:= false;
                     StartCalculationThread(d^.pd);
                   end;
                 end;
        ntAmp, ntAmp2: begin
                 if d^.type_ = ntAmp then
                   s:= string(d^.pd.prop_.file_path + d^.pd[d^.num_seq][d^.num_rec].amp)
                 else
                   s:= string(d^.pd.prop_.file_path + d^.pd[d^.num_seq][d^.num_rec].amp2);

                 if FileExists(s) then
                 begin
                   phase._type:= varDouble;
                   LoadBin(phase, s);
                   pnl.DrawImage(phase, phase);
                 end
                 else
                 begin
                   d^.pd.ClearCalculation;
                   if d^.type_ = ntAmp then
                     d^.pd[d^.num_seq][d^.num_rec].Add2Calculation(calcAmp)
                   else
                     d^.pd[d^.num_seq][d^.num_rec].Add2Calculation(calcAmp2);
                   StartCalculationThread(d^.pd);
                 end;
               end;
        ntMask1: begin
                   s:= string(d^.pd.prop_.file_path + d^.pd.mask1);
                   if FileExists(s) then
                   begin
                     mask_inner._type:= varByte;
                     LoadBin(mask_inner, s);

                     pnl.DrawImage(phase, mask_inner);
                     d^.pd.active:= amMask1;
                     vt.Repaint;
                   end;
                 end;
        ntMask2: begin
                   s:= string(d^.pd.prop_.file_path + d^.pd.mask2);
                   if FileExists(s) then
                   begin
                     mask_inner._type:= varByte;
                     LoadBin(mask_inner, varByte, s);

                     pnl.DrawImage(phase, mask_inner);
                     d^.pd.active:= amMask2;
                     vt.Repaint;
                   end;
                 end;
        ntCombinedMask: begin
                          if FileExists(string(d^.pd.prop_.file_path + d^.pd.mask1)) and FileExists(string(d^.pd.prop_.file_path + d^.pd.mask2)) then
                          begin
                            LoadBin(mask_inner, varByte, string(d^.pd.prop_.file_path + d^.pd.mask1));
                            LoadBin(mask_outer, varByte, string(d^.pd.prop_.file_path + d^.pd.mask2));

                            for i:=0 to mask_inner.w*mask_inner.h-1 do
                              if mask_outer.b^[i] = 1 then
                                mask_inner.b^[i]:= 1;

                            pnl.DrawImage(phase, mask_inner);
                            d^.pd.active:= amCombined;
                            vt.Repaint;
                          end;
                        end;
        ntUnwrap: begin
                    s:= string(d^.pd.prop_.file_path + d^.pd[d^.num_seq][d^.num_rec].unwrap);
                    if FileExists(s) then
                    begin
                      phase._type:= varDouble;
                      LoadBin(phase, s);
                      if CheckMask(mask_inner) then
                        pnl.DrawImage(phase, mask_inner)
                      else
                        pnl.DrawImage(phase, phase);
                    end
                    else
                    begin
                      d^.pd.ClearCalculation;
                      {
                      s:= string(d^.pd.prop_.file_path + d^.pd[d^.num_seq][d^.num_rec].phase);
                      if not FileExists(s) then
                      begin
                        d^.pd[d^.num_seq][d^.num_rec].Add2Calculation(calcPhase);
                        d^.pd[d^.num_seq][d^.num_rec].phase_calculated:= false;
                      end;
                      }
                      d^.pd[d^.num_seq][d^.num_rec].Add2Calculation(calcUnwrap);
                      d^.pd[d^.num_seq][d^.num_rec].unwrap_calculated:= false;
                      StartCalculationThread(d^.pd);
                    end;
                  end;
        ntMean_Unwrap:  begin
                          s:= string(d^.pd.prop_.file_path + d^.pd[d^.num_seq].mean_unwrap);

                          if FileExists(s) then
                          begin
                            LoadBin(phase, varDouble, s);

                            if CheckMask(mask_inner) then
                              pnl.DrawImage(phase, mask_inner)
                            else
                              pnl.DrawImage(phase, phase);

                          end
                          else
                          begin
                            d^.pd.ClearCalculation;
                            d^.pd[d^.num_seq].doMean:= true;
                            StartCalculationThread(d^.pd);
                          end;

                        end;
      end;

    end;
  end;
end;

class procedure TDummyObject.OnVtGetText(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType;
  var CellText: UnicodeString);
var d: PVtNodeData;
begin
  d:= PVtNodeData(Sender.GetNodeData(Node));
  if Assigned(d) then
  begin
    CellText:= d^.name + d^.value;
    if d^.type_ =  ntHeader then
      if d^.pd.changed then
        CellText:= CellText + '*';

  end;


end;

class procedure TDummyObject.OnVtKeyPress(Sender: TObject; var Key: Char);
var node: PVirtualNode;
    d: PVtNodeData;
begin
  node:= vt.GetFirstSelected();
  if Assigned(node) then
  begin
    ShowMessage(IntToStr(integer(Key)));



  end;

end;

class procedure TDummyObject.OnVtPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
var d: PVtNodeData;

procedure ChangeFont(node_type: TNodeType; active_mask: TActiveMask);
begin
  if node_type = d^.type_ then
    if d^.pd.active = active_mask then
        TargetCanvas.Font.Style:= [fsBold]
      else
        TargetCanvas.Font.Style:= [];
end;


begin
  d:= Sender.GetNodeData(Node);
  if Assigned(d) then
  begin
    ChangeFont(ntMask1, amMask1);
    ChangeFont(ntMask2, amMask2);
    ChangeFont(ntCombinedMask, amCombined);

    {
    if d^.type_ = ntMask1 then
      if d^.pd.active = amMask1 then
        TargetCanvas.Font.Style:= [fsBold]
      else
        TargetCanvas.Font.Style:= [];

    if d^.type_ = ntMask2 then
      if d^.pd.active = amMask2 then
        TargetCanvas.Font.Style:= [fsBold]
      else
        TargetCanvas.Font.Style:= [];
     }
  end;
end;


procedure UpdateVt;
begin
  vt.Clear;
  AddToVt(ProjectData);
end;


destructor TVtEditLink.Destroy;
begin
  FEdit.Free;
  inherited;
end;


procedure TVtEditLink.EditKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  CanAdvance: Boolean;
begin
  CanAdvance := true;

  case Key of
    VK_ESCAPE:
      if CanAdvance then
      begin
        FTree.CancelEditNode;
        Key := 0;
      end;
    VK_RETURN:
      if CanAdvance then
      begin
        FTree.EndEditNode;
        Key := 0;
      end;

    VK_UP,
    VK_DOWN:
      begin
        // Consider special cases before finishing edit mode.
        CanAdvance := Shift = [];
        if FEdit is TComboBox then
          CanAdvance := CanAdvance and not TComboBox(FEdit).DroppedDown;

        if CanAdvance then
        begin
          // Forward the keypress to the tree. It will asynchronously change the focused node.
          PostMessage(FTree.Handle, WM_KEYDOWN, Key, 0);
          Key := 0;
        end;
      end;
  end;
end;

function TVtEditLink.BeginEdit: Boolean;
begin
  Result:= True;
  FEdit.Show;
  FEdit.SetFocus;
end;

function TVtEditLink.CancelEdit: Boolean;
begin
  Result:= True;
  FEdit.Hide;
end;

function TVtEditLink.EndEdit: Boolean;
var
  Data: PVtNodeData;
  Buffer: array[0..1024] of Char;
  s: UnicodeString;
  b, changed: boolean;
  new_wl: double;
begin
  Result := True;
  Data := FTree.GetNodeData(FNode);
  if FEdit is TComboBox then
    s:= TComboBox(FEdit).Text
  else
  begin
    GetWindowText(FEdit.Handle, Buffer, 1024);
    s:= Buffer;
  end;

  changed:= false;

  case Data^.type_ of
    ntHeader: begin
                changed:= Data^.pd.prop_.project_name <> string(s);
                Data^.pd.prop_.project_name:= s;
                Data^.name:= s + '.winPhast';
             end;
    ntParam: begin

               b:= false;
               if Data^.ValueType = vtBoolean then
                 b:= (FEdit as TComboBox).ItemIndex = 0;

               case Data^.param_type_ of
                 ptWaveLength: begin
                                 new_wl:= CheckString(s);
                                 changed:= Data^.pd.prop_.WaveLength <> new_wl;
                                 Data^.pd.prop_.WaveLength:= new_wl;
                                 Data^.name:= 'Длина волны: ' + FloatToStrF(Data^.pd.prop_.WaveLength, ffFixed, 5, 2);
                               end;
                 ptWaveLength2: begin
                                  new_wl:= CheckString(s);
                                  changed:= Data^.pd.prop_.WaveLength2 <> new_wl;
                                  Data^.pd.prop_.WaveLength2:= new_wl;
                                  Data^.name:= 'Длина волны: ' + FloatToStrF(Data^.pd.prop_.WaveLength2, ffFixed, 5, 2);
                                end;
                 ptDoTilt: begin
                             changed:= Data^.pd.prop_.doTilt <> b;
                             Data^.pd.prop_.doTilt:= b;
                             Data^.name:= 'Вычитать клин: '+ s;
                           end;
                 ptDoMean: begin
                             changed:= Data^.pd.prop_.doMean <> b;
                             Data^.pd.prop_.doMean:= b;
                             Data^.name:= 'Усреднять результат в серии: '+ s;
                           end;

                 ptDoUnwrap: begin
                               changed:= Data^.pd.prop_.doUnwrap <> b;
                               Data^.pd.prop_.doUnwrap:= b;
                               Data^.name:= 'Сшивать фазу: '+ s;
                             end;
                 ptDoBase: begin
                             changed:= Data^.pd.prop_.doBase <> b;
                             Data^.pd.prop_.doBase:= b;
                             Data^.name:= 'Вычитать базу: '+ s;
                           end;
               end;
             end;
  end;

  Data^.pd.changed:= changed;
  FTree.InvalidateNode(FNode);
  {if S <> Data^.name then
  begin
    Data.Value := S;
    Data.Changed := True;
    FTree.InvalidateNode(FNode);
  end;
   }
  FEdit.Hide;
  FTree.SetFocus;
end;

function TVtEditLink.GetBounds: TRect;
begin
  Result:= FEdit.BoundsRect;
end;

function TVtEditLink.PrepareEdit(Tree: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex): Boolean;
var
  Data: PVtNodeData;
  b: boolean;
begin
  Result := True;
  FTree := Tree as TVirtualStringTree;
  FNode := Node;
  FColumn := Column;

  // determine what edit type actually is needed
  FEdit.Free;
  FEdit := nil;
  Data := FTree.GetNodeData(Node);
  case Data.ValueType of
    vtString:
      begin
        FEdit := TEdit.Create(nil);
        with FEdit as TEdit do
        begin
          Visible := False;
          Parent := Tree;
          if Data^.type_ = ntHeader then
            Text:= Data^.pd.prop_.project_name;
          if Data^.param_type_= ptWaveLength  then
            Text:= FloatToStrF(Data^.pd.prop_.WaveLength, ffFixed, 5, 2);
          if Data^.param_type_= ptWaveLength2  then
            Text:= FloatToStrF(Data^.pd.prop_.WaveLength2, ffFixed, 5, 2);
          OnKeyDown := EditKeyDown;
        end;
      end;
    vtPickString:
      begin
        FEdit := TComboBox.Create(nil);
        with FEdit as TComboBox do
        begin
          Visible := False;
          Parent := Tree;
          Text := Data^.name;
          Items.Add(Text);
          Items.Add('Standard');
          Items.Add('Additional');
          Items.Add('Win32');
          OnKeyDown := EditKeyDown;
        end;
      end;
    vtBoolean: begin
                 FEdit:= TComboBox.Create(nil);
                 with FEdit as TComboBox do
                 begin
                   Visible:= False;
                   Parent:= Tree;
                   b:= false;
                   Style:= csDropDownList;

                   case  Data^.param_type_ of
                      ptDoTilt: b:= Data^.pd.prop_.doTilt;
                      ptDoUnwrap: b:= Data^.pd.prop_.doUnwrap;
                      ptDoMean: b:= Data^.pd.prop_.doMean;
                      ptDoBase: b:= Data^.pd.prop_.doBase;
                   end;

                   Items.Add('да');
                   Items.Add('нет');

                   if b then
                     ItemIndex:= 0
                   else
                     ItemIndex:= 1;

                   OnKeyDown := EditKeyDown;
                 end;
               end;
    vtNumber:
      begin
        FEdit := TMaskEdit.Create(nil);
        with FEdit as TMaskEdit do
        begin
          Visible := False;
          Parent := Tree;
          EditMask := '9999.99';
          Text := Data^.name;
          OnKeyDown := EditKeyDown;
        end;
      end;
    vtPickNumber:
      begin
        FEdit := TComboBox.Create(nil);
        with FEdit as TComboBox do
        begin
          Visible := False;
          Parent := Tree;
          Text := Data^.name;
          OnKeyDown := EditKeyDown;
        end;
      end;
    vtMemo:
      begin
        FEdit := TComboBox.Create(nil);
        // In reality this should be a drop down memo but this requires
        // a special control.
        with FEdit as TComboBox do
        begin
          Visible := False;
          Parent := Tree;
          Text := Data^.name;
          Items.Add(Data^.name);
          OnKeyDown := EditKeyDown;
        end;
      end;
  else
    Result := False;
  end;
end;

procedure TVtEditLink.ProcessMessage(var Message: TMessage);
begin
  FEdit.WindowProc(Message);
end;

procedure TVtEditLink.SetBounds(R: TRect);
var
  Dummy: Integer;
begin
  // Since we don't want to activate grid extensions in the tree (this would influence how the selection is drawn)
  // we have to set the edit's width explicitly to the width of the column.
  FTree.Header.Columns.GetColumnBounds(FColumn, Dummy, R.Right);
  FEdit.BoundsRect:= R;
end;

procedure SaveMaskAndUpdateVt(pd: TProjectData; var mask: TMyInfernalType; maskType: TActiveMask);
var s: string;
begin
  case maskType of
    amMask1: s:= 'mask1.bin';
    amMask2: s:= 'mask2.bin';
  end;

  CreateBin(mask, string(ProjectData.prop_.file_path) + s);

  case maskType of
    amMask1: pd.mask1:= AnsiString(s);
    amMask2: pd.mask2:= AnsiString(s);
  end;

  pd.active:= maskType;
  pd.changed:= true;
  UpdateVt;
end;

procedure CheckAndLoadMask(pd: TProjectData; var mask: TMyInfernalType; maskType: TActiveMask);
var s: string;
begin
  case maskType of
    amMask1: s:= 'mask1.bin';
    amMask2: s:= 'mask2.bin';
  end;

  if FileExists(string(pd.prop_.file_path) + s) then
    LoadBin(mask, string(pd.prop_.file_path) + s)
  else
    ZeroMemory(mask.b, pd.prop_.w*pd.prop_.h);

end;

procedure AddMask(pd: TProjectData; pnl_: tpanel1; Shape: TDrawMode; mask_: TActiveMask; var p, mask: TMyInfernalType);
var i, w, h, cnt: integer;
    mode: TDrawMode;
    s: string;
begin

  if not p.loaded then exit;
  w:= pd.prop_.w;
  h:= pd.prop_.h;

  CheckAndLoadMask(pd, mask, mask_);

  pnl_.Contrast_mask:=1;

  cnt:=0;
  for i:=0 to w*h-1 do
    if mask.b^[i] = 1 then
      inc(cnt);

  if cnt = 0 then
    pnl_.DrawImage(p, p)
  else
    pnl_.DrawImage(p, mask);


  mode:=pnl_.DrawMode;
  pnl_.DrawMode:=dmNone;
  pnl_.DrawMode:=Shape;


  Form1.Off(false);
  pnl_.Cursor:=Unit1.crMyShittyCursor;

  repeat
    Application.ProcessMessages;
  until pnl_.DrawMode= dmNone;
  pnl_.Cursor:=crDefault;


  pnl_.GetMask(@p, @(_mask));

  for i:=0 to w*h-1 do
    if _mask.b^[i]=1 then
      mask.b^[i]:=1;

  pnl_.DrawMode:=dmNone;
  pnl_.DrawMode:=mode;

  pnl_.DrawImage(p, mask);

  SaveMaskAndUpdateVt(pd, mask, mask_);
  form1.off(true);
end;

procedure SubstructMask(pd: TProjectData; pnl_: tpanel1; Shape: TDrawMode; mask_: TActiveMask; var p, mask: TMyInfernalType);
var i, w, h, cnt: integer;
    mode: TDrawMode;
begin
  if not p.loaded then exit;

  w:=pd.prop_.w;
  h:=pd.prop_.h;

  CheckAndLoadMask(pd, mask, mask_);

  cnt:=0;
  for i:=0 to w*h-1 do
    if mask.b^[i] = 1 then
      inc(cnt);

  if cnt = 0 then
    exit;

  mode:=pnl_.DrawMode;
  pnl_.DrawMode:=dmNone;
  pnl_.DrawMode:=Shape;
  pnl_.Contrast_mask:=1;

  pnl.DrawImage(p, mask);
  form1.off(false);
  pnl_.Cursor:= Unit1.crMyShittyCursor;

  repeat
    Application.ProcessMessages;
  until pnl.DrawMode= dmNone;
  pnl_.Cursor:=crDefault;

  pnl_.GetMask(@p, @_mask);

  for i:=0 to w*h-1 do
    if _mask.b^[i]=1 then
      mask.b^[i]:=0;

  pnl_.DrawMode:=dmNone;
  pnl_.DrawMode:=mode;

  pnl_.DrawImage(p, mask);
  SaveMaskAndUpdateVt(pd, mask, mask_);

  form1.off(true);
//  CurrentMask:=cmMask1;
//  UpdateLegendLabels;

end;

procedure ClearMask(pd: TProjectData; pnl_: tpanel1; mask_: TActiveMask; var p, mask: TMyInfernalType);
begin
  if not p.loaded then exit;
  ZeroMemory(mask.b, pd.prop_.w*pd.prop_.h);

//  FillMemory(_mask.b, cfg.cam_w*cfg.cam_h, 1);
  pnl_.Contrast_mask:=1;
  pnl_.DrawImage(p, p);

  SaveMaskAndUpdateVt(pd, mask, mask_);
end;

procedure SelectAll(pd: TProjectData; pnl_: tpanel1; mask_: TActiveMask; var p, mask: TMyInfernalType);
var i, j, w, h: integer;
begin
  if not p.loaded then exit;

  w:= pd.prop_.w;
  h:= pd.prop_.h;

  for i:=10 to h-9 do
    for j:=10 to w-9 do
      mask.b^[i*w+j]:=1;

  SaveMaskAndUpdateVt(pd, mask, mask_);

  pnl_.DrawImage(p, mask);
end;


procedure SaveVtNode;
var p: PVirtualNode;
    d: PVtNodeData;
    s, name: string;
    data: TMyInfernalType;
    masked: boolean;
begin
  data:= TMyInfernalType.Create;

  p:= vt.GetFirstSelected();
  if Assigned(p) then
  begin
    d:= vt.GetNodeData(p);
    if Assigned(d) then
    begin
      case d^.type_ of
        ntImage: ;
        ntPhase, ntAmp, ntPhase2, ntAmp2: begin
                   case d^.type_ of
                     ntPhase: s:= string(d^.pd.prop_.file_path + d^.pd[d^.num_seq][d^.num_rec].phase);
                     ntPhase2: s:= string(d^.pd.prop_.file_path + d^.pd[d^.num_seq][d^.num_rec].phase2);
                     ntAmp: s:= string(d^.pd.prop_.file_path + d^.pd[d^.num_seq][d^.num_rec].amp);
                     ntAmp2: s:= string(d^.pd.prop_.file_path + d^.pd[d^.num_seq][d^.num_rec].amp2);
                   end;

                   {if d^.type_ = ntPhase then
                     s:= string(d^.pd.prop_.file_path + d^.pd[d^.num_seq][d^.num_rec].phase)
                   else
                     s:= string(d^.pd.prop_.file_path + d^.pd[d^.num_seq][d^.num_rec].amp);}

                   if FileExists(s) then
                   begin
                     LoadBin(data, varDouble, s);

                     Form1.SaveDialog1.Filter:= 'bmp-file|*.bmp|matlab-file|*.m|txt-file|*.txt';
                     Form1.SaveDialog1.Title:= 'Введите имя файла';

                     if Form1.SaveDialog1.Execute then
                     begin
                       name:= form1.SaveDialog1.FileName;
                       case Form1.SaveDialog1.FilterIndex of
                         1: begin
                              name:= ChangeFileExt(name, '.bmp');
                              CreateBmp(data, true, name);
                            end;

                         2: begin
                              name:= ChangeFileExt(name, '.m');
                              SaveRealArray2Matlab(data, 1, name);
                            end;

                         3: begin
                              name:= ChangeFileExt(name, '.txt');
                              SaveData2Txt(data, data, name);
                            end;
                       end;
                     end;

                   end;
                 end;
        ntUnwrap, ntMean_Unwrap:
        begin
          if d^.type_ = ntUnwrap then
            s:= string(d^.pd.prop_.file_path + d^.pd[d^.num_seq][d^.num_rec].phase)
          else
            s:= string(d^.pd.prop_.file_path + d^.pd[d^.num_seq].mean_unwrap);

          if FileExists(s) then
          begin
            LoadBin(data, varDouble, s);

            Form1.SaveDialog1.Filter:= 'bmp-file|*.bmp|matlab-file|*.m|txt-file|*.txt';
            Form1.SaveDialog1.Title:= 'Введите имя файла';

            masked:= CheckMask(mask_inner);

            if Form1.SaveDialog1.Execute then
            begin
              name:= form1.SaveDialog1.FileName;
              case Form1.SaveDialog1.FilterIndex of
                1: begin
                     name:= ChangeFileExt(name, '.bmp');
                     if masked then
                       CreateBmp(data, mask_inner, true, name)
                     else
                       CreateBmp(data, true, name);
                   end;

                2: begin
                     name:= ChangeFileExt(name, '.m');
                     SaveRealArray2Matlab(data, 1, name);
                   end;

                3: begin
                     name:= ChangeFileExt(name, '.txt');
                     if masked then
                       SaveData2Txt(data, mask_inner, name)
                     else
                       SaveData2Txt(data, data, name);
                   end;
              end;
            end;

          end;
        end;
      end;
    end;
  end;
  data.Destroy;

end;

procedure RecalculateNode;
var p: PVirtualNode;
    d: PVtNodeData;
    s, name: string;
    data: TMyInfernalType;
    masked: boolean;
    i,j: integer;
begin
  p:= vt.GetFirstSelected();
  if Assigned(p) then
  begin
    d:= vt.GetNodeData(p);
    if Assigned(d) then
    begin
      case d^.type_ of
        ntPhase, ntAmp:
        begin

          if d^.type_ = ntAmp then
            s:= string(d^.pd.prop_.file_path + d^.pd[d^.num_seq][d^.num_rec].amp)
          else
            s:= string(d^.pd.prop_.file_path + d^.pd[d^.num_seq][d^.num_rec].phase);

          if FileExists(s) then
            DeleteFile(s);

          d^.pd.ClearCalculation;
          if d^.type_ = ntAmp then
            d^.pd[d^.num_seq][d^.num_rec].Add2Calculation(calcAmp)
          else
            d^.pd[d^.num_seq][d^.num_rec].Add2Calculation(calcPhase);

          d^.pd[d^.num_seq][d^.num_rec].phase_calculated:= false;
          StartCalculationThread(d^.pd);
        end;
        ntUnwrap:
        begin
          s:= string(d^.pd.prop_.file_path + d^.pd[d^.num_seq][d^.num_rec].unwrap);
          if FileExists(s) then
            DeleteFile(s);

          d^.pd[d^.num_seq][d^.num_rec].Add2Calculation(calcUnwrap);
          d^.pd[d^.num_seq][d^.num_rec].unwrap_calculated:= false;
          StartCalculationThread(d^.pd);
        end;
        ntMean_Unwrap:
        begin
          s:= string(d^.pd.prop_.file_path + d^.pd[d^.num_seq].mean_unwrap);
          if FileExists(s) then
            DeleteFile(s);

          d^.pd.ClearCalculation;
          d^.pd[d^.num_seq].doMean:= true;
          StartCalculationThread(d^.pd);

        end;
        ntSeq:
        begin
          d^.pd.ClearCalculation;
          for i:=0 to d^.pd[d^.num_seq].Count-1 do
          begin
            DeleteFile(string(d^.pd.prop_.file_path + d^.pd[d^.num_seq][i].amp));
            DeleteFile(string(d^.pd.prop_.file_path + d^.pd[d^.num_seq][i].phase));
            DeleteFile(string(d^.pd.prop_.file_path + d^.pd[d^.num_seq][i].unwrap));

            d^.pd[d^.num_seq][i].Add2Calculation(calcUnwrap);
          end;
          DeleteFile(string(d^.pd.prop_.file_path + d^.pd[d^.num_seq].mean_unwrap));

          d^.pd[d^.num_seq].doMean:= cfg.do_mean;
          StartCalculationThread(d^.pd);
        end;
        ntHeader:
        begin
          for i:=0 to d^.pd.Count-1 do
          begin
            for j:=0 to d^.pd[i].Count-1 do
            begin
              DeleteFile(string(d^.pd.prop_.file_path + d^.pd[i][j].amp));
              DeleteFile(string(d^.pd.prop_.file_path + d^.pd[i][j].phase));
              DeleteFile(string(d^.pd.prop_.file_path + d^.pd[i][j].unwrap));
              d^.pd[i][j].Add2Calculation(calcUnwrap);
            end;
            DeleteFile(string(d^.pd.prop_.file_path + d^.pd[i].mean_unwrap));
            d^.pd[i].doMean:= cfg.do_mean;
          end;
          StartCalculationThread(d^.pd);
        end;
      end;
    end;
  end;
end;


procedure Project_rename(pd: TProjectData);
var node: PVirtualNode;
    d: PVtNodeData;
    old_name, new_name: string;
begin

  node:= vt.GetFirstSelected();
  if Assigned(node) then
  begin
    d:= vt.GetNodeData(node);
    if Assigned(d) then
    begin
      if not (d^.type_ = ntHeader) then
        exit;

        old_name:= pd.prop_.project_name;
        new_name:= InputBox('Переименование проекта', 'Введите новое имя проекта:', old_name);
        if old_name <> new_name then
        begin
          pd.prop_.project_name:= new_name;
          pd.changed:= true;
          UpdateVt;
        end;
    end;
  end;

end;

end.
