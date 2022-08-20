alter session set current_schema=sal_cl;

CREATE OR REPLACE PACKAGE pkg_sal_employees
AS  
   PROCEDURE LOAD_SAL_EMPLOYEES;
END pkg_sal_employees;

--drop package pkg_dw_employees;