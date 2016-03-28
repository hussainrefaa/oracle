-- Author: 	Hussen refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : + 4915775148443
-- Email: hus244@gmail.com

/* sample 1 : trigger creation *** */
CREATE OR REPLACE TRIGGER item_bi
  BEFORE INSERT ON item
  FOR EACH ROW
DECLARE
  cid INTEGER;
  Cnt NUMBER;
  cntrec number;
  SqlBff VARCHAR2(128);
  colCntRec  NUMBER;
   tabl_nam   varchar2(32);
   newid      varchar2(3);
BEGIN
  newid := :NEW.id_props;
  IF :NEW.id_category = '001' THEN   -- computer
    SQLBFF := 'SELECT COUNT(*) Cnt  FROM props_pc where id_pcmodel = ''' || newid || '''';
    tabl_nam := 'props_pc';
  ELSIF :NEW.id_category = '002' THEN  -- tv
     SQLBFF := 'SELECT COUNT(*) Cnt  FROM props_tv WHERE id_tvmodel = ''' || newid || '''';
     tabl_nam := 'props_tv';
  ELSIF :NEW.id_category = '003' THEN  -- radio
    SQLBFF := 'SELECT COUNT(*) Cnt FROM props_radio WHERE id_radiomodel = ''' || newid || '''';
    tabl_nam := 'props_radio';
  END IF;
     cid := dbms_sql.open_cursor;
     dbms_sql.parse(cid, SqlBff, dbms_sql.native);
     dbms_sql.define_column(cid, 1, colCntRec);
     Cnt := dbms_sql.execute(cid);
    IF dbms_sql.fetch_rows(cid) = 0 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Relation Error.  No parent record in table' || tabl_nam);
    END IF;
    dbms_sql.close_cursor(cid);
END;
/
--=====================================================================
--=====================================================================
/* sample 3 : trigger creation *** */
CREATE OR REPLACE TRIGGER item_bi
  BEFORE INSERT ON item
  FOR EACH ROW
DECLARE
  CntRec NUMBER;
BEGIN
  IF :NEW.id_category = '001' THEN   -- computer
    SELECT COUNT(*) cnt INTO CntRec FROM props_pc WHERE id_pcmodel = :NEW.id_props;
    IF CntRec = 0 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Relation Error.  No parent record in table [props_pc]');
    END IF;
  ELSIF :NEW.id_category = '002' THEN  -- tv
    SELECT COUNT(*) cnt INTO CntRec FROM props_tv WHERE id_tvmodel = :NEW.id_props;
    IF CntRec = 0 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Relation Error.  No parent record in table [props_tv]');
    END IF;
  ELSIF :NEW.id_category = '003' THEN  -- radio
    SELECT COUNT(*) cnt INTO CntRec FROM props_radio WHERE id_radiomodel = :NEW.id_props;
    IF CntRec = 0 THEN
      RAISE_APPLICATION_ERROR(-20001, 'Relation Error.  No parent record in table [props_radio]');
    END IF;
  END IF;
END;
--=====================================================================
--=====================================================================
/* 6-1 : test trigger creation - without 'for each row' option */
CREATE OR REPLACE TRIGGER item_bu
  BEFORE UPDATE ON item
BEGIN
  dbms_output.put_line('>> records are about to be inserted.');
END;
/