object WahllisteImport: TWahllisteImport
  Left = 0
  Top = 0
  Caption = 'Import einer Vorschlagsliste'
  ClientHeight = 755
  ClientWidth = 801
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
  object Splitter1: TSplitter
    Left = 0
    Top = 170
    Width = 801
    Height = 3
    Cursor = crVSplit
    Align = alTop
    ExplicitWidth = 253
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 695
    Width = 801
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 695
    ExplicitWidth = 801
    inherited StatusBar1: TStatusBar
      Width = 801
      ExplicitWidth = 801
    end
    inherited Panel1: TPanel
      Width = 801
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 801
      inherited OKBtn: TBitBtn
        Left = 697
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 697
      end
    end
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 801
    Height = 65
    Align = alTop
    Caption = 'Vorschlagsliste'
    TabOrder = 1
    DesignSize = (
      801
      65)
    object Edit1: TEdit
      Left = 16
      Top = 24
      Width = 667
      Height = 23
      Anchors = [akLeft, akTop, akRight]
      ReadOnly = True
      TabOrder = 0
      Text = 'Edit1'
    end
    object BitBtn1: TBitBtn
      Left = 713
      Top = 23
      Width = 75
      Height = 25
      Anchors = [akTop, akRight]
      Caption = 'Laden'
      ImageIndex = 7
      Images = ResMod.PngImageList1
      TabOrder = 1
      OnClick = BitBtn1Click
    end
  end
  object GroupBox2: TGroupBox
    Left = 0
    Top = 65
    Width = 801
    Height = 105
    Align = alTop
    Caption = 'Sheets'
    TabOrder = 2
    object CheckListBox1: TCheckListBox
      Left = 2
      Top = 17
      Width = 797
      Height = 86
      Align = alClient
      Columns = 2
      ItemHeight = 17
      TabOrder = 0
      OnClick = CheckListBox1Click
    end
  end
  object GroupBox3: TGroupBox
    Left = 0
    Top = 173
    Width = 801
    Height = 92
    Align = alTop
    Caption = 'Feldauswahl'
    TabOrder = 3
    object Label1: TLabel
      Left = 24
      Top = 40
      Width = 35
      Height = 15
      Caption = 'PersNr'
    end
    object Label2: TLabel
      Left = 240
      Top = 40
      Width = 115
      Height = 15
      Caption = 'Art der Besch'#228'ftigung'
    end
    object ComboBox1: TComboBox
      Left = 65
      Top = 32
      Width = 145
      Height = 23
      TabOrder = 0
      Text = 'ComboBox1'
    end
    object ComboBox2: TComboBox
      Left = 361
      Top = 32
      Width = 145
      Height = 23
      TabOrder = 1
      Text = 'ComboBox2'
    end
  end
  object GroupBox4: TGroupBox
    Left = 0
    Top = 265
    Width = 801
    Height = 430
    Align = alClient
    Caption = 'Vorschlagsliste'
    TabOrder = 4
    object LV: TListView
      Left = 2
      Top = 17
      Width = 797
      Height = 411
      Align = alClient
      Columns = <>
      ReadOnly = True
      RowSelect = True
      TabOrder = 0
      ViewStyle = vsReport
    end
  end
  object OpenDialog1: TOpenDialog
    DefaultExt = '.xlsx'
    Filter = 'Excel( *.xlsx)|*.xlsx|Alle Dateien|*.*'
    Title = 'W'#228'hlerliste laden'
    Left = 408
    Top = 24
  end
end
