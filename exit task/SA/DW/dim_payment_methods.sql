alter session set current_schema = DW_DATA;

CREATE TABLE DIM_payment_method(
    PAYMENT_METHOD_NAME	VARCHAR2(40 BYTE) NOT NULL,
    BANK_NAME	VARCHAR2(40 BYTE) NOT NULL
);