object MainClientForm: TMainClientForm
  Left = 0
  Top = 0
  HelpType = htKeyword
  HelpContext = 1
  Caption = 'MitbestimmIT Client VCL'
  ClientHeight = 731
  ClientWidth = 1103
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  HelpFile = 'dummy.hlp'
  KeyPreview = True
  Menu = MainMenu1
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  TextHeight = 15
  object Label1: TLabel
    Left = 0
    Top = 0
    Width = 1103
    Height = 32
    Align = alTop
    Alignment = taCenter
    Caption = 'Label1'
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Segoe UI Semibold'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitWidth = 68
  end
  object Splitter1: TSplitter
    Left = 321
    Top = 32
    Height = 680
    Visible = False
    ExplicitLeft = 808
    ExplicitTop = 184
    ExplicitHeight = 100
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 712
    Width = 1103
    Height = 19
    Panels = <
      item
        Width = 50
      end
      item
        Width = 50
      end
      item
        Width = 50
      end>
  end
  object StatBox: TGroupBox
    Left = 0
    Top = 32
    Width = 321
    Height = 680
    Align = alLeft
    Caption = 'Daten'
    TabOrder = 1
    Visible = False
    inline StatFrame1: TStatFrame
      Left = 2
      Top = 17
      Width = 317
      Height = 661
      Align = alClient
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitTop = 17
      ExplicitWidth = 317
      ExplicitHeight = 661
      inherited Splitter1: TSplitter
        Width = 317
        ExplicitWidth = 317
      end
      inherited Splitter2: TSplitter
        Width = 317
        ExplicitWidth = 317
      end
      inherited Splitter3: TSplitter
        Width = 317
        ExplicitWidth = 317
      end
      inherited Splitter4: TSplitter
        Width = 317
        ExplicitWidth = 317
      end
      inherited GroupBox1: TGroupBox
        Width = 317
        ExplicitWidth = 317
        inherited Chart1: TChart
          Width = 313
          ExplicitLeft = 2
          ExplicitTop = 17
          ExplicitWidth = 313
          ExplicitHeight = 158
        end
      end
      inherited GroupBox2: TGroupBox
        Width = 317
        ExplicitTop = 180
        ExplicitWidth = 317
        inherited Label1: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited Gremium: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited Label2: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited Freistellungen: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited Label3: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited Minderheit: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited Label4: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
        inherited MinderheitnSitze: TLabel
          StyleElements = [seFont, seClient, seBorder]
        end
      end
      inherited GroupBox3: TGroupBox
        Width = 317
        ExplicitLeft = 0
        ExplicitTop = 303
        ExplicitWidth = 317
        inherited Wahllisten: TListView
          Width = 313
          ExplicitLeft = 2
          ExplicitTop = 17
          ExplicitWidth = 313
        end
      end
      inherited GroupBox4: TGroupBox
        Width = 317
        ExplicitLeft = 0
        ExplicitTop = 411
        ExplicitWidth = 317
        inherited Wahllokale: TListView
          Width = 313
          ExplicitTop = 17
          ExplicitWidth = 313
        end
      end
      inherited GroupBox5: TGroupBox
        Width = 317
        Height = 142
        ExplicitLeft = 0
        ExplicitTop = 519
        ExplicitWidth = 317
        ExplicitHeight = 142
        inherited Wahlphasen: TListView
          Width = 313
          Height = 123
          ExplicitWidth = 313
          ExplicitHeight = 123
        end
      end
    end
  end
  object MainMenu1: TMainMenu
    Left = 40
    Top = 96
    object Programm1: TMenuItem
      Caption = 'Programm'
      object Verbinden1: TMenuItem
        Action = ac_connect
      end
      object rennen1: TMenuItem
        Action = ac_disconnect
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object Programm2: TMenuItem
        Action = FileExit1
      end
    end
    object Wahl1: TMenuItem
      Caption = 'Vorbereitung'
      object Planen1: TMenuItem
        Action = ac_wa_plan
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Wahlberechtigteaktualisieren1: TMenuItem
        Action = ac_wa_berechtigte
      end
      object Whlerliste1: TMenuItem
        Action = ac_wa_waehlerliste
      end
      object N4: TMenuItem
        Caption = '-'
      end
      object Wahlvorstand1: TMenuItem
        Action = ac_wa_vorstand
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Wahllisten2: TMenuItem
        Action = ac_wahlliste
      end
      object N5: TMenuItem
        Caption = '-'
      end
      object Rume1: TMenuItem
        Action = ac_rooms
      end
      object N7: TMenuItem
        Caption = '-'
      end
      object Benutzerverwaltung1: TMenuItem
        Action = aC_wa_user
      end
    end
    object Wahl2: TMenuItem
      Caption = 'Wahl'
      object Briefwahl1: TMenuItem
        Action = ac_wa_brief
      end
    end
    object Auszhlung1: TMenuItem
      Caption = 'Ausz'#228'hlung'
    end
    object Admin1: TMenuItem
      Caption = 'Admin'
      object Wahlen1: TMenuItem
        Action = ac_ad_wahl
      end
    end
    object Windows1: TMenuItem
      Caption = 'Windows'
      object Info1: TMenuItem
        Action = ac_info
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object Fehler1: TMenuItem
        Action = ac_error
      end
    end
  end
  object ActionList1: TActionList
    Left = 104
    Top = 128
    object FileExit1: TFileExit
      Category = 'Datei'
      Caption = '&Beenden'
      Hint = 'Beenden|Anwendung beenden'
      ImageIndex = 43
    end
    object ac_info: TAction
      Category = 'Window'
      Caption = 'Info'
      OnExecute = ac_infoExecute
    end
    object ac_wa_plan: TAction
      Category = 'Vorbereitung'
      Caption = 'Planen'
      OnExecute = ac_wa_planExecute
    end
    object ac_rooms: TAction
      Category = 'Vorbereitung'
      Caption = 'Wahllokal'
      OnExecute = ac_roomsExecute
    end
    object ac_wa_berechtigte: TAction
      Category = 'Vorbereitung'
      Caption = 'Wahlberechtigte aktualisieren'
      OnExecute = ac_wa_berechtigteExecute
    end
    object ac_wa_vorstand: TAction
      Category = 'Vorbereitung'
      Caption = 'Wahlvorstand'
      OnExecute = ac_wa_vorstandExecute
    end
    object ac_connect: TAction
      Category = 'Datei'
      Caption = 'Verbinden'
      OnExecute = ac_connectExecute
    end
    object ac_disconnect: TAction
      Category = 'Datei'
      Caption = 'Trennen'
      OnExecute = ac_disconnectExecute
    end
    object ac_wa_waehlerliste: TAction
      Category = 'Vorbereitung'
      Caption = 'W'#228'hlerliste'
      OnExecute = ac_wa_waehlerlisteExecute
    end
    object ac_ad_wahl: TAction
      Category = 'Admin'
      Caption = 'Wahlen'
      OnExecute = ac_ad_wahlExecute
    end
    object ac_wa_brief: TAction
      Category = 'Wahl'
      Caption = 'Briefwahl'
      OnExecute = ac_wa_briefExecute
    end
    object ac_error: TAction
      Category = 'Window'
      Caption = 'Fehler'
      OnExecute = ac_errorExecute
    end
    object ac_wahlliste: TAction
      Category = 'Vorbereitung'
      Caption = 'Wahlisten'
      OnExecute = ac_wahllisteExecute
    end
    object aC_wa_user: TAction
      Caption = 'Benutzerverwaltung'
      OnExecute = aC_wa_userExecute
    end
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 250
    OnTimer = Timer1Timer
    Left = 184
    Top = 120
  end
  object ApplicationEvents1: TApplicationEvents
    OnMessage = ApplicationEvents1Message
    Left = 384
    Top = 120
  end
end
