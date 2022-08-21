    alter session set current_schema=SA_DATE;
SELECT * FROM SA_GEN_PERIODS ;
SELECT * FROM SA_STORES      ;
SELECT * FROM SA_TIME  ;

    alter session set current_schema=SA_CUSTOMERS;
SELECT * FROM SA_CUSTOMERS      ;
SELECT * FROM SA_PAYMENT_METHODS  ;
SELECT * FROM SA_TRANSACTIONS  ;

    alter session set current_schema=SA_PRODUCTS;
SELECT * FROM SA_EMPLOYEES      ;
SELECT * FROM SA_PRODUCTS  ;

        SELECT
  table_name, owner
FROM
  all_tables
WHERE
  owner='SA_PRODUCTS'
ORDER BY
  owner, table_name
  
    
    alter session set current_schema=SA_CUSTOMERS;
    create table sa_transactions(
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
    PAYMENT_METHOD_NAME VARCHAR2(40) NOT NULL,
    BANK_NAME   VARCHAR2(40) NOT NULL,
   -----------PRODUCT
   PRODUCT_NAME         VARCHAR2(30),
   MODEL_NAME           VARCHAR2(20),
   MEMORY_AMOUNT        NUMBER(22,0),
   COLOR_NAME           VARCHAR2(25),
   PRICE                NUMBER(10),
   INSERT_DT            DATE,
   UPDATE_DT            DATE
   );
                 
     alter session set current_schema=SA_CUSTOMERS;
     INSERT INTO SA_TRANSACTIONS 
        SELECT C.*,PM.*, P.*
             FROM SA_CUSTOMERS.SA_CUSTOMERS C 
                CROSS JOIN SA_PRODUCTS.SA_PRODUCTS P
                    CROSS JOIN SA_CUSTOMERS.SA_PAYMENT_METHODS PM 
        WHERE C.CUSTOMER_SALE_DATE > TO_DATE( '01.01.20', 'MM/DD/YY' ) AND C.CUSTOMER_SALE_DATE < TO_DATE( '02.01.22', 'MM/DD/YY' );

       -- alter session set current_schema=SA_CUSTOMERS;SELECT * FROM SA_TRANSACTIONS;
       -- SELECT count(*) FROM SA_TRANSACTIONS
        select count (*),sum(price) as total_revenue, FIRST_NAME_CUSTOMER as CUSTOMER
            from sa_transactions 
                where CUSTOMER_SALE_DATE 
                                            between to_date('01.04.20', 'DD/MM/YY') AND to_date('30.04.20', 'DD/MM/YY')
                                            group by FIRST_NAME_CUSTOMER
                                            ORDER BY TOTAL_REVENUE DESC
    commit;
