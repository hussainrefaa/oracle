-- Author: 	Hussen refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : + 4915775148443
-- Email: hus244@gmail.com

CREATE TABLE departments (
  ID           NUMBER(10)    NOT NULL,
  DESCRIPTION  VARCHAR2(50)  NOT NULL);

ALTER TABLE departments ADD (
  CONSTRAINT dept_pk PRIMARY KEY (ID));

CREATE SEQUENCE dept_seq;

---------------------------------------------
CREATE OR REPLACE TRIGGER dept_bir 
BEFORE INSERT ON departments 
FOR EACH ROW
WHEN (new.id IS NULL)
BEGIN
  SELECT dept_seq.NEXTVAL
  INTO   :new.id
  FROM   dual;
END;
/
----------------------------------------------------
INSERT INTO departments (description)
    VALUES ('Development');
------------------------------------------------
SELECT * FROM departments;
------------------------------------------------------

