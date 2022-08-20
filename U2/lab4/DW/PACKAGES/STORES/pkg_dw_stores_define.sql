alter session set current_schema=DW_DATA;
CREATE OR REPLACE PACKAGE PKG_DW_STORES
AS  
   PROCEDURE LOAD_DW_STORE;
END PKG_DW_STORES;

--drop package pkg_dw_stores;