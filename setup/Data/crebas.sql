/* ============================================================ */
/*   Database name:  MODEL_4                                    */
/*   DBMS name:      InterBase                                  */
/*   Created on:     09.10.2025  21:06                          */
/* ============================================================ */

create generator gen_ad_id;
create generator gen_al_id;
create generator gen_ma_id;
create generator gen_wl_id;
create generator gen_wh_id;
create generator gen_wt_id;
create generator gen_sz_id;
create generator gen_lg_id;
create generator gen_aw_id;
create generator gen_wa_id;
create generator gen_mc_id;
/* ============================================================ */
/*   Table: MA_MITARBEITER                                      */
/* ============================================================ */
create table MA_MITARBEITER
(
    MA_ID                           INTEGER                not null,
    MA_PERSNR                       VARCHAR(10)                    ,
    MA_NAME                         VARCHAR(100)                   ,
    MA_VORNAME                      VARCHAR(100)                   ,
    MA_GENDER                       CHAR(1)                        ,
    MA_ABTEILUNG                    VARCHAR(20)                    ,
    MA_MAIL                         VARCHAR(255)                   ,
    constraint PK_MA_MITARBEITER primary key (MA_ID)
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
    WA_DATA                         BLOB                           ,
    WA_TYP                          INTEGER                        ,
    constraint PK_WA_WAHL primary key (WA_ID)
);

/* ============================================================ */
/*   Table: AD_ADMIN                                            */
/* ============================================================ */
create table AD_ADMIN
(
    AD_ID                           INTEGER                not null,
    AD_SECRET                       VARCHAR(32)                    ,
    AD_PWD                          VARCHAR(64)                    ,
    constraint PK_AD_ADMIN primary key (AD_ID)
);

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
/*   Table: MA_WA                                               */
/* ============================================================ */
create table MA_WA
(
    WA_ID                           INTEGER                not null,
    MA_ID                           INTEGER                not null,
    constraint PK_MA_WA primary key (WA_ID, MA_ID)
);

/* ============================================================ */
/*   Table: AW_AUSWERTUNG                                       */
/* ============================================================ */
create table AW_AUSWERTUNG
(
    WA_ID                           INTEGER                not null,
    AW_ID                           INTEGER                not null,
    AW_TITLE                        VARCHAR(100)                   ,
    AW_START                        TIMESTAMP                      ,
    AW_ENDE                         TIMESTAMP                      ,
    AW_ERGEBNIS                     BLOB                           ,
    constraint PK_AW_AUSWERTUNG primary key (WA_ID, AW_ID)
);

/* ============================================================ */
/*   Table: WL_WAHL_LOKAL                                       */
/* ============================================================ */
create table WL_WAHL_LOKAL
(
    WA_ID                           INTEGER                not null,
    WL_ID                           INTEGER                not null,
    WL_BAU                          VARCHAR(100)                   ,
    WL_STOCKWERK                    VARCHAR(10)                    ,
    WL_RAUM                         VARCHAR(10)                    ,
    constraint PK_WL_WAHL_LOKAL primary key (WA_ID, WL_ID)
);

/* ============================================================ */
/*   Table: WH_WAHL_HELFER                                      */
/* ============================================================ */
create table WH_WAHL_HELFER
(
    WL_ID                           INTEGER                not null,
    MA_ID                           INTEGER                not null,
    WA_ID                           INTEGER                not null,
    WH_ROLLE                        VARCHAR(100)                   ,
    constraint PK_WH_WAHL_HELFER primary key (WL_ID, MA_ID, WA_ID)
);

/* ============================================================ */
/*   Table: WV_WAHL_VORSTAND                                    */
/* ============================================================ */
create table WV_WAHL_VORSTAND
(
    WA_ID                           INTEGER                not null,
    MA_ID                           INTEGER                not null,
    WV_ROLLE                        VARCHAR(100)                   ,
    WV_CHEF                         CHARACTER                      ,
    constraint PK_WV_WAHL_VORSTAND primary key (WA_ID, MA_ID)
);

/* ============================================================ */
/*   Table: WT_WA                                               */
/* ============================================================ */
create table WT_WA
(
    WA_ID                           INTEGER                not null,
    MA_ID                           INTEGER                not null,
    WT_ID                           INTEGER                not null,
    constraint PK_WT_WA primary key (WA_ID, MA_ID, WT_ID)
);

/* ============================================================ */
/*   Table: BW_BRIEF_WAHL                                       */
/* ============================================================ */
create table BW_BRIEF_WAHL
(
    WA_ID                           INTEGER                not null,
    MA_ID                           INTEGER                not null,
    BW_ANTRAG                       DATE                           ,
    BW_VERSENDET                    DATE                           ,
    BW_EMPFANGEN                    DATE                           ,
    BW_UNGULTIG                     CHAR(1)                        ,
    constraint PK_BW_BRIEF_WAHL primary key (WA_ID, MA_ID)
);

/* ============================================================ */
/*   Table: AW_SZ                                               */
/* ============================================================ */
create table AW_SZ
(
    AW_ID                           INTEGER                not null,
    SZ_ID                           INTEGER                not null,
    WA_ID                           INTEGER                        ,
    AW_SZ_STAMP                     TIMESTAMP                      ,
    AW_SZ_DATA                      BLOB                           ,
    constraint PK_AW_SZ primary key (AW_ID, SZ_ID)
);

/* ============================================================ */
/*   Table: LG_LOG                                              */
/* ============================================================ */
create table LG_LOG
(
    WA_ID                           INTEGER                not null,
    LG_ID                           INTEGER                not null,
    LG_STAMP                        TIMESTAMP                      ,
    LG_DATA                         BLOB                           ,
    constraint PK_LG_LOG primary key (WA_ID, LG_ID)
);

/* ============================================================ */
/*   Table: AL_ADMIN_LOG                                        */
/* ============================================================ */
create table AL_ADMIN_LOG
(
    AL_ID                           INTEGER                not null,
    AD_ID                           INTEGER                        ,
    AL_TIMESTAMP                    TIMESTAMP                      ,
    AL_DATA                         blob sub_type text             ,
    constraint PK_AL_ADMIN_LOG primary key (AL_ID)
);

/* ============================================================ */
/*   Table: MA_PWD                                              */
/* ============================================================ */
create table MA_PWD
(
    MA_ID                           INTEGER                not null,
    MW_PWD                          VARCHAR(64)                    ,
    MW_ROLLE                        VARCHAR(100)                   ,
    MW_SECRET                       VARCHAR(32)                    ,
    MW_LOGIN                        VARCHAR(20)                    ,
    constraint PK_MA_PWD primary key (MA_ID)
);

/* ============================================================ */
/*   Table: WF_FRISTEN                                          */
/* ============================================================ */
create table WF_FRISTEN
(
    WA_ID                           INTEGER                not null,
    WF_ID                           INTEGER                not null,
    WF_TITEL                        VARCHAR(100)                   ,
    WF_START                        TIMESTAMP                      ,
    WF_ENDE                         TIMESTAMP                      ,
    WF_TYP                          INTEGER                        ,
    constraint PK_WF_FRISTEN primary key (WA_ID, WF_ID)
);

/* ============================================================ */
/*   Table: MC_MA_CHANGE                                        */
/* ============================================================ */
create table MC_MA_CHANGE
(
    WA_ID                           INTEGER                not null,
    MC_ID                           INTEGER                not null,
    MC_STAMP                        TIMESTAMP                      ,
    MC_ADD                          INTEGER                        ,
    MC_CHG                          INTEGER                        ,
    MC_DEL                          INTEGER                        ,
    MC_DATA                         BLOB                           ,
    constraint PK_MC_MA_CHANGE primary key (WA_ID, MC_ID)
);

alter table WT_WAHL_LISTE
    add constraint FK_REF_225 foreign key  (WA_ID)
       references WA_WAHL;

alter table MA_WA
    add constraint FK_REF_743 foreign key  (WA_ID)
       references WA_WAHL;

alter table MA_WA
    add constraint FK_REF_747 foreign key  (MA_ID)
       references MA_MITARBEITER;

alter table AW_AUSWERTUNG
    add constraint FK_REF_786 foreign key  (WA_ID)
       references WA_WAHL;

alter table WL_WAHL_LOKAL
    add constraint FK_REF_796 foreign key  (WA_ID)
       references WA_WAHL;

alter table WH_WAHL_HELFER
    add constraint FK_REF_20 foreign key  (WA_ID, WL_ID)
       references WL_WAHL_LOKAL;

alter table WH_WAHL_HELFER
    add constraint FK_REF_773 foreign key  (WA_ID, MA_ID)
       references MA_WA;

alter table WV_WAHL_VORSTAND
    add constraint FK_REF_766 foreign key  (WA_ID, MA_ID)
       references MA_WA;

alter table WT_WA
    add constraint FK_REF_68 foreign key  (WT_ID)
       references WT_WAHL_LISTE;

alter table WT_WA
    add constraint FK_REF_759 foreign key  (WA_ID, MA_ID)
       references MA_WA;

alter table BW_BRIEF_WAHL
    add constraint FK_REF_779 foreign key  (WA_ID, MA_ID)
       references MA_WA;

alter table AW_SZ
    add constraint FK_REF_96 foreign key  (WA_ID, AW_ID)
       references AW_AUSWERTUNG;

alter table AW_SZ
    add constraint FK_REF_100 foreign key  (SZ_ID)
       references SZ_STIMMZETTEL;

alter table LG_LOG
    add constraint FK_REF_217 foreign key  (WA_ID)
       references WA_WAHL;

alter table AL_ADMIN_LOG
    add constraint FK_REF_353 foreign key  (AD_ID)
       references AD_ADMIN;

alter table MA_PWD
    add constraint FK_REF_755 foreign key  (MA_ID)
       references MA_MITARBEITER;

alter table WF_FRISTEN
    add constraint FK_REF_1018 foreign key  (WA_ID)
       references WA_WAHL;

alter table MC_MA_CHANGE
    add constraint FK_REF_1258 foreign key  (WA_ID)
       references WA_WAHL;

set generator gen_ma_id to 100;

commit;


/* ============================================================ */
/*   Rollen                                                     */
/* ============================================================ */

CREATE ROLE appuser;
CREATE ROLE appadmin;
create ROLE apppwd;


/* ============================================================ */
/*   appuser                                                    */
/* ============================================================ */

GRANT SELECT, INSERT, UPDATE, DELETE ON AW_AUSWERTUNG TO appuser;
GRANT SELECT, INSERT, UPDATE, DELETE ON AW_SZ TO appuser;
GRANT SELECT, INSERT, UPDATE, DELETE ON BW_BRIEF_WAHL TO appuser;
GRANT SELECT, INSERT, UPDATE, DELETE ON LG_LOG TO appuser;
GRANT SELECT, INSERT, UPDATE, DELETE ON MA_MITARBEITER TO appuser;
GRANT SELECT, INSERT, UPDATE, DELETE ON SZ_STIMMZETTEL TO appuser;
GRANT SELECT, INSERT, UPDATE, DELETE ON WA_WAHL TO appuser;
GRANT SELECT, INSERT, UPDATE, DELETE ON WH_WAHL_HELFER TO appuser;
GRANT SELECT, INSERT, UPDATE, DELETE ON WL_WAHL_LOKAL TO appuser;
GRANT SELECT, INSERT, UPDATE, DELETE ON WT_WA TO appuser;
GRANT SELECT, INSERT, UPDATE, DELETE ON WT_WAHL_LISTE TO appuser;
GRANT SELECT, INSERT, UPDATE, DELETE ON WV_WAHL_VORSTAND TO appuser;
GRANT SELECT ON AD_ADMIN TO appuser;
GRANT SELECT, INSERT, UPDATE, DELETE ON MA_WA TO appuser;;
GRANT SELECT, INSERT, UPDATE, DELETE ON MA_PWD TO appuser;;
GRANT SELECT, INSERT, UPDATE, DELETE ON WF_FRISTEN to appuser;
GRANT SELECT, INSERT, UPDATE, DELETE ON MC_MA_CHANGE to appuser;

GRANT USAGE ON GENERATOR  gen_ma_id TO ROLE appuser;
GRANT USAGE ON GENERATOR  gen_wl_id TO ROLE appuser;
GRANT USAGE ON GENERATOR  gen_wh_id TO ROLE appuser;
GRANT USAGE ON GENERATOR  gen_wt_id TO ROLE appuser;
GRANT USAGE ON GENERATOR  gen_sz_id TO ROLE appuser;
GRANT USAGE ON GENERATOR  gen_lg_id TO ROLE appuser;
GRANT USAGE ON GENERATOR  gen_aw_id TO ROLE appuser;
GRANT USAGE ON GENERATOR  gen_mc_id TO ROLE appuser;

commit;

/* ============================================================ */
/*   appadmin                                                   */
/* ============================================================ */
GRANT SELECT, INSERT, UPDATE, DELETE ON AD_ADMIN TO appadmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON AL_ADMIN_LOG TO appadmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON WA_WAHL TO appadmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON MA_MITARBEITER TO appadmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON WV_WAHL_VORSTAND TO appadmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON MA_PWD TO appadmin;
GRANT SELECT, INSERT, UPDATE, DELETE ON MA_WA TO appadmin;

GRANT USAGE ON GENERATOR  gen_ad_id TO ROLE appadmin;
GRANT USAGE ON GENERATOR gen_al_id TO ROLE appadmin;
GRANT USAGE ON GENERATOR  gen_ma_id TO ROLE appadmin;
GRANT USAGE ON GENERATOR gen_wa_id TO ROLE appadmin;

commit;

/* ============================================================ */
/*   apppwd                                                     */
/* ============================================================ */

GRANT SELECT ON MA_PWD TO apppwd;
GRANT SELECT ON WA_WAHL TO apppwd;

commit;

SET TERM ^ ;
CREATE TRIGGER BIU_MA_PWD FOR MA_PWD ACTIVE
BEFORE insert OR update POSITION 0
AS
BEGIN
  IF (NEW.MW_LOGIN IS NOT NULL) THEN
    NEW.MW_LOGIN = LOWER(NEW.MW_LOGIN);
END
^
SET TERM ; ^

commit;
