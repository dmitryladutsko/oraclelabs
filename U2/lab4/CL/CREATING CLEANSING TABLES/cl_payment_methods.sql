alter session set current_schema = SA_CUSTOMERS;

CREATE TABLE SA_PAYMENT_METHODS(
    PAYMENT_METHOD_NAME	VARCHAR2(40 BYTE) NOT NULL,
    BANK_NAME	VARCHAR2(40 BYTE) NOT NULL
);

SELECT * FROM CL_PAYMENT_METHODS;