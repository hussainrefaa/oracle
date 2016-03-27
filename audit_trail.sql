-- Author: 	Hussen refaa
-- creation Date: 	2008-11-10
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : +4915775148443
-- Email: hus244@gmail.com
database auditing:
------------------
SQL> conn sys@newh as sysdba
Enter password:
Connected.
SQL> alter system set audit_trail=true scope=spfile;

System altered.

SQL> shut immediate;
Database closed.
Database dismounted.
ORACLE instance shut down.
SQL> startup;
ORACLE instance started.

Total System Global Area  171966464 bytes
Fixed Size                   787988 bytes
Variable Size             145488364 bytes
Database Buffers           25165824 bytes
Redo Buffers                 524288 bytes
Database mounted.
Database opened.
***** ***************
sql statement auditing
-----------------------
SQL> audit session by hr whenever not successful;
SQL> audit session whenever  successful;

system privilege auditing
-------------------------
SQL> audit delete any table by sys by session whenever [successful|not successful] ;
SQL>  (default)


object privilege auditing
-------------------------
SQL> audit update on hr.employees  by [access|session]  whenever successful ;
(do not mention username)

*****************************************************************
how to view what is audited
------------------------------

SQL> select * from dba_stmt_audit_opts;

USER_NAME                      PROXY_NAME
------------------------------ ------------------------------
AUDIT_OPTION                             SUCCESS    FAILURE
---------------------------------------- ---------- ----------
HR
CREATE SESSION                           NOT SET    BY ACCESS

LAYLA
DELETE ANY TABLE                         BY ACCESS  BY ACCESS





SQL> select * from dba_priv_audit_opts;

USER_NAME                      PROXY_NAME
------------------------------ ------------------------------
PRIVILEGE                                SUCCESS    FAILURE
---------------------------------------- ---------- ----------
HR
CREATE SESSION                           NOT SET    BY ACCESS

LAYLA
DELETE ANY TABLE                         BY ACCESS  BY ACCESS




SQL> select * from dba_obj_audit_opts
     where lower(owner)='hr';


OWNER                          OBJECT_NAME                    OBJECT_TY
------------------------------ ------------------------------ ---------
ALT       AUD       COM       DEL       GRA       IND       INS       LOC
--------- --------- --------- --------- --------- --------- --------- ---------
REN       SEL       UPD       REF EXE       CRE       REA       WRI
--------- --------- --------- --- --------- --------- --------- ---------
FBK
---------
HR                             EMPLOYEES                      TABLE
-/-       -/-       -/-       -/-       -/-       -/-       -/-       -/-
-/-       -/-       A/-       -/- -/-       -/-       -/-       -/-
-/-


*************************************************************
results of auditing
-----------------------
session audit
----------------
SQL> select os_username,username,to_char(timestamp,'yyyy mon dd hh24:mi:ss')
     from dba_audit_session;

OS_USERNAME
--------------------------------------------------------------------------------

USERNAME                       TO_CHAR(TIMESTAMP,'YYYYMONDDH
------------------------------ -----------------------------
ORA-INSTRUCTOR\Administrator
HR                             2006 aug 06 21:39:52


object audit
-----------------
SQL> select OS_USERNAME,USERNAME,TIMESTAMP,OWNER, OBJ_NAME,ACTION_NAME
     from dba_audit_object;

OS_USERNAME
-----------------------------------------------------------------------------

USERNAME                       TIMESTAMP OWNER
------------------------------ --------- ------------------------------
OBJ_NAME
-----------------------------------------------------------------------------

ACTION_NAME
----------------------------
ORA-INSTRUCTOR\Administrator
LAYLA                          06-AUG-06 SCOTT
EMP
DELETE


OS_USERNAME
-----------------------------------------------------------------------------

USERNAME                       TIMESTAMP OWNER
------------------------------ --------- ------------------------------
OBJ_NAME
-----------------------------------------------------------------------------

ACTION_NAME
----------------------------
ORA-INSTRUCTOR\Administrator
LAYLA                          06-AUG-06 HR
EMPLOYEES
UPDATE


OS_USERNAME
-----------------------------------------------------------------------------

USERNAME                       TIMESTAMP OWNER
------------------------------ --------- ------------------------------
OBJ_NAME
-----------------------------------------------------------------------------

ACTION_NAME
----------------------------
ORA-INSTRUCTOR\Administrator
LAYLA                          06-AUG-06 HR
EMPLOYEES
DELETE


OS_USERNAME
-----------------------------------------------------------------------------

USERNAME                       TIMESTAMP OWNER
------------------------------ --------- ------------------------------
OBJ_NAME
-----------------------------------------------------------------------------

ACTION_NAME
----------------------------
ORA-INSTRUCTOR\Administrator
LAYLA                          06-AUG-06 SCOTT
SALGRADE
DELETE
*******************************************************************
stop auditing
---------------
SQL> noaudit update on hr.employees;

Noaudit succeeded.

SQL> noaudit session by hr;


Noaudit succeeded.



*******************************************************************

value based auditing(triggers)
---------------------------------
CREATE OR REPLACE TRIGGER "SYSTEM".AUDIT_SALARY_EMP AFTER
UPDATE
 OF "SALARY" ON "HR"."EMPLOYEES" REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW begin
insert into system.audit_salary_emp
values(:old.first_name||' '||:old.last_name,:old.salary,:new.salary,current_timestamp,user);
end
;
/
***********************************
3/2/08
---------
FINE_GRAINED_AUDITING
----------------------
SQL> conn sys/password@newh as sysdba
Connected.
SQL> execute dbms_fga.add_policy(-
object_schema =>'hr',-
 object_name =>'employees',-
 policy_name =>'emp_sal',-
 audit_column =>'salary',-
 enable => true,-
 statement_types =>'update,delete');

***********************
TO VIEW AUDITED INFO
--------------------
SQL> select to_char(timestamp,'yyyymmddhh24miss'),
     db_user,policy_name,sql_TEXT
     FROM DBA_FGA_AUDIT_TRAIL;
TO_CHAR(TIMEST DB_USER                        POLICY_NAME
-------------- ------------------------------ --------------------
SQL_TEXT
------------------------------------------------------------------

20060806233151 LAYLA                          EMP_SAL
update hr.employees
set salary=salary*1.1
where department_id=30


SQL> select to_char(timestamp,'yyyymmddhh24miss'),
    db_user,policy_name,sql_TEXT
    FROM DBA_FGA_AUDIT_TRAIL;

TO_CHAR(TIMEST DB_USER                        POLICY_NAME
-------------- ------------------------------ --------------------
SQL_TEXT
------------------------------------------------------------------

20060806233151 LAYLA                          EMP_SAL
update hr.employees
set salary=salary*1.1
where department_id=30


**************************************************************
