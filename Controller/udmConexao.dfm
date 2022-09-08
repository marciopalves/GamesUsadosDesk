object DMConexao: TDMConexao
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 280
  Width = 347
  object IdHTTP: TIdHTTP
    HandleRedirects = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 18
    Top = 78
  end
  object IdSSLIOHandlerSocketOpenSSL: TIdSSLIOHandlerSocketOpenSSL
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 18
    Top = 24
  end
  object RESTClient: TRESTClient
    Authenticator = OAuth2Authenticator
    BaseURL = 'http://localhost:8080/users/register/manager'
    Params = <>
    ReadTimeout = 60000
    Left = 208
    Top = 144
  end
  object RESTRequest: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Method = rmPOST
    Params = <
      item
        Kind = pkREQUESTBODY
        Name = 'bodyD330A569C8F8409A9326A2137167312C'
        Value = '{"email":"admin@admin.com", "password":"123456"}'
        ContentType = ctAPPLICATION_JSON
      end>
    Response = RESTResponse
    ReadTimeout = 60000
    Left = 208
    Top = 80
  end
  object RESTResponse: TRESTResponse
    Left = 208
    Top = 208
  end
  object OAuth2Authenticator: TOAuth2Authenticator
    Left = 208
    Top = 16
  end
end
