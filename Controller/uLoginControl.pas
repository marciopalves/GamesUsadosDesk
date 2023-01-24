unit uLoginControl;

interface

Uses untLogin, uILogin;

Type TLoginControl = class(TInterfacedObject, ILogin)
  private
    function LoginPost(const pEmail, pPassword: String): TLogin;
  public
    function Logar(const pEmail: String; const pPassword: String): TLogin;
    procedure Deslogar;

end;

implementation

Uses untUser, udmConexao, untUtils,
     System.SysUtils, System.Classes,
     Rest.Json, REST.JsonReflect;

CONST
  RESOURCE = '/auth';

{ TLoginControl }

procedure TLoginControl.Deslogar;
begin
//
end;

function TLoginControl.Logar(const pEmail, pPassword: String): TLogin;
begin
  try
    if (Length(pPassword)> 0) And (ValidarEmail(pEmail)) then
    begin
      result := LoginPost(pEmail, pPassword);
    end
    else
    begin
      raise Exception.Create('Erro ao tentar logar no sistema!'+
                             sLineBreak+
                             'Verifique o email e a senha e tente novamente!');
    end;

  except
    on e:exception do
    begin
      raise Exception.Create('Erro ao tentar logar no sistema! '+sLineBreak+e.ToString);
    end;
  end;
end;

function TLoginControl.LoginPost(const pEmail, pPassword: String): TLogin;
Var
  JsonStreamRetorno,
  JsonStreamEnvio: TStringStream;
  vMarshal: TJSONMarshal;
  vTextoJson: String;
  vUser: TUser;
  vUrl: String;
begin
  try
    vUser          := TUser.Create();
    vUser.Email    := pEmail;
    vUser.Password := pPassword;

    vMarshal   := TJSONMarshal.Create (TJSONConverter.Create);
    vTextoJson := vMarshal.Marshal(vUser).ToString();

    JsonStreamEnvio   := TStringStream.Create(vTextoJson);
    JsonStreamRetorno := TStringStream.Create('');

    vUrl := (DMConexao.BaseUrl + RESOURCE);
    if (vUrl <> EmptyStr) then
    begin
      try
        DMConexao.IdHTTP.Post(vUrl, JsonStreamEnvio, JsonStreamRetorno);

        if (DMConexao.IdHTTP.ResponseCode = 200) then
          Result := TJson.JsonToObject<TLogin>(UTF8ToString(PAnsiChar(AnsiString(JsonStreamRetorno.DataString))));

        except on E:exception do
          raise Exception.Create('Erro acessar API '+e.ToString);
        end;
    end;

  finally
    vUser.Free;
    vMarshal.Free;
    JsonStreamEnvio.Free;
    JsonStreamRetorno.Free;
  end;
end;

end.
