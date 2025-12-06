object SelectWahlLokalForm: TSelectWahlLokalForm
  Left = 0
  Top = 0
  Caption = 'Auswahl Wahllokal'
  ClientHeight = 195
  ClientWidth = 833
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 833
    Height = 135
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
    Columns = <
      item
        Expanded = False
        FieldName = 'WL_BAU'
        Title.Caption = 'Geb'#228'ude'
        Width = 150
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
        FieldName = 'WL_START'
        Title.Caption = 'Start'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WL_ENDE'
        Title.Caption = 'Ende'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WH_ROLLE'
        Title.Caption = 'Rolle'
        Visible = True
      end>
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 135
    Width = 833
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 1
    ExplicitTop = 135
    ExplicitWidth = 833
    inherited StatusBar1: TStatusBar
      Width = 833
      ExplicitWidth = 833
    end
    inherited Panel1: TPanel
      Width = 833
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 833
      inherited OKBtn: TBitBtn
        Left = 729
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 729
      end
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TWahlLokalMod'
    SQLConnection = GM.SQLConnection1
    Left = 104
    Top = 112
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'WahllokaleQry'
    RemoteServer = DSProviderConnection1
    Left = 232
    Top = 120
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 320
    Top = 128
  end
end
