-- ///////////////////////////////////////////////////////////////////
-- PL/SQL sample source code #9
-- Author:        Hussen refaa
-- Creation Date: 2001-12-01
-- Last Modified: 0000-00-00
-- Copyright (c) 2001 by Hussen refaa
-- Author: 	Hussen refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : + 4915775148443
-- Email: hus244@gmail.com
-- ///////////////////////////////////////////////////////////////////

grant create any DIRECTORY  to docunet;

create or replace DIRECTORY LOG_DOC as 'C:\TEMP';

create or replace PROCEDURE file_action 
IS
   fileID UTL_FILE.FILE_TYPE;
   Creat_Dir_Command varchar2(200);

BEGIN

   Creat_Dir_Command := 'CREATE OR REPLACE DIRECTORY my_docs AS ' || chr(39) || 'c:\TEMP' || chr(39);
   dbms_output.put_line(Creat_Dir_Command);
   execute immediate Creat_Dir_Command; 
   fileID := UTL_FILE.FOPEN ('LOG_DOC', 'lotsa.stf', 'w');
   UTL_FILE.PUT_LINE (fileID, 'just the beginning');
   UTL_FILE.FCLOSE (fileID);
END;
/

begin
	 file_action ;
end;
/

/* 2-1 : write onto a file - 1 */
DECLARE
  file_handle  utl_file.file_type;
BEGIN
  file_handle := utl_file.fopen('LOG_DOC', 'logfile.log', 'w');
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
  file_handle := utl_file.fopen('c:/TEMP', 'logfile.log', 'w');
  utl_file.put_line(file_handle, 'logfile.log');
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

