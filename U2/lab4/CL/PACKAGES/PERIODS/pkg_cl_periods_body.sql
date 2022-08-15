alter session set current_schema=DW_CL;

CREATE OR REPLACE PACKAGE pkg_etl_cl_customers
AS  
   PROCEDURE LOAD_CLEAN_CUSTOMERS;
END pkg_etl_cl_customers;

--drop package pkg_etl_cl_customers;