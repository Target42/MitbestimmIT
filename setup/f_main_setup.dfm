object MainSetupForm: TMainSetupForm
  Left = 0
  Top = 0
  ActiveControl = CheckBox1
  Caption = 'MitbestimmIT-Server-Setup'
  ClientHeight = 498
  ClientWidth = 754
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object StatusBar1: TStatusBar
    Left = 0
    Top = 479
    Width = 754
    Height = 19
    Panels = <>
  end
  object JvWizard1: TJvWizard
    Left = 0
    Top = 0
    Width = 754
    Height = 479
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
    OnFinishButtonClick = JvWizard1FinishButtonClick
    OnCancelButtonClick = JvWizard1CancelButtonClick
    OnHelpButtonClick = JvWizard1HelpButtonClick
    DesignSize = (
      754
      479)
    object JvWizardWelcomePage1: TJvWizardWelcomePage
      Header.Title.Color = clNone
      Header.Title.Text = 'Setup MitbestimmIT-Server'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'Segoe UI'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Einrichtung des MitbestimmIT-Servers'#13#10
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -12
      Header.Subtitle.Font.Name = 'Segoe UI'
      Header.Subtitle.Font.Style = []
      VisibleButtons = [bkBack, bkNext, bkCancel, bkHelp]
      Caption = 'JvWizardWelcomePage1'
      OnCancelButtonClick = JvWizardWelcomePage1CancelButtonClick
      OnFinishButtonClick = JvWizardWelcomePage1FinishButtonClick
      OnHelpButtonClick = JvWizardWelcomePage1HelpButtonClick
      object Panel1: TPanel
        Left = 164
        Top = 396
        Width = 590
        Height = 41
        Align = alBottom
        BevelOuter = bvNone
        Caption = 'Panel1'
        ShowCaption = False
        TabOrder = 0
        object CheckBox1: TCheckBox
          Left = 24
          Top = 8
          Width = 129
          Height = 17
          Caption = 'Lizenz akzeptiert'
          TabOrder = 0
          OnClick = CheckBox1Click
        end
      end
      object Memo1: TMemo
        Left = 164
        Top = 70
        Width = 590
        Height = 326
        Align = alClient
        Lines.Strings = (
          #10'                    GNU GENERAL PUBLIC LICENSE'#10'                '
          '       Version 3, 29 June 2007'#10#10' Copyright (C) 2007 '
          ''
          'Free Software Foundation, Inc. <https://fsf.org/>'#10' '
          'Everyone is permitted to copy and distribute verbatim copies'#10' '
          'of this license document, but changing it is not allowed.'#10#10
          '                            Preamble'#10#10
          'The GNU General Public License is a free, copyleft license for'#10
          'software and other kinds of works.'#10
          ''
          
            #10'[Die vollst'#228'ndige Lizenz ist unter https://www.gnu.org/licenses' +
            '/gpl-3.0.txt abrufbar]'
          ''
          ''
          'Achtung:'
          'Ein FireBird 4.x-Server muss installiert sein')
        TabOrder = 1
      end
    end
    object JvWizardInteriorPage1: TJvWizardInteriorPage
      Header.Title.Color = clNone
      Header.Title.Text = 'Grundlagen'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'Segoe UI'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Einrichtug, Pfad, Passwort und Datenbank'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -12
      Header.Subtitle.Font.Name = 'Segoe UI'
      Header.Subtitle.Font.Style = []
      VisibleButtons = [bkBack, bkNext, bkCancel, bkHelp]
      Caption = 'JvWizardInteriorPage1'
      OnNextButtonClick = JvWizardInteriorPage1NextButtonClick
      OnCancelButtonClick = JvWizardWelcomePage1CancelButtonClick
      OnHelpButtonClick = JvWizardWelcomePage1HelpButtonClick
      inline FilesFrame1: TFilesFrame
        Left = 0
        Top = 70
        Width = 754
        Height = 367
        Align = alClient
        TabOrder = 0
        ExplicitTop = 70
        ExplicitWidth = 754
        ExplicitHeight = 367
        inherited GroupBox1: TGroupBox
          Width = 754
          ExplicitWidth = 754
          inherited SpeedButton1: TSpeedButton
            Left = 719
            ExplicitLeft = 719
          end
          inherited Edit1: TEdit
            Width = 824
            StyleElements = [seFont, seClient, seBorder]
            ExplicitWidth = 824
          end
        end
        inherited GroupBox2: TGroupBox
          Width = 754
          Height = 284
          ExplicitWidth = 754
          ExplicitHeight = 284
          inherited Memo1: TMemo
            Width = 750
            Height = 265
            StyleElements = [seFont, seClient, seBorder]
            ExplicitWidth = 750
            ExplicitHeight = 265
          end
        end
      end
    end
    object JvWizardInteriorPage6: TJvWizardInteriorPage
      Header.Title.Color = clNone
      Header.Title.Text = 'Vorraussetzungen'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'Segoe UI'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Dinge, die f'#252'r die Installation ben'#246'tigt werden'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -12
      Header.Subtitle.Font.Name = 'Segoe UI'
      Header.Subtitle.Font.Style = []
      VisibleButtons = [bkBack, bkNext, bkCancel, bkHelp]
      Caption = 'JvWizardInteriorPage6'
      OnCancelButtonClick = JvWizardWelcomePage1CancelButtonClick
      OnHelpButtonClick = JvWizardWelcomePage1HelpButtonClick
      inline PreFrame1: TPreFrame
        Left = 0
        Top = 70
        Width = 754
        Height = 367
        Align = alClient
        TabOrder = 0
        ExplicitTop = 70
        ExplicitWidth = 754
        ExplicitHeight = 367
        inherited RichEdit1: TRichEdit
          Width = 754
          Height = 367
          StyleElements = [seFont, seClient, seBorder]
          ExplicitWidth = 754
          ExplicitHeight = 367
        end
      end
    end
    object JvWizardInteriorPage7: TJvWizardInteriorPage
      Header.Title.Color = clNone
      Header.Title.Text = 'Port-Check'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'Segoe UI'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Testen der kommunikationsports'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -12
      Header.Subtitle.Font.Name = 'Segoe UI'
      Header.Subtitle.Font.Style = []
      VisibleButtons = [bkBack, bkNext, bkCancel, bkHelp]
      Caption = 'JvWizardInteriorPage7'
      OnNextButtonClick = JvWizardInteriorPage7NextButtonClick
      OnCancelButtonClick = JvWizardWelcomePage1CancelButtonClick
      OnHelpButtonClick = JvWizardWelcomePage1HelpButtonClick
      inline PortCheckFrame1: TPortCheckFrame
        Left = 0
        Top = 70
        Width = 754
        Height = 367
        Align = alClient
        TabOrder = 0
        ExplicitTop = 70
        ExplicitWidth = 754
        ExplicitHeight = 367
        inherited GroupBox1: TGroupBox
          Width = 754
          ExplicitWidth = 754
          inherited Label1: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited Label4: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited SpinEdit1: TSpinEdit
            StyleElements = [seFont, seClient, seBorder]
          end
        end
        inherited GroupBox2: TGroupBox
          Width = 754
          ExplicitWidth = 754
          inherited Label3: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited Label6: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited SpinEdit3: TSpinEdit
            StyleElements = [seFont, seClient, seBorder]
          end
        end
        inherited GroupBox3: TGroupBox
          Width = 754
          ExplicitWidth = 754
          inherited Label2: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited Label5: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited SpinEdit2: TSpinEdit
            StyleElements = [seFont, seClient, seBorder]
          end
        end
        inherited GroupBox4: TGroupBox
          Width = 754
          ExplicitWidth = 754
          inherited Label7: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited Label8: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited SpinEdit4: TSpinEdit
            StyleElements = [seFont, seClient, seBorder]
          end
        end
        inherited Panel1: TPanel
          Width = 754
          StyleElements = [seFont, seClient, seBorder]
          ExplicitTop = 289
          ExplicitWidth = 754
        end
        inherited IdTCPServer1: TIdTCPServer
          DefaultPort = 80
        end
      end
    end
    object JvWizardInteriorPage2: TJvWizardInteriorPage
      Header.Title.Color = clNone
      Header.Title.Text = 'Administratoreinstellungen'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'Segoe UI'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Passwort und 2 Faktorauthentifizierung'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -12
      Header.Subtitle.Font.Name = 'Segoe UI'
      Header.Subtitle.Font.Style = []
      VisibleButtons = [bkBack, bkNext, bkCancel, bkHelp]
      Caption = 'JvWizardInteriorPage2'
      OnEnterPage = JvWizardInteriorPage2EnterPage
      OnNextButtonClick = JvWizardInteriorPage2NextButtonClick
      OnCancelButtonClick = JvWizardWelcomePage1CancelButtonClick
      OnHelpButtonClick = JvWizardWelcomePage1HelpButtonClick
      object Label1: TLabel
        Left = 168
        Top = 280
        Width = 34
        Height = 15
        Caption = 'Label1'
      end
      inline AdminFrame1: TAdminFrame
        Left = 0
        Top = 70
        Width = 754
        Height = 367
        Align = alClient
        TabOrder = 0
        ExplicitTop = 70
        ExplicitWidth = 754
        ExplicitHeight = 367
        inherited GroupBox1: TGroupBox
          Width = 754
          ExplicitWidth = 754
          inherited LabeledEdit1: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited LabeledEdit2: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
        end
        inherited GroupBox2: TGroupBox
          Width = 754
          ExplicitWidth = 754
          inherited Image1: TImage
            Left = 490
            ExplicitLeft = 443
          end
          inherited Splitter1: TSplitter
            Left = 487
            ExplicitLeft = 440
          end
          inherited Panel1: TPanel
            Width = 485
            StyleElements = [seFont, seClient, seBorder]
            ExplicitLeft = 2
            ExplicitTop = 17
            ExplicitWidth = 485
            inherited Label1: TLabel
              Width = 479
              Height = 30
              StyleElements = [seFont, seClient, seBorder]
              ExplicitWidth = 469
              ExplicitHeight = 30
            end
            inherited Label2: TLabel
              Top = 89
              Width = 485
              StyleElements = [seFont, seClient, seBorder]
              ExplicitTop = 89
            end
            inherited CodeLab: TLabel
              Top = 59
              Width = 485
              StyleElements = [seFont, seClient, seBorder]
              ExplicitTop = 59
            end
            inherited CheckBox1: TCheckBox
              Width = 479
              ExplicitWidth = 479
            end
          end
        end
      end
    end
    object JvWizardInteriorPage3: TJvWizardInteriorPage
      Header.Title.Color = clNone
      Header.Title.Text = 'Datenbank'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'Segoe UI'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Erstellen der Datenbank'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -12
      Header.Subtitle.Font.Name = 'Segoe UI'
      Header.Subtitle.Font.Style = []
      VisibleButtons = [bkBack, bkNext, bkCancel, bkHelp]
      Caption = 'JvWizardInteriorPage3'
      OnNextButtonClick = JvWizardInteriorPage3NextButtonClick
      OnCancelButtonClick = JvWizardWelcomePage1CancelButtonClick
      OnHelpButtonClick = JvWizardWelcomePage1HelpButtonClick
      inline DatabaseFrame1: TDatabaseFrame
        Left = 0
        Top = 70
        Width = 754
        Height = 367
        Align = alClient
        TabOrder = 0
        ExplicitTop = 70
        ExplicitWidth = 754
        ExplicitHeight = 367
        inherited RadioGroup1: TRadioGroup
          Width = 754
          ExplicitWidth = 754
        end
        inherited GroupBox1: TGroupBox
          Width = 754
          ExplicitWidth = 754
          inherited LabeledEdit1: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited LabeledEdit2: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
        end
        inherited GroupBox2: TGroupBox
          Width = 754
          ExplicitWidth = 754
          inherited LabeledEdit3: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited LabeledEdit4: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
        end
        inherited GroupBox4: TGroupBox
          Width = 754
          ExplicitWidth = 754
          inherited Label1: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited BitBtn1: TBitBtn
            ImageIndex = 0
            Images = PngImageList1
          end
        end
      end
    end
    object JvWizardInteriorPage4: TJvWizardInteriorPage
      Header.Title.Color = clNone
      Header.Title.Text = 'Zertifikate'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'Segoe UI'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Erzeugen selbst erstellter Zertifikate f'#252'r HTTPS'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -12
      Header.Subtitle.Font.Name = 'Segoe UI'
      Header.Subtitle.Font.Style = []
      Caption = 'JvWizardInteriorPage4'
      OnNextButtonClick = JvWizardInteriorPage4NextButtonClick
      OnCancelButtonClick = JvWizardWelcomePage1CancelButtonClick
      OnHelpButtonClick = JvWizardWelcomePage1HelpButtonClick
      inline ZertifikatFrame1: TZertifikatFrame
        Left = 0
        Top = 70
        Width = 754
        Height = 367
        Align = alClient
        TabOrder = 0
        ExplicitTop = 70
        ExplicitWidth = 754
        ExplicitHeight = 367
        inherited GroupBox1: TGroupBox
          Width = 754
          ExplicitWidth = 754
          inherited LabeledEdit1: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited LabeledEdit2: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited LabeledEdit3: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited LabeledEdit4: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
        end
        inherited RadioGroup1: TRadioGroup
          Width = 754
          ExplicitWidth = 754
        end
        inherited GroupBox2: TGroupBox
          Width = 754
          Height = 262
          ExplicitWidth = 754
          ExplicitHeight = 262
          inherited Label1: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
        end
      end
    end
    object JvWizardInteriorPage5: TJvWizardInteriorPage
      Header.Title.Color = clNone
      Header.Title.Text = 'Mailserver'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'Segoe UI'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = #220'ber den Mailserver werden wichtige Logs verschickt'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -12
      Header.Subtitle.Font.Name = 'Segoe UI'
      Header.Subtitle.Font.Style = []
      VisibleButtons = [bkBack, bkNext, bkCancel, bkHelp]
      Caption = 'JvWizardInteriorPage5'
      OnNextButtonClick = JvWizardInteriorPage5NextButtonClick
      OnCancelButtonClick = JvWizardWelcomePage1CancelButtonClick
      OnHelpButtonClick = JvWizardWelcomePage1HelpButtonClick
      inline MailFrame1: TMailFrame
        Left = 0
        Top = 70
        Width = 754
        Height = 367
        Align = alClient
        TabOrder = 0
        ExplicitTop = 70
        ExplicitWidth = 754
        ExplicitHeight = 367
        inherited GroupBox1: TGroupBox
          Width = 754
          ExplicitWidth = 754
          inherited Label1: TLabel
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited LabeledEdit1: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited LabeledEdit2: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited LabeledEdit3: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited LabeledEdit4: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited ComboBox1: TComboBox
            StyleElements = [seFont, seClient, seBorder]
          end
        end
        inherited GroupBox2: TGroupBox
          Width = 754
          Height = 182
          ExplicitWidth = 754
          ExplicitHeight = 182
          inherited Panel1: TPanel
            Width = 750
            StyleElements = [seFont, seClient, seBorder]
            ExplicitWidth = 750
            inherited LabeledEdit5: TLabeledEdit
              StyleElements = [seFont, seClient, seBorder]
            end
          end
          inherited Memo1: TMemo
            Width = 750
            Height = 99
            StyleElements = [seFont, seClient, seBorder]
            ExplicitWidth = 750
            ExplicitHeight = 99
          end
        end
      end
    end
    object JvWizardInteriorPage8: TJvWizardInteriorPage
      Header.Title.Color = clNone
      Header.Title.Text = 'Server'
      Header.Title.Anchors = [akLeft, akTop, akRight]
      Header.Title.Font.Charset = DEFAULT_CHARSET
      Header.Title.Font.Color = clWindowText
      Header.Title.Font.Height = -16
      Header.Title.Font.Name = 'Segoe UI'
      Header.Title.Font.Style = [fsBold]
      Header.Subtitle.Color = clNone
      Header.Subtitle.Text = 'Allgemeine Einstellungen f'#252'r den Server'
      Header.Subtitle.Anchors = [akLeft, akTop, akRight, akBottom]
      Header.Subtitle.Font.Charset = DEFAULT_CHARSET
      Header.Subtitle.Font.Color = clWindowText
      Header.Subtitle.Font.Height = -12
      Header.Subtitle.Font.Name = 'Segoe UI'
      Header.Subtitle.Font.Style = []
      VisibleButtons = [bkFinish, bkHelp]
      Caption = 'JvWizardInteriorPage8'
      OnEnterPage = JvWizardInteriorPage8EnterPage
      OnCancelButtonClick = JvWizardWelcomePage1CancelButtonClick
      OnFinishButtonClick = JvWizardInteriorPage8FinishButtonClick
      OnHelpButtonClick = JvWizardWelcomePage1HelpButtonClick
      inline ServerFrame1: TServerFrame
        Left = 0
        Top = 70
        Width = 754
        Height = 367
        Align = alClient
        TabOrder = 0
        ExplicitTop = 70
        ExplicitWidth = 754
        ExplicitHeight = 367
        inherited Splitter1: TSplitter
          Height = 367
          ExplicitHeight = 367
        end
        inherited GroupBox1: TGroupBox
          Height = 367
          ExplicitHeight = 367
          inherited LV: TListView
            Height = 307
            ExplicitHeight = 307
          end
          inherited Panel2: TPanel
            Top = 324
            StyleElements = [seFont, seClient, seBorder]
            ExplicitTop = 324
          end
        end
        inherited GroupBox2: TGroupBox
          Width = 438
          Height = 367
          ExplicitWidth = 438
          ExplicitHeight = 367
          inherited Splitter2: TSplitter
            Top = 180
            Width = 434
            ExplicitTop = 180
            ExplicitWidth = 434
          end
          inherited GroupBox3: TGroupBox
            Top = 183
            Width = 434
            ExplicitTop = 183
            ExplicitWidth = 434
            inherited Memo1: TMemo
              Width = 430
              StyleElements = [seFont, seClient, seBorder]
              ExplicitWidth = 430
            end
          end
          inherited Panel1: TPanel
            Width = 434
            Height = 163
            StyleElements = [seFont, seClient, seBorder]
            ExplicitWidth = 434
            ExplicitHeight = 163
          end
        end
      end
    end
  end
  object PngImageList1: TPngImageList
    PngImages = <
      item
        Background = clWindow
        Name = 'Plus_16px'
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          6100000006624B474400FF00FF00FFA0BDA793000000E54944415478DA6364A0
          1030A20B04AE0B14FBCDF83F13C8F4066279A8F043C6FF8C5BFEFC6199BE3D6C
          F56B9C06F86EF08FFAFF9F711690C98DC3C22F0C8CFF53B6046C5C896180F7BA
          C05046C6FF2BB1B90A0DFC075A12B23568FD3AB8019EAB424599597FDF0132F9
          9055DA485B81E9234F8FA11BF281F53FA3CAFAA0F56FC106F8AE0F68FACFC050
          8BAE6A73C07AA8D702B1B9A4614BE08646B0013EEB022F02FDA647A201E78106
          18410C581FF01948F1C09C5D6E5A8AD5F39DA7BB91BDF31968001F950CA0D40B
          140722C5D1080214252418A02829C3005A66D2860A5F252A339103004DC68C11
          CCE2F5530000000049454E44AE426082}
      end
      item
        Background = clWindow
        Name = 'Approval_16px'
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          6100000006624B474400FF00FF00FFA0BDA7930000019F4944415478DA6364A0
          1030E2926838E3CBC5FDFDDF0410FB2B27534183C9E66F4419D07DD86B3B9032
          63F8FFFF3F0323A33054F80D103301F1C952DB6D5E380DE83DE869F88F89F10C
          543136F0EF3F13837199F5B60B2806CC3C63CCFAF1BBF85620C7198F66B0E2FF
          404380C49EAF7FBF7937381EF8037701D0E96F8194102ECDDC5C3C0C3A9AFA0C
          57AE5F64F8FAF5F3DB52BBED227017F41D0BE5FCFBF7EB5D2053129B663E5E3E
          067D6D13860F9FDE335CBD7191E1DFBFBFCFBEFEF9AE0C74C10FB001DD873C17
          00032C1EC46666666660676367F8F61D12E83CDCBC0C063A260C5FBE7E62B87C
          ED02C3DF7F7F21DE6164585062B32D9111EAFC45402A16C45656506390109762
          B878E52C4811833E48F3974F0C97AE9D07DAFC0FD9618B803112CF8888F3BF77
          405E60626202FB959F570014600C9F3E7F04FBFB1FD4662878CECCCCAD5C64B5
          FA3B7220BE07520210E73131686BE881C5AFDEB8044C12FFD04285E13DD07621
          BCD108720938E2FF6168C61E8D14252464803529FFFFFF16C806A9C59F949141
          C37E070E2E16CE8920F6B73FDFF341718E2B75520400ECA0B1116437FF650000
          000049454E44AE426082}
      end>
    Left = 448
    Top = 256
  end
end
