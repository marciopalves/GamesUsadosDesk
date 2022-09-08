unit uManagerControl;

interface

Uses uIManager, untManager;

Type
  TManagerControl = class(TInterfacedObject, IManager)
  private

  public
    function Criar(const pManager: TManager): Boolean;

end;

implementation

Uses System.SysUtils, System.Classes, System.JSON, Rest.Json, REST.JsonReflect,
     Rest.Types, untUser, udmConexao, untUtils, REST.Authenticator.OAuth;

CONST
  URL = 'http://localhost:8080/users/register/manager';

{ TManagerControl }

function TManagerControl.Criar(const pManager: TManager): Boolean;
Var
  JsonStreamEnvio: TStringStream;
  JsonEnvio: TJsonObject;
  JsonValue: TJSonValue;
  vMarshal: TJSONMarshal;
  vTextoJson: String;
begin
  try
    vMarshal   := TJSONMarshal.Create (TJSONConverter.Create);
//    vTextoJson := vMarshal.Marshal(pManager).ToString();
//    JsonStreamEnvio   := TStringStream.Create(vTextoJson);

    JsonEnvio := TJSONObject.Create;
    JsonEnvio.AddPair('Name',     pManager.Name);
    JsonEnvio.AddPair('Phone',    pManager.Phone);
    JsonEnvio.AddPair('Email',    pManager.Email);
    JsonEnvio.AddPair('Password', pManager.Password);

    DMConexao.InicializaRequest(URL);
    DMConexao.OAuth2Authenticator.TokenType   := TOAuth2TokenType.ttBEARER;
    DMConexao.OAuth2Authenticator.AccessToken := DMConexao.Login.Token;

    DMConexao.RestRequest.Method := rmPOST;
    //DMConexao.RestRequest.AddBody(JsonStreamEnvio);
    DMConexao.RestRequest.AddBody(JsonEnvio);
    try
      DMConexao.RESTRequest.Execute;

      Result := DMConexao.RESTResponse.StatusCode = 200;

    except on E:exception do
      begin
        Result := False;
        GerarLog('Erro ao acessar endpoint criar Gerente - '+e.ToString+
                  sLineBreak+'URL.:'+URL+' - '+vTextoJson);
        raise Exception.Create('Erro acessar API '+e.ToString);
      end;
    end;

  finally
    vMarshal.Free;
    JsonStreamEnvio.Free;
  end;
end;

end.
