alter session set current_schema=u_dw_references;

INSERT INTO t_years ( 
    DAYS_IN_CAL_YEAR,     
    BEG_OF_CAL_YEAR,      
    END_OF_CAL_YEAR,
    CALENDAR_YEAR
 )
  SELECT DAYS_IN_CAL_YEAR,     
    BEG_OF_CAL_YEAR,      
    END_OF_CAL_YEAR,
    CALENDAR_YEAR FROM u_dw_ext_references.cls_years;
     
COMMIT;

alter session set current_schema=u_dw_references;
SELECT * FROM t_days;

alter session set current_schema=u_dw_references;
SELECT * FROM t_weeks;

alter session set current_schema=u_dw_references;
SELECT * FROM t_months;

alter session set current_schema=u_dw_references;
SELECT * FROM t_quarters;

alter session set current_schema=u_dw_references;
SELECT * FROM t_years;

















