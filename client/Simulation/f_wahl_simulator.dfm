object WahlsimulatorForm: TWahlsimulatorForm
  Left = 0
  Top = 0
  Caption = 'Wahlsimulator'
  ClientHeight = 458
  ClientWidth = 653
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
  object StatusBar1: TStatusBar
    Left = 0
    Top = 439
    Width = 653
    Height = 19
    Panels = <>
    ExplicitTop = 409
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 0
    Width = 653
    Height = 109
    Align = alTop
    Caption = 'Statistik'
    TabOrder = 1
    object Label1: TLabel
      Left = 15
      Top = 24
      Width = 96
      Height = 15
      Caption = 'Wahlberechtigt : 0'
    end
    object Label2: TLabel
      Left = 140
      Top = 24
      Width = 51
      Height = 15
      Caption = 'Frauen : 0'
    end
    object Label3: TLabel
      Left = 261
      Top = 24
      Width = 56
      Height = 15
      Caption = 'M'#228'nner : 0'
    end
    object Label12: TLabel
      Left = 15
      Top = 45
      Width = 56
      Height = 15
      Caption = 'Gremium :'
    end
    object Gremium: TLabel
      Left = 93
      Top = 45
      Width = 6
      Height = 15
      Caption = '0'
    end
    object Label13: TLabel
      Left = 135
      Top = 45
      Width = 83
      Height = 15
      Caption = 'Freistellungen : '
    end
    object Freistellungen: TLabel
      Left = 224
      Top = 45
      Width = 6
      Height = 15
      Caption = '0'
    end
    object Label14: TLabel
      Left = 261
      Top = 45
      Width = 64
      Height = 15
      Caption = 'Minderheit :'
    end
    object Minderheit: TLabel
      Left = 331
      Top = 45
      Width = 32
      Height = 15
      Caption = 'Aliens'
    end
    object Label15: TLabel
      Left = 395
      Top = 45
      Width = 27
      Height = 15
      Caption = 'Sitze:'
    end
    object MinderheitnSitze: TLabel
      Left = 428
      Top = 45
      Width = 6
      Height = 15
      Caption = '0'
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 109
    Width = 653
    Height = 330
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 2
    ExplicitHeight = 300
    object TabSheet1: TTabSheet
      Caption = 'Wahldaten'
      object labBrief: TLabel
        Left = 391
        Top = 24
        Width = 6
        Height = 15
        Caption = '0'
      end
      object Label10: TLabel
        Left = 336
        Top = 144
        Width = 157
        Height = 15
        Caption = 'Ung'#252'ltige Briefwahlstimmen :'
      end
      object Label11: TLabel
        Left = 499
        Top = 144
        Width = 6
        Height = 15
        Caption = '0'
      end
      object Label4: TLabel
        Left = 32
        Top = 24
        Width = 97
        Height = 15
        Caption = 'Wahlbeteidigung :'
      end
      object Label5: TLabel
        Left = 320
        Top = 24
        Width = 65
        Height = 15
        Caption = 'Briefw'#228'hler :'
      end
      object Label6: TLabel
        Left = 32
        Top = 80
        Width = 79
        Height = 15
        Caption = 'Doppelw'#228'hler :'
      end
      object Label7: TLabel
        Left = 143
        Top = 80
        Width = 6
        Height = 15
        Caption = '0'
      end
      object Label8: TLabel
        Left = 32
        Top = 144
        Width = 143
        Height = 15
        Caption = 'Ung'#252'ltige Urnenstimmen : '
      end
      object Label9: TLabel
        Left = 181
        Top = 144
        Width = 6
        Height = 15
        Caption = '0'
      end
      object labWahlBeteidigung: TLabel
        Left = 143
        Top = 24
        Width = 19
        Height = 15
        Caption = '0 %'
      end
      object ScrollBar1: TScrollBar
        Left = 32
        Top = 45
        Width = 265
        Height = 17
        PageSize = 0
        TabOrder = 0
        OnChange = ScrollBar1Change
      end
      object ScrollBar2: TScrollBar
        Left = 320
        Top = 45
        Width = 265
        Height = 17
        PageSize = 0
        TabOrder = 1
        OnChange = ScrollBar2Change
      end
      object ScrollBar3: TScrollBar
        Left = 32
        Top = 101
        Width = 265
        Height = 17
        PageSize = 0
        TabOrder = 2
        OnChange = ScrollBar3Change
      end
      object ScrollBar4: TScrollBar
        Left = 32
        Top = 165
        Width = 265
        Height = 17
        PageSize = 0
        TabOrder = 3
        OnChange = ScrollBar4Change
      end
      object ScrollBar5: TScrollBar
        Left = 336
        Top = 165
        Width = 265
        Height = 17
        PageSize = 0
        TabOrder = 4
        OnChange = ScrollBar5Change
      end
      object BitBtn1: TBitBtn
        Left = 32
        Top = 224
        Width = 75
        Height = 25
        Caption = 'Anlegen'
        ImageIndex = 6
        Images = ResMod.PngImageList1
        TabOrder = 5
        OnClick = BitBtn1Click
      end
    end
  end
end
