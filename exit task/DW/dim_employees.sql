alter session set current_schema = DW_DATA;

CREATE TABLE DIM_employee (
  employee_id              NUMBER(5) not null,
    first_name_EMPLOYEE      VARCHAR2(40) NOT NULL,
    last_name_EMPLOYEE       VARCHAR2(40) NOT NULL,
    email_EMPLOYEE           VARCHAR2(40) NOT NULL,
    phone_EMPLOYEE           VARCHAR2(40) NOT NULL,
    POSITION_NAME_ACTUAL     VARCHAR2(40) NOT NULL,
    POSITION_DEGREE          VARCHAR2(40) NOT NULL,
    SALES_TYPE               VARCHAR2(40) NOT NULL,
    HIRE_DATE                DATE NOT NULL,
    salary                   int not null,
    chief_id                 int not null,
    position_name_previous   VARCHAR2(40) NOT NULL,
    position_change_date     DATE not null
);
commit;