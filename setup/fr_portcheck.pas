unit fr_portcheck;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons,
  Vcl.Samples.Spin, IdBaseComponent, IdComponent, IdCustomTCPServer, IdTCPServer,
  IdContext, Vcl.ExtCtrls, Web.HTTPApp, Web.HTTPProd;

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
    Panel1: TPanel;
    BitBtn5: TBitBtn;
    httpActive: TCheckBox;
    HttpsActive: TCheckBox;
    DnlActive: TCheckBox;
    PageProducer1: TPageProducer;
    procedure BitBtn1Click(Sender: TObject);
    procedure IdTCPServer1Execute(AContext: TIdContext);
    procedure SpinEdit1Change(Sender: TObject);
    procedure SpinEdit3Change(Sender: TObject);
    procedure SpinEdit2Change(Sender: TObject);
    procedure SpinEdit4Change(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure httpActiveClick(Sender: TObject);
    procedure HttpsActiveClick(Sender: TObject);
    procedure DnlActiveClick(Sender: TObject);
    procedure PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
      const TagString: string; TagParams: TStrings; var ReplaceText: string);
  private
    m_ports : array[1..4] of Boolean;
    procedure ShowDeaktiv( flag : Boolean; lab : TLabel);
  public
    procedure prepare;
    function isOk : boolean;
  end;

implementation

{$R *.dfm}

uses
  u_glob, System.Generics.Collections, m_res, system.IOUtils;

procedure TPortCheckFrame.BitBtn1Click(Sender: TObject);
var
  srv : TIdTCPServer;
  id  : integer;
  ok  : boolean;
  s   : string;
  col : Tcolor;
  port : integer;
  isActive : boolean;
begin
  id  := (Sender as TBitBtn).Tag;
  col := clGreen;
  port := 42;
  isActive := false;

  case id of
    1 :
    begin
      port := SpinEdit1.Value;
      isActive := true;
    end;
    2 :
    begin
      port := SpinEdit2.Value;
      isActive := httpActive.Checked;
    end;
    3 :
    begin
      port := SpinEdit3.Value;
      isActive := HttpsActive.Checked;
    end;
    4 :
    begin
      port := SpinEdit4.Value;
      isActive := DnlActive.Checked;
    end;
  end;


  ok := true;
  if isActive then
  begin
    srv := TIdTCPServer.Create;
    srv.OnExecute := IdTCPServer1Execute;
    srv.DefaultPort := port;

    try
      srv.Active := true;
      ok := true;
      s := 'Frei';
      srv.Active := false;
    except
      on e : exception do
      begin
        ok := false;
        s  := 'Belegt';
        col := clRed;
      end;
    end;
    srv.Active := false;
    srv.Free;
  end
  else
  begin
    s := 'Deaktiviert';
    col := clBlack;
  end;

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

  if not ok then
    ShowMessage(Format('Der Port %d ist bereits belegt!', [port]));

end;

procedure TPortCheckFrame.BitBtn5Click(Sender: TObject);
begin
  BitBtn1.Click;
  BitBtn2.Click;
  BitBtn3.Click;
  BitBtn4.Click;
end;

procedure TPortCheckFrame.DnlActiveClick(Sender: TObject);
begin
  ShowDeaktiv( DnlActive.Checked, Label4 );
end;

procedure TPortCheckFrame.httpActiveClick(Sender: TObject);
begin
  ShowDeaktiv( httpActive.Checked, Label2 );
end;

procedure TPortCheckFrame.HttpsActiveClick(Sender: TObject);
begin
  ShowDeaktiv( DnlActive.Checked, Label7 );
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
var
  fname : string;
  text : TSTringList;
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

  glob.HttpActive     := httpActive.Checked;
  Glob.HttpsActive    := HttpsActive.Checked;
  Glob.DnlActive      := DnlActive.Checked;

  if Result then
  begin
    Glob.PortDS         := SpinEdit1.Value;
    Glob.PortHttp       := SpinEdit2.Value;
    Glob.PortHttps      := SpinEdit3.Value;
    Glob.PortClientHttp := SpinEdit4.Value;

    glob.writeData;

    fname := TPath.Combine(Glob.HomeDir, 'OpenPorts.ps1');
    text := TSTringList.Create;
    text.Text := PageProducer1.Content;
    try
      text.SaveToFile(fname)
    except
      on e : exception do
      begin
        ShowMessage('Fehler beim Schreiben der Firewallregeln!');
        result := false;
      end;
    end;
    text.Free;
  end;

end;

procedure TPortCheckFrame.PageProducer1HTMLTag(Sender: TObject; Tag: TTag;
  const TagString: string; TagParams: TStrings; var ReplaceText: string);
var
  list : TSTringList;
begin
  if SameText('ports', TagString) then
  begin
    list := TStringList.Create;
    list.Delimiter := ',';
    list.StrictDelimiter := true;

    list.Add(IntToStr(Glob.PortDS));
    if Glob.HttpActive then
      list.Add(IntToStr(Glob.PortHttp));

    if Glob.HttpsActive then
      list.Add(IntToStr(Glob.PortHttps));

    if Glob.DnlActive then
      list.Add(IntToStr(Glob.PortClientHttp));

    ReplaceText := list.DelimitedText;

    list.Free;
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

  httpActive.Checked := glob.HttpActive;
  HttpsActive.Checked:= Glob.HttpsActive;
  DnlActive.Checked  := Glob.DnlActive;
end;

procedure TPortCheckFrame.ShowDeaktiv(flag: Boolean; lab: TLabel);
begin
  if not flag then
  begin
    lab.Caption := 'Deaktiviert';
    lab.Font.Color := clBlack;
  end
  else
  begin
    lab.Caption := 'Ungetestet';
    lab.Font.Color := clBlack;
  end;
end;

procedure TPortCheckFrame.SpinEdit1Change(Sender: TObject);
begin
  m_ports[1] := false;
  Label1.Caption := 'Ungestestet';
  Label1.Font.Color := clWindowText;

  Label4.Caption := format('ds://%s:%d', [GetEnvironmentVariable('COMPUTERNAME'), SpinEdit1.Value]);

  if (SpinEdit1 .Value = SpinEdit2.Value) or ( SpinEdit1.Value = SpinEdit3.Value) or ( SpinEdit1.Value = SpinEdit4.Value) then
    ShowMessage('Achtung! Port doppelt belegt!')

end;

procedure TPortCheckFrame.SpinEdit2Change(Sender: TObject);
begin
  m_ports[2] := false;
  Label2.Caption := 'Ungestestet';
  Label2.Font.Color := clWindowText;

  Label5.Caption := format('http://%s:%d', [GetEnvironmentVariable('COMPUTERNAME'), SpinEdit2.Value]);
  if (SpinEdit2.Value = SpinEdit1.Value) or ( SpinEdit2.Value = SpinEdit3.Value) or ( SpinEdit2.Value = SpinEdit4.Value) then
    ShowMessage('Achtung! Port doppelt belegt!')
end;

procedure TPortCheckFrame.SpinEdit3Change(Sender: TObject);
begin
  m_ports[3] := false;
  Label3.Caption := 'Ungestestet';
  Label3.Font.Color := clWindowText;

  Label6.Caption := format('https://%s:%d', [GetEnvironmentVariable('COMPUTERNAME'), SpinEdit3.Value]);
  if (SpinEdit3.Value = SpinEdit1.Value) or ( SpinEdit3.Value = SpinEdit2.Value) or ( SpinEdit3.Value = SpinEdit4.Value) then
    ShowMessage('Achtung! Port doppelt belegt!')
end;

procedure TPortCheckFrame.SpinEdit4Change(Sender: TObject);
begin
  m_ports[4] := false;
  Label7.Caption := 'Ungestestet';
  Label7.Font.Color := clWindowText;

  Label8.Caption := format('http://%s:%d', [GetEnvironmentVariable('COMPUTERNAME'), SpinEdit4.Value]);
  if (SpinEdit4.Value = SpinEdit1.Value) or ( SpinEdit4.Value = SpinEdit2.Value) or ( SpinEdit4.Value = SpinEdit3.Value) then
    ShowMessage('Achtung! Port doppelt belegt!')

end;

end.
