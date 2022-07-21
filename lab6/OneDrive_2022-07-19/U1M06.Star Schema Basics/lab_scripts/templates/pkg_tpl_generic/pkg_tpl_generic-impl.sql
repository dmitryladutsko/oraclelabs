CREATE OR REPLACE PACKAGE BODY pkg_etl_clients_dw
AS
   PROCEDURE load_cls_clients
   AS
   BEGIN
      EXECUTE IMMEDIATE 'truncate table cls_clients';

      INSERT INTO cls_clients
         SELECT --+PARALLEL(ord 4) FULL(ord)
               DISTINCT first_name
                      , last_name
                      , birth_day
                      , address
           FROM u_sa_data.orders ord;

      COMMIT;
   END;

   PROCEDURE load_dim_merge_clients
   AS
   BEGIN
      EXECUTE IMMEDIATE 'alter session enable parallel dml';

      DELETE --+PARALLEL(t_clients 4)
            FROM  u_dw_data.t_clients t
            WHERE ( t.client_first_name, t.client_last_name, t.country_id, t.date_of_birth ) IN
                     (SELECT --+PARALLEL(tt 4)
                            tt.client_first_name
                           , tt.client_last_name
                           , tt.country_id
                           , tt.date_of_birth
                        FROM u_dw_data.t_clients tt
                      MINUS
                      SELECT --+USE_HASH(cls cntr) full(cls) PARALLEL(cls 4)
                            first_name
                           , last_name
                           , cntr.country_id
                           , birth_day
                        FROM cls_clients cls
                           , u_dw_references.cu_countries cntr
                       WHERE UPPER ( cntr.region_desc ) = UPPER ( TRIM ( cls.address ) ));

      MERGE INTO u_dw_data.t_clients dw
           USING (SELECT --+USE_HASH(cls cntr) full(cls) PARALLEL(cls 4)
                        first_name
                       , last_name
                       , cntr.country_id
                       , birth_day
                       , ROWNUM AS rn
                    FROM cls_clients cls
                       , u_dw_references.cu_countries cntr
                   WHERE UPPER ( cntr.region_desc ) = UPPER ( TRIM ( cls.address ) )) cls
              ON ( cls.first_name = dw.client_first_name
              AND cls.last_name = dw.client_last_name
              AND cls.country_id = dw.country_id
              AND cls.birth_day = dw.date_of_birth )
      WHEN NOT MATCHED THEN
         INSERT            ( client_id
                           , client_code
                           , client_desc
                           , client_first_name
                           , client_last_name
                           , country_id
                           , date_of_birth )
             VALUES ( u_dw_data.sq_client_id.NEXTVAL
                    , cls.rn
                    , cls.first_name || ' ' || cls.last_name
                    , cls.first_name
                    , cls.last_name
                    , cls.country_id
                    , cls.birth_day )
      WHEN MATCHED THEN
         UPDATE SET client_code  = cls.rn
                  , client_desc  = cls.first_name || ' ' || cls.last_name;

      COMMIT;
   END;

   PROCEDURE load_dim_cursor_clients
   AS
      CURSOR cls_c
      IS
         ( SELECT --+USE_HASH(cls cntr tt) full(cls) full(tt) PARALLEL(cls 4)
                 first_name
                , last_name
                , cntr.country_id
                , birth_day
                , ROWNUM AS rn
                , NVL ( tt.client_id, -1 ) AS client_id
             FROM cls_clients cls
                , u_dw_references.cu_countries cntr
                , u_dw_data.t_clients tt
            WHERE UPPER ( cntr.region_desc ) = UPPER ( TRIM ( cls.address ) )
              AND cls.first_name = tt.client_first_name
              AND cls.last_name = tt.client_last_name
              AND cntr.country_id = tt.country_id
              AND cls.birth_day = tt.date_of_birth
              AND ROWNUM < 1000 );

      lc_count_exist NUMBER;
   BEGIN
      DELETE --+PARALLEL(t_clients 4)
            FROM  u_dw_data.t_clients t
            WHERE ( t.client_first_name, t.client_last_name, t.country_id, t.date_of_birth ) IN
                     (SELECT --+PARALLEL(tt 4)
                            tt.client_first_name
                           , tt.client_last_name
                           , tt.country_id
                           , tt.date_of_birth
                        FROM u_dw_data.t_clients tt
                      MINUS
                      SELECT --+USE_HASH(cls cntr) full(cls) PARALLEL(cls 4)
                            first_name
                           , last_name
                           , cntr.country_id
                           , birth_day
                        FROM cls_clients cls
                           , u_dw_references.cu_countries cntr
                       WHERE UPPER ( cntr.region_desc ) = UPPER ( TRIM ( cls.address ) ));

      COMMIT;
      lc_count_exist := 0;

      FOR c IN cls_c LOOP
         lc_count_exist := lc_count_exist + 1;

         IF c.client_id <> -1 THEN
            UPDATE u_dw_data.t_clients tt
               SET tt.client_code = c.rn
                 , tt.client_desc = c.first_name || ' ' || c.last_name
             WHERE c.client_id = tt.client_id
               AND UPPER ( tt.client_desc ) != UPPER ( c.first_name || ' ' || c.last_name );
         ELSIF ( c.client_id = -1 ) THEN
            INSERT INTO u_dw_data.t_clients tt ( client_id
                                               , client_code
                                               , client_desc
                                               , client_first_name
                                               , client_last_name
                                               , country_id
                                               , date_of_birth )
                 VALUES ( u_dw_data.sq_client_id.NEXTVAL
                        , c.rn
                        , c.first_name || ' ' || c.last_name
                        , c.first_name
                        , c.last_name
                        , c.country_id
                        , c.birth_day );
         ELSE
            raise_application_error ( -9999999999
                                    , 'Деление на ноль.' );
         END IF;

         IF lc_count_exist >= 1000 THEN
            COMMIT;
         END IF;
      END LOOP;

      COMMIT;
   END;
END pkg_etl_clients_dw;
/