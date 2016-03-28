-- Author: 	Hussain refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : + 4915775148443
-- Email: hus244@gmail.com

---

SQL>  SHOW PARAMETER AUDIT

NAME                                 TYPE        VALUE
------------------------------------ ----------- ------------------------------
audit_sys_operations                 boolean     FALSE
audit_trail                          string      NONE
SQL> ALTER SYSTEM SET audit_trail=db SCOPE=SPFILE;

System altered.

SQL> SHUTDOWN immediate
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
Database mounted.
Database opened.
SQL> CONNECT sys/password AS SYSDBA
Connected.
SQL> CREATE USER audit_test IDENTIFIED BY password
  2    DEFAULT TABLESPACE users
  3    TEMPORARY TABLESPACE temp
  4    QUOTA UNLIMITED ON users;

User created.

SQL> 
SQL> GRANT connect TO audit_test;

Grant succeeded.

SQL> GRANT create table, create procedure TO audit_test;

Grant succeeded.

SQL> CONNECT sys/password AS SYSDBA
Connected.
SQL> 
SQL> AUDIT ALL BY audit_test BY ACCESS;

Audit succeeded.

SQL> AUDIT SELECT TABLE, UPDATE TABLE, INSERT TABLE, DELETE TABLE BY audit_test BY ACCESS;

Audit succeeded.

SQL> AUDIT EXECUTE PROCEDURE BY audit_test BY ACCESS;

Audit succeeded.

SQL> CONN audit_test/password
Connected.
SQL> 
SQL> CREATE TABLE test_tab (
  2    id  NUMBER
  3  );

Table created.

SQL> 
SQL> INSERT INTO test_tab (id) VALUES (1);

1 row created.

SQL> UPDATE test_tab SET id = id;

1 row updated.

SQL> SELECT * FROM test_tab;

        ID
----------
         1

SQL> DELETE FROM test_tab;

1 row deleted.

SQL> 
SQL> DROP TABLE test_tab;

Table dropped.

SQL> SELECT view_name
  2  FROM   dba_views
  3  WHERE  view_name LIKE 'DBA%AUDIT%'
  4  ORDER BY view_name;
FROM   dba_views
       *
ERROR at line 2:
ORA-00942: table or view does not exist


SQL> CONN audit_test/password
Connected.
SQL> SELECT view_name
  2  FROM   dba_views
  3  WHERE  view_name LIKE 'DBA%AUDIT%'
  4  ORDER BY view_name;
FROM   dba_views
       *
ERROR at line 2:
ORA-00942: table or view does not exist


SQL> COLUMN username FORMAT A10
SQL> COLUMN owner    FORMAT A10
SQL> COLUMN obj_name FORMAT A10
SQL> COLUMN extended_timestamp FORMAT A35
SQL> 
SQL> SELECT username,
  2         extended_timestamp,
  3         owner,
  4         obj_name,
  5         action_name
  6  FROM   dba_audit_trail
  7  WHERE  owner = 'AUDIT_TEST'
  8  ORDER BY timestamp;
FROM   dba_audit_trail
       *
ERROR at line 6:
ORA-00942: table or view does not exist


SQL> conn sys/oracle as sysdba
Connected.
SQL> COLUMN username FORMAT A10
SQL> COLUMN owner    FORMAT A10
SQL> COLUMN obj_name FORMAT A10
SQL> COLUMN extended_timestamp FORMAT A35
SQL> 
SQL> SELECT username,
  2         extended_timestamp,
  3         owner,
  4         obj_name,
  5         action_name
  6  FROM   dba_audit_trail
  7  WHERE  owner = 'AUDIT_TEST'
  8  ORDER BY timestamp;

USERNAME   EXTENDED_TIMESTAMP                  OWNER      OBJ_NAME
---------- ----------------------------------- ---------- ----------
ACTION_NAME
----------------------------
AUDIT_TEST 24/04/08 12:51:36.049000 ? +02:00   AUDIT_TEST TEST_TAB
CREATE TABLE

AUDIT_TEST 24/04/08 12:51:36.064000 ? +02:00   AUDIT_TEST TEST_TAB
INSERT

AUDIT_TEST 24/04/08 12:51:36.080000 ? +02:00   AUDIT_TEST TEST_TAB
UPDATE


USERNAME   EXTENDED_TIMESTAMP                  OWNER      OBJ_NAME
---------- ----------------------------------- ---------- ----------
ACTION_NAME
----------------------------
AUDIT_TEST 24/04/08 12:51:36.096000 ? +02:00   AUDIT_TEST TEST_TAB
SELECT

AUDIT_TEST 24/04/08 12:51:36.096000 ? +02:00   AUDIT_TEST TEST_TAB
DELETE

AUDIT_TEST 24/04/08 12:51:37.908000 ? +02:00   AUDIT_TEST TEST_TAB
DROP TABLE


6 rows selected.

SQL> SELECT db_user,
  2         extended_timestamp,
  3         object_schema,
  4         object_name,
  5         action
  6  FROM   v$xml_audit_trail
  7  WHERE  object_schema = 'AUDIT_TEST'
  8  ORDER BY extended_timestamp;
FROM   v$xml_audit_trail
       *
ERROR at line 6:
ORA-00942: table or view does not exist


SQL> 
SQL> AUDIT INSERT, UPDATE, DELETE ON sys.aud$ BY ACCESS;

Audit succeeded.

SQL> CONN audit_test/password
Connected.
SQL> 
SQL> CREATE TABLE emp (
  2   empno     NUMBER(4) NOT NULL,
  3   ename     VARCHAR2(10),
  4   job       VARCHAR2(9),
  5   mgr       NUMBER(4),
  6   hiredate  DATE,
  7   sal       NUMBER(7,2),
  8   comm      NUMBER(7,2),
  9   deptno    NUMBER(2)
 10  );

Table created.

SQL> 
SQL> INSERT INTO emp (empno, ename, sal) VALUES (9999, 'Tim', 1);

1 row created.

SQL> INSERT INTO emp (empno, ename, sal) VALUES (9999, 'Larry', 50001);

1 row created.

SQL> COMMIT;

Commit complete.

SQL> CONN sys/password AS sysdba
Connected.
SQL> 
SQL> BEGIN
  2    DBMS_FGA.add_policy(
  3      object_schema   => 'AUDIT_TEST',
  4      object_name     => 'EMP',
  5      policy_name     => 'SALARY_CHK_AUDIT',
  6      audit_condition => 'SAL > 50000',
  7      audit_column    => 'SAL');
  8  END;
  9  /

PL/SQL procedure successfully completed.

SQL> CONN audit_test/password
Connected.
SQL> SELECT sal FROM emp WHERE ename = 'Tim';

       SAL
----------
         1

SQL> SELECT sal FROM emp WHERE ename = 'Larry';

       SAL
----------
     50001

SQL> 
SQL> CONN sys/password AS SYSDBA
Connected.
SQL> SELECT sql_text
  2  FROM   dba_fga_audit_trail;

SQL_TEXT
--------------------------------------------------------------------------------
SELECT sal FROM emp WHERE ename = 'Larry'

SQL> INSERT INTO emp (empno, ename, sal) VALUES (9999, 'Tim', 1);
INSERT INTO emp (empno, ename, sal) VALUES (9999, 'Tim', 1)
            *
ERROR at line 1:
ORA-00942: table or view does not exist


SQL> INSERT INTO audit_test.emp (empno, ename, sal) VALUES (9999, 'Tim', 1);

1 row created.

SQL> commit;

Commit complete.

SQL> SELECT sql_text
  2  FROM   dba_fga_audit_trail;

SQL_TEXT
--------------------------------------------------------------------------------
SELECT sal FROM emp WHERE ename = 'Larry'

SQL> BEGIN
  2    DBMS_FGA.add_policy(
  3      object_schema   => 'AUDIT_TEST',
  4      object_name     => 'EMP',
  5      policy_name     => 'SALARY_CHK_AUDIT',
  6      audit_condition => 'SAL > 50000',
  7      audit_column    => 'SAL',
  8      handler_schema  => 'AUDIT_TEST',
  9      handler_module  => 'FIRE_CLERK',
 10      enable          => TRUE);
 11  END;
 12  /
BEGIN
*
ERROR at line 1:
ORA-28101: policy already exists
ORA-06512: at "SYS.DBMS_FGA", line 17
ORA-06512: at line 2


SQL> CONN sys/password AS SYSDBA
Connected.
SQL> TRUNCATE TABLE fga_log$;

Table truncated.

SQL> SELECT sql_text FROM dba_fga_audit_trail;

no rows selected

SQL> BEGIN
  2    DBMS_FGA.add_policy(
  3      object_schema   => 'AUDIT_TEST',
  4      object_name     => 'EMP',
  5      policy_name     => 'SAL_AUDIT',
  6      audit_condition => NULL, -- Equivalent to TRUE
  7      audit_column    => 'SAL',
  8      statement_types => 'SELECT,INSERT,UPDATE,DELETE');
  9  END;
 10  /

PL/SQL procedure successfully completed.

SQL> 
SQL> CONN audit_test/password
Connected.
SQL> SELECT * FROM emp WHERE empno = 9998;

no rows selected

SQL> INSERT INTO emp (empno, ename, sal) VALUES (9998, 'Bill', 1);

1 row created.

SQL> UPDATE emp SET sal = 10 WHERE empno = 9998;

1 row updated.

SQL> DELETE emp WHERE empno = 9998;

1 row deleted.

SQL> ROLLBACK;

Rollback complete.

SQL> CONN sys/password AS SYSDBA
Connected.
SQL> SELECT sql_text FROM dba_fga_audit_trail;

SQL_TEXT
--------------------------------------------------------------------------------
SELECT * FROM emp WHERE empno = 9998
INSERT INTO emp (empno, ename, sal) VALUES (9998, 'Bill', 1)
UPDATE emp SET sal = 10 WHERE empno = 9998
DELETE emp WHERE empno = 9998

SQL> 
SQL> desc dba_fga_audit_trail
 Name                                      Null?    Type
 ----------------------------------------- -------- ----------------------------
 SESSION_ID                                NOT NULL NUMBER
 TIMESTAMP                                          DATE
 DB_USER                                            VARCHAR2(30)
 OS_USER                                            VARCHAR2(255)
 USERHOST                                           VARCHAR2(128)
 CLIENT_ID                                          VARCHAR2(64)
 EXT_NAME                                           VARCHAR2(4000)
 OBJECT_SCHEMA                                      VARCHAR2(30)
 OBJECT_NAME                                        VARCHAR2(128)
 POLICY_NAME                                        VARCHAR2(30)
 SCN                                                NUMBER
 SQL_TEXT                                           NVARCHAR2(2000)
 SQL_BIND                                           NVARCHAR2(2000)
 COMMENT$TEXT                                       VARCHAR2(4000)
 STATEMENT_TYPE                                     VARCHAR2(7)
 EXTENDED_TIMESTAMP                                 TIMESTAMP(6) WITH TIME ZONE
 PROXY_SESSIONID                                    NUMBER
 GLOBAL_UID                                         VARCHAR2(32)
 INSTANCE_NUMBER                                    NUMBER
 OS_PROCESS                                         VARCHAR2(16)
 TRANSACTIONID                                      RAW(8)
 STATEMENTID                                        NUMBER
 ENTRYID                                            NUMBER

SQL> 