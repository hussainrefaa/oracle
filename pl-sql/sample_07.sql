-- Author: 	Hussain refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : +4915775148443
-- Email: hus244@gmail.com


/* 7-1 : preparation */
begin
  dbms_output.enable(10000);
end;


/* sample 7-2 : record */
DECLARE
  TYPE TDeptRec IS RECORD (
    DeptId   VARCHAR2(3),
    DeptName VARCHAR2(16));
    
  DeptRec TDeptRec;

  CURSOR csr IS
    SELECT id_department, st_name FROM department;
BEGIN
  OPEN csr;
  LOOP
    FETCH csr INTO DeptRec.DeptId, DeptRec.DeptName;
    EXIT WHEN csr%NOTFOUND;
    dbms_output.put_line('ID: ' || DeptRec.DeptId || ',  NAME:' || DeptRec.DeptName);
  END LOOP;
  CLOSE csr;
END;
/


/* sample 7-3 : nested record */
DECLARE
  TYPE TEmpRec IS RECORD (
    EmpId   VARCHAR2(4),
    EmpName VARCHAR2(16)
    );
  TYPE TDeptRec IS RECORD (
    DeptId   VARCHAR2(3),
    DeptName VARCHAR2(16),
    EmpRec   TEmpRec);
  
  DeptRec TDeptRec;
  
  CURSOR CsrDept IS
    SELECT id_department, st_name FROM department;
  CURSOR CsrEmp (tmp VARCHAR2) IS
    SELECT id_employee, st_name FROM employee WHERE id_employee = '0' || tmp;
  
BEGIN
  OPEN CsrDept;
  LOOP
    FETCH CsrDept INTO DeptRec.DeptID, DeptRec.DeptName;
    EXIT WHEN CsrDept%NOTFOUND;
    
dbms_output.put_line('0' || DeptRec.DeptID);
    
    OPEN CsrEmp(DeptRec.DeptID);
    FETCH CsrEmp INTO DeptRec.EmpRec;
    IF CsrEmp%FOUND THEN
      dbms_output.put_line('dept id: ' || DeptRec.DeptID || '  dept name: ' || DeptRec.DeptName);
      dbms_output.put_line('  >> emp id:' || DeptRec.EmpRec.EmpId || '  emp name: ' || DeptRec.EmpRec.EmpName);
    ELSE
      dbms_output.put_line('dept id: ' || DeptRec.DeptID || '  dept name: ' || DeptRec.DeptName);
      dbms_output.put_line('  >> employee not found.');
    END IF;
    CLOSE CsrEmp;
  END LOOP;
  CLOSE CsrDept;
END;
/



/* sample 7-4 : %type and %rowtype */
DECLARE
  DeptName  department.st_name%TYPE;
  DeptRec   department%ROWTYPE;
  CURSOR csr IS
    SELECT id_department, st_name FROM department;
BEGIN
  OPEN csr;
  LOOP
    FETCH csr INTO DeptRec.id_department, DeptRec.st_name;
    EXIT WHEN csr%NOTFOUND;
    DeptName := LOWER(DeptRec.st_name);
    dbms_output.put_line('ID: ' || DeptRec.id_department || ',  NAME: ' || DeptName);
  END LOOP;
  CLOSE csr;
END;
/



/* sample 7-5 : %rowtype - cursor */
DECLARE
  CURSOR csr IS
    SELECT id_department, st_name FROM department;
  rec csr%ROWTYPE;
BEGIN
  OPEN csr;
  LOOP
    FETCH csr INTO rec;
    EXIT WHEN csr%NOTFOUND;
    dbms_output.put_line('ID: ' || rec.id_department || ',  NAME: ' || rec.st_name);
  END LOOP;
  CLOSE csr;
END;
/



/* sample 7-6 : pl/sql table */
DECLARE
  cnt    PLS_INTEGER;
  
  TYPE TNums IS TABLE OF PLS_INTEGER INDEX BY BINARY_INTEGER;
  Nums   TNums;
BEGIN
  FOR cnt IN 0..10 LOOP
    Nums(cnt) := cnt * 10;
  END LOOP;
  
  FOR cnt IN 0..10 LOOP
    dbms_output.put_line(Nums(cnt));
  END LOOP;
END;
/
