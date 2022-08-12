alter session set current_schema=u_dw_references;

create sequence u_dw_references.sq_day_id start with 1;

grant SELECT on u_dw_references.sq_day_id to u_dw_ext_references;