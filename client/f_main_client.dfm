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
  TextHeight = 15
  object StatusBar1: TStatusBar
    Left = 0
    Top = 604
    Width = 980
    Height = 19
    Panels = <>
  end
  object MainMenu1: TMainMenu
    Left = 24
    Top = 24
    object Programm1: TMenuItem
      Caption = 'Programm'
      object Programm2: TMenuItem
        Action = FileExit1
      end
    end
    object Wahl1: TMenuItem
      Caption = 'Wahl'
      object Planen1: TMenuItem
        Action = ac_wa_plan
      end
    end
    object Wahlbro1: TMenuItem
      Caption = 'Wahlb'#252'ro'
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
    Left = 96
    Top = 16
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
  end
end
