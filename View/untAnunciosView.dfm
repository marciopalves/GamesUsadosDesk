object frmAnuncios: TfrmAnuncios
  Left = 0
  Top = 0
  Caption = 'Listagem de An'#250'ncios'
  ClientHeight = 285
  ClientWidth = 565
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlFiltros: TPanel
    Left = 0
    Top = 0
    Width = 565
    Height = 49
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 11
      Top = 6
      Width = 93
      Height = 13
      Caption = 'Buscar Game <F2>'
    end
    object edtFiltro: TEdit
      Left = 8
      Top = 21
      Width = 92
      Height = 21
      Hint = 'Insira o c'#243'digo do game para filrar'
      TabOrder = 0
    end
    object btnPesquisa: TButton
      Left = 456
      Top = 17
      Width = 92
      Height = 25
      Hint = 'Pesquisar an'#250'ncios'
      Caption = 'Pesquisar'
      TabOrder = 1
      OnClick = btnPesquisaClick
    end
  end
  object dbgAnuncios: TDBGrid
    Left = 0
    Top = 49
    Width = 565
    Height = 236
    Hint = 'Pesquisar an'#250'ncios'
    Align = alClient
    DataSource = DMAnuncios.dsAnuncios
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'Id'
        Width = 84
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GameId'
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TitleGame'
        Width = 126
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Plataform'
        Width = 83
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CreatedBy'
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Price'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'Enable'
        Visible = True
      end>
  end
  object actAnuncios: TActionList
    Left = 480
    Top = 112
    object actBuscarGames: TAction
      Caption = 'actBuscarGames'
      ShortCut = 113
      OnExecute = actBuscarGamesExecute
    end
  end
end
