--------------------------PREREQUISITES-------------------------------
GRANT CREATE MATERIALIZED VIEW, CREATE TABLE, CREATE VIEW, QUERY REWRITE TO DW_CLEANSING;
--------------------------DAILY REPORT ON COMMIT----------------------

alter session set current_schema=DW_CLEANSING;
drop MATERIALIZED VIEW mv_monthly_model;

alter session set current_schema=DW_CLEANSING;

CREATE MATERIALIZED VIEW DW_CLEANSING.mv_monthly_model
BUILD IMMEDIATE
REFRESH COMPLETE START WITH (sysdate) NEXT (sysdate+3/1440)
    AS
        with tmp
    AS
    (
    select t.product_name,t.model_name, TRUNC(t.customer_sale_date,'mm') as month,
    TRUNC(t.customer_sale_date,'yyyy') as YEAR,sum(t.price) as sum_price
    
    from
    DW_CLEANSING.CL_TRANSACTIONS t
    GROUP BY  TRUNC(t.customer_sale_date,'yyyy'),TRUNC(t.customer_sale_date,'mm'),t.product_name,t.model_name
    )
        SELECT DISTINCT year, month, product_name, model_name, sum_price
    FROM 
    tmp
    model
    partition by (product_name, model_name)
    dimension by (year,month)
    measures(sum_price)
    rules (
               sum_price[FOR year IN (SELECT DISTINCT year FROM tmp), null]=SUM(sum_price)[cv(year), any]
                        )
    ORDER BY product_name, model_name, month;

SELECT * FROM DW_CLEANSING.mv_monthly_model where product_name = 'AirPods';

commit;

UPDATE DW_CLEANSING.CL_TRANSACTIONS
SET price = price - 500
WHERE PRODUCT_NAME = 'AirPods';

