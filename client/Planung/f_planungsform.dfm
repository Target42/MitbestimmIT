object Planungsform: TPlanungsform
  Left = 0
  Top = 0
  ActiveControl = WahlPlanungStartFrame1.LabeledEdit1
  Caption = 'Planungsform'
  ClientHeight = 573
  ClientWidth = 756
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
    Top = 554
    Width = 756
    Height = 19
    Panels = <>
  end
  object JvWizard1: TJvWizard
    Left = 0
    Top = 0
    Width = 756
    Height = 554
    ActivePage = JvWizardWelcomePage1
    ButtonBarHeight = 42
    ButtonStart.Caption = 'To &Start Page'
    ButtonStart.NumGlyphs = 1
    ButtonStart.Width = 85
    ButtonLast.Caption = 'To &Last Page'
    ButtonLast.NumGlyphs = 1
    ButtonLast.Width = 85
    ButtonBack.Caption = '< &Back'
    ButtonBack.NumGlyphs = 1
    ButtonBack.Width = 75
    ButtonNext.Caption = '&Next >'
    ButtonNext.NumGlyphs = 1
    ButtonNext.Width = 75
    ButtonFinish.Caption = '&Finish'
    ButtonFinish.NumGlyphs = 1
    ButtonFinish.Width = 75
    ButtonCancel.Caption = 'Abbrechen'
    ButtonCancel.NumGlyphs = 1
    ButtonCancel.ModalResult = 2
    ButtonCancel.Width = 75
    ButtonHelp.Caption = '&Hilfe'
    ButtonHelp.NumGlyphs = 1
    ButtonHelp.Width = 75
    ShowRouteMap = False
    DesignSize = (
      756
      554)
    object JvWizardWelcomePage1: TJvWizardWelcomePage
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'Planung einer Betriebsratswahl'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -24
      Header.Title.Font.Name = 'Segoe UI'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Wahlverfahren (BetrVG $14)'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -18
      Header.Subtitle.Font.Name = 'Segoe UI'
      Header.Subtitle.Font.Style = []
      Caption = 'JvWizardWelcomePage1'
      inline WahlPlanungStartFrame1: TWahlPlanungStartFrame
        AlignWithMargins = True
        Left = 167
        Top = 73
        Width = 586
        Height = 436
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 167
        ExplicitTop = 73
        ExplicitWidth = 586
        ExplicitHeight = 436
        inherited Image1: TImage
          Width = 586
          Height = 275
          ExplicitWidth = 586
          ExplicitHeight = 267
        end
        inherited GroupBox2: TGroupBox
          Width = 586
          ExplicitTop = 65
          ExplicitWidth = 586
          inherited LabeledEdit1: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited LabeledEdit2: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
        end
        inherited Panel1: TPanel
          Width = 586
          StyleElements = [seFont, seClient, seBorder]
          ExplicitWidth = 586
          inherited LabeledEdit3: TLabeledEdit
            EditLabel.ExplicitLeft = 0
            EditLabel.ExplicitTop = -18
            EditLabel.ExplicitWidth = 67
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited LabeledEdit4: TLabeledEdit
            EditLabel.ExplicitLeft = 0
            EditLabel.ExplicitTop = -18
            EditLabel.ExplicitWidth = 67
            StyleElements = [seFont, seClient, seBorder]
          end
        end
      end
    end
    object JvWizardInteriorPage1: TJvWizardInteriorPage
      Header.ParentFont = False
      Header.Title.Color = clNone
      Header.Title.Text = 'Planung einer Betriebsratswahl'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -24
      Header.Title.Font.Name = 'Segoe UI'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Wahlverfahren (BetrVG $14)'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -18
      Header.Subtitle.Font.Name = 'Segoe UI'
      Header.Subtitle.Font.Style = []
      Caption = 'JvWizardInteriorPage1'
      ExplicitWidth = 0
      ExplicitHeight = 0
      inline WahlverfahrenFrame1: TWahlverfahrenFrame
        AlignWithMargins = True
        Left = 3
        Top = 73
        Width = 750
        Height = 436
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 3
        ExplicitTop = 70
        ExplicitWidth = 756
        ExplicitHeight = 442
        inherited RadioButton1: TRadioButton
          Width = 744
          ExplicitWidth = 756
        end
        inherited RadioButton2: TRadioButton
          Width = 744
          ExplicitWidth = 756
        end
        inherited RichEdit1: TRichEdit
          Width = 744
          Lines.Strings = (
            ''
            'Ein vereinfachtes Verfahren ist m'#246'glich, wenn:'
            '    '#8226' es zwischen 5 und 100 Mitarbeiter sind.'
            '    '#8226' Es zwischen 101 und 200 Mitarbeiter sind und sich der '
            'Wahlausschuss '
            'und '
            'der Arbeitgeber auf dieses Verfahren geeinigt haben.'
            ''
            'Das Verfahren ist schneller und unkomplizierter:'
            '    '#8226' K'#252'rzere Fristen'
            '    '#8226' Nur ein Wahlgang'
            '    '#8226' Direktwahl der Kandidaten ohne Listenwahl')
          StyleElements = [seFont, seClient, seBorder]
          ExplicitWidth = 744
        end
        inherited RichEdit2: TRichEdit
          Width = 744
          Height = 43
          StyleElements = [seFont, seClient, seBorder]
          ExplicitWidth = 744
          ExplicitHeight = 43
        end
      end
    end
    object JvWizardInteriorPage2: TJvWizardInteriorPage
      Header.Title.Color = clNone
      Header.Title.Text = 'Planung einer Betriebsratswahl'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'Segoe UI'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Zeitplanung (BetrVG 16, WO-BetrVG '#167#167'3-41'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -12
      Header.Subtitle.Font.Name = 'Segoe UI'
      Header.Subtitle.Font.Style = []
      Caption = 'JvWizardInteriorPage2'
      ExplicitWidth = 0
      ExplicitHeight = 0
      inline WahlfristenFrame1: TWahlfristenFrame
        AlignWithMargins = True
        Left = 3
        Top = 73
        Width = 750
        Height = 436
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 3
        ExplicitTop = 70
        ExplicitWidth = 756
        ExplicitHeight = 442
        inherited Panel1: TPanel
          Width = 750
          StyleElements = [seFont, seClient, seBorder]
          ExplicitWidth = 756
          inherited Label1: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited Label2: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited Label3: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited Label4: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited Label5: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited Label6: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited Label7: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited Label8: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited Label9: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited Label10: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited Label11: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited Label12: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited Label13: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited Label14: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited Label15: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited Label16: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
        end
        inherited Chart1: TChart
          Width = 750
          Height = 184
          ExplicitWidth = 756
          ExplicitHeight = 190
        end
      end
    end
    object JvWizardInteriorPage3: TJvWizardInteriorPage
      Header.Title.Color = clNone
      Header.Title.Text = 'Planung einer Betriebsratswahl'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'Segoe UI'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Wahlvorstand (BetrVG '#167'16)'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -12
      Header.Subtitle.Font.Name = 'Segoe UI'
      Header.Subtitle.Font.Style = []
      Caption = 'JvWizardInteriorPage3'
      ExplicitWidth = 0
      ExplicitHeight = 0
      inline WahlVorstandFrame1: TWahlVorstandFrame
        AlignWithMargins = True
        Left = 3
        Top = 73
        Width = 750
        Height = 436
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 3
        ExplicitTop = 70
        ExplicitWidth = 756
        ExplicitHeight = 442
        inherited GroupBox1: TGroupBox
          Width = 750
          ExplicitWidth = 756
          inherited LV: TListView
            Width = 746
            ExplicitWidth = 752
          end
          inherited Panel1: TPanel
            Width = 746
            StyleElements = [seFont, seClient, seBorder]
            ExplicitWidth = 752
            inherited btnDelete: TBitBtn
              Left = 654
              ExplicitLeft = 660
            end
          end
        end
      end
    end
  end
end
