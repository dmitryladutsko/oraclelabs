alter session set current_schema = DW_CLEANSING;

drop table cl_payment_methods

alter session set current_schema = DW_CLEANSING;
CREATE TABLE CL_PAYMENT_METHODS(
    PAYMENT_METHOD_NAME	VARCHAR2(40) NOT NULL,
    BANK_NAME	VARCHAR2(40) NOT NULL
);