object HelferWechselForm: THelferWechselForm
  Left = 0
  Top = 0
  Caption = 'Helferwechsel'
  ClientHeight = 393
  ClientWidth = 740
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 740
    Height = 269
    Align = alClient
    Caption = 'Helfer'
    TabOrder = 0
    object DBGrid1: TDBGrid
      Left = 2
      Top = 17
      Width = 736
      Height = 250
      Align = alClient
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
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
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MA_VORNAME'
          Title.Caption = 'Vorname'
          Width = 100
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
          Width = 250
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'WH_ROLLE'
          Title.Caption = 'Rolle'
          Width = 100
          Visible = True
        end>
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 269
    Width = 740
    Height = 105
    Align = alBottom
    Caption = 'Passwort'
    TabOrder = 1
    object LabeledEdit1: TLabeledEdit
      Left = 16
      Top = 40
      Width = 121
      Height = 23
      EditLabel.Width = 96
      EditLabel.Height = 15
      EditLabel.Caption = 'Aktueller Benutzer'
      PasswordChar = '*'
      TabOrder = 0
      Text = ''
    end
    object LabeledEdit2: TLabeledEdit
      Left = 176
      Top = 40
      Width = 121
      Height = 23
      EditLabel.Width = 81
      EditLabel.Height = 15
      EditLabel.Caption = 'Neuer Benutzer'
      PasswordChar = '*'
      TabOrder = 1
      Text = ''
    end
    object BitBtn1: TBitBtn
      Left = 336
      Top = 40
      Width = 75
      Height = 25
      Caption = 'Setzen'
      TabOrder = 2
      OnClick = BitBtn1Click
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 374
    Width = 740
    Height = 19
    Panels = <>
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TWahlLokalMod'
    SQLConnection = GM.SQLConnection1
    Left = 56
    Top = 40
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'HelferQry'
    RemoteServer = DSProviderConnection1
    Left = 184
    Top = 40
    object ClientDataSet1MA_ID: TIntegerField
      FieldName = 'MA_ID'
      Origin = 'MA_ID'
      ProviderFlags = [pfInUpdate, pfInWhere, pfInKey]
      Required = True
    end
    object ClientDataSet1MA_PERSNR: TStringField
      FieldName = 'MA_PERSNR'
      Origin = 'MA_PERSNR'
      Size = 10
    end
    object ClientDataSet1MA_NAME: TStringField
      FieldName = 'MA_NAME'
      Origin = 'MA_NAME'
      Size = 100
    end
    object ClientDataSet1MA_VORNAME: TStringField
      FieldName = 'MA_VORNAME'
      Origin = 'MA_VORNAME'
      Size = 100
    end
    object ClientDataSet1MA_GENDER: TStringField
      FieldName = 'MA_GENDER'
      Origin = 'MA_GENDER'
      OnGetText = ClientDataSet1MA_GENDERGetText
      FixedChar = True
      Size = 1
    end
    object ClientDataSet1MA_ABTEILUNG: TStringField
      FieldName = 'MA_ABTEILUNG'
      Origin = 'MA_ABTEILUNG'
      Size = 100
    end
    object ClientDataSet1MA_MAIL: TStringField
      FieldName = 'MA_MAIL'
      Origin = 'MA_MAIL'
      Size = 255
    end
    object ClientDataSet1MA_GEB: TDateField
      FieldName = 'MA_GEB'
      Origin = 'MA_GEB'
    end
    object ClientDataSet1WH_ROLLE: TStringField
      FieldName = 'WH_ROLLE'
      Origin = 'WH_ROLLE'
      Size = 100
    end
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 272
    Top = 41
  end
end
