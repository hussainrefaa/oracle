-- Author: 	Hussain refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : +4915775148443
-- Email: hus244@gmail.com


-- backup script 
connect sys/oracle as sysdba


Connected to:
Oracle Database 10g Enterprise Edition Release 10.1.0.2.0 - Production
With the Partitioning, OLAP and Data Mining options

SQL> alter database archivelog;

SQL> select name from v$tablespace;

NAME
------------------------------
SYSTEM
UNDOTBS1
SYSAUX
USERS
TEMP
EXAMPLE

6 rows selected.

SQL> desc v$tablespace;
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 TS#                                                NUMBER
 NAME                                               VARCHAR2(30)
 INCLUDED_IN_DATABASE_BACKUP                        VARCHAR2(3)
 BIGFILE                                            VARCHAR2(3)
 FLASHBACK_ON                                       VARCHAR2(3)

SQL> select 'alter tablespace '||name ||' begin backup ;' from v$tablespace;

'ALTERTABLESPACE'||NAME||'BEGINBACKUP;'
--------------------------------------------------------------
alter tablespace SYSTEM begin backup ;
alter tablespace UNDOTBS1 begin backup ;
alter tablespace SYSAUX begin backup ;
alter tablespace USERS begin backup ;
alter tablespace TEMP begin backup ;
alter tablespace EXAMPLE begin backup ;

6 rows selected.

SQL> alter tablespace SYSTEM begin backup ;

Tablespace altered.

SQL> alter tablespace UNDOTBS1 begin backup ;

Tablespace altered.

SQL> alter tablespace SYSAUX begin backup ;

Tablespace altered.

SQL> alter tablespace USERS begin backup ;

Tablespace altered.

SQL> alter tablespace EXAMPLE begin backup ;

Tablespace altered.

SQL>  select 'alter tablespace '||name ||' end backup ;' from v$tablespace;

'ALTERTABLESPACE'||NAME||'ENDBACKUP;'
------------------------------------------------------------
alter tablespace SYSTEM end backup ;
alter tablespace UNDOTBS1 end backup ;
alter tablespace SYSAUX end backup ;
alter tablespace USERS end backup ;
alter tablespace TEMP end backup ;
alter tablespace EXAMPLE end backup ;

6 rows selected.

SQL> alter tablespace SYSTEM end backup ;

Tablespace altered.

SQL> alter tablespace UNDOTBS1 end backup ;

Tablespace altered.

SQL> alter tablespace SYSAUX end backup ;

Tablespace altered.

SQL> alter tablespace USERS end backup ;

Tablespace altered.

SQL> alter tablespace EXAMPLE end backup ;

Tablespace altered.

SQL> 
 mack acopy of tablespace and control file from opreating system;
in this dir D:\oracle\product\10.1.0\oradata\orcl

-----------------------------------------------------------------------------
-- restore script
-- delete D:\oracle\product\10.1.0\oradata\orcl\UNDOTBS01.DBF 
   for example and use this script
sql> select name from v$tablespace;
--------------------------------------------------------
SQL> alter database archivelog;

SQL> shutdown immediate;
Database closed.
Database dismounted.
ORACLE instance shut down.
SQL> startup
ORACLE instance started.

Total System Global Area  171966464 bytes                                       
Fixed Size                   787988 bytes                                       
Variable Size             145488364 bytes                                       
Database Buffers           25165824 bytes                                       
Redo Buffers                 524288 bytes                                       
ORA-00205: error in identifying controlfile, check alert log for more info 


SQL> alter database mount;

Database altered.

SQL> alter database open;
alter database open
*
ERROR at line 1:
ORA-01157: cannot identify/lock data file 4 - see DBWR trace file 
ORA-01110: data file 4: 'D:\ORACLE\PRODUCT\10.1.0\ORADATA\ORCL\USERS01.DBF' 


SQL> /
alter database open
*
ERROR at line 1:
ORA-01113: file 4 needs media recovery 
ORA-01110: data file 4: 'D:\ORACLE\PRODUCT\10.1.0\ORADATA\ORCL\USERS01.DBF' 


SQL> recover datafile 4;
Media recovery complete.
SQL> /

Database altered.

SQL> select * from scott.dept;

    DEPTNO DNAME          LOC                                                   
---------- -------------- -------------                                         
        10 ACCOUNTING     NEW YORK                                              
        20 RESEARCH       DALLAS                                                
        30 SALES          CHICAGO                                               
        40 OPERATIONS     BOSTON                                                

SQL> spool off

note :

if u take the file to another machin make

SQL> alter database open;
