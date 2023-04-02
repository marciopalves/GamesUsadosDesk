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
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object pnlGrid: TPanel
    Left = 0
    Top = 0
    Width = 603
    Height = 358
    TabOrder = 0
    object dbgGames: TDBGrid
      Left = 1
      Top = 1
      Width = 601
      Height = 356
      Align = alClient
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
          Width = 43
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Title'
          Width = 119
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Plataforma'
          Width = 124
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Image'
          Width = 185
          Visible = True
        end>
    end
  end
  object pnlBotoes: TPanel
    Left = 496
    Top = 0
    Width = 107
    Height = 358
    Align = alRight
    TabOrder = 1
    object btnPesqGames: TButton
      Left = 14
      Top = 112
      Width = 75
      Height = 25
      Hint = 'Pesquisar Games na API'
      Caption = 'Atualizar'
      TabOrder = 0
      OnClick = btnPesqGamesClick
    end
  end
end
