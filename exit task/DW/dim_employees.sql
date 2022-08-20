alter session set current_schema = DW_DATA;
drop table DIM_employee


alter session set current_schema = DW_DATA;
CREATE TABLE DIM_EMPLOYEES (
    employee_id              NUMBER(5),
    first_name_EMPLOYEE      VARCHAR2(40),
    last_name_EMPLOYEE       VARCHAR2(40),
    email_EMPLOYEE           VARCHAR2(40),
    phone_EMPLOYEE           VARCHAR2(40),
    POSITION_NAME_ACTUAL     VARCHAR2(40),
    POSITION_DEGREE          VARCHAR2(40),
    SALES_TYPE               VARCHAR2(40),
    HIRE_DATE                DATE,
    salary                   INT,
    chief_id                 INT,
    position_name_previous   VARCHAR2(40),
    position_change_date     DATE,
    CONSTRAINT PK_DIM_EMPLOYEE PRIMARY KEY ( employee_id) ENABLE
);