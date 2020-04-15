unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Dialogs,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniPanel, uniPageControl,
  uniGUIBaseClasses, uniButton, uniLabel, uniEdit, uniGroupBox, uniStatusBar,
  uniTreeView, uniDateTimePicker, uniTimer, uniMemo, uniBasicGrid, uniDBGrid,
  uniMultiItem, uniListBox, uniComboBox;

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
    UniTimer1: TUniTimer;
    UniButton8: TUniButton;
    UniTabSheet4: TUniTabSheet;
    UniDateTimePicker3: TUniDateTimePicker;
    UniMemo1: TUniMemo;
    UniDateTimePicker2: TUniDateTimePicker;
    UniTabSheet5: TUniTabSheet;
    UniButton6: TUniButton;
    UniListBox1: TUniListBox;
    UniButton2: TUniButton;
    UniLabel4: TUniLabel;
    UniGroupBox3: TUniGroupBox;
    UniListBox2: TUniListBox;
    UniComboBox1: TUniComboBox;
    UniLabel5: TUniLabel;
    procedure UniFormCreate(Sender: TObject);
    procedure UniButton1Click(Sender: TObject);
    procedure UniTabSheet1BeforeActivate(Sender: TObject;
      var AllowActivate: Boolean);
    procedure UniDateTimePicker1Change(Sender: TObject);
    procedure UniTabSheet3BeforeActivate(Sender: TObject;
      var AllowActivate: Boolean);
    procedure UniTreeView1Change(Sender: TObject; Node: TUniTreeNode);
    procedure UniTimer1Timer(Sender: TObject);
    procedure UniButton8Click(Sender: TObject);
    procedure UniDateTimePicker3Change(Sender: TObject);
    procedure UniTabSheet2BeforeActivate(Sender: TObject;
      var AllowActivate: Boolean);
    procedure UniTabSheet4BeforeActivate(Sender: TObject;
      var AllowActivate: Boolean);
    procedure UniDateTimePicker2Change(Sender: TObject);
    procedure UniButton6Click(Sender: TObject);
    procedure UniTreeView1DblClick(Sender: TObject);
    procedure UniButton2Click(Sender: TObject);
    procedure UniTreeView1Click(Sender: TObject);
    procedure UniTabSheet5BeforeActivate(Sender: TObject;
      var AllowActivate: Boolean);
    procedure UniComboBox1Change(Sender: TObject);
  private
    { Private declarations }
    SelectedNode1 : TUniTreeNode;
  public
    procedure confirmsave(Sender:TComponent;AResult:Integer);
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

// �Զ������ ------------------------------------------------------------------

procedure TMainForm.confirmsave(Sender:TComponent;AResult:Integer);
var
  order_kind,food_name,food_price:string;
  i:integer;
begin
  if AResult<>mrYes then
  begin
    exit;
  end;
  //
  // �˴����붩�ʹ���
  //
  if SelectedNode1.Text='���' then
  begin
    //
  end
  else if SelectedNode1.Text='���' then
  begin
    //
  end
  else if SelectedNode1.Text='���' then
  begin
    //
  end
  else begin
    try
      order_kind:=SelectedNode1.Parent.Text;
      i:=pos(':',SelectedNode1.Text);
      food_name:=copy(SelectedNode1.Text,1,i-1);
      food_price:=copy(SelectedNode1.text,i+1,length(SelectedNode1.Text));
      i:=pos('Ԫ',food_price);
      food_price:=copy(food_price,1,i-1);
      //

      with UniMainModule.exec_query do
      begin
        Close;
        SQL.Clear;
        SQL.Add('insert into order_table(order_date,order_time,gong_hao,');
        SQL.Add('user_name,user_department,order_kind,food_name,food_price,');
        SQL.Add('order_cancel,remark)');
        SQL.Add('values(:order_date,:order_time,:gong_hao,');
        SQL.Add(':user_name,:user_department,:order_kind,:food_name,:food_price,');
        SQL.Add(':order_cancel,:remark)');
        ParamByName('order_date').Value:=FormatDateTime('yyyy-MM-dd',UniDateTimePicker1.DateTime);
        ParamByName('order_time').Value:=FormatDateTime('yyyyMMddhhmmss',now());
        ParamByName('gong_hao').Value:=UniMainModule.global_gonghao;
        ParamByName('user_name').Value:=UniMainModule.global_username;
        ParamByName('user_department').Value:=UniMainModule.global_department;
        ParamByName('order_kind').Value:=order_kind;
        ParamByName('food_name').Value:=food_name;
        ParamByName('food_price').Value:=strtofloat(food_price);
        ParamByName('order_cancel').Value:='/';
        ParamByName('remark').Value:='web';
        Execsql;
        //ShowMessageN('���ͳɹ�');
      end;
    except
      ShowMessageN('����ʧ�ܣ�����ϵ����Ա,'+food_name+','+food_price);
    end;
  end;
end;

// �Զ�����̽��� --------------------------------------------------------------

// ��ʼ�� ----------------------------------------------------------------------
//
procedure TMainForm.UniFormCreate(Sender: TObject);  // �����û�Ȩ�޾�����ʾҳ�淶Χ
begin
  UniDateTimePicker1.DateTime:=now();
  UniDateTimePicker2.DateTime:=now();
  if UniMainModule.global_authority='ʳ�ù���Ա' then
  begin
    UniTabSheet1.TabVisible:=false;   // �ճ����͹��ܲ�����
    UniTabSheet2.TabVisible:=false;   // ��ѯ�˲͹��ܲ�����
    //UniTabSheet3.TabVisible:=false; // �޸����빦�� ����
    //UniTabSheet4.TabVisible:=false; // ����ͳ�ƹ��� ����
    //UniTabSheet5.TabVisible:=false;   // ��ѯ���� ����
  end
  else if (UniMainModule.global_authority='�ڱ���Ա') then
  begin
    //UniTabSheet1.TabVisible:=false;  // �ճ����� ����
    //UniTabSheet2.TabVisible:=false;  // ��ѯ�˲� ����
    //UniTabSheet3.TabVisible:=false;  // �޸����� ����
    UniTabSheet4.TabVisible:=false;  // ����ͳ�Ʋ�����
    UniTabSheet5.TabVisible:=false;  // ��ѯ���ʲ�����
  end
  else if (UniMainModule.global_authority='�Ǳ���Ա') then
  begin
    //UniTabSheet1.TabVisible:=false;  // �ճ����� ����
    //UniTabSheet2.TabVisible:=false;  // ��ѯ�˲� ����
    //UniTabSheet3.TabVisible:=false;  // �޸����� ����
    UniTabSheet4.TabVisible:=false;  // ����ͳ�Ʋ�����
    UniTabSheet5.TabVisible:=false;  // ��ѯ���ʲ�����
  end
  else begin  // ������
    //UniTabSheet1.TabVisible:=false;  // �ճ����� ����
    //UniTabSheet2.TabVisible:=false;  // ��ѯ�˲� ����
    //UniTabSheet3.TabVisible:=false;  // �޸����� ����
    UniTabSheet4.TabVisible:=false;  // ����ͳ�Ʋ�����
    UniTabSheet5.TabVisible:=false;  // ��ѯ���ʲ�����
  end;
  //
end;

procedure TMainForm.UniTabSheet1BeforeActivate(Sender: TObject;  // ����/�˲�ҳ���ʼ��
  var AllowActivate: Boolean);
var
  account:single;
begin
  // ��ʼ��
  UniDateTimePicker1.DateTime:=now();
  UniTreeView1.Items.Clear;
  account:=0.00;
  UniLabel4.Text:='��ӭ�㣬'+UniMainModule.global_username;
  //
  with UniMainModule.exec_query do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select account from user_table');
    SQl.Add('where gong_hao=:gong_hao');
    ParamByName('gong_hao').Value:=UniMainModule.global_gonghao;
    Open;
    if RecordCount>0 then
    begin
      account:=FieldByName('account').AsFloat;
    end;
  end;
  UniLabel4.Text:=UniLabel4.Text + '��������Ϊ ' + formatfloat('0.00',account) + ' Ԫ��';
  // ��Ӳ˵���Ϣ
  if (UniMainModule.global_authority='�ڱ���Ա') or (UniMainModule.global_authority='�Ǳ���Ա') then
  begin
    //
  end
  else if (UniMainModule.global_authority='����') then
  begin
    if (account<=0) then  // �ж��������Ƿ������ʾ��ֵ���ٵ��
    begin
      UniLabel4.Text:=UniLabel4.Text + '������ϵͣ�����ǰ��ֵ���ٶ��͡�';
      UniLabel4.Font.Color:=clRed;
    end;
  end;
end;

procedure TMainForm.UniTabSheet2BeforeActivate(Sender: TObject;  // ��ѯ�˲�ҳ���ʼ��
  var AllowActivate: Boolean);

begin
  UniDateTimePicker2.DateTime:=now();
  UniListBox1.Items.Clear;
end;

procedure TMainForm.UniTabSheet3BeforeActivate(Sender: TObject;  // �޸�����ҳ���ʼ��
  var AllowActivate: Boolean);
begin
  // ��ʼ��
  UniEdit1.Clear;
  UniEdit2.Clear;
  UniEdit3.Clear;
end;

procedure TMainForm.UniTabSheet4BeforeActivate(Sender: TObject;  // ��ѯͳ��ҳ���ʼ��
  var AllowActivate: Boolean);
begin
  UniDateTimePicker3.DateTime:=now();
  UniMemo1.Clear;
end;

procedure TMainForm.UniTabSheet5BeforeActivate(Sender: TObject;  // ���ʲ�ѯҳ���ʼ��
  var AllowActivate: Boolean);
var
  i:integer;
begin
  //
  with MainModule.UniMainModule.salary_query do
  begin
    //
    Close;
    SQL.Clear;
    SQL.Add('select salary_number from salary_table');
    SQL.Add('where gong_hao=:gong_hao');
    SQL.Add('order by salary_number');
    ParamByName('gong_hao').Value:=MainModule.UniMainModule.global_gonghao;
    Open;
    First;
    for i := 0 to RecordCount-1 do
    begin
      UniComboBox1.Items.Add(FieldByName('salary_number').AsString);
      Next;
    end;
  end;
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
procedure TMainForm.UniDateTimePicker1Change(Sender: TObject);  // ѡ�񶩲����ڣ�ˢ�¶����б�
var
  mytreenode1,mytreenode2,mytreenode3:TUniTreeNode;
  order_date:string;
  i:integer;
  server_time:TDateTime;
  date_str,time_str:string;
begin
  server_time:=UniMainModule.GetSysTime;
  date_str:=FormatDateTime('yyyyMMdd',server_time);
  time_str:=FormatDateTime('hhmmss',server_time);
  //
  if (strtoint(time_str)>=190000) and (strtoint(time_str)<=235959) then  // ���ߵ��Ժ�
  begin
    // ��ʾ��������
    ShowMessageN('���ߵ��Ժ������ͣ����½�');
  end
  else begin
    // ��������ʱ�䷶Χ�ڣ���ʼ�������
    if strtoint(FormatDateTime('yyyyMMdd',UniDateTimePicker1.DateTime))>strtoint(date_str) then  // ѡ�����ڴ��ڷ�������������
    begin
      // �����ͣ���ʼ�г�ѡ�����ڵĲ�Ʒ��Ϣ
      order_date:=FormatDateTime('yyyy-MM-dd',UniDateTimePicker1.DateTime);
      UniTreeview1.Items.Clear;
      //
      with UniTreeview1 do  // ���rootnode
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
        SQL.Add('select food_name,food_price from menulist_table');
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
            UniTreeView1.Items.AddChild(mytreenode1,FieldByName('food_name').AsString + ':' + FieldByName('food_price').AsString + 'Ԫ');
            Next;
          end;
        end;
      end;
      //
      with MainModule.UniMainModule.dingcan_query do  // ������
      begin
        Close;
        SQL.Clear;
        SQL.Add('select food_name,food_price from menulist_table');
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
            UniTreeView1.Items.AddChild(mytreenode2,FieldByName('food_name').AsString + ':' + FieldByName('food_price').AsString + 'Ԫ');
            Next;
          end;
        end;
      end;
      //
      with MainModule.UniMainModule.dingcan_query do  // ������
      begin
        Close;
        SQL.Clear;
        SQL.Add('select food_name,food_price from menulist_table');
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
            UniTreeView1.Items.AddChild(mytreenode3,FieldByName('food_name').AsString + ':' + FieldByName('food_price').AsString + 'Ԫ');
            Next;
          end;
        end;
      end;
    end
    else begin  // ��ʾ����ѡ�����֮ǰ
      UniTreeView1.Items.Clear;
      ShowMessageN('����ʱ�䲻��ѡ�����֮ǰ');
    end;
  end;
end;

procedure TMainForm.UniDateTimePicker2Change(Sender: TObject);  // ��ѯ���˶�������
var
  input_date:string;
  i:integer;
  food_price,total_price:single;
  order_kind,food_name:string;
begin
  total_price:=0;
  UniListBox1.Items.Clear;
  input_date:=FormatDateTime('yyyy-MM-dd',UniDateTimePicker2.DateTime);
  //
  with MainModule.UniMainModule.exec_query do  // ����Ѷ�����Ϣ
  begin
    Close;
    SQL.Clear;
    SQL.Add('select order_kind,food_name,food_price from order_table');
    SQL.Add('where order_date=:order_date');
    SQL.Add('and gong_hao=:gong_hao');
    SQL.Add('and order_cancel=:order_cancel');
    SQL.Add('order by order_kind,food_name');
    ParamByName('order_date').Value:=input_date;
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
        food_price:=FieldByName('food_price').AsSingle;
        total_price:=total_price+food_price;
        UniListBox1.Items.Add(order_kind+':'+food_name+':'+formatfloat('0.00',food_price)+'Ԫ');
        Next;
      end;
      UniListBox1.Items.Add('���Ϻϼƽ��Ϊ:'+formatfloat('0.00',total_price)+'Ԫ');
    end;
  end;
  //
  if strtoint(FormatDateTime('yyyyMMdd',UniDateTimePicker2.DateTime)) <= strtoint(FormatDateTime('yyyyMMdd',now())) then
  begin
    // ����ѡ���˵�����������������˲�
    if (UniButton2.Enabled=true) then
    begin
      UniButton2.Enabled:=false;
    end;
    if (UniButton6.Enabled=true) then
    begin
      UniButton6.Enabled:=false;
    end;
  end
  else begin
    if (UniButton2.Enabled=false) then
    begin
      UniButton2.Enabled:=true;
    end;
    if (UniButton6.Enabled=false) then
    begin
      UniButton6.Enabled:=true;
    end;
  end;
end;

procedure TMainForm.UniButton2Click(Sender: TObject);  // �˲�
var
  del_str:string;
  input_date:string;
  i:integer;
  order_kind,food_name:string;
  food_price:single;
begin
  if (UniListBox1.ItemIndex<0) then
  begin
    exit;
  end;
  //
  input_date:=FormatDateTime('yyyyMMdd',UniDateTimePicker2.DateTime);
  if (strtoint(input_date)>=190000) and (strtoint(input_date)<=235959) then
  begin
    // ��ʾ�����˲�ʱ��Σ��������˲�
  end
  else begin
    // �����˲������������˲�
    del_str:=UniListBox1.Items.Strings[UniListBox1.ItemIndex];
    if (pos(':',del_str)>0) then
    begin
      order_kind:=copy(del_str,1,pos(':',del_str)-1);
      del_str:=copy(del_str,pos(':',del_str)+1,length(del_str));  // �ظ�ֵ����
      food_name:=copy(del_str,1,pos(':',del_str)-1);
      //
      try
        with UniMainModule.exec_query do
        begin
          Close;
          SQL.Clear;
          SQL.Add('update order_table');
          SQL.Add('set order_cancel=:order_cancel');
          SQL.Add('where gong_hao=:gong_hao');
          SQL.Add('and order_date=:order_date');
          SQL.Add('and order_kind=:order_kind');
          SQL.Add('and food_name=:food_name');
          ParamByName('order_cancel').Value:=FormatDateTime('yyyyMMddhhmmss',now());
          ParamByName('gong_hao').Value:=UniMainModule.global_gonghao;
          ParamByName('order_date').Value:=FormatDateTime('yyyy-MM-dd',UniDateTimePicker2.DateTime);
          ParamByName('order_kind').Value:=order_kind;
          ParamByName('food_name').Value:=food_name;
          Execsql;
        end;
      except
        ShowMessageN('�˲͹������������⣬����ϵ����Ա');
      end;
      //
      UniListBox1.Items.Clear;
      with MainModule.UniMainModule.exec_query do  // ˢ���Ѷ�����Ϣ
      begin
        Close;
        SQL.Clear;
        SQL.Add('select order_kind,food_name,food_price from order_table');
        SQL.Add('where order_date=:order_date');
        SQL.Add('and gong_hao=:gong_hao');
        SQL.Add('and order_cancel=:order_cancel');
        SQL.Add('order by order_kind,food_name');
        ParamByName('order_date').Value:=FormatDateTime('yyyy-MM-dd',UniDateTimePicker2.DateTime);
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
            food_price:=FieldByName('food_price').AsSingle;
            UniListBox1.Items.Add(order_kind+':'+food_name+':'+Formatfloat('0.00',food_price)+'Ԫ');
            Next;
          end;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.UniButton6Click(Sender: TObject);  // ȫѡ�˲� ���޸�
begin
  if (UniListBox1.Items.Count>0) then
  begin
    try
      with UniMainModule.exec_query do
      begin
        Close;
        SQL.Clear;
        SQL.Add('update order_table');
        SQL.Add('set order_cancel=:order_cancel');
        SQL.Add('where gong_hao=:gong_hao');
        SQL.Add('and order_date=:order_date');
        ParamByName('order_cancel').Value:=FormatDateTime('yyyyMMddhhmmss',now());
        ParamByName('gong_hao').Value:=UniMainModule.global_gonghao;
        ParamByName('order_date').Value:=FormatDateTime('yyyy-MM-dd',UniDateTimePicker2.DateTime);
        Execsql;
      end;
    except
      ShowMessageN('�˲͹������������⣬����ϵ����Ա');
    end;
  end;
  //
  UniListBOx1.Items.Clear;
end;

procedure TMainForm.UniTreeView1Change(Sender: TObject; Node: TUniTreeNode);
begin
  SelectedNode1:=UniTreeView1.Selected;
end;


procedure TMainForm.UniTreeView1Click(Sender: TObject);
var
  show_str:string;
begin
  if (SelectedNode1.Parent = nil) then  // ѡ���˸��ڵ�
  begin
    // do nothing
  end
  else begin
    show_str:='����ǰѡ�����"'+SelectedNode1.Text+'",�Ƿ�ȷ�϶��ͣ�';
    MessageDlg(show_str,mtconfirmation,[mbYes,mbNo],confirmsave);
  end;
end;

procedure TMainForm.UniTreeView1DblClick(Sender: TObject);

begin
  //
end;

//
// ����ģ����� ----------------------------------------------------------------

// ��ѯģ�� --------------------------------------------------------------------
//
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
    SQL.Add('select user_name from order_table');
    SQL.Add('where order_date=:order_date');
    SQL.Add('and order_kind=:order_kind');
    SQL.Add('and order_cancel=:order_cancel');
    SQL.Add('group by user_name');
    ParamByName('order_date').Value:=input_date;
    ParamByName('order_kind').Value:='���';
    ParamByName('order_cancel').Value:='/';
    Open;
    UniMemo1.Lines.Add(input_date+' ������Ϣ���£�');
    UniMemo1.Lines.Add('������ݣ���������Ϊ'+inttostr(RecordCount)+'��');
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
    SQL.Add('select user_name from order_table');
    SQL.Add('where order_date=:order_date');
    SQL.Add('and order_kind=:order_kind');
    SQL.Add('and order_cancel=:order_cancel');
    SQL.Add('group by user_name');
    ParamByName('order_date').Value:=input_date;
    ParamByName('order_kind').Value:='���';
    ParamByName('order_cancel').Value:='/';
    Open;
    UniMemo1.Lines.Add('������ݣ���������Ϊ'+inttostr(RecordCount)+'��');
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
    SQL.Add('select user_name from order_table');
    SQL.Add('where order_date=:order_date');
    SQL.Add('and order_kind=:order_kind');
    SQL.Add('and order_cancel=:order_cancel');
    SQL.Add('group by user_name');
    ParamByName('order_date').Value:=input_date;
    ParamByName('order_kind').Value:='���';
    ParamByName('order_cancel').Value:='/';
    Open;
    UniMemo1.Lines.Add('������ݣ���������Ϊ'+inttostr(RecordCount)+'��');
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

//
// ��ѯģ����� ----------------------------------------------------------------

// ��ѡ��Ʒģ�� ----------------------------------------------------------------
//

procedure TMainForm.UniComboBox1Change(Sender: TObject);  // ��ѯ����
begin
  if Length(UniComboBox1.Text)=7 then
  begin
    with MainModule.UniMainModule.salary_query do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from salary_table');
      SQL.Add('where salary_number=:salary_number');
      SQL.Add('and gong_hao=:gong_hao');
      ParamByName('salary_number').Value:=UniComboBox1.Text;
      ParamByName('gong_hao').Value:=MainModule.UniMainModule.global_gonghao;
      Open;
      if RecordCount>0 then
      begin
        UniListBox2.Items.Add('Ӧ����Ŀ��'); // ��ʼ���Ӧ������
        //
        if FieldByName('zhi_wu_gong_zi').Value<>0 then
        begin
          UniListBox2.Items.Add('ְ���ʣ�' + FormatFloat('0.00',FieldByName('zhi_wu_gong_zi').AsCurrency));
        end;
        //
        if FieldByName('ji_bie_gong_zi').Value<>0 then
        begin
          UniListBox2.Items.Add('�����ʣ�' + FormatFloat('0.00',FieldByName('ji_bie_gong_zi').AsCurrency));
        end;
        //
        if FieldByName('shi_yong_qi').Value<>0 then
        begin
          UniListBox2.Items.Add('�����ڹ��ʣ�' + FormatFloat('0.00',FieldByName('shi_yong_qi').AsCurrency));
        end;
        //
        if FieldByName('gong_ren_gang_wei').Value<>0 then
        begin
          UniListBox2.Items.Add('���˸�λ���ʣ�' + FormatFloat('0.00',FieldByName('gong_ren_gang_wei').AsCurrency));
        end;
        //
        if FieldByName('ji_shu_deng_ji').Value<>0 then
        begin
          UniListBox2.Items.Add('�����ȼ����ʣ�' + FormatFloat('0.00',FieldByName('ji_shu_deng_ji').AsCurrency));
        end;
        //
        if FieldByName('gui_fan_jing_tie').Value<>0 then
        begin
          UniListBox2.Items.Add('�淶������' + FormatFloat('0.00',FieldByName('gui_fan_jing_tie').AsCurrency));
        end;
        //
        if FieldByName('guan_xian_jing_tie').Value<>0 then
        begin
          UniListBox2.Items.Add('���ν�����' + FormatFloat('0.00',FieldByName('guan_xian_jing_tie').AsCurrency));
        end;
        //
        if FieldByName('gang_wei_jing_tie').Value<>0 then
        begin
          UniListBox2.Items.Add('��λ������' + FormatFloat('0.00',FieldByName('gang_wei_jing_tie').AsCurrency));
        end;
        //
        if FieldByName('tong_xun_bu_zhu').Value<>0 then
        begin
          UniListBox2.Items.Add('ͨѶ������' + FormatFloat('0.00',FieldByName('tong_xun_bu_zhu').AsCurrency));
        end;
        //
        if FieldByName('jian_ku_jing_tie').Value<>0 then
        begin
          UniListBox2.Items.Add('����Զ����������' + FormatFloat('0.00',FieldByName('jian_ku_jing_tie').AsCurrency));
        end;
        //
        if FieldByName('jiao_tong_bao_gan').Value<>0 then
        begin
          UniListBox2.Items.Add('��ͨ���ɣ�' + FormatFloat('0.00',FieldByName('jiao_tong_bao_gan').AsCurrency));
        end;
        //
        if FieldByName('wu_jia_bu_tie').Value<>0 then
        begin
          UniListBox2.Items.Add('��۲�����' + FormatFloat('0.00',FieldByName('wu_jia_bu_tie').AsCurrency));
        end;
        //
        if FieldByName('bao_jian_jing_tie').Value<>0 then
        begin
          UniListBox2.Items.Add('����������' + FormatFloat('0.00',FieldByName('bao_jian_jing_tie').AsCurrency));
        end;
        //
        if FieldByName('gong_wu_bu_tie').Value<>0 then
        begin
          UniListBox2.Items.Add('����ͨ������' + FormatFloat('0.00',FieldByName('gong_wu_bu_tie').AsCurrency));
        end;
        //
        if FieldByName('zhu_fang_bu_tie').Value<>0 then
        begin
          UniListBox2.Items.Add('ס����ҵ��������' + FormatFloat('0.00',FieldByName('zhu_fang_bu_tie').AsCurrency));
        end;
        //
        UniListBox2.Items.Add('Ӧ���ϼƣ�' + FormatFloat('0.00',FieldByName('ying_fa').AsCurrency)); // Ӧ���ϼ���
        //
        UniListBox2.Items.Add('Ӧ����Ŀ��'); // ��ʼ���Ӧ������
        //
        if FieldByName('yang_lao_bao_xian').Value<>0 then
        begin
          UniListBox2.Items.Add('���ϱ��գ�-' + FormatFloat('0.00',FieldByName('yang_lao_bao_xian').AsCurrency));
        end;
        //
        if FieldByName('zhi_ye_nian_jin').Value<>0 then
        begin
          UniListBox2.Items.Add('ְҵ���-' + FormatFloat('0.00',FieldByName('zhi_ye_nian_jin').AsCurrency));
        end;
        //
        if FieldByName('qing_jia_kou_kuan').Value<>0 then
        begin
          UniListBox2.Items.Add('��ٿۿ-' + FormatFloat('0.00',FieldByName('qing_jia_kou_kuan').AsCurrency));
        end;
        //
        if FieldByName('gong_ji_jin').Value<>0 then
        begin
          UniListBox2.Items.Add('������-' + FormatFloat('0.00',FieldByName('gong_ji_jin').AsCurrency));
        end;
        //
        if FieldByName('gong_hui_fei').Value<>0 then
        begin
          UniListBox2.Items.Add('����ѣ�-' + FormatFloat('0.00',FieldByName('gong_hui_fei').AsCurrency));
        end;
        //
        if FieldByName('yi_bao').Value<>0 then
        begin
          UniListBox2.Items.Add('ҽ�Ƹ��ˣ�-' + FormatFloat('0.00',FieldByName('yi_bao').AsCurrency));
        end;
        //
        if FieldByName('ge_shui').Value<>0 then
        begin
          UniListBox2.Items.Add('��������˰��-' + FormatFloat('0.00',FieldByName('ge_shui').AsCurrency));
        end;
        //
        if FieldByName('fang_zu').Value<>0 then
        begin
          UniListBox2.Items.Add('���⣺-' + FormatFloat('0.00',FieldByName('fang_zu').AsCurrency));
        end;
        //
        if FieldByName('shui_fei').Value<>0 then
        begin
          UniListBox2.Items.Add('ˮ�ѣ�-' + FormatFloat('0.00',FieldByName('shui_fei').AsCurrency));
        end;
        //
        UniListBox2.Items.Add('Ӧ�ۺϼƣ�-' + FormatFloat('0.00',FieldByName('ying_kou').AsCurrency)); // Ӧ�ۺϼ���
        UniListBox2.Items.Add('ʵ������' + FormatFloat('0.00',FieldByName('shi_fa').AsCurrency)); // Ӧ�ۺϼ���
      end;
    end;
    // �ı�unilistbox��ʾ������ɫ
  end;
end;

//
// ��ѡ��Ʒģ����� ------------------------------------------------------------

initialization
  RegisterAppFormClass(TMainForm);

end.
