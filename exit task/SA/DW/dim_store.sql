alter session set current_schema = DW_DATA;

CREATE TABLE DIM_store (
    phone         VARCHAR2(40 BYTE) NOT NULL,
    address       VARCHAR2(20 BYTE) NOT NULL,
    city          VARCHAR2(20 BYTE) NOT NULL,
    country       VARCHAR2(20 BYTE) NOT NULL,
    region        VARCHAR2(20 BYTE) NOT NULL
);