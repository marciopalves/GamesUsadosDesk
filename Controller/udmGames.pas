unit udmGames;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.JSON, Rest.Json;

type
  TDMGames = class(TDataModule)
    mtGames: TFDMemTable;
    dsGames: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    ListaJsonGames: String;

    procedure ListarGames;

  end;

var
  DMGames: TDMGames;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

Uses untUtils, udmConexao,
     REST.Types, REST.JsonReflect, RESTRequest4D, untGame;

Const
  RESOURCE = '/games?page=0';

{ TDMGames }

procedure TDMGames.DataModuleCreate(Sender: TObject);
begin
  //
end;

procedure TDMGames.ListarGames;
Var
  vResp: IResponse;
  vJsonArray: TJSONArray;
begin
  vResp := TRequest.New
             .BaseURL(DMConexao.BaseUrl)
             .Resource(RESOURCE)
             .Accept(REST.Types.CONTENTTYPE_APPLICATION_JSON)
             .DataSetAdapter(mtGames)
             .Get;

  if vResp.StatusCode = 200 then
    GerarLog('Listar Games QTD Registros.:'+mtGames.RecordCount.ToString)
  else GerarLog('Listar Games Erro Status Code:'+vResp.StatusCode.ToString);

  GerarLog('Json Retornado:'+vResp.JSONValue.ToString);
  GerarLog('Json *** '+vResp.Content);

  ListaJsonGames := vResp.Content;
end;


end.
