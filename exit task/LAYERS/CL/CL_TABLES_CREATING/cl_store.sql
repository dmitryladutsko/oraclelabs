alter session set current_schema = DW_CLEANSING;

DROP TABLE CL_STORES

alter session set current_schema = DW_CLEANSING;

CREATE TABLE CL_STORES (
    country_city  VARCHAR2(20) NOT NULL,
    address       VARCHAR2(20) NOT NULL,
    phone         NUMBER NOT NULL
);

