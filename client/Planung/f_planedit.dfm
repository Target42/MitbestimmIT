object PlanEditoForm: TPlanEditoForm
  Left = 0
  Top = 0
  Caption = 'Bearbeiten der Planungsdaten'
  ClientHeight = 674
  ClientWidth = 739
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
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 614
    Width = 739
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitLeft = -16
    ExplicitTop = 208
    inherited StatusBar1: TStatusBar
      Width = 739
      ExplicitWidth = 729
    end
    inherited Panel1: TPanel
      Width = 739
      StyleElements = [seFont, seClient, seBorder]
      inherited OKBtn: TBitBtn
        Left = 635
        OnClick = BaseFrame1OKBtnClick
      end
    end
  end
  inline WahlfristenFrame1: TWahlfristenFrame
    Left = 0
    Top = 0
    Width = 739
    Height = 614
    Align = alClient
    TabOrder = 1
    ExplicitLeft = -355
    ExplicitTop = -158
    inherited Splitter1: TSplitter
      Width = 739
    end
    inherited Chart1: TChart
      Width = 739
      Height = 354
    end
    inherited GroupBox1: TGroupBox
      Width = 739
      inherited LV: TListView
        Width = 735
      end
      inherited Panel1: TPanel
        Width = 735
        StyleElements = [seFont, seClient, seBorder]
      end
    end
  end
end
