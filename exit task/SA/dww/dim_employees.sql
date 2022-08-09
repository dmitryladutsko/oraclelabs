alter session set current_schema = DW_DATA;

CREATE TABLE DIM_employee (
    employee_id     NUMBER(10) NOT NULL,
    first_name      VARCHAR2(40 BYTE) NOT NULL,
    last_name       VARCHAR2(40 BYTE) NOT NULL,
    email           VARCHAR2(40 BYTE) NOT NULL,
    phone           VARCHAR2(40 BYTE) NOT NULL,
    store_id        NUMBER(10) NOT NULL,
    POSITION_NAME   VARCHAR2(40 BYTE) NOT NULL,
    POSITION_GRADE	VARCHAR2(40 BYTE) NOT NULL,
    HIRE_DATE	    DATE NOT NULL,	
    FIRE_DATE	    DATE NOT NULL,
    MANAGER_ID	    NUMBER(10) NOT NULL,	
    M_FIRST_NAME	VARCHAR2(40 BYTE) NOT NULL,	
    M_LAST_NAME	    VARCHAR2(40 BYTE) NOT NULL,	
    M_POSITION_NAME	VARCHAR2(40 BYTE) NOT NULL,	
    CONSTRAINT employee_id_pk PRIMARY KEY ( employee_id) ENABLE
);