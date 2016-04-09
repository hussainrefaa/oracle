-- Author: 	Hussain refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : +4915775148443
-- Email: hus244@gmail.com

/* create sample data - employee */
DECLARE
  CntEmp     NUMBER(4,0);
  CntMaxEmp  NUMBER(4,0);
  CntMonth   NUMBER(4,0);
  NameBff    VARCHAR2(4);
  SepNum     NUMBER(3,0);
  DepId      VARCHAR2(3);
BEGIN
  CntMaxEmp := 10;
  FOR CntMonth IN 1..240 LOOP
    CntEmp := 1;
    WHILE CntEmp <= CntMaxEmp LOOP
      INSERT INTO monthlysalary VALUES(
        TO_CHAR(ADD_MONTHS(TO_DATE('1980-01-01', 'YYYY-MM-DD'),CntMonth), 'YYYYMM'),
        TO_CHAR(CntEmp, '0000'),
        TO_NUMBER(TO_CHAR(SYSDATE, 'SS')) * 100,
        TO_NUMBER(TO_CHAR(SYSDATE, 'SS')) / CntEmp
      );
      
    END LOOP;
    CntMaxEmp := CntMaxEmp + 10;
  END LOOP;
    
END;
/
