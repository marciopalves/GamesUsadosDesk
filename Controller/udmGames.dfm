object DMGames: TDMGames
  OldCreateOrder = False
  Height = 201
  Width = 317
  object RESTClient: TRESTClient
    BaseURL = 'http://localhost:8080/games?page=0'
    ContentType = 'application/json'
    Params = <>
    Left = 136
    Top = 64
  end
  object RESTRequest: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Params = <>
    Response = RESTResponse
    Left = 56
    Top = 64
  end
  object RESTResponse: TRESTResponse
    Left = 216
    Top = 64
  end
  object RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter
    FieldDefs = <>
    ResponseJSON = RESTResponse
    Left = 72
    Top = 137
  end
  object FDMemTable1: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 200
    Top = 128
  end
end
