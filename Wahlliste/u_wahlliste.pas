unit u_wahlliste;

interface

uses
  System.JSON, System.Generics.Collections;

type
  TWahllistePerson = class
    private
      const
        wpNr = 'nr';
        wpID = 'id';
        wpJob= 'job';
    private
      FNr: integer;
      FID: integer;
    FPersNr: string;
    FName: string;
    FVorname: string;
    FAbteilung: string;
    FGebDat: string;
    FGender: string;
    FJob: string;
    public
      constructor create;
      Destructor Destroy; override;

      property Nr: integer read FNr write FNr;
      property ID: integer read FID write FID;

      property PersNr: string read FPersNr write FPersNr;
      property Name: string read FName write FName;
      property Vorname: string read FVorname write FVorname;
      property Abteilung: string read FAbteilung write FAbteilung;
      property GebDat: string read FGebDat write FGebDat;
      property Gender: string read FGender write FGender;
      property Job: string read FJob write FJob;

      function toJSON : TJSONObject;
      procedure fromJSON( data : TJSONObject );
  end;

  TWahlliste = class
  private
    const
      wlName     = 'name';
      wlKurz     = 'kurz';
      wlID       = 'id';
      wlPersonen = 'personen';
  private
      FName: string;
      FKurz: string;
      FID  : integer;
      m_list : TList<TWahllistePerson>;
  public
      constructor create;
      Destructor Destroy; override;

      property Name: string read FName write FName;
      property Kurz: string read FKurz write FKurz;
      property ID: integer read FID write FID;

      property Personen : TList<TWahllistePerson> read m_list;

      function toJSON : TJSONObject;
      procedure fromJson( data : TJSONObject );

      procedure sort;

      function add : TWahllistePerson;
  end;

implementation

{ TWahlliste }

uses
  u_json, System.Generics.Defaults;

function TWahlliste.add: TWahllistePerson;
begin
  Result := TWahllistePerson.create;
  m_list.Add(Result);
  Result.Nr := m_list.Count;
end;

constructor TWahlliste.create;
begin
  m_list := TList<TWahllistePerson>.Create;
  FID := -1;
end;

destructor TWahlliste.Destroy;
var
  ma : TWahllistePerson;
begin
  for ma in m_list do
    ma.Free;
  m_list.Free;

end;

procedure TWahlliste.fromJson(data: TJSONObject);
var
  arr : TJSONArray;
  row : TArrayIterator;
  p   : TWahllistePerson;
begin
  FName := JString( data, wlName, FName);
  FKurz := JString(data, wlKurz, FKurz );
  FID   := JInt( data, wlID, FID);


  arr := JArray( data, wlPersonen);
  if Assigned(arr) then
  begin
    row := TArrayIterator.Create(arr);
    while row.Next do
    begin
      p := TWahllistePerson.create;
      p.fromJSON(row.CurrentItem);
      m_list.Add(p);
    end;
    row.Free;
  end;
end;

procedure TWahlliste.sort;
begin
  m_list.Sort(
  TComparer<TWahllistePerson>.Construct(
    function(const Left, Right: TWahllistePerson): Integer
    begin
      Result := left.Nr - Right.Nr;
    end )
    );

end;

function TWahlliste.toJSON: TJSONObject;
var
  arr : TJSONArray;
  ma  : TWahllistePerson;
  nr  : integer;
begin
  Result := TJSONObject.Create;
  JReplace(result, wlName, FName);
  JReplace(result, wlKurz, FKurz);
  JReplace(result, wlID, FID);

  if m_list.Count > 0 then
  begin
    arr := TJSONArray.Create;
    nr := 1;
    for ma in m_list do
    begin
      ma.Nr := nr;
      inc(nr);
      arr.Add(ma.toJSON);
    end;
    JReplace( result, wlPersonen, arr);
  end;
end;

{ TWahllistePerson }

constructor TWahllistePerson.create;
begin
  FNr := 0;
  FID := 0;
end;

destructor TWahllistePerson.Destroy;
begin

end;

procedure TWahllistePerson.fromJSON(data: TJSONObject);
begin
  JInt(data, wpNr, FNr);
  JInt(data, wpID, FID);
  JString(data, wpJob, FJob);
end;

function TWahllistePerson.toJSON: TJSONObject;
begin
  Result := TJSONObject.Create;

  JReplace(result, wpNr, FNr);
  JReplace(Result, wpID, FID);
  JReplace(Result, wpJob, FJob);
end;

end.
