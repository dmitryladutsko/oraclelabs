alter session set current_schema=DW_DATA;
SELECT * FROM DIM_EMPLOYEES
---------------------------SUM----------------------------------
SELECT SUM(salary) AS TOTAL_SALARIES
FROM dim_employees
WHERE position_name_actual LIKE '%manager';
---------------------------AVG----------------------------------
SELECT POSITION_NAME_ACTUAL AS DEPARTMENT, trunc(AVG(salary)) AS AVERAGE_SALARY
FROM dim_employees
GROUP BY POSITION_NAME_ACTUAL;
---------------------------MIN----------------------------------
SELECT trunc(MIN(salary)) AS MINIMAL_SALARY
FROM dim_employees;

---------------------------MAX----------------------------------
SELECT trunc(MAX(salary)) AS min_salary_in_company
FROM dim_employees;