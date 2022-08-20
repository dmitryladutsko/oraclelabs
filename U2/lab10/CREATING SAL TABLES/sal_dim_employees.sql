alter session set current_schema = SAL_CL;

drop table SAL_DIM_EMPLOYEEs cascade CONSTRAINTS;

CREATE TABLE SAL_DIM_EMPLOYEES (
    employee_id              NUMBER(5) ,
    first_name_EMPLOYEE      VARCHAR2(40) ,
    last_name_EMPLOYEE       VARCHAR2(40) ,
    email_EMPLOYEE           VARCHAR2(40) ,
    phone_EMPLOYEE           VARCHAR2(40) ,
    POSITION_NAME_ACTUAL     VARCHAR2(40) ,
    POSITION_DEGREE          VARCHAR2(40) ,
    SALES_TYPE               VARCHAR2(40) ,
    HIRE_DATE                DATE ,
    salary                   int ,
    chief_id                 int ,
    position_name_previous   VARCHAR2(40) ,
    position_change_date     DATE ,
    CONSTRAINT employee_id_pk PRIMARY KEY ( employee_id) ENABLE
);