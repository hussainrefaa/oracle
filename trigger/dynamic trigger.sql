-- Author: 	Hussen refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : + 4915775148443
-- Email: hus244@gmail.com

SET SERVEROUTPUT ON SIZE 1000000
SET VERIFY OFF
SET TRIMSPOOL ON
DECLARE
  v_owner  VARCHAR2(30) := UPPER('&1');
  v_table  VARCHAR2(30) := UPPER('&2');

  CURSOR c_columns IS
    SELECT column_name
    FROM   all_tab_columns
    WHERE  owner      = v_owner
    AND    table_name = v_table;
BEGIN
  DBMS_OUTPUT.PUT_LINE('CREATE OR REPLACE TRIGGER ' || v_table || '_aiudr_trg');
  DBMS_OUTPUT.PUT_LINE('AFTER INSERT OR UPDATE OR DELETE ON ' || v_table);
  DBMS_OUTPUT.PUT_LINE('FOR EACH ROW');
  DBMS_OUTPUT.PUT_LINE('DECLARE');
  DBMS_OUTPUT.PUT_LINE('	PRAGMA AUTONOMOUS_TRANSACTION;');
  DBMS_OUTPUT.PUT_LINE('	v_action VARCHAR2(30) := ''NONE'';');
  DBMS_OUTPUT.PUT_LINE('BEGIN');
  DBMS_OUTPUT.PUT_LINE('	IF INSERTING THEN');
  DBMS_OUTPUT.PUT_LINE('		v_action := ''INSERT'';');
  DBMS_OUTPUT.PUT_LINE('	ELSIF UPDATING THEN');
  DBMS_OUTPUT.PUT_LINE('		v_action := ''UPDATE'';');
  DBMS_OUTPUT.PUT_LINE('	ELSIF DELETING THEN');
  DBMS_OUTPUT.PUT_LINE('		v_action := ''DELETE'';');
  DBMS_OUTPUT.PUT_LINE('	END IF;');
    
  DBMS_OUTPUT.PUT_LINE('	tsh_audit.insert_log (');
  DBMS_OUTPUT.PUT_LINE('		SYS_CONTEXT(''USERENV'',''CLIENT_IDENTIFIER''),');
  DBMS_OUTPUT.PUT_LINE('		''' || v_table || ''',');
  DBMS_OUTPUT.PUT_LINE('		v_action,');
  FOR cur_rec IN c_columns LOOP
    IF c_columns%ROWCOUNT > 1 THEN
      DBMS_OUTPUT.PUT_LINE('||');
    END IF;
    DBMS_OUTPUT.PUT('		''NEW.' || cur_rec.column_name || '=['' || :NEW.' || cur_rec.column_name || ' || ''] ' ||
                         'OLD.' || cur_rec.column_name || '=['' || :OLD.' || cur_rec.column_name || ' || '']'' ');
  END LOOP;
  DBMS_OUTPUT.NEW_LINE;
  DBMS_OUTPUT.PUT_LINE('	);');
  
  DBMS_OUTPUT.PUT_LINE('	COMMIT;');
  DBMS_OUTPUT.PUT_LINE('END;');
  DBMS_OUTPUT.PUT_LINE('/');
  DBMS_OUTPUT.PUT_LINE('SHOW ERRORS');
END;
/