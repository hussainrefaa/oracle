-- Author: 	Hussain refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : +4915775148443
-- Email: hus244@gmail.com

DECLARE
  val BINARY_INTEGER;
BEGIN
  dbms_random.initialize(123456789);
  val := dbms_random.random;
  
  dbms_output.put_line(val);
  
  dbms_random.terminate;
END;
