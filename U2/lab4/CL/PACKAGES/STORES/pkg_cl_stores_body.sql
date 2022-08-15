
alter session set current_schema=SA_DATE;
GRANT SELECT ON SA_DATE.SA_STORES TO DW_CLEANSING; 

alter session set current_schema=DW_CLEANSING;
CREATE OR REPLACE PACKAGE body pkg_cl_stores
AS  
  PROCEDURE LOAD_CLEAN_STORES
   AS   
      CURSOR curs_cl_stores
      IS
         SELECT DISTINCT
            country_city ,
            address      ,
            phone        
           FROM SA_DATE.SA_STORES
           WHERE
                country_city     IS NOT NULL
                AND address      IS NOT NULL
                AND phone        IS NOT NULL;
                
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CLEANSING.cl_stores';
      FOR i IN curs_cl_stores LOOP
         INSERT INTO DW_CLEANSING.cl_stores( 
                           country_city ,
                           address      ,
                           phone        )
                    VALUES ( 
                           I.country_city ,
                           I.address      ,
                           I.phone        );

         EXIT WHEN curs_cl_stores%NOTFOUND;
      END LOOP;

      COMMIT;
   END LOAD_CLEAN_STORES;
END pkg_cl_stores;


alter session set current_schema=DW_CLEANSING;
exec pkg_cl_stores.LOAD_CLEAN_STORES;
select * from cl_products;

alter session set current_schema=DW_CLEANSING;
select COUNT(*) from cl_stores;

alter session set current_schema=SA_DATE;
select COUNT(*) from sa_stores;

commit;
