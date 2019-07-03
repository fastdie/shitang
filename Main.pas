unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniPanel, uniPageControl,
  uniGUIBaseClasses, uniButton, uniLabel, uniEdit, uniGroupBox, uniStatusBar,
  uniTreeView, uniDateTimePicker, uniTimer, uniMemo;

type
  TMainForm = class(TUniForm)
    UniPageControl1: TUniPageControl;
    UniTabSheet1: TUniTabSheet;
    UniTabSheet2: TUniTabSheet;
    UniTabSheet3: TUniTabSheet;
    UniGroupBox1: TUniGroupBox;
    UniEdit1: TUniEdit;
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniLabel3: TUniLabel;
    UniEdit2: TUniEdit;
    UniEdit3: TUniEdit;
    UniButton1: TUniButton;
    UniGroupBox2: TUniGroupBox;
    UniDateTimePicker1: TUniDateTimePicker;
    UniTreeView1: TUniTreeView;
    UniTreeView2: TUniTreeView;
    UniButton2: TUniButton;
    UniButton3: TUniButton;
    UniButton4: TUniButton;
    UniGroupBox3: TUniGroupBox;
    UniDateTimePicker2: TUniDateTimePicker;
    UniTreeView3: TUniTreeView;
    UniTreeView4: TUniTreeView;
    UniButton5: TUniButton;
    UniButton6: TUniButton;
    UniButton7: TUniButton;
    UniTimer1: TUniTimer;
    UniButton8: TUniButton;
    UniButton9: TUniButton;
    UniTabSheet4: TUniTabSheet;
    UniDateTimePicker3: TUniDateTimePicker;
    UniMemo1: TUniMemo;
    procedure UniFormCreate(Sender: TObject);
    procedure UniButton1Click(Sender: TObject);
    procedure UniTabSheet1BeforeActivate(Sender: TObject;
      var AllowActivate: Boolean);
    procedure UniTabSheet2BeforeActivate(Sender: TObject;
      var AllowActivate: Boolean);
    procedure UniDateTimePicker1Change(Sender: TObject);
    procedure UniButton2Click(Sender: TObject);
    procedure UniButton3Click(Sender: TObject);
    procedure UniButton4Click(Sender: TObject);
    procedure UniDateTimePicker2Change(Sender: TObject);
    procedure UniButton5Click(Sender: TObject);
    procedure UniButton6Click(Sender: TObject);
    procedure UniButton7Click(Sender: TObject);
    procedure UniTabSheet3BeforeActivate(Sender: TObject;
      var AllowActivate: Boolean);
    procedure UniTreeView1Change(Sender: TObject; Node: TUniTreeNode);
    procedure UniTimer1Timer(Sender: TObject);
    procedure UniTreeView3Change(Sender: TObject; Node: TUniTreeNode);
    procedure UniButton8Click(Sender: TObject);
    procedure UniButton9Click(Sender: TObject);
    procedure UniDateTimePicker3Change(Sender: TObject);
  private
    { Private declarations }
    SelectedNode1 : TUniTreeNode;
    SelectedNode2 : TUniTreeNode;
  public
    { Public declarations }
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, public_func, login;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

// ��ʼ�� ----------------------------------------------------------------------
//
procedure TMainForm.UniFormCreate(Sender: TObject);
begin
  UniDateTimePicker1.DateTime:=now();
  UniDateTimePicker2.DateTime:=now();
  if UniMainModule.global_authority='ʳ�ù���Ա' then
  begin
    UniTabSheet1.TabVisible:=false;
    UniTabSheet2.TabVisible:=false;
  end
  else begin
    UniTabSheet4.TabVisible:=false;
  end;
  //
end;

procedure TMainForm.UniTabSheet1BeforeActivate(Sender: TObject;
  var AllowActivate: Boolean);
begin
  // ��ʼ��
  UniDateTimePicker1.DateTime:=now();
  UniTreeView1.Items.Clear;
  UniTreeView2.Items.Clear;
  // ��Ӳ˵���Ϣ
end;

procedure TMainForm.UniTabSheet2BeforeActivate(Sender: TObject;
  var AllowActivate: Boolean);
begin
  // ��ʼ��
  UniDateTimePicker2.DateTime:=now();
  UniTreeView3.Items.Clear;
  UniTreeView4.Items.Clear;
  // ��Ӷ�����Ϣ
end;

procedure TMainForm.UniTabSheet3BeforeActivate(Sender: TObject;
  var AllowActivate: Boolean);
begin
  // ��ʼ��
  UniEdit1.Clear;
  UniEdit2.Clear;
  UniEdit3.Clear;
end;

procedure TMainForm.UniTimer1Timer(Sender: TObject);
begin
  UniTreeView1.FullExpand;
end;
//
// ��ʼ������ ------------------------------------------------------------------

// �������ģ�� ----------------------------------------------------------------
//
procedure TMainForm.UniButton1Click(Sender: TObject);  // �޸�����
var
  old_pwd,new_pwd:string;
  old_pwd_flag,change_pwd_flag:boolean;
begin
  old_pwd_flag:=false;
  change_pwd_flag:=false;
  //
  if Trim(UniEdit1.Text)='' then
  begin
    ShowMessageN('�����������');
  end
  else if Trim(UniEdit2.Text)='' then
  begin
    ShowMessageN('������������');
  end
  else if Trim(UniEdit3.Text)='' then
  begin
    ShowMessageN('���ظ�������');
  end
  else begin
    old_pwd:=Trim(UniEdit1.Text);
    old_pwd:=public_func.encoding(old_pwd,public_func.encrypt_key);
    with MainModule.UniMainModule.exec_query do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select gong_hao from user_table');
      SQL.Add('where gong_hao=:gong_hao and user_pwd=:user_pwd');
      ParamByName('gong_hao').Value:=UniMainModule.global_gonghao;
      ParamByName('user_pwd').Value:=old_pwd;
      Open;
      if RecordCount>0 then
      begin
        old_pwd_flag:=true;  // ������������ȷ
      end;
    end;
    //
    if old_pwd_flag then
    begin
      if Trim(UniEdit2.Text)=Trim(UniEdit3.Text) then
      begin
        new_pwd:=Trim(UniEdit2.Text);
        if Length(Trim(UniEdit2.Text))<21 then
        begin
          new_pwd:=public_func.encoding(new_pwd,public_func.encrypt_key);
          change_pwd_flag:=true;  // ������������ϱ�׼
        end
        else begin
          UniEdit2.Clear;
          UniEdit3.Clear;
          ShowMessageN('��������󳤶�Ϊ20λ������������');
        end;
      end
      else begin
        UniEdit2.Clear;
        UniEdit3.Clear;
        ShowMessageN('ǰ�������������������������');
      end;
    end
    else begin
      UniEdit1.Clear;
      ShowMessageN('�������������������');
    end;
  end;
  //
  if change_pwd_flag then
  try
    with MainModule.UniMainModule.exec_query do  // ִ���޸��������
    begin
      Close;
      SQL.Clear;
      SQL.Add('update user_table');
      SQL.Add('set user_pwd=:new_pwd');
      SQL.Add('where gong_hao=:gong_hao');
      ParamByName('new_pwd').Value:=new_pwd;
      ParamByName('gong_hao').Value:=UniMainModule.global_gonghao;
      execsql;
    end;
    //
    UniEdit1.Clear;
    UniEdit2.Clear;
    UniEdit3.Clear;
    ShowMessageN('�������޸�');
  except
    ShowMessageN('��������������������⣬����ϵ����Ա');
  end;
end;

procedure TMainForm.UniButton8Click(Sender: TObject);
begin
  ShowMessage('�û�����'+UniMainModule.global_username+';���ţ�'+UniMainModule.global_gonghao+';���ţ�'+UniMainModule.global_department+';');
end;

//
// �������ģ����� ------------------------------------------------------------

// ����ģ�� --------------------------------------------------------------------
//
procedure TMainForm.UniDateTimePicker1Change(Sender: TObject);
var
  mytreenode1,mytreenode2,mytreenode3:TUniTreeNode;
  order_date:string;
  order_kind,food_name:string;
  i:integer;
begin
  if UniDateTimePicker1.DateTime<=now() then
  begin
    //ShowMessageN('����ʱ�䲻��ѡ�����֮ǰ');
  end
  else begin
    order_date:=FormatDateTime('yyyy-MM-dd',UniDateTimePicker1.DateTime);
    UniTreeview1.Items.Clear;
    UniTreeView2.Items.Clear;
    //
    with UniTreeview1 do
    begin
      mytreenode1:=Items.Add(nil,'���');
      mytreenode2:=Items.Add(nil,'���');
      mytreenode3:=Items.Add(nil,'���');
    end;
    //
    with MainModule.UniMainModule.dingcan_query do  // ������
    begin
      Close;
      SQL.Clear;
      SQL.Add('select food_name from menulist_table');
      SQL.Add('where order_date=:order_date');
      SQL.Add('and order_kind=:order_kind');
      SQL.Add('order by food_name');
      ParamByName('order_date').Value:=order_date;
      ParamByName('order_kind').Value:='���';
      Open;
      if RecordCount>0 then
      begin
        for i := 0 to RecordCount-1 do
        begin
          UniTreeView1.Items.AddChild(mytreenode1,FieldByName('food_name').AsString);
          Next;
        end;
      end;
    end;
    //
    with MainModule.UniMainModule.dingcan_query do  // ������
    begin
      Close;
      SQL.Clear;
      SQL.Add('select food_name from menulist_table');
      SQL.Add('where order_date=:order_date');
      SQL.Add('and order_kind=:order_kind');
      SQL.Add('order by food_name');
      ParamByName('order_date').Value:=order_date;
      ParamByName('order_kind').Value:='���';
      Open;
      if RecordCount>0 then
      begin
        for i := 0 to RecordCount-1 do
        begin
          UniTreeView1.Items.AddChild(mytreenode2,FieldByName('food_name').AsString);
          Next;
        end;
      end;
    end;
    //
    with MainModule.UniMainModule.dingcan_query do  // ������
    begin
      Close;
      SQL.Clear;
      SQL.Add('select food_name from menulist_table');
      SQL.Add('where order_date=:order_date');
      SQL.Add('and order_kind=:order_kind');
      SQL.Add('order by food_name');
      ParamByName('order_date').Value:=order_date;
      ParamByName('order_kind').Value:='���';
      Open;
      if RecordCount>0 then
      begin
        for i := 0 to RecordCount-1 do
        begin
          UniTreeView1.Items.AddChild(mytreenode3,FieldByName('food_name').AsString);
          Next;
        end;
      end;
    end;
    //
    with MainModule.UniMainModule.exec_query do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select order_kind,food_name from order_table');
      SQL.Add('where order_date=:order_date');
      SQL.Add('and gong_hao=:gong_hao');
      SQL.Add('and order_cancel=:order_cancel');
      SQL.Add('order by order_kind,food_name');
      ParamByName('order_date').Value:=order_date;
      ParamByName('gong_hao').Value:=UniMainModule.global_gonghao;
      ParamByName('order_cancel').Value:='/';
      Open;
      First;
      if RecordCount>0 then
      begin
        for i := 0 to RecordCount-1 do
        begin
          order_kind:=FieldByName('order_kind').AsString;
          food_name:=FieldByName('food_name').AsString;
          UniTreeView2.Items.Add(nil,order_kind+':'+food_name);
          Next;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.UniButton2Click(Sender: TObject);  // ��ѡ
var
  order_kind,food_name,add_str:string;
  i:integer;
  add_flag:boolean;
begin
  add_flag:=true;
  if (SelectedNode1.Parent = nil) then
  begin
    // do nothing
  end
  else begin
    order_kind:=SelectedNode1.Parent.Text;
    food_name:=SelectedNode1.Text;
    add_str:=order_kind+':'+food_name;
    //
    for i := 0 to UniTreeView2.Items.Count-1 do
    begin
      if (UniTreeView2.Items.Item[i].Text=add_str) then
      begin
        add_flag:=false;
      end;
    end;
    //
    if add_flag then
    begin
      UniTreeView2.Items.Add(nil,add_str);
    end;
  end;
end;

procedure TMainForm.UniButton9Click(Sender: TObject);  // ��ѡ����
var
  delete_node:TUniTreeNode;
begin
  delete_node:=UniTreeView2.Selected;
  UniTreeView2.Items.Delete(delete_node);
end;

procedure TMainForm.UniButton3Click(Sender: TObject);  // ȫѡ
var
  order_kind,food_name,add_str:string;
  i:integer;
begin
  UniTreeView2.Items.Clear;
  //
  for i := 0 to UniTreeView1.Items.Count-1 do
  begin
    if (UniTreeView1.Items.Item[i].Parent<>nil) then
    begin
      order_kind:=UniTreeView1.Items.Item[i].Parent.Text;
      food_name:=UniTreeView1.Items.Item[i].Text;
      add_str:=order_kind+':'+food_name;
      //
      UniTreeView2.Items.Add(nil,add_str);
    end;
  end;
end;

procedure TMainForm.UniButton4Click(Sender: TObject);  // ���涩����Ϣ
var
  order_kind,food_name,add_str:string;
  i:integer;
begin
  if (UniTreeView2.Items.Count>0) then
  begin
    // ����Ѿ��ж��ͼ�¼�����Ѵ��ڵĶ��ͼ�¼���Ϊȡ��
    try
      with MainModule.UniMainModule.exec_query do
      begin
        Close;
        SQL.Clear;
        SQL.Add('update order_table');
        SQL.Add('set order_cancel=:order_cancel');
        SQL.Add('where gong_hao=:gong_hao and order_date=:order_date');
        ParamByName('order_cancel').Value:=FormatDateTime('yyyyMMddhhmmss',now());
        ParamByName('gong_hao').Value:=UniMainModule.global_gonghao;
        ParamByName('order_date').Value:=FormatDateTime('yyyy-MM-dd',UniDateTimePicker1.DateTime);
        Execsql;
      end;
    except
      ShowMessageN('���ԭ���ͼ�¼�����г��ִ�������ϵ����Ա');
    end;
    //
    // ����¶��ͼ�¼
    for i := 0 to UniTreeView2.Items.Count-1 do
    begin
      add_str:=UniTreeView2.Items.Item[i].Text;
      if (pos(':',add_str)>0) then
      begin
        order_kind:=copy(add_str,1,pos(':',add_str)-1);  // ��ȡadd_strǰ�벿�֣��ָ���Ϊ':'
        food_name:=copy(add_str,pos(':',add_str)+1,length(add_str));  // ��ȡadd_str��벿�֣��ָ���Ϊ':'
        //ShowMessageN(order_kind+','+food_name);
        try
          with MainModule.UniMainModule.exec_query do
          begin
            Close;
            SQL.Clear;
            SQL.Add('insert into order_table(order_date,order_time,gong_hao,');
            SQL.Add('user_name,user_department,order_kind,food_name,');
            SQL.Add('order_cancel,remark)');
            SQL.Add('values(:order_date,:order_time,:gong_hao,');
            SQL.Add(':user_name,:user_department,:order_kind,:food_name,');
            SQL.Add(':order_cancel,:remark)');
            ParamByName('order_date').Value:=FormatDateTime('yyyy-MM-dd',UniDateTimePicker1.DateTime);
            ParamByName('order_time').Value:=FormatDateTime('yyyyMMddhhmmss',now());
            ParamByName('gong_hao').Value:=UniMainModule.global_gonghao;
            ParamByName('user_name').Value:=UniMainModule.global_username;
            ParamByName('user_department').Value:=UniMainModule.global_department;
            ParamByName('order_kind').Value:=order_kind;
            ParamByName('food_name').Value:=food_name;
            ParamByName('order_cancel').Value:='/';
            ParamByName('remark').Value:='web';
            Execsql;
            ShowMessageN('������Ϣ�ѱ���');
          end;
        except
          ShowMessageN('���涩����Ϣ�����г��ִ�������ϵ����Ա');
          Exit;
        end;
      end
      else begin
        ShowMessageN('δ�ҵ��ַ��ָ���');
      end;
    end;
    //UniTreeView2.Items.Clear;
  end
  else begin
    ShowMessageN('δ���ڶ�����Ϣ');
  end;
end;

procedure TMainForm.UniTreeView1Change(Sender: TObject; Node: TUniTreeNode);
begin
  SelectedNode1:=Node;
end;
//
// ����ģ����� ----------------------------------------------------------------

// �˲�ģ�� --------------------------------------------------------------------
//
procedure TMainForm.UniDateTimePicker2Change(Sender: TObject);  // �˲�
var
  order_date:string;
  order_kind,food_name:string;
  i:integer;
begin
  if UniDateTimePicker2.DateTime<=now() then
  begin
    //ShowMessageN('�˲�ʱ�䲻��ѡ�����֮ǰ');
  end
  else begin
    order_date:=FormatDateTime('yyyy-MM-dd',UniDateTimePicker2.DateTime);
    UniTreeview3.Items.Clear;
    UniTreeView4.Items.Clear;
    //
    with MainModule.UniMainModule.tuican_query do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select order_kind,food_name from order_table');
      SQL.Add('where order_date=:order_date');
      SQL.Add('and gong_hao=:gong_hao');
      SQL.Add('and order_cancel=:order_cancel');
      SQL.Add('order by order_kind,food_name');
      ParamByName('order_date').Value:=order_date;
      ParamByName('gong_hao').Value:=UniMainModule.global_gonghao;
      ParamByName('order_cancel').Value:='/';
      Open;
      First;
      if RecordCount>0 then
      begin
        for i := 0 to RecordCount-1 do
        begin
          order_kind:=FieldByName('order_kind').AsString;
          food_name:=FieldByName('food_name').AsString;
          UniTreeView3.Items.Add(nil,order_kind+':'+food_name);
          Next;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.UniDateTimePicker3Change(Sender: TObject);
var
  input_date:string;
  i:integer;
  display_str:string;
begin
  input_date:=FormatDateTime('yyyy-MM-dd',UniDateTimePicker3.DateTime);
  UniMemo1.Lines.Clear;
  //
  with UniMainModule.exec_query do  // �г��������
  begin
    Close;
    SQL.Clear;
    SQL.Add('select food_name,count(food_name) as food_number from order_table');
    SQL.Add('where order_date=:order_date');
    SQL.Add('and order_kind=:order_kind');
    SQL.Add('and order_cancel=:order_cancel');
    SQL.Add('group by food_name');
    ParamByName('order_date').Value:=input_date;
    ParamByName('order_kind').Value:='���';
    ParamByName('order_cancel').Value:='/';
    Open;
    First;
    if RecordCount>0 then
    begin
      UniMemo1.Lines.Add(input_date+' ������Ϣ���£�');
      UniMemo1.Lines.Add('������ݣ�');
      for i := 0 to RecordCount-1 do
      begin
        display_str:=Fields.FieldByName('food_name').AsString+' = '+Fields.FieldByName('food_number').AsString;
        UniMemo1.Lines.Add(display_str);
        Next;
      end;
    end;
  end;
  //
  with UniMainModule.exec_query do  // �г��������
  begin
    Close;
    SQL.Clear;
    SQL.Add('select food_name,count(food_name) as food_number from order_table');
    SQL.Add('where order_date=:order_date');
    SQL.Add('and order_kind=:order_kind');
    SQL.Add('and order_cancel=:order_cancel');
    SQL.Add('group by food_name');
    ParamByName('order_date').Value:=input_date;
    ParamByName('order_kind').Value:='���';
    ParamByName('order_cancel').Value:='/';
    Open;
    First;
    if RecordCount>0 then
    begin
      UniMemo1.Lines.Add('������ݣ�');
      for i := 0 to RecordCount-1 do
      begin
        display_str:=Fields.FieldByName('food_name').AsString+' = '+Fields.FieldByName('food_number').AsString;
        UniMemo1.Lines.Add(display_str);
        Next;
      end;
    end;
  end;
  //
  with UniMainModule.exec_query do  // �г��������
  begin
    Close;
    SQL.Clear;
    SQL.Add('select food_name,count(food_name) as food_number from order_table');
    SQL.Add('where order_date=:order_date');
    SQL.Add('and order_kind=:order_kind');
    SQL.Add('and order_cancel=:order_cancel');
    SQL.Add('group by food_name');
    ParamByName('order_date').Value:=input_date;
    ParamByName('order_kind').Value:='���';
    ParamByName('order_cancel').Value:='/';
    Open;
    First;
    if RecordCount>0 then
    begin
      UniMemo1.Lines.Add('������ݣ�');
      for i := 0 to RecordCount-1 do
      begin
        display_str:=Fields.FieldByName('food_name').AsString+' = '+Fields.FieldByName('food_number').AsString;
        UniMemo1.Lines.Add(display_str);
        Next;
      end;
    end;
  end;
end;

procedure TMainForm.UniButton5Click(Sender: TObject);  // ����
var
  add_str:string;
begin
  add_str:=SelectedNode2.Text;
  UniTreeView4.Items.Add(nil,add_str);
  UniTreeView3.Items.Delete(SelectedNode2);
end;

procedure TMainForm.UniButton6Click(Sender: TObject);  // ȫ��
var
  add_str:string;
  i:integer;
begin
  UniTreeView4.Items.Clear;
  //
  for i := 0 to UniTreeView3.Items.Count-1 do
  begin
    add_str:=UniTreeView3.Items.Item[i].Text;
    UniTreeView4.Items.Add(nil,add_str);
  end;
  //
  UniTreeView3.Items.Clear;
end;

procedure TMainForm.UniButton7Click(Sender: TObject);  // ɾ��
var
  delete_str,order_kind,food_name:string;
  i:integer;
begin
  for i := 0 to UniTreeView4.Items.Count-1 do
    begin
      delete_str:=UniTreeView4.Items.Item[i].Text;
      if (pos(':',delete_str)>0) then
      begin
        order_kind:=copy(delete_str,1,pos(':',delete_str)-1);  // ��ȡdelete_strǰ�벿�֣��ָ���Ϊ':'
        food_name:=copy(delete_str,pos(':',delete_str)+1,length(delete_str));  // ��ȡadd_str��벿�֣��ָ���Ϊ':'
        //ShowMessageN(order_kind+','+food_name);
        try
          with MainModule.UniMainModule.exec_query do
          begin
            Close;
            SQL.Clear;
            SQL.Add('update order_table');
            SQL.Add('set order_cancel=:order_cancel');
            SQL.Add('where order_date=:order_date');
            SQL.Add('and order_kind=:order_kind');
            SQL.Add('and food_name=:food_name');
            SQL.Add('and gong_hao=:gong_hao');
            ParamByName('order_cancel').Value:=FormatDateTime('yyyyMMddhhmmss',now());
            ParamByName('order_date').Value:=FormatDateTime('yyyy-MM-dd',UniDateTimePicker2.DateTime);
            ParamByName('order_kind').Value:=order_kind;
            ParamByName('food_name').Value:=food_name;
            ParamByName('gong_hao').Value:=UniMainModule.global_gonghao;
            Execsql;
            ShowMessageN('�˲ʹ���ɹ�');
          end;
        except
          ShowMessageN('�˲ʹ�������г��ִ�������ϵ����Ա');
          Exit;
        end;
      end
      else begin
        ShowMessageN('δ�ҵ��ַ��ָ���');
      end;
    end;
    UniTreeView4.Items.Clear;
end;

procedure TMainForm.UniTreeView3Change(Sender: TObject; Node: TUniTreeNode);
begin
  SelectedNode2:=Node;
end;
//
// �˲�ģ����� ----------------------------------------------------------------

initialization
  RegisterAppFormClass(TMainForm);

end.
