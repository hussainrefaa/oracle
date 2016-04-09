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


/* exercise 1 - package header */
CREATE OR REPLACE PACKAGE t AS
  PROCEDURE cat;
END t;
/


