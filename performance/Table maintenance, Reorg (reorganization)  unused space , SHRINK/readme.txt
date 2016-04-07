Table maintenance, Reorg (reorganization)  unused space , SHRINK

There are a couple of points that can lead to unused space in datafiles. The most common are:
• Poor housekeeping/maintenance means that one or more tables have grown excessively.
 After the data is deleted from the tables,reset of HWM to reclaim the space.
• Many segments such as tables,indexes,partitions,subpartitions,
lobs and its indexes have been moved to another tablespace leaving unused spaces in the datafiles.
HWM(High Water Mark) as we all understand is the pointer to that location of a table where on any point in history the table has grown.
If there are to many rows being deleted from a table, a lot of free space exists before the HWM. Reading such tables will lead to FTS by Oracle ,
which reads all the blocks(data+empty) upto the HWM. 
Such reads are costly and causes an performance impact.
There are certain elements for reorganizing a table which can be of crucial importance to the DBA’s.
•  Free space within the data blocks can be coalesced?This is because tables with more than one freelist groups and many freelists.
 Such tables often extend frequently with enough of unused space.
 A coalesce operation will help any operations that require full table scans of the tables.
• Table rows can be organized in the order of primary key index, which can improve the performance of the application query.
 Which means that the data can be accessed very quickly with less I/O since the rows resides in adjacent blocks.
• Chained rows can be coalesced?Any rows that chained as a result of row expansion will be coalesced.
