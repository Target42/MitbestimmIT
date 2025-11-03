object WahllistenForm: TWahllistenForm
  Left = 0
  Top = 0
  Caption = 'Wahllisten'
  ClientHeight = 472
  ClientWidth = 873
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
    Top = 201
    Width = 873
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitWidth = 221
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 453
    Width = 873
    Height = 19
    Panels = <>
    ExplicitTop = 422
    ExplicitWidth = 640
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 873
    Height = 201
    Align = alTop
    Caption = 'Wahllisten'
    TabOrder = 1
    ExplicitWidth = 640
    object DBGrid1: TDBGrid
      Left = 2
      Top = 17
      Width = 869
      Height = 141
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
          FieldName = 'WT_NAME'
          Title.Caption = 'Name'
          Width = 250
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'WT_KURZ'
          Title.Caption = 'K'#252'rzel'
          Visible = True
        end>
    end
    object Panel1: TPanel
      Left = 2
      Top = 158
      Width = 869
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel1'
      ShowCaption = False
      TabOrder = 1
      ExplicitWidth = 636
      DesignSize = (
        869
        41)
      object btnAdd: TBitBtn
        Left = 14
        Top = 6
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
        Top = 6
        Width = 97
        Height = 27
        Caption = 'Bearbeiten'
        ImageIndex = 3
        Images = ResMod.PngImageList1
        TabOrder = 1
        OnClick = btnEditClick
      end
      object btnDelete: TBitBtn
        Left = 778
        Top = 6
        Width = 75
        Height = 27
        Anchors = [akTop, akRight]
        Caption = 'L'#246'schen'
        ImageIndex = 2
        Images = ResMod.PngImageList1
        TabOrder = 2
        OnClick = btnDeleteClick
        ExplicitLeft = 545
      end
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 204
    Width = 873
    Height = 249
    Align = alClient
    Caption = 'Mitglieder'
    TabOrder = 2
    ExplicitWidth = 640
    ExplicitHeight = 218
    object DBGrid2: TDBGrid
      Left = 2
      Top = 17
      Width = 869
      Height = 189
      Align = alClient
      DataSource = DataSource2
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
          FieldName = 'WT_WA_POS'
          Title.Caption = 'Position'
          Visible = True
        end
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
          Width = 75
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
          FieldName = 'MA_GEB'
          Title.Caption = 'GebDat'
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'WT_WA_JOB'
          Title.Caption = 'Job'
          Width = 150
          Visible = True
        end>
    end
    object Panel2: TPanel
      Left = 2
      Top = 206
      Width = 869
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      Caption = 'Panel2'
      ShowCaption = False
      TabOrder = 1
      ExplicitTop = 175
      ExplicitWidth = 636
      object BitBtn1: TBitBtn
        Left = 14
        Top = 10
        Width = 89
        Height = 27
        Caption = 'Berabeiten'
        ImageIndex = 1
        Images = ResMod.PngImageList1
        TabOrder = 0
        OnClick = BitBtn1Click
      end
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TWahlListeMod'
    SQLConnection = GM.SQLConnection1
    Left = 64
    Top = 48
  end
  object ListenQry: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'WahllisteQry'
    RemoteServer = DSProviderConnection1
    Left = 184
    Top = 48
  end
  object DataSource1: TDataSource
    DataSet = ListenQry
    Left = 296
    Top = 40
  end
  object MAQry: TClientDataSet
    Aggregates = <>
    IndexFieldNames = 'WA_ID;WT_ID'
    MasterFields = 'WA_ID;WT_ID'
    MasterSource = DataSource1
    PacketRecords = 0
    Params = <>
    ProviderName = 'WahllisteMAQry'
    RemoteServer = DSProviderConnection1
    Left = 48
    Top = 240
    object MAQryWA_ID: TIntegerField
      FieldName = 'WA_ID'
      Required = True
    end
    object MAQryMA_ID: TIntegerField
      FieldName = 'MA_ID'
      Required = True
    end
    object MAQryWT_ID: TIntegerField
      FieldName = 'WT_ID'
      Required = True
    end
    object MAQryWT_WA_POS: TIntegerField
      FieldName = 'WT_WA_POS'
    end
    object MAQryMA_PERSNR: TStringField
      FieldName = 'MA_PERSNR'
      ReadOnly = True
      Size = 10
    end
    object MAQryMA_NAME: TStringField
      FieldName = 'MA_NAME'
      ReadOnly = True
      Size = 100
    end
    object MAQryMA_VORNAME: TStringField
      FieldName = 'MA_VORNAME'
      ReadOnly = True
      Size = 100
    end
    object MAQryMA_GENDER: TStringField
      FieldName = 'MA_GENDER'
      ReadOnly = True
      OnGetText = MAQryMA_GENDERGetText
      FixedChar = True
      Size = 1
    end
    object MAQryMA_ABTEILUNG: TStringField
      FieldName = 'MA_ABTEILUNG'
      ReadOnly = True
      Size = 100
    end
    object MAQryMA_GEB: TDateField
      FieldName = 'MA_GEB'
      ReadOnly = True
    end
    object MAQryWT_WA_JOB: TStringField
      FieldName = 'WT_WA_JOB'
      Size = 150
    end
  end
  object DataSource2: TDataSource
    DataSet = MAQry
    Left = 136
    Top = 240
  end
end
