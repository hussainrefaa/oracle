CREATE OR REPLACE FUNCTION now RETURN VARCHAR2 IS

BEGIN
  RETURN TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS');
END now;
/

CREATE OR REPLACE FUNCTION to_date1(date_in IN varchar2) RETURN VARCHAR2 IS

BEGIN
  RETURN TO_CHAR(to_date(date_in,'YYYY-MM-DD HH24:MI:SS'), 'YYYY-MM-DD HH24:MI:SS');
END to_date1;
/

create or replace function datediff( p_what in varchar2,
                                        p_d1   in date,
                                         p_d2   in date ) return number
    as
        l_result    number;
    begin
        select (p_d2-p_d1) *
               decode( upper(p_what),
                       'SS', 24*60*60, 'MI', 24*60, 'HH', 24, NULL )
        into l_result from dual;
 
       return l_result;
   end;
   /

