-- Author: 	Hussain refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : + 4915775148443
-- Email: hus244@gmail.com

---

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

