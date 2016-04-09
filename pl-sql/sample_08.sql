-- Author: 	Hussain refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : +4915775148443
-- Email: hus244@gmail.com

BEGIN
  INSERT INTO department VALUES('aaa','aaa','000');
  INSERT INTO department VALUES('bbb','aaa','000');
  INSERT INTO department VALUES('ccc','aaa','000');
  INSERT INTO department VALUES('ddd','aaa','000');
END;



DELETE FROM DEPARTMENT WHERE ID_DEPARTMENT IN ('aaa','bbb','ccc','ddd');



CREATE OR REPLACE TRIGGER department_bi
  BEFORE INSERT ON department
DECLARE
  str  CONSTANT VARCHAR2(16) := 'row is about to be inserted.';
BEGIN
  dbms_output.put_line(str);
END;



/* *** before update - 1 *** */
CREATE OR REPLACE TRIGGER department_bu
  BEFORE UPDATE ON department
DECLARE
  str  CONSTANT VARCHAR2(16) := 'row is about to be updated.';
BEGIN
  dbms_output.put_line(str);
END;



/* *** before update - 2 *** */
CREATE OR REPLACE TRIGGER department_bu
  BEFORE UPDATE ON department
  FOR EACH ROW
DECLARE
  str  CONSTANT VARCHAR2(16) := 'row is about to be updated.';
BEGIN
  dbms_output.put_line(str);
END;



UPDATE department SET st_name = 'xxx' WHERE st_name = 'aaa'



/* *** :new and :old *** */
CREATE OR REPLACE TRIGGER department_bu
  BEFORE UPDATE ON department
  FOR EACH ROW
BEGIN
  dbms_output.put_line('Modified: [' || :OLD.st_name || '] => [' || :NEW.st_name || ']');
END;


ALTER TRIGGER department_bu DISABLE;
ALTER TRIGGER department_bu ENABLE;

SELECT * FROM USER_TRIGGERS;



  BEFORE INSERT
  BEFORE INSERT FOR EACH ROW
  AFTER INSERT
  AFTER INSERT FOR EACH ROW
  BEFORE UPDATE
  BEFORE UPDATE FOR EACH ROW
  AFTER UPDATE
  AFTER UPDATE FOR EACH ROW
  BEFORE DELETE
  BEFORE DELETE FOR EACH ROW
  AFTER DELETE
  AFTER DELETE FOR EACH ROW
  
SET LONG 2000
