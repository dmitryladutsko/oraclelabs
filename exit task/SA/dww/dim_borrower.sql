alter session set current_schema = DW_DATA;

create table DIM_BORROWERS (
   BORROWER_ID          NUMBER(22)            not null,
   COUNTRY              CHAR(20)              not null,
   REGION               CHAR(20),
   CITY                 CHAR(25),
   ADRESS               CHAR(50),
   PHONE                CHAR(20),
   constraint PK_DIM_BORROWERS primary key (BORROWER_ID)
);