object AuswertungForm: TAuswertungForm
  Left = 0
  Top = 0
  Caption = 'Wahlauswertung'
  ClientHeight = 478
  ClientWidth = 676
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  TextHeight = 15
  object StatusBar1: TStatusBar
    Left = 0
    Top = 459
    Width = 676
    Height = 19
    Panels = <>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 676
    Height = 459
    ActivePage = TabSheet2
    Align = alClient
    TabOrder = 1
    object TabSheet5: TTabSheet
      Caption = 'Allgemeines'
      object Label1: TLabel
        Left = 0
        Top = 0
        Width = 668
        Height = 285
        Align = alTop
        Caption = 
          'Bitte um Beachtung:'#13#10#13#10'1. Die Abgabe der Stimmzettel an der Urne' +
          ' m'#252'ssen beendet werden.'#13#10#13#10'2. Die eingegangenen Briefwahlunterla' +
          'gen m'#252'ssen gesichtet werden und die Umschl'#228'ge mit den Stimmzette' +
          'ln der g'#252'ltigen Briefw'#228'hler werden in die Urne geworfen. Doppelt' +
          'w'#228'hler werden vom Programm extra ausgewiesen, diese Unterlagen s' +
          'ind, wie die Ung'#252'ltigen, zu Archivieren.'#13#10#13#10'3. Die Auswertung de' +
          'r Wahl wird nun gesartet.'#13#10#13#10'4. Es werden alle Stimmzettel gepr'#252 +
          'ft ob sie ung'#252'ltig sind. '#13#10#13#10'5. Es ergibt sich eine Gesamtanzahl' +
          ' aus: G'#252'ltige Stimmen an der Urne + G'#252'ltige Briefwahlstimmen - B' +
          'riefwahlunterlagen von Doppeltw'#228'hlern - Ung'#252'ltige Stimmzettel. '#13 +
          #10#13#10'6. Es werden mindestens 2 Ausz'#228'hlungen vorgenommen. Durch den' +
          ' Einsatz eines Pagiernierstempels k'#246'nnen Erfassungsfehler leicht' +
          'er gefunden werden. '#13#10#13#10'7. Die auswertung wird beendet. '
        WordWrap = True
        ExplicitWidth = 667
      end
    end
    object TabSheet1: TTabSheet
      Caption = '1. Briefahlunterlagen'
      object BitBtn2: TBitBtn
        Left = 32
        Top = 33
        Width = 75
        Height = 25
        Caption = 'Starten'
        TabOrder = 0
        OnClick = BitBtn2Click
      end
      object BitBtn3: TBitBtn
        Left = 152
        Top = 33
        Width = 75
        Height = 25
        Caption = 'Beenden'
        TabOrder = 1
        OnClick = BitBtn3Click
      end
    end
    object TabSheet2: TTabSheet
      Caption = '2. Auswertung Starten'
      ImageIndex = 1
      object BitBtn1: TBitBtn
        Left = 32
        Top = 32
        Width = 75
        Height = 25
        Caption = 'Starten'
        Enabled = False
        TabOrder = 0
        OnClick = BitBtn1Click
      end
      object BitBtn4: TBitBtn
        Left = 152
        Top = 32
        Width = 75
        Height = 25
        Caption = 'Beenden'
        TabOrder = 1
      end
    end
    object TabSheet3: TTabSheet
      Caption = '3. Ausz'#228'hlungen'
      ImageIndex = 2
    end
    object TabSheet4: TTabSheet
      Caption = '4. Auswertung Beenden'
      ImageIndex = 3
    end
  end
  object DSProviderConnection1: TDSProviderConnection
    ServerClassName = 'TWahlMod'
    SQLConnection = GM.SQLConnection1
    Left = 504
    Top = 96
  end
end
