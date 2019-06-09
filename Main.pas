unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniPanel, uniPageControl,
  uniGUIBaseClasses, uniButton, uniLabel, uniEdit, uniGroupBox, uniStatusBar,
  uniTreeView, uniDateTimePicker;

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

// ��ʼ�� ----------------------------------------------------------------------
//
procedure TMainForm.UniFormCreate(Sender: TObject);
begin
  UniDateTimePicker1.DateTime:=now();
  UniDateTimePicker2.DateTime:=now();
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
//
// �������ģ����� ------------------------------------------------------------

// ����ģ�� --------------------------------------------------------------------
//
procedure TMainForm.UniButton2Click(Sender: TObject);
begin
  // ��ѡ
end;

procedure TMainForm.UniButton3Click(Sender: TObject);
begin
  // ȫѡ
end;

procedure TMainForm.UniButton4Click(Sender: TObject);
begin
  // ���涩����Ϣ
end;

procedure TMainForm.UniDateTimePicker1Change(Sender: TObject);
begin
  //
end;
//
// ����ģ����� ----------------------------------------------------------------

// �˲�ģ�� --------------------------------------------------------------------
//
procedure TMainForm.UniDateTimePicker2Change(Sender: TObject);
begin
  // �˲�
end;

procedure TMainForm.UniButton5Click(Sender: TObject);
begin
  // ����
end;

procedure TMainForm.UniButton6Click(Sender: TObject);
begin
  // ȫ��
end;

procedure TMainForm.UniButton7Click(Sender: TObject);
begin
  // ɾ��
end;
//
// �˲�ģ����� ----------------------------------------------------------------


initialization
  RegisterAppFormClass(TMainForm);

end.
