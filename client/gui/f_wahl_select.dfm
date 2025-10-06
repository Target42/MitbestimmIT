object WahlSelectForm: TWahlSelectForm
  Left = 0
  Top = 0
  Caption = 'Wahl ausw'#228'hlen'
  ClientHeight = 305
  ClientWidth = 648
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
    Top = 245
    Width = 648
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 381
    ExplicitWidth = 624
    inherited StatusBar1: TStatusBar
      Width = 648
      ExplicitWidth = 647
    end
    inherited Panel1: TPanel
      Width = 648
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 624
      inherited OKBtn: TBitBtn
        Left = 544
        ExplicitLeft = 520
      end
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 648
    Height = 245
    Align = alClient
    DataSource = DataSource1
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
        Width = 64
        Visible = True
      end>
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'WahlListQry'
    RemoteServer = DSProviderConnection1
    Left = 168
    Top = 96
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
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TWahlMod'
    Connected = True
    SQLConnection = GM.SQLConnection1
    Left = 64
    Top = 24
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 264
    Top = 112
  end
end
