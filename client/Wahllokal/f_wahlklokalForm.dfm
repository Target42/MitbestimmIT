object WahllokalForm: TWahllokalForm
  Left = 0
  Top = 0
  Caption = 'Wahllokale'
  ClientHeight = 511
  ClientWidth = 674
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Splitter1: TSplitter
    Left = 0
    Top = 177
    Width = 674
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitWidth = 284
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 674
    Height = 177
    Align = alTop
    Caption = 'R'#228'ume'
    TabOrder = 0
    object Panel1: TPanel
      Left = 2
      Top = 128
      Width = 670
      Height = 47
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel1'
      ShowCaption = False
      TabOrder = 0
      DesignSize = (
        670
        47)
      object btnAdd: TBitBtn
        Left = 14
        Top = 16
        Width = 89
        Height = 27
        Caption = 'Hinzuf'#252'gen'
        ImageIndex = 1
        Images = ResMod.PngImageList1
        TabOrder = 0
        OnClick = btnAddClick
      end
      object btnEdit: TBitBtn
        Left = 136
        Top = 16
        Width = 97
        Height = 27
        Caption = 'Bearbeiten'
        ImageIndex = 3
        Images = ResMod.PngImageList1
        TabOrder = 1
        OnClick = btnEditClick
      end
      object btnDelete: TBitBtn
        Left = 584
        Top = 16
        Width = 75
        Height = 27
        Anchors = [akTop, akRight]
        Caption = 'L'#246'schen'
        ImageIndex = 2
        Images = ResMod.PngImageList1
        TabOrder = 2
        OnClick = btnDeleteClick
      end
    end
    object DBGrid1: TDBGrid
      Left = 2
      Top = 17
      Width = 670
      Height = 111
      Align = alClient
      DataSource = LokalSrc
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
          FieldName = 'WL_START'
          Title.Caption = 'Startzeit'
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'WL_ENDE'
          Title.Caption = 'Endzeit'
          Visible = True
        end>
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 180
    Width = 674
    Height = 312
    Align = alClient
    Caption = 'Wahlhelfer'
    TabOrder = 1
    object Panel2: TPanel
      Left = 2
      Top = 263
      Width = 670
      Height = 47
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel1'
      ShowCaption = False
      TabOrder = 0
      DesignSize = (
        670
        47)
      object BitBtn1: TBitBtn
        Left = 14
        Top = 16
        Width = 89
        Height = 27
        Caption = 'Hinzuf'#252'gen'
        ImageIndex = 1
        Images = ResMod.PngImageList1
        TabOrder = 0
        OnClick = BitBtn1Click
      end
      object BitBtn3: TBitBtn
        Left = 584
        Top = 16
        Width = 75
        Height = 27
        Anchors = [akTop, akRight]
        Caption = 'L'#246'schen'
        ImageIndex = 2
        Images = ResMod.PngImageList1
        TabOrder = 1
        OnClick = BitBtn3Click
      end
    end
    object DBGrid2: TDBGrid
      Left = 2
      Top = 17
      Width = 670
      Height = 246
      Align = alClient
      DataSource = HelferSrc
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      PopupMenu = PopupMenu1
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
          Title.Caption = 'Abteilung'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'WH_ROLLE'
          Title.Caption = 'Bemerkung'
          Width = 100
          Visible = True
        end>
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 492
    Width = 674
    Height = 19
    Panels = <>
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TLokaleMod'
    Connected = True
    SQLConnection = GM.SQLConnection1
    Left = 48
    Top = 48
  end
  object LokalQry: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'LokaleQry'
    RemoteServer = DSProviderConnection1
    Left = 160
    Top = 40
  end
  object LokalSrc: TDataSource
    DataSet = LokalQry
    Left = 272
    Top = 40
  end
  object HelferQry: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'WL_ID;WA_ID'
    MasterFields = 'WL_ID;WA_ID'
    MasterSource = LokalSrc
    PacketRecords = 0
    Params = <>
    ProviderName = 'HelferQry'
    RemoteServer = DSProviderConnection1
    Left = 40
    Top = 228
    object HelferQryMA_ID: TIntegerField
      FieldName = 'MA_ID'
      Origin = 'MA_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object HelferQryMA_PERSNR: TStringField
      FieldName = 'MA_PERSNR'
      Origin = 'MA_PERSNR'
      Size = 10
    end
    object HelferQryMA_NAME: TStringField
      FieldName = 'MA_NAME'
      Origin = 'MA_NAME'
      Size = 100
    end
    object HelferQryMA_VORNAME: TStringField
      FieldName = 'MA_VORNAME'
      Origin = 'MA_VORNAME'
      Size = 100
    end
    object HelferQryMA_GENDER: TStringField
      FieldName = 'MA_GENDER'
      Origin = 'MA_GENDER'
      OnGetText = HelferQryMA_GENDERGetText
      FixedChar = True
      Size = 1
    end
    object HelferQryMA_ABTEILUNG: TStringField
      FieldName = 'MA_ABTEILUNG'
      Origin = 'MA_ABTEILUNG'
      Size = 100
    end
    object HelferQryMA_MAIL: TStringField
      FieldName = 'MA_MAIL'
      Origin = 'MA_MAIL'
      Size = 255
    end
    object HelferQryMA_GEB: TDateField
      FieldName = 'MA_GEB'
      Origin = 'MA_GEB'
    end
    object HelferQryWH_ROLLE: TStringField
      FieldName = 'WH_ROLLE'
      Origin = 'WH_ROLLE'
      Size = 100
    end
    object HelferQryWL_ID: TIntegerField
      FieldName = 'WL_ID'
      Required = True
    end
    object HelferQryWA_ID: TIntegerField
      FieldName = 'WA_ID'
      Required = True
    end
  end
  object HelferSrc: TDataSource
    DataSet = HelferQry
    Left = 112
    Top = 228
  end
  object PopupMenu1: TPopupMenu
    Left = 304
    Top = 268
    object Bemerkungbearbeiten1: TMenuItem
      Caption = 'Bemerkung bearbeiten'
      OnClick = Bemerkungbearbeiten1Click
    end
  end
end
