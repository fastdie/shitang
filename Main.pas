unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniPanel, uniPageControl,
  uniGUIBaseClasses, uniButton, uniLabel, uniEdit, uniGroupBox, uniStatusBar;

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
    procedure UniFormCreate(Sender: TObject);
    procedure UniButton1Click(Sender: TObject);
  private
    { Private declarations }
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
      ParamByName('gong_hao').Value:=global_gonghao;
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
      ParamByName('gong_hao').Value:=global_gonghao;
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

procedure TMainForm.UniFormCreate(Sender: TObject);
begin
  //
end;

initialization
  RegisterAppFormClass(TMainForm);

end.
