﻿unit i_waehlerliste;

interface

uses
  System.JSON, System.Generics.Collections;

type
  IWaehler = interface;
  IWaehlerListe = interface;

  IWaehler = interface
  ['{3065D567-237C-497D-81E2-9A2200BA4B14}']
      function getPersNr : string;
      procedure setPersNr( value : string );
      function getName : string;
      procedure setName( value : string );
      function getVorname : string;
      procedure setVorname( value : string );
      function getAnrede : string;
      procedure setAnrede( value : string );
      function getAbteilung : string;
      procedure setAbteilung( value : string );

      property PersNr: String read getPersNr write setPersNr;
      property Name: string read getName write setName;
      property Vorname: string read getVorname write setVorname;
      property Anrede: string read getAnrede write setAnrede;
      property Abteilung: string read getAbteilung write setAbteilung;

      procedure fromJSON( data : TJSONObject ); overload;
      procedure fromJSON( arr : TJSONArray ); overload;

      function toJSON : TJSONObject;
      function toSimpleJSON : TJSONArray;

      function compare( value : IWaehler ) : Boolean;

      function clone : IWaehler;
      procedure Assign( value : IWaehler );

      procedure release;

  end;

  IWaehlerListe = interface
  ['{963337A8-C7D5-49C1-A853-CAB9C9E0F056}']
      procedure fromSimpleJSON( data : TJSONObject );
      procedure fromFullJSON( data : TJSONObject );

      function getitems: TList<IWaehler>;


      property Items : TList<IWaehler> read getitems;

      function new : IWaehler;
      function add( data : TJSONObject) : IWaehler; overload;
      function add( arr : TJSONArray) : IWaehler; overload;
      procedure add( waehler : IWaehler); overload;

      function getWaehler( prsnr : string ) : IWaehler;
      function hasWaehler( prsnr : string ) : boolean;

      procedure fromJSON( data : TJSONObject );   overload;
      function loadFromFile( filename : string ) : boolean;

      function toJSON : TJSONObject;
      function toSimpleJSON : TJSONObject;
      function saveToFile( fname : string ) : Boolean;

      procedure Assign( src : IWaehlerListe );
      procedure clear;

      procedure delete( persnr : string );

      procedure release;

  end;


implementation

end.
