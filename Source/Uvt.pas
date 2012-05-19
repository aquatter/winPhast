unit Uvt;

interface

uses
  VirtualTrees, UProjectData, Controls, Classes, Messages, Windows, StdCtrls, Mask, Graphics;

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
    ptDoTilt,
    ptDoUnwrap,
    ptDoMean,
    ptDoBase
  );


  PVtNodeData = ^TVtNodeData;
  TVtNodeData = record
    pd: TProjectData;
    num_seq, num_rec, num_img: integer;
    name, value: string;
    type_: (ntImage, ntPhase, ntUnwrap, ntSeq, ntRec, ntImage_root, ntHeader, ntParam, ntMask1, ntMask2);
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
procedure SaveMaskAndUpdateVt(maskType: TActiveMask);

implementation

uses Unit1, Forms, SysUtils, crude, panel1, UPhast2Vars, UTProjectCalculationThread;

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
  vt.TreeOptions.SelectionOptions:= vt.TreeOptions.SelectionOptions + [toFullRowSelect, toLevelSelectConstraint];
  vt.TreeOptions.AnimationOptions:= vt.TreeOptions.AnimationOptions + [toAnimatedToggle, toAdvancedAnimatedToggle];
  vt.DefaultText:= '';
  vt.BorderStyle:= bsNone;


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

end;

procedure AddToVt(var pd: TProjectData);
var t, seq_, rec_, img, img_root, p, param_node, masks_node: PVirtualNode;
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
      d^.name:= string(pd.prop_.file_name);
      d^.pd:= pd;
      d^.ValueType:= vtString;
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
          d^.name:= 'Длина волны: ' + FloatToStrF(pd.prop_.WaveLength, ffFixed, 5, 2)+'нм.';
          d^.param_type_:= ptWaveLength;
          d^.ValueType:= vtString;
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

        for j:=0 to pd.Get(i).Count-1 do
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
              img_root^.States:= img_root^.States + [vsExpanded];
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

              for k:=0 to pd.Get(i).Get(j).img.Count-1 do
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
                d^.value:= string(pd.Get(i).Get(j).phase);
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
begin
  p:= vt.GetFirstSelected(false);
  if Assigned(p) then
  begin
    d:= PVtNodeData(vt.GetNodeData(p));
    if Assigned(d) then
    begin
      case d^.type_ of
        ntImage: begin
                   s:= string(d^.pd.prop_.file_path + d^.name);
                   if FileExists(s) then
                   begin
                     LoadBmp(phase, s, varDouble);
                     pnl.DrawImage(phase, phase);
                   end;
                 end;

        ntPhase: begin
                   s:= string(d^.pd.prop_.file_path + d^.pd.Get(d^.num_seq).Get(d^.num_seq).phase);
                   if FileExists(s) then
                   begin
                     phase._type:= varDouble;
                     LoadBin(phase, s);
                     pnl.DrawImage(phase, phase);
                   end
                   else
                   begin
                     d^.pd.ClearCalculation;
                     d^.pd.Get(d^.num_seq).Get(d^.num_rec).Add2Calculation(calcPhase);
                     StartCalculationThread(d^.pd);
                   end;
                 end;
        ntMask1: begin
                   s:= string(d^.pd.prop_.file_path + d^.pd.mask1);
                   if FileExists(s) then
                   begin
                     mask_inner._type:= varByte;
                     LoadBin(mask_inner, s);

                     pnl.DrawImage(mask_inner, mask_inner);
                     d^.pd.active:= amMask1;
                   end;
                 end;
        ntMask2: begin
                   s:= string(d^.pd.prop_.file_path + d^.pd.mask2);
                   if FileExists(s) then
                   begin
                     mask_inner._type:= varByte;
                     LoadBin(mask_inner, s);

                     pnl.DrawImage(mask_inner, mask_inner);
                     d^.pd.active:= amMask2;
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

class procedure TDummyObject.OnVtPaintText(Sender: TBaseVirtualTree; const TargetCanvas: TCanvas; Node: PVirtualNode; Column: TColumnIndex; TextType: TVSTTextType);
var d: PVtNodeData;
begin
  d:= Sender.GetNodeData(Node);
  if Assigned(d) then
  begin
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

procedure SaveMaskAndUpdateVt(maskType: TActiveMask);
var s: string;
begin
  case maskType of
    amMask1: s:= 'mask1.bin';
    amMask2: s:= 'mask2.bin';
  end;

  CreateBin(mask_inner, string(ProjectData.prop_.file_path) + s);
  ProjectData.mask1:= AnsiString(s);
  ProjectData.active:= maskType;
  ProjectData.changed:= true;
  UpdateVt;
end;



end.
