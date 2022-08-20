alter session set current_schema = DW_DATA;
CREATE TABLE DIM_STORES (
    store_id      NUMBER(10)  ,
    country_city  VARCHAR2(20),
    address       VARCHAR2(20),
    phone         NUMBER      ,
    CONSTRAINT PK_STORE PRIMARY KEY ( store_id )
);