alter session set current_schema=sal_cl;

CREATE OR REPLACE PACKAGE pkg_sal_fact_sales
AS  
   PROCEDURE LOAD_SAL_FACT_SALES;
END pkg_sal_fact_sales;

--alter session set current_schema=DW_DATA;
--drop package pkg_dw_fact_sales;