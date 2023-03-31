unit udmPlataforma;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TDMPlataforma = class(TDataModule)
    mtPlataforma: TFDMemTable;
    dsPlataforma: TDataSource;

  private
    { Private declarations }
  public
    { Public declarations }
    procedure ListarPlataformas;
    function CriarNovaPlataforma(const pNome: String ):Boolean;

  end;

var
  DMPlataforma: TDMPlataforma;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

Uses untUtils, udmConexao,
     REST.Types, REST.JsonReflect, RESTRequest4D;

Const
  RESOURCE_LISTAR = '/platforms';
  RESOURCE_CRIAR = '/platforms/register/';

{ TDMPlataforma }

procedure TDMPlataforma.ListarPlataformas;
begin
  TRequest.New
      .BaseURL(DMConexao.BaseUrl)
      .Resource(RESOURCE_LISTAR)
      .Accept(REST.Types.CONTENTTYPE_APPLICATION_JSON)
      .DataSetAdapter(mtPlataforma)
      .Get;
end;

function TDMPlataforma.CriarNovaPlataforma(const pNome: String): Boolean;
Var
  vResp: IResponse;
begin
  if Trim(pNome) <> EmptyStr then
  begin
    try
      vResp := TRequest.New
                  .BaseURL(DMConexao.BaseUrl)
                  .Resource(RESOURCE_CRIAR + pNome)
                  .TokenBearer(DMConexao.Login.Token)
                  .Accept(REST.Types.CONTENTTYPE_APPLICATION_JSON)
                  .Post;
      result := vResp.StatusCode = 200;
    except
      on e:exception do
      begin
        raise Exception.Create('Erro ao criar Plataforma!'+slIneBreak+e.ToString);
      end;
    end;
  end;
end;

end.
