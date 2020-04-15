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

// 自定义过程 ------------------------------------------------------------------

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
  // 此处加入订餐代码
  //
  if SelectedNode1.Text='早餐' then
  begin
    //
  end
  else if SelectedNode1.Text='午餐' then
  begin
    //
  end
  else if SelectedNode1.Text='晚餐' then
  begin
    //
  end
  else begin
    try
      order_kind:=SelectedNode1.Parent.Text;
      i:=pos(':',SelectedNode1.Text);
      food_name:=copy(SelectedNode1.Text,1,i-1);
      food_price:=copy(SelectedNode1.text,i+1,length(SelectedNode1.Text));
      i:=pos('元',food_price);
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
        //ShowMessageN('订餐成功');
      end;
    except
      ShowMessageN('订餐失败，请联系管理员,'+food_name+','+food_price);
    end;
  end;
end;

// 自定义过程结束 --------------------------------------------------------------

// 初始化 ----------------------------------------------------------------------
//
procedure TMainForm.UniFormCreate(Sender: TObject);  // 根据用户权限决定显示页面范围
begin
  UniDateTimePicker1.DateTime:=now();
  UniDateTimePicker2.DateTime:=now();
  if UniMainModule.global_authority='食堂管理员' then
  begin
    UniTabSheet1.TabVisible:=false;   // 日常订餐功能不可用
    UniTabSheet2.TabVisible:=false;   // 查询退餐功能不可用
    //UniTabSheet3.TabVisible:=false; // 修改密码功能 可用
    //UniTabSheet4.TabVisible:=false; // 订餐统计功能 可用
    //UniTabSheet5.TabVisible:=false;   // 查询工资 可用
  end
  else if (UniMainModule.global_authority='在编人员') then
  begin
    //UniTabSheet1.TabVisible:=false;  // 日常订餐 可用
    //UniTabSheet2.TabVisible:=false;  // 查询退餐 可用
    //UniTabSheet3.TabVisible:=false;  // 修改密码 可用
    UniTabSheet4.TabVisible:=false;  // 订餐统计不可用
    UniTabSheet5.TabVisible:=false;  // 查询工资不可用
  end
  else if (UniMainModule.global_authority='非编人员') then
  begin
    //UniTabSheet1.TabVisible:=false;  // 日常订餐 可用
    //UniTabSheet2.TabVisible:=false;  // 查询退餐 可用
    //UniTabSheet3.TabVisible:=false;  // 修改密码 可用
    UniTabSheet4.TabVisible:=false;  // 订餐统计不可用
    UniTabSheet5.TabVisible:=false;  // 查询工资不可用
  end
  else begin  // 家属组
    //UniTabSheet1.TabVisible:=false;  // 日常订餐 可用
    //UniTabSheet2.TabVisible:=false;  // 查询退餐 可用
    //UniTabSheet3.TabVisible:=false;  // 修改密码 可用
    UniTabSheet4.TabVisible:=false;  // 订餐统计不可用
    UniTabSheet5.TabVisible:=false;  // 查询工资不可用
  end;
  //
end;

procedure TMainForm.UniTabSheet1BeforeActivate(Sender: TObject;  // 订餐/退餐页面初始化
  var AllowActivate: Boolean);
var
  account:single;
begin
  // 初始化
  UniDateTimePicker1.DateTime:=now();
  UniTreeView1.Items.Clear;
  account:=0.00;
  UniLabel4.Text:='欢迎你，'+UniMainModule.global_username;
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
  UniLabel4.Text:=UniLabel4.Text + '；你的余额为 ' + formatfloat('0.00',account) + ' 元。';
  // 添加菜单信息
  if (UniMainModule.global_authority='在编人员') or (UniMainModule.global_authority='非编人员') then
  begin
    //
  end
  else if (UniMainModule.global_authority='家属') then
  begin
    if (account<=0) then  // 判断余额，余额不足或欠费则提示充值后再点餐
    begin
      UniLabel4.Text:=UniLabel4.Text + '你的余额较低，请提前充值后再订餐。';
      UniLabel4.Font.Color:=clRed;
    end;
  end;
end;

procedure TMainForm.UniTabSheet2BeforeActivate(Sender: TObject;  // 查询退餐页面初始化
  var AllowActivate: Boolean);

begin
  UniDateTimePicker2.DateTime:=now();
  UniListBox1.Items.Clear;
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

procedure TMainForm.UniTabSheet5BeforeActivate(Sender: TObject;  // 工资查询页面初始化
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
procedure TMainForm.UniDateTimePicker1Change(Sender: TObject);  // 选择订餐日期，刷新订餐列表
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
        SQL.Add('select food_name,food_price from menulist_table');
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
            UniTreeView1.Items.AddChild(mytreenode1,FieldByName('food_name').AsString + ':' + FieldByName('food_price').AsString + '元');
            Next;
          end;
        end;
      end;
      //
      with MainModule.UniMainModule.dingcan_query do  // 添加午餐
      begin
        Close;
        SQL.Clear;
        SQL.Add('select food_name,food_price from menulist_table');
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
            UniTreeView1.Items.AddChild(mytreenode2,FieldByName('food_name').AsString + ':' + FieldByName('food_price').AsString + '元');
            Next;
          end;
        end;
      end;
      //
      with MainModule.UniMainModule.dingcan_query do  // 添加晚餐
      begin
        Close;
        SQL.Clear;
        SQL.Add('select food_name,food_price from menulist_table');
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
            UniTreeView1.Items.AddChild(mytreenode3,FieldByName('food_name').AsString + ':' + FieldByName('food_price').AsString + '元');
            Next;
          end;
        end;
      end;
    end
    else begin  // 提示不能选择当天或之前
      UniTreeView1.Items.Clear;
      ShowMessageN('订餐时间不能选择当天或之前');
    end;
  end;
end;

procedure TMainForm.UniDateTimePicker2Change(Sender: TObject);  // 查询个人订餐数据
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
  with MainModule.UniMainModule.exec_query do  // 添加已订餐信息
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
        UniListBox1.Items.Add(order_kind+':'+food_name+':'+formatfloat('0.00',food_price)+'元');
        Next;
      end;
      UniListBox1.Items.Add('以上合计金额为:'+formatfloat('0.00',total_price)+'元');
    end;
  end;
  //
  if strtoint(FormatDateTime('yyyyMMdd',UniDateTimePicker2.DateTime)) <= strtoint(FormatDateTime('yyyyMMdd',now())) then
  begin
    // 日期选择了当天或以往，不允许退餐
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

procedure TMainForm.UniButton2Click(Sender: TObject);  // 退餐
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
    // 提示超过退餐时间段，不允许退餐
  end
  else begin
    // 符合退餐条件，允许退餐
    del_str:=UniListBox1.Items.Strings[UniListBox1.ItemIndex];
    if (pos(':',del_str)>0) then
    begin
      order_kind:=copy(del_str,1,pos(':',del_str)-1);
      del_str:=copy(del_str,pos(':',del_str)+1,length(del_str));  // 重赋值操作
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
        ShowMessageN('退餐过程中碰到问题，请联系管理员');
      end;
      //
      UniListBox1.Items.Clear;
      with MainModule.UniMainModule.exec_query do  // 刷新已订餐信息
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
            UniListBox1.Items.Add(order_kind+':'+food_name+':'+Formatfloat('0.00',food_price)+'元');
            Next;
          end;
        end;
      end;
    end;
  end;
end;

procedure TMainForm.UniButton6Click(Sender: TObject);  // 全选退餐 待修改
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
      ShowMessageN('退餐过程中碰到问题，请联系管理员');
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
  if (SelectedNode1.Parent = nil) then  // 选择了根节点
  begin
    // do nothing
  end
  else begin
    show_str:='您当前选择的是"'+SelectedNode1.Text+'",是否确认订餐？';
    MessageDlg(show_str,mtconfirmation,[mbYes,mbNo],confirmsave);
  end;
end;

procedure TMainForm.UniTreeView1DblClick(Sender: TObject);

begin
  //
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

// 点选物品模块 ----------------------------------------------------------------
//

procedure TMainForm.UniComboBox1Change(Sender: TObject);  // 查询工资
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
        UniListBox2.Items.Add('应发项目：'); // 开始输出应发数据
        //
        if FieldByName('zhi_wu_gong_zi').Value<>0 then
        begin
          UniListBox2.Items.Add('职务工资：' + FormatFloat('0.00',FieldByName('zhi_wu_gong_zi').AsCurrency));
        end;
        //
        if FieldByName('ji_bie_gong_zi').Value<>0 then
        begin
          UniListBox2.Items.Add('级别工资：' + FormatFloat('0.00',FieldByName('ji_bie_gong_zi').AsCurrency));
        end;
        //
        if FieldByName('shi_yong_qi').Value<>0 then
        begin
          UniListBox2.Items.Add('试用期工资：' + FormatFloat('0.00',FieldByName('shi_yong_qi').AsCurrency));
        end;
        //
        if FieldByName('gong_ren_gang_wei').Value<>0 then
        begin
          UniListBox2.Items.Add('工人岗位工资：' + FormatFloat('0.00',FieldByName('gong_ren_gang_wei').AsCurrency));
        end;
        //
        if FieldByName('ji_shu_deng_ji').Value<>0 then
        begin
          UniListBox2.Items.Add('技术等级工资：' + FormatFloat('0.00',FieldByName('ji_shu_deng_ji').AsCurrency));
        end;
        //
        if FieldByName('gui_fan_jing_tie').Value<>0 then
        begin
          UniListBox2.Items.Add('规范津贴：' + FormatFloat('0.00',FieldByName('gui_fan_jing_tie').AsCurrency));
        end;
        //
        if FieldByName('guan_xian_jing_tie').Value<>0 then
        begin
          UniListBox2.Items.Add('关衔津贴：' + FormatFloat('0.00',FieldByName('guan_xian_jing_tie').AsCurrency));
        end;
        //
        if FieldByName('gang_wei_jing_tie').Value<>0 then
        begin
          UniListBox2.Items.Add('岗位津贴：' + FormatFloat('0.00',FieldByName('gang_wei_jing_tie').AsCurrency));
        end;
        //
        if FieldByName('tong_xun_bu_zhu').Value<>0 then
        begin
          UniListBox2.Items.Add('通讯补助：' + FormatFloat('0.00',FieldByName('tong_xun_bu_zhu').AsCurrency));
        end;
        //
        if FieldByName('jian_ku_jing_tie').Value<>0 then
        begin
          UniListBox2.Items.Add('艰苦边远地区津贴：' + FormatFloat('0.00',FieldByName('jian_ku_jing_tie').AsCurrency));
        end;
        //
        if FieldByName('jiao_tong_bao_gan').Value<>0 then
        begin
          UniListBox2.Items.Add('交通包干：' + FormatFloat('0.00',FieldByName('jiao_tong_bao_gan').AsCurrency));
        end;
        //
        if FieldByName('wu_jia_bu_tie').Value<>0 then
        begin
          UniListBox2.Items.Add('物价补贴：' + FormatFloat('0.00',FieldByName('wu_jia_bu_tie').AsCurrency));
        end;
        //
        if FieldByName('bao_jian_jing_tie').Value<>0 then
        begin
          UniListBox2.Items.Add('保健津贴：' + FormatFloat('0.00',FieldByName('bao_jian_jing_tie').AsCurrency));
        end;
        //
        if FieldByName('gong_wu_bu_tie').Value<>0 then
        begin
          UniListBox2.Items.Add('公务交通补贴：' + FormatFloat('0.00',FieldByName('gong_wu_bu_tie').AsCurrency));
        end;
        //
        if FieldByName('zhu_fang_bu_tie').Value<>0 then
        begin
          UniListBox2.Items.Add('住房物业服务补贴：' + FormatFloat('0.00',FieldByName('zhu_fang_bu_tie').AsCurrency));
        end;
        //
        UniListBox2.Items.Add('应发合计：' + FormatFloat('0.00',FieldByName('ying_fa').AsCurrency)); // 应发合计数
        //
        UniListBox2.Items.Add('应扣项目：'); // 开始输出应扣数据
        //
        if FieldByName('yang_lao_bao_xian').Value<>0 then
        begin
          UniListBox2.Items.Add('养老保险：-' + FormatFloat('0.00',FieldByName('yang_lao_bao_xian').AsCurrency));
        end;
        //
        if FieldByName('zhi_ye_nian_jin').Value<>0 then
        begin
          UniListBox2.Items.Add('职业年金：-' + FormatFloat('0.00',FieldByName('zhi_ye_nian_jin').AsCurrency));
        end;
        //
        if FieldByName('qing_jia_kou_kuan').Value<>0 then
        begin
          UniListBox2.Items.Add('请假扣款：-' + FormatFloat('0.00',FieldByName('qing_jia_kou_kuan').AsCurrency));
        end;
        //
        if FieldByName('gong_ji_jin').Value<>0 then
        begin
          UniListBox2.Items.Add('公积金：-' + FormatFloat('0.00',FieldByName('gong_ji_jin').AsCurrency));
        end;
        //
        if FieldByName('gong_hui_fei').Value<>0 then
        begin
          UniListBox2.Items.Add('工会费：-' + FormatFloat('0.00',FieldByName('gong_hui_fei').AsCurrency));
        end;
        //
        if FieldByName('yi_bao').Value<>0 then
        begin
          UniListBox2.Items.Add('医疗个人：-' + FormatFloat('0.00',FieldByName('yi_bao').AsCurrency));
        end;
        //
        if FieldByName('ge_shui').Value<>0 then
        begin
          UniListBox2.Items.Add('个人所得税：-' + FormatFloat('0.00',FieldByName('ge_shui').AsCurrency));
        end;
        //
        if FieldByName('fang_zu').Value<>0 then
        begin
          UniListBox2.Items.Add('房租：-' + FormatFloat('0.00',FieldByName('fang_zu').AsCurrency));
        end;
        //
        if FieldByName('shui_fei').Value<>0 then
        begin
          UniListBox2.Items.Add('水费：-' + FormatFloat('0.00',FieldByName('shui_fei').AsCurrency));
        end;
        //
        UniListBox2.Items.Add('应扣合计：-' + FormatFloat('0.00',FieldByName('ying_kou').AsCurrency)); // 应扣合计数
        UniListBox2.Items.Add('实发数：' + FormatFloat('0.00',FieldByName('shi_fa').AsCurrency)); // 应扣合计数
      end;
    end;
    // 改变unilistbox显示内容颜色
  end;
end;

//
// 点选物品模块结束 ------------------------------------------------------------

initialization
  RegisterAppFormClass(TMainForm);

end.
