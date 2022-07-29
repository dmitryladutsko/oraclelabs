alter session set current_schema = DW_DATA;

create table FACT_SALES (
   SALES_ID             NUMBER(22,0)          not null,
   TIME_ID              DATE,
   PERIOD_ID            NUMBER(22,0),
   CUSTOMER_ID          NUMBER(22,0),
   GEO_ID               NUMBER(22),
   BORROWER_ID          NUMBER(22),
   EMPLOYEE_ID          NUMBER(10),
   PAYMENT_METHOD_ID    NUMBER(10,0),
   STORE_ID             NUMBER(10),
   PRODUCT_ID           NUMBER(22,0),
   TOTAL_AMNT           numeric(8,2),
   MAD                  numeric(5,2),
   constraint PK_FACT_SALES primary key (SALES_ID)
)
    partition by range (TIME_ID) subpartition by hash (CUSTOMER_ID)
        SUBPARTITIONS 4 
        (partition sales_q1 values less than (to_date('2021-03-01', 'YYYY-MM-DD')),
         partition sales_q2 values less than (to_date('2021-06-01', 'YYYY-MM-DD')),
         partition sales_q3 values less than (to_date('2021-09-01', 'YYYY-MM-DD')),
         partition sales_q4 values less than (to_date('2021-12-31', 'YYYY-MM-DD'))
        );

/* Index: "Reference_1_FK"                                      */

ALTER TABLE FACT_SALES ADD employee_id NUMBER(10);
ALTER TABLE FACT_SALES ADD PAYMENT_METHOD_ID NUMBER(10,0);
ALTER TABLE FACT_SALES ADD STORE_ID NUMBER(10);
create index "Reference_1_FK" on FACT_SALES (
   TIME_ID ASC
);

/* Index: "Reference_2_FK"                                      */
create index "Reference_2_FK" on FACT_SALES (
   PERIOD_ID ASC
);

/* Index: "Reference_3_FK"                                      */
create index "Reference_3_FK" on FACT_SALES (
   CUSTOMER_ID ASC
);

/* Index: "Reference_4_FK"                                      */
create index "Reference_4_FK" on FACT_SALES (
   EMPLOYEE_ID ASC
);

/* Index: "Reference_5_FK"                                      */
create index "Reference_5_FK" on FACT_SALES (
   PAYMENT_METHOD_ID ASC
);

/* Index: "Reference_6_FK"                                      */
create index "Reference_6_FK" on FACT_SALES (
   GEO_ID ASC
);

/* Index: "Reference_7_FK"                                      */
create index "Reference_7_FK" on FACT_SALES (
   BORROWER_ID ASC
);

/* Index: "Reference_8_FK"                                      */
create index "Reference_8_FK" on FACT_SALES (
   PRODUCT_ID ASC
);

/* Index: "Reference_9_FK"                                      */
create index "Reference_9_FK" on FACT_SALES (
   STORE_ID ASC
);

alter table FACT_SALES
   add constraint FK_FACT_SALE_REFERENCE_DIM_TIME foreign key (TIME_ID)
      references DIM_TIME (TIME_ID);

alter table FACT_SALES
   add constraint FK_FACT_SALE_REFERENCE_DIM_PER foreign key (PERIOD_ID)
      references DIM_GEN_PERIODS (PERIOD_ID);

alter table FACT_SALES
   add constraint FK_FACT_SALE_REFERENCE_DIM_CUSTOMERS foreign key (CUSTOMER_ID)
      references DIM_CUSTOMERS (CUSTOMER_ID);


alter table FACT_SALES
   add constraint FK_FACT_SALE_REFERENCE_DIM_GEO foreign key (GEO_ID)
      references DIM_GEO_LOCATIONS (GEO_ID);

alter table FACT_SALES
   add constraint FK_FACT_SALE_REFERENCE_DIM_BORR foreign key (BORROWER_ID)
      references DIM_BORROWERS (BORROWER_ID);

alter table FACT_SALES
   add constraint FK_FACT_SALE_REFERENCE_DIM_PROD foreign key (PRODUCT_ID)
      references DIM_PRODUCTS (PRODUCT_ID);

alter table FACT_SALES
   add constraint FK_FACT_SALE_REFERENCE_DIM_STORES foreign key (STORE_ID)
      references DIM_STORE (STORE_ID);
      
alter table FACT_SALES
   add constraint FK_FACT_SALE_REFERENCE_DIM_PAY_METH foreign key (PAYMENT_METHOD_ID)
      references DIM_payment_method (PAYMENT_METHOD_ID);

alter table FACT_SALES
   add constraint FK_FACT_SALE_REFERENCE_DIM_EMP foreign key (EMPLOYEE_ID)
      references DIM_EMPLOYEE (EMPLOYEE_ID);

--grant select on DW_DATA to DLADUTKO;