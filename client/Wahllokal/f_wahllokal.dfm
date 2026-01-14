object WahlForm: TWahlForm
  Left = 0
  Top = 0
  Caption = 'Wahllokal'
  ClientHeight = 641
  ClientWidth = 1337
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object StatusBar1: TStatusBar
    Left = 0
    Top = 622
    Width = 1337
    Height = 19
    Panels = <>
    SimplePanel = True
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 1337
    Height = 517
    Align = alClient
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
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
        Title.Caption = 'abteilung'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MA_GEB'
        Title.Caption = 'GebDat'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WL_BAU'
        Title.Caption = 'Geb'#228'ude'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WL_STOCKWERK'
        Title.Caption = 'Stockwerk'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WL_RAUM'
        Title.Caption = 'Raum'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WL_TIMESTAMP'
        Title.Caption = 'Gew'#228'hlt um'
        Visible = True
      end>
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 517
    Width = 1337
    Height = 105
    Align = alBottom
    Caption = 'Aktionen'
    TabOrder = 2
    object BitBtn1: TBitBtn
      Left = 24
      Top = 40
      Width = 217
      Height = 25
      Caption = 'Wahlunterlagen aush'#228'ndigen'
      ImageIndex = 9
      Images = ResMod.PngImageList1
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 280
      Top = 40
      Width = 177
      Height = 25
      Caption = 'Schriftf'#252'hrer wechseln'
      ImageIndex = 3
      Images = ResMod.PngImageList1
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TWahlLokalMod'
    SQLConnection = GM.SQLConnection1
    Left = 56
    Top = 48
  end
  object MaListQry: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'MaListrQry'
    RemoteServer = DSProviderConnection1
    Left = 184
    Top = 48
    object MaListQryMA_ID: TIntegerField
      FieldName = 'MA_ID'
    end
    object MaListQryMA_PERSNR: TStringField
      FieldName = 'MA_PERSNR'
      Size = 10
    end
    object MaListQryMA_NAME: TStringField
      FieldName = 'MA_NAME'
      Size = 100
    end
    object MaListQryMA_VORNAME: TStringField
      FieldName = 'MA_VORNAME'
      Size = 100
    end
    object MaListQryMA_GENDER: TStringField
      FieldName = 'MA_GENDER'
      FixedChar = True
      Size = 1
    end
    object MaListQryMA_ABTEILUNG: TStringField
      FieldName = 'MA_ABTEILUNG'
      Size = 100
    end
    object MaListQryMA_GEB: TDateField
      FieldName = 'MA_GEB'
    end
    object MaListQryWL_BAU: TStringField
      FieldName = 'WL_BAU'
      Size = 100
    end
    object MaListQryWL_STOCKWERK: TStringField
      FieldName = 'WL_STOCKWERK'
      Size = 10
    end
    object MaListQryWL_RAUM: TStringField
      FieldName = 'WL_RAUM'
      Size = 10
    end
    object MaListQryWL_TIMESTAMP: TSQLTimeStampField
      FieldName = 'WL_TIMESTAMP'
    end
  end
  object FDBatchMove1: TFDBatchMove
    Reader = FDBatchMoveDataSetReader1
    Writer = FDBatchMoveDataSetWriter1
    Mappings = <>
    LogFileName = 'Data.log'
    Left = 168
    Top = 184
  end
  object FDBatchMoveDataSetReader1: TFDBatchMoveDataSetReader
    DataSet = MaListQry
    Left = 176
    Top = 120
  end
  object FDBatchMoveDataSetWriter1: TFDBatchMoveDataSetWriter
    DataSet = MAList
    Left = 168
    Top = 248
  end
  object MAList: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'MA_ID'
        DataType = ftInteger
      end
      item
        Name = 'MA_PERSNR'
        DataType = ftString
        Size = 10
      end
      item
        Name = 'MA_NAME'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'MA_VORNAME'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'MA_GENDER'
        DataType = ftString
        Size = 1
      end
      item
        Name = 'MA_ABTEILUNG'
        DataType = ftString
        Size = 100
      end
      item
        Name = 'MA_GEB'
        DataType = ftDate
      end
      item
        Name = 'WL_BAU'
        Attributes = [faReadonly]
        DataType = ftString
        Size = 100
      end
      item
        Name = 'WL_STOCKWERK'
        Attributes = [faReadonly]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'WL_RAUM'
        Attributes = [faReadonly]
        DataType = ftString
        Size = 10
      end
      item
        Name = 'WL_TIMESTAMP'
        Attributes = [faReadonly]
        DataType = ftTimeStamp
      end>
    IndexDefs = <>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvEDelete, uvEInsert, uvEUpdate, uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 160
    Top = 312
  end
  object DataSource1: TDataSource
    DataSet = MAList
    Left = 248
    Top = 312
  end
  object FDStanStorageXMLLink1: TFDStanStorageXMLLink
    Left = 664
    Top = 328
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'WAUpdateQry'
    RemoteServer = DSProviderConnection1
    Left = 440
    Top = 56
  end
end
