alter session set current_schema=DW_DATA;

CREATE OR REPLACE PACKAGE pkg_dw_time
AS
   PROCEDURE LOAD_DW_TIME;
END pkg_dw_time;

--drop package pkg_cl_time;