alter session set current_schema=DW_CLEANSING;
GRANT SELECT ON DW_CLEANSING.cl_products TO DW_DATA;

alter session set current_schema=DW_DATA;
SELECT * FROM DIM_PRODUCTS;

alter session set current_schema=DW_DATA;
DROP SEQUENCE SEQ_PRODUCTS;
CREATE SEQUENCE SEQ_PRODUCTS
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

alter session set current_schema=DW_DATA;
CREATE OR REPLACE PACKAGE body pkg_dw_products
AS  
  PROCEDURE LOAD_DW_PRODUCTS
   AS   
      CURSOR curs_dw_products
      IS
         SELECT DISTINCT
           PRODUCT_NAME         ,
           MODEL_NAME           ,
           MEMORY_AMOUNT        ,
           COLOR_NAME           ,
           PRICE                ,
           INSERT_DT            ,
           UPDATE_DT            
           FROM DW_CLEANSING.CL_PRODUCTS;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_DATA.dim_products';
      FOR i IN curs_dw_products LOOP
         INSERT INTO DW_DATA.dim_products( 
                       PRODUCT_ID           ,
                       PRODUCT_NAME         ,
                       MODEL_NAME           ,
                       MEMORY_AMOUNT        ,
                       COLOR_NAME           ,
                       PRICE                ,
                       INSERT_DT            ,
                       UPDATE_DT            )
              VALUES ( 
                       SEQ_CUSTOMERS.NEXTVAL ,
                       I.PRODUCT_NAME         ,
                       I.MODEL_NAME           ,
                       I.MEMORY_AMOUNT        ,
                       I.COLOR_NAME           ,
                       I.PRICE                ,
                       I.INSERT_DT            ,
                       I.UPDATE_DT            );

         EXIT WHEN curs_dw_products%NOTFOUND;
      END LOOP;

      COMMIT;
   END LOAD_DW_PRODUCTS;
END pkg_dw_products;


alter session set current_schema=DW_DATA;
exec pkg_dw_products.LOAD_DW_PRODUCTS;

alter session set current_schema=DW_CLEANSING;
select count(*) from cl_products;

alter session set current_schema=DW_DATA;
select count(*) from dim_products;

commit;
