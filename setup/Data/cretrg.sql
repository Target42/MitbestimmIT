/* ============================================================ */
/*   Database name:  MODEL_4                                    */
/*   DBMS name:      InterBase                                  */
/*   Created on:     21.09.2025  13:09                          */
/* ============================================================ */

/*  Insert trigger "ti_ad_admin" for table "AD_ADMIN"  */
set term /;
create trigger ti_ad_admin for AD_ADMIN
before insert as
begin
    new.ad_id = gen_id(gen_ad_id, 1);
end;/
set term ;/

/*  Insert trigger "ti_al_admin_log" for table "AL_ADMIN_LOG"  */
set term /;
create trigger ti_al_admin_log for AL_ADMIN_LOG
before insert as
begin
    new.al_id = gen_id(gen_al_id, 1);
    new.al_timestamp = CURRENT_TIMESTAMP;
end;/
set term ;/

/*  Insert trigger "ti_aw_auswertung" for table "AW_AUSWERTUNG"  */
set term /;
create trigger ti_aw_auswertung for AW_AUSWERTUNG
before insert as
begin
    new.aw_id = gen_id(gen_aw_id, 1);

end;/
set term ;/

/*  Insert trigger "ti_tab_107" for table "LG_LOG"  */
set term /;
create trigger ti_tab_107 for LG_LOG
before insert as
begin
    new.lg_id = gen_id(gen_lg_id, 1);

end;/
set term ;/

/*  Insert trigger "ti_tab_1" for table "MA_MITARBEITER"  */
set term /;
create trigger ti_tab_1 for MA_MITARBEITER
before insert as
begin
    new.ma_id = gen_id(gen_ma_id, 1);

end;/
set term ;/

/*  Insert trigger "ti_sz_stimmzettel" for table "SZ_STIMMZETTEL"  */
set term /;
create trigger ti_sz_stimmzettel for SZ_STIMMZETTEL
before insert as
begin
    new.sz_id = gen_id(gen_sz_id, 1);

end;/
set term ;/

/*  Insert trigger "ti_tab_184" for table "WA_WAHL"  */
set term /;
create trigger ti_tab_184 for WA_WAHL
before insert as
begin
    new.wa_id = gen_id(gen_wa_id, 1);

end;/
set term ;/

/*  Insert trigger "ti_wd_wahldaten" for table "WD_WAHLDATEN"  */
set term /;
create trigger ti_wd_wahldaten for WD_WAHLDATEN
before insert as
begin
    new.wd_id = gen_id(gen_wd_id, 1);

end;/
set term ;/

/*  Insert trigger "ti_tab_2" for table "WL_WAHL_LOKAL"  */
set term /;
create trigger ti_tab_2 for WL_WAHL_LOKAL
before insert as
begin
    new.wl_id = gen_id(gen_wl_id, 1);

end;/
set term ;/

/*  Insert trigger "ti_wt_wahl_liste" for table "WT_WAHL_LISTE"  */
set term /;
create trigger ti_wt_wahl_liste for WT_WAHL_LISTE
before insert as
begin
    new.wt_id = gen_id(gen_wt_id, 1);

end;/
set term ;/

