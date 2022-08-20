alter session set current_schema = SAL_CL;

create table SAL_DIM_PRODUCTS (
   PRODUCT_ID           NUMBER(22,0),
   PRODUCT_NAME         VARCHAR2(10),
   MODEL_ID             NUMBER(22,0),
   MODEL_NAME           VARCHAR2(10),
   MEMORY_AMOUNT        NUMBER(22,0),
   COLOR_ID             NUMBER(22,0),
   COLOR_NAME           CHAR(25),
   PRICE                NUMBER(10),
   INSERT_DT            DATE,
   UPDATE_DT            DATE,
   constraint PK_DIM_PRODUCTS primary key (PRODUCT_ID)
);