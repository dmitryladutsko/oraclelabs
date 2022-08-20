ALTER USER SAL_CL quota unlimited on TS_SA_CL_001;

alter session set current_schema=sal_cl;
GRANT SELECT ON DW_DATA.dim_customers TO sal_cl;

alter session set current_schema=sal_cl;
CREATE OR REPLACE PACKAGE body pkg_sal_customers
AS  
  PROCEDURE LOAD_SAL_CUSTOMERS
   AS
     BEGIN
     MERGE INTO SAL_CL.sal_dim_customers A
     USING ( SELECT CUSTOMER_ID, FIRST_NAME_CUSTOMER, LAST_NAME_CUSTOMER,COUNTRY_CITY_CUSTOMER, ADRESS_CUSTOMER, EMAIL, PHONE_CUSTOMER, AGE, IS_ACTIVE, CUSTOMER_SALE_DATE
             FROM DW_DATA.dim_customers) B
             ON (a.EMAIL = b.EMAIL)
             WHEN MATCHED THEN 
                UPDATE SET a.CUSTOMER_ID = b.CUSTOMER_ID
             WHEN NOT MATCHED THEN 
                INSERT (a.CUSTOMER_ID, a.FIRST_NAME_CUSTOMER, a.LAST_NAME_CUSTOMER, a.COUNTRY_CITY_CUSTOMER, a.ADRESS_CUSTOMER, a.EMAIL, a.PHONE_CUSTOMER, a.AGE,a.IS_ACTIVE, a.CUSTOMER_SALE_DATE)
                VALUES (b.CUSTOMER_ID, b.FIRST_NAME_CUSTOMER, b.LAST_NAME_CUSTOMER, b.COUNTRY_CITY_CUSTOMER, b.ADRESS_CUSTOMER, b.EMAIL, b.PHONE_CUSTOMER, b.AGE, b.IS_ACTIVE, b.CUSTOMER_SALE_DATE);
     COMMIT;
   END LOAD_SAL_CUSTOMERS;
END pkg_sal_customers;

alter session set current_schema=sal_cl;
exec pkg_sal_customers.LOAD_SAL_CUSTOMERS;
select * from sal_dim_customers;


alter session set current_schema=sal_cl;
select * from sal_dim_customers;


alter session set current_schema=DW_DATA;
SELECT * FROM DIM_CUSTOMERS;

commit;