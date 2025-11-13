unit LogThread;

interface

uses
  System.Classes, System.Generics.Collections, System.SyncObjs, System.SysUtils;

type
  TLogEntry = record
    wahl : Boolean;
    id   : integer;
    user : string;
    Title: string;
    Text: string;
  end;

  TSaveLogFunc = procedure(wahl : Boolean; title : string; text : string; id :  integer; user :  string);

  TLogThread = class(TThread)
  private
    FLogQueue: TQueue<TLogEntry>;
    FCriticalSection: TCriticalSection;
    FLogAvailableEvent: TEvent; // NEU: Das Ereignis, das signalisiert, dass Logs da sind
    FSaveLogFunc: TSaveLogFunc;
    procedure DoExecute;
  protected
    procedure Execute; override;
  public
    constructor Create(SaveLogFunc: TSaveLogFunc); reintroduce;
    destructor Destroy; override;
    procedure AddLog(wahl :  boolean; title, text : string; id : integer; user : string);
    procedure EndLog;
  end;

implementation

{ TLogThread }

constructor TLogThread.Create(SaveLogFunc: TSaveLogFunc);
begin

  FreeOnTerminate := true;
  FSaveLogFunc := SaveLogFunc;
  FLogQueue := TQueue<TLogEntry>.Create;
  FCriticalSection := TCriticalSection.Create;

  FLogAvailableEvent := TEvent.Create(nil, True, false, '');

  inherited Create(False);
  Self.FreeOnTerminate := True;
end;

destructor TLogThread.Destroy;
begin
  FLogAvailableEvent.Free; // Event freigeben
  FLogQueue.Free;
  FCriticalSection.Free;
  inherited;
end;

// NEU: Überschreiben von Terminate für sauberes Aufwecken
procedure TLogThread.EndLog;
begin
  Terminate;
  // Wichtig: Das Event setzen, um den blockierten Wait-Aufruf sofort zu beenden!
  FLogAvailableEvent.SetEvent;
end;

procedure TLogThread.Execute;
begin
  // Solange der Thread nicht beendet werden soll
  while not Terminated do
  begin
    // Warten, bis das Event signalisiert wird (d.h. AddLog wurde aufgerufen)
    // INFINITE bedeutet, der Thread schläft, bis das Signal kommt
    if FLogAvailableEvent.WaitFor(100) = wrSignaled then
    begin
      FLogAvailableEvent.ResetEvent;
      DoExecute;
    end;

    if Terminated then
      Break;
  end;
end;

procedure TLogThread.DoExecute;
var
  LItem: TLogEntry;
  LItemAvailable: Boolean;
begin
  // Wir verarbeiten jetzt alle Elemente in einem Durchgang
  repeat
    LItemAvailable := False;

    // Kritischen Abschnitt betreten, um die Queue zu schützen
    FCriticalSection.Enter;
    try
      if FLogQueue.Count > 0 then
      begin
        LItem := FLogQueue.Dequeue;
        LItemAvailable := True;
      end;
    finally
      // Kritischen Abschnitt verlassen
      FCriticalSection.Leave;
    end;

    // Speichern außerhalb der kritischen Sektion
    if LItemAvailable then
    begin
      FSaveLogFunc(LItem.wahl, LItem.Title, LItem.Text, LItem.id, LItem.user);
    end;
  until not LItemAvailable;
end;

// Die Thread-safe Methode, um Log-Einträge hinzuzufügen
procedure TLogThread.AddLog(wahl :  boolean; title, text : string; id : integer; user : string);
var
  LEntry: TLogEntry;
begin
  LEntry.wahl  := wahl;
  LEntry.Title := title;
  LEntry.Text  := text;
  LEntry.id    := id;
  LEntry.user  := user;

  // Kritischen Abschnitt betreten, um die Queue zu schützen
  FCriticalSection.Enter;
  try
    FLogQueue.Enqueue(LEntry);
  finally
    FCriticalSection.Leave;
  end;

  // NEU: Das Event setzen, um den wartenden Thread sofort aufzuwecken!
  FLogAvailableEvent.SetEvent;
end;

end.
