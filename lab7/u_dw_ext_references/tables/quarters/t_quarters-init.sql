alter session set current_schema=u_dw_references;

INSERT INTO t_quarters ( 
    DAYS_IN_CAL_QUARTER,
    BEG_OF_CAL_QUARTER,
    END_OF_CAL_QUARTER,
    CALENDAR_QUARTER_NUMBER
 )
  SELECT DAYS_IN_CAL_QUARTER,
    BEG_OF_CAL_QUARTER,
    END_OF_CAL_QUARTER,
    CALENDAR_QUARTER_NUMBER FROM u_dw_ext_references.cls_quarters;
     
COMMIT;