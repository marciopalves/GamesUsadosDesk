object frmParametros: TfrmParametros
  Left = 0
  Top = 0
  Caption = 'Par'#226'metros'
  ClientHeight = 181
  ClientWidth = 459
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
  object Label1: TLabel
    Left = 16
    Top = 48
    Width = 43
    Height = 13
    Caption = 'BaseUrl'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object edtBaseUrl: TEdit
    Left = 62
    Top = 40
    Width = 249
    Height = 21
    TabOrder = 0
  end
  object bSalvar: TBitBtn
    Left = 317
    Top = 38
    Width = 75
    Height = 25
    Hint = 'Salvar configura'#231#227'o'
    Caption = 'Salvar'
    TabOrder = 1
    OnClick = bSalvarClick
  end
end
