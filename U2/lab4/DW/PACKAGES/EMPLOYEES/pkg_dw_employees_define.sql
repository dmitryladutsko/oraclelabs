alter session set current_schema=DW_DATA;

CREATE OR REPLACE PACKAGE pkg_dw_employees
AS  
   PROCEDURE LOAD_DW_EMPLOYEES;
END pkg_dw_employees;

--drop package pkg_dw_employees;