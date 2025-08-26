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
  private
    m_list : TStringList;
    m_name : string;

    procedure UpdateLV;

    procedure findService;
  public
    procedure prepare;
    procedure updateData;
    procedure release;
  end;

implementation

{$R *.dfm}

{ TServerFrame }

procedure TServerFrame.BitBtn1Click(Sender: TObject);
begin
  DosCommand2.CommandLine := 'Service_Install.bat';
  DosCommand2.Execute;
end;

procedure TServerFrame.BitBtn2Click(Sender: TObject);
begin
  DosCommand2.CommandLine := 'Service_Start.bat';
  DosCommand2.Execute;
end;

procedure TServerFrame.BitBtn3Click(Sender: TObject);
begin
  DosCommand2.CommandLine := 'Service_Uninstall.bat';
  DosCommand2.Execute;
end;

procedure TServerFrame.BitBtn4Click(Sender: TObject);
begin
  DosCommand2.CommandLine := 'Service_Stop.Bat';
  DosCommand2.Execute;
end;

procedure TServerFrame.BitBtn5Click(Sender: TObject);
begin
  DosCommand2.CommandLine := 'start MitbestimmITServer.exe';
  DosCommand2.Execute;

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

procedure TServerFrame.DosCommand2NewLine(ASender: TObject;
  const ANewLine: string; AOutputType: TOutputType);
begin
  Memo1.Lines.Add(ANewLine);
end;

procedure TServerFrame.DosCommand2Terminated(Sender: TObject);
begin
  Memo1.Lines.Add('Fertig');
  updateData;
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
