alter session set current_schema = SA_DATE;

CREATE TABLE SA_STORES (
    phone         VARCHAR2(40 BYTE) NOT NULL,
    address       VARCHAR2(20 BYTE) NOT NULL,
    city          VARCHAR2(20 BYTE) NOT NULL,
    country       VARCHAR2(20 BYTE) NOT NULL,
    region        VARCHAR2(20 BYTE) NOT NULL
);

