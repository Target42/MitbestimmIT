unit fr_portcheck;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Samples.Spin, IdBaseComponent, IdComponent, IdCustomTCPServer, IdTCPServer,
  IdContext;

type
  TPortCheckFrame = class(TFrame)
    GroupBox1: TGroupBox;
    SpinEdit1: TSpinEdit;
    BitBtn1: TBitBtn;
    GroupBox2: TGroupBox;
    BitBtn2: TBitBtn;
    GroupBox3: TGroupBox;
    BitBtn3: TBitBtn;
    IdTCPServer1: TIdTCPServer;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    SpinEdit3: TSpinEdit;
    SpinEdit2: TSpinEdit;
    GroupBox4: TGroupBox;
    SpinEdit4: TSpinEdit;
    BitBtn4: TBitBtn;
    Label7: TLabel;
    Label8: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure IdTCPServer1Execute(AContext: TIdContext);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure SpinEdit4Change(Sender: TObject);
  private
    m_ports : array[1..3] of Boolean;
  public
    procedure prepare;
    function isOk : boolean;
  end;

implementation

{$R *.dfm}

uses u_glob, System.Generics.Collections;

procedure TPortCheckFrame.BitBtn1Click(Sender: TObject);
var
  srv : TIdTCPServer;
  id  : integer;
  ok  : boolean;
  s   : string;
  col : Tcolor;
begin
  srv := TIdTCPServer.Create;

  srv.OnExecute := IdTCPServer1Execute;
  id  := (Sender as TBitBtn).Tag;
  col := clGreen;
  case id of
    1 : srv.DefaultPort := SpinEdit1.Value;
    2 : srv.DefaultPort := SpinEdit2.Value;
    3 : srv.DefaultPort := SpinEdit3.Value;
    4 : srv.DefaultPort := SpinEdit4.Value;
  end;

  try
    srv.Active := true;
    ok := true;
    s := 'Frei';
  except
    on e : exception do
    begin
      ok := false;
      s  := 'Belegt';
      col := clRed;
    end;
  end;
  srv.Free;

  case id of
    1 :
    begin
      Label1.Caption := s;
      Label1.Font.Color := col;
    end;
    2 :
    begin
      Label2.Caption := s;
      Label2.Font.Color := col;
    end;
    3 :
    begin
      Label3.Caption := s;
      Label3.Font.Color := col;
    end;
    4 :
    begin
      Label7.Caption := s;
      Label7.Font.Color := col;
    end;
  end;
  m_ports[id] := ok;

  if ok then
    ShowMessage('Der Port wurde erfolgreich getestet!')
  else
    ShowMessage('Dieser Port ist bereits belegt!');

end;

procedure TPortCheckFrame.IdTCPServer1Execute(AContext: TIdContext);
begin
//
end;

function TPortCheckFrame.isOk: boolean;
var
  i : integer;
  list : TList<Integer>;

  function add( port : integer ): boolean;
  begin
    Result := false;
    if list.IndexOf(port) = -1  then
    begin
      Result := true;
      list.Add(port);
    end;

  end;
begin
  Result := true;

  for i := low(m_ports) to High(m_ports) do
    Result := Result and m_ports[i];

  list := TList<Integer>.create;
  Result := result and add(SpinEdit1.Value);
  Result := result and add(SpinEdit2.Value);
  Result := result and add(SpinEdit3.Value);
  Result := result and add(SpinEdit4.Value);
  list.Free;


  if Result then
  begin
    Glob.PortDS    := SpinEdit1.Value;
    Glob.PortHttp  := SpinEdit2.Value;
    Glob.PortHttps := SpinEdit3.Value;
  end;

end;

procedure TPortCheckFrame.prepare;
var
  i : integer;
begin
  for i := low(m_ports) to High(m_ports) do
    m_ports[i] := false;

  SpinEdit1.Value := Glob.PortDS;
  SpinEdit2.Value := Glob.PortHttp;
  SpinEdit3.Value := Glob.PortHttps;
  SpinEdit4.Value := Glob.PortClientHttp;
end;

procedure TPortCheckFrame.SpinEdit1Change(Sender: TObject);
begin
  Label4.Caption := format('ds://%s:%d', [GetEnvironmentVariable('COMPUTERNAME'), SpinEdit1.Value]);

  if (SpinEdit1 .Value = SpinEdit2.Value) or ( SpinEdit1.Value = SpinEdit3.Value) or ( SpinEdit1.Value = SpinEdit4.Value) then
    ShowMessage('Achtung! Port doppelt belegt!')

end;

procedure TPortCheckFrame.SpinEdit2Change(Sender: TObject);
begin
  Label5.Caption := format('http://%s:%d', [GetEnvironmentVariable('COMPUTERNAME'), SpinEdit2.Value]);
  if (SpinEdit2.Value = SpinEdit1.Value) or ( SpinEdit2.Value = SpinEdit3.Value) or ( SpinEdit2.Value = SpinEdit4.Value) then
    ShowMessage('Achtung! Port doppelt belegt!')
end;

procedure TPortCheckFrame.SpinEdit3Change(Sender: TObject);
begin
  Label6.Caption := format('https://%s:%d', [GetEnvironmentVariable('COMPUTERNAME'), SpinEdit3.Value]);
  if (SpinEdit3.Value = SpinEdit1.Value) or ( SpinEdit3.Value = SpinEdit2.Value) or ( SpinEdit3.Value = SpinEdit4.Value) then
    ShowMessage('Achtung! Port doppelt belegt!')
end;

procedure TPortCheckFrame.SpinEdit4Change(Sender: TObject);
begin
  Label6.Caption := format('http://%s:%d', [GetEnvironmentVariable('COMPUTERNAME'), SpinEdit3.Value]);
  if (SpinEdit4.Value = SpinEdit1.Value) or ( SpinEdit4.Value = SpinEdit2.Value) or ( SpinEdit4.Value = SpinEdit3.Value) then
    ShowMessage('Achtung! Port doppelt belegt!')

end;

end.
