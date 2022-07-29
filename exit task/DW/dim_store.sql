alter session set current_schema = DW_DATA;

CREATE TABLE DIM_store (
    store_id      NUMBER(10) NOT NULL,
    manager_id    NUMBER(10) NOT NULL,
    phone         VARCHAR2(40 BYTE) NOT NULL,
    address       VARCHAR2(20 BYTE) NOT NULL,
    city          VARCHAR2(20 BYTE) NOT NULL,
    country       VARCHAR2(20 BYTE) NOT NULL,
    region        VARCHAR2(20 BYTE) NOT NULL,
    CONSTRAINT store_id_pk PRIMARY KEY ( store_id )
);