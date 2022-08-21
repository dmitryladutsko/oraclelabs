alter session set current_schema = SA_PRODUCTS;

create table SA_PRODUCTS (
   PRODUCT_NAME         VARCHAR2(30),
   MODEL_NAME           VARCHAR2(20),
   MEMORY_AMOUNT        NUMBER(22,0),
   COLOR_NAME           CHAR(25),
   PRICE                NUMBER(10),
   INSERT_DT            DATE,
   UPDATE_DT            DATE
);