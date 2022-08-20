alter session set current_schema=DW_CLEANSING;
GRANT SELECT ON DW_CLEANSING.cl_stores TO DW_DATA;

alter session set current_schema=DW_DATA;

   /* store_id      NUMBER(10)  ,
    country_city  VARCHAR2(20),
    address       VARCHAR2(20),
    phone         NUMBER   */   

CREATE OR REPLACE PACKAGE body pkg_dw_stores
AS  
  PROCEDURE LOAD_DW_STORE
   AS
     BEGIN
      DECLARE
       TYPE CURSOR_NUMBER IS TABLE OF NUMBER;
       TYPE CURSOR_VARCHAR IS TABLE OF VARCHAR2(20);
       TYPE BIG_CURSOR IS REF CURSOR ;
 
    ALL_INF BIG_CURSOR;
       
            store_id      CURSOR_NUMBER      ;
            country_city  CURSOR_VARCHAR     ;
            address       CURSOR_VARCHAR     ;
            phone_STAGE CURSOR_NUMBER        ;
       
 BEGIN
    OPEN ALL_INF FOR
        SELECT 
                source_CL.country_city AS country_city_source_CL,
                source_CL.address AS address_source_CL,
                stage.phone AS phone,
                stage.store_id AS store_id
           FROM (SELECT DISTINCT * FROM DW_CLEANSING.cl_stores) source_CL
                     LEFT JOIN DW_DATA.dim_stores stage
                     ON (stage.phone = stage.phone);
    FETCH ALL_INF
    BULK COLLECT INTO
            store_id   ,
            country_city  ,
            address  ,
            phone_STAGE ;
    CLOSE ALL_INF;
 FOR i IN store_id.FIRST .. store_id.LAST LOOP
       IF ( store_id ( i ) IS NULL ) THEN
          INSERT INTO DW_DATA.dim_stores ( 
                                            store_id   ,
                                            country_city  ,
                                            address  ,
                                            phone_STAGE )
                                            
               VALUES (                     SEQ_STORES.NEXTVAL,
                                            country_city(I)  ,
                                            address(I)  ,
                                            phone_STAGE(I));
          COMMIT;
          
          ELSE UPDATE DW_DATA.DIM_STORES
         SET 
            country_city = country_city(I),
            address = address(I),
            phone = phone(I)
         WHERE store_id = store_id(i);
          COMMIT; 
       END IF;
    END LOOP;
   
 END;
   END LOAD_DW_STORE;
END pkg_dw_stores;



alter session set current_schema=DW_DATA;
exec pkg_etl_dw_currencies.LOAD_DW_CURRENCY;
select * from dim_stores;

commit;

DROP SEQUENCE SEQ_STORES;
CREATE SEQUENCE SEQ_STORES
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;