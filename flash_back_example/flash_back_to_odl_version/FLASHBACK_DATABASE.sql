-- Author: 	Hussain refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : + 4915775148443
-- Email: hus244@gmail.com

---

--- enable flashback area
1- conn sys/oracle as sysdba 

2- SQL> archive log list;

alter system set DB_RECOVERY_FILE_DEST_SIZE = 2585570312192 k scope=both;
-- alter system set db_flashback_retention_target=2880
     scope=both;

SQL> shutdown immediate;

SQL>  startup mount;

SQL> alter database flashback on;

SQL> alter database open;


SQL> archive log list;


--- restore data using flaskback
SQL> SHUTDOWN IMMEDIATE;

SQL> STARTUP MOUNT;

SQL> FLASHBACK DATABASE TO TIMESTAMP to_timestamp ('17.07.2008 12:30:00 AM');

Flashback complete.

SQL> ALTER DATABASE OPEN RESETLOGS;

Database altered.