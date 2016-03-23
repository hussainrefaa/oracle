--- enable flashback area
1- conn sys/oracle as sysdba 

2- SQL> archive log list;

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

SQL> FLASHBACK DATABASE TO TIMESTAMP to_timestamp ('17.07.2008 12:30:00');

Flashback complete.

SQL> ALTER DATABASE OPEN RESETLOGS;

Database altered.