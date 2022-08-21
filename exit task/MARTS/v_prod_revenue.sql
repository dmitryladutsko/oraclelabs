alter session set current_schema = sal_cl;   
            create or replace view v_prod_revenue as 
                 select fct.customer_id, p.product_name, c.adress_customer, 
                 to_char(c.CUSTOMER_SALE_DATE, 'month') as month, sum(p.price) as Revenue
                      from sal_cl.sal_fact_sales fct 
                      inner join sal_cl.sal_dim_products p
                                                    on (fct.product_id = p.product_id)
                            
                            left join sal_cl.sal_dim_customers c
                                                    on (fct.customer_id = c.customer_id)
                      
                where c.CUSTOMER_SALE_DATE between to_date ('01.01.20' ,'DD/MM/YY') and to_date ('30.01.20' ,'DD/MM/YY') 
                group by grouping sets
                (
                (fct.customer_id, p.product_name, c.adress_customer,to_char(c.CUSTOMER_SALE_DATE, 'month')),
                (p.product_name, c.adress_customer,to_char(c.CUSTOMER_SALE_DATE, 'month')), 
                (p.product_name, c.adress_customer),
                (p.product_name)               
                )
                    order by 1, 2, 3, 4;