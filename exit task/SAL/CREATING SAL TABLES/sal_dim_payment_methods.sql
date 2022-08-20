alter session set current_schema = sal_cl;

CREATE TABLE sal_dim_payment_methods(
    PAYMENT_METHOD_ID	NUMBER(10,0),
    PAYMENT_METHOD_NAME	VARCHAR2(40),
    BANK_NAME	VARCHAR2(40) ,
    CONSTRAINT PK_PAYMENT_METHOD_ID PRIMARY KEY (  PAYMENT_METHOD_ID ) ENABLE
);