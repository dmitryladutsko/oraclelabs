alter session set current_schema=sal_cl;
GRANT SELECT ON dw_data.dim_products TO sal_cl;

alter session set current_schema=DW_DATA;
SELECT * FROM DIM_PRODUCTS;


alter session set current_schema=sal_cl;
CREATE OR REPLACE PACKAGE body pkg_sal_products
AS  
  PROCEDURE LOAD_SAL_PRODUCTS
   AS   
      CURSOR curs_sal_products
      IS
         SELECT DISTINCT
           PRODUCT_ID           ,
           PRODUCT_NAME         ,
           MODEL_NAME           ,
           MEMORY_AMOUNT        ,
           COLOR_NAME           ,
           PRICE                ,
           INSERT_DT            ,
           UPDATE_DT            
           FROM DW_DATA.DIM_PRODUCTS;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE sal_cl.sal_dim_products';
      FOR i IN curs_sal_products LOOP
         INSERT INTO sal_cl.sal_dim_products( 
                       PRODUCT_ID           ,
                       PRODUCT_NAME         ,
                       MODEL_NAME           ,
                       MEMORY_AMOUNT        ,
                       COLOR_NAME           ,
                       PRICE                ,
                       INSERT_DT            ,
                       UPDATE_DT            )
              VALUES ( 
                       I.PRODUCT_ID           ,
                       I.PRODUCT_NAME         ,
                       I.MODEL_NAME           ,
                       I.MEMORY_AMOUNT        ,
                       I.COLOR_NAME           ,
                       I.PRICE                ,
                       I.INSERT_DT            ,
                       I.UPDATE_DT            );

         EXIT WHEN curs_sal_products%NOTFOUND;
      END LOOP;

      COMMIT;
   END LOAD_SAL_PRODUCTS;
END pkg_sal_products;


alter session set current_schema=sal_cl;
exec pkg_sal_products.LOAD_SAL_PRODUCTS;

alter session set current_schema=sal_cl;
select count(*) from sal_dim_products;

alter session set current_schema=DW_DATA;
select count(*) from dim_products;

commit;
