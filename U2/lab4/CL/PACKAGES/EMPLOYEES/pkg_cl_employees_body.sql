alter session set current_schema=SA_PRODUCTS;
GRANT SELECT ON SA_PRODUCTS.sa_employees TO DW_CLEANSING; 

alter session set current_schema=DW_CLEANSING;
CREATE OR REPLACE PACKAGE body pkg_cl_employees 
AS  
  PROCEDURE LOAD_CLEAN_EMPLOYEES
   AS   
      CURSOR curs_cl_employees
      IS
         SELECT DISTINCT 
                         employee_id              ,
                         first_name_EMPLOYEE      ,
                         last_name_EMPLOYEE       ,
                         email_EMPLOYEE           ,
                         phone_EMPLOYEE           ,
                         POSITION_NAME_ACTUAL     ,
                         POSITION_DEGREE          ,
                         SALES_TYPE               ,
                         HIRE_DATE                ,
                         salary                   ,
                         chief_id                 ,
                         position_name_previous   ,
                         position_change_date
           FROM SA_PRODUCTS.sa_employees
           WHERE employee_id IS NOT NULL 
           AND first_name_EMPLOYEE IS NOT NULL
           AND last_name_EMPLOYEE IS NOT NULL
           AND email_EMPLOYEE IS NOT NULL
           AND phone_EMPLOYEE IS NOT NULL
           AND POSITION_NAME_ACTUAL IS NOT NULL
           AND POSITION_DEGREE IS NOT NULL
           AND SALES_TYPE IS NOT NULL
           AND HIRE_DATE IS NOT NULL
           AND salary IS NOT NULL
           AND chief_id IS NOT NULL
           AND position_name_previous IS NOT NULL
           AND position_change_date IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE DW_CLEANSING.cl_employees';
      FOR i IN curs_cl_employees LOOP
         INSERT INTO DW_CLEANSING.cl_employees( 
                      employee_id              ,
                      first_name_EMPLOYEE      ,
                      last_name_EMPLOYEE       ,
                      email_EMPLOYEE           ,
                      phone_EMPLOYEE           ,
                      POSITION_NAME_ACTUAL     ,
                      POSITION_DEGREE          ,
                      SALES_TYPE               ,
                      HIRE_DATE                ,
                      salary                   ,
                      chief_id                 ,
                      position_name_previous   ,
                      position_change_date     )
              VALUES (    
                      i.employee_id              ,
                      i.first_name_EMPLOYEE      ,
                      i.last_name_EMPLOYEE       ,
                      i.email_EMPLOYEE           ,
                      i.phone_EMPLOYEE           ,
                      i.POSITION_NAME_ACTUAL     ,
                      i.POSITION_DEGREE          ,
                      i.SALES_TYPE               ,
                      i.HIRE_DATE                ,
                      i.salary                   ,
                      i.chief_id                 ,
                      i.position_name_previous   ,
                      i.position_change_date);

         EXIT WHEN curs_cl_employees%NOTFOUND;
      END LOOP;

      COMMIT;
   END LOAD_CLEAN_EMPLOYEES;
END pkg_cl_employees;

ALTER USER DW_CLEANSING quota unlimited on TS_DW_CLEANSING;
alter session set current_schema=DW_CLEANSING;
exec pkg_cl_employees.LOAD_CLEAN_EMPLOYEES;

alter session set current_schema=DW_CLEANSING;
select count(*) from cl_employees;

alter session set current_schema=SA_PRODUCTS;
select count(*) from SA_employees;

commit;