-- Author: 	Hussain Refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : +4915775148443
-- Email: refaa.hussain@gmail.com


sqlplus sys/oracle as sysdba

-- drop rman tablespace ( if exsiting)
SQL> drop TABLESPACE "RMAN" INCLUDING CONTENTS;

-- drop rman user ( if exsiting)
SQL> drop user rman cascade;

-- create rman tablespace
SQL> CREATE TABLESPACE "RMAN"
     DATAFILE '/xxxx/RMAN01.DBF' SIZE 6208K REUSE
     AUTOEXTEND ON NEXT 64K MAXSIZE 32767M
     EXTENT MANAGEMENT LOCAL
     SEGMENT SPACE MANAGEMENT AUTO;


-- create rman user
SQL> CREATE USER rman IDENTIFIED BY rman
     TEMPORARY TABLESPACE temp
     DEFAULT TABLESPACE rman
     QUOTA UNLIMITED ON rman;

	 -- grant priv to rman user
SQL> GRANT connect, resource, recovery_catalog_owner TO rman;


SQL> exit

-- create rman catlog  depend on rman tablespace
RMAN> create catalog tablespace "RMAN";

RMAN> exit

RMAN> register database;

-- recovery from latest 15 days
RMAN> configure retention policy to recovery window of 15 days;

--- save backup files on hard disk
RMAN>  configure default device type to disk;

-- set rman to backup control files automaticlly 
RMAN> configure controlfile autobackup on;

RMAN>  configure channel device type disk format '/xxxx/Backup%d_DB_%u_%s_%p';

rman> CONFIGURE CONTROLFILE AUTOBACKUP FORMAT FOR DEVICE TYPE DISK TO '/xxxx/control_file/%F';

-- to prevent delete archive file automaticlly ( Must to delete manully )
RMAN> CONFIGURE ARCHIVELOG DELETION POLICY TO NONE;


RMAN> exit


sqlplus sys/oracle as sysdba

-- shut database mandatory
SQL> shutdown immediate;

-- startup in mount case
SQL> startup mount;

-- set database in archiving mode
SQL> alter database archivelog;

-- open database after set to arechiving log
SQL> alter database open;


sql> exit


rman catalog=rman/rman@orcl target=sys/oracle@orcl


--- this script will backup database beside to archive files
run {
    backup database format '/xxxx/Backup%d_DB_%u_%s_%p'plus archivelog format '/xxxx/archive/ora_comp0%d_%T_%U_lvl0Tarch'  ;
    ### delete all obsolete : delete backups older than the retention policy
    delete noprompt obsolete;
  }


--- if we want to backup with delete old archive files
run {
 backup database plus archivelog delete input;
 }


--  this script to delete all expired backup 

RMAN> configure retention policy to recovery window of 15 days;

RMAN> 
run {
    backup database format '/xxxx/Backup%d_DB_%u_%s_%p'plus archivelog format '/xxxx/archive/ora_comp0%d_%T_%U_lvl0Tarch'  ;
    ### delete all obsolete : delete backups older than the retention policy
    delete expired backup;
  }



RMAN>

//////////////////////
-- performe validate to database to assure 
-- if the backup files is correct
run {
  restore database validate;
}

-- You can also check on the ability to restore an individual tablespace: 

run {
  restore tablespace read_only_tbs validate;
}


--- to restore database 

sql> shutdown immediate
sql> startup mount
sql> exit;

cmd> rman target sys/oracle 

rman> restore database;
rman> recover database;

rman> alter database open;




