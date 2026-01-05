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
        Title.Caption = 'Empfange'
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BW_ERROR'
        Title.Caption = 'Ung'#252'ltig'
        Width = 75
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
    ExplicitTop = 459
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
    object BitBtn1: TBitBtn
      Left = 248
      Top = 32
      Width = 105
      Height = 25
      Action = ac_request
      Caption = 'Beantragt'
      Images = ResMod.PngImageList1
      TabOrder = 2
    end
    object BitBtn2: TBitBtn
      Left = 400
      Top = 32
      Width = 105
      Height = 25
      Action = ac_send
      Caption = 'Versendet'
      Images = ResMod.PngImageList1
      TabOrder = 3
    end
    object BitBtn3: TBitBtn
      Left = 552
      Top = 32
      Width = 97
      Height = 25
      Action = ac_received
      Caption = 'Empfangen'
      Images = ResMod.PngImageList1
      TabOrder = 4
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
    Left = 184
    Top = 144
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
        DataType = ftTimeStamp
      end
      item
        Name = 'BW_VERSENDET'
        Attributes = [faReadonly]
        DataType = ftTimeStamp
      end
      item
        Name = 'BW_EMPFANGEN'
        Attributes = [faReadonly]
        DataType = ftTimeStamp
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
    UpdateOptions.AssignedValues = [uvCheckRequired, uvCheckReadOnly, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    StoreDefs = True
    Left = 432
    Top = 200
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
    object BriefTabBW_ANTRAG: TSQLTimeStampField
      FieldName = 'BW_ANTRAG'
      OnGetText = BriefTabBW_ANTRAGGetText
    end
    object BriefTabBW_VERSENDET: TSQLTimeStampField
      FieldName = 'BW_VERSENDET'
      OnGetText = BriefTabBW_ANTRAGGetText
    end
    object BriefTabBW_EMPFANGEN: TSQLTimeStampField
      FieldName = 'BW_EMPFANGEN'
      OnGetText = BriefTabBW_ANTRAGGetText
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
    Left = 312
    Top = 56
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
  object ActionList1: TActionList
    Images = ResMod.PngImageList1
    Left = 408
    Top = 304
    object ac_request: TAction
      Caption = 'Beantragt'
      ImageIndex = 10
      OnExecute = ac_requestExecute
    end
    object ac_send: TAction
      Caption = 'Versendet'
      ImageIndex = 11
      OnExecute = ac_sendExecute
    end
    object ac_received: TAction
      Caption = 'Empfangen'
      ImageIndex = 12
      OnExecute = ac_receivedExecute
    end
  end
end
