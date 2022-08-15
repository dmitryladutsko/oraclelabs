alter session set current_schema=DW_DATA;
SELECT * FROM dim_employees;
---------------------RANK------------------------------------------------

select FIRST_NAME_EMPLOYEE, 
       salary,
       RANK() OVER (PARTITION BY POSITION_NAME_ACTUAL ORDER BY salary) SALARY_RANK
  from dim_employees
 where POSITION_NAME_ACTUAL = 'Manager';

---------------------DENSE_RANK------------------------------------------------

select FIRST_NAME_EMPLOYEE, 
       salary,
       DENSE_RANK() OVER (PARTITION BY POSITION_NAME_ACTUAL ORDER BY salary) SALARY_RANK
  from dim_employees
 where POSITION_NAME_ACTUAL = 'Manager';
