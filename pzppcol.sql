--
-- PZPPCOL  (Procedure) 
--
CREATE OR REPLACE PROCEDURE pzppcol IS
tmpVar NUMBER;

cursor fac_sbgi_code is
    select pztpcol_id id,spriden_pidm pidm, pztpcol_sbgi_code sbgi_code, stvsbgi_desc college_desc from pztpcol, spriden, stvsbgi where spriden_id = pztpcol_id and spriden_change_ind is null and stvsbgi_code = pztpcol_sbgi_code;

fac_sbgi_rec fac_sbgi_code%rowtype;


/******************************************************************************
   NAME:       pzppcol
   PURPOSE:    

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        4/21/2016   santani       1. Created this procedure.

   NOTES:

   Automatically available Auto Replace Keywords:
      Object Name:     pzppcol
      Sysdate:         4/21/2016
      Date and Time:   4/21/2016, 4:46:36 PM, and 4/21/2016 4:46:36 PM
      Username:        santani (set in TOAD Options, Procedure Editor)
      Table Name:       (set in the "New PL/SQL Object" dialog)

******************************************************************************/
BEGIN
   tmpVar := 0;
   open fac_sbgi_code;
   loop
   fetch fac_sbgi_code into fac_sbgi_rec;
   exit when fac_sbgi_code%notfound;
   insert into sorpcol values (fac_sbgi_rec.pidm,fac_sbgi_rec.sbgi_code,null,null,null,null,sysdate,'STCL_CODE',0,0,null,null);
   IF SQL%ROWCOUNT = 1 THEN
      dbms_output.put_line(fac_sbgi_rec.id||' college added '||fac_sbgi_rec.college_desc);
      end if;
      commit;
   end loop;
    EXCEPTION
     WHEN NO_DATA_FOUND THEN
       NULL;
     WHEN OTHERS THEN
       -- Consider logging the error and then re-raise
       RAISE;
END pzppcol;
/
