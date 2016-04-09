-- Author: 	Hussain refaa
-- creation Date: 	2009
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : +4915775148443
-- Email: hus244@gmail.com

SET SERVEROUTPUT ON



/* *** explicit cursors ******************************************* */

/* sample 1 - basic usage */
DECLARE
  dept_id    VARCHAR2(3);
  dept_name  VARCHAR2(16);

  CURSOR csrDept IS
    SELECT id_department, st_name FROM department;
BEGIN
  OPEN csrDept;
  LOOP
    FETCH csrDept INTO dept_id, dept_name;
    EXIT WHEN csrDept%NOTFOUND;
    dbms_output.put_line(dept_id || ' : ' || dept_name);
  END LOOP;
  CLOSE csrDept;
END;
/


/* sample 2 - pass parameters to SELECT statement */
DECLARE
  dept_id    VARCHAR2(3);
  dept_name  VARCHAR2(16);

  CURSOR csrDept(id_1 VARCHAR2, id_2 VARCHAR2) IS
    SELECT id_department, st_name
      FROM department
     WHERE id_department IN (id_1, id_2);
BEGIN
  OPEN csrDept('000', '999');
  LOOP
    FETCH csrDept INTO dept_id, dept_name;
    EXIT WHEN csrDept%NOTFOUND;
    dbms_output.put_line(dept_id || ' : ' || dept_name);
  END LOOP;
  CLOSE csrDept;

  OPEN csrDept('004', '005');
  LOOP
    FETCH csrDept INTO dept_id, dept_name;
    EXIT WHEN csrDept%NOTFOUND;
    dbms_output.put_line(dept_id || ' : ' || dept_name);
  END LOOP;
  CLOSE csrDept;
END;
/



/* *** implicit cursors ******************************************* */

/* sample 3 - basic usage */
/* sample 1 - basic usage */
DECLARE
  dept_count NUMBER;
BEGIN
  SELECT COUNT(*) INTO dept_count FROM department;
  dbms_output.put_line(dept_count);
END;
/



/* *** exercise *************************************************** */

/* exercise 1 - package header */
CREATE OR REPLACE PACKAGE t AS
  PROCEDURE cat;
END t;
/


/* exercise 1 - package body */
CREATE OR REPLACE PACKAGE BODY t AS
-- get table list
PROCEDURE cat AS
  cnt     NUMBER;
  ObjName VARCHAR2(30);
  CURSOR csrTables IS
    SELECT table_name FROM user_tables ORDER BY 1;
BEGIN
  OPEN csrTables;
  
  dbms_output.put_line('');
  dbms_output.put_line('------------------------------');

  cnt := 0;
  LOOP
    FETCH csrTables INTO ObjName;
    EXIT WHEN csrTables%NOTFOUND;
    dbms_output.put_line(TO_CHAR(cnt + 1, '000') || ': ' || ObjName);
    cnt := cnt + 1;
  END LOOP;
  CLOSE csrTables;
  
  dbms_output.put_line('------------------------------');
  dbms_output.put_line(TO_CHAR(cnt) || ' table(s) found.');
END;
END t;
/


/* exercise 2 - catalogue procedure */
CREATE OR REPLACE PROCEDURE ct AS
  CntTab   NUMBER(7,0);
  BffLine  VARCHAR2(100);
  TabName  VARCHAR2(30);
  ColName  VARCHAR2(30);
  DataType VARCHAR2(30);
  DataLen  NUMBER(7,0);
  DataPrc  NUMBER(7,0);
  DataScl  NUMBER(7,0);
  Nullable VARCHAR2(1);
  ColID    NUMBER(7,0);
  LastTab  VARCHAR2(30);
  CURSOR csr IS
    SELECT tab.table_name, col.column_name, col.data_type, col.data_length,
           col.data_precision, col.data_scale, col.nullable, col.column_id
      FROM user_tables tab, user_tab_columns col
     WHERE tab.table_name = col.table_name
     ORDER BY col.table_name, col.column_id;
BEGIN
  OPEN csr;
  
  dbms_output.put_line('');
  
  LastTab := '.';
  CntTab := 0;
  LOOP
    FETCH csr INTO TabName, ColName, DataType, DataLen, DataPrc, 
                   DataScl, Nullable, ColID;
    EXIT WHEN csr%NOTFOUND;
    
    IF LastTab <> TabName THEN
      dbms_output.put_line('-----------------------------------------------------------');
      dbms_output.put_line('[' || TabName || ']');
      LastTab := TabName;
      CntTab := CntTab + 1;
    END IF;
    
    -- set column name.
    BffLine := '.   ' || ColName;
    FOR CntRow IN LENGTH(ColName)..31 LOOP
      BffLine := BffLine || ' ';
    END LOOP;
    
    -- set nullable.
    IF Nullable = 'Y' THEN
      BffLine := BffLine || '  ';
    ELSE
      BffLine := BffLine || '* ';
    END IF;
    
    -- set data type.
    BffLine := BffLine || DataType;
    IF (DataType = 'CHAR') OR (DataType = 'VARCHAR2') THEN
      BffLine := BffLine || '(' || DataLen || ')';
    ELSIF DataType = 'NUMBER' THEN
      BffLine := BffLine || '(' || DataPrc || ',' || DataScl ||')';
    ELSIF DataType = 'DATE' THEN
      NULL;
    END IF;
    
    dbms_output.put_line(BffLine);
  END LOOP;
  CLOSE csr;
  
      dbms_output.put_line('-----------------------------------------------------------');
  dbms_output.put_line(TO_CHAR(CntTab) || ' table(s) found.');
END;
/


