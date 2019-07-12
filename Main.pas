unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniPanel, uniPageControl,
  uniGUIBaseClasses, uniButton, uniLabel, uniEdit, uniGroupBox, uniStatusBar,
  uniTreeView, uniDateTimePicker, uniTimer, uniMemo, uniBasicGrid, uniDBGrid;

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
    UniTimer1: TUniTimer;
    UniButton8: TUniButton;
    UniButton9: TUniButton;
    UniTabSheet4: TUniTabSheet;
    UniDateTimePicker3: TUniDateTimePicker;
    UniMemo1: TUniMemo;
    UniDateTimePicker2: TUniDateTimePicker;
    UniMemo2: TUniMemo;
    UniTabSheet5: TUniTabSheet;
    UniDBGrid1: TUniDBGrid;
    UniButton5: TUniButton;
    UniDateTimePicker4: TUniDateTimePicker;
    procedure UniFormCreate(Sender: TObject);
    procedure UniButton1Click(Sender: TObject);
    procedure UniTabSheet1BeforeActivate(Sender: TObject;
      var AllowActivate: Boolean);
    procedure UniDateTimePicker1Change(Sender: TObject);
    procedure UniButton2Click(Sender: TObject);
    procedure UniButton3Click(Sender: TObject);
    procedure UniButton4Click(Sender: TObject);
    procedure UniTabSheet3BeforeActivate(Sender: TObject;
      var AllowActivate: Boolean);
    procedure UniTreeView1Change(Sender: TObject; Node: TUniTreeNode);
    procedure UniTimer1Timer(Sender: TObject);
    procedure UniButton8Click(Sender: TObject);
    procedure UniButton9Click(Sender: TObject);
    procedure UniDateTimePicker3Change(Sender: TObject);
    procedure UniTabSheet2BeforeActivate(Sender: TObject;
      var AllowActivate: Boolean);
    procedure UniTabSheet4BeforeActivate(Sender: TObject;
      var AllowActivate: Boolean);
    procedure UniDateTimePicker2Change(Sender: TObject);
    procedure UniTabSheet5BeforeActivate(Sender: TObject;
      var AllowActivate: Boolean);
  private
    { Private declarations }
    SelectedNode1 : TUniTreeNode;
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

// 初始化 ----------------------------------------------------------------------
//
procedure TMainForm.UniFormCreate(Sender: TObject);  // 根据用户权限决定显示页面范围
begin
  UniDateTimePicker1.DateTime:=now();
  if UniMainModule.global_authority='食堂管理员' then
  begin
    UniTabSheet1.TabVisible:=false;
    UniTabSheet2.TabVisible:=false;
  end
  else begin
    UniTabSheet4.TabVisible:=false;
  end;
  //
end;

procedure TMainForm.UniTabSheet1BeforeActivate(Sender: TObject;  // 订餐/退餐页面初始化
  var AllowActivate: Boolean);
begin
  // 初始化
  UniDateTimePicker1.DateTime:=now();
  UniTreeView1.Items.Clear;
  UniTreeView2.Items.Clear;
  // 添加菜单信息
end;

procedure TMainForm.UniTabSheet2BeforeActivate(Sender: TObject;  // 查询页面初始化
  var AllowActivate: Boolean);
var
  input_date:string;
  order_kind,food_name:string;
  i:integer;
begin
  UniDateTimePicker2.DateTime:=now();
  UniMemo2.Clear;
  input_date:=FormatDateTime('yyyy-MM-dd',UniDateTimePicker2.DateTime);
  //
  with MainModule.UniMainModule.exec_query do  // 在MEMO中列出所选日期的订餐记录
  begin
    Close;
    SQL.Clear;
    SQL.Add('select order_kind,food_name from order_table');
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
        UniMemo2.Lines.Add(order_kind+':'+food_name);
        Next;
      end;
    end;
  end;

end;

procedure TMainForm.UniTabSheet3BeforeActivate(Sender: TObject;  // 修改密码页面初始化
  var AllowActivate: Boolean);
begin
  // 初始化
  UniEdit1.Clear;
  UniEdit2.Clear;
  UniEdit3.Clear;
end;

procedure TMainForm.UniTabSheet4BeforeActivate(Sender: TObject;  // 查询统计页面初始化
  var AllowActivate: Boolean);
begin
  UniDateTimePicker3.DateTime:=now();
  UniMemo1.Clear;
end;

procedure TMainForm.UniTabSheet5BeforeActivate(Sender: TObject;
  var AllowActivate: Boolean);
begin
  UniDateTimePicker3.DateTime:=now();
end;

procedure TMainForm.UniTimer1Timer(Sender: TObject);
begin
  UniTreeView1.FullExpand;
end;
//
// 初始化结束 ------------------------------------------------------------------

// 密码管理模块 ----------------------------------------------------------------
//
procedure TMainForm.UniButton1Click(Sender: TObject);  // 修改密码
var
  old_pwd,new_pwd:string;
  old_pwd_flag,change_pwd_flag:boolean;
begin
  old_pwd_flag:=false;
  change_pwd_flag:=false;
  //
  if Trim(UniEdit1.Text)='' then
  begin
    ShowMessageN('请输入旧密码');
  end
  else if Trim(UniEdit2.Text)='' then
  begin
    ShowMessageN('请输入新密码');
  end
  else if Trim(UniEdit3.Text)='' then
  begin
    ShowMessageN('请重复新密码');
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
        old_pwd_flag:=true;  // 旧密码输入正确
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
          change_pwd_flag:=true;  // 新密码输入符合标准
        end
        else begin
          UniEdit2.Clear;
          UniEdit3.Clear;
          ShowMessageN('新密码最大长度为20位，请重新输入');
        end;
      end
      else begin
        UniEdit2.Clear;
        UniEdit3.Clear;
        ShowMessageN('前后输入的密码有误，请重新输入');
      end;
    end
    else begin
      UniEdit1.Clear;
      ShowMessageN('旧密码错误，请重新输入');
    end;
  end;
  //
  if change_pwd_flag then
  try
    with MainModule.UniMainModule.exec_query do  // 执行修改密码操作
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
    ShowMessageN('密码已修改');
  except
    ShowMessageN('更改密码过程中碰到问题，请联系管理员');
  end;
end;

procedure TMainForm.UniButton8Click(Sender: TObject);
begin
  ShowMessage('用户名：'+UniMainModule.global_username+';工号：'+UniMainModule.global_gonghao+';部门：'+UniMainModule.global_department+';');
end;

//
// 密码管理模块结束 ------------------------------------------------------------

// 订餐模块 --------------------------------------------------------------------
//
procedure TMainForm.UniDateTimePicker1Change(Sender: TObject);
var
  mytreenode1,mytreenode2,mytreenode3:TUniTreeNode;
  order_date:string;
  order_kind,food_name:string;
  i:integer;
  server_time:TDateTime;
  date_str,time_str:string;
begin
  server_time:=UniMainModule.GetSysTime;
  date_str:=FormatDateTime('yyyyMMdd',server_time);
  time_str:=FormatDateTime('hhmmss',server_time);
  //
  if (strtoint(time_str)>=190000) and (strtoint(time_str)<=235959) then  // 晚七点以后
  begin
    // 提示不允许订餐
    ShowMessageN('晚七点以后不允许订餐，请谅解');
  end
  else begin
    // 在允许订餐时间范围内，开始检查日期
    if strtoint(FormatDateTime('yyyyMMdd',UniDateTimePicker1.DateTime))>strtoint(date_str) then  // 选择日期大于服务器当日日期
    begin
      // 允许订餐，开始列出选择日期的菜品信息
      order_date:=FormatDateTime('yyyy-MM-dd',UniDateTimePicker1.DateTime);
      UniTreeview1.Items.Clear;
      UniTreeView2.Items.Clear;
      //
      with UniTreeview1 do  // 添加rootnode
      begin
        mytreenode1:=Items.Add(nil,'早餐');
        mytreenode2:=Items.Add(nil,'午餐');
        mytreenode3:=Items.Add(nil,'晚餐');
      end;
      //
      with MainModule.UniMainModule.dingcan_query do  // 添加早餐
      begin
        Close;
        SQL.Clear;
        SQL.Add('select food_name from menulist_table');
        SQL.Add('where order_date=:order_date');
        SQL.Add('and order_kind=:order_kind');
        SQL.Add('order by food_name');
        ParamByName('order_date').Value:=order_date;
        ParamByName('order_kind').Value:='早餐';
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
      with MainModule.UniMainModule.dingcan_query do  // 添加午餐
      begin
        Close;
        SQL.Clear;
        SQL.Add('select food_name from menulist_table');
        SQL.Add('where order_date=:order_date');
        SQL.Add('and order_kind=:order_kind');
        SQL.Add('order by food_name');
        ParamByName('order_date').Value:=order_date;
        ParamByName('order_kind').Value:='午餐';
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
      with MainModule.UniMainModule.dingcan_query do  // 添加晚餐
      begin
        Close;
        SQL.Clear;
        SQL.Add('select food_name from menulist_table');
        SQL.Add('where order_date=:order_date');
        SQL.Add('and order_kind=:order_kind');
        SQL.Add('order by food_name');
        ParamByName('order_date').Value:=order_date;
        ParamByName('order_kind').Value:='晚餐';
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
      with MainModule.UniMainModule.exec_query do  // 在右侧栏目添加已订餐信息
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
    end
    else begin  // 提示不能选择当天或之前
      UniTreeView1.Items.Clear;
      UniTreeView2.Items.Clear;
      ShowMessageN('订餐时间不能选择当天或之前');
    end;
  end;
end;

procedure TMainForm.UniDateTimePicker2Change(Sender: TObject);  // 查询个人订餐数据
var
  input_date:string;
  i:integer;
  order_kind,food_name:string;
begin
  UniMemo2.Lines.Clear;
  input_date:=FormatDateTime('yyyy-MM-dd',UniDateTimePicker2.DateTime);
  //
  with MainModule.UniMainModule.exec_query do  // 在MEMO中添加已订餐信息
  begin
    Close;
    SQL.Clear;
    SQL.Add('select order_kind,food_name from order_table');
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
        UniMemo2.Lines.Add(order_kind+':'+food_name);
        Next;
      end;
    end;
  end;
end;

procedure TMainForm.UniButton2Click(Sender: TObject);  // 单选
var
  order_kind,food_name,add_str:string;
  i:integer;
  add_flag:boolean;
begin
  add_flag:=true;
  if (SelectedNode1.Parent = nil) then  // 选中了rootnode
  begin
    // do nothing
  end
  else begin  // 选中了菜品信息
    order_kind:=SelectedNode1.Parent.Text;
    food_name:=SelectedNode1.Text;
    add_str:=order_kind+':'+food_name;
    //
    for i := 0 to UniTreeView2.Items.Count-1 do  // 检查选中菜品信息在右侧是否已经存在
    begin
      if (UniTreeView2.Items.Item[i].Text=add_str) then // 右侧存在选中菜品，将添加标志设为false
      begin
        add_flag:=false;
      end;
    end;
    //
    if add_flag then // 检查完毕，右侧不存在选中菜品
    begin
      UniTreeView2.Items.Add(nil,add_str);  // 执行添加操作
    end;
  end;
end;

procedure TMainForm.UniButton9Click(Sender: TObject);  // 单选撤销
var
  delete_node:TUniTreeNode;
begin
  delete_node:=UniTreeView2.Selected;
  UniTreeView2.Items.Delete(delete_node);
end;

procedure TMainForm.UniButton3Click(Sender: TObject);  // 全选
var
  order_kind,food_name,add_str:string;
  i:integer;
begin
  UniTreeView2.Items.Clear;  // 右侧全清空
  //
  for i := 0 to UniTreeView1.Items.Count-1 do  // 执行全选添加操作
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

procedure TMainForm.UniButton4Click(Sender: TObject);  // 保存订餐信息
var
  order_kind,food_name,add_str:string;
  i:integer;
begin
  if (UniTreeView2.Items.Count>0) then
  begin
    // 如果已经有订餐记录，将已存在的订餐记录标记为取消
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
      ShowMessageN('清除原订餐记录过程中出现错误，请联系管理员');
    end;
    //
    // 添加新订餐记录
    for i := 0 to UniTreeView2.Items.Count-1 do
    begin
      add_str:=UniTreeView2.Items.Item[i].Text;
      if (pos(':',add_str)>0) then
      begin
        order_kind:=copy(add_str,1,pos(':',add_str)-1);  // 获取add_str前半部分，分隔符为':'
        food_name:=copy(add_str,pos(':',add_str)+1,length(add_str));  // 获取add_str后半部分，分隔符为':'
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
            ShowMessageN('订餐信息已保存');
          end;
        except
          ShowMessageN('保存订餐信息过程中出现错误，请联系管理员');
          Exit;
        end;
      end
      else begin
        ShowMessageN('未找到字符分隔符');
      end;
    end;
    //UniTreeView2.Items.Clear;
  end
  else begin
    ShowMessageN('未存在订餐信息');
  end;
end;

procedure TMainForm.UniTreeView1Change(Sender: TObject; Node: TUniTreeNode);
begin
  SelectedNode1:=Node;
end;
//
// 订餐模块结束 ----------------------------------------------------------------

// 查询模块 --------------------------------------------------------------------
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
  with UniMainModule.exec_query do  // 列出早餐人数
  begin
    Close;
    SQL.Clear;
    SQL.Add('select user_name from order_table');
    SQL.Add('where order_date=:order_date');
    SQL.Add('and order_kind=:order_kind');
    SQL.Add('and order_cancel=:order_cancel');
    SQL.Add('group by user_name');
    ParamByName('order_date').Value:=input_date;
    ParamByName('order_kind').Value:='早餐';
    ParamByName('order_cancel').Value:='/';
    Open;
    UniMemo1.Lines.Add(input_date+' 订餐信息如下：');
    UniMemo1.Lines.Add('早餐数据：订餐人数为'+inttostr(RecordCount)+'人');
  end;
  //
  with UniMainModule.exec_query do  // 列出早餐数据
  begin
    Close;
    SQL.Clear;
    SQL.Add('select food_name,count(food_name) as food_number from order_table');
    SQL.Add('where order_date=:order_date');
    SQL.Add('and order_kind=:order_kind');
    SQL.Add('and order_cancel=:order_cancel');
    SQL.Add('group by food_name');
    ParamByName('order_date').Value:=input_date;
    ParamByName('order_kind').Value:='早餐';
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
  with UniMainModule.exec_query do  // 列出午餐人数
  begin
    Close;
    SQL.Clear;
    SQL.Add('select user_name from order_table');
    SQL.Add('where order_date=:order_date');
    SQL.Add('and order_kind=:order_kind');
    SQL.Add('and order_cancel=:order_cancel');
    SQL.Add('group by user_name');
    ParamByName('order_date').Value:=input_date;
    ParamByName('order_kind').Value:='午餐';
    ParamByName('order_cancel').Value:='/';
    Open;
    UniMemo1.Lines.Add('午餐数据：订餐人数为'+inttostr(RecordCount)+'人');
  end;
  //
  with UniMainModule.exec_query do  // 列出午餐数据
  begin
    Close;
    SQL.Clear;
    SQL.Add('select food_name,count(food_name) as food_number from order_table');
    SQL.Add('where order_date=:order_date');
    SQL.Add('and order_kind=:order_kind');
    SQL.Add('and order_cancel=:order_cancel');
    SQL.Add('group by food_name');
    ParamByName('order_date').Value:=input_date;
    ParamByName('order_kind').Value:='午餐';
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
  with UniMainModule.exec_query do  // 列出晚餐人数
  begin
    Close;
    SQL.Clear;
    SQL.Add('select user_name from order_table');
    SQL.Add('where order_date=:order_date');
    SQL.Add('and order_kind=:order_kind');
    SQL.Add('and order_cancel=:order_cancel');
    SQL.Add('group by user_name');
    ParamByName('order_date').Value:=input_date;
    ParamByName('order_kind').Value:='晚餐';
    ParamByName('order_cancel').Value:='/';
    Open;
    UniMemo1.Lines.Add('晚餐数据：订餐人数为'+inttostr(RecordCount)+'人');
  end;
  //
  with UniMainModule.exec_query do  // 列出晚餐数据
  begin
    Close;
    SQL.Clear;
    SQL.Add('select food_name,count(food_name) as food_number from order_table');
    SQL.Add('where order_date=:order_date');
    SQL.Add('and order_kind=:order_kind');
    SQL.Add('and order_cancel=:order_cancel');
    SQL.Add('group by food_name');
    ParamByName('order_date').Value:=input_date;
    ParamByName('order_kind').Value:='晚餐';
    ParamByName('order_cancel').Value:='/';
    Open;
    First;
    if RecordCount>0 then
    begin
      UniMemo1.Lines.Add('晚餐数据：');
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
// 查询模块结束 ----------------------------------------------------------------

initialization
  RegisterAppFormClass(TMainForm);

end.
