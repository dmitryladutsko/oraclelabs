DROP TABLE SA_STORES;

alter session set current_schema = SA_DATE;

CREATE TABLE SA_STORES (
    country_city  VARCHAR2(20),
    address       VARCHAR2(20),
    phone         NUMBER
);

-------------------------------------
-------------------------------------
-------------------------------------
alter session set current_schema = SA_DATE;

INSERT INTO SA_STORES
    WITH create_country AS (
        SELECT
            1         AS id
          , 'USA California'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2          AS id
          , 'UK Manchester'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3        AS id
          , 'Belarus Minsk'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4         AS id
          , 'Russia Moscow'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5         AS id
          , 'Germany Essen'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            6         AS id
          , 'Switzerland Bern'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            7         AS id
          , 'Ukraine Kyiv'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            8         AS id
          , 'Moldova Kishinev'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            9         AS id
          , 'Poland Warsaw'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            10         AS id
          , 'Litva Vilnius'  AS a
        FROM
            dual
        ), 
        create_address AS (
        SELECT
            1         AS id
          , 'Bogdanovicha st.'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2          AS id
          , 'Tiger st.'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3        AS id
          , 'Independent st.'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4         AS id
          , 'Park st.'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5         AS id
          , 'Doggy st.'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            6         AS id
          , 'Grey Goose st.'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            7         AS id
          , 'Brooklyn st.'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            8         AS id
          , 'Lenina st.'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            9         AS id
          , 'Time st.'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            10         AS id
          , 'Mickevicha sq.'  AS a
        FROM
            dual
        ),
        create_store AS (
        SELECT
            a.* ,
            trunc(dbms_random.value(1, 10))                  AS id_country,
            trunc(dbms_random.value(1, 10))                  AS id_address,
            trunc(dbms_random.value(1000001, 9999999))       AS phone_number
        FROM
            (
                SELECT
                    ROWNUM rn
                FROM
                    dual
                CONNECT BY
                    level <= 30
            ) a
    )
    SELECT
        c_country.a,
        c_address.a,
        cr_store.phone_number
    FROM
        create_store  cr_store
        LEFT OUTER JOIN create_country       c_country        ON cr_store.id_country = c_country.id
        LEFT OUTER JOIN create_address           c_address           ON cr_store.id_address = c_address.id

--select * from sa_stores order by country_city







