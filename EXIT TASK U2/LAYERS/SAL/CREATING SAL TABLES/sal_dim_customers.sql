alter session set current_schema = SAL_CL;
drop table SAL_DIM_CUSTOMERS
ALTER TABLE SAL_DIM_CUSTOMERS DROP CONSTRAINT PK_DIM_CUSTOMERS;

alter session set current_schema = SAL_CL;
create table SAL_DIM_CUSTOMERS (
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
ALTER TABLE SAL_DIM_CUSTOMERS DROP CONSTRAINT PK_DIM_CUSTOMERS;