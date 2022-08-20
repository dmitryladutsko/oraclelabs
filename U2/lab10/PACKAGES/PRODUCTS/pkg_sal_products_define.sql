alter session set current_schema=sal_cl;

CREATE OR REPLACE PACKAGE pkg_sal_products
AS  
   PROCEDURE LOAD_SAL_PRODUCTS;
END pkg_sal_products;

--drop package pkg_cl_products;