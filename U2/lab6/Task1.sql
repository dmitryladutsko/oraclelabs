---------------------FIRST_VALUE------------------------------------------------
alter session set current_schema=DW_DATA;

SELECT DISTINCT position_name_actual, FIRST_VALUE(salary)
        OVER (PARTITION BY position_name_actual ORDER BY salary DESC
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
        AS hiest_salary
FROM dim_employees
WHERE position_name_actual LIKE '%manager'
ORDER BY position_name_actual;

---------------------LAST_VALUE------------------------------------------------
SELECT DISTINCT product_name, LAST_VALUE(price) 
        OVER (PARTITION BY product_name ORDER BY price DESC
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING)
        AS lowest_price_product
FROM dim_products
WHERE product_name IN('Iphone')
ORDER BY product_name;