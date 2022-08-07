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

Uses System.SysUtils, System.Classes, Rest.Json,
     REST.JsonReflect, untPrincipal, untUser, udmConexao, untUtils;

CONST
  URL = 'http://localhost:8080/users/register/manager';

{ TManagerControl }

function TManagerControl.Criar(const pManager: TManager): Boolean;
Var
  JsonStreamRetorno, JsonStreamEnvio: TStringStream;
  vMarshal: TJSONMarshal;
  vTextoJson: String;
begin
  try
    DMConexao.IdHTTP.Request.BasicAuthentication := True;
    DMConexao.IdHTTP.Request.CustomHeaders.Add('Authorization=Bearer '+frmPrincipal.vLogin.Token);

    GerarLog('Criando Gerente Definindo Token'+DMConexao.IdHTTP.Request.CustomHeaders.Text);

    vMarshal   := TJSONMarshal.Create (TJSONConverter.Create);
    vTextoJson := vMarshal.Marshal(pManager).ToString();

    JsonStreamEnvio   := TStringStream.Create(vTextoJson);
    JsonStreamRetorno := TStringStream.Create('');
    try
      GerarLog('Criando Gerente '+DMConexao.IdHTTP.Request.CustomHeaders.Text+
                sLineBreak+'URL.:'+URL+' Json'+vTextoJson);

      DMConexao.IdHTTP.Post(URL, JsonStreamEnvio, JsonStreamRetorno);
      Result := DMConexao.IdHTTP.ResponseCode = 200;

    except on E:exception do
      begin
        GerarLog('Erro ao criar Gerente - '+e.ToString+
                  sLineBreak+'URL.:'+URL+' - '+vTextoJson);
        raise Exception.Create('Erro acessar API '+e.ToString);
      end;
    end;

  finally
    vMarshal.Free;
    JsonStreamEnvio.Free;
    JsonStreamRetorno.Free;
  end;
end;

end.
