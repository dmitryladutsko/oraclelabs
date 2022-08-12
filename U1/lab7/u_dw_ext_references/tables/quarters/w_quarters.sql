create or replace view u_dw_references.w_quarters as
SELECT QUARTER_ID,
     DAYS_IN_CAL_QUARTER,
    BEG_OF_CAL_QUARTER,
    END_OF_CAL_QUARTER,
    CALENDAR_QUARTER_NUMBER
  FROM t_quarters;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_quarters to u_dw_ext_references;
