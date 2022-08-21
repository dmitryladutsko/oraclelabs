alter session set current_schema = DW_CLEANSING;
    
    drop table cl_transactions; 
    
alter session set current_schema = DW_CLEANSING;
    
    create table cl_transactions(
    --CUSTOMER
   FIRST_NAME_CUSTOMER           CHAR(20),
   LAST_NAME_CUSTOMER            CHAR(20),
   COUNTRY_CITY_CUSTOMER         CHAR(20),
   ADRESS_CUSTOMER               CHAR(50),
   EMAIL                         CHAR(30),
   PHONE_CUSTOMER                NUMBER,
   AGE                           NUMBER,
   IS_ACTIVE                     VARCHAR2(6),
   CUSTOMER_SALE_DATE            DATE,
    ----------PAYMENT METHOD
--    PAYMENT_METHOD_NAME VARCHAR2(40) NOT NULL,
--    BANK_NAME   VARCHAR2(40) NOT NULL,
--------------EMPLOYEE
    employee_id              NUMBER(5) not null,
    first_name_EMPLOYEE      VARCHAR2(40) NOT NULL,
    last_name_EMPLOYEE       VARCHAR2(40) NOT NULL,
    email_EMPLOYEE           VARCHAR2(40) NOT NULL,
    phone_EMPLOYEE           VARCHAR2(40) NOT NULL,
    POSITION_NAME_ACTUAL     VARCHAR2(40) NOT NULL,
    POSITION_DEGREE          VARCHAR2(40) NOT NULL,
    SALES_TYPE               VARCHAR2(40) NOT NULL,
    HIRE_DATE                DATE NOT NULL,
    salary                   int not null,
    chief_id                 int not null,
    position_name_previous   VARCHAR2(40) NOT NULL,
    position_change_date     DATE not null,
   -----------PRODUCT
   PRODUCT_NAME         VARCHAR2(30),
   MODEL_NAME           VARCHAR2(20),
   MEMORY_AMOUNT        NUMBER(22,0),
   COLOR_NAME           VARCHAR2(25),
   PRICE                NUMBER(10),
   INSERT_DT            DATE,
   UPDATE_DT            DATE,  
---------------STORE
    country_city  VARCHAR2(20) NOT NULL,
    address       VARCHAR2(20) NOT NULL,
    phone         NUMBER NOT NULL
    );
------------------------------- CHANGE!!!!!!                 
     alter session set current_schema=SA_CUSTOMERS;
     INSERT INTO SA_TRANSACTIONS 
        SELECT C.*, P.*
             FROM SA_CUSTOMERS.SA_CUSTOMERS C 
                CROSS JOIN SA_PRODUCTS.SA_PRODUCTS P 
             --       right outer 
        WHERE C.CUSTOMER_SALE_DATE > TO_DATE( '01.01.20', 'MM/DD/YY' ) AND C.CUSTOMER_SALE_DATE < TO_DATE( '02.01.22', 'MM/DD/YY' );

       -- SELECT * FROM SA_TRANSACTIONS;
       -- SELECT count(*) FROM SA_TRANSACTIONS
        select count (*),sum(price) as total_revenue, FIRST_NAME_CUSTOMER as CUSTOMER
            from sa_transactions 
                where CUSTOMER_SALE_DATE 
                                            between to_date('01.04.20', 'DD/MM/YY') AND to_date('30.04.20', 'DD/MM/YY')
                                            group by FIRST_NAME_CUSTOMER
                                            ORDER BY TOTAL_REVENUE DESC;
    commit;
    
    
    
--------------------- CREATED TABLES

    SELECT
  table_name, owner
    FROM
  all_tables
    WHERE
  owner='DW_CLEANSING'
    ORDER BY
  owner, table_name


alter session set current_schema = DW_CLEANSING;

SELECT * FROM CL_CUSTOMERS   ;
SELECT * FROM CL_EMPLOYEES   ;
SELECT * FROM CL_GEN_PERIODS ;
SELECT * FROM CL_GEO_LOCATIONS;
SELECT * FROM CL_PAYMENT_METHODS;
SELECT * FROM CL_PRODUCTS       ;
SELECT * FROM CL_STORES         ;
SELECT * FROM CL_TIME           ;
SELECT * FROM CL_TRANSACTIONS  ; 
