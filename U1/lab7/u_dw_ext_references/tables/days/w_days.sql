create or replace view u_dw_references.w_days as
SELECT            DAY_ID    ,                
                DAY_NAME    ,               
      DAY_NUMBER_IN_WEEK    ,     
     DAY_NUMBER_IN_MONTH    ,    
      DAY_NUMBER_IN_YEAR           
  FROM t_days;

grant DELETE,INSERT,UPDATE,SELECT on u_dw_references.w_days to u_dw_ext_references;
