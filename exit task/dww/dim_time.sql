alter session set current_schema = DW_DATA;
create table DIM_TIME (
    date_id                       DATE         ,
    beg_of_year                   DATE         ,      
    end_of_year                   DATE         ,    
    day_name                      VARCHAR2(44) ,
    day_number_in_week            VARCHAR2(1)  ,
    day_number_in_month           VARCHAR2(2)  ,
    day_number_in_year            VARCHAR2(3)  ,
    calendar_week_number          VARCHAR2(1)  ,
    week_ending_date              DATE         ,
    calendar_month_number         VARCHAR2(2)  ,
    days_in_month                 VARCHAR2(2)  ,
    end_of_month                  DATE         ,
    end_of_quarter                VARCHAR2(32) ,
    quarter_number                VARCHAR2(1)  , 
    n_year                        VARCHAR2(4)  ,  
    days_in_cal_year              NUMBER       ,
   constraint PK_DIM_TIME primary key (date_id)
);
CREATE INDEX idx_dim_time ON dim_time(date_id DESC);

DROP INDEX idx_dim_time;