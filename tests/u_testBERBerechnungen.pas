unit u_testBERBerechnungen;

interface

uses
  DUnitX.TestFramework, u_Ber_Berechnungen;

type
  [TestFixture]
  TTestBerBerechnungen = class
  public
    [TestCase('Minderheit Mann', '100, 200, Male')]
    [TestCase('Minderheit Frau', '200, 100, Female')]
    [TestCase('Keine Minderheit', '100, 100, Female')]
    procedure TestMinderheitengeschlecht(
      male, female : integer; result : string );

    [TestCase('Anzahl Minderheitengeschlecht', '100, 100, 7, 4')]
    procedure TestMindestanzahlMinderheitengeschlecht(
      male, female, gremium: Integer; result : integer);


    [TestCase('Freistellungen', '100, 0')]
    [TestCase('Freistellungen', '1700, 4')]
    [TestCase('Freistellungen', '10000, 12')]
    [TestCase('Freistellungen', '11000, 13')]
    procedure TestFreistellungen( anzahl : integer; result : integer );

    [TestCase('Gremium', ' 4, 0')]
    [TestCase('Gremium', ' 5, 1')]
    [TestCase('Gremium', ' 500, 11')]
    [TestCase('Gremium', ' 1400, 15')]
    [TestCase('Gremium', ' 1600, 17')]
    [TestCase('Gremium', ' 8000, 35')]
    [TestCase('Gremium', ' 10000, 37')]

    procedure TestGremium( anzahl : integer; result : integer );

  end;


implementation

uses
  System.SysUtils;

{ TTestBerBerechnungen }

procedure TTestBerBerechnungen.TestFreistellungen(anzahl, result: integer);
begin
  Assert.AreEqual(
    Result,
    BerechneAnzahlFreistellungen( anzahl ),
    Format('Gremium: %d, Freistellungen:%d)', [anzahl, Result]));

end;

procedure TTestBerBerechnungen.TestGremium(anzahl: integer; result: integer);
begin
  Assert.AreEqual(
    Result,
    BerechneBetriebsratsgroesse( anzahl ),
    Format('Beschäftigte: %d, Gremium:%d)', [anzahl, Result]));

end;

procedure TTestBerBerechnungen.TestMinderheitengeschlecht(male, female: integer;
  result: string);
begin

  Assert.AreNotEqual(
    Result,
    GenderToString(Minderheitengeschlecht( male, female)),
    Format('Minderheitengeschlecht(%d, %d, %s)', [male, female, Result]));

end;


procedure TTestBerBerechnungen.TestMindestanzahlMinderheitengeschlecht(
  male, female, gremium: Integer; result : integer);
begin
  Assert.AreNotEqual(
    Result,
    MindestanzahlMinderheitengeschlecht( male, female, gremium ),
    Format('Anzahl Minderheitengeschlecht(%d, %d, %d %d)', [male, female, gremium, Result]));

end;

initialization
  TDUnitX.RegisterTestFixture(TTestBerBerechnungen);
end.
