
alter session set current_schema=SA_PRODUCTS;
GRANT SELECT ON SA_PRODUCTS.SA_PRODUCTS TO DW_CLEANSING; 

alter session set current_schema=DW_CLEANSING;
CREATE OR REPLACE PACKAGE body pkg_cl_products
AS  
  PROCEDURE LOAD_CLEAN_PRODUCTS
   AS   
      CURSOR curs_cl_products
      IS
         SELECT DISTINCT
           PRODUCT_NAME         ,
           MODEL_NAME           ,
           MEMORY_AMOUNT        ,
           COLOR_NAME           ,
           PRICE                ,
           INSERT_DT            ,
           UPDATE_DT            
           FROM SA_PRODUCTS.SA_PRODUCTS
           WHERE
               PRODUCT_NAME             IS NOT NULL
               AND MODEL_NAME           IS NOT NULL
               AND MEMORY_AMOUNT        IS NOT NULL
               AND COLOR_NAME           IS NOT NULL
               AND PRICE                IS NOT NULL
               AND INSERT_DT            IS NOT NULL
               AND UPDATE_DT            IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CLEANSING.cl_products';
      FOR i IN curs_cl_products LOOP
         INSERT INTO DW_CLEANSING.cl_products( 
                       PRODUCT_NAME         ,
                       MODEL_NAME           ,
                       MEMORY_AMOUNT        ,
                       COLOR_NAME           ,
                       PRICE                ,
                       INSERT_DT            ,
                       UPDATE_DT            )
              VALUES ( 
                       I.PRODUCT_NAME         ,
                       I.MODEL_NAME           ,
                       I.MEMORY_AMOUNT        ,
                       I.COLOR_NAME           ,
                       I.PRICE                ,
                       I.INSERT_DT            ,
                       I.UPDATE_DT            );

         EXIT WHEN curs_cl_products%NOTFOUND;
      END LOOP;

      COMMIT;
   END LOAD_CLEAN_PRODUCTS;
END pkg_cl_products;


alter session set current_schema=DW_CLEANSING;
exec pkg_cl_products.LOAD_CLEAN_PRODUCTS;
select * from cl_products;

alter session set current_schema=DW_CLEANSING;
select count(*) from cl_products;

alter session set current_schema=SA_PRODUCTS;
select count(*) from sa_products;

commit;
