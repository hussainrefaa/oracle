-- Author: 	Hussen refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : + 4915775148443
-- Email: hus244@gmail.com

SELECT &columns
  FROM classes;

SELECT first_name, last_name
  FROM students
  WHERE &where_clause;

-- But a bind variable cannot be used in this manner:
VARIABLE where_clause VARCHAR2(100)

BEGIN
  :where_clause := 'WHERE ID = 10001';
END;
/

PRINT :where_clause

SELECT first_name, last_name
  FROM students
  WHERE :where_clause;
