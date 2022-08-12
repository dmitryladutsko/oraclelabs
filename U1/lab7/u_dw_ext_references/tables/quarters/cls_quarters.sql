ALTER SESSION SET current_schema=u_dw_ext_references;

--drop table cls_quarters;

CREATE TABLE cls_quarters(

DAYS_IN_CAL_QUARTER           NUMBER,
BEG_OF_CAL_QUARTER            DATE,
END_OF_CAL_QUARTER            DATE,
CALENDAR_QUARTER_NUMBER       VARCHAR2(1)
)
tablespace TS_REFERENCES_DATA_01;