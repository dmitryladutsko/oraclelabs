alter session set current_schema=sal_cl;
GRANT SELECT ON dw_data.fact_sales TO sal_cl; 

alter session set current_schema=sal_cl;
CREATE OR REPLACE PACKAGE body pkg_sal_fact_sales
AS  
  PROCEDURE LOAD_SAL_FACT_SALES
   AS   
      CURSOR curs_sal_fact_sales
      IS
         SELECT DISTINCT
                                SALE_ID           ,
                                DATE_ID           ,
                                CUSTOMER_ID       ,
                                PRODUCT_ID        ,
                                PAYMENT_METHOD_ID ,
                                STORE_ID          ,
                                EMPLOYEE_ID       
           FROM DW_DATA.FACT_SALES;                
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE sal_cl.sal_fact_sales';
      FOR i IN curs_sal_fact_sales LOOP
         INSERT INTO sal_cl.sal_fact_sales( 
                SALE_ID           ,
                DATE_ID           ,
                CUSTOMER_ID       ,
                PRODUCT_ID        ,
                PAYMENT_METHOD_ID ,
                STORE_ID          ,
                EMPLOYEE_ID       )
                    VALUES ( 
                                I.SALE_ID           ,
                                I.DATE_ID           ,
                                I.CUSTOMER_ID       ,
                                I.PRODUCT_ID        ,
                                I.PAYMENT_METHOD_ID ,
                                I.STORE_ID          ,
                                I.EMPLOYEE_ID       );

         EXIT WHEN curs_sal_fact_sales%NOTFOUND;
      END LOOP;

      COMMIT;
   END LOAD_SAL_FACT_SALES;
END pkg_sal_fact_sales;


alter session set current_schema=sal_cl;
exec pkg_sal_fact_sales.LOAD_SAL_FACT_SALES;

alter session set current_schema=DW_DATA;
select COUNT(*) from fact_sales;

alter session set current_schema=SAL_CL;
select COUNT(*) from sal_fact_sales;

commit;