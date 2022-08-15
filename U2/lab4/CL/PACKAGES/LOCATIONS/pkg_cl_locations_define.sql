alter session set current_schema=DW_CLEANSING;

CREATE OR REPLACE PACKAGE pkg_cl_locations
AS
   PROCEDURE LOAD_CLEAN_LOCATIONS;
END pkg_cl_locations;

--drop package pkg_cl_locations;