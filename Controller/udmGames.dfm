object DMGames: TDMGames
  OldCreateOrder = False
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
    Left = 71
    Top = 14
    object mtGamesId: TIntegerField
      FieldName = 'Id'
    end
    object mtGamesTitle: TStringField
      FieldName = 'Title'
    end
    object mtGamesPlataforma: TStringField
      DisplayLabel = 'Plataforma'
      FieldName = 'Plataform'
    end
    object mtGamesImage: TStringField
      DisplayLabel = 'Imagem'
      FieldName = 'Image'
    end
  end
  object dsGames: TDataSource
    DataSet = mtGames
    Left = 39
    Top = 78
  end
end
