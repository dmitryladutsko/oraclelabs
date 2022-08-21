alter session set current_schema = DW_CLEANSING;
--DESCRIBE CL_CUSTOMERS
--DROP TABLE CL_CUSTOMERS;

alter session set current_schema = DW_CLEANSING;

create table CL_CUSTOMERS (
   FIRST_NAME_CUSTOMER           CHAR(20),
   LAST_NAME_CUSTOMER            CHAR(20),
   COUNTRY_CITY_CUSTOMER         CHAR(20),
   ADRESS_CUSTOMER               CHAR(50),
   EMAIL                         CHAR(30),
   PHONE_CUSTOMER                NUMBER,
   AGE                           NUMBER,
   IS_ACTIVE                     VARCHAR2(6),
   CUSTOMER_SALE_DATE            DATE
);

SELECT  * FROM CL_CUSTOMERS