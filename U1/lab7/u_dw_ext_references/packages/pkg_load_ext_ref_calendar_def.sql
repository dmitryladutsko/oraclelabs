alter session set current_schema=u_dw_ext_references;

CREATE OR REPLACE PACKAGE pkg_load_ext_ref_calendar

AS  
   PROCEDURE load_ref_calendar;

   PROCEDURE load_cls_days;
   
   PROCEDURE load_cls_weeks;
   
   PROCEDURE load_cls_months;
   
   PROCEDURE load_cls_quarters;
   
   PROCEDURE load_cls_years; 
END pkg_load_ext_ref_calendar;
/