alter session set current_schema = SA_PRODUCTS;

CREATE TABLE SA_EMPLOYEES (
    first_name      VARCHAR2(40 BYTE) NOT NULL,
    last_name       VARCHAR2(40 BYTE) NOT NULL,
    email           VARCHAR2(40 BYTE) NOT NULL,
    phone           VARCHAR2(40 BYTE) NOT NULL,
    POSITION_NAME   VARCHAR2(40 BYTE) NOT NULL,
    POSITION_GRADE	VARCHAR2(40 BYTE) NOT NULL,
    HIRE_DATE	    DATE NOT NULL
);