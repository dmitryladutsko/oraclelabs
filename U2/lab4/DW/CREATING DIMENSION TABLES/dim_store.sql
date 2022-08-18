alter session set current_schema = DW_DATA;

SELECT * FROM  DIM_STORES;

CREATE TABLE DIM_stores (
    store_id      INT,
    country_city  VARCHAR2(20),
    address       VARCHAR2(20),
    phone         NUMBER,
    CONSTRAINT store_id_pk PRIMARY KEY ( store_id )
);