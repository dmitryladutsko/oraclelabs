alter session set current_schema=sal_cl;
GRANT SELECT ON dw_data.dim_stores TO sal_cl;
  
  
  alter session set current_schema=sal_cl;
CREATE OR REPLACE PACKAGE body pkg_sal_stores
AS  
  PROCEDURE LOAD_SAL_STORES
   AS   
      CURSOR curs_sal_stores
      IS
         SELECT DISTINCT
            store_id   ,
            country_city  ,
            address  ,
            phone 
           FROM DW_DATA.DIM_STORES;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE sal_cl.sal_dim_stores';
      FOR i IN curs_sal_stores LOOP
         INSERT INTO sal_cl.sal_dim_stores( 
                                            store_id   ,
                                            country_city  ,
                                            address  ,
                                            phone)
              VALUES ( 
                                    i.store_id   ,
                                    i.country_city  ,
                                    i.address  ,
                                    i.phone);
         EXIT WHEN curs_sal_stores%NOTFOUND;
      END LOOP;

      COMMIT;
   END LOAD_SAL_STORES;
END pkg_sal_stores;

alter session set current_schema=sal_cl;
exec pkg_sal_stores.LOAD_SAL_STORES;

alter session set current_schema=sal_cl;
select * from sal_dim_stores;

alter session set current_schema=dw_data;
select * from dim_stores;

commit;