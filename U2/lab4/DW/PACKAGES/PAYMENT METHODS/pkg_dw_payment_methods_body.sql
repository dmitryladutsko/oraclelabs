alter session set current_schema=DW_CLEANSING;
GRANT SELECT ON DW_CLEANSING.cl_payment_methods TO DW_DATA;

alter session set current_schema=DW_DATA;

DROP SEQUENCE SEQ_PAYMENT_METHODS;
CREATE SEQUENCE SEQ_PAYMENT_METHODS
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
CREATE OR REPLACE PACKAGE body pkg_dw_payment_methods
AS  
  PROCEDURE LOAD_DW_PAYMENT_METHODS
   AS
     BEGIN
     MERGE INTO DW_DATA.dim_payment_methods A
     USING ( SELECT PAYMENT_METHOD_NAME, BANK_NAME
             FROM DW_CLEANSING.cl_payment_methods) B
             ON (a.PAYMENT_METHOD_NAME = b.PAYMENT_METHOD_NAME)
             WHEN MATCHED THEN 
                UPDATE SET a.BANK_NAME = b.BANK_NAME
             WHEN NOT MATCHED THEN 
                INSERT (a.PAYMENT_METHOD_ID, a.PAYMENT_METHOD_NAME, a.BANK_NAME)
                VALUES (SEQ_PAYMENT_METHODS.NEXTVAL ,b.PAYMENT_METHOD_NAME, b.BANK_NAME);
     COMMIT;
   END LOAD_DW_PAYMENT_METHODS;
END pkg_dw_payment_methods;


alter session set current_schema=DW_DATA;
exec pkg_dw_payment_methods.LOAD_DW_PAYMENT_METHODS;

select * from dim_payment_methods;

commit;