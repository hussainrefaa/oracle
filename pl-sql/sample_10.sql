-- Author: 	Hussain refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : +4915775148443
-- Email: hus244@gmail.com

/* *** sample 1 : dbms_sql *** */

/* 1-0 : preparation */
CREATE TABLE del (c NUMBER);

/* 1-1 : wrong procedure. */
CREATE OR REPLACE PROCEDURE clear_all(table_name IN VARCHAR2) AS
BEGIN
  DELETE FROM || table_name;
END;
/


/* 1-2 : correct procedure. */
CREATE OR REPLACE PROCEDURE clear_all(table_name IN VARCHAR2) AS
  cid INTEGER;
  cnt NUMBER;
  SqlBff VARCHAR2(128);
BEGIN
  SqlBff := 'DELETE FROM ' || table_name;

  cid := dbms_sql.open_cursor;
  dbms_sql.parse(cid, SqlBff, dbms_sql.native);
  cnt := dbms_sql.execute(cid);
  dbms_sql.close_cursor(cid);
  dbms_output.put_line(TO_CHAR(cnt) || ' row(s) deleted.');
END;
/


/* 1-3 : DDL */
SET SERVEROUTPUT ON

BEGIN
  DROP TABLE del;
END;
/


/* 1-4 : DDL - 2 */
DECLARE
  cid  NUMBER;
  cnt  NUMBER;
BEGIN
  cid := dbms_sql.open_cursor;
  dbms_sql.parse(cid, 'DROP TABLE del', dbms_sql.native);
  cnt := dbms_sql.execute(cid);
  dbms_sql.close_cursor(cid);
  
  dbms_output.put_line('[ ' || TO_CHAR(cnt) || ' ] is returned.');
END;
/


/* 1-5 : select procedure */
CREATE OR REPLACE PROCEDURE count_all(table_name IN VARCHAR2) AS
  cid INTEGER;
  cnt NUMBER;
  SqlBff VARCHAR2(128);
  ColCnt NUMBER;
BEGIN
  SqlBf := 'SELECT COUNT(*) cnt FROM ' || table_name;

  cid := dbms_sql.open_cursor;
  dbms_sql.parse(cid, SqlBff, dbms_sql.native);
  dbms_sql.define_column(cid, 1, ColCnt);
  cnt := dbms_sql.execute(cid);

  IF dbms_sql.fetch_rows(cid) > 0 THEN
    dbms_sql.column_value(cid, 1, ColCnt);
    dbms_output.put_line(TO_CHAR(ColCnt) || ' row(s) in the table.');
  END IF;

  dbms_sql.close_cursor(cid);
END;
/


/* 1-6 : bind variables */
DECLARE
  cid  NUMBER;
  cnt  NUMBER;
BEGIN
  cid := dbms_sql.open_cursor;
  dbms_sql.parse(cid, 'SELECT COUNT(*) FROM employee WHERE id_employee = :emp', dbms_sql.native);
  dbms_sql.define_column(cid, 1, cnt);
  dbms_sql.bind_variable(cid, 'emp', '1234');
  cnt := dbms_sql.execute(cid);
  IF dbms_sql.fetch_rows(cid) > 0 THEN
    dbms_sql.column_value(cid, 1, cnt);
    dbms_output.put_line(TO_CHAR(cnt) || ' row matched.');
  END IF;
  dbms_sql.close_cursor(cid);
END;
/


/* 1-7 : bind variables (char) */

/* 1-7-0 : preparation */
CREATE TABLE char_test(c CHAR(1));

DECLARE
  cnt  PLS_INTEGER;
BEGIN
  FOR cnt IN 65..90 LOOP
    INSERT INTO char_test VALUES(CHR(cnt));
  END LOOP;
END;
/
COMMIT;


/* 1-7-1 : selection */
DECLARE
  cid  NUMBER;
  cnt  NUMBER;
BEGIN
  cid := dbms_sql.open_cursor;
  dbms_sql.parse(cid, 'SELECT COUNT(*) cnt FROM char_test WHERE c = :c_val', dbms_sql.native);
  dbms_sql.define_column(cid, 1, cnt);
  dbms_sql.bind_variable_char(cid, 'c_val', 'A');
  cnt := dbms_sql.execute(cid);
  IF dbms_sql.fetch_rows(cid) > 0 THEN
    dbms_sql.column_value(cid, 1, cnt);
    dbms_output.put_line(TO_CHAR(cnt) || ' row matched.');
  END IF;
  dbms_sql.close_cursor(cid);
END;
/



/* *** sample 2 : util_file *** */

/* 2-0 : preparation
 *   - create new folder 'user_log'.
 *   - shutdown oracle.
 *   - open 'init.ora' and add line(s) as follow.
 *     UTL_FILE_DIR = h:\database\
 *   - start oracle again.
 */

/* 2-1 : write onto a file - 1 */
DECLARE
  file_handle  utl_file.file_type;
BEGIN
  file_handle := utl_file.fopen('h:\database', 'logfile.log', 'w');
  utl_file.put_line(file_handle, '/* sample log file */');
  utl_file.new_line(file_handle, 1);
  utl_file.put_line(file_handle, 'Creation Date: ' || TO_CHAR(SYSDATE, 'YYYY-MM-DD'));
  utl_file.fclose(file_handle);
END;
/


/* 2-2 : write onto a file - 2 */
DECLARE
  file_handle  utl_file.file_type;
BEGIN
  file_handle := utl_file.fopen('h:\database', 'logfile.log', 'w');
  utl_file.put_line(file_handle, '/* sample log file */');
  utl_file.put(file_handle, 'a');
  utl_file.put(file_handle, 'b');
  utl_file.put(file_handle, 'c');
  utl_file.put(file_handle, 'd');
  utl_file.new_line(file_handle, 1);
  utl_file.put(file_handle, 'e');
  utl_file.put(file_handle, 'f');
  utl_file.put(file_handle, 'g');
  utl_file.new_line(file_handle, 3);
  utl_file.put(file_handle, 'h');
  utl_file.fclose(file_handle);
END;
/


/* 2-3 : read from file */
SET SERVEROUTPUT ON

DECLARE
  file_handle  utl_file.file_type;
  bff VARCHAR2(1000);
BEGIN
  file_handle := utl_file.fopen('h:\database', 'logfile.log', 'r');
  
  LOOP
    utl_file.get_line(file_handle, bff);
    dbms_output.put_line(bff);
  END LOOP;
  utl_file.fclose(file_handle);
EXCEPTION
  WHEN no_data_found THEN
    utl_file.fclose(file_handle);
  WHEN others THEN
    raise_application_error(-20001, 'Error!!!');
END;
/



/* *** sample 3 : dbms_job *** */

/* 3-0 : preparation */
-- create job record table.
CREATE TABLE job_rec (dt DATE);

-- create procedure to be run - 1
CREATE OR REPLACE PROCEDURE insert_log_date AS
BEGIN
  INSERT INTO test.job_rec VALUES(sysdate);
  COMMIT;
END;
/


-- create procedure to be run - 2
CREATE OR REPLACE PROCEDURE insert_same_date AS
BEGIN
  INSERT INTO test.job_rec VALUES(TO_DATE('1900-01-01', 'YYYY-MM-DD'));
  COMMIT;
END;
/


/* 3-1 : job creation */
  --  1440 = 24h * 60m
  -- 86400 = 24h * 60m * 60s
DECLARE
  job_num  INTEGER;
BEGIN
  dbms_job.submit(job_num, 'test.insert_log_date();', 
                  sysdate, 'sysdate + (1/1440)', false);
  dbms_output.put_line(job_num);
END;
/


/* 3-2 : check log record table */
SELECT TO_CHAR(dt, 'yyyy-mm-dd hh24:mi:ss') FROM test.job_rec;


/* 3-3 : check d.d. */
SELECT TO_CHAR(SYSDATE, 'yyyy-mm-dd hh24:mi:ss') sd FROM dual;

SELECT job, TO_CHAR(next_date, 'yyyy-mm-dd hh24:mi:ss') nxt, 
       SUBSTR(what, 1, 20) job_desc, broken
  FROM user_jobs
 ORDER BY job;


/* 3-4 : run immediately */
BEGIN
  dbms_job.run(1);
END;
/


/* 3-5 : change interval */
BEGIN
  dbms_job.interval(1, 'SYSDATE + (10/86400)');
END;
/


/* 3-6 : change procedure */
BEGIN
  dbms_job.what(1, 'insert_same_date');
END;
/


/* 3-7 : change procedure */
BEGIN
  dbms_job.next_date(1, SYSDATE + 1);
END;


/* 3-8 : remove job */
BEGIN
  dbms_job.remove(1);
END;

