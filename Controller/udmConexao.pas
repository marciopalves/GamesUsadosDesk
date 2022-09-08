unit udmConexao;

interface

uses
  System.SysUtils, System.Classes, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IPPeerClient, REST.Client,
  Data.Bind.Components, Data.Bind.ObjectScope, REST.Types,
  REST.Authenticator.OAuth, untLogin;

type
  TDMConexao = class(TDataModule)
    IdHTTP: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    RESTClient: TRESTClient;
    RESTRequest: TRESTRequest;
    RESTResponse: TRESTResponse;
    OAuth2Authenticator: TOAuth2Authenticator;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    FLogin: TLogin;
    { Private declarations }
  public
    { Public declarations }
    procedure InicializaRequest(const pUrl: String = '');
    procedure ResetParametrosRequest;
    property Login: TLogin read FLogin Write FLogin;
  end;

Const
  CHARSET_PADRAO = 'utf-8';
  CONTENT_TYPE_PADRAO = 'application/json';
  BASE_URL = 'http://localhost:8080';
  MSG_URL_BASE = 'A url base não foi preenchida!';

var
  DMConexao: TDMConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}


{$R *.dfm}

procedure TDMConexao.DataModuleCreate(Sender: TObject);
begin
  Login := TLogin.Create;

  idHttp.Request.Clear;
  idHttp.Request.ContentType:= 'application/json';
  idhttp.Request.Charset    := 'UTF-8';
  IdHttp.IOHandler          := IdSSLIOHandlerSocketOpenSSL;
  idHttp.Request.BasicAuthentication := False;
  //
  InicializaRequest();
end;

procedure TDMConexao.InicializaRequest(const pUrl: String = '');
begin
  RESTRequest.Client    := RestClient;
  RESTRequest.Response  := RESTResponse;
  ResetParametrosRequest;

  if pUrl <> '' then
    RESTClient.BaseURL := pUrl;
end;

procedure TDMConexao.ResetParametrosRequest;
begin
  RestRequest.Params.Clear;
//  RestRequest.Body.ClearBody;
//  RestClient.Params.Clear;
end;

procedure TDMConexao.DataModuleDestroy(Sender: TObject);
begin
  Login.Free;
end;

end.
