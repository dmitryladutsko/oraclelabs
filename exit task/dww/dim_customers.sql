alter session set current_schema = DW_DATA;
drop table DIM_CUSTOMERS
ALTER TABLE DIM_CUSTOMERS DROP CONSTRAINT PK_DIM_CUSTOMERS;

alter session set current_schema = DW_DATA;
create table DIM_CUSTOMERS (
   CUSTOMER_ID                   NUMBER(22,0),
   FIRST_NAME_CUSTOMER           CHAR(20),
   LAST_NAME_CUSTOMER            CHAR(20),
   COUNTRY_CITY_CUSTOMER         CHAR(20),
   ADRESS_CUSTOMER               CHAR(50),
   EMAIL                         CHAR(30),
   PHONE_CUSTOMER                NUMBER,
   AGE                           NUMBER,
   IS_ACTIVE                     VARCHAR2(6),
   CUSTOMER_SALE_DATE            DATE,
   CONSTRAINT PK_DIM_CUSTOMERS PRIMARY KEY ( CUSTOMER_ID )
);
ALTER TABLE DIM_CUSTOMERS DROP CONSTRAINT PK_DIM_CUSTOMERS;

alter session set current_schema = DW_DATA;
ALTER TABLE DIM_CUSTOMERS
ENABLE CONSTRAINT pk_dim_customers;