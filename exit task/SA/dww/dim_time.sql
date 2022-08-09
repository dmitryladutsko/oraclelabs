alter session set current_schema = DW_DATA;

create table DIM_TIME (
TIME_ID                       DATE  ,       
DAY_NAME                      VARCHAR2(44) ,
DAY_NUMBER_IN_WEEK            VARCHAR2(1)  ,
DAY_NUMBER_IN_MONTH           VARCHAR2(2)  ,
DAY_NUMBER_IN_YEAR            VARCHAR2(3)  ,
CALENDAR_WEEK_NUMBER          VARCHAR2(1)  ,
WEEK_ENDING_DATE              DATE         ,
CALENDAR_MONTH_NUMBER         VARCHAR2(2)  ,
DAYS_IN_CAL_MONTH             VARCHAR2(2)  ,
END_OF_CAL_MONTH              DATE         ,
CALENDAR_MONTH_NAME           VARCHAR2(32) ,
DAYS_IN_CAL_QUARTER           NUMBER       ,
BEG_OF_CAL_QUARTER            DATE         ,
END_OF_CAL_QUARTER            DATE         ,
CALENDAR_QUARTER_NUMBER       VARCHAR2(1) , 
CALENDAR_YEAR                 VARCHAR2(4),  
DAYS_IN_CAL_YEAR              NUMBER  ,     
BEG_OF_CAL_YEAR               DATE   ,      
END_OF_CAL_YEAR               DATE  ,       
   constraint PK_DIM_TIME primary key (TIME_ID)
);
CREATE INDEX idx_dim_time ON dim_time(time_id DESC);

DROP INDEX idx_dim_time;