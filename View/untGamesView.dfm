object frmGamesView: TfrmGamesView
  Left = 0
  Top = 0
  Caption = 'Games'
  ClientHeight = 301
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
    Width = 472
    Height = 301
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 513
    object strgGames: TStringGrid
      Left = 1
      Top = 1
      Width = 470
      Height = 299
      Align = alClient
      TabOrder = 0
      ExplicitTop = 0
    end
  end
  object pnlBotoes: TPanel
    Left = 472
    Top = 0
    Width = 131
    Height = 301
    Align = alRight
    TabOrder = 1
    object brnPesqGames: TButton
      Left = 30
      Top = 64
      Width = 75
      Height = 25
      Hint = 'Pesquisar Games na API'
      Caption = 'Pesquisar '
      TabOrder = 0
      OnClick = brnPesqGamesClick
    end
    object mmTeste: TMemo
      Left = 5
      Top = 152
      Width = 185
      Height = 89
      TabOrder = 1
    end
  end
end
