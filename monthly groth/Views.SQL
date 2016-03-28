-- Author: 	Hussain refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : + 4915775148443
-- Email: hus244@gmail.com
-- this view to sys user
conn sys/oracle@orcl as sysdba
---------------------------------------------------------------
create or replace view FreeSpaceWithinDataFiles
as
 SELECT   SUBSTR (df.NAME, 1, 100) file_name, 
                 df.BYTES / 1024 / 1024 allocated_mb,  
           ((df.BYTES / 1024 / 1024) - NVL (SUM (dfs.BYTES) / 1024 / 1024, 0) 
           ) used_mb,  
           NVL (SUM (dfs.BYTES) / 1024 / 1024, 0) free_space_mb 
           FROM v$datafile df, dba_free_space dfs 
           WHERE df.file# = dfs.file_id(+) 
           GROUP BY dfs.file_id, df.NAME, df.file#, df.BYTES 
           ORDER BY file_name;
----------------------------------------------------------------
---- Shows how many extents to go in a tablespace before it is full
---- Autoallocate Locally Managed Tablespaces are shown as [unknown]

create or replace view tablespaceBeforItFull
as
select NEXT.tablespace_name
      ,nvl(FREE.Maxbyte,0)/1024 Largest_freespace
      ,MAXT/1024                Maximum_next_extent
      ,FREE.Maxbyte/MAXT        Extents_Befor_full
from (
       select  tablespace_name
              ,max(next_extent) MAXT
       from    sys.DBA_SEGMENTS                  
       group by tablespace_name  ) NEXT
    ,(
       select  tablespace_name
              ,max(bytes) Maxbyte
       from    sys.DBA_FREE_SPACE
       group by tablespace_name  ) FREE
where FREE.tablespace_name(+) = NEXT.tablespace_name
order by Maximum_next_extent;
---------------------------------------------------------------
------Shows segs whose NEXT extent*2 will not fit in the largest free space
create or replace view EXT_WARNING
as
select FREE.tablespace_name
      ,FREE.Maxbyte/1024 Largest_Free
      ,NEXT.owner
      ,NEXT.segment_type
      ,NEXT.segment_name
      ,next_extent/1024 next_extent
from ( select owner,segment_type,segment_name,tablespace_name,next_extent
       from   sys.DBA_SEGMENTS                    ) NEXT
    ,( select tablespace_name,max(bytes) Maxbyte
       from   sys.DBA_FREE_SPACE
       group by tablespace_name                   ) FREE
where FREE.tablespace_name  = NEXT.tablespace_name
and   NEXT.next_extent * 2 >= FREE.Maxbyte
order by tablespace_name,owner,segment_type,segment_name;
---------------------------------------------------------------
-- Checks table and index storage clauses for all owners.
create or replace view check_storage
as
select segment_type
      ,avg(bytes/1024)  averageSegmSize
      ,next_extent/1024 nextExtent
      ,pct_increase     
      ,max(extents) currentExtents
      ,decode(max_extents,2147483645,'unltd',max_extents) maximumExtents
      ,count(*) TOTAL#
from   sys.DBA_SEGMENTS
where owner not in ('SYS','SYSTEM')
group by segment_type,next_extent,pct_increase,max_extents;
---------------------------------------------------------------
create or replace view FreeSpaceWithinTableSpace
as
select F.tablespace_name
      ,F.file_name
      ,F.bytes/1024/1024 MBYTE
      ,sum(nvl(S.bytes,0)/1024/1024) MBFREE
      ,max(nvl(S.bytes,0)/1024/1024) MB_MAX
      ,(((F.bytes/1024/1024)-nvl((sum(nvl(S.bytes,0)/1024/1024)),0)) / (F.bytes/1024/1024))*100  Pct_used
from   sys.DBA_DATA_FILES F
      ,sys.DBA_FREE_SPACE S
where  F.file_id = S.file_id(+)
group by F.tablespace_name, F.file_name, F.bytes/1024 
order by F.file_name;
----------------------------------------------------------------
-- Segments that will cause errors when they try to extent!!!
create or replace view exterror
as
SELECT   a.owner || '.' || a.segment_name "Sname", a.segment_type "Stype",
         a.BYTES / 1024 / 1024 "Size", a.next_extent / 1024 / 1024 "Next",
         a.tablespace_name "TName"
    FROM SYS.dba_segments a
   WHERE a.tablespace_name NOT LIKE 'T%MP%'        -- Exclude TEMP tablespaces
     AND next_extent * 1 >
            (                         -- Cannot extend 1x, can change to 2x...
             SELECT MAX (b.BYTES)
               FROM dba_free_space b
              WHERE a.tablespace_name = b.tablespace_name)
ORDER BY 3 DESC;
----------------------------------------------------------------
create or replace view dbGrowthPerMonth
as
SELECT   TO_CHAR (creation_time, 'RRRR_Month') perMonth,
         SUM (BYTES) / 1024 / 1024 growthInMeg  
         FROM SYS.v_$datafile  
         WHERE creation_time > SYSDATE - 365 
         GROUP BY TO_CHAR (creation_time,'RRRR_Month') ;
----------------------------------------------------------------  
create or replace view InvalidObjects
as
select OWNER,OBJECT_NAME,SUBOBJECT_NAME,  
OBJECT_ID, DATA_OBJECT_ID, OBJECT_TYPE ,CREATED,  
LAST_DDL_TIME ,TIMESTAMP, STATUS, TEMPORARY ,  
GENERATED , SECONDARY  
from dba_objects   
where status= 'INVALID';
---------------------------------------------------------------
-----  highwater <> number of used blocks
-----  The highwater mark must be greater than or equal to zero
-----  highWaterMark >= 0 if not this case error so in this case do analyze
-----  ORA-13153 invalid high water mark specified
-----  Script to determine highwater mark of tables. It is essential
-----  to run ANALYZE_SCHEMA utility or ANALYZE TABLE commands before
-----  running this script for accurate statistics.

create or replace view highWaterMark
as
SELECT   a.owner, a.table_name,a.num_rows,a.avg_space, a.avg_row_len, 
         b.blocks alcblks,a.empty_blocks,
         (b.blocks - a.empty_blocks - 1) hgwtr
    FROM dba_tables a, dba_segments b
   WHERE a.table_name = b.segment_name
     AND a.owner = b.owner
     AND a.owner NOT IN ('SYS', 'SYSTEM')
     AND a.blocks <> (b.blocks - a.empty_blocks - 1)
ORDER BY 1, 2;
---------------------------------------------------------------
grant select on FreeSpaceWithinDataFiles  to account;
grant select on FreeSpaceWithinTableSpace to account;
grant select on dbGrowthPerMonth to account;
grant select on InvalidObjects to account;
grant select on tablespaceBeforItFull to account;
grant select on EXT_WARNING to account;
grant select on check_storage to account;
grant select on exterror to account;
grant select on highWaterMark to account;



