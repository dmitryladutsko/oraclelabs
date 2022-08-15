alter session set current_schema=SA_DATE;
GRANT SELECT ON SA_DATE.SA_TIME TO DW_CLEANSING; 

alter session set current_schema=DW_CLEANSING;
CREATE OR REPLACE PACKAGE body pkg_cl_time
AS  
  PROCEDURE LOAD_CLEAN_TIME
   AS   
      CURSOR curs_cl_time
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
           FROM SA_DATE.SA_TIME
           WHERE
               date_id               IS NOT NULL
               AND beg_of_year           IS NOT NULL      
               AND end_of_year           IS NOT NULL    
               AND day_name              IS NOT NULL
               AND day_number_in_week    IS NOT NULL
               AND day_number_in_month   IS NOT NULL
               AND day_number_in_year    IS NOT NULL
               AND calendar_week_number  IS NOT NULL
               AND week_ending_date      IS NOT NULL
               AND calendar_month_number IS NOT NULL
               AND days_in_month         IS NOT NULL
               AND end_of_month          IS NOT NULL
               AND end_of_quarter        IS NOT NULL
               AND quarter_number        IS NOT NULL
               AND n_year                IS NOT NULL  
               AND days_in_cal_year      IS NOT NULL;
                
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CLEANSING.cl_time';
      FOR i IN curs_cl_time LOOP
         INSERT INTO DW_CLEANSING.cl_time( 
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

         EXIT WHEN curs_cl_time%NOTFOUND;
      END LOOP;

      COMMIT;
   END LOAD_CLEAN_TIME;
END pkg_cl_time;


alter session set current_schema=DW_CLEANSING;
exec pkg_cl_time.LOAD_CLEAN_TIME;

alter session set current_schema=DW_CLEANSING;
select COUNT(*) from cl_time;

alter session set current_schema=SA_DATE;
select COUNT(*) from sa_time;

commit;
