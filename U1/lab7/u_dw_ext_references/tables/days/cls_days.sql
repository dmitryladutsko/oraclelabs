alter session set current_schema=u_dw_ext_references;


create table cls_days(       
DAY_NAME                      VARCHAR2(44) ,
DAY_NUMBER_IN_WEEK            VARCHAR2(1)  ,
DAY_NUMBER_IN_MONTH           VARCHAR2(2)  ,
DAY_NUMBER_IN_YEAR            VARCHAR2(3)  )tablespace TS_REFERENCES_DATA_01;

drop table cls_days;
drop table cls_months;
drop table cls_weeks;
drop table cls_quarters;
drop table cls_years;
select * from cls_days