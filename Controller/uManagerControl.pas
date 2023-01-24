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

Uses untUser, udmConexao, untUtils, untParametros,
     System.SysUtils, System.Classes, REST.Types,
     REST.JsonReflect,
     RESTRequest4D;

CONST
  RESOURCE = '/users/register/manager';

{ TManagerControl }

function TManagerControl.Criar(const pManager: TManager): Boolean;
Var
  vResp: IResponse;
begin
  if (DMConexao.Login.Token <> EmptyStr) And
     (DMConexao.BaseUrl <> EmptyStr) And
     (pManager <> Nil) then
  begin
    try
      vResp := TRequest.New
                .BaseURL(DMConexao.BaseUrl)
                .Resource(RESOURCE)
                .TokenBearer(DMConexao.Login.Token)
                .Accept(REST.Types.CONTENTTYPE_APPLICATION_JSON)
                .AddBody(pManager)
                //.RaiseExceptionOn500(True)
                .Post;

      result := vResp.StatusCode = 200;

    except on E:exception do
      begin
        Result := False;
        GerarLog('Erro ao acessar endpoint criar Gerente - '+e.ToString+
                  sLineBreak+'URL.:'+DMConexao.BaseUrl+RESOURCE);
        raise Exception.Create('Erro acessar API '+e.ToString);
      end;
    end;

  end
  else
  begin
    GerarLog('Informações insuficientes para acessar API.'+
             ' - BaseUrl.:'+DMConexao.BaseUrl+ sLineBreak+
             ' - Token.:'+DMConexao.Login.Token+ sLineBreak+
             ' - JSON.:'+pManager.ToString);
    raise Exception.Create('Erro informações insuficientes para acessar API.');
  end;

end;

end.
