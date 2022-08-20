
alter session set current_schema = sal_cl;
drop table sal_fact_sales;

alter session set current_schema = sal_cl;
create table SAL_FACT_SALES (
SALE_ID              NUMBER(22,0),
DATE_ID              DATE        ,
CUSTOMER_ID          NUMBER(22,0),
PRODUCT_ID           NUMBER(22,0),
PAYMENT_METHOD_ID    NUMBER(10,0),
STORE_ID             NUMBER(10,0),
EMPLOYEE_ID          NUMBER(10,0),
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

alter table SAL_FACT_SALES
   add constraint FK_FACT_SALE_REFERENCE_SAL_DIM_TIME foreign key (DATE_ID)
      references SAL_DIM_TIME (DATE_ID);

alter table SAL_FACT_SALES
   add constraint FK_FACT_SALE_REFERENCE_SAL_DIM_CUSTOMERS foreign key (CUSTOMER_ID)
      references SAL_DIM_CUSTOMERS (CUSTOMER_ID);

alter table SAL_FACT_SALES
   add constraint FK_FACT_SALE_REFERENCE_SAL_DIM_PROD foreign key (PRODUCT_ID)
      references SAL_DIM_PRODUCTS (PRODUCT_ID);

alter table SAL_FACT_SALES
   add constraint FK_FACT_SALE_REFERENCE_SAL_DIM_STORES foreign key (STORE_ID)
      references SAL_DIM_STORES (STORE_ID);
      
alter table SAL_FACT_SALES
   add constraint FK_FACT_SALE_REFERENCE_SAL_DIM_PAY_METH foreign key (PAYMENT_METHOD_ID)
      references SAL_DIM_PAYMENT_METHODS (PAYMENT_METHOD_ID);

alter table SAL_FACT_SALES
   add constraint FK_FACT_SALE_REFERENCE_SAL_DIM_EMP foreign key (EMPLOYEE_ID)
      references SAL_DIM_EMPLOYEES (EMPLOYEE_ID);