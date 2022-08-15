alter session set current_schema=DW_CLEANSING;

CREATE OR REPLACE PACKAGE pkg_cl_stores
AS  
   PROCEDURE LOAD_CLEAN_STORES;
END pkg_cl_stores;

--drop package pkg_cl_stores;