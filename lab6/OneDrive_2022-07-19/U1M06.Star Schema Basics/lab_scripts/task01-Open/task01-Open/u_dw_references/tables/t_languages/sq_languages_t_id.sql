drop sequence u_dw_references.sq_languages_t_id;

alter session set current_schema = u_dw_references;

create sequence u_dw_references.sq_languages_t_id;

grant SELECT on u_dw_references.sq_languages_t_id to u_dw_ext_references;
