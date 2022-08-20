alter session set current_schema=sal_cl;
CREATE OR REPLACE PACKAGE PKG_SAL_STORES
AS  
   PROCEDURE LOAD_SAL_STORES;
END PKG_SAL_STORES;

--drop package pkg_dw_stores;