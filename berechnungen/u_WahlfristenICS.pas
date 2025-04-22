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
unit u_WahlfristenICS;


interface

uses
  SysUtils, Classes, u_BRWahlFristen;

procedure ExportiereWahlfristenAlsICS(const Datei: string; const Fristen: TWahlFristen);

implementation

uses
  System.DateUtils;

{
  Converts a given date to a string formatted as 'yyyymmdd' for use in ICS (iCalendar) files.

  @param Datum The date to be converted.
  @return A string representing the date in 'yyyymmdd' format.
}
function ICSDatum(Datum: TDate): string;
begin
  Result := FormatDateTime('yyyymmdd', Datum);
end;

{
  Writes a line of text to a stream in ICS (iCalendar) format, appending a CRLF sequence.

  @param F The stream to which the line will be written.
  @param Zeile The string representing the line to be written to the stream.
}
procedure ICSZeile(const F: TStream; const Zeile: string);
begin
  F.Write(PAnsiChar(AnsiString(Zeile + #13#10))^, Length(Zeile) + 2);
end;

{
  Creates an ICS calendar entry and writes it to the provided stream.

  @param F     The stream to which the ICS calendar entry will be written.
  @param Datum The date of the event.
  @param Titel The title of the event, which will be used as both the summary and description.
}
procedure ICSKalendereintrag(const F: TStream; const Datum: TDate; const Titel: string);
begin
  ICSZeile(F, 'BEGIN:VEVENT');
  ICSZeile(F, 'DTSTART;VALUE=DATE:' + ICSDatum(Datum));
  ICSZeile(F, 'DTEND;VALUE=DATE:' + ICSDatum(IncDay(Datum, 1)));
  ICSZeile(F, 'SUMMARY:' + Titel);
  ICSZeile(F, 'DESCRIPTION:' + Titel);
  ICSZeile(F, 'END:VEVENT');
end;

{
  This procedure exports election deadlines (Wahlfristen) as an ICS (iCalendar) file.

  @param Datei   The file path where the ICS file will be created.
  @param Fristen A TWahlFristen object containing the election deadlines to be exported.

  The procedure creates a new ICS file and writes calendar entries for the following events:
  - Election day (Wahltag)
  - Latest appointment of the election committee (Späteste Bestellung Wahlvorstand)
  - Deadline for the election announcement (Wahlausschreiben spätestens)
  - End of the proposal submission period (Ende Vorschlagsfrist)
  - Announcement of valid proposals (Bekanntgabe gültiger Wahlvorschläge)
  - Announcement of election results (Bekanntgabe Wahlergebnis)
  - End of the contestation period (Fristende Wahlanfechtung)

  The ICS file is structured according to the iCalendar format, starting with "BEGIN:VCALENDAR"
  and ending with "END:VCALENDAR". Each event is added as a calendar entry using the
  ICSKalendereintrag helper procedure.

  The file is created using a TFileStream with fmCreate mode, ensuring that any existing file
  at the specified path will be overwritten. The TFileStream is properly freed after use.
}
procedure ExportiereWahlfristenAlsICS(const Datei: string; const Fristen: TWahlFristen);
var
  F: TFileStream;
begin
  F := TFileStream.Create(Datei, fmCreate);
  try
    ICSZeile(F, 'BEGIN:VCALENDAR');
    ICSZeile(F, 'VERSION:2.0');
    ICSZeile(F, 'PRODID:-//MitbestimmIT//DE');

    ICSKalendereintrag(F, Fristen.Wahltag, 'Wahltag');
    ICSKalendereintrag(F, Fristen.SpaetesterWahlvorstand, 'Späteste Bestellung Wahlvorstand');
    ICSKalendereintrag(F, Fristen.WahlausschreibenDatum, 'Wahlausschreiben spätestens');
    ICSKalendereintrag(F, Fristen.VorschlagsfristEnde, 'Ende Vorschlagsfrist');
    ICSKalendereintrag(F, Fristen.BekanntgabeVorschlaege, 'Bekanntgabe gültiger Wahlvorschläge');
    ICSKalendereintrag(F, Fristen.BekanntgabeErgebnis, 'Bekanntgabe Wahlergebnis');
    ICSKalendereintrag(F, Fristen.AnfechtungsfristEnde, 'Fristende Wahlanfechtung');

    ICSZeile(F, 'END:VCALENDAR');
  finally
    F.Free;
  end;
end;

end.

