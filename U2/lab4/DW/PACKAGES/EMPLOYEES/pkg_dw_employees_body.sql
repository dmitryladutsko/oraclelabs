alter session set current_schema=DW_DATA;
SELECT * FROM DIM_EMPLOYEES;

alter session set current_schema=DW_CLEANSING;
SELECT * FROM CL_EMPLOYEES;

GRANT SELECT ON DW_CLEANSING.cl_employees TO DW_DATA;

alter session set current_schema=DW_DATA;

CREATE OR REPLACE PACKAGE body pkg_dw_employees
AS  
  PROCEDURE LOAD_DW_EMPLOYEES
   AS
     BEGIN
     MERGE INTO DW_DATA.dim_employees a
     USING ( SELECT employee_id ,first_name_EMPLOYEE , last_name_EMPLOYEE, email_EMPLOYEE, phone_EMPLOYEE,POSITION_NAME_ACTUAL,
                    POSITION_DEGREE, SALES_TYPE , HIRE_DATE , salary, chief_id , position_name_previous, position_change_date
             FROM DW_CLEANSING.cl_employees) b
             ON (a.employee_id = b.employee_id)
             WHEN MATCHED THEN 
                UPDATE SET a.salary = b.salary
             WHEN NOT MATCHED THEN 
                INSERT (a.employee_id ,a.first_name_EMPLOYEE , a.last_name_EMPLOYEE, a.email_EMPLOYEE, a.phone_EMPLOYEE,a.POSITION_NAME_ACTUAL,
                    a.POSITION_DEGREE, a.SALES_TYPE , a.HIRE_DATE , a.salary, a.chief_id , a.position_name_previous, a.position_change_date)
                VALUES (b.employee_id ,b.first_name_EMPLOYEE , b.last_name_EMPLOYEE, b.email_EMPLOYEE, b.phone_EMPLOYEE,b.POSITION_NAME_ACTUAL,
                    b.POSITION_DEGREE, b.SALES_TYPE , b.HIRE_DATE , b.salary, b.chief_id , b.position_name_previous, b.position_change_date);
     COMMIT;
   END LOAD_DW_EMPLOYEES;
END pkg_dw_employees;


alter session set current_schema=DW_DATA;
exec pkg_dw_employees.LOAD_DW_EMPLOYEES;

select * from dim_employees;

commit;