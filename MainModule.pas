unit MainModule;

interface

uses
  uniGUIMainModule, SysUtils, Classes, Data.DB, MemDS, DBAccess, Uni,
  UniProvider, MySQLUniProvider;

type
  TUniMainModule = class(TUniGUIMainModule)
    UniConnection1: TUniConnection;
    MySQLUniProvider1: TMySQLUniProvider;
    exec_query: TUniQuery;
    dingcan_query: TUniQuery;
    tuican_query: TUniQuery;
    fankui_ds: TUniDataSource;
    fankui_query: TUniQuery;
  private
    { Private declarations }
  public
    // 定义全局变量，用来保存登录用户的工号，用户名，所属部门，用户权限等信息
    global_gonghao,global_username,global_department,global_authority:string;
    error_number:integer;
    function GetSysTime: TDateTime;
    { Public declarations }
  end;

function UniMainModule: TUniMainModule;

implementation



{$R *.dfm}

uses
  UniGUIVars, ServerModule, uniGUIApplication;

function UniMainModule: TUniMainModule;
begin
  Result := TUniMainModule(UniApplication.UniMainModule)
end;

function TUniMainModule.GetSysTime: TDateTime;
begin
  with UniMainModule.exec_query do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select now() as SysTime');
    Open;
    Result:=FieldByName('SysTime').AsDateTime;
  end;
end;

initialization
  RegisterMainModuleClass(TUniMainModule);
end.

