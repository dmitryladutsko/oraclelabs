alter session set current_schema = DW_DATA;

SELECT * FROM  DIM_STORES;

CREATE TABLE DIM_stores (
    store_id      INT,
    country_city  VARCHAR2(20) NOT NULL,
    address       VARCHAR2(20) NOT NULL,
    phone         NUMBER NOT NULL,
    CONSTRAINT store_id_pk PRIMARY KEY ( store_id )
);