object frmLogin: TfrmLogin
  Left = 0
  Top = 0
  Caption = 'Games Usados'
  ClientHeight = 217
  ClientWidth = 285
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 285
    Height = 217
    Align = alClient
    AutoSize = True
    Color = clSilver
    ParentBackground = False
    TabOrder = 0
    object lblEmail: TLabel
      Left = 106
      Top = 15
      Width = 50
      Height = 19
      Caption = 'Email '
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblSenha: TLabel
      Left = 106
      Top = 95
      Width = 50
      Height = 19
      Caption = 'Senha'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtEmail: TEdit
      Left = 48
      Top = 40
      Width = 193
      Height = 21
      TabOrder = 0
    end
    object edtPassword: TEdit
      Left = 48
      Top = 120
      Width = 193
      Height = 21
      PasswordChar = '*'
      TabOrder = 1
    end
    object bbConfirmar: TBitBtn
      Left = 16
      Top = 168
      Width = 97
      Height = 33
      Caption = 'Logar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ModalResult = 1
      ParentFont = False
      TabOrder = 2
      OnClick = bbConfirmarClick
    end
    object bbCancelar: TBitBtn
      Left = 153
      Top = 168
      Width = 97
      Height = 33
      Caption = 'Cancelar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ModalResult = 2
      ParentFont = False
      TabOrder = 3
    end
  end
  object ActionList: TActionList
    Left = 248
    Top = 80
    object actAdmin: TAction
      Category = 'Logar'
      Caption = 'actAdmin'
      ShortCut = 32880
      OnExecute = actAdminExecute
    end
    object actClear: TAction
      Caption = 'actClear'
      ShortCut = 27
      OnExecute = actClearExecute
    end
    object actGerente: TAction
      Category = 'Logar'
      Caption = 'actGerente'
      ShortCut = 32881
      OnExecute = actGerenteExecute
    end
    object actUser: TAction
      Category = 'Logar'
      Caption = 'actUser'
      ShortCut = 32882
      OnExecute = actUserExecute
    end
  end
end
