object DMGames: TDMGames
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 133
  Width = 173
  object mtGames: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 32
    Top = 16
  end
  object dsGames: TDataSource
    DataSet = mtGames
    Left = 32
    Top = 72
  end
  object cdsGamesMemoria: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 109
    Top = 17
    object cdsGamesMemoriaId: TIntegerField
      FieldName = 'Id'
    end
    object cdsGamesMemoriaTitle: TStringField
      DisplayWidth = 80
      FieldName = 'Title'
      Size = 80
    end
    object cdsGamesMemoriaPlataforma: TStringField
      DisplayWidth = 60
      FieldName = 'Plataforma'
      Size = 60
    end
    object cdsGamesMemoriaImage: TStringField
      DisplayWidth = 120
      FieldName = 'Image'
      Size = 120
    end
  end
  object dsGamesMemoria: TDataSource
    DataSet = cdsGamesMemoria
    Left = 109
    Top = 69
  end
end
