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
    ExplicitTop = 614
    ExplicitWidth = 739
    inherited StatusBar1: TStatusBar
      Width = 739
      ExplicitWidth = 739
    end
    inherited Panel1: TPanel
      Width = 739
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 739
      inherited OKBtn: TBitBtn
        Left = 635
        OnClick = BaseFrame1OKBtnClick
        ExplicitLeft = 635
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
    ExplicitWidth = 739
    ExplicitHeight = 614
    inherited Splitter1: TSplitter
      Width = 739
      ExplicitWidth = 739
    end
    inherited Chart1: TChart
      Width = 739
      Height = 354
      ExplicitWidth = 739
      ExplicitHeight = 354
    end
    inherited GroupBox1: TGroupBox
      Width = 739
      ExplicitWidth = 739
      inherited LV: TListView
        Width = 735
        ExplicitWidth = 735
      end
      inherited Panel1: TPanel
        Width = 735
        StyleElements = [seFont, seClient, seBorder]
        ExplicitWidth = 735
        inherited BitBtn1: TBitBtn
          Left = 28
          Width = 93
          ExplicitLeft = 28
          ExplicitWidth = 93
        end
      end
    end
  end
end
