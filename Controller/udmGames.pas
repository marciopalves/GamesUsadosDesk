unit udmGames;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.JSON, Rest.Json, Datasnap.DBClient;

type
  TDMGames = class(TDataModule)
    mtGames: TFDMemTable;
    dsGames: TDataSource;
    cdsGamesMemoria: TClientDataSet;
    cdsGamesMemoriaId: TIntegerField;
    cdsGamesMemoriaTitle: TStringField;
    cdsGamesMemoriaPlataforma: TStringField;
    cdsGamesMemoriaImage: TStringField;
    dsGamesMemoria: TDataSource;
    procedure DataModuleCreate(Sender: TObject);
  private
    FListaJsonGames: String;
    { Private declarations }
    procedure CarregarGamesMemoria();

  public
    { Public declarations }
    property ListaJsonGames: String read FListaJsonGames write FListaJsonGames;
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
  cdsGamesMemoria.CreateDataSet;
end;

procedure TDMGames.ListarGames;
Var
  vResp: IResponse;
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

  CarregarGamesMemoria();

end;

procedure TDMGames.CarregarGamesMemoria;
Var
  vObjetoJson,
  vSubObjJson: TJsonObject;
  vJsonValor,
  vJsonItem: TJsonValue;
  vArrayGames: TJSonArray;
  vCont, i: Integer;
begin
  GerarLog('Carregar Games Memoria');
  vObjetoJson := TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(DMGames.ListaJsonGames), 0) as TJsonObject;

  vJsonValor  := vObjetoJson.Get('content').JsonValue;
  vArrayGames := vJsonValor as TJSONArray;

  for vCont := 0 to vArrayGames.Size -1 do
  begin
    vSubObjJson  := (vArrayGames.Get(vCont) as TJsonObject);

    cdsGamesMemoria.Insert;
    cdsGamesMemoriaId.AsInteger         :=  StrToIntDef(RetornaDepois(':', vSubObjJson.Pairs[0].ToString), 0);
    cdsGamesMemoriaTitle.AsString       :=  RetornaDepois(':', vSubObjJson.Pairs[1].ToString);
    cdsGamesMemoriaPlataforma.AsString  :=  RetornaDepois(':', vSubObjJson.Pairs[2].ToString);
    cdsGamesMemoriaImage.AsString       :=  RetornaDepois(':', vSubObjJson.Pairs[4].ToString);

    cdsGamesMemoria.Post;
  end;
end;

end.
