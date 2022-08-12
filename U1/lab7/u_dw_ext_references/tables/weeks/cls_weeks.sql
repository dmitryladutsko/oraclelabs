alter session set current_schema=u_dw_ext_references;

--drop table cls_weeks;

CREATE TABLE cls_weeks (
CALENDAR_WEEK_NUMBER          VARCHAR2(1)  ,
WEEK_ENDING_DATE              DATE        
) tablespace TS_REFERENCES_DATA_01;