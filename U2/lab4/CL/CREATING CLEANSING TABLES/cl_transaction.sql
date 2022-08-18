alter session set current_schema=DW_CLEANSING;
drop table cl_transactions;

alter session set current_schema=DW_CLEANSING;
create table cl_transactions(
   PRODUCT_NAME                  VARCHAR2(30),
   MODEL_NAME                    VARCHAR2(20),
   MEMORY_AMOUNT                 NUMBER(22,0),
   COLOR_NAME                    VARCHAR2(25),
   PRICE                         NUMBER(10),
   INSERT_DT                     DATE,
   UPDATE_DT                     DATE,
-----------------------------------------------------------
   FIRST_NAME_CUSTOMER           CHAR(20),
   LAST_NAME_CUSTOMER            CHAR(20),
   COUNTRY_CITY_CUSTOMER         CHAR(20),
   ADRESS_CUSTOMER               CHAR(50),
   EMAIL                         CHAR(30),
   PHONE_CUSTOMER                NUMBER,
   AGE                           NUMBER,
   IS_ACTIVE                     VARCHAR2(6),
   CUSTOMER_SALE_DATE            DATE,
-----------------------------------------------------------
    PAYMENT_METHOD_NAME    	 VARCHAR2(40),
    BANK_NAME	             VARCHAR2(40),
    -----------------------------------------------------------
    employee_id              NUMBER(5),
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
    position_change_date     DATE not null,
-----------------------------------------------------------
    date_id                  DATE         ,
    beg_of_year              DATE         ,      
    end_of_year              DATE         ,    
    day_name                 VARCHAR2(44) ,
    day_number_in_week       VARCHAR2(1)  ,
    day_number_in_month      VARCHAR2(2)  ,
    day_number_in_year       VARCHAR2(3)  ,
    calendar_week_number     VARCHAR2(1)  ,
    week_ending_date         DATE         ,
    calendar_month_number    VARCHAR2(2)  ,
    days_in_month            VARCHAR2(2)  ,
    end_of_month             DATE         ,
    end_of_quarter           VARCHAR2(32) ,
    quarter_number           VARCHAR2(1)  , 
    n_year                   VARCHAR2(4)  ,  
    days_in_cal_year         NUMBER       ,
---------------------------------------------------------------------
    country_city  VARCHAR2(20),
    address       VARCHAR2(20),
    phone         NUMBER 
);


alter session set current_schema=DW_CLEANSING;
INSERT INTO cl_transactions /*+ parallel(DW_CLEANSING.cl_transactions, 8)*/ 
(
 SELECT    
        p.* , c.* , pm.* , e.* , t.*, s.*

 FROM
    DW_CLEANSING.cl_products p
    
    CROSS JOIN DW_CLEANSING.cl_customers c 

        CROSS JOIN DW_CLEANSING.cl_payment_methods pm
        
            CROSS JOIN DW_CLEANSING.CL_EMPLOYEES e
            
                CROSS JOIN DW_CLEANSING.CL_STORES s
            
            INNER JOIN DW_CLEANSING.cl_time t ON t.date_id = c.CUSTOMER_SALE_DATE
 
 WHERE c.CUSTOMER_SALE_DATE > TO_DATE( '01.01.20', 'MM/DD/YY' ) 
        AND c.CUSTOMER_SALE_DATE < TO_DATE( '01.01.22', 'MM/DD/YY' ) and 

        (mod(c.PHONE_CUSTOMER,2) = 0 ) and

        e.phone_EMPLOYEE LIKE '2%' AND

        e.FIRST_NAME_EMPLOYEE LIKE 'D%' AND
        
        E.LAST_NAME_EMPLOYEE NOT LIKE 'P%' AND
                
        E.LAST_NAME_EMPLOYEE NOT LIKE 'S%' AND
                     
        (s.PHONE > 7000000) AND
        
        pm.PAYMENT_METHOD_NAME = 'Card' AND
        
        c.FIRST_NAME_CUSTOMER LIKE 'D%'); 
                                        commit;

select count(*) from cl_stores;

alter session set current_schema = SA_DATE;
select * from sa_stores

    alter session set current_schema=DW_CLEANSING;
    select * from cl_transactions;
    
    SELECT 
        * 
    FROM 
        ALL_OBJECTS 
    WHERE 
        OBJECT_TYPE 
                    IN ('FUNCTION','PROCEDURE','PACKAGE') 
                    AND OWNER = 'DW_CLEANSING'