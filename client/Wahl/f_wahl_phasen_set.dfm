object WahlPhasenSEtForm: TWahlPhasenSEtForm
  Left = 0
  Top = 0
  Caption = 'Wahlphasen activieren/deactivieren'
  ClientHeight = 335
  ClientWidth = 365
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
    Top = 316
    Width = 365
    Height = 19
    Panels = <>
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 365
    Height = 243
    Align = alClient
    DataSource = DataSource1
    Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    Columns = <
      item
        Expanded = False
        FieldName = 'WP_ID'
        Title.Caption = 'Nr'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WP_TITLE'
        Title.Caption = 'Titel'
        Width = 200
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WP_ACTIVE'
        Title.Caption = 'Aktiv'
        Width = 60
        Visible = True
      end>
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 243
    Width = 365
    Height = 73
    Align = alBottom
    Caption = 'Aktionen'
    TabOrder = 2
    DesignSize = (
      365
      73)
    object BitBtn1: TBitBtn
      Left = 24
      Top = 24
      Width = 97
      Height = 25
      Caption = 'Aktivieren'
      ImageIndex = 6
      Images = ResMod.PngImageList1
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 248
      Top = 24
      Width = 97
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Deaktivieren'
      ImageIndex = 13
      Images = ResMod.PngImageList1
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TWahlMod'
    SQLConnection = GM.SQLConnection1
    Left = 88
    Top = 56
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'WahlPhasenQry'
    RemoteServer = DSProviderConnection1
    Left = 136
    Top = 168
    object ClientDataSet1WA_ID: TIntegerField
      FieldName = 'WA_ID'
      Required = True
    end
    object ClientDataSet1WP_ID: TIntegerField
      FieldName = 'WP_ID'
      Required = True
    end
    object ClientDataSet1WP_TITLE: TStringField
      FieldName = 'WP_TITLE'
      Size = 100
    end
    object ClientDataSet1WP_ACTIVE: TStringField
      FieldName = 'WP_ACTIVE'
      OnGetText = ClientDataSet1WP_ACTIVEGetText
      FixedChar = True
      Size = 1
    end
    object ClientDataSet1WP_PHASE: TStringField
      FieldName = 'WP_PHASE'
      Size = 5
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 296
    Top = 144
  end
end
