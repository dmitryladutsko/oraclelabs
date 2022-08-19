alter session set current_schema=DW_CLEANSING;
GRANT SELECT ON DW_CLEANSING.cl_transactions TO DW_DATA;

alter session set current_schema = DW_DATA;

CREATE OR REPLACE PACKAGE BODY pkg_dw_fact_sales
AS
    PROCEDURE LOAD_DW_FACT_SALES
    AS
    BEGIN
        EXECUTE IMMEDIATE 'TRUNCATE TABLE fact_sales';
        DECLARE

                TYPE CURSOR_NUMBER IS TABLE OF number(10);
                TYPE CURSOR_DATE IS TABLE OF date;
       	        TYPE BIG_CURSOR IS REF CURSOR ;

	          ALL_INF BIG_CURSOR;
              SALE_ID CURSOR_NUMBER;
              DATE_ID CURSOR_DATE;
              CUSTOMER_ID CURSOR_NUMBER;
              PRODUCT_ID CURSOR_NUMBER;
              PAYMENT_METHOD_ID CURSOR_NUMBER;
              STORE_ID CURSOR_NUMBER;
              EMPLOYEE_ID CURSOR_NUMBER;

        BEGIN
            OPEN ALL_INF FOR SELECT /*+parallel (8) */
                             fac.sale_id,
                             t.date_id,
                             c.customer_id,
                             p.product_id,
                             pm.payment_method_id,
                             s.store_id,
                             emp.employee_id
                         --    SYSDATE
	          FROM (SELECT DISTINCT *
                           FROM DW_CLEANSING.cl_transactions) source_cl
                     LEFT JOIN 
                        DW_DATA.dim_time t
                     ON (source_cl.customer_sale_date=t.date_id)
                     LEFT JOIN 
                        DW_DATA.dim_customers c
                     ON (source_cl.phone_customer=c.phone_customer and source_cl.email = c.email)
                     LEFT JOIN
                        DW_DATA.dim_products p 
                     ON (source_cl.product_name=p.product_name and source_cl.model_name=p.model_name)
                     LEFT JOIN 
                        DW_DATA.dim_payment_methods pm
                     ON (source_cl.payment_method_name=pm.payment_method_name AND source_cl.bank_name=pm.bank_name)
                     LEFT JOIN 
                        DW_DATA.dim_stores s
                     ON (source_cl.phone=s.phone)
                     LEFT JOIN 
                        DW_DATA.dim_employees emp
                     ON (source_cl.phone_employee=emp.phone_employee)
                     LEFT JOIN 
                        DW_DATA.fact_sales fac
                     ON (t.date_id=fac.date_id AND c.customer_id=fac.customer_id AND p.product_id=fac.product_id 
                     AND pm.payment_method_id=fac.payment_method_id AND s.store_id=fac.store_id 
                     AND emp.employee_id=fac.employee_id)
                     where rownum <= 300000;
	
	   FETCH ALL_INF
	   BULK COLLECT INTO
              SALE_ID                  ,
              DATE_ID                  ,
              CUSTOMER_ID              ,
              PRODUCT_ID               ,
              PAYMENT_METHOD_ID        ,
              STORE_ID                 , 
              EMPLOYEE_ID              ;
                
	   CLOSE ALL_INF;
	
	   FOR i IN SALE_ID.FIRST .. SALE_ID.LAST LOOP 
       
	      IF ( SALE_ID ( i ) IS NULL ) THEN
                 INSERT INTO dw_data.fact_sales      (SALE_ID                  ,
                                                      DATE_ID                  ,
                                                      CUSTOMER_ID              ,
                                                      PRODUCT_ID               ,
                                                      PAYMENT_METHOD_ID        ,
                                                      STORE_ID                 , 
                                                      EMPLOYEE_ID              )
                                                  
                                           VALUES ( SEQ_FACT_SALES.NEXTVAL        ,
                                                      DATE_ID                  (i),
                                                      CUSTOMER_ID              (i),
                                                      PRODUCT_ID               (i),
                                                      PAYMENT_METHOD_ID        (i),
                                                      STORE_ID                 (i), 
                                                      EMPLOYEE_ID              (i));       
	         COMMIT;
	      END IF;
	   END LOOP;
	END;
   END LOAD_DW_FACT_SALES;
END pkg_dw_fact_sales;

alter session set current_schema = DW_DATA;
DROP SEQUENCE SEQ_FACT_SALES;
CREATE SEQUENCE SEQ_FACT_SALES
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

alter session set current_schema=DW_DATA;
exec pkg_dw_fact_sales.LOAD_DW_FACT_SALES;
select * from FACT_SALES order by 1;

commit;