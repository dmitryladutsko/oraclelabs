alter session set current_schema=SAL_CL;

CREATE OR REPLACE PACKAGE pkg_sal_time
AS
   PROCEDURE LOAD_SAL_TIME;
END pkg_sal_time;

--drop package pkg_cl_time;