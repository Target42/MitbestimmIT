unit f_wahlliste_personen;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, u_wahlliste, Vcl.StdCtrls, Vcl.Mask,
  Vcl.ExtCtrls, m_glob, Vcl.Grids, fr_base, Vcl.Menus, u_stub, Vcl.ComCtrls,
  u_json, Vcl.Buttons, System.Actions, Vcl.ActnList, m_res;

type
  TWahllistenPersonenForm = class(TForm)
    GroupBox1: TGroupBox;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit2: TLabeledEdit;
    BaseFrame1: TBaseFrame;
    SG: TStringGrid;
    PopupMenu1: TPopupMenu;
    PopupMenu11: TMenuItem;
    GroupBox2: TGroupBox;
    ActionList1: TActionList;
    ac_paste: TAction;
    BitBtn1: TBitBtn;
    procedure FormCreate(Sender: TObject);
    procedure SGSelectCell(Sender: TObject; ACol, ARow: LongInt;
      var CanSelect: Boolean);
    procedure SGKeyPress(Sender: TObject; var Key: Char);
    procedure SGDrawCell(Sender: TObject; ACol, ARow: LongInt; Rect: TRect;
      State: TGridDrawState);
    procedure ac_pasteExecute(Sender: TObject);
  private
    const
    colNr         = 0;
    colPersNr     = 1;
    colName       = 2;
    colVorname    = 3;
    colGeschlecht = 4;
    colAbteilung  = 5;
    colJob        = 6;
  private
    m_liste : TWahlliste;
    function GetWahlliste: TWahlliste;
    procedure SetWahlliste(const Value: TWahlliste);

    function Add( PersNr : string ) :TWahllistePerson;
    procedure lookup( p : TWahllistePerson );
    function findID( PersNr : string ) : integeR;
    procedure UpdateRow( row : integer; p :TWahllistePerson );
  public
    class function execute( var wl : TWahlliste ) : boolean;
    property Wahlliste: TWahlliste read GetWahlliste write SetWahlliste;
  end;

var
  WahllistenPersonenForm: TWahllistenPersonenForm;

implementation

uses
  Data.DB, ClipBrd, System.JSON;

{$R *.dfm}

{ TWahllistenPersonenForm }

procedure TWahllistenPersonenForm.ac_pasteExecute(Sender: TObject);
var
  list : TSTringList;
  lines : TStringList;
  i : integer;
  inx : integer;
  p   : TWahllistePerson;
begin
  lines := TStringList.Create;
  lines.Text := Clipboard.AsText;;

  list := TStringList.Create;
  list.StrictDelimiter := true;
  list.Delimiter := ',';

  if Sg.Col = colPersNr then
  begin
    for i := 0 to pred(lines.Count) do
    begin
      list.DelimitedText := lines[i];
      if list.Count > 0 then
      begin
        p := Add(list[0]);
        if list.Count >= 7 then
          p.Job := list[colJob];
      end;
    end;
  end
  else if Sg.Col = colJob then
  begin
    if SG.Row < 1 then
      SG.Row := 1;

    inx := SG.Row -1;
    // jobs einfügen
    for i := 0 to pred(lines.Count) do
    begin
      list.DelimitedText := lines[i];
      if list.Count > 0 then
      begin
        if inx < m_liste.Personen.Count then
        begin
          p := m_liste.Personen[inx];
          p.Job := list[0];
          Sg.Cells[colJob,inx + 1] := list[0];
          inc(inx);
        end;
      end;
    end;
  end;

  list.Free;
  lines.Free;
end;

function TWahllistenPersonenForm.Add(PersNr: string) : TWahllistePerson;
var
  id : integeR;
begin
  Result := NIL;
  id := findID(GM.cleanPersNr(PersNr));
  if id > 0 then
  begin
    result := m_liste.add;
    result.ID := id;
    lookup(result);
    UpdateRow( m_liste.Personen.Count, result );
  end;
end;

class function TWahllistenPersonenForm.execute(var wl: TWahlliste): boolean;
begin
  Application.CreateForm(TWahllistenPersonenForm, WahllistenPersonenForm);
  WahllistenPersonenForm.Wahlliste := wl;
  Result := WahllistenPersonenForm.ShowModal = mrOk;
  WahllistenPersonenForm.Free;
end;

function TWahllistenPersonenForm.findID(PersNr: string): integeR;
begin
  Result := 0;
  if GM.MAUserTab.Locate('MA_PERSNR', PersNr, [TLocateOption.loCaseInsensitive]) then
  begin
    Result := GM.MAUserTab.FieldByName('MA_ID').AsInteger;
  end;
end;

procedure TWahllistenPersonenForm.FormCreate(Sender: TObject);
var
  i : integer;
begin
  SG.ColCount := 7;
  SG.RowCount := 100;

  SG.Cells[colNr,         0] := 'Nr';
  SG.Cells[colPersNr,     0] := 'PersNr';
  SG.Cells[colName,       0] := 'Name';
  SG.Cells[colVorname,    0] := 'Vorname';
  SG.Cells[colGeschlecht, 0] := 'Geschlecht';
  SG.Cells[colAbteilung,  0] := 'Abteilung';
  SG.Cells[colJob,        0] := 'Job';

  SG.ColWidths[colNr]         := 50;
  SG.ColWidths[colPersNr]     := 75;
  SG.ColWidths[colName]       := 150;
  SG.ColWidths[colVorname]    := 150;
  SG.ColWidths[colGeschlecht] := 75;
  SG.ColWidths[colAbteilung]  := 100;
  SG.ColWidths[colJob]        := 100;

  for i := 1 to SG.RowCount do
    SG.Cells[0, i] := intToStr(i);

  if GM.MAUserTab.IsEmpty then
    GM.updateMATab;
end;

function TWahllistenPersonenForm.GetWahlliste: TWahlliste;
begin
  Result := m_liste;
end;

procedure TWahllistenPersonenForm.lookup(p: TWahllistePerson);
begin
  if GM.MAUserTab.Locate( 'MA_ID', p.ID, []) then
  begin
    p.PersNr  := GM.MAUserTab.FieldByName('MA_PERSNR').AsString;
    p.Name    := GM.MAUserTab.FieldByName('MA_NAME').AsString;
    p.Vorname := GM.MAUserTab.FieldByName('MA_VORNAME').AsString;
    p.GebDat  := FormatDateTime('dd.MM.yyyy', GM.MAUserTab.FieldByName('MA_GEB').AsDateTime);
    if GM.MAUserTab.FieldByName('MA_GENDER').AsString = 'w' then
      p.Gender := 'weiblich'
    else
      p.Gender := 'männlich';
    p.Abteilung := GM.MAUserTab.FieldByName('MA_ABTEILUNG').AsString;
  end;
end;

procedure TWahllistenPersonenForm.SetWahlliste(const Value: TWahlliste);
var
  p : TWahllistePerson;
  inx : integer;
begin
  m_liste := value;
  LabeledEdit1.Text := m_liste.Name;
  LabeledEdit2.Text := m_liste.Kurz;

  inx := 1;
  for p in m_liste.Personen do
  begin
    lookup(p);
    UpdateRow(inx, p);
    inc(inx);
  end;

end;

procedure TWahllistenPersonenForm.SGDrawCell(Sender: TObject; ACol,
  ARow: LongInt; Rect: TRect; State: TGridDrawState);
var
  Grid: TStringGrid;
  CellText: string;
begin
  Grid := Sender as TStringGrid;

  CellText := Grid.Cells[ACol, ARow];

  if gdSelected in State then
    Grid.Canvas.Brush.Color := clHighlight
  else
    Grid.Canvas.Brush.Color := clWindow ;

  if (Acol = 0) or ( ARow = 0) then
    Grid.Canvas.Brush.Color := clBtnFace;
  if (ARow > 0) and ( ( ACol >= 2 ) and (ACol <= 5) ) then
    Grid.Canvas.Brush.Color := TColor(RGB(250, 250, 250));


  Grid.Canvas.FillRect(Rect);

  if (ACol = colPersNr) or ( ACol = colJob) then
    Grid.Canvas.Font.Color := clGreen
  else
    Grid.Canvas.Font.Color := clBlack;

  Grid.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, CellText);
end;

procedure TWahllistenPersonenForm.SGKeyPress(Sender: TObject; var Key: Char);
var
  id : integer;
  p  : TWahllistePerson;
  inx : integer;
begin
  if key = #13 then
  begin
    if SG.Col = colPersNr then
    begin
      id := findID(GM.cleanPersNr(SG.Cells[SG.Col, SG.Row]));
      SG.Cells[SG.Col, SG.Row] := '';

      if id > 0 then
      begin
        p := m_liste.add;
        p.ID := id;
        lookup(p);
        UpdateRow( m_liste.Personen.Count, p );
      end;
    end
    else if Sg.Col = colJob then
    begin
      inx := SG.Row - 1;
      if inx < m_liste.Personen.Count then
      begin
        p := m_liste.Personen[inx];
        p.Job := trim(SG.Cells[SG.Col, SG.Row]);
      end;
    end;

  end;
end;

procedure TWahllistenPersonenForm.SGSelectCell(Sender: TObject; ACol,
  ARow: LongInt; var CanSelect: Boolean);
var
  inx : integer;
  id  :  integer;
  p   : TWahllistePerson;
begin
  CanSelect := ( ACol = colPersNr  ) or ( ACol = colJob);

  inx := SG.Row - 1;
  if ( SG.Col = colJob) and ( SG.Row > 0 ) then
  begin
    if (inx >= 0 ) and ( inx < m_liste.Personen.Count) then
    begin
      p := m_liste.Personen[inx];
      p.Job := trim(SG.Cells[colJob, SG.Row]);
    end;
  end
  else if (SG.Col = colPersNr) and ( SG.Row > 0 ) then
  begin
    if inx >= m_liste.Personen.Count then
    begin
      id := findID(GM.cleanPersNr(SG.Cells[SG.Col, SG.Row]));
      SG.Cells[SG.Col, SG.Row] := '';

      if id > 0 then
      begin
        p := m_liste.add;
        p.ID := id;
        lookup(p);
        UpdateRow( m_liste.Personen.Count, p );
      end;
    end;
  end;
end;

procedure TWahllistenPersonenForm.UpdateRow(row: integer; p: TWahllistePerson);
begin
  SG.Cells[colPersNr,     row] := p.PersNr;
  SG.Cells[colName,       row] := p.Name;
  SG.Cells[colVorname,    row] := p.Vorname;
  SG.Cells[colGeschlecht, row] := p.Gender;
  SG.Cells[colGeschlecht, row] := p.Gender;
  SG.Cells[colAbteilung,  row] := p.Abteilung;
  SG.Cells[colJob,        row] := p.Job;
end;

end.
