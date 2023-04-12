object DMAnuncios: TDMAnuncios
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Height = 148
  Width = 146
  object cdsAnuncios: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 48
    Top = 40
    object cdsAnunciosId: TIntegerField
      DisplayLabel = 'C'#243'digo An'#250'ncio'
      FieldName = 'Id'
    end
    object cdsAnunciosGameId: TIntegerField
      DisplayLabel = 'C'#243'digo do Jogo'
      FieldName = 'GameId'
    end
    object cdsAnunciosTitleGame: TStringField
      DisplayLabel = 'T'#237'tulo'
      FieldName = 'TitleGame'
      Size = 80
    end
    object cdsAnunciosPlataform: TStringField
      DisplayLabel = 'Plataforma'
      FieldName = 'Plataform'
      Size = 80
    end
    object cdsAnunciosCreatedBy: TStringField
      DisplayLabel = 'Criador'
      FieldName = 'CreatedBy'
      Size = 80
    end
    object cdsAnunciosPrice: TFloatField
      DisplayLabel = 'Pre'#231'o'
      FieldName = 'Price'
    end
    object cdsAnunciosEnable: TBooleanField
      DisplayLabel = 'Ativo'
      FieldName = 'Enable'
    end
  end
  object dsAnuncios: TDataSource
    DataSet = cdsAnuncios
    Left = 48
    Top = 104
  end
end
