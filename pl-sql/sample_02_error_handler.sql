-- Author: 	Hussain refaa
-- creation Date: 	2009
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : +4915775148443
-- Email: hus244@gmail.com


CONNECT test/test

/* preparation **************************************************** */


/* clear data */
DELETE FROM test1.tbl_1;


/* create table 2 */
CREATE TABLE tbl_2(
  id  NUMBER(4,0),
  val NUMBER(4,0),
CONSTRAINT pk_tbl_2 PRIMARY KEY (id)
);


/* add foreign key on table 1 -- it means table 2 becomes master. */
ALTER TABLE test1.tbl_1 ADD CONSTRAINT fk_tbl_1_1 FOREIGN KEY (id)
  REFERENCES test1.tbl_2(id);


/* create sample data */
DECLARE
  x NUMBER(4,0);
  y NUMBER(2,0);
BEGIN
  y := 10;
  FOR x IN 0..10 LOOP
    INSERT INTO test1.tbl_2 VALUES(x, x * y);
    INSERT INTO test1.tbl_1 VALUES(x);
    y := y - 1;
  END LOOP;
END;
/

COMMIT;



/* test start ***************************************************** */

/* set sql*plus parameter -- */
SET SERVEROUTPUT ON



/* sample #2-1: an error occurs */ 
BEGIN
  INSERT INTO test1.tbl_2 VALUES(1, 1);
END;
/



/* sample #2-2: an error handled. */ 
BEGIN
  INSERT INTO test1.tbl_2 VALUES(1, 1);
EXCEPTION
  WHEN CURSOR_ALREADY_OPEN THEN
    dbms_output.put_line('<< error is handled (1) >>');
  WHEN DUP_VAL_ON_INDEX THEN
    dbms_output.put_line('<< error is handled (2) >>');
  WHEN OTHERS THEN
    dbms_output.put_line('<< error is handled (3) >>');
END;
/



/* sample #2-3-1: an error occurs */
DELETE FROM test1.tbl_2;



/* sample #2-3-2: assosiate an error */
DECLARE
  err_child_exists EXCEPTION;
  PRAGMA EXCEPTION_INIT(err_child_exists, -02292);
BEGIN
  DELETE FROM test1.tbl_2;
EXCEPTION
  WHEN CURSOR_ALREADY_OPEN THEN
    dbms_output.put_line('<< error is handled (1) >>');
  WHEN DUP_VAL_ON_INDEX THEN
    dbms_output.put_line('<< error is handled (2) >>');
  WHEN err_child_exists THEN
    dbms_output.put_line('<< error is handled (3) >>');
  WHEN OTHERS THEN
    dbms_output.put_line('<< error is handled (4) >>');
END;
/



/* sample #2-4: create new error */ 
DECLARE
  x        NUMBER;
  err_test EXCEPTION;
BEGIN
  x := 10;
  
  IF x = 10 THEN
    RAISE err_test;
  ELSE
    INSERT INTO test1.tbl_2 VALUES(0,0);
  END IF;
EXCEPTION
  WHEN err_test THEN
    dbms_output.put_line('<< error is handled (1) >>');
  WHEN OTHERS THEN
    dbms_output.put_line('<< error is handled (2) >>');
END;
/



/* sample #2-5-1: raise application error */ 
DECLARE
  x        NUMBER;
BEGIN
  x := 10;
  
  IF x = 10 THEN
    RAISE_APPLICATION_ERROR(-20001, 'test error');
  ELSE
    INSERT INTO test1.tbl_2 VALUES(0,0);
  END IF;
END;
/



/* sample #2-5-2: raise application error */ 
DECLARE
  x        NUMBER;
BEGIN
  x := 10;
  
  IF x = 10 THEN
    RAISE_APPLICATION_ERROR(-20001, 'test error');
  ELSE
    INSERT INTO test1.tbl_2 VALUES(0,0);
  END IF;
EXCEPTION
  WHEN CURSOR_ALREADY_OPEN THEN
    dbms_output.put_line('<< error is handled (1) >>');
  WHEN DUP_VAL_ON_INDEX THEN
    dbms_output.put_line('<< error is handled (2) >>');
  WHEN OTHERS THEN
    dbms_output.put_line('<< error is handled (4) >>');
END;
/



