-- Author: 	Hussain refaa
-- creation Date: 	2009
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : +4915775148443
-- Email: hus244@gmail.com

CONNECT system/manager



CONNECT test1/test1



/* table creation */
CREATE TABLE tbl_1(
  id  NUMBER(4,0));



/* sample PL/SQL code */
DECLARE
  x NUMBER(4,0);
BEGIN
  FOR x IN 0..99 LOOP
    INSERT INTO test1.tbl_1 VALUES(x);
  END LOOP;
END;
/


COMMIT;


/* stored procedure creation */
CREATE PROCEDURE sp
AS
  x NUMBER(4,0);
BEGIN
  FOR x IN 0..99 LOOP
    INSERT INTO test.tbl_1 VALUES(x);
  END LOOP;
END;
/

EXECUTE sp;


/* procedure deletion */
DROP PROCEDURE sp;

