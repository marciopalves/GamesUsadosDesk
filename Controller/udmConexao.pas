unit udmConexao;

interface

uses
  System.SysUtils, System.Classes, IdIOHandler, IdIOHandlerSocket,
  IdIOHandlerStack, IdSSL, IdSSLOpenSSL, IdBaseComponent, IdComponent,
  IdTCPConnection, IdTCPClient, IdHTTP;

type
  TDMConexao = class(TDataModule)
    IdHTTP: TIdHTTP;
    IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DMConexao: TDMConexao;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDMConexao.DataModuleCreate(Sender: TObject);
begin
  idHttp.Request.Clear;
  idHttp.Request.ContentType:= 'application/json';
  idhttp.Request.Charset    := 'UTF-8';
  IdHttp.IOHandler          := IdSSLIOHandlerSocketOpenSSL;
  idHttp.Request.BasicAuthentication := False;
end;

end.
