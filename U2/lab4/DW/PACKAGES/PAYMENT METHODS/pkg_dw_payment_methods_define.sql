alter session set current_schema=DW_DATA;

CREATE OR REPLACE PACKAGE pkg_dw_payment_methods
AS  
   PROCEDURE LOAD_DW_PAYMENT_METHODS;
END pkg_dw_payment_methods;

--drop package pkg_dw_payment_methods;