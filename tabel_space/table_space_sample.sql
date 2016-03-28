-- Author: 	Hussen refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : + 4915775148443
-- Email: hus244@gmail.com
SET SERVEROUTPUT ON;

DROP USER t_user CASCADE;


drop tablespace t_data;
drop tablespace temp_data;
drop tablespace undo_t ;
drop tablespace temp_data;

CREATE TABLESPACE t_data
DATAFILE 't_data.dat' SIZE 25M
DEFAULT STORAGE (
  INITIAL 50K
  NEXT 50K
  MINEXTENTS 2
  PCTINCREASE 0)
  ONLINE;

CREATE TABLESPACE t_child
DATAFILE 'data_child.dat' SIZE 25M
DEFAULT STORAGE (
  INITIAL 50K
  NEXT 50K
  MINEXTENTS 2
  PCTINCREASE 0)
  ONLINE;


CREATE TABLESPACE t_FIX
DATAFILE 't_fix.dat' SIZE 5M
DEFAULT STORAGE (
  INITIAL 50K
  NEXT 50K
  MINEXTENTS 2
  PCTINCREASE 0)
  ONLINE;

CREATE TABLESPACE idx_test
DATAFILE 'idx_test.dat' SIZE 50M
DEFAULT STORAGE (
  INITIAL 50K
  NEXT 50K
  MINEXTENTS 2
  PCTINCREASE 0)
  ONLINE;




CREATE TEMPORARY TABLESPACE temp_data
                 TEMPFILE 'temp_data.tmp' SIZE 50M;

CREATE UNDO TABLESPACE undo_t  
DATAFILE 'undo_t.dat' size 100M;



ALTER SYSTEM SET UNDO_RETENTION = 2400;
ALTER SYSTEM SET UNDO_TABLESPACE = undo_t ;


CREATE USER t_user  IDENTIFIED BY t_user 
default tablespace t_data Temporary tablespace temp_data;

GRANT
  CREATE SESSION,
  CREATE TABLE ,
  RESOURCE,CREATE PUBLIC DATABASE LINK,
  create any procedure,
  EXECUTE ANY PROCEDURE
  TO t_user ;
/

CONN t_user/t_user 
/



