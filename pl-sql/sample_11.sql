-- Author: 	Hussain refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : +4915775148443
-- Email: hus244@gmail.com

Rem          job_queue_processes=2   #two background processes
Rem          job_queue_interval=60   #the processes wake up every 60 seconds

/* for the 1st session. */
SET SERVEROUTPUT ON

DECLARE
  STT_TIMEOUT CONSTANT PLS_INTEGER := 1;
  status NUMBER;
  message VARCHAR2(100);
BEGIN
  dbms_alert.register('sample_alert');
  dbms_alert.waitone('sample_alert', message, status, 120);
  
  IF status = STT_TIMEOUT THEN
    dbms_output.put_line('timeout!!');
  ELSE
    dbms_output.put_line(message);
  END IF;
END;
/

/* for the 2nd session */
SET SERVEROUTPUT ON

DECLARE
  STT_TIMEOUT CONSTANT PLS_INTEGER := 1;
  status NUMBER;
  message VARCHAR2(100);
BEGIN
--  dbms_alert.register('sample_alert');
  dbms_alert.waitone('sample_alert', message, status, 120);
  
  IF status = STT_TIMEOUT THEN
    dbms_output.put_line('timeout!!');
  ELSE
    dbms_output.put_line(message);
  END IF;
END;
/


/* for the 3rd session */
BEGIN
  dbms_alert.signal('sample_alert','alert has been fired.');
  commit;
END;
/

BEGIN
  dbms_alert.removeall;
  commit;
END;
/


