BEGIN
   pkg_load_ext_ref_languages.load_cls_languages;
   pkg_load_ext_ref_languages.load_ref_lng_scopes;
   pkg_load_ext_ref_languages.load_ref_lng_types;
   pkg_load_ext_ref_languages.load_ref_lanuages;   
END;

select * from U_DW_REFERENCES.cu_lng_scopes;
select * from U_DW_REFERENCES.cu_lng_types;
select * from U_DW_REFERENCES.cu_languages;