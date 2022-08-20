alter session set current_schema=sal_cl;

CREATE OR REPLACE PACKAGE pkg_sal_customers
AS  
   PROCEDURE LOAD_SAL_CUSTOMERS;
END pkg_sal_customers;

alter session set current_schema=sal_cl;
drop package pkg_sal_customers;