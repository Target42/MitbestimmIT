object UserForm: TUserForm
  Left = 0
  Top = 0
  Caption = 'Benutzerverwaltung'
  ClientHeight = 451
  ClientWidth = 1134
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
    Top = 432
    Width = 1134
    Height = 19
    Panels = <>
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 1134
    Height = 432
    Align = alClient
    Caption = #220'bersicht'
    TabOrder = 1
    object DBGrid1: TDBGrid
      Left = 2
      Top = 17
      Width = 1130
      Height = 413
      Align = alClient
      DataSource = DataSource1
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      PopupMenu = PopupMenu1
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
      OnDblClick = DBGrid1DblClick
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
          Title.Caption = 'abteilung'
          Width = 100
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MW_LOGIN'
          Title.Caption = 'Login'
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MA_MAIL'
          Title.Caption = 'eMail'
          Width = 250
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MA_GEB'
          Title.Caption = 'Geb.Dat.'
          Width = 75
          Visible = True
        end
        item
          Expanded = False
          FieldName = 'MW_ROLLE'
          Title.Caption = 'Rollen'
          Width = 250
          Visible = True
        end>
    end
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    ProviderName = 'UserQry'
    ReadOnly = True
    RemoteServer = DSProviderConnection1
    Left = 168
    Top = 24
    object ClientDataSet1MA_ID: TIntegerField
      FieldName = 'MA_ID'
      Required = True
    end
    object ClientDataSet1MA_PERSNR: TStringField
      FieldName = 'MA_PERSNR'
      Size = 10
    end
    object ClientDataSet1MA_NAME: TStringField
      FieldName = 'MA_NAME'
      Size = 100
    end
    object ClientDataSet1MA_VORNAME: TStringField
      FieldName = 'MA_VORNAME'
      Size = 100
    end
    object ClientDataSet1MA_GENDER: TStringField
      FieldName = 'MA_GENDER'
      OnGetText = ClientDataSet1MA_GENDERGetText
      FixedChar = True
      Size = 1
    end
    object ClientDataSet1MA_ABTEILUNG: TStringField
      FieldName = 'MA_ABTEILUNG'
      Size = 100
    end
    object ClientDataSet1MA_MAIL: TStringField
      FieldName = 'MA_MAIL'
      Size = 255
    end
    object ClientDataSet1MA_GEB: TDateField
      FieldName = 'MA_GEB'
    end
    object ClientDataSet1MW_ROLLE: TStringField
      FieldName = 'MW_ROLLE'
      ReadOnly = True
      Size = 100
    end
    object ClientDataSet1MW_LOGIN: TStringField
      FieldName = 'MW_LOGIN'
      ReadOnly = True
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TUserMod'
    SQLConnection = GM.SQLConnection1
    Left = 48
    Top = 24
  end
  object DataSource1: TDataSource
    DataSet = ClientDataSet1
    Left = 264
    Top = 16
  end
  object PopupMenu1: TPopupMenu
    Images = ResMod.PngImageList1
    Left = 608
    Top = 112
    object Barbeiten1: TMenuItem
      Caption = 'Barbeiten'
      ImageIndex = 1
      OnClick = Barbeiten1Click
    end
  end
end
