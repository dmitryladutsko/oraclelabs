alter session set current_schema = DW_DATA;
GRANT SELECT ON DW_CLEANSING.cl_employees  TO DW_DATA;

DROP SEQUENCE SEQ_EMPLOYEES;
CREATE SEQUENCE SEQ_EMPLOYEES
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

----------------------------MERGE----------------------------------
CREATE OR REPLACE PACKAGE body pkg_dw_employees_independent
AS  
  PROCEDURE LOAD_DW_EMPLOYEES
   AS
     BEGIN
     MERGE INTO DW_DATA.dim_employees A
     USING ( SELECT employee_id ,first_name_EMPLOYEE , last_name_EMPLOYEE, email_EMPLOYEE, phone_EMPLOYEE,POSITION_NAME_ACTUAL,
                    POSITION_DEGREE, SALES_TYPE , HIRE_DATE , salary, chief_id , position_name_previous, position_change_date
             FROM DW_CLEANSING.cl_employees) B
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
   
----------------------------------to_refcursor----------------------------------- 
   PROCEDURE LOAD_DW_EMPLOYEES_with_to_refcursor_func
   
    AS
     BEGIN 
     DECLARE 
       cursor_id NUMBER (25);
       cur_count NUMBER (38);
       query_cur VARCHAR2(2000);
       TYPE ref_crsr IS REF CURSOR;
       ref_cursor ref_crsr;
       TYPE type_rec IS RECORD
                       (    employee_id              NUMBER(5),
                            first_name_EMPLOYEE      VARCHAR2(40),
                            last_name_EMPLOYEE       VARCHAR2(40),
                            email_EMPLOYEE           VARCHAR2(40),
                            phone_EMPLOYEE           VARCHAR2(40),
                            POSITION_NAME_ACTUAL     VARCHAR2(40),
                            POSITION_DEGREE          VARCHAR2(40),
                            SALES_TYPE               VARCHAR2(40),
                            HIRE_DATE                DATE,
                            salary                   int,
                            chief_id                 int,
                            position_name_previous   VARCHAR2(40),
                            position_change_date     DATE);
                            
       one_record type_rec;
       
        BEGIN 
     query_cur:= 'SELECT employee_id ,first_name_EMPLOYEE , last_name_EMPLOYEE, email_EMPLOYEE, phone_EMPLOYEE,POSITION_NAME_ACTUAL,
                    POSITION_DEGREE, SALES_TYPE , HIRE_DATE , salary, chief_id , position_name_previous, position_change_date
                    
                    FROM
                        
                        (SELECT stage.employee_id ,stage.first_name_EMPLOYEE , stage.last_name_EMPLOYEE, stage.email_EMPLOYEE,
                        stage.phone_EMPLOYEE, stage.POSITION_NAME_ACTUAL,  stage.POSITION_DEGREE, stage.SALES_TYPE ,
                        stage.HIRE_DATE , stage.salary, stage.chief_id , stage.position_name_previous, stage.position_change_date
                                
                                FROM DW_CLEANSING.cl_employees source
                  LEFT JOIN dw_data.dim_employees stage
                  ON (source.employee_id=stage.employee_id))';
                  
                  
      cursor_id:=DBMS_SQL.open_cursor;
      
      DBMS_SQL.PARSE(cursor_id, query_cur, DBMS_SQL.NATIVE);
      
      cur_count:= DBMS_SQL.EXECUTE(cursor_id);
      
      ref_cursor:= DBMS_SQL.TO_REFCURSOR(cursor_id);
      
        LOOP
      FETCH ref_cursor INTO one_record;
      EXIT WHEN ref_cursor%NOTFOUND;
      IF (one_record.employee_id IS NULL) THEN
                INSERT INTO dw_data.dim_employees (employee_id ,first_name_EMPLOYEE , last_name_EMPLOYEE, email_EMPLOYEE,
                phone_EMPLOYEE,POSITION_NAME_ACTUAL, POSITION_DEGREE, SALES_TYPE , HIRE_DATE , salary,
                chief_id , position_name_previous, position_change_date)
                VALUES (SEQ_EMPLOYEES.NEXTVAL,
                one_record.first_name_EMPLOYEE , one_record.last_name_EMPLOYEE, one_record.email_EMPLOYEE,
                one_record.phone_EMPLOYEE, one_record.POSITION_NAME_ACTUAL, one_record.POSITION_DEGREE, one_record.SALES_TYPE ,
                one_record.HIRE_DATE , one_record.salary, one_record.chief_id , one_record.position_name_previous, 
                one_record.position_change_date); 
      END IF;
      END LOOP;
    COMMIT;
    END;
   END LOAD_DW_EMPLOYEES_with_to_refcursor_func;
       
--------------------------------to_cursor_number-------------------------------
       
           PROCEDURE LOAD_DW_EMPLOYEES_with_to_cursor_number_func
               AS
              BEGIN 
            DECLARE
              l_rc_var1 SYS_REFCURSOR;
              l_n_cursor_id    NUMBER;
              l_n_rowcount     NUMBER;
              l_n_column_count NUMBER;
              
              
                            l_vc_employee_id              NUMBER(5);
                            l_vc_first_name_EMPLOYEE      VARCHAR2(40);
                            l_vc_last_name_EMPLOYEE       VARCHAR2(40);
                            l_vc_email_EMPLOYEE           VARCHAR2(40);
                            l_vc_phone_EMPLOYEE           VARCHAR2(40);
                            l_vc_POSITION_NAME_ACTUAL     VARCHAR2(40);
                            l_vc_POSITION_DEGREE          VARCHAR2(40);
                            l_vc_SALES_TYPE               VARCHAR2(40);
                            l_vc_HIRE_DATE                DATE;
                            l_vc_salary                   int;
                            l_vc_chief_id                 int;
                            l_vc_position_name_previous   VARCHAR2(40);
                            l_vc_position_change_date     DATE;              
              
              l_ntt_desc_tab dbms_sql.desc_tab;
              
            BEGIN
              OPEN l_rc_var1 FOR             
              'SELECT employee_id ,first_name_EMPLOYEE , last_name_EMPLOYEE, email_EMPLOYEE,
                        phone_EMPLOYEE, POSITION_NAME_ACTUAL,  POSITION_DEGREE, SALES_TYPE ,
                        HIRE_DATE , salary, chief_id , position_name_previous, position_change_date
                        
               FROM DW_CLEANSING.cl_employees';
               
              l_n_cursor_id:= DBMS_SQL.to_cursor_number(l_rc_var1);
              dbms_sql.describe_columns(l_n_cursor_id,l_n_column_count,l_ntt_desc_tab);
              FOR loop_col IN 1..l_n_column_count
              LOOP
                dbms_sql.define_column(l_n_cursor_id,loop_col,
                CASE l_ntt_desc_tab(loop_col).col_name
                  WHEN 'employee_id' THEN
                  l_vc_employee_id
               
                        WHEN 'first_name_EMPLOYEE' THEN
                  l_vc_first_name_EMPLOYEE
               
                WHEN 'last_name_EMPLOYEE' THEN
                  l_vc_last_name_EMPLOYEE
               
                        WHEN 'email_EMPLOYEE' THEN
                  l_vc_email_EMPLOYEE
               
                WHEN 'phone_EMPLOYEE' THEN
                  l_vc_phone_EMPLOYEE
               
                        WHEN 'POSITION_NAME_ACTUAL' THEN
                  l_vc_POSITION_NAME_ACTUAL
               
                WHEN 'POSITION_DEGREE' THEN
                  l_vc_POSITION_DEGREE
               
                        WHEN 'SALES_TYPE' THEN
                  l_vc_SALES_TYPE
               
                WHEN 'HIRE_DATE' THEN
                  l_vc_HIRE_DATE
               
                        WHEN 'salary' THEN
                  l_vc_salary
               
                WHEN 'chief_id' THEN
                  l_vc_chief_id
               
                        WHEN 'position_name_previous' THEN
                  l_vc_position_name_previous
               
                WHEN 'position_change_date' THEN
                  l_vc_position_change_date
                  
                END, 50);
                
              END LOOP loop_col;
              LOOP
                l_n_rowcount:=dbms_sql.fetch_rows(l_n_cursor_id);
                EXIT
              WHEN l_n_rowcount=0;
                FOR loop_col IN 1..l_n_column_count
                LOOP
                    CASE l_ntt_desc_tab(loop_col).col_name
        
                          WHEN 'employee_id' THEN
                            dbms_sql.column_value(l_n_cursor_id,loop_col,l_vc_employee_id);
                          
                          WHEN 'first_name_EMPLOYEE' THEN
                            dbms_sql.column_value(l_n_cursor_id,loop_col,l_vc_first_name_EMPLOYEE);
                          
                          WHEN 'last_name_EMPLOYEE' THEN
                            dbms_sql.column_value(l_n_cursor_id,loop_col,l_vc_last_name_EMPLOYEE);
                        
                          WHEN 'email_EMPLOYEE' THEN
                            dbms_sql.column_value(l_n_cursor_id,loop_col,l_vc_email_EMPLOYEE);
                          
                          WHEN 'phone_EMPLOYEE' THEN
                            dbms_sql.column_value(l_n_cursor_id,loop_col,l_vc_phone_EMPLOYEE);
                          
                          WHEN 'POSITION_NAME_ACTUAL' THEN
                            dbms_sql.column_value(l_n_cursor_id,loop_col,l_vc_POSITION_NAME_ACTUAL);
        
                          WHEN 'POSITION_DEGREE' THEN
                            dbms_sql.column_value(l_n_cursor_id,loop_col,l_vc_POSITION_DEGREE);
                          
                          WHEN 'SALES_TYPE' THEN
                            dbms_sql.column_value(l_n_cursor_id,loop_col,l_vc_SALES_TYPE);
                          
                          WHEN 'HIRE_DATE' THEN
                            dbms_sql.column_value(l_n_cursor_id,loop_col,l_vc_HIRE_DATE);
                          
                          WHEN 'salary' THEN
                            dbms_sql.column_value(l_n_cursor_id,loop_col,l_vc_salary);
                          
                          WHEN 'chief_id' THEN
                            dbms_sql.column_value(l_n_cursor_id,loop_col,l_vc_chief_id);
        
                          WHEN 'position_name_previous' THEN
                            dbms_sql.column_value(l_n_cursor_id,loop_col,l_vc_position_name_previous);
                          
                          WHEN 'position_change_date' THEN
                            dbms_sql.column_value(l_n_cursor_id,loop_col,l_vc_position_change_date);
                          END CASE;
                END LOOP loop_col;
                IF(l_vc_employee_id IS NOT NULL) THEN
                INSERT INTO dw_data.dim_employees(employee_id ,
                                                    first_name_EMPLOYEE ,
                                                     last_name_EMPLOYEE,
                                                      email_EMPLOYEE,
                                                       phone_EMPLOYEE, 
                                                       POSITION_NAME_ACTUAL,
                                                         POSITION_DEGREE,
                                                          SALES_TYPE ,
                                                          HIRE_DATE ,
                                                          salary,
                                                           chief_id ,
                                                            position_name_previous,
                                                             position_change_date)
               
                VALUES (    l_vc_employee_id           ,
                            l_vc_first_name_EMPLOYEE      ,
                            l_vc_last_name_EMPLOYEE       ,
                            l_vc_email_EMPLOYEE           ,
                            l_vc_phone_EMPLOYEE           ,
                            l_vc_POSITION_NAME_ACTUAL     ,
                            l_vc_POSITION_DEGREE          ,
                            l_vc_SALES_TYPE               ,
                            l_vc_HIRE_DATE        ,
                            l_vc_salary          ,
                            l_vc_chief_id        ,
                            l_vc_position_name_previous   ,
                            l_vc_position_change_date); 
        END IF;
      END LOOP;
    COMMIT;
    END;

   END LOAD_DW_EMPLOYEES_with_to_cursor_number_func;
      
END pkg_dw_employees_independent;










TRUNCATE TABLE dim_employees

exec pkg_dw_employees_independent.LOAD_DW_EMPLOYEES; 

TRUNCATE TABLE dim_employees

exec pkg_dw_employees_independent.LOAD_DW_EMPLOYEES_with_to_refcursor_func;

TRUNCATE TABLE dim_employees

exec pkg_dw_employees_independent.LOAD_DW_EMPLOYEES_with_to_cursor_number_func;
SELECT * FROM dim_employees