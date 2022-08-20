alter session set current_schema=sal_cl;
GRANT SELECT ON dw_data.dim_time TO sal_cl; 

alter session set current_schema=sal_cl;
CREATE OR REPLACE PACKAGE body pkg_sal_time
AS  
  PROCEDURE LOAD_SAL_TIME
   AS   
      CURSOR curs_sal_time
      IS
         SELECT DISTINCT
                date_id               ,
                beg_of_year           ,      
                end_of_year           ,    
                day_name              ,
                day_number_in_week    ,
                day_number_in_month   ,
                day_number_in_year    ,
                calendar_week_number  ,
                week_ending_date      ,
                calendar_month_number ,
                days_in_month         ,
                end_of_month          ,
                end_of_quarter        ,
                quarter_number        , 
                n_year                ,  
                days_in_cal_year     
           FROM DW_DATA.DIM_TIME;
                
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE sal_cl.sal_dim_time';
      FOR i IN curs_sal_time LOOP
         INSERT INTO sal_cl.sal_dim_time( 
                date_id               ,
                beg_of_year           ,      
                end_of_year           ,    
                day_name              ,
                day_number_in_week    ,
                day_number_in_month   ,
                day_number_in_year    ,
                calendar_week_number  ,
                week_ending_date      ,
                calendar_month_number ,
                days_in_month         ,
                end_of_month          ,
                end_of_quarter        ,
                quarter_number        , 
                n_year                ,  
                days_in_cal_year      )
                    VALUES ( 
                I.date_id               ,
                I.beg_of_year           ,      
                I.end_of_year           ,    
                I.day_name              ,
                I.day_number_in_week    ,
                I.day_number_in_month   ,
                I.day_number_in_year    ,
                I.calendar_week_number  ,
                I.week_ending_date      ,
                I.calendar_month_number ,
                I.days_in_month         ,
                I.end_of_month          ,
                I.end_of_quarter        ,
                I.quarter_number        , 
                I.n_year                ,  
                I.days_in_cal_year      );

         EXIT WHEN curs_sal_time%NOTFOUND;
      END LOOP;

      COMMIT;
   END LOAD_SAL_TIME;
END pkg_sal_time;


alter session set current_schema=sal_cl;
exec pkg_sal_time.LOAD_SAL_TIME;

alter session set current_schema=DW_DATA;
select COUNT(*) from dim_time;

alter session set current_schema=SAL_CL;
select COUNT(*) from sal_dim_time;

commit;
