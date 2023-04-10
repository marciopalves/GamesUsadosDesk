object DMAnuncios: TDMAnuncios
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 148
  Width = 146
  object cdsAnuncios: TClientDataSet
    Active = True
    Aggregates = <>
    Params = <>
    ProviderName = 'dspAnuncios'
    Left = 64
    Top = 24
    object cdsAnunciosId: TIntegerField
      FieldName = 'Id'
    end
    object cdsAnunciosGameId: TIntegerField
      FieldName = 'GameId'
    end
    object cdsAnunciosTituloGame: TStringField
      FieldName = 'TituloGame'
    end
    object cdsAnunciosPrice: TFloatField
      FieldName = 'Price'
    end
  end
  object dsAnuncios: TDataSource
    DataSet = cdsAnuncios
    Left = 64
    Top = 96
  end
end
