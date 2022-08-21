alter session set current_schema = DW_CLEANSING;

drop table CL_PRODUCTS

alter session set current_schema = DW_CLEANSING;

create table CL_PRODUCTS (
   PRODUCT_NAME         VARCHAR2(30),
   MODEL_NAME           VARCHAR2(20),
   MEMORY_AMOUNT        NUMBER(22,0),
   COLOR_NAME           VARCHAR2(25),
   PRICE                NUMBER(10),
   INSERT_DT            DATE,
   UPDATE_DT            DATE
);