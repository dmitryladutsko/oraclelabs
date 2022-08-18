alter session set current_schema=DW_DATA;

CREATE OR REPLACE PACKAGE pkg_dw_fact_sales
AS  
   PROCEDURE LOAD_DW_FACT_SALES;
END pkg_dw_fact_sales;

alter session set current_schema=DW_DATA;
drop package pkg_dw_fact_sales;