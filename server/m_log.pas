unit m_log;

interface

uses
  System.Classes, FireDAC.Stan.Intf, FireDAC.Stan.Option,
  FireDAC.Stan.Param, FireDAC.Stan.Error, FireDAC.DatS, FireDAC.Phys.Intf,
  FireDAC.DApt.Intf, FireDAC.Stan.Async, FireDAC.DApt, Data.DB,
  FireDAC.Comp.DataSet, FireDAC.Comp.Client;

type
  TLogMod = class(TDataModule)
    AddLogQry: TFDQuery;
  private
    { Private-Deklarationen }
  public
    procedure addLog( wahl : boolean; titel, text : string; id : integer; user : string );
  end;

procedure CreateLogthread;
procedure EndLogThread;
procedure Savelog( wahl : boolean; title, text : string );

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

uses
  m_db, System.SysUtils, Datasnap.DSSession, LogThread;

{$R *.dfm}

{ TLogMod }

var
  LogMod: TLogMod;
  m_logger : TLogThread;


procedure TLogMod.addLog(wahl : boolean; titel, text: string; id : integer; user : string);
begin
  if wahl then
  begin
    AddLogQry.ParamByName('WA_ID').AsInteger := id;
    AddLogQry.ParamByName('LG_DATA').AsString := text;
    AddLogQry.ParamByName('LG_USER').AsString := user;
    AddLogQry.ParamByName('LG_TITEL').AsString:= titel;
    AddLogQry.ExecSQL;

    AddLogQry.close;
  end;
end;

procedure doSaveLog( wahl : boolean; title, text : string; id : integer; user : string );
begin
  if Assigned(LogMod) then
    LogMod.addLog(wahl, title, text, id, user);
end;

procedure Savelog( wahl : boolean; title, text : string );
var
  session : TDSSession;
  id : integer;
  user : string;
begin
  id := 0;
  user := '';

  session := TDSSessionManager.GetThreadSession;
  if Assigned(session) then
  begin
    id := DBMod.WahlID;
    user := TDSSessionManager.GetThreadSession.getData('UserName' );
  end;
  m_logger.AddLog(wahl, title, text, id, user);
end;

procedure CreateLogthread;
begin
  LogMod :=  TLogMod.Create(nil);
  m_logger := TLogThread.Create(doSaveLog);
end;

procedure EndLogThread;
begin
  m_logger.EndLog;
  m_logger := NIL;
  LogMod.Free;
  LogMod := NIL;
end;





end.
