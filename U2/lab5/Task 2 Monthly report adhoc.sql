alter session set current_schema=DW_CLEANSING;

with tmp
as 
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
    
    select count(*)
    from
    DW_CLEANSING.CL_TRANSACTIONS 