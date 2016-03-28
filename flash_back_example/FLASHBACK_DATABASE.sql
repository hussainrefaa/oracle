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

sql> alter system set DB_RECOVERY_FILE_DEST_SIZE = 100g scope=both;

-- set form 100 daye's
sql>  alter system set db_flashback_retention_target=144000
     scope=both;



SQL> shutdown immediate;

SQL>  startup mount;

sql> alter database archivelog;
SQL> alter database flashback on;

SQL> alter database open;


SQL> archive log list;


--- restore data using flaskback
SQL> SHUTDOWN IMMEDIATE;

SQL> STARTUP MOUNT;

SQL> FLASHBACK DATABASE TO TIMESTAMP to_timestamp ('12.7.2009 10:56:00 PM');

Flashback complete.   

SQL> ALTER DATABASE OPEN RESETLOGS;

Database altered.

----------------------------------------------
--- define location must to create by system command
sql> alter system set db_recovery_file_dest = 'c:\flash_recovery_area' scope=both;

sql> alter system set DB_CREATE_ONLINE_LOG_DEST_1 = 'c:\flash_recovery_area' scope=both;
sql> alter system set DB_CREATE_ONLINE_LOG_DEST_2 = 'c:\flash_recovery_area' scope=both;
sql> alter system set DB_CREATE_ONLINE_LOG_DEST_3 = 'c:\flash_recovery_area' scope=both;
sql> alter system set DB_CREATE_ONLINE_LOG_DEST_4 = 'c:\flash_recovery_area' scope=both;
sql> alter system set DB_CREATE_ONLINE_LOG_DEST_5 = 'c:\flash_recovery_area' scope=both;

SQL> ALTER SYSTEM set DB_RECOVERY_FILE_DEST ='c:\temp'  scope = both;

--- to disable the flash recovery area
sql> alter system set db_recovery_file_dest = '' scope= both;

--- to query recovery file dest :
sql> select * from v$recovery_file_dest

-- or
sql> show parameter db_recovery_file_dest;

---or  to show flashback area dest
SELECT VALUE FROM V$PARAMETER WHERE NAME = 'db_recovery_file_dest'

----- to khnow scn  :
sql> select oldest_flashback_scn, oldest_flashback_time 
     from v$flashback_database_log;

------------------------------------------------------------------
------ views
Data Dictionary Views

-- This view is the main source and contains the following columns
V$RECOVERY_FILE_DEST


-- This view provides information about the flash recovery area disk space usage.
    Following is its main columns:

V$FLASH_RECOVERY_AREA_USAGE

select *from V$FLASH_RECOVERY_AREA_USAGE;






 -- The Yes/No column IS_RECOVERY_DEST_FILE is added to some dictionary views to indicate whether the
 -- file was created in the flash recovery area.
 -- It exists in :

 V$CONTROLFILE,
 V$LOGFILE, V$ARCHIVED_LOG,
 V$DATAFILE_COPY,
 V$BACKUP_PIECE.


--- Estimating Flashback Database Storage Requirements
sql> SELECT ESTIMATED_FLASHBACK_SIZE, RETENTION_TARGET, FLASHBACK_SIZE  
     FROM V$FLASHBACK_DATABASE_LOG;

--- --- Estimating Flashback Database Storage Requirements
sql> SELECT ESTIMATED_FLASHBACK_SIZE FROM V$FLASHBACK_DATABASE_STAT;

--- Identify Different File types and space used in Flash Recovery Area
sql> select * from v$flash_recovery_area_usage;

--- Percentage of space usable in the flash recovery area can be identified by:
SELECT (100 - sum(percent_space_used)) + sum(percent_space_reclaimable) 
FROM v$flash_recovery_area_usage;

----  show the time and cincernt SCN
SELECT current_scn, SCN_TO_TIMESTAMP(current_scn) FROM v$database

---------------------------------------------------------------------

--- using rman

-------------------
-- to copy full database = control file
rman>backup as copy database;

--- to copy as backupset
rman> configure device type disk backup type to copy;
RMAN> backup as backupset database;


-- Compressed Backups 
RMAN> CONFIGURE DEVICE TYPE DISK BACKUP TYPE TO COMPRESSED BACKUPSET;
RMAN> BACKUP AS COMPRESSED BACKUPSET DATABASE;

-- to copy archivelog
rman>backup as copy archivelog all;

--- to copy one data file
rman>backup as copy datafile 1;
-------------------

--- to copy control file
rman>backup as copy controlfilecopy all;

rman> CONFIGURE DEFAULT DEVICE TYPE TO disk;
rman> CONFIGURE DEVICE TYPE disk PARALLELISM 3;
rman> CONFIGURE CHANNEL 1 DEVICE TYPE disk CONNECT = 'c:\temp';
rman> CONFIGURE CHANNEL 2 DEVICE TYPE disk CONNECT = 'c:\temp';
rman> CONFIGURE CHANNEL 3 DEVICE TYPE disk CONNECT = 'c:\temp';


--- backup flashback area

run
 {
 allocate channel c1 type disk;
 backup recovery area;
 }

rman> CONFIGURE BACKUP OPTIMIZATION ON;

rman> BACKUP RECOVERY AREA;
-- or

rman> BACKUP RECOVERY files;

--- restore control file from flash back area

RMAN> Restore controlfile from autobackup using recovery area 'c:\recovery';


------------- sample of flashback
SQL> FLASHBACK DATABASE TO SCN 5964663

SQL> FLASHBACK DATABASE TO BEFORE SCN 5964663

SQL> FLASHBACK DATABASE TO TIMESTAMP (SYSDATE -1/24)

SQL> FLASHBACK DATABASE TO SEQUENCE 12345





