unit udmUsers;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDMUsers = class(TDataModule)
    mtUsers: TFDMemTable;
    dsUsers: TDataSource;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure ListarUsuarios;
  end;

var
  DMUsers: TDMUsers;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

Uses untUtils, udmConexao, REST.Types, RESTRequest4D;

{ TDMUsers }

Const
  RESOURCE_LISTAR = '/users';


procedure TDMUsers.ListarUsuarios;
Var
  vResp: IResponse;
begin
  vResp := TRequest.New
      .BaseURL(DMConexao.BaseUrl)
      .Resource(RESOURCE_LISTAR)
      .TokenBearer(DMConexao.Login.Token)
      .Accept(REST.Types.CONTENTTYPE_APPLICATION_JSON)
      .DataSetAdapter(mtUsers)
      .Get;
  if vResp.StatusCode = 200 then
    GerarLog('Listar Usu�rios.:'+mtUsers.RecordCount.ToString)
  else GerarLog('Listar Usu�rios Erro Status Code:'+vResp.StatusCode.ToString);

  GerarLog('Json Retornado:'+vResp.JSONValue.ToString);
  GerarLog('Json *** '+vResp.Content);

end;

end.
