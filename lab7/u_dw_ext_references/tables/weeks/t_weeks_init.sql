alter session set current_schema=u_dw_references;

INSERT INTO t_weeks (
     CALENDAR_WEEK_NUMBER, 
     WEEK_ENDING_DATE
 )
  SELECT CALENDAR_WEEK_NUMBER, 
     WEEK_ENDING_DATE FROM cls_weeks;

COMMIT;

select * from t_weeks;