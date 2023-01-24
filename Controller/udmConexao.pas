unit udmConexao;

interface

uses
  System.SysUtils, System.Classes, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP, IPPeerClient,
  Data.Bind.Components, Data.Bind.ObjectScope,
  System.IniFiles, Vcl.Forms, untLogin;

type
  TDMConexao = class(TDataModule)
    IdHTTP: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
    procedure CarregarParametros;
  private
    FLogin: TLogin;
    FBaseUrl: String;
    Config: TIniFile;
    { Private declarations }
  public
    { Public declarations }
    property Login: TLogin read FLogin Write FLogin;
    Property BaseUrl: String Read FBaseUrl Write FBaseUrl;
  end;

Const
  CHARSET_PADRAO = 'utf-8';
  CONTENT_TYPE_PADRAO = 'application/json';
  MSG_URL_BASE = 'A url base não foi preenchida!';

var
  DMConexao: TDMConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses untUtils;

{$R *.dfm}

procedure TDMConexao.CarregarParametros;
begin
  Config := TIniFile.Create(ExtractFilePath(Application.ExeName)+'Config.ini');
  GerarLog('Carregar parametros ...');
  BaseUrl := Config.ReadString('PARAMETROS', 'BASEURL', '');
  GerarLog('BaseUrl .:'+BaseUrl);
end;

procedure TDMConexao.DataModuleCreate(Sender: TObject);
begin
  Login := TLogin.Create;

  idHttp.Request.Clear;
  idHttp.Request.ContentType:= 'application/json';
  idhttp.Request.Charset    := 'UTF-8';
  IdHttp.IOHandler          := IdSSLIOHandlerSocketOpenSSL;
  idHttp.Request.BasicAuthentication := False;

  CarregarParametros;
end;

procedure TDMConexao.DataModuleDestroy(Sender: TObject);
begin
  Login.Free;
end;

end.
