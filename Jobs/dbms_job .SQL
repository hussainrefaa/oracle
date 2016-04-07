/* *** sample 3 : dbms_job *** */
drop table job_rec;
drop procedure insert_log_date;
drop procedure insert_same_date;
/* 3-0 : preparation */
-- create job record table.
CREATE TABLE job_rec (dt DATE);

-- create procedure to be run - 1
CREATE OR REPLACE PROCEDURE insert_log_date AS
BEGIN
  INSERT INTO job_rec VALUES(sysdate);
  COMMIT;
END;
/


-- create procedure to be run - 2
CREATE OR REPLACE PROCEDURE insert_same_date AS
BEGIN
  INSERT INTO job_rec VALUES(TO_DATE('1900-01-01', 'YYYY-MM-DD'));
  COMMIT;
END;
/


/* 3-1 : job creation */
  --  1440 = 24h * 60m
  -- 86400 = 24h * 60m * 60s
DECLARE
  job_num  INTEGER;
BEGIN
  -- every min
  dbms_job.submit(job_num, 'insert_log_date();', 
                  sysdate, 'sysdate + (1/86400)', false);
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

