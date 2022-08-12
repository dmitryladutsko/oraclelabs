--==============================================================
-- Initial Rows: t_localizations
--==============================================================
select * from u_dw_references.t_localizations;
INSERT INTO u_dw_references.t_localizations ( localization_id
                            , localization_code
                            , localization_desc
                            , localization_desc_ens
                            , lng_id
                            , contry_id
                            , is_default )
     VALUES ( -1
            , 'n.a.'
            , 'Not Available'
            , 'Not Available'
            , NULL
            , NULL
            , NULL );

INSERT INTO u_dw_references.t_localizations ( localization_id
                            , localization_code
                            , localization_desc
                            , localization_desc_ens
                            , lng_id
                            , contry_id
                            , is_default )
     VALUES ( -2
            , 'n.d.'
            , 'Not Defined'
            , 'Not Defined'
            , NULL
            , NULL
            , NULL );

INSERT INTO u_dw_references.t_localizations ( localization_id
                            , localization_code
                            , localization_desc
                            , localization_desc_ens
                            , lng_id
                            , contry_id
                            , is_default )
     VALUES ( 1
            , 'en-US'
            , 'English'
            , 'English'
            , NULL
            , NULL
            , 1 );

INSERT INTO u_dw_references.t_localizations ( localization_id
                            , localization_code
                            , localization_desc
                            , localization_desc_ens
                            , lng_id
                            , contry_id
                            , is_default )
     VALUES ( 2
            , 'ru-RU'
            , 'Russian'
            , '�������'
            , NULL
            , NULL
            , NULL );

INSERT INTO u_dw_references.t_localizations ( localization_id
                            , localization_code
                            , localization_desc
                            , localization_desc_ens
                            , lng_id
                            , contry_id
                            , is_default )
     VALUES ( 3
            , 'be-BY'
            , 'Belarussian'
            , '��������i'
            , NULL
            , NULL
            , NULL );

COMMIT;