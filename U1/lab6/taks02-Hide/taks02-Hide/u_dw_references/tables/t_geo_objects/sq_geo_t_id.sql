--drop sequence sq_geo_t_id;
alter session set current_schema = u_dw_references;

create sequence sq_geo_t_id;

grant SELECT on sq_geo_t_id to u_dw_ext_references;

