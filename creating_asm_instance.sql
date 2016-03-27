-- first run the localconfig.bat in :
 c:\oracle\product\10.2.0\db_1\BIN\localconfig.bat add

1- Create Admin Directories 
mkdir c:\oracle\product\10.2.0\admin\+ASM\bdump
mkdir c:\oracle\product\10.2.0\admin\+ASM\cdump
mkdir c:\oracle\product\10.2.0\admin\+ASM\hdump
mkdir c:\oracle\product\10.2.0\admin\+ASM\pfile
mkdir c:\oracle\product\10.2.0\admin\+ASM\udump



2- Create Instance Parameter File 
in the pathe : %ORACLE_BASE%\admin\+ASM\pfile\init.ora

create this file :
###########################################
# Automatic Storage Management
###########################################
 _asm_allow_only_raw_disks=false
 asm_diskgroups='TESTDB_DATA1'

# Default asm_diskstring values for supported platforms:
#     Solaris (32/64 bit)   /dev/rdsk/*
#     Windows NT/XP         \\.\orcldisk*
#     Linux (32/64 bit)     /dev/raw/*
#     HPUX                  /dev/rdsk/*
#     HPUX(Tru 64)          /dev/rdisk/*
#     AIX                   /dev/rhdisk/*

asm_diskstring='c:\asmdisks\*'
DB_UNIQUE_NAME = +ASM


###########################################
# Diagnostics and Statistics
###########################################
background_dump_dest=c:\oracle\product\10.2.0\admin\+ASM\bdump
core_dump_dest=c:\oracle\product\10.2.0\admin\+ASM\cdump
user_dump_dest=c:\oracle\product\10.2.0\admin\+ASM\udump

###########################################
# Miscellaneous
###########################################
instance_type=asm
compatible=10.1.0.4.0

###########################################
# Pools
###########################################
large_pool_size=12M

###########################################
# Security and Auditing
###########################################
remote_login_passwordfile=exclusive


3- creating and Starting the ASM Instance 

c:\ ORADIM -NEW -ASMSID +ASM -STARTMODE auto

-- or

c:\ oradim -new -asmsid +ASM -syspwd change_on_install -pfile c:\oracle\product\10.2.0\admin\+ASM\pfile\init.ora -spfile     -startmode manual -shutmode immediate

c:\> oradim -edit -asmsid +ASM -startmode a

c:\> set oracle_sid=+ASM
c:\> sqlplus "/ as sysdba"

sql> shutdown abort
SQL> startup pfile='c:\oracle\product\10.2.0\admin\+ASM\pfile\init.ora';

SQL> create spfile from pfile='c:\oracle\product\10.2.0\admin\+ASM\pfile\init.ora';

----------------------------------------------------------------------
----------------------------------------------------------------------
-- Creating Disk Groups steps 

sql> shutdown abort
sql> startup nomount

1- Set Initialization Parameter 
SQL> alter system set "_asm_allow_only_raw_disks"=false scope=spfile;
SQL> alter system set asm_diskstring='c:\asmdisks\_file*' scope=both;


2- Bounce the ASM Instance 
SQL> shutdown abort
SQL> startup

3- Create New Directory for Device Files 
mkdir c:\asmdisks

4- Create this perl File for ASM Disks 

CreateTextFiles.pl containts :
-------------------------------------------------------
-------------------------------------------------------

my $s='0' x 2**20;

open(DF1,">c:/asmdisks/_file_disk1") || die "Cannot create file - $!\n";
open(DF2,">c:/asmdisks/_file_disk2") || die "Cannot create file - $!\n";
open(DF3,">c:/asmdisks/_file_disk3") || die "Cannot create file - $!\n";
open(DF4,">c:/asmdisks/_file_disk4") || die "Cannot create file - $!\n";

for (my $i=1; $i<1025; $i++) {
  print DF1 $s;
  print DF2 $s;
  print DF3 $s;
  print DF4 $s;
}

exit

-------------------------------------------------------
-------------------------------------------------------
-- Now, run the Perl script using your favorite Perl interpreter: 
c:\> cd c:\oracle\product\10.2.0\db_1\perl\5.8.3\bin\MSWin32-x86-multi-thread\
c:\oracle\product\10.2.0\db_1\perl\5.8.3\bin\MSWin32-x86-multi-thread\perl CreateTextFiles.pl


-----------------------------------------------
-- now Create ASM Disk Groups 
c:\> set oracle_sid=+ASM
c:\> sqlplus "/ as sysdba"

SQL> CREATE DISKGROUP testdb_data1 NORMAL REDUNDANCY
     FAILGROUP controller1 DISK 'c:\ASMDISKS\_FILE_DISK1' size 1024m, 'c:\ASMDISKS\_FILE_DISK2' size 1024m 
     FAILGROUP controller2 DISK 'c:\ASMDISKS\_FILE_DISK3'  size 1024m , 'c:\ASMDISKS\_FILE_DISK4'  size 1024m ;


-- if u want resize file
SQL> ALTER DISKGROUP testdb_data1
     RESIZE DISK testdb_data1 SIZE 2G;



-- views 

-- instance type
SQL> select instance_name from v$instance;

SQL> SELECT group_number, disk_number, mount_status, header_status, state, path
     FROM   v$asm_disk ;





SQL> select group_number, name, total_mb, free_mb, state, type
     from v$asm_diskgroup;


SQL>select INSTANCE_NAME, DB_NAME, STATUS from v$asm_client;


-- data file
SQL> select name from v$datafile;

-- log file
SQL> select * from v$logfile;

--- to show the hierarchical tree of file stored in the diskgroup
SQL> select concat('+'|| gname, sys_connect_by_path(aname,'/')) full_alias_path FROM
     (select g.name gname, a.parent_index pindex, a.name aname,
      a.reference_index rindex from v$asm_alias a, v$asm_diskgroup g 
      where a.group_number = g.group_number)
      start with (mod(pindex, power(2,24))) = 0
      connect by prior rindex = pindex;


DROP DISKGROUP testdb_data1 INCLUDING CONTENTS;


--- create tablespace on asm storage
SQL> CREATE TABLESPACE my_ts DATAFILE '+testdb_data1' SIZE 100M AUTOEXTEND ON;




--- create asm directory 
SQL> alter diskgroup DATA add directory '+DATA/oradata/orcl';

-- now create the alias
SQL> alter diskgroup DATA add alias '+DATA/oradata/orcl/nitin01.dbf' for 
     +DATA/orcl/datafile/nitin.263.3;



