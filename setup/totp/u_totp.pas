unit u_totp;

interface

uses
  Vcl.ExtCtrls, Vcl.Graphics, System.Types;

const
  TOTPTimeStep = 30;

procedure setUTC( value : TDateTime );
function getUTC : TDateTime;

function GenerateBase32Secret(Length: Integer = 16): string;
function SecondsRemaining(TimeStep: Integer = TOTPTimeStep): Integer;
function GenerateTOTP(const Base32Secret: string; TimeStep: Integer = TOTPTimeStep; Digits: Integer = 6; TimeOffset: Integer = 0): string;
function DrawQRCodeToBitmap(const Data: string; PixelsPerModule: Integer = 5) : TBitmap;
procedure DrawQRCodeToImage(const Data: string; Image: TImage; PixelsPerModule: Integer = 5);

implementation

uses
  System.Hash, DelphiZXingQRCode, Math, System.DateUtils, System.SysUtils;

const

  TimeDelta = -1;
  Base32Chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567';

var
  ntp_UTC : TDateTime;

procedure setUTC( value : TDateTime );
begin
  ntp_UTC := value;
end;

function getUTC : TDateTime;
begin
  if ntp_UTC = 0.0 then
    Result := TDateTime.NowUTC
  else
    Result := ntp_UTC;
end;

function GenerateBase32Secret(Length: Integer): string;
var
  i: Integer;
  len : integer;
begin
  Result := '';
  len := System.Length(Base32Chars);
  for i := 1 to Length do
  begin
    Result := Result + Base32Chars[Random(len)+1];
  end;
end;

function SecondsRemaining(TimeStep: Integer): Integer;
begin
   Result := TimeStep - ((DateTimeToUnix(TDateTime.NowUTC) + TimeDelta) mod TimeStep);
end;

function GenerateTOTP(const Base32Secret: string; TimeStep: Integer; Digits: Integer; TimeOffset: Integer): string;
var
  Key: TBytes;
  Counter: Int64;
  CounterBytes: TBytes;
  Hash: TBytes;
  Offset, BinaryCode, OTP: Integer;
  i: Integer;
begin
  // Base32 decode
  SetLength(Key, (Length(Base32Secret) * 5) div 8);
  var BitBuffer := 0;
  var BitsLeft := 0;
  var j := 0;
  for i := 1 to Length(Base32Secret) do
  begin
    var Ch := UpCase(Base32Secret[i]);
    if Ch = '=' then Break;
    BitBuffer := (BitBuffer shl 5) or (Pos(Ch, Base32Chars) - 1);
    Inc(BitsLeft, 5);
    if BitsLeft >= 8 then
    begin
      Key[j] := Byte((BitBuffer shr (BitsLeft - 8)) and $FF);
      Inc(j);
      Dec(BitsLeft, 8);
    end;
  end;
  SetLength(Key, j);

  // Zeitbasiert
  Counter := ((DateTimeToUnix(getUTC) + TimeDelta) div TimeStep) + TimeOffset;
  SetLength(CounterBytes, 8);
  for i := 7 downto 0 do
  begin
    CounterBytes[i] := Counter and $FF;
    Counter := Counter shr 8;
  end;

  Hash := THashSHA1.getHMACAsBytes(CounterBytes, Key);
  Offset := Hash[High(Hash)] and $0F;

  BinaryCode :=
    ((Hash[Offset] and $7F) shl 24) or
    ((Hash[Offset + 1] and $FF) shl 16) or
    ((Hash[Offset + 2] and $FF) shl 8) or
    (Hash[Offset + 3] and $FF);

  OTP := BinaryCode mod Trunc(IntPower(10, Digits));
  Result := Format('%.*d', [Digits, OTP]);
end;

function DrawQRCodeToBitmap(const Data: string; PixelsPerModule: Integer) : TBitmap;
var
  QR: TDelphiZXingQRCode;
  x, y: Integer;
begin
  QR := TDelphiZXingQRCode.Create;
  Result := TBitmap.Create;
  try
    QR.Data := Data;
    QR.Encoding := TQRCodeEncoding.qrUTF8BOM;
    QR.QuietZone := 4;
    Result.SetSize(QR.Columns * PixelsPerModule, QR.Rows * PixelsPerModule);
    Result.PixelFormat := pf24bit;
    Result.Canvas.Brush.Color := clWhite;
    Result.Canvas.FillRect(Result.Canvas.ClipRect);
    Result.Canvas.Brush.Color := clBlack;

    for y := 0 to QR.Rows - 1 do
      for x := 0 to QR.Columns - 1 do
        if QR.IsBlack[y, x] then
          Result.Canvas.FillRect(Rect(
            x * PixelsPerModule,
            y * PixelsPerModule,
            (x + 1) * PixelsPerModule,
            (y + 1) * PixelsPerModule));

  finally
    QR.Free;
  end;
end;

procedure DrawQRCodeToImage(const Data: string; Image: TImage; PixelsPerModule: Integer);
var
  QR: TDelphiZXingQRCode;
  Bitmap: TBitmap;
begin
  QR := TDelphiZXingQRCode.Create;
  Bitmap := DrawQRCodeToBitmap( data, PixelsPerModule );
  Image.Picture.Assign(Bitmap);
  QR.Free;
  Bitmap.Free;
end;

initialization
  ntp_UTC := 0.0;
  Randomize;

end.
