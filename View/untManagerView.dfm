object frmManager: TfrmManager
  Left = 0
  Top = 0
  Caption = 'Cadastro de Gerentes'
  ClientHeight = 226
  ClientWidth = 525
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnlEdits: TPanel
    Left = 0
    Top = 0
    Width = 525
    Height = 185
    Align = alClient
    TabOrder = 0
    object lblNome: TLabel
      Left = 32
      Top = 23
      Width = 39
      Height = 16
      Caption = 'Nome '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object Label1: TLabel
      Left = 32
      Top = 80
      Width = 59
      Height = 16
      Caption = 'Telefone '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblEmail: TLabel
      Left = 32
      Top = 127
      Width = 32
      Height = 16
      Caption = 'Email'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSenha: TLabel
      Left = 376
      Top = 127
      Width = 40
      Height = 16
      Caption = 'Senha'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblTipo: TLabel
      Left = 197
      Top = 80
      Width = 26
      Height = 16
      Caption = 'Tipo'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtNome: TEdit
      Left = 32
      Top = 45
      Width = 309
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
    end
    object edtMaskTel: TMaskEdit
      Left = 32
      Top = 95
      Width = 127
      Height = 22
      EditMask = '(99) 99999-9999'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      MaxLength = 15
      ParentFont = False
      TabOrder = 1
      Text = '(  )      -    '
    end
    object edtEmail: TEdit
      Left = 32
      Top = 142
      Width = 309
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 3
    end
    object edtPassword: TEdit
      Left = 376
      Top = 142
      Width = 129
      Height = 22
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      PasswordChar = '*'
      TabOrder = 4
    end
    object cbbUserType: TComboBox
      Left = 196
      Top = 95
      Width = 145
      Height = 22
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ItemIndex = 0
      ParentFont = False
      TabOrder = 2
      Text = 'Manager'
      Items.Strings = (
        'Manager')
    end
  end
  object pnlBotoes: TPanel
    Left = 0
    Top = 185
    Width = 525
    Height = 41
    Align = alBottom
    TabOrder = 1
    object bbConfirmar: TBitBtn
      Left = 251
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
      Left = 376
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
end
