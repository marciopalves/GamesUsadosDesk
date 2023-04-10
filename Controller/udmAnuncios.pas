unit udmAnuncios;

interface

uses
  System.SysUtils, System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  System.JSON, Rest.Json, Datasnap.DBClient, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, MidasLib;

type
  TTipoListaAnuncio = (tpMeusAnuncios, tpAnunciosGame);

type
  TDMAnuncios = class(TDataModule)
    cdsAnuncios: TClientDataSet;
    dsAnuncios: TDataSource;
    cdsAnunciosId: TIntegerField;
    cdsAnunciosGameId: TIntegerField;
    cdsAnunciosTituloGame: TStringField;
    cdsAnunciosPrice: TFloatField;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarAnunciosMemoria(const pTipoListaAnuncio: TTipoListaAnuncio);
    procedure CarregarMeusAnuncios(const pTexto: String);
  public
    { Public declarations }

    procedure ListarAnunciosJogo(const pIdGame: String);
    procedure ListarMeusAnuncios;
    procedure CriarAnuncio(const pIdGame:String; const pValor:String);

  end;

var
  DMAnuncios: TDMAnuncios;
  vListaAnuncios: String;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

Uses untUtils, udmConexao,
     REST.Types, REST.JsonReflect, RESTRequest4D;

Const
  RESOURCE_LISTAR_MEUS = '/announcements/my-games';
  RESOURCE_LISTAR_APARTIR_GAME = '/announcements/game/&s';
  RESOURCE_CRIAR = '/announcements/game/%s/price/%s';
  ERRO_API = 'Erro ao acessar api!%s %s';

{ TDMAnuncios }

procedure TDMAnuncios.DataModuleCreate(Sender: TObject);
begin
//  cdsAnuncios.CreateDataSet;
//  cdsAnuncios.Active := True;
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
  vRecurso := Format(RESOURCE_LISTAR_APARTIR_GAME, [pIdGame]);

  GerarLog('ListarAnunciosJogo apartir do Game:'+pIdGame+
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

    tpMeusAnuncios:
    begin
      CarregarMeusAnuncios(vListaAnuncios);
    end;

    tpAnunciosGame:
    begin
      //
      //
    end;

  end;
end;

procedure TDMAnuncios.CarregarMeusAnuncios(const pTexto: String);
Var
  vAnuncios,
  vAnuncioAtual: String;
  vPosicao: Integer;
  vLista: TStrings;
  vItem: String;
begin
  GerarLog('Carregar Meus Anúncios!');
  vAnuncios := pTexto;

  try
    vLista := TStringList.Create;
    vPosicao  := Pos('"}},', vAnuncios);
    //cdsAnuncios.EmptyDataSet;
    while vPosicao <> 0 do
    begin
      vPosicao  := Pos('"}},', vAnuncios);
      vAnuncioAtual := Copy(vAnuncios, 0, vPosicao);

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
      cdsAnunciosTituloGame.AsString := Copy(vItem,
                                             0,
                                             Pos(',', vItem)-1);

      vItem := vLista[4];
      cdsAnunciosPrice.AsFloat := StrToFloatDef(Copy(vItem,
                                                      0,
                                                      Pos(',', vItem)-1),
                                                0);

      Delete(vAnuncios, 0, vPosicao);
      vPosicao  := Pos('"}},', vAnuncios);
    end;

  except
    on e:exception do
    begin
      GerarLog('Erro dados em memoria '+e.ToString);
      raise Exception.Create('Erro dados em memoria '+e.ToString);
    end;
  end;

  GerarLog(vAnuncioAtual);
end;

end.


--- Anuncios MyGames  Primeiro o id do anuncio depois game
[
    {
        "id": 1,
        "game": {
            "id": 1,
            "title": "God of War IV",
            "platform": "Playstation 4",
            "metadata": {
                "createdBy": "pedrokra@gmail.com",
                "createdAt": "2021-07-07T11:22:52.690+00:00",
                "updatedBy": null,
                "updateAt": null,
                "textCreatedAt": "07/07/2021 08:22:52"
            },
            "image": "http://localhost:8080/images/games/1.png"
        },
        "owner": {
            "name": "Pedro",
            "phone": "+55 (34) 9 1234-1111",
            "email": "user1@gmail.com",
            "image": null
        },
        "price": 300.0,
        "enabled": true,
        "priceMasked": "R$ 300,00",
        "metadata": {
            "createdBy": "user1@gmail.com",
            "createdAt": "2021-07-07T11:22:52.690+00:00",
            "updatedBy": null,
            "updateAt": null,
            "textCreatedAt": "07/07/2021 08:22:52"
        }
    },
    {
        "id": 2,
        "game": {
            "id": 2,
            "title": "Horizon Zero Dawn: Forbidden West",
            "platform": "Playstation 5",
            "metadata": {
                "createdBy": "pedrokra@gmail.com",
                "createdAt": "2021-07-07T11:22:52.690+00:00",
                "updatedBy": null,
                "updateAt": null,
                "textCreatedAt": "07/07/2021 08:22:52"
            },
            "image": "http://localhost:8080/images/games/2.png"
        },
        "owner": {
            "name": "Pedro",
            "phone": "+55 (34) 9 1234-1111",
            "email": "user1@gmail.com",
            "image": null
        },
        "price": 500.0,
        "enabled": true,
        "priceMasked": "R$ 500,00",
        "metadata": {
            "createdBy": "user1@gmail.com",
            "createdAt": "2021-07-07T11:22:52.690+00:00",
            "updatedBy": null,
            "updateAt": null,
            "textCreatedAt": "07/07/2021 08:22:52"
        }
    },
    {
        "id": 4,
        "game": {
            "id": 1,
            "title": "God of War IV",
            "platform": "Playstation 4",
            "metadata": {
                "createdBy": "pedrokra@gmail.com",
                "createdAt": "2021-07-07T11:22:52.690+00:00",
                "updatedBy": null,
                "updateAt": null,
                "textCreatedAt": "07/07/2021 08:22:52"
            },
            "image": "http://localhost:8080/images/games/1.png"
        },
        "owner": {
            "name": "Pedro",
            "phone": "+55 (34) 9 1234-1111",
            "email": "user1@gmail.com",
            "image": null
        },
        "price": 123.0,
        "enabled": false,
        "priceMasked": "R$ 123,00",
        "metadata": {
            "createdBy": "user1@gmail.com",
            "createdAt": "2023-01-13T11:22:52.690+00:00",
            "updatedBy": null,
            "updateAt": null,
            "textCreatedAt": "13/01/2023 08:22:52"
        }
    }
]

--#########################################################
-- de um jogo especifico

[
    {
        "id": 1,
        "game": {
            "id": 1,
            "title": "God of War IV",
            "platform": "Playstation 4",
            "metadata": {
                "createdBy": "pedrokra@gmail.com",
                "createdAt": "2021-07-07T11:22:52.690+00:00",
                "updatedBy": null,
                "updateAt": null,
                "textCreatedAt": "07/07/2021 08:22:52"
            },
            "image": "http://localhost:8080/images/games/1.png"
        },
        "owner": {
            "name": "Pedro",
            "phone": "+55 (34) 9 1234-1111",
            "email": "user1@gmail.com",
            "image": null
        },
        "price": 300.0,
        "enabled": true,
        "priceMasked": "R$ 300,00",
        "metadata": {
            "createdBy": "user1@gmail.com",
            "createdAt": "2021-07-07T11:22:52.690+00:00",
            "updatedBy": null,
            "updateAt": null,
            "textCreatedAt": "07/07/2021 08:22:52"
        }
    },
    {
        "id": 2,
        "game": {
            "id": 2,
            "title": "Horizon Zero Dawn: Forbidden West",
            "platform": "Playstation 5",
            "metadata": {
                "createdBy": "pedrokra@gmail.com",
                "createdAt": "2021-07-07T11:22:52.690+00:00",
                "updatedBy": null,
                "updateAt": null,
                "textCreatedAt": "07/07/2021 08:22:52"
            },
            "image": "http://localhost:8080/images/games/2.png"
        },
        "owner": {
            "name": "Pedro",
            "phone": "+55 (34) 9 1234-1111",
            "email": "user1@gmail.com",
            "image": null
        },
        "price": 500.0,
        "enabled": true,
        "priceMasked": "R$ 500,00",
        "metadata": {
            "createdBy": "user1@gmail.com",
            "createdAt": "2021-07-07T11:22:52.690+00:00",
            "updatedBy": null,
            "updateAt": null,
            "textCreatedAt": "07/07/2021 08:22:52"
        }
    },
    {
        "id": 4,
        "game": {
            "id": 1,
            "title": "God of War IV",
            "platform": "Playstation 4",
            "metadata": {
                "createdBy": "pedrokra@gmail.com",
                "createdAt": "2021-07-07T11:22:52.690+00:00",
                "updatedBy": null,
                "updateAt": null,
                "textCreatedAt": "07/07/2021 08:22:52"
            },
            "image": "http://localhost:8080/images/games/1.png"
        },
        "owner": {
            "name": "Pedro",
            "phone": "+55 (34) 9 1234-1111",
            "email": "user1@gmail.com",
            "image": null
        },
        "price": 123.0,
        "enabled": false,
        "priceMasked": "R$ 123,00",
        "metadata": {
            "createdBy": "user1@gmail.com",
            "createdAt": "2023-01-13T11:22:52.690+00:00",
            "updatedBy": null,
            "updateAt": null,
            "textCreatedAt": "13/01/2023 08:22:52"
        }
    }
]
