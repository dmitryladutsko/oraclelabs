
alter session set current_schema = DW_DATA;
drop table fact_sales;

alter session set current_schema = DW_DATA;
create table FACT_SALES (
SALE_ID             NUMBER(22,0),
CUSTOMER_ID          NUMBER(22,0),
PRODUCT_ID           NUMBER(22,0),
PAYMENT_METHOD_ID    NUMBER(10,0),
STORE_ID             NUMBER(10,0),
EMPLOYEE_ID          NUMBER(10,0),
DATE_ID              DATE        ,
UPDATE_DT            DATE        ,
   /*PERIOD_ID            NUMBER(22,0),
   GEO_ID               NUMBER(22),*/

   constraint PK_FACT_SALES primary key (SALE_ID)
)
--drop table FACT_SALES;
PARTITION BY RANGE (date_id)
    subpartition by hash(CUSTOMER_ID) subpartitions 4
(
    PARTITION QUARTER_1 VALUES LESS THAN(TO_DATE('01.04.2020', 'DD/MM/YYYY'))
    (
      subpartition QUARTER_1_sub_1,
      subpartition QUARTER_1_sub_2,
      subpartition QUARTER_1_sub_3,
      subpartition QUARTER_1_sub_4
    ),
    PARTITION QUARTER_2 VALUES LESS THAN(TO_DATE('01.07.2020', 'DD/MM/YYYY'))
    (
      subpartition QUARTER_2_sub_1,
      subpartition QUARTER_2_sub_2,
      subpartition QUARTER_2_sub_3,
      subpartition QUARTER_2_sub_4
     ),
     PARTITION QUARTER_3 VALUES LESS THAN(TO_DATE('01.10.2020', 'DD/MM/YYYY'))
    (
       subpartition QUARTER_3_sub_1,
      subpartition QUARTER_3_sub_2,
      subpartition QUARTER_3_sub_3,
      subpartition QUARTER_3_sub_4
    ),
     PARTITION QUARTER_4 VALUES LESS THAN(TO_DATE('01.01.2021', 'DD/MM/YYYY'))
    (
      subpartition QUARTER_4_sub_1,
      subpartition QUARTER_4_sub_2,
      subpartition QUARTER_4_sub_3,
      subpartition QUARTER_4_sub_4
    )
);

alter table FACT_SALES
   add constraint FK_FACT_SALE_REFERENCE_DIM_TIME foreign key (DATE_ID)
      references DIM_TIME (DATE_ID);

alter table FACT_SALES
   add constraint FK_FACT_SALE_REFERENCE_DIM_CUSTOMERS foreign key (CUSTOMER_ID)
      references DIM_CUSTOMERS (CUSTOMER_ID);

alter table FACT_SALES
   add constraint FK_FACT_SALE_REFERENCE_DIM_PROD foreign key (PRODUCT_ID)
      references DIM_PRODUCTS (PRODUCT_ID);

alter table FACT_SALES
   add constraint FK_FACT_SALE_REFERENCE_DIM_STORES foreign key (STORE_ID)
      references DIM_STORES (STORE_ID);
      
alter table FACT_SALES
   add constraint FK_FACT_SALE_REFERENCE_DIM_PAY_METH foreign key (PAYMENT_METHOD_ID)
      references DIM_PAYMENT_METHODS (PAYMENT_METHOD_ID);

alter table FACT_SALES
   add constraint FK_FACT_SALE_REFERENCE_DIM_EMP foreign key (EMPLOYEE_ID)
      references DIM_EMPLOYEES (EMPLOYEE_ID);