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