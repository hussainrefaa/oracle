----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
    -- Created on          : 14 -11-2010
    -- Development  by     : Hussain Refaa
    -- Email               : hus244@gmail.com
    -- Phone               : +4915775148443
    -- Description         : Oracle
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------	
-- This triger script will create auto increment primay key

--------------------------------------------------------
-- 1-  DDL for Sequence EMP_ID_SEQ 
--------------------------------------------------------
CREATE SEQUENCE  "EMP_ID_SEQ"  MINVALUE 1 MAXVALUE 999999999999999999999999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

--------------------------------------------------------
-- 2-  DDL for Table AFFILIATE
--------------------------------------------------------
CREATE TABLE "EMPS" 
   ("EMP_ID" NUMBER(10,0), 
	"EMP_FIRSTNAME" NUMBER(10,0), 
	"EMP_LASTNAME" VARCHAR2(32 CHAR), 
	"EMP_SAL" NUMBER(10,4) DEFAULT '0'
   ) SEGMENT CREATION IMMEDIATE 
  PCTFREE 10 PCTUSED 40 INITRANS 1 MAXTRANS 255 NOCOMPRESS LOGGING
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "EMPS_TBS" ;
  
 
--------------------------------------------------------
-- 3-  DDL for Table AFFILIATE
--------------------------------------------------------
  CREATE UNIQUE INDEX "PRIMARY_EMP" ON "EMPS" ("EMP_ID") 
  PCTFREE 10 INITRANS 2 MAXTRANS 255 COMPUTE STATISTICS 
  STORAGE(INITIAL 65536 NEXT 1048576 MINEXTENTS 1 MAXEXTENTS 2147483645
  PCTINCREASE 0 FREELISTS 1 FREELIST GROUPS 1 BUFFER_POOL DEFAULT FLASH_CACHE DEFAULT CELL_FLASH_CACHE DEFAULT)
  TABLESPACE "USERS" ;
  
--------------------------------------------------------
-- 4 DDL for Trigger EMP_ID_TRG
--------------------------------------------------------
CREATE OR REPLACE TRIGGER "EMP_ID_TRG" BEFORE INSERT ON EMPS
FOR EACH ROW
DECLARE 
v_newVal NUMBER(12) := 0;
v_incval NUMBER(12) := 0;
BEGIN
  IF INSERTING AND :new.EMP_ID IS NULL THEN
    SELECT  EMP_ID_SEQ.NEXTVAL INTO v_newVal FROM DUAL;
    -- If this is the first time this table have been inserted into (sequence == 1)
    IF v_newVal = 1 THEN 
      --get the max indentity value from the table
      SELECT NVL(max(EMP_ID),0) INTO v_newVal FROM EMPS;
      v_newVal := v_newVal + 1;
      --set the sequence to that value
      LOOP
           EXIT WHEN v_incval>=v_newVal;
           SELECT EMP_ID_SEQ.nextval INTO v_incval FROM dual;
      END LOOP;
    END IF;
    --used to emulate LAST_INSERT_ID()
    --mysql_utilities.identity := v_newVal; 
   -- assign the value from the sequence to emulate the identity column
   :new.EMP_ID := v_newVal;
  END IF;
END;
/
ALTER TRIGGER "EMP_ID_TRG" ENABLE;

--------------------------------------------------------
-- 5 Test Script
--------------------------------------------------------
Insert into EMPS (EMP_FIRSTNAME,EMP_LASTNAME,EMP_SAL) values ('JHONE','SMITH',5500);
