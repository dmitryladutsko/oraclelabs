alter session set current_schema = DW_DATA;

create table DIM_PRODUCTS (
   PRODUCT_ID           NUMBER(22,0)          not null,
   PRODUCT_NAME         VARCHAR2(30),
   MODEL_NAME           VARCHAR2(20),
   MEMORY_AMOUNT        NUMBER(22,0),
   COLOR_NAME           VARCHAR2(25),
   PRICE                NUMBER(10),
   INSERT_DT            DATE,
   UPDATE_DT            DATE,
   constraint PK_DIM_PRODUCTS primary key (PRODUCT_ID)
);