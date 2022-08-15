alter session set current_schema = DW_CLEANSING;

CREATE TABLE CL_STORES (
    country_city  VARCHAR2(20),
    address       VARCHAR2(20),
    phone         NUMBER 
);


select * from cl_stores;
