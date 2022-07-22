alter session set current_schema=u_dw_references;

--DROP TABLE t_weeks;

CREATE TABLE t_weeks(
WEEK_ID                    NUMBER GENERATED BY DEFAULT ON NULL AS IDENTITY,
CALENDAR_WEEK_NUMBER          VARCHAR2(1)  ,
WEEK_ENDING_DATE              DATE,   
CONSTRAINT "PK_DW.T_WEEKS" PRIMARY KEY (week_id)
);
