-- Author: 	Hussain refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : + 4915775148443
-- Email: hus244@gmail.com

---

conn sys/oracle as sysdba


SQL> archive log list;

SQL> alter system set db_flashback_retention_target=2880
     scope=both;

System altered.

SQL> shutdown immediate;
Database closed.
Database dismounted.
ORACLE instance shut down.
SQL>  startup mount;
ORACLE instance started.

Total System Global Area  612368384 bytes
Fixed Size                  1250428 bytes
Variable Size             205523844 bytes
Database Buffers          398458880 bytes
Redo Buffers                7135232 bytes
Database mounted.
SQL> startup mount;
ORA-01081: cannot start already-running ORACLE - shut it down first
SQL> startup mount;
ORA-01081: cannot start already-running ORACLE - shut it down first
SQL> alter database flashback on;

Database altered.

SQL> alter database open;

Database altered.

SQL> select oldest_flashback_scn, oldest_flashback_time from
  2  v$flashback_database_log;

OLDEST_FLASHBACK_SCN OLDEST_FLASHBACK_TI
-------------------- -------------------
              829476 2008-03-09:14:56:49

SQL> truncate table hr.employees;
truncate table hr.employees
                  *
ERROR at line 1:
ORA-02266: unique/primary keys in table referenced by enabled foreign keys


SQL> select * from scott.emp;

     EMPNO ENAME      JOB              MGR HIREDATE                   SAL
---------- ---------- --------- ---------- ------------------- ----------
      COMM     DEPTNO
---------- ----------
      7369 SMITH      CLERK           7902 1980-12-17:00:00:00        880
                   20

      7499 ALLEN      SALESMAN        7698 1981-02-20:00:00:00       1760
       300         30

      7521 WARD       SALESMAN        7698 1981-02-22:00:00:00       1375
       500         30


     EMPNO ENAME      JOB              MGR HIREDATE                   SAL
---------- ---------- --------- ---------- ------------------- ----------
      COMM     DEPTNO
---------- ----------
      7566 JONES      MANAGER         7839 1981-04-02:00:00:00     3272.5
                   20

      7654 MARTIN     SALESMAN        7698 1981-09-28:00:00:00       1375
      1400         30

      7698 BLAKE      MANAGER         7839 1981-05-01:00:00:00       3135
                   30


     EMPNO ENAME      JOB              MGR HIREDATE                   SAL
---------- ---------- --------- ---------- ------------------- ----------
      COMM     DEPTNO
---------- ----------
      7782 CLARK      MANAGER         7839 1981-06-09:00:00:00       2695
                   10

      7788 SCOTT      ANALYST         7566 1987-04-19:00:00:00       3300
                   20

      7839 KING       PRESIDENT            1981-11-17:00:00:00       5500
                   10


     EMPNO ENAME      JOB              MGR HIREDATE                   SAL
---------- ---------- --------- ---------- ------------------- ----------
      COMM     DEPTNO
---------- ----------
      7844 TURNER     SALESMAN        7698 1981-09-08:00:00:00       1650
         0         30

      7876 ADAMS      CLERK           7788 1987-05-23:00:00:00       1210
                   20

      7900 JAMES      CLERK           7698 1981-12-03:00:00:00       1045
                   30


     EMPNO ENAME      JOB              MGR HIREDATE                   SAL
---------- ---------- --------- ---------- ------------------- ----------
      COMM     DEPTNO
---------- ----------
      7902 FORD       ANALYST         7566 1981-12-03:00:00:00       3300
                   20

      7934 MILLER     CLERK           7782 1982-01-23:00:00:00       1430
                   10


14 rows selected.

SQL> truncate table scott.emp;

Table truncated.

sql> select oldest_flashback_scn, oldest_flashback_time from
    v$flashback_database_log;
SQL> flashback database to timestamp(to_timestamp('08-mar-08 03:41:00 pm'));
flashback database to timestamp(to_timestamp('08-mar-08 03:41:00 pm'))
*
ERROR at line 1:
ORA-38757: Database must be mounted and not open to FLASHBACK.


SQL> shut immediate
Database closed.
Database dismounted.
ORACLE instance shut down.
SQL> startup mount
ORACLE instance started.

Total System Global Area  612368384 bytes
Fixed Size                  1250428 bytes
Variable Size             213912452 bytes
Database Buffers          390070272 bytes
Redo Buffers                7135232 bytes
Database mounted.
SQL>
SQL> flashback database to timestamp(to_timestamp('08-mar-08 03:41:00 pm'));
flashback database to timestamp(to_timestamp('08-mar-08 03:41:00 pm'))
*
ERROR at line 1:
ORA-38729: Not enough flashback database log data to do FLASHBACK.


SQL> flashback database to timestamp(to_timestamp('09-mar-08 03:41:00 pm'))
  2  ;

Flashback complete.
sql>alter database open read only; -- to assure relative the old data
sql> select * from scott.emp;
sql> shut immediate;
sql> startup mount
sql> alter database open resetlogs; -- to begen a new flashback ciycle
