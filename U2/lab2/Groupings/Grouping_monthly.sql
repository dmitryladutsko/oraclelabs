    alter session set current_schema=SA_CUSTOMERS;
    
-----------------------------------            
---------------        group by ROLLUP or GROUPING SETS     
                     
-----------------------------------            
---------------        GROUPING SETS            
            alter session set current_schema=SA_CUSTOMERS;                                         
            select product_name, adress_customer, to_char(CUSTOMER_SALE_DATE, 'month') as month, sum(price) as Revenue
            from sa_transactions 
                where CUSTOMER_SALE_DATE between to_date ('01.01.20' ,'DD/MM/YY') and to_date ('30.01.20' ,'DD/MM/YY') 
                group by grouping sets
                (
                (product_name, adress_customer,to_char(CUSTOMER_SALE_DATE, 'month')), 
                (product_name, adress_customer),
                (product_name)               
                );
                
-----------------------------------            
---------------        ROLLUP                

                alter session set current_schema=SA_CUSTOMERS;                                         
                select product_name, adress_customer, to_char(CUSTOMER_SALE_DATE, 'month') as month, sum(price) as Revenue
                from sa_transactions 
                    where CUSTOMER_SALE_DATE between to_date ('01.01.20' ,'DD/MM/YY') and to_date ('30.01.20' ,'DD/MM/YY') 
                    group by rollup
                    (product_name, adress_customer,to_char(CUSTOMER_SALE_DATE, 'month'));
-----------------------------------            
---------------      Sum Revenue  	DAY - MONTH - QUARTER - YEAR 

                alter session set current_schema=SA_CUSTOMERS;  
                select CUSTOMER_SALE_DATE, to_char(CUSTOMER_SALE_DATE, 'month') as month,
                quarter_number as quarter,
                to_char(CUSTOMER_SALE_DATE, 'YYYY') as year,
                sum(price) as Revenue               
                                 from sa_customers.sa_transactions tr left join
                                                    sa_date.sa_time t on tr.CUSTOMER_SALE_DATE = t.date_id
                
                 where CUSTOMER_SALE_DATE between to_date ('01.01.20' ,'DD/MM/YY') and to_date ('01.01.21' ,'DD/MM/YY') 
                    group by rollup
                    (CUSTOMER_SALE_DATE,to_char(CUSTOMER_SALE_DATE, 'month'),quarter_number, to_char(CUSTOMER_SALE_DATE, 'YYYY'))
                 order by quarter_number, month desc;
                
-----------------------------------            
---------------     Average Revenue   	DAY - MONTH - QUARTER - YEAR 

                alter session set current_schema=SA_CUSTOMERS;  
                select CUSTOMER_SALE_DATE, to_char(CUSTOMER_SALE_DATE, 'month') as month,
                quarter_number as quarter,
                to_char(CUSTOMER_SALE_DATE, 'YYYY') as year,
                round (avg(price), 2) as Revenue               
                                 from sa_customers.sa_transactions tr left join
                                                    sa_date.sa_time t on tr.CUSTOMER_SALE_DATE = t.date_id
                
                 where CUSTOMER_SALE_DATE between to_date ('01.01.20' ,'DD/MM/YY') and to_date ('01.01.21' ,'DD/MM/YY') 
                    group by rollup
                    (CUSTOMER_SALE_DATE,to_char(CUSTOMER_SALE_DATE, 'month'),quarter_number, to_char(CUSTOMER_SALE_DATE, 'YYYY'))
                 order by quarter_number, month desc;
                
                commit;