object frmPlataformas: TfrmPlataformas
  Left = 0
  Top = 0
  Caption = 'Plataformas'
  ClientHeight = 358
  ClientWidth = 549
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
    Width = 369
    Height = 356
    TabOrder = 0
    object dbgPlataformas: TDBGrid
      Left = 1
      Top = 1
      Width = 367
      Height = 329
      Align = alClient
      DataSource = DMGames.dsGames
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
          Width = 81
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'Title'
          Width = 200
          Visible = True
        end>
    end
    object btnPesquisarPlataformas: TButton
      Left = 1
      Top = 330
      Width = 367
      Height = 25
      Hint = 'Pesquisar Plataformas'
      Align = alBottom
      Caption = 'Atualizar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 1
      OnClick = btnPesquisarPlataformasClick
    end
  end
  object pnlBotoes: TPanel
    Left = 368
    Top = 0
    Width = 181
    Height = 358
    Align = alRight
    BevelInner = bvLowered
    TabOrder = 1
    object gbCadPlataforma: TGroupBox
      Left = 2
      Top = 2
      Width = 177
      Height = 354
      Align = alClient
      Caption = '         Cadastrar plataforma            '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      object edtPlataforma: TEdit
        Left = 16
        Top = 48
        Width = 145
        Height = 21
        TabOrder = 0
      end
      object btnCadastrarPlataforma: TButton
        Left = 16
        Top = 120
        Width = 145
        Height = 25
        Caption = 'Cadastrar'
        TabOrder = 1
        OnClick = btnCadastrarPlataformaClick
      end
    end
  end
end
