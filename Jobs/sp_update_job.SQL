-- Author: 	Hussain refaa
-- creation Date: 	2008
-- Last Updated: 	0000-00-00
-- Control Number:	xxxx-xxxx-xxxx-xxxx
-- Version: 	0.0
-- Phone : +4915775148443
-- Email: hus244@gmail.com

CREATE OR REPLACE PROCEDURE sp_update_job AS
begin
        -- first task 
	delete from documents where ttl>0 and ttl<sysdate and ttlaction_id=1;
        -- second task 
        update documents set isdeleted=1 where ttl>0 and ttl<sysdate
        and ttlaction_id=0 and isdeleted=0;
        commit;
end;
/



declare
     v number;
      i int;
 begin
     
     --Execute every 1 sec.   
     --'SYSDATE + 1/86400' 86400=24*60*60 mean the number of sec in the day
     dbms_job.submit(v,'sp_update_job;',sysdate,'SYSDATE + 1/86400',true);
     dbms_job.run(v);
     --dmbs_job.broken(v);     
    
 end;
 /
