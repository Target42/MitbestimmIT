unit f_splash;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls;
  {
    TSplashform:
    Diese Klasse repräsentiert ein Splash-Screen-Formular in der Anwendung. Sie enthält visuelle Komponenten wie ein Bild und Labels,
    sowie einen Timer, um das Verhalten des Splash-Screens zu steuern.

    Komponenten:
    - Image1: Eine TImage-Komponente, die ein Bild auf dem Splash-Screen anzeigt.
    - Label1: Eine TLabel-Komponente, die Text auf dem Splash-Screen anzeigt.
    - Label2: Eine TLabel-Komponente, die zusätzlichen Text auf dem Splash-Screen anzeigt.
    - Timer1: Eine TTimer-Komponente, die zeitgesteuerte Ereignisse verwaltet, wie z. B. das Schließen des Splash-Screens nach einer bestimmten Dauer.
    - Label3: Eine TLabel-Komponente, die weitere Informationen oder Status auf dem Splash-Screen anzeigt.

    Methoden:
    - Timer1Timer(Sender: TObject): Ereignisbehandler für die Timer1-Komponente. Diese Methode wird ausgelöst, wenn der Timer abläuft.
  }

type
  TSplashform = class(TForm)
    Image1: TImage;
    Timer1: TTimer;
    procedure Timer1Timer(Sender: TObject);
  private
    { Private-Deklarationen }
  public
    { Public-Deklarationen }
  end;

var
  Splashform: TSplashform;

implementation

{$R *.dfm}

procedure TSplashform.Timer1Timer(Sender: TObject);
begin
  Splashform.Free;
end;

end.
