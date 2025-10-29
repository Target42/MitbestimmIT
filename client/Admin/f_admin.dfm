object AdminForm: TAdminForm
  Left = 0
  Top = 0
  Caption = 'Administrator-Verwaltung'
  ClientHeight = 482
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  HelpFile = 'dummy.hlp'
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 624
    Height = 209
    Align = alTop
    Caption = 'Wahl'#252'bersicht'
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 2
      Top = 17
      Width = 620
      Height = 190
      Align = alClient
      DataSource = WahlSrc
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
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
          FieldName = 'WA_TITLE'
          Title.Caption = 'Wahlname'
          Width = 300
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'WA_SIMU_LANG'
          Title.Caption = 'Simulation'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'WA_ACTIVE_LANG'
          Title.Caption = 'Aktiv'
          Visible = True
        end>
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 463
    Width = 624
    Height = 19
    Panels = <>
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 209
    Width = 624
    Height = 280
    Align = alTop
    Caption = 'Neue Wahl anlegen'
    TabOrder = 2
    object Panel1: TPanel
      Left = 2
      Top = 17
      Width = 620
      Height = 72
      Align = alTop
      BevelOuter = bvNone
      Caption = 'Panel1'
      ShowCaption = False
      TabOrder = 0
      object LabeledEdit1: TLabeledEdit
        Left = 16
        Top = 32
        Width = 281
        Height = 23
        EditLabel.Width = 82
        EditLabel.Height = 15
        EditLabel.Caption = 'Name der Wahl'
        TabOrder = 0
        Text = ''
      end
      object CheckBox1: TCheckBox
        Left = 320
        Top = 32
        Width = 137
        Height = 17
        Caption = 'Simulation zus'#228'tzlich'
        Checked = True
        State = cbChecked
        TabOrder = 1
      end
    end
    object GroupBox3: TGroupBox
      Left = 2
      Top = 89
      Width = 620
      Height = 189
      Align = alClient
      Caption = 'Wahlvorstandvorsitz'
      TabOrder = 1
      object LabeledEdit2: TLabeledEdit
        Left = 111
        Top = 40
        Width = 89
        Height = 23
        EditLabel.Width = 43
        EditLabel.Height = 15
        EditLabel.Caption = 'Pers.-Nr'
        TabOrder = 1
        Text = '0815'
      end
      object LabeledEdit3: TLabeledEdit
        Left = 215
        Top = 40
        Width = 154
        Height = 23
        EditLabel.Width = 32
        EditLabel.Height = 15
        EditLabel.Caption = 'Name'
        TabOrder = 2
        Text = 'Doe'
      end
      object LabeledEdit4: TLabeledEdit
        Left = 383
        Top = 40
        Width = 121
        Height = 23
        EditLabel.Width = 47
        EditLabel.Height = 15
        EditLabel.Caption = 'Vorname'
        TabOrder = 3
        Text = 'John'
      end
      object LabeledEdit5: TLabeledEdit
        Left = 16
        Top = 95
        Width = 121
        Height = 23
        EditLabel.Width = 87
        EditLabel.Height = 15
        EditLabel.Caption = 'initialesPasswort'
        PasswordChar = '*'
        TabOrder = 4
        Text = '0815'
      end
      object LabeledEdit6: TLabeledEdit
        Left = 16
        Top = 40
        Width = 89
        Height = 23
        EditLabel.Width = 30
        EditLabel.Height = 15
        EditLabel.Caption = 'Login'
        TabOrder = 0
        Text = 'jd0815'
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 422
    Width = 624
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel2'
    ShowCaption = False
    TabOrder = 3
    object BitBtn1: TBitBtn
      Left = 18
      Top = 10
      Width = 89
      Height = 25
      Caption = 'Anlegen'
      ImageIndex = 9
      Images = ResMod.PngImageList1
      TabOrder = 0
      OnClick = BitBtn1Click
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TAdminMod'
    SQLConnection = GM.SQLConnection1
    Left = 80
    Top = 56
  end
  object WahlTab: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'WahlTab'
    RemoteServer = DSProviderConnection1
    Left = 200
    Top = 56
    object WahlTabWA_ID: TIntegerField
      FieldName = 'WA_ID'
      Origin = 'WA_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object WahlTabWA_TITLE: TStringField
      FieldName = 'WA_TITLE'
      Origin = 'WA_TITLE'
      Size = 150
    end
    object WahlTabWA_SIMU: TStringField
      FieldName = 'WA_SIMU'
      Origin = 'WA_SIMU'
      FixedChar = True
      Size = 1
    end
    object WahlTabWA_ACTIVE: TStringField
      FieldName = 'WA_ACTIVE'
      Origin = 'WA_ACTIVE'
      FixedChar = True
      Size = 1
    end
    object WahlTabWA_SIMU_LANG: TStringField
      FieldKind = fkCalculated
      FieldName = 'WA_SIMU_LANG'
      OnGetText = WahlTabWA_SIMU_LANGGetText
      Calculated = True
    end
    object WahlTabWA_ACTIVE_LANG: TStringField
      FieldKind = fkCalculated
      FieldName = 'WA_ACTIVE_LANG'
      OnGetText = WahlTabWA_ACTIVE_LANGGetText
      Calculated = True
    end
  end
  object WahlSrc: TDataSource
    DataSet = WahlTab
    Left = 288
    Top = 56
  end
end
