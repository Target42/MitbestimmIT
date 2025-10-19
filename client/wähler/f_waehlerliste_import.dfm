object WaehlerlisteImportForm: TWaehlerlisteImportForm
  Left = 0
  Top = 0
  Caption = 'W'#228'hlerliste'
  ClientHeight = 668
  ClientWidth = 624
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
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 624
    Height = 73
    Align = alTop
    Caption = 'Datendatei'
    TabOrder = 0
    object SpeedButton1: TSpeedButton
      Left = 472
      Top = 32
      Width = 23
      Height = 22
      Caption = '...'
      OnClick = SpeedButton1Click
    end
    object Edit1: TEdit
      Left = 16
      Top = 31
      Width = 441
      Height = 23
      TabOrder = 0
    end
    object btnLoad: TBitBtn
      Left = 528
      Top = 30
      Width = 75
      Height = 25
      Caption = 'Laden'
      ImageIndex = 7
      Images = ResMod.PngImageList1
      TabOrder = 1
      OnClick = btnLoadClick
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 73
    Width = 624
    Height = 136
    Align = alTop
    Caption = 'Feldzuordnungen'
    TabOrder = 1
    object Label1: TLabel
      Left = 16
      Top = 24
      Width = 91
      Height = 15
      Caption = 'Personalnummer'
    end
    object Label2: TLabel
      Left = 288
      Top = 24
      Width = 101
      Height = 15
      Caption = 'Anrede/Geschlecht'
    end
    object Label3: TLabel
      Left = 16
      Top = 48
      Width = 32
      Height = 15
      Caption = 'Name'
    end
    object Label4: TLabel
      Left = 288
      Top = 48
      Width = 47
      Height = 15
      Caption = 'Vorname'
    end
    object Label5: TLabel
      Left = 16
      Top = 78
      Width = 52
      Height = 15
      Caption = 'Abteilung'
    end
    object Label9: TLabel
      Left = 288
      Top = 77
      Width = 80
      Height = 15
      Caption = 'Geburtstdatum'
    end
    object ComboBox1: TComboBox
      Left = 128
      Top = 16
      Width = 145
      Height = 23
      TabOrder = 0
      Text = 'ComboBox1'
    end
    object ComboBox2: TComboBox
      Left = 406
      Top = 16
      Width = 145
      Height = 23
      TabOrder = 1
      Text = 'ComboBox2'
    end
    object ComboBox3: TComboBox
      Left = 128
      Top = 45
      Width = 145
      Height = 23
      TabOrder = 2
      Text = 'ComboBox3'
    end
    object ComboBox4: TComboBox
      Left = 406
      Top = 45
      Width = 145
      Height = 23
      TabOrder = 3
      Text = 'ComboBox4'
    end
    object ComboBox5: TComboBox
      Left = 128
      Top = 72
      Width = 145
      Height = 23
      TabOrder = 4
      Text = 'ComboBox5'
    end
    object CheckBox1: TCheckBox
      Left = 128
      Top = 101
      Width = 145
      Height = 17
      Caption = '1.Zeile '#220'berschrift'
      Checked = True
      State = cbChecked
      TabOrder = 5
    end
    object btnUse: TBitBtn
      Left = 406
      Top = 105
      Width = 105
      Height = 25
      Hint = 
        'Die '#220'berschriftennamen m'#252'ssen so angeordnet werden, das sie der ' +
        'Liste unten entsprechen'
      Caption = #220'bernehmen'
      ImageIndex = 6
      Images = ResMod.PngImageList1
      TabOrder = 6
      OnClick = btnUseClick
    end
    object ComboBox9: TComboBox
      Left = 406
      Top = 74
      Width = 145
      Height = 23
      TabOrder = 7
      Text = 'ComboBox9'
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 649
    Width = 624
    Height = 19
    Panels = <>
  end
  object Panel1: TPanel
    Left = 0
    Top = 603
    Width = 624
    Height = 46
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 3
    DesignSize = (
      624
      46)
    object btnUpdate: TBitBtn
      Left = 496
      Top = 15
      Width = 107
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Aktualisieren'
      ImageIndex = 5
      Images = ResMod.PngImageList1
      TabOrder = 0
      OnClick = btnUpdateClick
    end
  end
  object LV: TListView
    Left = 0
    Top = 281
    Width = 624
    Height = 322
    Align = alClient
    Columns = <
      item
        Caption = 'PersNr'
      end
      item
        Caption = 'Name'
        Width = 150
      end
      item
        Caption = 'Vorname'
        Width = 150
      end
      item
        Caption = 'Geschlecht'
        Width = 100
      end
      item
        Caption = 'Abteilung'
        Width = 100
      end
      item
        Caption = 'GebDat'
        Width = 100
      end>
    ReadOnly = True
    RowSelect = True
    TabOrder = 4
    ViewStyle = vsReport
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 209
    Width = 624
    Height = 72
    Align = alTop
    Caption = 'Geschlechter'
    TabOrder = 5
    ExplicitTop = 201
    object Label6: TLabel
      Left = 16
      Top = 14
      Width = 50
      Height = 15
      Caption = 'M'#228'nnlich'
    end
    object Label7: TLabel
      Left = 167
      Top = 14
      Width = 46
      Height = 15
      Caption = 'Weiblich'
    end
    object Label8: TLabel
      Left = 318
      Top = 14
      Width = 32
      Height = 15
      Caption = 'Divers'
    end
    object btnScan: TBitBtn
      Left = 469
      Top = 41
      Width = 75
      Height = 25
      Hint = 
        'Die Bezeichnungen der Geschlechter m'#252'ssen hier eingestellt werde' +
        'n.'
      Caption = 'Suchen'
      ImageIndex = 8
      Images = ResMod.PngImageList1
      TabOrder = 0
      OnClick = btnScanClick
    end
    object ComboBox6: TComboBox
      Left = 16
      Top = 35
      Width = 145
      Height = 23
      TabOrder = 1
      Text = 'ComboBox6'
    end
    object ComboBox7: TComboBox
      Left = 167
      Top = 35
      Width = 145
      Height = 23
      TabOrder = 2
      Text = 'ComboBox6'
    end
    object ComboBox8: TComboBox
      Left = 318
      Top = 35
      Width = 145
      Height = 23
      ItemIndex = 1
      TabOrder = 3
      Text = 'weiblich'
      Items.Strings = (
        'm'#228'nnlich'
        'weiblich')
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.xlsx'
    Filter = 'Excel( *.xlsx)|*.xlsx|Alle Dateien|*.*'
    Title = 'W'#228'hlerliste laden'
    Left = 280
    Top = 16
  end
end
