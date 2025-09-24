unit fr_server;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes,
  Vcl.Graphics, Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DosCommand, Vcl.StdCtrls,
  Vcl.Buttons, System.ImageList, Vcl.ImgList, PngImageList, Vcl.ComCtrls,
  Vcl.ExtCtrls;

type
  TServerFrame = class(TFrame)
    DosCommand1: TDosCommand;
    PngImageList1: TPngImageList;
    GroupBox1: TGroupBox;
    LV: TListView;
    Splitter1: TSplitter;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    DosCommand2: TDosCommand;
    Memo1: TMemo;
    Panel1: TPanel;
    Splitter2: TSplitter;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Panel2: TPanel;
    BitBtn6: TBitBtn;
    procedure DosCommand1NewLine(ASender: TObject; const ANewLine: string;
      AOutputType: TOutputType);
    procedure DosCommand1Terminated(Sender: TObject);
    procedure DosCommand2NewLine(ASender: TObject; const ANewLine: string;
      AOutputType: TOutputType);
    procedure BitBtn1Click(Sender: TObject);
    procedure DosCommand2Terminated(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure DosCommand2ExecuteError(ASender: TObject; AE: Exception;
      var AHandled: Boolean);
  private
    m_list : TStringList;
    m_name : string;

    procedure UpdateLV;

    procedure findService;
    procedure updateData;
  public
    procedure prepare;

    procedure release;
  end;

implementation

{$R *.dfm}

uses m_res, system.IOUtils;

{ TServerFrame }

procedure Execute( const aCommando : string );
var
  tmpStartupInfo: TStartupInfo;
  tmpProcessInformation: TProcessInformation;
  tmpProgram: String;
begin
  tmpProgram := trim(aCommando);
  FillChar(tmpStartupInfo, SizeOf(tmpStartupInfo), 0);
  with tmpStartupInfo do
  begin
    cb := SizeOf(TStartupInfo);
    wShowWindow := SW_HIDE;
  end;

  if CreateProcess(nil, pchar(tmpProgram), nil, nil, true, CREATE_NEW_CONSOLE,
    nil, nil, tmpStartupInfo, tmpProcessInformation) then
  begin
    // Handle für den Prozess und den Thread schließen, da wir nicht darauf warten.
    CloseHandle(tmpProcessInformation.hProcess);
    CloseHandle(tmpProcessInformation.hThread);
  end
  else
  begin
    RaiseLastOSError;
  end;
end;

procedure ExecuteAndWait(const aCommando: string);
var
  tmpStartupInfo: TStartupInfo;
  tmpProcessInformation: TProcessInformation;
  tmpProgram: String;
begin
  tmpProgram := trim(aCommando);
  FillChar(tmpStartupInfo, SizeOf(tmpStartupInfo), 0);
  with tmpStartupInfo do
  begin
    cb := SizeOf(TStartupInfo);
    wShowWindow := SW_HIDE;
  end;

  if CreateProcess(nil, pchar(tmpProgram), nil, nil, true, CREATE_NO_WINDOW,
    nil, nil, tmpStartupInfo, tmpProcessInformation) then
  begin
    // loop every 10 ms
    while WaitForSingleObject(tmpProcessInformation.hProcess, 10) > 0 do
    begin
      Application.ProcessMessages;
    end;
    CloseHandle(tmpProcessInformation.hProcess);
    CloseHandle(tmpProcessInformation.hThread);
  end
  else
  begin
    RaiseLastOSError;
  end;
end;

procedure TServerFrame.BitBtn1Click(Sender: TObject);
begin
  Execute(TPath.Combine(DosCommand2.CurrentDir, 'Service_Install.bat'));
end;

procedure TServerFrame.BitBtn2Click(Sender: TObject);
begin
  Execute(TPath.Combine(DosCommand2.CurrentDir, 'Service_Start.bat'));
end;

procedure TServerFrame.BitBtn3Click(Sender: TObject);
begin
  Execute(TPath.Combine(DosCommand2.CurrentDir, 'Service_Uninstall.bat'));
end;

procedure TServerFrame.BitBtn4Click(Sender: TObject);
begin
  Execute(TPath.Combine(DosCommand2.CurrentDir, 'Service_Stop.Bat'));
end;

procedure TServerFrame.BitBtn5Click(Sender: TObject);
begin
  Execute(TPath.Combine(DosCommand2.CurrentDir, 'MitbestimmITServer.exe'));
end;

procedure TServerFrame.BitBtn6Click(Sender: TObject);
begin
  updateData;
end;

procedure TServerFrame.DosCommand1NewLine(ASender: TObject;
  const ANewLine: string; AOutputType: TOutputType);
begin
  m_list.Add(ANewLine);

end;

procedure TServerFrame.DosCommand1Terminated(Sender: TObject);
begin
  UpdateLV;
  Screen.Cursor := crDefault;
end;

procedure TServerFrame.DosCommand2ExecuteError(ASender: TObject; AE: Exception;
  var AHandled: Boolean);
begin
  Memo1.Lines.Add('Fehler');
  Memo1.Lines.Add(AE.ToString);
end;

procedure TServerFrame.DosCommand2NewLine(ASender: TObject;
  const ANewLine: string; AOutputType: TOutputType);
begin
  Memo1.Lines.Add(ANewLine);
end;

procedure TServerFrame.DosCommand2Terminated(Sender: TObject);
begin
  Memo1.Lines.Add('Fertig');
  updateData;
  findService;
end;

procedure TServerFrame.findService;
var
  i : integer;
  item : TListItem;
begin
  for i := 0 to pred(LV.Items.Count) do
  begin
    item := Lv.Items[i];
    if SameText(m_name, item.Caption) then
    begin
      LV.Selected := item;
      break;
    end;
  end;
end;

procedure TServerFrame.prepare;
begin
  Memo1.Lines.Clear;
  m_list := TStringList.Create;
  m_name := 'MitbestimmIT Server';
  DosCommand2.CurrentDir := ExtractFilePath(ParamStr(0));
end;

procedure TServerFrame.release;
begin
  m_list.Free;
end;

procedure TServerFrame.updateData;
begin
  m_list.Clear;
  Lv.Items.Clear;
  Screen.Cursor := crHourGlass;
  DosCommand1.Execute;
end;

procedure TServerFrame.UpdateLV;
var
  i     : integer;
  split : TStringList;
  item  : TListItem;
begin
  split := TStringList.Create;

  Lv.Items.BeginUpdate;
  Lv.Items.Clear;

  if m_list.Count >= 4 then
  begin


    while pos('--', trim(m_list[0])) = 0 do
    begin
      m_list.Delete(0)
    end;
    m_list.Delete(0);

    for i := 0 to pred(m_list.Count) do
    begin
      split.DelimitedText := m_list[i];
      if split.Count>= 2 then
      begin
        item := LV.Items.Add;

        if SameText('running', split[0]) then
          item.ImageIndex := 0
        else if SameText('stopped', split[0]) then
          item.ImageIndex := 2
        else
          item.ImageIndex := 1;

        item.SubItems.Add(split[0]);
        split.Delete(0);
        item.Caption := trim(split.Text);

        if SameText(m_name, item.Caption) then
          LV.Selected := item;
      end;
    end;
  end;

  split.Free;
  Lv.Items.EndUpdate;
end;

end.
