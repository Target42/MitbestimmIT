/* ============================================================ */
/*   Database name:  MODEL_4                                    */
/*   DBMS name:      InterBase                                  */
/*   Created on:     05.08.2025  19:41                          */
/* ============================================================ */

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

