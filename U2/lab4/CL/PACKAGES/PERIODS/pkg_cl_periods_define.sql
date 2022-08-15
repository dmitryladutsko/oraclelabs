alter session set current_schema=DW_CLEANSING;

CREATE OR REPLACE PACKAGE pkg_cl_periods
AS  
   PROCEDURE LOAD_CLEAN_PERIODS;
END pkg_cl_periods;

--drop package pkg_cl_periods;