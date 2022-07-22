alter session set current_schema=u_dw_ext_references;

Create table cls_months (
CALENDAR_MONTH_NUMBER         VARCHAR2(2)  ,
DAYS_IN_CAL_MONTH             VARCHAR2(2)  ,
END_OF_CAL_MONTH              DATE         ,
CALENDAR_MONTH_NAME           VARCHAR2(32)   
)
tablespace TS_REFERENCES_DATA_01;

--select * from cls_months;