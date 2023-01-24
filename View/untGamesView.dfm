object frmGamesView: TfrmGamesView
  Left = 0
  Top = 0
  Caption = 'Games'
  ClientHeight = 358
  ClientWidth = 603
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlGrid: TPanel
    Left = 0
    Top = 0
    Width = 603
    Height = 243
    TabOrder = 0
    object dbgGames: TDBGrid
      Left = 1
      Top = 1
      Width = 601
      Height = 241
      Align = alClient
      DataSource = dsGames
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'Id'
          Width = 34
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Title'
          Width = 152
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Plataform'
          Width = 159
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Image'
          Width = 131
          Visible = True
        end>
    end
  end
  object mmGames: TMemo
    Left = 0
    Top = 248
    Width = 603
    Height = 110
    Align = alBottom
    ParentShowHint = False
    ShowHint = False
    TabOrder = 2
  end
  object pnlBotoes: TPanel
    Left = 496
    Top = 0
    Width = 107
    Height = 248
    Align = alRight
    TabOrder = 1
    ExplicitHeight = 242
    object btnPesqGames: TButton
      Left = 14
      Top = 40
      Width = 75
      Height = 25
      Hint = 'Pesquisar Games na API'
      Caption = 'Buscar API'
      TabOrder = 0
      OnClick = btnPesqGamesClick
    end
  end
  object FDMemGames: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 520
    Top = 96
    object FDMemGamesId: TIntegerField
      FieldName = 'Id'
    end
    object FDMemGamesTitle: TStringField
      FieldName = 'Title'
    end
    object FDMemGamesPlataforma: TStringField
      DisplayLabel = 'Plataforma'
      FieldName = 'Plataform'
    end
    object FDMemGamesImage: TStringField
      DisplayLabel = 'Imagem'
      FieldName = 'Image'
    end
  end
  object dsGames: TDataSource
    DataSet = FDMemGames
    Left = 520
    Top = 160
  end
end
