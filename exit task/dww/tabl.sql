--SA_DATE ts_sa_date

--EMPLOYEES
alter session set current_schema = SA_DATE;
ALTER USER SA_DATE quota unlimited on TS_SA_DATE;

DROP TABLE SA_EMPLOYEE_DATA;

create table SA_EMPLOYEE_DATA
(
   EMPLOYEE_ID INT,
   EMP_NAME VARCHAR (20),
   SALARY INT,
   SD DATE
) tablespace ts_sa_date
;

insert into SA_EMPLOYEE_DATA(EMPLOYEE_ID, EMP_NAME, SALARY, SD)
select rownum, 'Employee ' || to_char(rownum), dbms_random.value(2, 9) * 1000, TO_DATE('12/31/2021', 'MM/DD/YYYY')
from dual
connect by level <= 50000;

/*SELECT * FROM SA_EMPLOYEE_DATA;

alter session set current_schema = SA_DATE;
TRUNCATE TABLE SA_EMPLOYEE_DATA;*/


-- PERIODS
ALTER SESSION SET CURRENT_SCHEMA = SA_DATE;
DROP TABLE SA_PERIODS_DATA;

CREATE TABLE SA_PERIODS_DATA
(
   START_DT DATE, 
   END_DT DATE, 
   INSERT_DT DATE
)tablespace ts_sa_date;

insert into SA_PERIODS_DATA (START_DT, END_DT, INSERT_DT)
select
    stdate + 30 + rn,
    stdate + 60 + rn,
    to_date(to_char(sysdate, 'YYYY-MM-DD'), 'YYYY-MM-DD')

FROM
(select to_date('2015-07-13', 'YYYY-MM-DD') stdate,
        ROWNUM rn
from dual
connect by level <= 50000);
commit;


-- PRODUCTS
DROP table SA_PRODUCTS_DATA;

create table SA_PRODUCTS_DATA
(
   SD DATE,
   RN INT,
   ID_COLOR INT,
   ID_PRODUCT INT,
   C VARCHAR(10)
) tablespace ts_sa_date
;
INSERT INTO sa_products_data 
select g.*, C.C from 
    (
Select a.*, TRUNC(DBMS_RANDOM.VALUE( 1,10)) as ID_COLOR , TRUNC(DBMS_RANDOM.VALUE( 1,100)) as ID_PRODUCT  
FROM
         (
        SELECT
            TO_DATE('12/31/2021', 'MM/DD/YYYY')      sd
          , ROWNUM                                   rn
        FROM
            dual
        CONNECT BY
            level <= 400000
         ) a
    ) g
LEFT OUTER JOIN 
    ( select 1 as ID , 'RED' as C from dual union all 
    select 2, 'BLUE' 
    from dual) C
on g.ID_COLOR = c.ID 
COMMIT;
--VIEWS MB