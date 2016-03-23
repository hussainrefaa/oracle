
SQL*Plus: Release 10.2.0.1.0 - Production on Tue Mar 11 14:42:22 2008

Copyright (c) 1982, 2005, Oracle.  All rights reserved.


Connected to:
Oracle Database 10g Enterprise Edition Release 10.2.0.1.0 - Production
With the Partitioning, OLAP and Data Mining options



SQL> create table xxxx.dept as select * from scott.dept;
SQL> create table xxxx.emp10 as select * from scott.emp;

Table created.

SQL> alter table xxxx.dept enable row movement;

Table altered.

SQL> alter table xxxx.emp10 enable row movement;

Table altered.


SQL> update xxxx.emp10 set sal=sal*1.1 where
     DEPTNO=10;

1 row updated.

SQL> delete from xxxx.emp10 where DEPTNO=20;

2 rows deleted.

SQL> commit;

Commit complete.

sql > select versions_startscn, 
      to_char(versions_starttime, 'YYYY-MM-DD HH24:MI:SS'),
      versions_xid, versions_operation, EMPNO, ENAME, 
      comm, SAL from xxxx.EMP10 versions
      between scn minvalue and maxvalue 
      where versions_startscn is not null order by 
      versions_startscn desc

-- where versions_startscn <> 4284184 
SQL> flashback table xxxx.emp10 to scn 4284184;


sql> select * from xxxx.emp10 
     where  DEPTNO= 40;

