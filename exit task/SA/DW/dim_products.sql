alter session set current_schema = DW_DATA;

create table DIM_PRODUCTS (
   PRODUCT_NAME         VARCHAR2(10),
   MODEL_NAME           VARCHAR2(10),
   MEMORY_AMOUNT        NUMBER(22,0),
   COLOR_NAME           CHAR(25),
   PRICE                NUMBER(10),
   INSERT_DT            DATE,
   UPDATE_DT            DATE
);