object MainSetupForm: TMainSetupForm
  Left = 0
  Top = 0
  ActiveControl = CheckBox1
  Caption = 'MitbestimmIT-Server-Setup'
  ClientHeight = 498
  ClientWidth = 707
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
    Width = 707
    Height = 19
    Panels = <>
  end
  object JvWizard1: TJvWizard
    Left = 0
    Top = 0
    Width = 707
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
    DesignSize = (
      707
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
      Caption = 'JvWizardWelcomePage1'
      object Panel1: TPanel
        Left = 164
        Top = 396
        Width = 543
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
        Width = 543
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
            '/gpl-3.0.txt abrufbar]')
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
      Caption = 'JvWizardInteriorPage1'
      OnNextButtonClick = JvWizardInteriorPage1NextButtonClick
      ExplicitWidth = 0
      ExplicitHeight = 0
      object GroupBox1: TGroupBox
        Left = 0
        Top = 70
        Width = 707
        Height = 83
        Align = alTop
        Caption = 'Zielpfad'
        TabOrder = 0
        DesignSize = (
          707
          83)
        object SpeedButton1: TSpeedButton
          Left = 672
          Top = 35
          Width = 23
          Height = 22
          Action = BrowseForFolder1
          Anchors = [akTop, akRight]
          Images = PngImageList1
        end
        object Edit1: TEdit
          Left = 16
          Top = 34
          Width = 641
          Height = 23
          TabOrder = 0
          Text = 'Edit1'
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
      Caption = 'JvWizardInteriorPage2'
      OnNextButtonClick = JvWizardInteriorPage2NextButtonClick
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
        Width = 707
        Height = 367
        Align = alClient
        TabOrder = 0
        ExplicitTop = 70
        ExplicitWidth = 707
        ExplicitHeight = 367
        inherited GroupBox1: TGroupBox
          Width = 707
          ExplicitWidth = 707
          inherited LabeledEdit1: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited LabeledEdit2: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
        end
        inherited GroupBox2: TGroupBox
          Width = 707
          ExplicitWidth = 707
          inherited Image1: TImage
            Left = 443
            ExplicitLeft = 443
          end
          inherited Splitter1: TSplitter
            Left = 440
            ExplicitLeft = 440
          end
          inherited Panel1: TPanel
            Width = 438
            StyleElements = [seFont, seClient, seBorder]
            ExplicitWidth = 438
            inherited Label1: TLabel
              Width = 398
              Height = 30
              StyleElements = [seFont, seClient, seBorder]
              ExplicitWidth = 398
              ExplicitHeight = 30
            end
            inherited Label2: TLabel
              Top = 89
              StyleElements = [seFont, seClient, seBorder]
              ExplicitTop = 89
            end
            inherited CodeLab: TLabel
              Top = 59
              StyleElements = [seFont, seClient, seBorder]
              ExplicitTop = 59
            end
            inherited CheckBox1: TCheckBox
              Width = 432
              ExplicitWidth = 432
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
      Caption = 'JvWizardInteriorPage3'
      ExplicitWidth = 0
      ExplicitHeight = 0
      inline DatabaseFrame1: TDatabaseFrame
        Left = 0
        Top = 70
        Width = 707
        Height = 367
        Align = alClient
        TabOrder = 0
        ExplicitTop = 70
        ExplicitWidth = 707
        ExplicitHeight = 367
        inherited RadioGroup1: TRadioGroup
          Width = 707
          ExplicitWidth = 707
        end
        inherited GroupBox1: TGroupBox
          Width = 707
          ExplicitWidth = 707
          inherited LabeledEdit1: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited LabeledEdit2: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
        end
        inherited GroupBox2: TGroupBox
          Width = 707
          ExplicitWidth = 707
          inherited LabeledEdit3: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
        end
        inherited GroupBox3: TGroupBox
          Width = 707
          ExplicitWidth = 707
          inherited LabeledEdit4: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
        end
        inherited GroupBox4: TGroupBox
          Width = 707
          ExplicitWidth = 707
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
      inline ZertifikatFrame1: TZertifikatFrame
        Left = 0
        Top = 70
        Width = 707
        Height = 367
        Align = alClient
        TabOrder = 0
        ExplicitTop = 70
        ExplicitWidth = 707
        ExplicitHeight = 367
        inherited GroupBox1: TGroupBox
          Width = 707
          ExplicitWidth = 707
          inherited LabeledEdit1: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
          inherited LabeledEdit2: TLabeledEdit
            StyleElements = [seFont, seClient, seBorder]
          end
        end
        inherited GroupBox2: TGroupBox
          Width = 707
          Height = 262
          ExplicitTop = 105
          ExplicitWidth = 707
          ExplicitHeight = 262
          inherited Memo1: TMemo
            Width = 703
            Height = 243
            StyleElements = [seFont, seClient, seBorder]
            ExplicitLeft = 2
            ExplicitTop = 17
            ExplicitWidth = 703
            ExplicitHeight = 243
          end
        end
      end
    end
  end
  object ActionList1: TActionList
    Images = PngImageList1
    Left = 48
    Top = 176
    object BrowseForFolder1: TBrowseForFolder
      Category = 'Datei'
      Caption = 'BrowseForFolder1'
      DialogCaption = 'BrowseForFolder1'
      BrowseOptions = []
      BrowseOptionsEx = []
      ImageIndex = 0
      OnAccept = BrowseForFolder1Accept
    end
  end
  object PngImageList1: TPngImageList
    PngImages = <
      item
        Background = clWindow
        Name = 'Folder Tree_16px'
        PngImage.Data = {
          89504E470D0A1A0A0000000D49484452000000100000001008060000001FF3FF
          6100000006624B474400FF00FF00FFA0BDA7930000010F4944415478DA6364A0
          10308288FF8B18B819FE32B803998F1913194E936EC07ABE5C067EFE4940DE7F
          0626A6F760995F3F3732BABE4822CE80EDE27D0CC282852832DFBE3D61747824
          4B2703B68A7A307073CEFAF39F8D0BC46761FCF59DE1D7EF1D8C6ECF53C1F2F3
          1992802A23811E9C0E0CA3751806C0C084A5EB4241744174D06A64F1FF7BA4EF
          30F0F12AA358FDE65D09A3D7AB5E4C03FE3380BCF204593C4BBAC295959B4900
          C580B7EFFB193D5F1611E78203728F18B8B850C3E3FD871E46F717A5C419B04D
          C49E8185C51CC580FFFF1730BABF7C459C01740D44A080C57F068613C8E239D2
          255398B9D8C40806E2A4256B65FE31325A32A0815CA992C94CDC6CE204031117
          203A10C90100C51585114EE523620000000049454E44AE426082}
      end>
    Left = 32
    Top = 24
  end
end
