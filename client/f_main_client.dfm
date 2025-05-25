object MainClientForm: TMainClientForm
  Left = 0
  Top = 0
  Caption = 'MitbestimmIT Client VCL'
  ClientHeight = 623
  ClientWidth = 980
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
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
      Caption = 'Wahl'
      object Planen1: TMenuItem
        Action = ac_wa_plan
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object Wahlberechtigteaktualisieren1: TMenuItem
        Action = ac_wa_berechtigte
      end
      object Wahlvorstand1: TMenuItem
        Action = ac_wa_vorstand
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Wahllisten1: TMenuItem
        Action = ac_wa_listen
      end
    end
    object Wahlbuero1: TMenuItem
      Caption = 'Wahllokal'
      object Rume1: TMenuItem
        Action = ac_rooms
      end
      object Wahlhelfer1: TMenuItem
        Action = ac_helper
      end
    end
    object Briefwahl1: TMenuItem
      Caption = 'Briefwahl'
    end
    object Auszhlung1: TMenuItem
      Caption = 'Ausz'#228'hlung'
    end
    object Windows1: TMenuItem
      Caption = 'Windows'
      object Info1: TMenuItem
        Action = ac_info
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
      Category = 'Wahl'
      Caption = 'Planen'
      OnExecute = ac_wa_planExecute
    end
    object ac_rooms: TAction
      Category = 'Wahlb'#252'ro'
      Caption = 'R'#228'ume'
      OnExecute = ac_roomsExecute
    end
    object ac_helper: TAction
      Category = 'Wahlb'#252'ro'
      Caption = 'Wahlhelfer'
      OnExecute = ac_helperExecute
    end
    object ac_wa_berechtigte: TAction
      Category = 'Wahl'
      Caption = 'Wahlberechtigte aktualisieren'
      OnExecute = ac_wa_berechtigteExecute
    end
    object ac_wa_listen: TAction
      Category = 'Wahl'
      Caption = 'Wahllisten'
    end
    object ac_wa_vorstand: TAction
      Category = 'Wahl'
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
