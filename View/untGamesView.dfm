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
    Width = 496
    Height = 301
    Align = alClient
    TabOrder = 0
    ExplicitWidth = 472
    object DBGrid1: TDBGrid
      Left = 1
      Top = 1
      Width = 494
      Height = 299
      Align = alClient
      DataSource = DataSource
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'Tahoma'
      TitleFont.Style = []
      Columns = <
        item
          Expanded = False
          FieldName = 'id'
          Title.Caption = 'Codigo'
          Width = 49
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'title'
          Title.Caption = 'Titulo'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'platform'
          Title.Caption = 'Plataforma'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'image'
          Title.Caption = 'Imagem'
          Visible = True
        end>
    end
  end
  object pnlBotoes: TPanel
    Left = 496
    Top = 0
    Width = 107
    Height = 301
    Align = alRight
    TabOrder = 1
    object btnPesqGames: TButton
      Left = 22
      Top = 96
      Width = 75
      Height = 25
      Hint = 'Pesquisar Games na API'
      Caption = 'Pesquisar '
      TabOrder = 0
      OnClick = btnPesqGamesClick
    end
  end
  object RESTClient: TRESTClient
    Accept = 'application/json, text/plain; q=0.9, text/html;q=0.8,'
    AcceptCharset = 'utf-8, *;q=0.8'
    BaseURL = 'http://localhost:8080/games?page=0'
    Params = <>
    ReadTimeout = 90000
    Left = 272
    Top = 24
  end
  object RESTRequest: TRESTRequest
    AssignedValues = [rvConnectTimeout, rvReadTimeout]
    Client = RESTClient
    Params = <>
    Response = RESTResponse
    Left = 376
    Top = 40
  end
  object RESTResponse: TRESTResponse
    ContentType = 'application/json'
    RootElement = 'content[0]'
    Left = 376
    Top = 96
  end
  object RESTResponseDataSetAdapter: TRESTResponseDataSetAdapter
    Active = True
    Dataset = FDMemTable
    FieldDefs = <>
    Response = RESTResponse
    TypesMode = Rich
    Left = 384
    Top = 160
  end
  object FDMemTable: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'id'
        DataType = ftFloat
      end
      item
        Name = 'title'
        DataType = ftWideString
        Size = 33
      end
      item
        Name = 'platform'
        DataType = ftWideString
        Size = 13
      end
      item
        Name = 'image'
        DataType = ftWideString
        Size = 40
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvUpdateChngFields, uvUpdateMode, uvLockMode, uvLockPoint, uvLockWait, uvRefreshMode, uvFetchGeneratorsPoint, uvCheckRequired, uvCheckReadOnly, uvCheckUpdatable]
    UpdateOptions.LockWait = True
    UpdateOptions.FetchGeneratorsPoint = gpNone
    UpdateOptions.CheckRequired = False
    StoreDefs = True
    Left = 384
    Top = 224
    object FDMemTableid: TFloatField
      DisplayWidth = 4
      FieldName = 'id'
    end
    object FDMemTabletitle: TWideStringField
      DisplayWidth = 33
      FieldName = 'title'
      Size = 33
    end
    object FDMemTableplatform: TWideStringField
      DisplayWidth = 13
      FieldName = 'platform'
      Size = 13
    end
    object FDMemTableimage: TWideStringField
      DisplayWidth = 40
      FieldName = 'image'
      Size = 40
    end
  end
  object BindSourceDB1: TBindSourceDB
    DataSet = FDMemTable
    ScopeMappings = <>
    Left = 296
    Top = 160
  end
  object BindingsList1: TBindingsList
    Methods = <>
    OutputConverters = <>
    Left = 300
    Top = 221
    object LinkFillControlToField1: TLinkFillControlToField
      Category = 'Quick Bindings'
      Track = True
      FillDataSource = BindSourceDB1
      AutoFill = True
      FillExpressions = <
        item
          SourceMemberName = 'id'
          ControlMemberName = 'SubItems[0]'
        end
        item
          SourceMemberName = 'title'
          ControlMemberName = 'SubItems[1]'
        end
        item
          SourceMemberName = 'platform'
          ControlMemberName = 'SubItems[2]'
        end>
      FillHeaderExpressions = <>
      FillBreakGroups = <>
    end
  end
  object DataSource: TDataSource
    DataSet = FDMemTable
    Left = 176
    Top = 248
  end
end
