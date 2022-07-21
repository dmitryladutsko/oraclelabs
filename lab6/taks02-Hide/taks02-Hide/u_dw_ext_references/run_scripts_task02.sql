BEGIN
   --Transport Countries
   pkg_load_ext_ref_geography.load_cls_languages_alpha3;
   pkg_load_ext_ref_geography.load_cls_languages_alpha2;
   pkg_load_ext_ref_geography.load_ref_geo_countries;
END;

BEGIN
   --Cleansing
   pkg_load_ext_ref_geography.load_cls_geo_structure;
   pkg_load_ext_ref_geography.load_cls_geo_structure2cntr;
   pkg_load_ext_ref_geography.load_cls_countries_grouping;
   pkg_load_ext_ref_geography.load_cls_countries2groups;
   --Transport References
   pkg_load_ext_ref_geography.load_ref_geo_systems;
   pkg_load_ext_ref_geography.load_ref_geo_parts;
   pkg_load_ext_ref_geography.load_ref_geo_regions;
   pkg_load_ext_ref_geography.load_ref_cntr_group_systems;
   pkg_load_ext_ref_geography.load_ref_cntr_groups;
   pkg_load_ext_ref_geography.load_ref_cntr_sub_groups;   
   --Transport Links
   pkg_load_ext_ref_geography.load_lnk_geo_structure;
   pkg_load_ext_ref_geography.load_lnk_geo_countries;
   pkg_load_ext_ref_geography.load_lnk_cntr_grouping;
   pkg_load_ext_ref_geography.load_lnk_cntr2groups;
END;

alter session set current_schema = u_dw_references;

--selects for Step 1
select * from t_localizations;
select * from cu_languages;
select * from w_lng_links;
select * from cu_lng_scopes;
select * from cu_lng_types;

select * from sys.all_tables
where OWNER in ('U_DW_REFERENCES','U_DW_EXT_REFERENCES');

select * from sys.all_views
where OWNER in ('U_DW_REFERENCES','U_DW_EXT_REFERENCES');

select * from dba_tablespaces;
--selects for Step 2
select * from t_cntr_group_systems;
select * from lc_cntr_group_systems;

select * from t_cntr_groups;
select * from lc_cntr_groups;

select * from t_cntr_sub_groups;
select * from lc_cntr_sub_groups;

select * from t_countries;
select * from lc_countries;

select * from t_geo_object_links;

select * from t_geo_objects;

select * from t_geo_parts;
select * from lc_geo_parts;

select * from t_geo_regions;
select * from lc_geo_regions;

select * from t_geo_systems;
select * from lc_geo_systems;

select * from t_geo_types;

select * from t_addresses;
select * from t_address_types;


