ALTER SESSION SET current_schema=u_dw_ext_references;

--drop table cls_years

create table cls_years
(
    DAYS_IN_CAL_YEAR NUMBER,     
    BEG_OF_CAL_YEAR DATE,      
    END_OF_CAL_YEAR DATE,
    CALENDAR_YEAR VARCHAR2(4)
)tablespace TS_REFERENCES_DATA_01;