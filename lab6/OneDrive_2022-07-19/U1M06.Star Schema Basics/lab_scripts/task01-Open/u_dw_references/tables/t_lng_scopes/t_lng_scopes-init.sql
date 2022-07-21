--Initial rows
INSERT INTO u_dw_references.t_lng_scopes ( lng_scope_id
                         , lng_scope_code )
     VALUES ( 1
            , 'I' );

INSERT INTO u_dw_references.t_lng_scopes ( lng_scope_id
                         , lng_scope_code )
     VALUES ( 2
            , 'M' );

INSERT INTO u_dw_references.t_lng_scopes ( lng_scope_id
                         , lng_scope_code )
     VALUES ( 3
            , 'S' );

Commit;         
select * from u_dw_references.t_lng_scopes;
delete from u_dw_references.t_lng_scopes where LNG_SCOPE_ID >3;
truncate table u_dw_references.t_lng_scopes;
           SELECT * FROM USER_CONSTRAINTS WHERE TABLE_NAME = "u_dw_references.t_lng_scopes";