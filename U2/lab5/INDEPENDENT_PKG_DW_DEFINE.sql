alter session set current_schema = DW_DATA;
CREATE OR REPLACE PACKAGE pkg_dw_employees_independent
AS  

   PROCEDURE LOAD_DW_EMPLOYEES;
   PROCEDURE LOAD_DW_EMPLOYEES_with_to_refcursor_func;
   PROCEDURE LOAD_DW_EMPLOYEES_with_to_cursor_number_func;

END pkg_dw_employees_independent;