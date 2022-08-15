--------------------------PREREQUISITES-------------------------------
GRANT CREATE MATERIALIZED VIEW, CREATE TABLE, CREATE VIEW, QUERY REWRITE TO SA_CUSTOMERS;
--------------------------MONTHLY REPORT ON DEMAND--------------------
alter session set current_schema=SA_CUSTOMERS;  
drop MATERIALIZED VIEW mv_mounth_report;

alter session set current_schema=SA_CUSTOMERS;  
CREATE MATERIALIZED VIEW mv_mounth_report
BUILD DEFERRED
REFRESH COMPLETE ON DEMAND
AS SELECT product_name, adress_customer, to_char(CUSTOMER_SALE_DATE, 'month') as month, sum(price) as Revenue
            from sa_transactions 
                where CUSTOMER_SALE_DATE between to_date ('01.01.20' ,'DD/MM/YY') and to_date ('30.01.20' ,'DD/MM/YY') 
                group by grouping sets
                (
                (product_name, adress_customer,to_char(CUSTOMER_SALE_DATE, 'month')), 
                (product_name, adress_customer),
                (product_name)               
                );

EXEC DBMS_MVIEW.REFRESH('mv_mounth_report')

SELECT * FROM  mv_mounth_report;