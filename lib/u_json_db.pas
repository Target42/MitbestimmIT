unit u_json_db;

interface

uses
  System.JSON, Data.DB;

function DataSourceSimpleFields( src :TDataSet ) : TJSONArray;
function DataSourceFields( src :TDataSet ) : TJSONArray;
function DataSourceToJson( src :TDataSet; simple : boolean  = true ) : TJSONObject;
procedure JsonToDataSet( data : TJSONObject; dset : TDataSet );

implementation

uses
  u_json, System.SysUtils, System.Generics.Collections;
// In der "interface"-Sektion deiner Unit oder als globale Konstante
const
  FieldTypeNames: array[TFieldType] of string = (
    'ftUnknown', 'ftString', 'ftSmallint', 'ftInteger', 'ftWord',
    'ftBoolean', 'ftFloat', 'ftCurrency', 'ftBCD', 'ftDate', 'ftTime', 'ftDateTime',
    'ftBytes', 'ftVarBytes', 'ftAutoInc', 'ftBlob', 'ftMemo', 'ftGraphic', 'ftFmtMemo',
    'ftParadoxOle', 'ftDBaseOle', 'ftTypedBinary', 'ftCursor', 'ftFixedChar', 'ftWideString',
    'ftLargeint', 'ftADT', 'ftArray', 'ftReference', 'ftDataSet', 'ftOraBlob', 'ftOraClob',
    'ftVariant', 'ftInterface', 'ftIDispatch', 'ftGuid', 'ftTimeStamp', 'ftFMTBcd',
    'ftFixedWideChar', 'ftWideMemo', 'ftOraTimeStamp', 'ftOraInterval',
    'ftLongWord', 'ftShortint', 'ftByte', 'ftExtended', 'ftConnection', 'ftParams', 'ftStream',
    'ftTimeStampOffset', 'ftObject', 'ftSingle'
  );

function DataTypeToString(FieldType: TFieldType): string;
begin
  Result := FieldTypeNames[FieldType];
end;

function StringToDataType(const FieldTypeName: string): TFieldType;
var
  FieldType: TFieldType;
begin
  Result := ftUnknown;

  for FieldType := Low(TFieldType) to High(TFieldType) do
  begin
    if SameText(FieldTypeName, FieldTypeNames[FieldType]) then
    begin
      Result := FieldType;
      break;
    end;
  end;
end;

function DataSourceSimpleFields( src :TDataSet ) : TJSONArray;
var
  i   : integer;
begin
  Result := TJSONArray.Create;

  for I := 0 to pred(src.Fields.Count) do
  begin
    if  src.Fields[i].DataType <> ftBlob then
      Result.Add(src.Fields[i].Name);
  end;
end;

function DatasourceFields( src :TDataSet ) : TJSONArray;
var
  row : TJSONObject;
  i   : integer;
  field : TField;
begin
  Result := TJSONArray.Create;

  for I := 0 to pred(src.Fields.Count) do
  begin
    field := src.Fields[i];
    if field.DataType <> TFieldType.ftBlob then
    begin
      row := TJSONObject.Create;

      field := src.Fields[i];

      JReplace(row, 'name', field.Name);
      JReplace(row, 'title', field.Name);
      JReplace(row, 'visible', field.Visible);
      JReplace(row, 'type', DataTypeToString(field.DataType));
      JReplace(row, 'size', field.Size);

      Result.AddElement(row);
    end;
  end;

end;

function DataSourceToJson( src :TDataSet; simple : boolean ) : TJSONObject;
var
  i : integer;
  arr : TJSONArray;
  data: TJSONArray;
begin
  Result := TJSONObject.Create;
  if simple then
    JReplace(result, 'fields', DataSourceSimpleFields(src))
  else
    JReplace(result, 'fields', DataSourceFields(src));

  data := TJSONArray.Create;
  with src do
  begin
    first;

    while not eof do
    begin
      arr := TJSONArray.Create;
      for i := 0 to pred( Fields.Count) do
      begin
        arr.Add(FieldByName(Fields[i].Name).AsString);
      end;
      data.AddElement(arr);
      next;
    end;
  end;
  JReplace(result, 'data', data);

end;

procedure JsonToDataSet( data : TJSONObject; dset : TDataSet );
  procedure addFields(arr : TJSONArray);
  var
    i : integer;
    field: TField;
    row : TJSONObject;
  begin
    for i := 0 to pred(data.Count) do
    begin
      row := arr[i] as TJSONObject;

      field             := TField.Create(dset);
      dset.Fields.Add(field);
      field.Name        := JString( row, 'name');
      field.SetFieldType(StringToDataType(JString( row, 'name')));
      field.Size        := JInt( row, 'size');
      field.Visible     := JBool( row, 'visible');
    end;
  end;
var
  i   : integer;
  j   : integer;
  arr : TJSONArray;
  row : TJSONArray;
begin
  addFields(JArray(data, 'fields'));

  arr := JArray(data, 'data');
  for i := 0 to pred(arr.Count) do
  begin
    dset.Append;
    row := arr.Items[i] as TJSONArray;
    for j := 0 to pred(row.Count) do
    begin
      dset.Fields.Fields[j].AsString := row.Items[i].ToString;
    end;
    dset.Post;
  end;

end;

end.

