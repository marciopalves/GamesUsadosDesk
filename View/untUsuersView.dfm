object frmUsers: TfrmUsers
  Left = 0
  Top = 0
  Caption = 'Usu'#225'rios do Sistema'
  ClientHeight = 338
  ClientWidth = 573
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlBotoes: TPanel
    Left = 466
    Top = 0
    Width = 107
    Height = 338
    Align = alRight
    TabOrder = 0
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
  object pnlGrid: TPanel
    Left = 0
    Top = 0
    Width = 474
    Height = 338
    Align = alLeft
    TabOrder = 1
    object dbgUsers: TDBGrid
      Left = 1
      Top = 1
      Width = 472
      Height = 336
      Align = alClient
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
    end
  end
end
