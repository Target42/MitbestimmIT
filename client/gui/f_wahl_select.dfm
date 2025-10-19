object WahlSelectForm: TWahlSelectForm
  Left = 0
  Top = 0
  Caption = 'Wahl ausw'#228'hlen'
  ClientHeight = 161
  ClientWidth = 598
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
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 101
    Width = 598
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 101
    ExplicitWidth = 598
    inherited StatusBar1: TStatusBar
      Width = 598
      ExplicitWidth = 598
    end
    inherited Panel1: TPanel
      Width = 598
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 598
      inherited OKBtn: TBitBtn
        Left = 494
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 494
      end
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 598
    Height = 101
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
        FieldName = 'WA_TITLE'
        Title.Caption = 'Titel'
        Width = 300
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WA_SIMU'
        Title.Caption = 'Simulation'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WA_ACTIVE'
        Title.Caption = 'Aktiv'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WA_TYP'
        Title.Caption = 'Verfahren'
        Width = 100
        Visible = True
      end>
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'WahlListQry'
    RemoteServer = DSProviderConnection1
    Left = 176
    Top = 8
    object ClientDataSet1WA_ID: TIntegerField
      FieldName = 'WA_ID'
      Required = True
    end
    object ClientDataSet1WA_TITLE: TStringField
      FieldName = 'WA_TITLE'
      Size = 150
    end
    object ClientDataSet1WA_SIMU: TStringField
      FieldName = 'WA_SIMU'
      OnGetText = ClientDataSet1WA_SIMUGetText
      FixedChar = True
      Size = 1
    end
    object ClientDataSet1WA_ACTIVE: TStringField
      FieldName = 'WA_ACTIVE'
      OnGetText = ClientDataSet1WA_SIMUGetText
      FixedChar = True
      Size = 1
    end
    object ClientDataSet1WA_TYP: TIntegerField
      FieldName = 'WA_TYP'
      OnGetText = ClientDataSet1WA_TYPGetText
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TWahlMod'
    SQLConnection = GM.SQLConnection1
    Left = 64
    Top = 24
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 256
    Top = 16
  end
end
