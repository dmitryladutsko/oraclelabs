
alter session set current_schema = SAL_CL;
begin 
pkg_sal_time.LOAD_SAL_TIME;
pkg_sal_stores.LOAD_SAL_STORES;
pkg_sal_products.LOAD_SAL_PRODUCTS;
pkg_sal_customers.LOAD_SAL_CUSTOMERS;
pkg_sal_employees.LOAD_SAL_EMPLOYEES;
pkg_sal_payment_methods.LOAD_SAL_PAYMENT_METHODS; 
pkg_sal_fact_sales.LOAD_SAL_FACT_SALES;
end;


alter session set current_schema = SAL_CL;
select count(*) from sal_cl.sal_dim_time;
select count(*) from sal_cl.sal_dim_stores;
select count(*) from sal_cl.sal_dim_products;
select count(*) from sal_cl.sal_dim_employees;
select count(*) from sal_cl.sal_dim_customers;
select count(*) from sal_cl.sal_dim_payment_methods;
select count(*) from sal_fact_sales;

select table_name, owner
    from all_tables 
        where owner = 'SAL_CL';

alter session set current_schema = SAL_CL;
SELECT OWNER, OBJECT_NAME, OBJECT_TYPE
    FROM ALL_OBJECTS 
        WHERE OBJECT_TYPE IN ('FUNCTION','PROCEDURE','PACKAGE')     
            and owner in('SAL_CL');
        
        alter session set current_schema = SAL_CL;
        SELECT * FROM SAL_DIM_EMPLOYEES;