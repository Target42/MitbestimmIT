object AuswertungBriefForm: TAuswertungBriefForm
  Left = 0
  Top = 0
  Caption = 'Auswertung der Briefwahl'
  ClientHeight = 640
  ClientWidth = 1087
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 1087
    Height = 370
    Align = alClient
    Caption = #220'bersicht'
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 2
      Top = 17
      Width = 1083
      Height = 351
      Align = alClient
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      ReadOnly = True
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
      Columns = <
        item
          Expanded = False
          FieldName = 'MA_PERSNR'
          Title.Caption = 'PersNr'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MA_NAME'
          Title.Caption = 'Name'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MA_VORNAME'
          Title.Caption = 'Vorname'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MA_GENDER'
          Title.Caption = 'Geschlecht'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MA_ABTEILUNG'
          Title.Caption = 'Abteilung'
          Width = 150
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MA_GEB'
          Title.Caption = 'Geboren'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BW_ERROR'
          Title.Caption = 'Status'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BW_ANTRAG'
          Title.Caption = 'Beantragt'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BW_VERSENDET'
          Title.Caption = 'Versendet'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'BW_EMPFANGEN'
          Title.Caption = 'Empfangen'
          Width = 100
          Visible = True
        end>
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 621
    Width = 1087
    Height = 19
    Panels = <>
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 370
    Width = 1087
    Height = 190
    Align = alBottom
    Caption = 'Aktionen'
    Enabled = False
    TabOrder = 2
    object Splitter1: TSplitter
      Left = 138
      Top = 17
      Height = 171
      ExplicitLeft = 144
    end
    object Splitter2: TSplitter
      Left = 604
      Top = 17
      Height = 171
      ExplicitLeft = 640
      ExplicitTop = 32
      ExplicitHeight = 100
    end
    object RadioGroup1: TRadioGroup
      Left = 141
      Top = 17
      Width = 463
      Height = 171
      Align = alLeft
      Caption = 'Begr'#252'ndung'
      Columns = 2
      Items.Strings = (
        'Alles OK'
        'Stimmzettel fehlt'
        'Stimmzettel nicht im Umschlag'
        'Stimmzettelumschlaf offen'
        'Mehre Stimmzettelumschl'#228'ge'
        'Wahlschein fehlt'
        'Wahlschein nicht unterschrieben'
        'Wahlschein manipuliert'
        'Anderer Grund')
      TabOrder = 0
    end
    object RadioGroup2: TRadioGroup
      Left = 2
      Top = 17
      Width = 136
      Height = 171
      Align = alLeft
      Caption = 'Status'
      Items.Strings = (
        'G'#252'ltig'
        'Ung'#252'ltig'
        'Unvollst'#228'ndig'
        'Dopeltw'#228'hler')
      TabOrder = 1
      OnClick = RadioGroup2Click
    end
    object GroupBox3: TGroupBox
      Left = 607
      Top = 17
      Width = 478
      Height = 171
      Align = alClient
      Caption = 'Anmerkungen'
      TabOrder = 2
      object Memo1: TMemo
        Left = 2
        Top = 17
        Width = 474
        Height = 152
        Align = alClient
        Lines.Strings = (
          'Memo1')
        TabOrder = 0
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 560
    Width = 1087
    Height = 61
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 3
    ExplicitTop = 562
    object BitBtn1: TBitBtn
      Left = 32
      Top = 30
      Width = 75
      Height = 25
      Caption = 'Bearbeiten'
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 832
      Top = 30
      Width = 75
      Height = 25
      Caption = 'Abbrechen'
      Enabled = False
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 992
      Top = 30
      Width = 75
      Height = 25
      Caption = 'Speichern'
      Enabled = False
      TabOrder = 2
      OnClick = BitBtn3Click
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TAuswertungsmod'
    SQLConnection = GM.SQLConnection1
    Left = 96
    Top = 88
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'BriefdatenQry'
    RemoteServer = DSProviderConnection1
    Left = 216
    Top = 96
    object ClientDataSet1BW_ID: TIntegerField
      FieldName = 'BW_ID'
      Origin = 'BW_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ClientDataSet1MA_ID: TIntegerField
      FieldName = 'MA_ID'
      Origin = 'MA_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ClientDataSet1BW_ANTRAG: TSQLTimeStampField
      FieldName = 'BW_ANTRAG'
      Origin = 'BW_ANTRAG'
    end
    object ClientDataSet1BW_VERSENDET: TSQLTimeStampField
      FieldName = 'BW_VERSENDET'
      Origin = 'BW_VERSENDET'
    end
    object ClientDataSet1BW_EMPFANGEN: TSQLTimeStampField
      FieldName = 'BW_EMPFANGEN'
      Origin = 'BW_EMPFANGEN'
    end
    object ClientDataSet1BW_ERROR: TStringField
      FieldName = 'BW_ERROR'
      Origin = 'BW_ERROR'
      FixedChar = True
      Size = 1
    end
    object ClientDataSet1BW_CHG: TSQLTimeStampField
      FieldName = 'BW_CHG'
      Origin = 'BW_CHG'
    end
    object ClientDataSet1MA_PERSNR: TStringField
      FieldName = 'MA_PERSNR'
      Origin = 'MA_PERSNR'
      ProviderFlags = []
      Size = 10
    end
    object ClientDataSet1MA_NAME: TStringField
      FieldName = 'MA_NAME'
      Origin = 'MA_NAME'
      ProviderFlags = []
      Size = 100
    end
    object ClientDataSet1MA_VORNAME: TStringField
      FieldName = 'MA_VORNAME'
      Origin = 'MA_VORNAME'
      ProviderFlags = []
      Size = 100
    end
    object ClientDataSet1MA_ABTEILUNG: TStringField
      FieldName = 'MA_ABTEILUNG'
      Origin = 'MA_ABTEILUNG'
      ProviderFlags = []
      Size = 100
    end
    object ClientDataSet1MA_GENDER: TStringField
      FieldName = 'MA_GENDER'
      Origin = 'MA_GENDER'
      ProviderFlags = []
      FixedChar = True
      Size = 1
    end
    object ClientDataSet1MA_GEB: TDateField
      FieldName = 'MA_GEB'
      Origin = 'MA_GEB'
      ProviderFlags = []
    end
  end
  object DataSource1: TDataSource
    DataSet = BriefTab
    Left = 696
    Top = 136
  end
  object BriefTab: TFDMemTable
    AfterScroll = BriefTabAfterScroll
    FieldDefs = <>
    IndexDefs = <
      item
        Name = 'PRIMARY_KEY'
        Fields = 'BW_ID;MA_ID'
        Options = [ixPrimary, ixUnique]
      end>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 616
    Top = 137
    object BriefTabBW_ID: TIntegerField
      DisplayWidth = 10
      FieldName = 'BW_ID'
      Required = True
    end
    object BriefTabMA_ID: TIntegerField
      DisplayWidth = 10
      FieldName = 'MA_ID'
      Required = True
    end
    object BriefTabBW_ANTRAG: TSQLTimeStampField
      DisplayWidth = 34
      FieldName = 'BW_ANTRAG'
      DisplayFormat = 'dd.MM.yyyy hh:mm'
    end
    object BriefTabBW_VERSENDET: TSQLTimeStampField
      DisplayWidth = 34
      FieldName = 'BW_VERSENDET'
      DisplayFormat = 'dd.MM.yyyy hh:mm'
    end
    object BriefTabBW_EMPFANGEN: TSQLTimeStampField
      DisplayWidth = 34
      FieldName = 'BW_EMPFANGEN'
      DisplayFormat = 'dd.MM.yyyy hh:mm'
    end
    object BriefTabBW_ERROR: TStringField
      DisplayWidth = 27
      FieldName = 'BW_ERROR'
      OnGetText = BriefTabBW_ERRORGetText
      Size = 1
    end
    object BriefTabBW_CHG: TSQLTimeStampField
      DisplayWidth = 34
      FieldName = 'BW_CHG'
    end
    object BriefTabMA_PERSNR: TStringField
      DisplayWidth = 10
      FieldName = 'MA_PERSNR'
      Size = 10
    end
    object BriefTabMA_NAME: TStringField
      DisplayWidth = 100
      FieldName = 'MA_NAME'
      Size = 100
    end
    object BriefTabMA_VORNAME: TStringField
      DisplayWidth = 100
      FieldName = 'MA_VORNAME'
      Size = 100
    end
    object BriefTabMA_ABTEILUNG: TStringField
      DisplayWidth = 100
      FieldName = 'MA_ABTEILUNG'
      Size = 100
    end
    object BriefTabMA_GENDER: TStringField
      DisplayWidth = 10
      FieldName = 'MA_GENDER'
      OnGetText = BriefTabMA_GENDERGetText
      Size = 1
    end
    object BriefTabMA_GEB: TDateField
      DisplayWidth = 10
      FieldName = 'MA_GEB'
    end
  end
  object FDBatchMove1: TFDBatchMove
    Reader = FDBatchMoveDataSetReader1
    Writer = FDBatchMoveDataSetWriter1
    Mappings = <>
    LogFileName = 'Data.log'
    Left = 376
    Top = 144
  end
  object FDBatchMoveDataSetReader1: TFDBatchMoveDataSetReader
    DataSet = ClientDataSet1
    Left = 224
    Top = 216
  end
  object FDBatchMoveDataSetWriter1: TFDBatchMoveDataSetWriter
    DataSet = BriefTab
    Left = 504
    Top = 219
  end
end
