object BriefwahlForm: TBriefwahlForm
  Left = 0
  Top = 0
  Caption = 'Briefwahl'
  ClientHeight = 589
  ClientWidth = 832
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object StatusBar1: TStatusBar
    Left = 0
    Top = 570
    Width = 832
    Height = 19
    Panels = <>
    ExplicitTop = 422
    ExplicitWidth = 624
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 832
    Height = 465
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
        Width = 80
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MA_ABTEILUNG'
        Title.Caption = 'Abteilung'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BW_ANTRAG'
        Title.Caption = 'Antrag'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BW_VERSENDET'
        Title.Caption = 'Versendet'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BW_EMPFANGEN'
        Title.Caption = 'Empfange'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BW_ERROR'
        Title.Caption = 'Ung'#252'ltig'
        Visible = True
      end>
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 465
    Width = 832
    Height = 105
    Align = alBottom
    Caption = 'Aktionen'
    TabOrder = 2
    ExplicitTop = 508
    ExplicitWidth = 1188
    object LabeledEdit1: TLabeledEdit
      Left = 16
      Top = 40
      Width = 73
      Height = 23
      EditLabel.Width = 35
      EditLabel.Height = 15
      EditLabel.Caption = 'PersNr'
      TabOrder = 0
      Text = ''
      OnKeyPress = LabeledEdit1KeyPress
    end
    object LabeledEdit2: TLabeledEdit
      Left = 104
      Top = 40
      Width = 121
      Height = 23
      EditLabel.Width = 32
      EditLabel.Height = 15
      EditLabel.Caption = 'Name'
      TabOrder = 1
      Text = ''
      OnKeyPress = LabeledEdit2KeyPress
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TBriefWahlMod'
    SQLConnection = GM.SQLConnection1
    Left = 88
    Top = 56
  end
  object MaTable: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'MaListQry'
    RemoteServer = DSProviderConnection1
    Left = 216
    Top = 56
  end
  object BriefTab: TFDMemTable
    Active = True
    FieldDefs = <
      item
        Name = 'MA_ID'
        Attributes = [faRequired]
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
        Name = 'MA_MAIL'
        DataType = ftString
        Size = 255
      end
      item
        Name = 'MA_GEB'
        DataType = ftDate
      end
      item
        Name = 'BW_ID'
        Attributes = [faReadonly]
        DataType = ftInteger
      end
      item
        Name = 'BW_ANTRAG'
        Attributes = [faReadonly]
        DataType = ftDate
      end
      item
        Name = 'BW_VERSENDET'
        Attributes = [faReadonly]
        DataType = ftDate
      end
      item
        Name = 'BW_EMPFANGEN'
        Attributes = [faReadonly]
        DataType = ftDate
      end
      item
        Name = 'BW_ERROR'
        Attributes = [faReadonly]
        DataType = ftString
        Size = 1
      end>
    IndexDefs = <
      item
        Name = 'PRIMARY_KEY'
        Fields = 'MA_ID'
        Options = [ixPrimary, ixUnique]
      end>
    Indexes = <
      item
        Active = True
        Name = 'PRIMARY_KEY'
        Fields = 'MA_ID'
        Options = [soUnique, soPrimary]
      end>
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 24
    Top = 136
    object BriefTabMA_ID: TIntegerField
      FieldName = 'MA_ID'
      Required = True
    end
    object BriefTabMA_PERSNR: TStringField
      FieldName = 'MA_PERSNR'
      Size = 10
    end
    object BriefTabMA_NAME: TStringField
      FieldName = 'MA_NAME'
      Size = 100
    end
    object BriefTabMA_VORNAME: TStringField
      FieldName = 'MA_VORNAME'
      Size = 100
    end
    object BriefTabMA_GENDER: TStringField
      FieldName = 'MA_GENDER'
      OnGetText = BriefTabMA_GENDERGetText
      Size = 1
    end
    object BriefTabMA_ABTEILUNG: TStringField
      FieldName = 'MA_ABTEILUNG'
      Size = 100
    end
    object BriefTabMA_MAIL: TStringField
      FieldName = 'MA_MAIL'
      Size = 255
    end
    object BriefTabMA_GEB: TDateField
      FieldName = 'MA_GEB'
    end
    object BriefTabBW_ID: TIntegerField
      FieldName = 'BW_ID'
      ReadOnly = True
    end
    object BriefTabBW_ANTRAG: TDateField
      FieldName = 'BW_ANTRAG'
      ReadOnly = True
    end
    object BriefTabBW_VERSENDET: TDateField
      FieldName = 'BW_VERSENDET'
      ReadOnly = True
    end
    object BriefTabBW_EMPFANGEN: TDateField
      FieldName = 'BW_EMPFANGEN'
      ReadOnly = True
    end
    object BriefTabBW_ERROR: TStringField
      FieldName = 'BW_ERROR'
      ReadOnly = True
      Size = 1
    end
  end
  object FDBatchMove1: TFDBatchMove
    Reader = FDBatchMoveDataSetReader1
    Writer = FDBatchMoveDataSetWriter1
    Mappings = <>
    LogFileName = 'Data.log'
    Left = 176
    Top = 136
  end
  object FDBatchMoveDataSetReader1: TFDBatchMoveDataSetReader
    DataSet = MaTable
    Left = 312
    Top = 136
  end
  object FDBatchMoveDataSetWriter1: TFDBatchMoveDataSetWriter
    DataSet = BriefTab
    Left = 312
    Top = 200
  end
  object DataSource1: TDataSource
    DataSet = BriefTab
    Left = 96
    Top = 248
  end
end
