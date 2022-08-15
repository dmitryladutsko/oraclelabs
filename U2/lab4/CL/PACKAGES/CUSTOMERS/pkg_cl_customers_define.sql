alter session set current_schema=SA_CUSTOMERS;
GRANT SELECT ON SA_CUSTOMERS.sa_customers TO DW_CLEANSING; 

alter session set current_schema=DW_CLEANSING;
CREATE OR REPLACE PACKAGE body pkg_cl_customers
AS  
  PROCEDURE LOAD_CLEAN_CUSTOMERS
   AS   
      CURSOR curs_cl_customers
      IS
         SELECT DISTINCT 
               FIRST_NAME_CUSTOMER           ,
               LAST_NAME_CUSTOMER            ,
               COUNTRY_CITY_CUSTOMER         ,
               ADRESS_CUSTOMER               ,
               EMAIL                         ,
               PHONE_CUSTOMER                ,
               AGE                           ,
               IS_ACTIVE                     ,
               CUSTOMER_SALE_DATE            
           FROM SA_CUSTOMERS.sa_customers
           WHERE
           FIRST_NAME_CUSTOMER IS NOT NULL 
           AND LAST_NAME_CUSTOMER IS NOT NULL
           AND COUNTRY_CITY_CUSTOMER IS NOT NULL
           AND ADRESS_CUSTOMER IS NOT NULL
           AND EMAIL IS NOT NULL
           AND PHONE_CUSTOMER IS NOT NULL
           AND AGE IS NOT NULL
           AND IS_ACTIVE IS NOT NULL
           AND CUSTOMER_SALE_DATE IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CLEANSING.cl_customers';
      FOR i IN curs_cl_customers LOOP
         INSERT INTO DW_CLEANSING.cl_customers( 
               FIRST_NAME_CUSTOMER           ,
               LAST_NAME_CUSTOMER            ,
               COUNTRY_CITY_CUSTOMER         ,
               ADRESS_CUSTOMER               ,
               EMAIL                         ,
               PHONE_CUSTOMER                ,
               AGE                           ,
               IS_ACTIVE                     ,
               CUSTOMER_SALE_DATE            )
              VALUES (    
                        I.FIRST_NAME_CUSTOMER           ,
                        I.LAST_NAME_CUSTOMER            ,
                        I.COUNTRY_CITY_CUSTOMER         ,
                        I.ADRESS_CUSTOMER               ,
                        I.EMAIL                         ,
                        I.PHONE_CUSTOMER                ,
                        I.AGE                           ,
                        I.IS_ACTIVE                     ,
                        I.CUSTOMER_SALE_DATE            );

         EXIT WHEN curs_cl_customers%NOTFOUND;
      END LOOP;

      COMMIT;
   END LOAD_CLEAN_CUSTOMERS;
END pkg_cl_customers;


alter session set current_schema=DW_CLEANSING;
exec pkg_cl_customers.LOAD_CLEAN_CUSTOMERS;
select * from cl_customers;

commit;




   FIRST_NAME_CUSTOMER           ,
   LAST_NAME_CUSTOMER            ,
   COUNTRY_CITY_CUSTOMER         ,
   ADRESS_CUSTOMER               ,
   EMAIL                         ,
   PHONE_CUSTOMER                ,
   AGE                           ,
   IS_ACTIVE                     ,
   CUSTOMER_SALE_DATE            
