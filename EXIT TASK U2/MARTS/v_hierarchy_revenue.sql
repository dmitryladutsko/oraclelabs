alter session set current_schema = sal_cl;       
        create or replace view v_revenue as
            select c.CUSTOMER_SALE_DATE, to_char(c.CUSTOMER_SALE_DATE, 'month') as month,
                t.quarter_number as quarter,
                to_char(c.CUSTOMER_SALE_DATE, 'YYYY') as year,
                sum(p.price) as Revenue               
                                from sal_cl.sal_fact_sales fct
                                   
                                    inner join sal_cl.sal_dim_products p
                                                                        on (fct.product_id = p.product_id)
                                        left join sal_cl.sal_dim_time t
                                                                        on (fct.date_id = t.date_id)
                                             left join sal_cl.sal_dim_customers c
                                                                        on (fct.customer_id = c.customer_id)
                 where c.CUSTOMER_SALE_DATE between to_date ('01.01.20' ,'DD/MM/YY') and to_date ('01.01.21' ,'DD/MM/YY') 
                    group by rollup
                    (c.CUSTOMER_SALE_DATE,to_char(c.CUSTOMER_SALE_DATE, 'month'),
                    t.quarter_number, to_char(c.CUSTOMER_SALE_DATE, 'YYYY'))
                 order by t.quarter_number, to_char(c.CUSTOMER_SALE_DATE, 'month') desc;
  