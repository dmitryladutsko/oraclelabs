alter session set current_schema = DW_CLEANSING;

create table CL_GEN_PERIODS (
   PERIOD_NAME          VARCHAR2(20),
   START_DT             DATE,
   END_DT               DATE,
   INSERT_DT            DATE,
   UPDATE_DT            DATE
);