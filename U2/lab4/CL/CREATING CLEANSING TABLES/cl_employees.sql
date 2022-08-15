alter session set current_schema = SA_PRODUCTS;

CREATE TABLE SA_EMPLOYEES (
    first_name      VARCHAR2(40) NOT NULL,
    last_name       VARCHAR2(40) NOT NULL,
    email           VARCHAR2(40) NOT NULL,
    phone           VARCHAR2(40) NOT NULL,
    POSITION_NAME   VARCHAR2(40) NOT NULL,
    POSITION_GRADE	VARCHAR2(40) NOT NULL,
    HIRE_DATE	    DATE NOT NULL
);