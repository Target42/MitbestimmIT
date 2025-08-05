/* ============================================================ */
/*   Database name:  MODEL_4                                    */
/*   DBMS name:      InterBase                                  */
/*   Created on:     05.08.2025  19:37                          */
/* ============================================================ */

create generator gen_ma_id;
create generator gen_wl_id;
create generator gen_wh_id;
create generator gen_wt_id;
create generator gen_wd_id;
create generator gen_sz_id;
create generator gen_lg_id;
create generator gen_aw_id;
create generator gen_wa_id;
/* ============================================================ */
/*   Table: SZ_STIMMZETTEL                                      */
/* ============================================================ */
create table SZ_STIMMZETTEL
(
    SZ_ID                           INTEGER                not null,
    SZ_NR                           VARCHAR(20)                    ,
    SZ_GULTIG                       CHAR(1)                        ,
    constraint PK_SZ_STIMMZETTEL primary key (SZ_ID)
);

/* ============================================================ */
/*   Table: WA_WAHL                                             */
/* ============================================================ */
create table WA_WAHL
(
    WA_ID                           INTEGER                not null,
    WA_TITLE                        VARCHAR(150)                   ,
    WA_SIMU                         CHAR(1)                        ,
    WA_ACTIVE                       CHAR(1)                        ,
    constraint PK_WA_WAHL primary key (WA_ID)
);

/* ============================================================ */
/*   Table: MA_MITARBEITER                                      */
/* ============================================================ */
create table MA_MITARBEITER
(
    MA_ID                           INTEGER                not null,
    WA_ID                           INTEGER                not null,
    MA_PERSNR                       VARCHAR(10)                    ,
    MA_NAME                         VARCHAR(100)                   ,
    MA_VORNAME                      VARCHAR(100)                   ,
    MA_GENDER                       CHAR(1)                        ,
    MA_ABTEILUNG                    VARCHAR(20)                    ,
    constraint PK_MA_MITARBEITER primary key (MA_ID, WA_ID)
);

/* ============================================================ */
/*   Index: MA_MITARBEITER_PERSNR                               */
/* ============================================================ */
create unique ASC index MA_MITARBEITER_PERSNR on MA_MITARBEITER (MA_PERSNR);

/* ============================================================ */
/*   Index: MA_MITARBEITER_NAME                                 */
/* ============================================================ */
create ASC index MA_MITARBEITER_NAME on MA_MITARBEITER (MA_NAME, MA_VORNAME, MA_ABTEILUNG);

/* ============================================================ */
/*   Table: WT_WAHL_LISTE                                       */
/* ============================================================ */
create table WT_WAHL_LISTE
(
    WT_ID                           INTEGER                not null,
    WA_ID                           INTEGER                        ,
    WT_NAME                         VARCHAR(150)                   ,
    WT_KURZ                         VARCHAR(15)                    ,
    constraint PK_WT_WAHL_LISTE primary key (WT_ID)
);

/* ============================================================ */
/*   Index: WT_WAHL_LISTE_NAME                                  */
/* ============================================================ */
create unique ASC index WT_WAHL_LISTE_NAME on WT_WAHL_LISTE (WT_NAME);

/* ============================================================ */
/*   Table: WL_WAHL_LOKAL                                       */
/* ============================================================ */
create table WL_WAHL_LOKAL
(
    WL_ID                           INTEGER                not null,
    WA_ID                           INTEGER                        ,
    WL_BAU                          VARCHAR(100)                   ,
    WL_STOCKWERK                    VARCHAR(10)                    ,
    WL_RAUM                         VARCHAR(10)                    ,
    constraint PK_WL_WAHL_LOKAL primary key (WL_ID)
);

/* ============================================================ */
/*   Table: BW_BRIEF_WAHL                                       */
/* ============================================================ */
create table BW_BRIEF_WAHL
(
    MA_ID                           INTEGER                not null,
    WA_ID                           INTEGER                        ,
    BW_ANTRAG                       DATE                           ,
    BW_VERSENDET                    DATE                           ,
    BW_EMPFANGEN                    DATE                           ,
    BW_UNGULTIG                     CHAR(1)                        ,
    constraint PK_BW_BRIEF_WAHL primary key (MA_ID)
);

/* ============================================================ */
/*   Table: AW_AUSWERTUNG                                       */
/* ============================================================ */
create table AW_AUSWERTUNG
(
    AW_ID                           INTEGER                not null,
    MA_ID                           INTEGER                        ,
    AW_TITLE                        VARCHAR(100)                   ,
    AW_START                        TIMESTAMP                      ,
    AW_ENDE                         TIMESTAMP                      ,
    AW_ERGEBNIS                     BLOB                           ,
    constraint PK_AW_AUSWERTUNG primary key (AW_ID)
);

/* ============================================================ */
/*   Table: WH_WAHL_HELFER                                      */
/* ============================================================ */
create table WH_WAHL_HELFER
(
    WL_ID                           INTEGER                not null,
    MA_ID                           INTEGER                not null,
    WA_ID                           INTEGER                        ,
    WH_ROLLE                        VARCHAR(100)                   ,
    constraint PK_WH_WAHL_HELFER primary key (WL_ID, MA_ID)
);

/* ============================================================ */
/*   Table: WV_WAHL_VORSTAND                                    */
/* ============================================================ */
create table WV_WAHL_VORSTAND
(
    MA_ID                           INTEGER                not null,
    WA_ID                           INTEGER                        ,
    WV_ROLLE                        VARCHAR(100)                   ,
    WH_SECRET                       CHAR(32)                       ,
    constraint PK_WV_WAHL_VORSTAND primary key (MA_ID)
);

/* ============================================================ */
/*   Table: WT_WA                                               */
/* ============================================================ */
create table WT_WA
(
    WT_ID                           INTEGER                not null,
    MA_ID                           INTEGER                not null,
    WA_ID                           INTEGER                        ,
    constraint PK_WT_WA primary key (WT_ID, MA_ID)
);

/* ============================================================ */
/*   Table: AW_SZ                                               */
/* ============================================================ */
create table AW_SZ
(
    AW_ID                           INTEGER                not null,
    SZ_ID                           INTEGER                not null,
    AW_SZ_STAMP                     TIMESTAMP                      ,
    AW_SZ_DATA                      BLOB                           ,
    constraint PK_AW_SZ primary key (AW_ID, SZ_ID)
);

/* ============================================================ */
/*   Table: WD_WAHLDATEN                                        */
/* ============================================================ */
create table WD_WAHLDATEN
(
    WD_ID                           INTEGER                not null,
    WA_ID                           INTEGER                        ,
    WD_KEY                          VARCHAR(100)                   ,
    WD_DATA                         BLOB                           ,
    constraint PK_WD_WAHLDATEN primary key (WD_ID)
);

/* ============================================================ */
/*   Table: LG_LOG                                              */
/* ============================================================ */
create table LG_LOG
(
    WA_ID                           INTEGER                        ,
    LG_ID                           INTEGER                        ,
    LG_STAMP                        TIMESTAMP                      ,
    LG_DATA                         BLOB                           
);

alter table MA_MITARBEITER
    add constraint FK_REF_189 foreign key  (WA_ID)
       references WA_WAHL;

alter table WT_WAHL_LISTE
    add constraint FK_REF_225 foreign key  (WA_ID)
       references WA_WAHL;

alter table WL_WAHL_LOKAL
    add constraint FK_REF_229 foreign key  (WA_ID)
       references WA_WAHL;

alter table BW_BRIEF_WAHL
    add constraint FK_REF_77 foreign key  (MA_ID, WA_ID)
       references MA_MITARBEITER;

alter table AW_AUSWERTUNG
    add constraint FK_REF_221 foreign key  (MA_ID)
       references BW_BRIEF_WAHL;

alter table WH_WAHL_HELFER
    add constraint FK_REF_20 foreign key  (WL_ID)
       references WL_WAHL_LOKAL;

alter table WH_WAHL_HELFER
    add constraint FK_REF_24 foreign key  (MA_ID, WA_ID)
       references MA_MITARBEITER;

alter table WV_WAHL_VORSTAND
    add constraint FK_REF_30 foreign key  (MA_ID, WA_ID)
       references MA_MITARBEITER;

alter table WT_WA
    add constraint FK_REF_68 foreign key  (WT_ID)
       references WT_WAHL_LISTE;

alter table WT_WA
    add constraint FK_REF_72 foreign key  (MA_ID, WA_ID)
       references MA_MITARBEITER;

alter table AW_SZ
    add constraint FK_REF_96 foreign key  (AW_ID)
       references AW_AUSWERTUNG;

alter table AW_SZ
    add constraint FK_REF_100 foreign key  (SZ_ID)
       references SZ_STIMMZETTEL;

alter table WD_WAHLDATEN
    add constraint FK_REF_213 foreign key  (WA_ID)
       references WA_WAHL;

alter table LG_LOG
    add constraint FK_REF_217 foreign key  (WA_ID)
       references WA_WAHL;

