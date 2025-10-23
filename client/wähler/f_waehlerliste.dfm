object WaehlerListeForm: TWaehlerListeForm
  Left = 0
  Top = 0
  Caption = 'W'#228'hlerliste'
  ClientHeight = 441
  ClientWidth = 624
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 381
    Width = 624
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 381
    ExplicitWidth = 624
    inherited StatusBar1: TStatusBar
      Width = 624
      ExplicitWidth = 624
    end
    inherited Panel1: TPanel
      Width = 624
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 624
      inherited CancelBtn: TBitBtn
        Visible = False
      end
      inherited OKBtn: TBitBtn
        Left = 520
        ExplicitLeft = 520
      end
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 624
    Height = 381
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
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'MA_VORNAME'
        Title.Caption = 'Vorname'
        Width = 120
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
        Width = 120
        Visible = True
      end>
  end
  object DataSource1: TDataSource
    DataSet = GM.MAList
    Left = 304
    Top = 224
  end
end
