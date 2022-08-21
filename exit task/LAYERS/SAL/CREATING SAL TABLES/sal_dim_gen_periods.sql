alter session set current_schema = DW_DATA;

create table DIM_GEN_PERIODS (
   PERIOD_ID            NUMBER(22,0)          not null,
   PERIOD_NAME          VARCHAR2(20),
   START_DT             DATE,
   END_DT               DATE,
   INSERT_DT            DATE,
   UPDATE_DT            DATE,
   constraint PK_DIM_GEN_PERIODS primary key (PERIOD_ID)
);