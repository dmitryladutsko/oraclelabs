    alter session set current_schema=SA_CUSTOMERS;
    
            select count (*),sum(price) as total_revenue, FIRST_NAME_CUSTOMER as CUSTOMER
            from sa_transactions 
                where CUSTOMER_SALE_DATE 
                                            between to_date('01.04.20', 'DD/MM/YY') AND to_date('30.04.20', 'DD/MM/YY')
                                            group by FIRST_NAME_CUSTOMER
                                            ORDER BY TOTAL_REVENUE DESC;
                                            
                                            
                                            
            alter session set current_schema=SA_CUSTOMERS;                                         
            select CUSTOMER_SALE_DATE as date_num, sum(price) as Revenue
            from sa_transactions 
                where CUSTOMER_SALE_DATE = to_date ('14.04.20' ,'DD/MM/YY')
                
            group by CUSTOMER_SALE_DATE;
            
-----------------------------------            
---------------        group by cube    
            
            alter session set current_schema=SA_CUSTOMERS;                                         
            select CUSTOMER_SALE_DATE as date_num, sum(price) as Revenue, FIRST_NAME_CUSTOMER AS  customer
            from sa_transactions 
                where CUSTOMER_SALE_DATE = to_date ('14.04.20' ,'DD/MM/YY')
                
            group by cube (CUSTOMER_SALE_DATE, FIRST_NAME_CUSTOMER);
                
-----------------------------------            
---------------        grouping ()

            alter session set current_schema=SA_CUSTOMERS;                                         
            select CUSTOMER_SALE_DATE as date_num, count (rownum) as toal_amount, 
            grouping (CUSTOMER_SALE_DATE) as Grouping
            from sa_transactions 
            where CUSTOMER_SALE_DATE between to_date ('01.04.20' ,'DD/MM/YY') and to_date ('01.05.20' ,'DD/MM/YY') 
                                group by cube (CUSTOMER_SALE_DATE)
                                order by count (rownum);

-----------------------------------            
---------------        grouping_id
            
            alter session set current_schema=SA_CUSTOMERS;                                         
            select CUSTOMER_SALE_DATE as date_num, count (rownum) as toal_amount, product_name as product, model_name as MODELn,
            grouping_id (CUSTOMER_SALE_DATE) as Groupin
            from sa_transactions 
            where CUSTOMER_SALE_DATE between to_date ('01.04.20' ,'DD/MM/YY') and to_date ('01.05.20' ,'DD/MM/YY')
                                group by cube ( product_name, CUSTOMER_SALE_DATE, model_name)
                                order by count (rownum);                          
                
                
            commit;
                                        
                