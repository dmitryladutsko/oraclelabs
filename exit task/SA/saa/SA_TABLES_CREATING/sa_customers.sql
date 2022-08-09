alter session set current_schema = SA_CUSTOMERS;

create table SA_CUSTOMERS (
   FIRST_NAME           CHAR(20),
   LAST_NAME            CHAR(20),
   COUNTRY              CHAR(20),
   CITY                 CHAR(25),
   ADRESS               CHAR(50),
   EMAIL                CHAR(30),
   PHONE                CHAR(20),
   AGE                  NUMBER(3,1),
   VALID_FROM           DATE,
   VALID_TO             DATE                  not null,
   IS_ACTIVE            VARCHAR2(4),
   INSERT_DT            DATE
);















/*DROP TABLE DIM_CUSTOMERS CASCADE;

ALTER TABLE DIM_CUSTOMERS DROP CONSTRAINT PK_DIM_CUSTOMERS;

alter session set current_schema = DW_DATA;
ALTER TABLE DIM_CUSTOMERS
ENABLE CONSTRAINT pk_dim_customers;*/