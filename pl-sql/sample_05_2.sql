-- Author: 	Hussain refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : +4915775148443
-- Email: hus244@gmail.com


SET SERVEROUTPUT ON



/* *** explicit cursors ******************************************* */

/* sample 5-1 - basic usage */
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



/* sample 5-2 - pass parameters to SELECT statement */
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



/* sample 5-3 : implicit cursor. */
DECLARE
  dept_count NUMBER;
BEGIN
  SELECT COUNT(*) cnt INTO dept_count FROM department;
  dbms_output.put_line(dept_count);
EXCEPTION
  WHEN TOO_MANY_ROWS THEN
    dbms_output.put_line('too many records found.');
  WHEN NO_DATA_FOUND THEN
    dbms_output.put_line('no record found.');
END;
/



/* sample 5-4 : cursor-for loop */
DECLARE
  CURSOR csr IS
    SELECT * FROM department;
BEGIN
  FOR rec IN csr LOOP
    dbms_output.put_line('ID: ' || rec.id_department || 
                         ' NAME: ' || rec.st_name);
  END LOOP;
END;



/* sample 5-5 : cursor management */
DECLARE
  err EXCEPTION;
  CURSOR csr IS
    SELECT * FROM department;
BEGIN
  OPEN csr;
  RAISE err;
  dbms_output.put_line('processed successfully.');
  CLOSE csr;
EXCEPTION
  WHEN err THEN
    IF csr%ISOPEN THEN
      CLOSE csr;
      dbms_output.put_line('cursor has been closed.');
    ELSE
      dbms_output.put_line('nothing to do.');
    END IF;
  WHEN OTHERS THEN
    dbms_output.put_line('other error.');
END;
/


