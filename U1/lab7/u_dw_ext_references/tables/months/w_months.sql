--drop view u_dw_references.w_months;

--==============================================================
-- View: w_months                                            
--==============================================================

create or replace view u_dw_references.w_months as
SELECT month_id
     , calendar_month_number
     , days_in_cal_month
     , end_of_cal_month
     , calendar_month_name
  FROM t_months;

comment on column u_dw_references.w_months.month_id is
'Identifier of the Month';

comment on column u_dw_references.w_months.days_in_cal_month is
'Number of days in month';

comment on column u_dw_references.w_months.end_of_cal_month is
'Last day of month';

comment on column u_dw_references.w_months.calendar_month_name is
'Month name';



grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_months to u_dw_ext_references;
