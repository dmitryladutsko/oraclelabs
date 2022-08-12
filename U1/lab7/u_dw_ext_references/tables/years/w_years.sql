create or replace view u_dw_references.w_years as
SELECT YEAR_ID,
      DAYS_IN_CAL_YEAR,     
    BEG_OF_CAL_YEAR,      
    END_OF_CAL_YEAR,
    CALENDAR_YEAR
  FROM t_years;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_years to u_dw_ext_references;
