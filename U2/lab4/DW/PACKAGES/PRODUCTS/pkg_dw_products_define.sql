alter session set current_schema=DW_DATA;

CREATE OR REPLACE PACKAGE pkg_dw_products
AS  
   PROCEDURE LOAD_DW_PRODUCTS;
END pkg_dw_products;

--drop package pkg_cl_products;