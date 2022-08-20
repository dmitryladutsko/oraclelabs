alter session set current_schema=sal_cl;

CREATE OR REPLACE PACKAGE pkg_sal_payment_methods
AS  
   PROCEDURE LOAD_SAL_PAYMENT_METHODS;
END pkg_sal_payment_methods;

--drop package pkg_dw_payment_methods;