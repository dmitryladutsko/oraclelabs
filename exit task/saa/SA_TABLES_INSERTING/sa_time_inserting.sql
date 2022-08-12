alter session set current_schema=SA_DATE;
drop table SA_TIME;

alter session set current_schema=SA_DATE;
Create table sa_time (
date_id                       DATE,
beg_of_year               DATE         ,      
end_of_year               DATE         ,    
day_name                      VARCHAR2(44) ,
day_number_in_week            VARCHAR2(1)  ,
day_number_in_month           VARCHAR2(2)  ,
day_number_in_year            VARCHAR2(3)  ,
calendar_week_number          VARCHAR2(1)  ,
week_ending_date              DATE         ,
calendar_month_number         VARCHAR2(2)  ,
days_in_month             VARCHAR2(2)  ,
end_of_month              DATE         ,
end_of_quarter            VARCHAR2(32) ,
quarter_number            VARCHAR2(1)  , 
n_year                 VARCHAR2(4)  ,  
days_in_cal_year              NUMBER            
);


INSERT INTO sa_time ( 
        date_id                   ,
        beg_of_year           ,      
        end_of_year           ,    
        day_name                  ,
        day_number_in_week        ,
        day_number_in_month       ,
        day_number_in_year        ,
        calendar_week_number      ,
        week_ending_date          ,
        calendar_month_number     ,
        days_in_month         ,
        end_of_month          ,
        end_of_quarter        ,
        quarter_number   , 
        n_year             ,  
        days_in_cal_year                     
)
SELECT 
  TRUNC( sd + rn ) date_id,                 
  TRUNC( sd ) beg_of_year,           
  TO_CHAR( sd + 364 ) end_of_year,          
  TO_CHAR( sd + rn, 'fmDay' ) day_name,                
  TO_CHAR( sd + rn, 'D' ) day_number_in_week,                  
  TO_CHAR( sd + rn, 'DD' ) day_number_in_month,              
  TO_CHAR( sd + rn, 'DDD' ) day_number_in_year,                   
  TO_CHAR( sd + rn, 'W' ) calendar_week_number,                    
  ( CASE
      WHEN TO_CHAR( sd + rn, 'D' ) IN (  2, 3, 4, 5, 6, 7) THEN
        NEXT_DAY( sd + rn, 'Monday' )
      ELSE
        ( sd + rn )
    END ) week_ending_date,                   
  TO_CHAR( sd + rn, 'MM' ) calendar_month_number,                    
  TO_CHAR( LAST_DAY( sd + rn ), 'DD' ) days_in_month,                    
  LAST_DAY( sd + rn ) end_of_month,                   
  ( CASE
      WHEN TO_CHAR( sd + rn, 'Q' ) = 1 THEN
        TO_DATE( '06/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
      WHEN TO_CHAR( sd + rn, 'Q' ) = 2 THEN
        TO_DATE( '09/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
      WHEN TO_CHAR( sd + rn, 'Q' ) = 3 THEN
        TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
      WHEN TO_CHAR( sd + rn, 'Q' ) = 4 THEN
        TO_DATE( '03/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
    END ) end_of_quarter,                   
  ( CASE
      WHEN TO_CHAR( sd + rn, 'Q' ) = 1 THEN 1
      WHEN TO_CHAR( sd + rn, 'Q' ) = 2 THEN 2
      WHEN TO_CHAR( sd + rn, 'Q' ) = 3 THEN 3
      WHEN TO_CHAR( sd + rn, 'Q' ) = 4 THEN 4
    END ) quarter_number,                 
  TO_CHAR( sd + rn - 90, 'YYYY' ) year,                    
  ( TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
    - TRUNC( sd + rn, 'YEAR' ) ) days_in_cal_year                    
FROM
  ( 
    SELECT 
      TO_DATE( '01/01/2019', 'MM/DD/YYYY' ) sd,
      rownum rn
    FROM dual
      CONNECT BY level <= 3000
  );
  
  select * from sa_time;
  
  select * from calendar;