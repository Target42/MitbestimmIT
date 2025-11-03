object WahllistenPersonenForm: TWahllistenPersonenForm
  Left = 0
  Top = 0
  Caption = 'Mitglieder der Wahlliste'
  ClientHeight = 516
  ClientWidth = 985
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
    Width = 985
    Height = 73
    Align = alTop
    Caption = 'Wahlliste'
    TabOrder = 0
    ExplicitWidth = 624
    object LabeledEdit1: TLabeledEdit
      Left = 11
      Top = 32
      Width = 414
      Height = 23
      EditLabel.Width = 32
      EditLabel.Height = 15
      EditLabel.Caption = 'Name'
      Enabled = False
      TabOrder = 0
      Text = ''
    end
    object LabeledEdit2: TLabeledEdit
      Left = 440
      Top = 32
      Width = 121
      Height = 23
      EditLabel.Width = 32
      EditLabel.Height = 15
      EditLabel.Caption = 'K'#252'rzel'
      Enabled = False
      TabOrder = 1
      Text = ''
    end
  end
  inline BaseFrame1: TBaseFrame
    Left = 0
    Top = 456
    Width = 985
    Height = 60
    Align = alBottom
    AutoSize = True
    TabOrder = 1
    ExplicitTop = 381
    ExplicitWidth = 624
    inherited StatusBar1: TStatusBar
      Width = 985
      ExplicitWidth = 986
    end
    inherited Panel1: TPanel
      Width = 985
      StyleElements = [seFont, seClient, seBorder]
      ExplicitWidth = 624
      inherited OKBtn: TBitBtn
        Left = 881
        ExplicitLeft = 520
      end
    end
  end
  object SG: TStringGrid
    Left = 0
    Top = 73
    Width = 985
    Height = 383
    Align = alClient
    DefaultDrawing = False
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing, goFixedRowDefAlign]
    PopupMenu = PopupMenu1
    TabOrder = 2
    OnDrawCell = SGDrawCell
    OnKeyPress = SGKeyPress
    OnSelectCell = SGSelectCell
    ExplicitTop = 77
  end
  object PopupMenu1: TPopupMenu
    Left = 200
    Top = 120
    object PopupMenu11: TMenuItem
      Caption = 'Einf'#252'gen'
      ShortCut = 16470
      OnClick = PopupMenu11Click
    end
  end
end
