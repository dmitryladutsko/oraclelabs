--------------------------PREREQUISITES-------------------------------
GRANT CREATE MATERIALIZED VIEW, CREATE TABLE, CREATE VIEW, QUERY REWRITE TO SA_CUSTOMERS;
--------------------------DAILY REPORT ON COMMIT----------------------

alter session set current_schema=SA_CUSTOMERS;  
drop MATERIALIZED VIEW mv_daily_report;

alter session set current_schema=SA_CUSTOMERS; 
CREATE MATERIALIZED VIEW mv_daily_report
    REFRESH ON COMMIT
AS                                         
            select CUSTOMER_SALE_DATE as date_num, sum(price) as Revenue
            from sa_transactions 
                where CUSTOMER_SALE_DATE = to_date ('14.04.20' ,'DD/MM/YY')
                
            group by CUSTOMER_SALE_DATE;

EXEC DBMS_MVIEW.REFRESH('mv_daily_report')

alter session set current_schema=SA_CUSTOMERS;

SELECT * FROM  mv_daily_report;


SELECT * FROM sa_transactions WHERE first_name_customer = 'Dmitry' and last_name_customer = 'Lee';

UPDATE sa_transactions SET price = 50000 WHERE first_name_customer = 'Dmitry' and last_name_customer = 'Lee';

COMMIT;
