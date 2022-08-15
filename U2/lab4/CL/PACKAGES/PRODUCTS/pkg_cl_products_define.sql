alter session set current_schema=DW_CLEANSING;

CREATE OR REPLACE PACKAGE pkg_cl_products
AS  
   PROCEDURE LOAD_CLEAN_PRODUCTS;
END pkg_cl_products;

--drop package pkg_cl_products;