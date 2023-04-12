object frmCadAnuncios: TfrmCadAnuncios
  Left = 0
  Top = 0
  Caption = 'Cadastro de An'#250'ncios'
  ClientHeight = 201
  ClientWidth = 447
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
  object lblValor: TLabel
    Left = 15
    Top = 56
    Width = 27
    Height = 13
    Caption = 'Valor '
  end
  object pnlFiltros: TPanel
    Left = 0
    Top = 0
    Width = 447
    Height = 49
    Align = alTop
    BevelInner = bvLowered
    TabOrder = 0
    object Label1: TLabel
      Left = 15
      Top = 6
      Width = 93
      Height = 13
      Caption = 'Buscar Game <F2>'
    end
    object edtFiltro: TEdit
      Left = 11
      Top = 19
      Width = 104
      Height = 21
      Hint = 'Insira o c'#243'digo do game para filrar'
      TabOrder = 0
    end
    object btnPesquisa: TButton
      Left = 339
      Top = 15
      Width = 92
      Height = 25
      Hint = 'Pesquisar an'#250'ncios'
      Caption = 'Pesquisar'
      TabOrder = 1
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 160
    Width = 447
    Height = 41
    Align = alBottom
    TabOrder = 1
    object bbConfirmar: TBitBtn
      Left = 91
      Top = 8
      Width = 75
      Height = 26
      Caption = 'Confirmar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ModalResult = 1
      ParentFont = False
      TabOrder = 0
      OnClick = bbConfirmarClick
    end
    object bbCancelar: TBitBtn
      Left = 216
      Top = 8
      Width = 75
      Height = 26
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ModalResult = 2
      ParentFont = False
      TabOrder = 1
    end
  end
  object edtValor: TEdit
    Left = 11
    Top = 72
    Width = 121
    Height = 21
    TabOrder = 2
  end
end
