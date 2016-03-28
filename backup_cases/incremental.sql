-- Author: 	Hussain refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : +4915775148443
-- Email: hus244@gmail.com

-- connect to rman 
rman target sys/oracle

rman> CONFIGURE DEFAULT DEVICE TYPE TO DISK;
rman> CONFIGURE RETENTION POLICY TO REDUNDANCY 31;
rman> CONFIGURE DEVICE TYPE DISK PARALLELISM 2;
rman> CONFIGURE CHANNEL DEVICE TYPE DISK FORMAT '/xxxx/inc/orac_inc0%d_%T_%U_lvl0T';
rman> CONFIGURE CONTROLFILE AUTOBACKUP ON;
rman> CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '/xxxx/control_file/%F';

------------------------------------------------------
-- shut database mandatory
rman> SHUTDOWN IMMEDIATE;
-- startup in mount case
rman> STARTUP MOUNT;

-- set database in archive log
rman> alter database archivelog;

-- this script backup L 0 equal to full database backup
rman>
run {
   crosscheck archivelog all;
   backup force tag 'some_tag_0T' incremental level 0 check logical database  force format '/xxxx/inc/orac_inc0%d_%T_%U_lvl0T' plus archivelog format '/xxxx/archive/ora_inc0%d_%T_%U_lvl0Tarch';
   delete noprompt force archivelog all completed before "sysdate - 7";
}
-- this script backup L1 backup database from last incremental backup
-- must to run daily level 1 BY DEFAULT ITS DIFFERENTIAL backups 
rman>
run {
   crosscheck archivelog all;
   backup force tag 'some_tag_0T' incremental level 1 check logical database  force format '/xxxx/inc/orac_inc0%d_%T_%U_lvl0T' plus archivelog format '/xxxx/archive/ora_inc0%d_%T_%U_lvl0Tarch';
   delete noprompt force archivelog all completed before "sysdate - 7";
}

------------------------------------------------------
--- must to run weekly or biweekly level 0 backups
rman> BACKUP INCREMENTAL LEVEL 0 DATABASE FILESPERSET 4 format '/xxxx/inc/orac_inc0%d_%T_%U_lvl0T' plus archivelog format '/xxxx/archive/ora_inc0%d_%T_%U_lvl0Tarch';

-- must to run daily level 1  CUMULATIVE backups
rman> BACKUP INCREMENTAL LEVEL 1 CUMULATIVE  DATABASE FILESPERSET 4  format '/xxxx/inc/orac_Cum%d_%T_%U_lvl0T' plus archivelog format '/xxxx/archive/ora_cum%d_%T_%U_lvl0Tarch';


-- must to run daily level 1 BY DEFAULT ITS DIFFERENTIAL backups 
rman> BACKUP INCREMENTAL LEVEL 1 DATABASE FILESPERSET 4  format '/xxxx/inc/orac_Dif%d_%T_%U_lvl0T' plus archivelog format '/xxxx/archive/ora_diff%d_%T_%U_lvl0Tarch';

------------------------------------------------------
sql> ALTER DATABASE OPEN;
------------------------------------------------------


-- retore
----------- restore and recover
-- FIRST CASE
sql> shutdown immediate
sql> startup mount 
rman>RESTORE DATABASE VALIDATE;

-- SECOND CASE

C:\>sqlplus sys/password as sysdba

-- to khnow the SEQUENCE number and thread 
SQL> select * from v$log; 


SQL> select * from v$logfile;

sql> shutdown immediate;
---------
from the opreting system :
delete the current log file from 


sql>startup mount;
rman>
 run
 {
 set until sequence= 3 thread =1;
 restore database;
 recover database;
 sql 'alter database open resetlogs';
 }


RMAN> list incarnation of database;