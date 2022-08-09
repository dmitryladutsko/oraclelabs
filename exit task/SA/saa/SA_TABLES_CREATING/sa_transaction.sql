   /* alter session set current_schema=SA_ORDERS;
    drop table t_sa_transactions;
    
    SELECT order_date, Round(AVG(order_price), 1), SUM(order_price), MAX(receiving_date)
    FROM SA_ORDERS.t_sa_transactions
    GROUP BY order_date;*/
    
   /* commit;
    SELECT *
    FROM SA_ORDERS.t_sa_transactions;*/
    
    alter session set current_schema=SA_ORDERS;
    create table t_sa_transactions(
    product_name                  VARCHAR2(15)     not null,
    order_price                   FLOAT            not null,
    order_status                  VARCHAR2(15)     not null,
    order_date                    DATE             not null,
    receiving_date                DATE             not null,
    ----------
    client_name                   VARCHAR2(50)     not null,
    client_surname                VARCHAR2(50)     not null,
    client_patronymic             VARCHAR2(15)     not null,
    phone_number                  NUMBER           not null,
    client_address                VARCHAR2(50)     not null,
    payment_method                VARCHAR2(15)     not null,
    ----------
    currenci_id                   INT              not null,
    currenci_name                 VARCHAR2(25)     not null,
    direct_exchange_rate          FLOAT            not null,
    reverse_exchange_rate         FLOAT            not null,
    ----------
    date_id                       DATE,
    beg_of_fin_year               DATE         ,      
    end_of_fin_year               DATE         ,    
    day_name                      VARCHAR2(44) ,
    day_number_in_week            VARCHAR2(1)  ,
    day_number_in_month           VARCHAR2(2)  ,
    day_number_in_year            VARCHAR2(3)  ,
    calendar_week_number          VARCHAR2(1)  ,
    week_ending_date              DATE         ,
    calendar_month_number         VARCHAR2(2)  ,
    days_in_fin_month             VARCHAR2(2)  ,
    end_of_fin_month              DATE         ,
    end_of_fin_quarter            VARCHAR2(32) ,
    fin_quarter_number            VARCHAR2(1)  , 
    fin_year                 VARCHAR2(4)  ,  
    days_in_cal_year              NUMBER            
    );
    
    
    alter session set current_schema=SA_ORDERS;
    INSERT INTO t_sa_transactions
    (
     SELECT /*+ parallel(SA_ORDERS.t_sa_orders, 4)*/ *
     FROM
        SA_ORDERS.t_sa_orders
     CROSS JOIN (SELECT * FROM SA_CUSTOMERS.t_sa_customers
        WHERE phone_number > 9995807 AND client_name = 'Bob')
     CROSS JOIN (SELECT * FROM SA_CURRENCIES.t_sa_currencies
        WHERE currenci_id = 34)
     INNER JOIN SA_CURRENCIES.t_sa_financial_calendar ON date_id = order_date
    WHERE order_date > TO_DATE( '01.01.20', 'MM/DD/YY' ) AND order_date < TO_DATE( '04.01.22', 'MM/DD/YY' )
    );
    
    commit;