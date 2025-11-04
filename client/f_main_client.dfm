object MainClientForm: TMainClientForm
  Left = 0
  Top = 0
  HelpType = htKeyword
  HelpContext = 1
  Caption = 'MitbestimmIT Client VCL'
  ClientHeight = 623
  ClientWidth = 980
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
    Width = 980
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
  object StatusBar1: TStatusBar
    Left = 0
    Top = 604
    Width = 980
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
  object MainMenu1: TMainMenu
    Left = 24
    Top = 24
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
    end
    object Wahl2: TMenuItem
      Caption = 'Wahl'
      object Wahllisten1: TMenuItem
        Caption = 'Wahllisten'
      end
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
    Left = 128
    Top = 32
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
  end
  object Timer1: TTimer
    Enabled = False
    Interval = 250
    OnTimer = Timer1Timer
    Left = 216
    Top = 32
  end
end
