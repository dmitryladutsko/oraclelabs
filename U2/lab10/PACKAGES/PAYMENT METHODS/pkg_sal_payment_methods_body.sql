alter session set current_schema=sal_cl;
GRANT SELECT ON dw_data.dim_payment_methods TO sal_cl;

alter session set current_schema=sal_cl;
CREATE OR REPLACE PACKAGE body pkg_sal_payment_methods
AS  
  PROCEDURE LOAD_SAL_PAYMENT_METHODS
   AS
     BEGIN
     MERGE INTO sal_cl.sal_dim_payment_methods A
     USING ( SELECT PAYMENT_METHOD_ID, PAYMENT_METHOD_NAME, BANK_NAME
             FROM DW_DATA.dim_payment_methods) B
             ON (a.PAYMENT_METHOD_NAME = b.PAYMENT_METHOD_NAME)
             WHEN MATCHED THEN 
                UPDATE SET a.BANK_NAME = b.BANK_NAME
             WHEN NOT MATCHED THEN 
                INSERT (a.PAYMENT_METHOD_ID, a.PAYMENT_METHOD_NAME, a.BANK_NAME)
                VALUES (b.PAYMENT_METHOD_ID ,b.PAYMENT_METHOD_NAME, b.BANK_NAME);
     COMMIT;
   END LOAD_SAL_PAYMENT_METHODS;
END pkg_sal_payment_methods;


alter session set current_schema=sal_cl;
exec pkg_sal_payment_methods.LOAD_SAL_PAYMENT_METHODS;

select * from sal_dim_payment_methods;

commit;