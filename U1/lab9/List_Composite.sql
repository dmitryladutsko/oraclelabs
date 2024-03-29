alter session set current_schema = DW_DATA;

create table calendar03
(
   TIME_ID              DATE               not null,
   YEAR_CALENDAR        NUMBER(4),
   YEAR_DAYS_CNT        NUMBER(3),
   QUARTER_NUMBER       NUMBER(1),
   QUARTER_DAYS_CNT     NUMBER(3),
   QUARTER_BEGIN_DT     DATE,
   QUARTER_END_DT       DATE,
   MONTH_NUMBER         NUMBER(2),
   MONTH_NAME           VARCHAR(30),
   MONTH_DAYS_CNT       NUMBER(3),
   WEEK_NUMBER          NUMBER(2),
   WEEK_END_DT          DATE,
   DAY_NAME             VARCHAR(30),
   DAY_NUMBER_WEEK      NUMBER(1),
   DAY_NUMBER_MONTH     NUMBER(2),
   DAY_NUMBER_YEAR      NUMBER(3),
   constraint PK_DIM_TIME03 primary key (TIME_ID)
    )
    PARTITION BY LIST(MONTH_NAME)
    (
    PARTITION PART_1 VALUES ('January', 'February', 'March', 'April', 'May', 'June') tablespace lw_09_1,
    PARTITION PART_2 VALUES ('July', 'August', 'September', 'October', 'November', 'December') tablespace lw_09_2
    );


INSERT INTO calendar03
SELECT

    TRUNC( sd + rn ), -- time_id
    TO_CHAR( sd + rn, 'YYYY' ), -- year_calendar
    ( TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
    - TRUNC( sd + rn, 'YEAR' ) ) + 1, -- year days_cnt

    TO_CHAR( sd + rn, 'Q' ), --quarter_number
        ( ( CASE
          WHEN TO_CHAR( sd + rn, 'Q' ) = 1 THEN
            TO_DATE( '03/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          WHEN TO_CHAR( sd + rn, 'Q' ) = 2 THEN
            TO_DATE( '06/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          WHEN TO_CHAR( sd + rn, 'Q' ) = 3 THEN
            TO_DATE( '09/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          WHEN TO_CHAR( sd + rn, 'Q' ) = 4 THEN
            TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
        END ) - TRUNC( sd + rn, 'Q' ) + 1 ), --  quarter_days_cnt

    TRUNC( sd + rn, 'Q' ), -- quarter begin_dt

        ( CASE
          WHEN TO_CHAR( sd + rn, 'Q' ) = 1 THEN
            TO_DATE( '03/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          WHEN TO_CHAR( sd + rn, 'Q' ) = 2 THEN
            TO_DATE( '06/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          WHEN TO_CHAR( sd + rn, 'Q' ) = 3 THEN
            TO_DATE( '09/30/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
          WHEN TO_CHAR( sd + rn, 'Q' ) = 4 THEN
            TO_DATE( '12/31/' || TO_CHAR( sd + rn, 'YYYY' ), 'MM/DD/YYYY' )
        END ), -- quarter_end_dt


        TO_CHAR( sd + rn, 'MM' ), --month_number
        TO_CHAR( sd + rn, 'FMMonth' ), -- month_name
        TO_CHAR( LAST_DAY( sd + rn ), 'DD' ), -- month_days_cnt

        TO_CHAR( sd + rn, 'W' ), -- week_number
            ( CASE
                  WHEN TO_CHAR( sd + rn, 'D' ) IN ( 1, 2, 3, 4, 5, 6 ) THEN
                    NEXT_DAY( sd + rn, '�������' )
                  ELSE
                    ( sd + rn )
                END ), -- week_end_date

        TO_CHAR( sd + rn, 'fmDay' ), -- day_name
        TO_CHAR( sd + rn, 'D' ), -- day_number_week
        TO_CHAR( sd + rn, 'DD' ), -- day_number_month
        TO_CHAR( sd + rn, 'DDD' ) -- day_number_yearth

    FROM
  (
    SELECT
      TO_DATE( '12/31/2000', 'MM/DD/YYYY' ) sd,
      rownum rn
    FROM dual
      CONNECT BY level <= 6000
  );
  
alter table calendar03
    merge partitions part_1, part_2 into partition part_3
        tablespace lw_09;
        
alter table calendar03
    move partition part_3
        tablespace lw_09_1 nologging compress;
    
alter table calendar03
    split partition part_3 values ('January', 'May', 'December')
    into
    (
    partition part_1
        tablespace lw_09,
    partition part_2
        tablespace lw_09_2
            STORAGE(INITIAL 8M)
    )
    PARALLEL 5;

alter table calendar03
    truncate partition part_1;
    
alter table calendar03
    drop partition part_1;
    