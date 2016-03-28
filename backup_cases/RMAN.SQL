-- Author: 	Hussain refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : +4915775148443
-- Email: hus244@gmail.com

Recovery Manager can operate with or without a recovery catalog

1-
 CONNECT system/oracle

2-
CREATE TABLESPACE "RMAN" 
DATAFILE 'C:\temp\RMAN01.DBF' SIZE 6208K REUSE
AUTOEXTEND ON NEXT 64K MAXSIZE 32767M
EXTENT MANAGEMENT LOCAL
SEGMENT SPACE MANAGEMENT AUTO;

3-
CREATE USER rman IDENTIFIED BY rman
TEMPORARY TABLESPACE temp 
DEFAULT TABLESPACE rman 
QUOTA UNLIMITED ON rman;

4-
GRANT connect, resource, recovery_catalog_owner TO rman;

5-

c:>rman catalog=rman/rman

--- from here install recovery catalog 
6-
create catalog tablespace "RMAN";

7-
exit;

8-
c:>

-- from here Register Database
-- Each database to be backed up by RMAN must be registered:

C:>rman catalog=rman/rman target=scott/tiger


-- this way without a recovery catalog
---------- anthoer way
1- rman nocatalog
2- connect target scott/tiger@orcl
3- run {
   allocate channel ch1 type 'SBT_TAPE';
   backup tablespace TOOLS format prompt“%u”;}

1- rman nocatalog
2- connect target scott/tiger@orcl
3-
create script foo_full {
        allocate channel t1 type 'SBT_TAPE';
        allocate channel t2 type 'SBT_TAPE';
        allocate channel t3 type 'SBT_TAPE';
     backup full filesperset 4
        database format `FOO.FULL.%n.%s.%p');run { execute script foo_full;}




-------restore data base
 run {  
        allocate channel dev1 type disk;  
        allocate channel dev2 type 'sbt_tape';  
           sql "alter tablespace tbs_1 offline immediate" ;  
           set newname for datafile 'disk7/oracle/tbs11.f' 
           to 'disk9/oracle/tbs11.f' ;  
           restore (tablespace tbs_1) ;  
           switch datafile all ;  
           recover tablespace tbs_1 ;  
           sql "alter tablespace tbs_1 online" ;  
        release channel dev1;  
        release channel dev2;  
     }  


