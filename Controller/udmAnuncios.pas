unit udmAnuncios;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.JSON, Rest.Json, Datasnap.DBClient, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, MidasLib, untDenuncia;

type
  TTipoListaAnuncio = (tpMeusAnuncios, tpAnunciosGame);

type
  TDMAnuncios = class(TDataModule)
    cdsAnuncios: TClientDataSet;
    cdsAnunciosId: TIntegerField;
    cdsAnunciosGameId: TIntegerField;
    cdsAnunciosTitleGame: TStringField;
    cdsAnunciosPlataform: TStringField;
    cdsAnunciosPrice: TFloatField;
    dsAnuncios: TDataSource;
    cdsAnunciosEnable: TBooleanField;
    cdsAnunciosCreatedBy: TStringField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarAnunciosMemoria(const pTipoListaAnuncio: TTipoListaAnuncio);
    procedure CarregarMeusAnuncios( pTexto: String);
    procedure CarregarAnunciosGame( pTexto: String);
  public
    { Public declarations }

    procedure ListarAnunciosJogo(const pIdGame: String);
    procedure ListarMeusAnuncios;
    procedure CriarAnuncio(const pIdGame:String; const pValor:String);
    procedure DenunciarAnuncio(const pDenuncia: TDenuncia);

  end;

var
  DMAnuncios: TDMAnuncios;
  cdsAnuncios: TClientDataSet;
  dsAnuncios: TDatasource;
  vListaAnuncios: String;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

Uses untUtils, udmConexao, untGame,
     REST.Types, REST.JsonReflect, RESTRequest4D, System.StrUtils;

Const
  RESOURCE_LISTAR_MEUS = '/announcements/my-games';
  RESOURCE_LISTAR_APARTIR_GAME = '/announcements/game/';
  RESOURCE_CRIAR = '/announcements/game/%s/price/%s';
  RESOURCE_DENUNCIA = '/report';
  ERRO_API = 'Erro ao acessar api!%s %s';

{ TDMAnuncios }

procedure TDMAnuncios.DataModuleCreate(Sender: TObject);
begin
  cdsAnuncios.CreateDataSet;
end;

procedure TDMAnuncios.CriarAnuncio(const pIdGame:String; const pValor:String);
Var
  vResp: IResponse;
  vRecurso: String;
begin
  vRecurso := Format(RESOURCE_CRIAR, [pIdGame, pValor]);

  GerarLog('Criando anúncio apartir do Game:'+pIdGame+
           sLineBreak+
           'url:'+DMConexao.BaseUrl+vRecurso);

  vResp:= TRequest.New
            .BaseURL(DMConexao.BaseUrl)
            .Resource(vRecurso)
            .TokenBearer(DMConexao.Login.Token)
            .Accept(REST.Types.CONTENTTYPE_APPLICATION_JSON)
            .Post;
end;

procedure TDMAnuncios.ListarAnunciosJogo(const pIdGame: String);
Var
  vResp: IResponse;
  vRecurso: String;
begin
  vRecurso := RESOURCE_LISTAR_APARTIR_GAME + pIdGame;

  GerarLog('ListarAnunciosGame IdGame:'+pIdGame+
           sLineBreak+
           'url:'+DMConexao.BaseUrl+vRecurso);
  try
    vResp := TRequest.New
                .BaseURL(DMConexao.BaseUrl)
                .Resource(vRecurso)
                .TokenBearer(DMConexao.Login.Token)
                .Accept(REST.Types.CONTENTTYPE_APPLICATION_JSON)
                .Get;

    if vResp.StatusCode = 200 then
    begin
      vListaAnuncios := vResp.Content;

      if vListaAnuncios <> EmptyStr then
        carregarAnunciosMemoria(tpAnunciosGame);
    end;

  except
    on e: exception do
    begin
      GerarLog('Erro ao acessar Api '+e.ToString);
      raise Exception.CreateFmt(ERRO_API, [sLineBreak, e.ToString]);
    end;
  end;
end;

procedure TDMAnuncios.ListarMeusAnuncios;
Var
  vResp: IResponse;
begin
  GerarLog('Listar Meus Anúncios:'+
           DMConexao.BaseUrl+
           RESOURCE_LISTAR_MEUS);
  try
    vResp := TRequest.New
              .BaseURL(DMConexao.BaseUrl)
              .Resource(RESOURCE_LISTAR_MEUS)
              .TokenBearer(DMConexao.Login.Token)
              .Accept(Rest.Types.CONTENTTYPE_APPLICATION_JSON)
              .get;

    if vResp.StatusCode = 200 then
    begin
      vListaAnuncios    := vResp.Content;

      if vListaAnuncios <> EmptyStr then
        carregarAnunciosMemoria(tpMeusAnuncios);
    end;

  except
    on e:exception do
    begin
      GerarLog('Erro ao listar meus anúncios!'+sLineBreak+e.ToString);
      raise Exception.CreateFmt(ERRO_API, [sLineBreak, e.ToString]);
    end;
  end;
end;

procedure TDMAnuncios.carregarAnunciosMemoria(const pTipoListaAnuncio: TTipoListaAnuncio);
Var
  vObjetoJson,
  vSubObjJson: TJsonObject;
  vJsonValor,
  vJsonItem: TJsonValue;
  vArrayAnuncios: TJSonArray;
  vCont, i: Integer;
begin
  GerarLog('Carregar Anuncios Memoria!');
  GerarLog('json.:'+vListaAnuncios);

  case pTipoListaAnuncio of
    tpMeusAnuncios: CarregarMeusAnuncios(vListaAnuncios);
    tpAnunciosGame: CarregarAnunciosGame(vListaAnuncios);
  end;
  dsAnuncios.DataSet := cdsAnuncios;
end;

procedure TDMAnuncios.CarregarMeusAnuncios( pTexto: String);
Var
  vAnuncios,
  vAnuncioAtual: String;
  vPosicao: Integer;
  vLista: TStrings;
  vItem, vValor: String;
begin
  GerarLog('Carregar Meus Anúncios!');
  vPosicao  := 0;
  vAnuncios := pTexto;

  try
    vLista   := TStringList.Create;
    vPosicao := Pos('"}},', vAnuncios);
    cdsAnuncios.EmptyDataSet;

    while vPosicao <> 0 do
    begin
      vAnuncioAtual := Copy(vAnuncios, 0, vPosicao);
      vLista.Clear;
      ExtractStrings([':'], [], PChar(vAnuncioAtual), vLista);

      cdsAnuncios.Append;

      vItem := vLista[1];
      cdsAnunciosId.AsInteger  := StrToIntDef(Copy(vItem,
                                                   0,
                                                   Pos(',', vItem)-1),
                                                   0);
      vItem := vLista[3];
      cdsAnunciosGameId.AsInteger := StrToIntDef(Copy(vItem,
                                                      0,
                                                      Pos(',', vItem)-1),
                                                      0);
      vItem := vLista[4];
      vValor := Copy(vItem,
                     0,
                     Pos(',', vItem)-1);

      cdsAnunciosTitleGame.AsString := StringReplace(vValor, '"', '', [rfReplaceAll]);

      vItem  := vLista[5];
      vValor := Copy(vItem,
                     0,
                     Pos(',', vItem)-1);
      cdsAnunciosPlataform.AsString := StringReplace(vValor, '"', '', [rfReplaceAll]);

      vItem  := vLista[14];
      vValor := Copy(vItem,
                     0,
                     Pos(',', vItem)-1);
      cdsAnunciosCreatedBy.AsString := StringReplace(vValor, '"', '', [rfReplaceAll]);

      vItem := vLista[18];
      vValor := Copy(vItem,
                     0,
                     Pos(',', vItem)-1);

      cdsAnunciosPrice.AsString := StringReplace(vValor, '.', ',', []);

      vItem := vLista[19];
      cdsAnunciosEnable.AsBoolean := StrToBool(Copy(vItem,
                                                0,
                                                Pos(',', vItem)-1));
      cdsAnuncios.Post;

      Delete(vAnuncios, 1, vPosicao+3);
      vPosicao  := Pos('"}},', vAnuncios);
    end;
  except
    on e:exception do
    begin
      GerarLog('Erro dados em memoria '+e.ToString);
      raise Exception.Create('Erro dados em memoria '+e.ToString);
    end;
  end;
  GerarLog('Dados carregados com sucesso! '+
           'Qtd Registros:'+IntToStr(cdsAnuncios.RecordCount));
end;

procedure TDMAnuncios.CarregarAnunciosGame(pTexto: String);
Var
  vAnuncios,
  vAnuncioAtual: String;
  vPosicao: Integer;
  vLista: TStrings;
  vItem, vValor: String;
  vGame: TGame;
begin
  GerarLog('Carregar Anúncios a partir de um game!');
  vPosicao    := 0;
  try
    vAnuncios := pTexto;
    vGame     := TGame.Create();
    vLista    := TStringList.Create;

    try
      vLista.Clear;
      ExtractStrings([':'], [], PChar(vAnuncios), vLista);

      vItem    := vLista[2];
      vGame.Id := StrToIntDef(Copy(vItem,
                                   0,
                                   Pos(',', vItem)-1),
                                   0);


      vItem  := vLista[3];
      vValor := Copy(vItem,
                     0,
                     Pos(',', vItem)-1);

      vGame.Title := StringReplace(vValor, '"', '', [rfReplaceAll]);
      vItem  := vLista[4];
      vValor := Copy(vItem,
                     0,
                     Pos(',', vItem)-1);

      vGame.Plataforma := StringReplace(vValor, '"', '', [rfReplaceAll]);

      vItem  := vLista[15];
      vValor := Copy(vItem,
                     0,
                     Pos(',', vItem)-1);
      vGame.CreatedBy := StringReplace(vValor, '"', '', [rfReplaceAll]);

      vPosicao := Pos('[{', vAnuncios);
      Delete(vAnuncios, 1, vPosicao);

      cdsAnuncios.EmptyDataSet;

      vPosicao := Pos('},{', vAnuncios);
      if (vPosicao = 0)then
        vPosicao := Pos('}]}', vAnuncios);

      while vPosicao <> 0 do
      begin
        vAnuncioAtual := Copy(vAnuncios, 0, vPosicao);
        vLista.Clear;
        ExtractStrings([':'], [], PChar(vAnuncioAtual), vLista);

        cdsAnuncios.Append;

        vItem := vLista[1];
        cdsAnunciosId.AsInteger  := StrToIntDef(Copy(vItem,
                                                     0,
                                                     Pos(',', vItem)-1),
                                                     0);

        cdsAnunciosGameId.AsInteger   := vGame.Id;
        cdsAnunciosTitleGame.AsString := vGame.Title;
        cdsAnunciosPlataform.AsString := vGame.Plataforma;

        vItem  := vLista[3];
        vValor := Copy(vItem,
                       0,
                       Pos(',', vItem)-1);
        cdsAnunciosCreatedBy.AsString := StringReplace(vValor, '"', '', [rfReplaceAll]);

        vItem := vLista[7];
        vValor := Copy(vItem,
                       0,
                       Pos('}', vItem)-1);

        cdsAnunciosPrice.AsString := StringReplace(vValor, '.', ',', []);


        cdsAnuncios.Post;

        Delete(vAnuncios, 1, vPosicao);

        vPosicao  := Pos('},{', vAnuncios);
        if (vPosicao = 0)then
          vPosicao := Pos('}]}', vAnuncios);
      end;
      GerarLog('Dados carregados com sucesso! '+
               'Qtd Registros:'+IntToStr(cdsAnuncios.RecordCount));
    except
      on e:exception do
      begin
        GerarLog('Erro dados em memoria '+e.ToString);
        raise Exception.Create('Erro dados em memoria '+e.ToString);
      end;
    end;

  finally
    FreeAndNil(vGame);
  end;
end;

procedure TDMAnuncios.DenunciarAnuncio(const pDenuncia: TDenuncia);
Var
  vResp:  IResponse;
  jsBody: TJSonObject;
begin

  jsBody := TJSONObject.Create();
  try
    jsBody.AddPair('Id', pDenuncia.Id);
    jsBody.AddPair('Description', pDenuncia.Description);
    jsBody.AddPair('Type', 'game');

    vResp:= TRequest.New
          .BaseURL(DMConexao.BaseUrl)
          .Resource(RESOURCE_DENUNCIA)
          .TokenBearer(DMConexao.Login.Token)
          .Accept(REST.Types.CONTENTTYPE_APPLICATION_JSON)
          .AddBody(jsBody)
          .Post;

     if vResp.StatusCode = 200 then
        GerarLog('Denúncia criada com sucesso!');
  finally
    FreeAndNil(jsBody);
  end;


end;

end.

//*********************************************************************************************************************************************************************************************/
//*********************************************************************************************************************************************************************************************/

-- Meus Anuncios
[
	{
		"id":1,
		"game":{
					"id":1,
					"title":"God of War IV",
					"platform":"Playstation 4",
					"metadata":{
						"createdBy":"pedrokra@gmail.com",
						"createdAt":"2021-07-07T11:22:52.690+00:00",
						"updatedBy":null,
						"updateAt":null,
						"textCreatedAt":"07/07/2021 08:22:52"},
						"image":"http://localhost:8080/images/games/1.png"
				},
		"owner":{
			"name":"Pedro",
			"phone":"+55 (34) 9 1234-1111",
			"email":"user1@gmail.com",
			"image":null},
			"price":300.0,
			"enabled":true,
			"priceMasked":"R$ 300,00",
			"metadata":{
						"createdBy":"user1@gmail.com",
						"createdAt":"2021-07-07T11:22:52.690+00:00",
						"updatedBy":null,
						"updateAt":null,
						"textCreatedAt":"07/07/2021 08:22:52"
						}
	}
]

//*********************************************************************************************************************************************************************************************
//*********************************************************************************************************************************************************************************************
-- Anuncios a partir de um jogo

{
	"game":{
				"id":1,
				"title":"God of War IV",
				"platform":"Playstation 4",
				"metadata":{
								"createdBy":"pedrokra@gmail.com",
								"createdAt":"2021-07-07T11:22:52.690+00:00",
								"updatedBy":null,
								"updateAt":null,
								"textCreatedAt":"07/07/2021 08:22:52"},
								"image":"http://localhost:8080/images/games/1.png"
			},
	"announcements":[
						{
							"id":1,
							"owner":{
										"name":"Pedro",
										"phone":"+55 (34) 9 1234-1111",
										"email":"user1@gmail.com",
										"image":null},
										"price":300.0
						},
						{
							"id":6,
							"owner":{
										"name":"Luatane",
										"phone":"+55 (61) 9 1234-2222",
										"email":"user2@gmail.com",
										"image":null},
										"price":456.0
						}
					]
}
