alter session set current_schema=DW_CLEANSING;

CREATE OR REPLACE PACKAGE pkg_cl_time
AS
   PROCEDURE LOAD_CLEAN_TIME;
END pkg_cl_time;

--drop package pkg_cl_time;