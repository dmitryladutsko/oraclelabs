alter session set current_schema=u_dw_references;

INSERT INTO t_months ( 
     CALENDAR_MONTH_NUMBER,
     DAYS_IN_CAL_MONTH,
     END_OF_CAL_MONTH,
     CALENDAR_MONTH_NAME
 )
  SELECT CALENDAR_MONTH_NUMBER,
     DAYS_IN_CAL_MONTH,
     END_OF_CAL_MONTH,
     CALENDAR_MONTH_NAME FROM u_dw_ext_references.cls_months;
     
COMMIT;
