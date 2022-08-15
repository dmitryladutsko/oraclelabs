alter session set current_schema=SA_CUSTOMERS;
GRANT SELECT ON SA_CUSTOMERS.sa_payment_methods TO DW_CLEANSING; 

alter session set current_schema=DW_CLEANSING;
CREATE OR REPLACE PACKAGE body pkg_cl_payment_methods
AS  
  PROCEDURE LOAD_CLEAN_PAYMENT_METHODS
   AS   
      CURSOR curs_cl_payment_methods
      IS
         SELECT DISTINCT 
                    PAYMENT_METHOD_NAME ,
                    BANK_NAME  
           FROM SA_CUSTOMERS.sa_payment_methods
           WHERE
               PAYMENT_METHOD_NAME IS NOT NULL
               AND BANK_NAME IS NOT NULL;

   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CLEANSING.cl_payment_methods';
      FOR i IN curs_cl_payment_methods LOOP
         INSERT INTO DW_CLEANSING.cl_payment_methods( 
                        PAYMENT_METHOD_NAME ,
                        BANK_NAME )
              VALUES (
                        I.PAYMENT_METHOD_NAME ,
                        I.BANK_NAME );

         EXIT WHEN curs_cl_payment_methods%NOTFOUND;
      END LOOP;

      COMMIT;
   END LOAD_CLEAN_PAYMENT_METHODS;
END pkg_cl_payment_methods;



ALTER USER DW_CLEANSING quota unlimited on TS_DW_CLEANSING;
alter session set current_schema=DW_CLEANSING;
exec pkg_cl_payment_methods.LOAD_CLEAN_PAYMENT_METHODS;

alter session set current_schema=DW_CLEANSING;
select count (*) from cl_payment_methods;


alter session set current_schema = SA_CUSTOMERS;
select * from sa_payment_methods
commit;