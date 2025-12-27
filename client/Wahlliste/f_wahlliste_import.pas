unit f_wahlliste_import;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, fr_base, Vcl.StdCtrls, Vcl.Buttons, Excel4Delphi,
  Excel4Delphi.Stream, m_res, Vcl.CheckLst, Vcl.ExtCtrls, Vcl.ComCtrls,
  System.JSON, u_json;

type
  TWahllisteImport = class(TForm)
    BaseFrame1: TBaseFrame;
    GroupBox1: TGroupBox;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    OpenDialog1: TOpenDialog;
    GroupBox2: TGroupBox;
    Splitter1: TSplitter;
    CheckListBox1: TCheckListBox;
    GroupBox3: TGroupBox;
    LV: TListView;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Label2: TLabel;
    ComboBox2: TComboBox;
    GroupBox4: TGroupBox;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure CheckListBox1Click(Sender: TObject);
    procedure BaseFrame1OKBtnClick(Sender: TObject);
  private
    m_workBook: TZWorkBook;
    function loadExcel( fname : string ) : Boolean;
    procedure readSheets;
    procedure updateTable( inx : integer );
    procedure Fillcombo;
    procedure splitName( title : string; var name, kurz : string );

    function buildJson : TJSONObject;

    procedure showInfo( data : TJSONobject);
    procedure ShowResult( data : TJSONobject);
  public
    class function execute : boolean;
  end;

var
  WahllisteImport: TWahllisteImport;

implementation

{$R *.dfm}

uses u_stub, m_glob;

procedure TWahllisteImport.BaseFrame1OKBtnClick(Sender: TObject);
var
  client : TDSVorschlagListenImportClient;
  data   : TJSONObject;
  res    : TJSONObject;
begin
  data := buildJson;

  screen.Cursor := crHourGlass;
  client := TDSVorschlagListenImportClient.Create(GM.SQLConnection1.DBXConnection);
  try
    res := client.Import(data);
    screen.Cursor := crDefault;
    ShowResult( res );
  except
    on e : exception do
    begin
      screen.Cursor := crDefault;
      ShowMessage(e.ToString);
    end;
  end;

  client.Free;

end;

procedure TWahllisteImport.BitBtn1Click(Sender: TObject);
begin
  if OpenDialog1.Execute then
  begin
    Edit1.Text := OpenDialog1.FileName;
    loadExcel( OpenDialog1.FileName );
  end;
end;

function TWahllisteImport.buildJson: TJSONObject;
var
  arr : TJSONArray;
  page : integer;

  pinx, jinx : integer;
  function addPersonen ( sheet : TZSheet ) : TJSONArray;
  var
    nr, job : string;
    row  : integer;
    obj  : TJSONObject;
  begin
    Result := nil;

    if (pinx >= sheet.ColCount) or ( jinx >= sheet.ColCount) then
      exit;

    Result := TJSONArray.Create;
    for row := 1 to pred(sheet.RowCount) do
    begin
      nr := trim(sheet.Cell[pinx, row].AsString);
      job:= trim(sheet.Cell[jinx, row].AsString);

      if (nr <> '') and (job <> '' ) then
      begin
        obj := TJSONObject.Create;
        JReplace( obj, 'persnr', nr);
        JReplace( obj, 'job', job);
        Result.AddElement(obj);
      end;
    end;

  end;

  function addPage( sheet : TZSheet ) : TJSONObject;
  var
    kurz, name : string;
    personen : TJSONArray;
  begin
    Result := NIL;
    splitName(sheet.Title, name, kurz);

    if kurz = '' then
      exit;

    personen := addPersonen(sheet);
    if not Assigned(personen) then
      exit;

    Result := TJSONObject.Create;
    JReplace( result, 'name', name);
    JReplace( result, 'kurz', kurz);

    JReplace( result, 'personen', personen);
  end;
var
  obj : TJSONObject;
begin
  Result := NIL;

  pinx := ComboBox1.ItemIndex;
  jinx := ComboBox2.ItemIndex;
  if (pinx = -1) or (jinx = -1) then
    exit;

  Result := TJSONObject.Create;


  arr := TJSONArray.Create;
  for page := 0 to pred(m_workBook .Sheets.Count) do
  begin
    obj := addPage(m_workBook.Sheets.Sheet[page]);
    if Assigned(obj) then
      arr.AddElement(obj);
  end;
  JReplace( result, 'pages', arr);
end;

procedure TWahllisteImport.CheckListBox1Click(Sender: TObject);
begin
  updateTable( CheckListBox1.ItemIndex);
end;

class function TWahllisteImport.execute: boolean;
begin
  Application.CreateForm(TWahllisteImport, WahllisteImport);
  result := WahllisteImport.ShowModal = mrOk;
  WahllisteImport.Free;
end;

procedure TWahllisteImport.Fillcombo;
var
  col : integer;
  sheet : TZSheet;
begin
  ComboBox1.Items.Clear;
  ComboBox2.Items.Clear;

  sheet := m_workBook.Sheets[0];
  for col := 0 to pred(sheet.ColCount) do
  begin
    ComboBox1.Items.Add(sheet.Cell[col, 0].AsString);
  end;
  ComboBox2.Items.Assign(ComboBox1.Items);

  if ComboBox1.Items.Count> 0 then
  begin
    ComboBox1.ItemIndex := 0;
    ComboBox2.ItemIndex := ComboBox2.Items.Count-1;
  end;
end;

procedure TWahllisteImport.FormCreate(Sender: TObject);
begin
  m_workBook := NIL;
  if SameTExt(GetEnvironmentVariable('COMPUTERNAME'), 'Odin') then
  begin
    Edit1.Text := 'D:\git_d12\MitbestimmIT\testdaten\Firma1\IG Metal (IGM).xlsx';
    loadExcel(Edit1.Text);
  end;
end;

procedure TWahllisteImport.FormDestroy(Sender: TObject);
begin
  if Assigned(m_workBook) then
  begin
    FreeAndNil(m_workBook)
  end;
end;

function TWahllisteImport.loadExcel(fname: string): Boolean;
var
  data : TJSONObject;
begin
  result := false;
  if Assigned(m_workBook) then
  begin
    FreeAndNil(m_workBook)
  end;
  try
    m_workBook := TZWorkBook.Create(nil);
    m_workBook.LoadFromFile(fname);

    Fillcombo;
    updateTable(0);

    data := buildJson;
    showInfo( data );
    if Assigned(data) then
      FreeAndNil(data);
    Result := true;
  except
    on e : exception do
    begin
      ShowMessage(e.ToString);
    end;
  end;
  if Result then
  begin
    readSheets;
  end;

end;

procedure TWahllisteImport.readSheets;
var
  i : integer;
  inx : integer;
begin
  CheckListBox1.Items.Clear;

  for i := 0 to pred(m_workBook .Sheets.Count) do
  begin
    inx := CheckListBox1.Items.Add(m_workBook .Sheets.Sheet[i].Title );
    CheckListBox1.Checked[inx] := true;
  end;
end;

procedure TWahllisteImport.showInfo(data: TJSONobject);
var
  msg : string;
  pages : TJSONArray;
  row : TJSONObject;
  i   : integer;
  personen : TJSONArray;
begin
  msg := 'Es wurden keine Vorschlagslisten gefunden!';
  if Assigned(data) then
  begin
    pages := JArray( data, 'pages');
    if Assigned(pages) then
    begin
      msg := '';
      for i := 0 to pred(pages.Count) do
      begin
        row := getRow(pages, i);
        personen := JArray( row, 'personen');
        msg := msg + Format( '%s (%s): %d Personen%s', [JString(row, 'name'), JString(row, 'kurz'), personen.Count, sLineBreak]);
      end;
    end;
  end;
  ShowMessage(msg);
end;

procedure TWahllisteImport.ShowResult(data: TJSONobject);
var
  msg : string;
  row : TJSONObject;
  arr : TJSONArray;
  err : TJSONArray;
  ok  : TJSONArray;
  i   : integer;
begin
  msg := '';

  arr := JArray( data, 'listen');
  if Assigned(arr) then
  begin
    for i := 0 to pred(arr.Count) do
    begin
      row := getRow(arr, i);
      err := JArray( row, 'error');
      ok  := JArray( row, 'ok');

      msg := msg + Format('%s(%s) Ok:%d Fehler:%d %s',
      [
        JString( row, 'name'),
        JString( row, 'kurz'),
        ok.Count,
        err.Count,
        sLineBreak
      ]);

    end;

  end
  else
    msg := 'Die Antwort enthielt keine Daten';
  ShowMessage(msg);
end;

procedure TWahllisteImport.splitName(title: string; var name, kurz : string );
var
  inx : integer;
begin
  inx := pos('(', title);
  if inx > 0 then
  begin
    name := trim(copy( title, 0, inx-1));
    kurz := copy( title, inx + 1);
    inx  := pos(')', kurz);
    if inx > 0 then
      SetLength(kurz, inx-1);
    kurz := trim(kurz);
  end
  else
  begin
    name := title;
    kurz := '';
  end;

end;

procedure TWahllisteImport.updateTable(inx: integer);
var
  sheet : TZSheet;
  row, col : integer;
  lcol : TListColumn;
  item : TListItem;
  kurz, name : string;
begin
  LV.Items.Clear;
  LV.Columns.Clear;
  if inx = -1  then
    exit;

  LV.Items.BeginUpdate;
  sheet := m_workBook.Sheets[inx];
  splitName( sheet.Title, name, kurz );
  GroupBox4.Caption := Format('Vorschlagsliste : %s (%s)', [name, kurz]);

  lcol := LV.Columns.Add;
  lcol.Caption := 'Nr';
  for col := 0 to pred(sheet.ColCount) do
  begin
    lcol := LV.Columns.Add;
    lcol.Caption := sheet.Cell[col, 0].AsString;
  end;
  for row := 1 to pred( sheet.RowCount) do
  begin
    item := LV.Items.Add;
    item.Caption := IntToStr(row);
    for col := 0 to pred(sheet.ColCount) do
    begin
      item.SubItems.Add(sheet.Cell[col, row].AsString);
    end;
  end;

  for col := 0 to pred(LV.Columns.Count) do
  begin
    LV.Columns[col].Width := -1;
  end;

  LV.Items.EndUpdate;
end;

end.
