-- Author: 	Hussain refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : +4915775148443
-- Email: hus244@gmail.com

DECLARE
  status INTEGER;
  pipe_exists EXCEPTION;
  PRAGMA EXCEPTION_INIT(pipe_exists, -23322);
BEGIN
  status := dbms_pipe.create_pipe('sample_pipe');
EXCEPTION
  WHEN pipe_exists THEN
    dbms_output.put_line('Pipe already exists.');
END;
/


DECLARE
  status INTEGER;
BEGIN
  dbms_pipe.pack_message('sample message 1.');
  status := dbms_pipe.send_message('sample_pipe');
END;
/



DECLARE
  status INTEGER;
  pipe_exists EXCEPTION;
  PRAGMA EXCEPTION_INIT(pipe_exists, -23322);
BEGIN
  status := dbms_pipe.create_pipe('sample_pipe');
  dbms_pipe.pack_message('sample message 1.');
  status := dbms_pipe.send_message('sample_pipe');
EXCEPTION
  WHEN pipe_exists THEN
    dbms_output.put_line('Pipe already exists.');
END;
/



SET SERVEROUTPUT ON

DECLARE
  status INTEGER;
  MsgBuffer  VARCHAR2(100);
BEGIN
  status := dbms_pipe.receive_message('sample_pipe');
  IF status = 0 THEN
    dbms_pipe.unpack_message(MsgBuffer);
    dbms_output.put_line(MsgBuffer);
  ELSE
    dbms_output.put_line('No message found in the pipe.');
  END IF;
END;
/



DECLARE
  status INTEGER;
BEGIN
  status := dbms_pipe.remove_pipe('sample_pipe');
END;
/






DECLARE
  status INTEGER;
BEGIN
  dbms_pipe.pack_message('sample message 1.');
  status := dbms_pipe.send_message('sample_pipe');
  dbms_pipe.pack_message('sample message 2.');
  status := dbms_pipe.send_message('sample_pipe');
  dbms_pipe.pack_message('sample message 3.');
  status := dbms_pipe.send_message('sample_pipe');
END;
/



DECLARE
  status INTEGER;
BEGIN
  dbms_pipe.purge('sample_pipe');
END;
/

select * from v$db_pipes
