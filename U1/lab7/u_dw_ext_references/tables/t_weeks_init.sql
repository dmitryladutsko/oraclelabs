alter session set current_schema=u_dw_references;

INSERT INTO t_weeks (
     CALENDAR_WEEK_NUMBER, 
     WEEK_ENDING_DATE
 )
  SELECT CALENDAR_WEEK_NUMBER, 
     WEEK_ENDING_DATE FROM u_dw_ext_references.cls_weeks;

COMMIT;

select * from t_weeks;