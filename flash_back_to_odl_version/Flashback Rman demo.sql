-- Author: 	Hussain refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : + 4915775148443
-- Email: hus244@gmail.com

---

sql> shutdown immediate;
SQL> startup mount exclusive;

SQL> alter database archivelog;

SQL> ALTER DATABASE FLASHBACK ON;
SQL> ALTER SYSTEM SET db_recovery_file_dest = 'c:\temp';
sql> ALTER SYSTEM SET db_recovery_file_dest_size = 2G;
sql> ALTER SYSTEM SET DB_FLASHBACK_RETENTION_TARGET=4320;

SQL> alter database open;

SQL> alter system switch logfile;

SQL> select estimated_flashback_size
     from   v$flashback_database_log;


RMAN> FLASHBACK DATABASE
    TO TIME = TO_DATE 
    ('06/25/03 12:00:00','MM/DD/YY HH:MI:SS');
sql> alter database open;
sql> create table ss(col1 integer);
sql> insert into vlues(23);
sql> commit;
sql> insert into vlues(23);
sql> insert into vlues(23);
sql> insert into vlues(23);
sql> commit;

sql> shutdown immediate;
sql> startup mount exclusive;

SQL> FLASHBACK DATABASE TO TIMESTAMP (SYSDATE - 5/24);
SQL> FLASHBACK DATABASE TO SCN 76239;

SQL> ALTER DATABASE RESETLOGS;

RMAN> FLASHBACK DATABASE TO BEFORE RESETLOGS;
