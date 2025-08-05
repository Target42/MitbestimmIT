object CreateDBMode: TCreateDBMode
  Height = 480
  Width = 640
  object FDScript1: TFDScript
    SQLScripts = <
      item
        Name = 'Tables'
        SQL.Strings = (
          
            '/* ============================================================ ' +
            '*/'
          
            '/*   Database name:  MODEL_4                                    ' +
            '*/'
          
            '/*   DBMS name:      InterBase                                  ' +
            '*/'
          
            '/*   Created on:     30.07.2025  20:21                          ' +
            '*/'
          
            '/* ============================================================ ' +
            '*/'
          ''
          'create generator gen_ma_id;'
          'create generator gen_wl_id;'
          'create generator gen_wh_id;'
          'create generator gen_wt_id;'
          'create generator gen_wd_id;'
          'create generator gen_sz_id;'
          'create generator gen_lg_id;'
          'create generator gen_aw_id;'
          
            '/* ============================================================ ' +
            '*/'
          
            '/*   Table: WD_WAHLDATEN                                        ' +
            '*/'
          
            '/* ============================================================ ' +
            '*/'
          'create table WD_WAHLDATEN'
          '('
          
            '    WD_ID                           INTEGER                not n' +
            'ull,'
          
            '    WD_KEY                          VARCHAR(100)                ' +
            '   ,'
          
            '    WD_DATA                         BLOB                        ' +
            '   ,'
          '    constraint PK_WD_WAHLDATEN primary key (WD_ID)'
          ');'
          ''
          
            '/* ============================================================ ' +
            '*/'
          
            '/*   Table: LG_LOG                                              ' +
            '*/'
          
            '/* ============================================================ ' +
            '*/'
          'create table LG_LOG'
          '('
          
            '    LG_ID                           INTEGER                     ' +
            '   ,'
          
            '    LG_STAMP                        TIMESTAMP                   ' +
            '   ,'
          
            '    LG_DATA                         BLOB                        ' +
            '   '
          ');'
          ''
          
            '/* ============================================================ ' +
            '*/'
          
            '/*   Table: MA_MITARBEITER                                      ' +
            '*/'
          
            '/* ============================================================ ' +
            '*/'
          'create table MA_MITARBEITER'
          '('
          
            '    MA_ID                           INTEGER                not n' +
            'ull,'
          
            '    MA_PERSNR                       VARCHAR(10)                 ' +
            '   ,'
          
            '    MA_NAME                         VARCHAR(100)                ' +
            '   ,'
          
            '    MA_VORNAME                      VARCHAR(100)                ' +
            '   ,'
          
            '    MA_GENDER                       CHAR(1)                     ' +
            '   ,'
          
            '    MA_ABTEILUNG                    VARCHAR(20)                 ' +
            '   ,'
          '    constraint PK_MA_MITARBEITER primary key (MA_ID)'
          ');'
          ''
          
            '/* ============================================================ ' +
            '*/'
          
            '/*   Index: MA_MITARBEITER_PERSNR                               ' +
            '*/'
          
            '/* ============================================================ ' +
            '*/'
          
            'create unique ASC index MA_MITARBEITER_PERSNR on MA_MITARBEITER ' +
            '(MA_PERSNR);'
          ''
          
            '/* ============================================================ ' +
            '*/'
          
            '/*   Index: MA_MITARBEITER_NAME                                 ' +
            '*/'
          
            '/* ============================================================ ' +
            '*/'
          
            'create ASC index MA_MITARBEITER_NAME on MA_MITARBEITER (MA_NAME,' +
            ' MA_VORNAME, MA_ABTEILUNG);'
          ''
          
            '/* ============================================================ ' +
            '*/'
          
            '/*   Table: WL_WAHL_LOKAL                                       ' +
            '*/'
          
            '/* ============================================================ ' +
            '*/'
          'create table WL_WAHL_LOKAL'
          '('
          
            '    WL_ID                           INTEGER                not n' +
            'ull,'
          
            '    WL_BAU                          VARCHAR(100)                ' +
            '   ,'
          
            '    WL_STOCKWERK                    VARCHAR(10)                 ' +
            '   ,'
          
            '    WL_RAUM                         VARCHAR(10)                 ' +
            '   ,'
          '    constraint PK_WL_WAHL_LOKAL primary key (WL_ID)'
          ');'
          ''
          
            '/* ============================================================ ' +
            '*/'
          
            '/*   Table: WT_WAHL_LISTE                                       ' +
            '*/'
          
            '/* ============================================================ ' +
            '*/'
          'create table WT_WAHL_LISTE'
          '('
          
            '    WT_ID                           INTEGER                not n' +
            'ull,'
          
            '    WT_NAME                         VARCHAR(150)                ' +
            '   ,'
          
            '    WT_KURZ                         VARCHAR(15)                 ' +
            '   ,'
          '    constraint PK_WT_WAHL_LISTE primary key (WT_ID)'
          ');'
          ''
          
            '/* ============================================================ ' +
            '*/'
          
            '/*   Index: WT_WAHL_LISTE_NAME                                  ' +
            '*/'
          
            '/* ============================================================ ' +
            '*/'
          
            'create unique ASC index WT_WAHL_LISTE_NAME on WT_WAHL_LISTE (WT_' +
            'NAME);'
          ''
          
            '/* ============================================================ ' +
            '*/'
          
            '/*   Table: SZ_STIMMZETTEL                                      ' +
            '*/'
          
            '/* ============================================================ ' +
            '*/'
          'create table SZ_STIMMZETTEL'
          '('
          
            '    SZ_ID                           INTEGER                not n' +
            'ull,'
          
            '    SZ_NR                           VARCHAR(20)                 ' +
            '   ,'
          
            '    SZ_GULTIG                       CHAR(1)                     ' +
            '   ,'
          '    constraint PK_SZ_STIMMZETTEL primary key (SZ_ID)'
          ');'
          ''
          
            '/* ============================================================ ' +
            '*/'
          
            '/*   Table: AW_AUSWERTUNG                                       ' +
            '*/'
          
            '/* ============================================================ ' +
            '*/'
          'create table AW_AUSWERTUNG'
          '('
          
            '    AW_ID                           INTEGER                not n' +
            'ull,'
          
            '    AW_TITLE                        VARCHAR(100)                ' +
            '   ,'
          
            '    AW_START                        TIMESTAMP                   ' +
            '   ,'
          
            '    AW_ENDE                         TIMESTAMP                   ' +
            '   ,'
          
            '    AW_ERGEBNIS                     BLOB                        ' +
            '   ,'
          '    constraint PK_AW_AUSWERTUNG primary key (AW_ID)'
          ');'
          ''
          
            '/* ============================================================ ' +
            '*/'
          
            '/*   Table: WH_WAHL_HELFER                                      ' +
            '*/'
          
            '/* ============================================================ ' +
            '*/'
          'create table WH_WAHL_HELFER'
          '('
          
            '    WL_ID                           INTEGER                not n' +
            'ull,'
          
            '    MA_ID                           INTEGER                not n' +
            'ull,'
          
            '    WH_ROLLE                        VARCHAR(100)                ' +
            '   ,'
          '    constraint PK_WH_WAHL_HELFER primary key (WL_ID, MA_ID)'
          ');'
          ''
          
            '/* ============================================================ ' +
            '*/'
          
            '/*   Table: WV_WAHL_VORSTAND                                    ' +
            '*/'
          
            '/* ============================================================ ' +
            '*/'
          'create table WV_WAHL_VORSTAND'
          '('
          
            '    MA_ID                           INTEGER                not n' +
            'ull,'
          
            '    WV_ROLLE                        VARCHAR(100)                ' +
            '   ,'
          
            '    WH_SECRET                       CHAR(32)                    ' +
            '   ,'
          '    constraint PK_WV_WAHL_VORSTAND primary key (MA_ID)'
          ');'
          ''
          
            '/* ============================================================ ' +
            '*/'
          
            '/*   Table: WT_WA                                               ' +
            '*/'
          
            '/* ============================================================ ' +
            '*/'
          'create table WT_WA'
          '('
          
            '    WT_ID                           INTEGER                not n' +
            'ull,'
          
            '    MA_ID                           INTEGER                not n' +
            'ull,'
          '    constraint PK_WT_WA primary key (WT_ID, MA_ID)'
          ');'
          ''
          
            '/* ============================================================ ' +
            '*/'
          
            '/*   Table: BW_BRIEF_WAHL                                       ' +
            '*/'
          
            '/* ============================================================ ' +
            '*/'
          'create table BW_BRIEF_WAHL'
          '('
          
            '    MA_ID                           INTEGER                not n' +
            'ull,'
          
            '    BW_ANTRAG                       DATE                        ' +
            '   ,'
          
            '    BW_VERSENDET                    DATE                        ' +
            '   ,'
          
            '    BW_EMPFANGEN                    DATE                        ' +
            '   ,'
          
            '    BW_UNGULTIG                     CHAR(1)                     ' +
            '   ,'
          '    constraint PK_BW_BRIEF_WAHL primary key (MA_ID)'
          ');'
          ''
          
            '/* ============================================================ ' +
            '*/'
          
            '/*   Table: AW_SZ                                               ' +
            '*/'
          
            '/* ============================================================ ' +
            '*/'
          'create table AW_SZ'
          '('
          
            '    AW_ID                           INTEGER                not n' +
            'ull,'
          
            '    SZ_ID                           INTEGER                not n' +
            'ull,'
          
            '    AW_SZ_STAMP                     TIMESTAMP                   ' +
            '   ,'
          
            '    AW_SZ_DATA                      BLOB                        ' +
            '   ,'
          '    constraint PK_AW_SZ primary key (AW_ID, SZ_ID)'
          ');'
          ''
          'alter table WH_WAHL_HELFER'
          '    add constraint FK_REF_20 foreign key  (WL_ID)'
          '       references WL_WAHL_LOKAL;'
          ''
          'alter table WH_WAHL_HELFER'
          '    add constraint FK_REF_24 foreign key  (MA_ID)'
          '       references MA_MITARBEITER;'
          ''
          'alter table WV_WAHL_VORSTAND'
          '    add constraint FK_REF_30 foreign key  (MA_ID)'
          '       references MA_MITARBEITER;'
          ''
          'alter table WT_WA'
          '    add constraint FK_REF_68 foreign key  (WT_ID)'
          '       references WT_WAHL_LISTE;'
          ''
          'alter table WT_WA'
          '    add constraint FK_REF_72 foreign key  (MA_ID)'
          '       references MA_MITARBEITER;'
          ''
          'alter table BW_BRIEF_WAHL'
          '    add constraint FK_REF_77 foreign key  (MA_ID)'
          '       references MA_MITARBEITER;'
          ''
          'alter table AW_SZ'
          '    add constraint FK_REF_96 foreign key  (AW_ID)'
          '       references AW_AUSWERTUNG;'
          ''
          'alter table AW_SZ'
          '    add constraint FK_REF_100 foreign key  (SZ_ID)'
          '       references SZ_STIMMZETTEL;'
          '')
      end
      item
        Name = 'Trigger'
        SQL.Strings = (
          
            '/* ============================================================ ' +
            '*/'
          
            '/*   Database name:  MODEL_4                                    ' +
            '*/'
          
            '/*   DBMS name:      InterBase                                  ' +
            '*/'
          
            '/*   Created on:     30.07.2025  20:22                          ' +
            '*/'
          
            '/* ============================================================ ' +
            '*/'
          ''
          
            '/*  Insert trigger "ti_aw_auswertung" for table "AW_AUSWERTUNG" ' +
            ' */'
          'set term /;'
          'create trigger ti_aw_auswertung for AW_AUSWERTUNG'
          'before insert as'
          'begin'
          '    new.aw_id = gen_id(gen_aw_id, 1);'
          ''
          'end;/'
          'set term ;/'
          ''
          '/*  Insert trigger "ti_tab_107" for table "LG_LOG"  */'
          'set term /;'
          'create trigger ti_tab_107 for LG_LOG'
          'before insert as'
          'begin'
          '    new.lg_id = gen_id(gen_lg_id, 1);'
          ''
          'end;/'
          'set term ;/'
          ''
          '/*  Insert trigger "ti_tab_1" for table "MA_MITARBEITER"  */'
          'set term /;'
          'create trigger ti_tab_1 for MA_MITARBEITER'
          'before insert as'
          'begin'
          '    new.ma_id = gen_id(gen_ma_id, 1);'
          ''
          'end;/'
          'set term ;/'
          ''
          
            '/*  Insert trigger "ti_sz_stimmzettel" for table "SZ_STIMMZETTEL' +
            '"  */'
          'set term /;'
          'create trigger ti_sz_stimmzettel for SZ_STIMMZETTEL'
          'before insert as'
          'begin'
          '    new.sz_id = gen_id(gen_sz_id, 1);'
          ''
          'end;/'
          'set term ;/'
          ''
          
            '/*  Insert trigger "ti_wd_wahldaten" for table "WD_WAHLDATEN"  *' +
            '/'
          'set term /;'
          'create trigger ti_wd_wahldaten for WD_WAHLDATEN'
          'before insert as'
          'begin'
          '    new.wd_id = gen_id(gen_wd_id, 1);'
          ''
          'end;/'
          'set term ;/'
          ''
          '/*  Insert trigger "ti_tab_2" for table "WL_WAHL_LOKAL"  */'
          'set term /;'
          'create trigger ti_tab_2 for WL_WAHL_LOKAL'
          'before insert as'
          'begin'
          '    new.wl_id = gen_id(gen_wl_id, 1);'
          ''
          'end;/'
          'set term ;/'
          ''
          
            '/*  Insert trigger "ti_wt_wahl_liste" for table "WT_WAHL_LISTE" ' +
            ' */'
          'set term /;'
          'create trigger ti_wt_wahl_liste for WT_WAHL_LISTE'
          'before insert as'
          'begin'
          '    new.wt_id = gen_id(gen_wt_id, 1);'
          ''
          'end;/'
          'set term ;/'
          '')
      end>
    Connection = FDConnection1
    Params = <>
    Macros = <>
    Left = 312
    Top = 96
  end
  object FDConnection1: TFDConnection
    Params.Strings = (
      'DriverID=FB'
      'User_Name=sysdba'
      'Password=masterkey')
    Left = 120
    Top = 64
  end
end
