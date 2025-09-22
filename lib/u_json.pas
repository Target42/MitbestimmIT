{
  This file is part of the MitbestimmIT project.

  Copyright (C) 2025 Stephan Winter

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program. If not, see <https://www.gnu.org/licenses/>.
}
unit u_json;

{
  used from: https://github.com/Target42/Archivar/blob/main/misc/u_json.pas
}

interface

uses
  System.JSON, System.Classes, System.Generics.Collections;

type
  TArrayIterator = class
  private
    fArray: TJSONArray;
    fCurrentItem: Integer;
  protected
  public
    constructor Create(const arr: TJSONArray);
    procedure Reset;
    function Next: Boolean; virtual;
    function CurrentItem: TJSONObject;
    function count : integer;
  end;

procedure JReplace( obj : TJSONObject ; name : string ; value : string ); overload;
procedure JReplace( obj : TJSONObject ; name : string ; value : integer ); overload;
procedure JReplace( obj : TJSONObject ; name : string ; value : Int64 ); overload;
procedure JReplaceDouble( obj : TJSONObject ; name : string ; value : double ); overload;
procedure JReplace( obj : TJSONObject ; name : string ; value : boolean ); overload;
procedure JReplace( obj : TJSONObject ; name : string ; value : TJSONArray ); overload;
procedure JReplace( obj : TJSONObject ; name : string ; value : TJSONObject ); overload;
procedure Jreplace( obj : TJSONObject ; name : string ; value : TDate );      overload;

procedure JRemove( obj : TJSONObject ; name : string );

function JString( obj : TJSONObject; name : string ; default : string = '' ) : string;
function JInt   ( obj : TJSONObject; name : string ; default : integer = 0 ) : integer;
function JInt64 ( obj : TJSONObject; name : string ; default : int64 = 0 ) : int64;
function JDouble( obj : TJSONObject; name : string ; default : double = 0.0 ) : Double;
function JBool  ( obj : TJSONObject; name : string ; default : boolean = false ) : boolean;
function JObject( obj : TJSONObject; name : string ) : TJSONObject;
function JArray ( obj : TJSONObject; name : string ) : TJSONArray;
function JDate  ( obj : TJSONObject; name : string ) : TDate;

function getRow( arr : TJSONArray ; inx : integer ) : TJSONObject;

procedure setText( obj : TJSONObject; name : string ; text : string ); overload;
procedure setText( obj : TJSONObject; name : string ; list : TStrings ); overload;
procedure setText( obj : TJSONObject; name : string ; list : TStringList ); overload;
procedure setText( arr : TJSONArray;  list : TStringList ); overload;

function  getText( obj : TJSONObject; name : string ) : String; overload;
procedure getText( obj : TJSONObject; name : string ; list : TStringList ); overload;
procedure getText( arr : TJSONArray;  list : TStringList ); overload;

function  getIntNumbers( obj : TJSONObject; name : string ) : Tlist<integer>;

function loadJSON( var obj : TJSONObject; st : TStream ) : boolean; overload;
function loadJSON( var obj : TJSONObject; fileName : string ) : boolean; overload;

function loadJSON( st : TStream ) : TJSONObject; overload;
function loadJSON( fileName : string ) : TJSONObject; overload;
function JFromText( text : string) : TJSONObject;
function JValueFromText( text : string ) : TJSONValue;

function saveJSON( obj : TJSONObject; st : TStream ; pretty : boolean = false ) : boolean; overload;
function saveJSON( obj : TJSONObject; fileName : string ; pretty : boolean = false ) : boolean; overload;

function JQuote( s : string ) : String;
function JUnQuote( s : string ) : String;

function JDeleteKey( obj : TJSONObject ; name : String ) : boolean;
function JExistsKey( obj : TJSONObject ; name : String ) : boolean;

procedure JResult( obj : TJSONObject ; ok : Boolean ; text : string );
procedure JResponse( data : TJSONObject ; state : boolean ; text : string );

function formatJSON( obj : TJSONObject; indend : integer = -1 ) : string;

procedure JAction( data : TJSONObject; action : string );

function JArrayToInteger( arr : TJSONArray ) : TList<integer>; overload;
function JArrayToInteger( data : TJSONObject; name : string ) : TList<integer>; overload;
function IntListToJArray( var list : TList<integer> ) : TJSONArray;

procedure purge( var list : TStringList );

implementation

uses
  System.SysUtils;

var
  AddSpc : string;

function parseArray( arr : TJSONArray; indent : string ) : string; forward;
function ParseObject( obj : TJSONObject; indent : string ) : string; forward;


{*******************************************************************************
*                   JRemove
*******************************************************************************}
procedure JRemove( obj : TJSONObject ; name : string );
var
  p :TJSONPair;

begin
  if not Assigned(obj) then
    exit;

  p := obj.RemovePair(name);
  if Assigned(p) then
    p.Free;
end;

{*******************************************************************************
*                   JReplace    string
*******************************************************************************}
procedure JReplace( obj : TJSONObject ; name : string ; value : string );
var
  p :  TJSONPair;
begin
  if not Assigned(obj) then
    exit;

  p := obj.RemovePair(name);
  if Assigned(p) then
    p.Free;
  if not value.Contains(#13) then
    obj.AddPair( TJSONPair.Create( name, TJSONString.Create(JQuote(value))))
  else
    setText( obj, name, value );
end;

{*******************************************************************************
*                   JReplace    boolean
*******************************************************************************}
procedure JReplace( obj : TJSONObject ; name : string ; value : boolean );
var
  p :  TJSONPair;
begin
  if not Assigned(obj) then
    exit;

  p := obj.RemovePair(name);
  if Assigned(p) then
    p.Free;

  obj.AddPair( TJSONPair.Create( name, TJSONBool.Create(value)));

end;


{*******************************************************************************
*                   JReplace    TJSONArray
*******************************************************************************}
procedure JReplace( obj : TJSONObject ; name : string ; value : TJSONArray );
var
  p :  TJSONPair;
begin
  if not Assigned(obj) then
    exit;

  p := obj.RemovePair(name);
  if Assigned(p) then
    p.Free;
  if Assigned( value) then
    obj.AddPair( TJSONPair.Create( name, value) );
end;

{*******************************************************************************
*                   JReplace    integer
*******************************************************************************}
procedure JReplace( obj : TJSONObject ; name : string ; value : integer );
var
  p :  TJSONPair;
begin
  if not Assigned(obj) then
    exit;

  p := obj.RemovePair(name);
  if Assigned(p) then
    p.Free;
  obj.AddPair( TJSONPair.Create( name, TJSONNumber.Create(value)));
end;

procedure JReplace( obj : TJSONObject ; name : string ; value : Int64 ); overload;
var
  p :  TJSONPair;
begin
  if not Assigned(obj) then
    exit;

  p := obj.RemovePair(name);
  if Assigned(p) then
    p.Free;
  obj.AddPair( TJSONPair.Create( name, TJSONNumber.Create(value)));
end;

{*******************************************************************************
*                   JReplace    double
*******************************************************************************}
procedure JReplaceDouble( obj : TJSONObject ; name : string ; value : double ); overload;
var
  p :  TJSONPair;
begin
  if not Assigned(obj) then
    exit;

  p := obj.RemovePair(name);
  if Assigned(p) then
    p.Free;
  obj.AddPair( TJSONPair.Create( name, TJSONNumber.Create(value)));
end;

{*******************************************************************************
*                   JReplace    TJSONObject
*******************************************************************************}
procedure JReplace( obj : TJSONObject ; name : string ; value : TJSONObject ); overload;
var
  p :  TJSONPair;
begin
  if not Assigned(obj) then
    exit;

  p := obj.RemovePair(name);
  if Assigned(p) then
    p.Free;
  if Assigned(value) then
    obj.AddPair( TJSONPair.Create( name, value));
end;

{*******************************************************************************
*                   JReplace    TDate
*******************************************************************************}
procedure Jreplace( obj : TJSONObject ; name : string ; value : TDate );
var
  text : string;
begin
  text := FormatDateTime('dd.MM.YYYY hh:mm:ss', value);
  Jreplace( obj, name, text);
end;

{*******************************************************************************
*                   JArray
*******************************************************************************}
function JArray ( obj : TJSONObject; name : string ) : TJSONArray;
begin
  Result := NIL;

  if not Assigned(obj) then
    exit;
  try
    Result := obj.Values[ name ] as TJSONArray;
  finally

  end;

end;

{*******************************************************************************
*                   JArray
*******************************************************************************}
function JDate( obj : TJSONObject ; name : string ) : TDate;
var
  text : string;
  s     :TFormatSettings;
begin
  Result := 0.0;

  s := TFormatSettings.Create('de-DE');
  text := JString( obj, name);

  if not text.IsEmpty then
  begin
    try
      Result := StrToDateTime( text, s);
    except

    end;
  end;

end;

{*******************************************************************************
*                   JObject
*******************************************************************************}
function JObject( obj : TJSONObject; name : string ) : TJSONObject;
begin
  Result := NIL;

  if not Assigned(obj) then
    exit;
  try
    if obj.Values[ name ] is TJSONObject then //
      Result := TJSONObject(obj.Values[ name ]);
  except

  end;
end;

{*******************************************************************************
*                   JInt
*******************************************************************************}
function JInt( obj : TJSONObject; name : string ; default : integer = 0 ) : integer;
var
  v : TJSONNumber;
  val : TJSONValue;
begin
  Result := default;

  if not Assigned(obj) then
    exit;
  val := obj.Values[ name ];
  v := val as TJSONNumber;

  if Assigned(v) then
    Result := v.AsInt;
end;
{*******************************************************************************
*                   JInt64
*******************************************************************************}
function JInt64 ( obj : TJSONObject; name : string ; default : int64 = 0 ) : int64;
var
  v : TJSONNumber;
begin
  Result := default;

  if not Assigned(obj) then
    exit;
  v := obj.Values[ name ] as TJSONNumber;

  if Assigned(v) then
    Result := v.AsInt64;
end;

{*******************************************************************************
*                   JDouble
*******************************************************************************}
function JDouble( obj : TJSONObject; name : string ; default : double = 0.0 ) : Double;
var
  v : TJSONNumber;
begin
  Result := default;

  if not Assigned(obj) then
    exit;
  v := obj.Values[ name ] as TJSONNumber;

  if Assigned(v) then
    Result := v.AsDouble;
end;
{*******************************************************************************
*                   JBool
*******************************************************************************}
function JBool ( obj : TJSONObject; name : string ; default : boolean  ) : boolean;
var
  v : TJSONBool;
begin
  Result := default;

  if not Assigned(obj) then
    exit;
  v := obj.Values[ name ] as TJSONBool;

  if Assigned(v) then
    Result := v.AsBoolean;

end;

{*******************************************************************************
*                   JString
*******************************************************************************}
function JString( obj : TJSONObject ; name : string ; default : string ) : string;
var
  v : TJSONString;
  val : TJSONValue;
begin
  Result := default;

  if not Assigned(obj) then
    exit;
  val := obj.Values[ name ];
  if not Assigned( val) then
    exit;

  if  val is TJSONString then
  begin
    v := obj.Values[ name ] as TJSONString;

    if Assigned(v) then
      Result := JUnQuote(v.Value);
  end
  else if val is TJSONArray then
  begin
    Result := getText( obj, name );
  end;

end;

{*******************************************************************************
*                   ac_ru_runExecute
*******************************************************************************}
function loadJSON( st : TStream ) : TJSONObject;
var
  list : TStringList;
begin
  Result := NIL;

  if not Assigned(st) then
    exit;

  list := TStringList.Create;
  try
    list.LoadFromStream(st, TEncoding.UTF8);

    Result := TJSONObject.ParseJSONValue(list.Text) as TJSONObject;
  finally
    list.Free;
  end;


end;

{*******************************************************************************
*                   ac_ru_runExecute
*******************************************************************************}
function loadJSON( fileName : string ) : TJSONObject;
var
  st : TFileStream;
begin
  Result := NIL;
  st := NIL;

  if FileExists( fileName) then
  begin
    try
      st := TFileStream.Create(fileName, fmOpenRead + fmShareDenyNone );
      Result := loadJSON(st);
    finally
      st.Free;
    end;
  end;

end;

function loadJSON( var obj : TJSONObject; st : TStream ) : boolean;
begin
  if Assigned(obj) then
    obj.Free;
  obj := loadJSON( st );

  Result := Assigned(obj);
end;

function loadJSON( var obj : TJSONObject; fileName : string ) : boolean;
begin
  if Assigned(obj) then
    obj.Free;
  obj := loadJSON( fileName );

  Result := Assigned(obj);
end;


{*******************************************************************************
*                   ac_ru_runExecute
*******************************************************************************}
function getRow( arr : TJSONArray ; inx : integer ) : TJSONObject;
begin
  Result := NIL;

  if not Assigned(arr) then
    exit;

    Result := arr.Items[ inx ] as TJSONObject;
end;

{*******************************************************************************
*                   saveJSON
*******************************************************************************}
function saveJSON( obj : TJSONObject; st : TStream; pretty : boolean ) : boolean;
var
  list : TStringList;
begin
  Result := false;
  if (not Assigned(obj)) or ( not Assigned(st)) then
    exit;

  list := TStringList.Create;
  try
    if not pretty then
      list.Text := obj.ToJSON
    else
      list.Text := formatJSON( obj );

    list.SaveToStream(st, TEncoding.UTF8);
    Result := true;
  finally
    list.Free;
  end;
end;

{*******************************************************************************
*                   saveJSON
*******************************************************************************}
function saveJSON( obj : TJSONObject; fileName : string ; pretty : boolean  ) : boolean;
var
  st : TFileStream;
begin
  Result := false;

  if not Assigned(obj) then
    exit;
  st:= NIL;
  try
    st := TFileStream.Create(fileName, fmCreate + fmShareDenyNone);
    Result := saveJSON( obj, st,pretty);
  finally
    st.Free;
  end;
end;

{*******************************************************************************
*                   setText
*******************************************************************************}
procedure setText( obj : TJSONObject; name : string ; list : TStrings );
var
  arr : TJSONArray;
  i    : integer;
begin
  arr := TJSONArray.Create;
  for i := 0 to pred(list.Count) do
    begin
      arr.Add( JQuote(list.Strings[i]));
    end;
  JReplace( obj, name, arr);
end;

procedure setText( arr : TJSONArray;  list : TStringList );
var
  i    : integer;
begin
  for i := 0 to pred(list.Count) do
  begin
    arr.Add( JQuote(list.Strings[i]));
  end;
end;

procedure setText( obj : TJSONObject; name : string ; list : TStringList );
begin
  setText( obj, name, TSTrings(list));
end;

{*******************************************************************************
*                   setText
*******************************************************************************}
procedure setText( obj : TJSONObject; name : string ; text : string );
var
  arr : TJSONArray;
  list : TStringList;
  i    : integer;
begin
  arr := TJSONArray.Create;
  list := TStringList.Create;
  list.Text := text;

  for i := 0 to pred(list.Count) do
    begin
      arr.Add( JQuote(list.Strings[i]));
    end;

  list.Free;
  JReplace( obj, name, arr);

end;

{*******************************************************************************
*                   getText
*******************************************************************************}
procedure getText( arr : TJSONArray; list : TStringList );
var
  i   : integer;
begin
  if not Assigned(arr) then
    exit;

  for i := 0 to pred(arr.Count) do
    begin
      list.Add( JUnQuote(arr.Items[i].Value));
    end;
end;

{*******************************************************************************
*                   getText
*******************************************************************************}
procedure getText( obj : TJSONObject; name : string ; list : TStringList );
var
  arr : TJSONArray;
begin
  arr := JArray( obj, name);
  getText( arr, list );
end;


{*******************************************************************************
*                   getIntNumbers
*******************************************************************************}
function  getIntNumbers( obj : TJSONObject; name : string ) : Tlist<integer>;
var
  arr : TJSONArray;
  i   : integer;
begin
  Result := TList<integer>.create;

  arr := JArray( obj, name);
  if not Assigned(arr) then
    exit;

  for i := 0 to pred(arr.Count) do
    begin
      if arr.Items[i] is TJSONNumber then
        Result.Add((arr.Items[i] as TJSONNumber).AsInt);
    end;
end;

{*******************************************************************************
*                   ac_ru_runExecute
*******************************************************************************}
function getText( obj : TJSONObject; name : string ) : String;
var
  arr : TJSONArray;
  list: TStringList;
  i   : integer;
begin
  arr := JArray( obj, name);
  if not Assigned(arr) then
    exit;

  list := TStringList.Create;
  for i := 0 to pred(arr.Count) do
    begin
      list.Add( JUnQuote(arr.Items[i].Value));
    end;

  Result := list.Text;
  list.Free;
end;

{*******************************************************************************
*                   JQuote
*******************************************************************************}
function JQuote( s : string ) : String;
begin
  Result := stringreplace( s, #$08, '\b', [rfReplaceAll, rfIgnoreCase]);
  Result := stringreplace( s, #$09, '\t', [rfReplaceAll, rfIgnoreCase]);
  Result := stringreplace( s, #$0A, '\n', [rfReplaceAll, rfIgnoreCase]);
  Result := stringreplace( s, #$0C, '\f', [rfReplaceAll, rfIgnoreCase]);
  Result := stringreplace( s, #$0D, '\r', [rfReplaceAll, rfIgnoreCase]);
  Result := stringreplace( s, '\',  '\\', [rfReplaceAll, rfIgnoreCase]);
end;


function JQuote_old( s : string ) : String;
var
  i : integer;
  c : char;
begin
  for i := 1 to pred(Length(s)) do
    begin
      c := s[i];
      case c of
        #$08 : Result := Result + '\b';
        #$09 : Result := Result + '\t';
        #$0A : Result := Result + '\n';
        #$0c : Result := Result + '\f';
        #$0D : Result := Result + '\r';
        '\'  : Result := Result + '\\';
      else
        Result:= Result + c;
      end;
    end;
end;

{*******************************************************************************
*                   JUnQuote
*******************************************************************************}
function JUnQuote( s : string ) : String;
begin
  Result := stringreplace( s, '\b', #$08, [rfReplaceAll, rfIgnoreCase]);
  Result := stringreplace( s, '\t', #$09, [rfReplaceAll, rfIgnoreCase]);
  Result := stringreplace( s, '\n', #$0A, [rfReplaceAll, rfIgnoreCase]);
  Result := stringreplace( s, '\f', #$0C, [rfReplaceAll, rfIgnoreCase]);
  Result := stringreplace( s, '\r', #$0D, [rfReplaceAll, rfIgnoreCase]);
  Result := stringreplace( s, '\\', '\', [rfReplaceAll, rfIgnoreCase]);
end;

{*******************************************************************************
*                   JDeleteKey
*******************************************************************************}
function JDeleteKey( obj : TJSONObject ; name : String ) : boolean;
var
  p : TJSONPair;
begin
  Result := false;
  if not Assigned(obj) then
    exit;
   p:= obj.RemovePair(name);

   if Assigned(p) then
   begin
    p.Free;
    Result := true;
   end;
end;
{*******************************************************************************
*                   JExistsKey
*******************************************************************************}
function JExistsKey( obj : TJSONObject ; name : String ) : boolean;
var
  val : TJSONValue;
begin
  Result := false;
  if not Assigned(obj) then
    exit;
  val := obj.GetValue(name);

  Result := Assigned(val);
end;
{*******************************************************************************
*                   JResult
*******************************************************************************}
procedure JResult( obj : TJSONObject ; ok : Boolean ; text : string );
begin
  if not Assigned(obj) then
    exit;

  JReplace( obj, 'result', ok);
  JReplace( obj, 'text', text);
end;

{*******************************************************************************
*                   JFromText
*******************************************************************************}
function JFromText( text : string) : TJSONObject;
begin
  Result := TJSONObject.ParseJSONValue(text) as TJSONObject;
end;

{*******************************************************************************
*                   JValueFromText
*******************************************************************************}
function JValueFromText( text : string ) : TJSONValue;
begin
  Result := TJSONObject.ParseJSONValue(text)
end;

{*******************************************************************************
*                   JResponse
*******************************************************************************}
procedure JResponse( data : TJSONObject ; state : boolean ; text : string );
begin
  JResult( data, state, text );
end;


function parseArray( arr : TJSONArray; indent : string ) : string;
var
  spc   : string;
  i, anz: integer;
  val     : TJSONValue;
begin
  spc := indent + AddSpc;
  Result := indent + '['+sLineBreak;

  anz := pred(arr.Count);
  for i := 0 to anz do
  begin
    val := arr.Items[i];

    if val is TJSONArray then
      Result := Result + parseArray(val as TJSONArray, spc)
    else if val is TJSONObject then
      Result := Result + parseObject( val as TJSONObject, spc )
    else
      Result := Result + spc + val.ToJSON;
    if i < anz then
      Result := Result +',';

    Result := Result + sLineBreak;

  end;
  Result := Result + indent + ']';
end;

function ParseObject( obj : TJSONObject; indent : string ) : string;
var
  spc : string;
  i, anz   : integer;
  p   : TJSONPair;
begin
  spc := indent + AddSpc;
  Result := indent + '{'+sLineBreak;
  anz := pred(obj.Count);
  for i := 0 to anz do
  begin
    p := obj.Pairs[i];
    if (p.JsonValue is TJSONArray) then
    begin
      Result := Result + spc+p.JsonString.ToString +':'+sLineBreak;
      Result := Result + parseArray( p.JsonValue as TJSONArray, spc );
    end
    else if (p.JsonValue is TJSONObject) then
    begin
      Result := Result + spc+p.JsonString.ToString +':'+sLineBreak;
      Result := Result + ParseObject( p.JsonValue as TJSONObject, spc );
    end
    else
      Result := Result + spc + p.ToJSON;
    if i < anz then
      Result := Result +',';

    Result := Result + sLineBreak;
  end;
  Result := Result + indent + '}';
end;

function formatJSON( obj : TJSONObject; indend : integer ) : string;
var
  i : integer;
begin
  Result := '';
  if not  Assigned(obj) then
    exit;

  if indend <> -1 then
  begin
    AddSpc := '';
    for i := 0 to pred(indend) do
      AddSpc := AddSpc + ' ';
  end;

  Result := ParseObject( obj, '' );
end;

procedure JAction( data : TJSONObject; action : string );
begin
  JReplace( data, 'action', action);
end;

function JArrayToInteger( data : TJSONObject; name : string ) : TList<integer>;
begin
  result := JArrayToInteger(JArray( data, name));
end;

function JArrayToInteger( arr : TJSONArray ) : TList<integer>;
var
  i : integer;
begin
  Result := TList<integer>.create;
  if not Assigned(arr) then exit;

  for i := 0 to pred(arr.Count) do begin
    Result.Add((arr.Items[i] as TJSONNumber).AsInt);
  end;
end;

function IntListToJArray( var list : TList<integer> ) : TJSONArray;
var
  nr :  integer;
begin
  Result := TJSONArray.Create;
  for nr in list do
    Result.AddElement(TJSONNumber.Create(nr));
end;

{ TCustomerIterator }

function TArrayIterator.count: integer;
begin
  Result := 0;
  if Assigned(fArray) then
    Result := fArray.Count;
end;

constructor TArrayIterator.Create(const arr: TJSONArray);
begin
  fArray := arr;
  Reset;

end;

function TArrayIterator.CurrentItem: TJSONObject;
begin
  Result := nil;
  if (fArray <> nil) and
     (
       (fCurrentItem >= 0) and (fCurrentItem < fArray.Count )
     ) then
  Result := fArray.Items[ fCurrentItem ] as TJSONObject;
end;

function TArrayIterator.Next: Boolean;
begin
  Inc(fCurrentItem);
  Result := (fArray <> nil) and (fCurrentItem < fArray.Count );
end;

procedure TArrayIterator.Reset;
begin
  fCurrentItem := -1;
end;


procedure purge( var list : TStringList );
var
  i : Integer;
begin
  for i := Pred(list.Count) downto 0 do
  begin
    if trim(list[i]) = '' then
      list.Delete(i);
  end;
end;


initialization
  AddSpc:= '  ';

end.


