object SimulationLoadForm: TSimulationLoadForm
  Left = 0
  Top = 0
  Caption = 'Simulation laden oder erzeugen'
  ClientHeight = 441
  ClientWidth = 588
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
    Top = 381
    Width = 588
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 0
    ExplicitTop = 381
    ExplicitWidth = 588
    inherited StatusBar1: TStatusBar
      Width = 588
      ExplicitWidth = 588
    end
    inherited Panel1: TPanel
      Width = 588
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 588
      inherited OKBtn: TBitBtn
        Left = 484
        Enabled = False
        ExplicitLeft = 484
      end
    end
  end
  object LV: TListView
    Left = 0
    Top = 0
    Width = 588
    Height = 340
    Align = alClient
    Columns = <
      item
        Caption = 'Kurzname'
        Width = 100
      end
      item
        Caption = 'Name'
        Width = 450
      end>
    ReadOnly = True
    RowSelect = True
    TabOrder = 1
    ViewStyle = vsReport
  end
  object Panel1: TPanel
    Left = 0
    Top = 340
    Width = 588
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 2
    object btnNeueWahl: TBitBtn
      Left = 16
      Top = 10
      Width = 153
      Height = 25
      Caption = 'Neue Wahl anlagen'
      ImageIndex = 9
      Images = ResMod.PngImageList1
      TabOrder = 0
      OnClick = btnNeueWahlClick
    end
  end
end
