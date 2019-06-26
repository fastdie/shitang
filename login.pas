unit login;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniButton, uniEdit,
  uniGUIBaseClasses, uniLabel;

type
  TUniLoginForm1 = class(TUniLoginForm)
    UniLabel1: TUniLabel;
    UniLabel2: TUniLabel;
    UniEdit1: TUniEdit;
    UniEdit2: TUniEdit;
    UniButton1: TUniButton;
    procedure UniLoginFormCreate(Sender: TObject);
    procedure UniButton1Click(Sender: TObject);
    procedure UniEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure UniEdit2KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function UniLoginForm1: TUniLoginForm1;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, Main, public_func;

function UniLoginForm1: TUniLoginForm1;
begin
  Result := TUniLoginForm1(UniMainModule.GetFormInstance(TUniLoginForm1));
end;

procedure TUniLoginForm1.UniButton1Click(Sender: TObject); // 登录过程
var
  gong_hao,user_pwd:string;  // 工号，登录密码
begin
  if Trim(UniEdit1.Text)='' then
    ShowMessage('请输入工号')
  else if Trim(UniEdit2.Text)='' then
    ShowMessage('请输入密码')
  else
   begin
     gong_hao:=Trim(UniEdit1.Text);
     user_pwd:=Trim(UniEdit2.Text);
     user_pwd:=public_func.encoding(user_pwd,public_func.encrypt_key);  // 用户密码加密
     with MainModule.UniMainModule.exec_query do
     begin
       Close;
       SQL.Clear;
       SQL.Add('select user_name,user_department,user_authority from user_table');
       SQL.Add('where gong_hao=:gong_hao and user_pwd=:user_pwd');
       ParamByName('gong_hao').Value:=gong_hao;
       ParamByName('user_pwd').Value:=user_pwd;
       Open;
       if RecordCount=0 then  // 未找到符合条件的记录，说明账号密码不存在
       begin
         UniEdit1.Clear;
         UniEdit2.Clear;
         //
         UniMainModule.error_number:=UniMainModule.error_number+1;
         if UniMainModule.error_number<4 then
         begin
           ShowMessage('工号或密码不正确，请重新输入');
         end
         else begin
           UniLoginForm1.Close;
         end;
       end
       else begin  // 找到对应记录，将用户信息保存至全局变量
         UniMainModule.global_gonghao:=gong_hao;
         UniMainModule.global_username:=Trim(FieldByName('user_name').AsString);
         UniMainModule.global_department:=Trim(FieldByName('user_department').AsString);
         UniMainModule.global_authority:=Trim(FieldByName('user_authority').AsString);
         //
         ModalResult := mrOk;
       end;
     end;
   end;
end;

procedure TUniLoginForm1.UniEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    UniEdit2.SetFocus;
  end;
end;

procedure TUniLoginForm1.UniEdit2KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
  begin
    UniButton1.SetFocus;
  end;
end;

procedure TUniLoginForm1.UniLoginFormCreate(Sender: TObject);
begin
  UniMainModule.global_gonghao:='';
  UniMainModule.global_username:='';
  UniMainModule.global_department:='';
  UniMainModule.global_authority:='';
  UniMainModule.error_number:=0;
  UniEdit1.Clear;
  UniEdit2.Clear;
end;

initialization
  RegisterAppFormClass(TUniLoginForm1);

end.
