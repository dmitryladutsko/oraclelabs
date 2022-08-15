alter session set current_schema=DW_CLEANSING;

CREATE OR REPLACE PACKAGE pkg_cl_employees
AS  
   PROCEDURE LOAD_CLEAN_EMPLOYEES;
END pkg_cl_employees;

--drop package pkg_etl_cl_employees;