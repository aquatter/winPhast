unit Uvt;

interface

uses
  VirtualTrees, UProjectData;

type
  PVtNodeData = ^TVtNodeData;
  TVtNodeData = record
    pd: TProjectData;
    num_seq, num_rec, num_img: integer;
    name: string;
    type_: (ntImage, ntPhase, ntUnwrap, ntSeq, ntRec, ntImage_root);
  end;

  TDummyObject = class
    class procedure OnVtGetText(Sender: TBaseVirtualTree; Node: PVirtualNode; Column: TColumnIndex;
    TextType: TVSTTextType; var CellText: UnicodeString);
    class procedure OnVtDblClick(Sender: TObject);
  end;

var
  vt: TVirtualStringTree;

procedure InitVt;
procedure AddToVt(var pd: TProjectData);


implementation

uses Unit1, Forms, Controls, SysUtils, crude, panel1, UPhast2Vars;

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
end;

procedure AddToVt(var pd: TProjectData);
var t, seq_, rec_, img, img_root, p: PVirtualNode;
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
                d^.name:= string(pd.Get(i).Get(j).phase);
                d^.type_:= ntPhase;
                d^.num_seq:= i;
                d^.num_rec:= j;
                d^.pd:= pd;
              end;
            end;

            p:= vt.AddChild(rec_);

            if Assigned(p) then
            begin
              d:= PVtNodeData(vt.GetNodeData(p));
              if Assigned(d) then
              begin
                d^.name:= string(pd.Get(i).Get(j).unwrap);
                d^.type_:= ntUnwrap;
                d^.num_seq:= i;
                d^.num_rec:= j;
                d^.pd:= pd;
              end;
            end;
          end;
        end;
      end;
    end;
  end;
end;

{ TDummyObject }

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
                     LoadBmp(int, s, varByte);
                     pnl.DrawImage(int, int);
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
  if d <> nil then
    CellText:= d^.name;


end;

end.
