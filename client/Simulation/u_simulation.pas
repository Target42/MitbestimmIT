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

unit u_simulation;

interface

uses
  u_WahlhelferListe, u_wahllokal, u_Wahlvorstand, u_Waehlerliste;

type
  TSimulation = class
    private
      m_path            : string;
      m_vorstand        : IWahlvorstand;
      m_waehler         : TWaehlerListe;
      m_wahlhelferListe : TWahlhelferListe;
      m_wahllokale      : TWahlLokalListe;
    public
      constructor create;
      Destructor Destroy; override;

      property Vorstand   : IWahlvorstand read m_vorstand;
      property WahlHelfer : TWahlhelferListe read m_wahlhelferListe;
      property WahlLokale : TWahlLokalListe read m_wahllokale;

      procedure load( path : string );
      function save : boolean;

      function new( path : string ) : boolean;
  end;

implementation

uses
  System.SysUtils;

{ TSimulation }

constructor TSimulation.create;
begin
  m_vorstand        := createWahlvorstand;
  m_wahlhelferListe := TWahlhelferListe.Create;
  m_wahllokale      := TWahlLokalListe.create;
  m_waehler         := TWaehlerListe.create;
end;

destructor TSimulation.Destroy;
begin
  m_wahlhelferListe.Free;
  m_wahllokale.Free;
  m_vorstand.release;
  m_wahlhelferListe.Free;
  inherited;
end;

procedure TSimulation.load(path: string);
begin
  m_path := path;
end;

function TSimulation.new(path: string): boolean;
begin
  m_path := path;
  Result := Forcedirectories( m_path );
end;

function TSimulation.save: boolean;
begin
  Result := false;
end;

end.
