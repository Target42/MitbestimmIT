object Planungsform: TPlanungsform
  Left = 0
  Top = 0
  ActiveControl = WahlverfahrenFrame1.RichEdit1
  Caption = 'Wahlplanung'
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
      EnabledButtons = [bkNext, bkCancel]
      Caption = 'JvWizardWelcomePage1'
      inline WahlverfahrenFrame1: TWahlverfahrenFrame
        Left = 164
        Top = 70
        Width = 592
        Height = 442
        Align = alClient
        TabOrder = 0
        ExplicitLeft = 164
        ExplicitTop = 70
        ExplicitWidth = 592
        ExplicitHeight = 442
        inherited RadioGroup1: TRadioGroup
          Width = 592
          ExplicitTop = 0
          ExplicitWidth = 592
        end
        inherited RichEdit1: TRichEdit
          Width = 592
          Height = 385
          StyleElements = [seFont, seClient, seBorder]
          ExplicitWidth = 592
          ExplicitHeight = 385
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
      EnabledButtons = [bkBack, bkFinish, bkCancel]
      Caption = 'JvWizardInteriorPage1'
      OnEnterPage = JvWizardInteriorPage1EnterPage
      OnFinishButtonClick = JvWizardInteriorPage1FinishButtonClick
      inline WahlfristenFrame1: TWahlfristenFrame
        Left = 0
        Top = 70
        Width = 756
        Height = 442
        Align = alClient
        TabOrder = 0
        ExplicitTop = 70
        ExplicitWidth = 756
        ExplicitHeight = 442
        inherited Splitter1: TSplitter
          Width = 756
          ExplicitWidth = 756
        end
        inherited Chart1: TChart
          Width = 756
          Height = 182
          ExplicitWidth = 756
          ExplicitHeight = 182
        end
        inherited GroupBox1: TGroupBox
          Width = 756
          ExplicitWidth = 756
          inherited LV: TListView
            Width = 752
            ExplicitTop = 19
            ExplicitWidth = 752
          end
          inherited Panel1: TPanel
            Width = 752
            StyleElements = [seFont, seClient, seBorder]
            ExplicitWidth = 752
          end
        end
      end
    end
  end
end
