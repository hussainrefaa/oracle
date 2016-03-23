Sql > Set Heading off
Sql > Spool c:\s.sql
SELECT ' ALTER INDEX ' || INDEX_NAME || ' REBUILD ; '
FROM USER_INDEXES
Sql > Spool off
Sql >@ c:\s.sql
