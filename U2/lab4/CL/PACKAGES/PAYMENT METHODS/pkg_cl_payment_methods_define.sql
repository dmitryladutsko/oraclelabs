alter session set current_schema=DW_CLEANSING;

CREATE OR REPLACE PACKAGE pkg_cl_payment_methods
AS  
   PROCEDURE LOAD_CLEAN_PAYMENT_METHODS;
END pkg_cl_payment_methods;

--drop package pkg_cl_payment_methods;