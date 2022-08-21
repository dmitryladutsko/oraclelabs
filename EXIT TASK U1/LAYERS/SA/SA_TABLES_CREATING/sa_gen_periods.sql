alter session set current_schema = SA_DATE;

create table SA_GEN_PERIODS (
   PERIOD_NAME          VARCHAR2(20),
   START_DT             DATE,
   END_DT               DATE,
   INSERT_DT            DATE,
   UPDATE_DT            DATE
);