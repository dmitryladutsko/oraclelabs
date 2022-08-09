alter session set current_schema = SA_CUSTOMERS;
--drop table sa_customers;
create table SA_CUSTOMERS (
   FIRST_NAME           CHAR(20),
   LAST_NAME            CHAR(20),
   COUNTRY_CITY         CHAR(20),
   ADRESS               CHAR(50),
   EMAIL                CHAR(30),
   PHONE                NUMBER,
   AGE                  NUMBER,
  -- VALID_FROM           DATE
 /*  VALID_TO             DATE                  not null,*/
   IS_ACTIVE            VARCHAR2(6)
  -- INSERT_DT            DATE*/
);

-------------------------------------
-------------------------------------
-------------------------------------
alter session set current_schema = SA_CUSTOMERS;

INSERT INTO sa_customers
    WITH create_first_name AS (
        SELECT
            1      AS id
          , 'Dmitry'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2      AS id
          , 'Vika'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3      AS id
          , 'Artem'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4      AS id
          , 'Nikita'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5      AS id
          , 'Vanya'  AS a
        FROM
            dual
            UNION ALL
        SELECT
            6      AS id
          , 'Masha'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            7      AS id
          , 'John'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            8      AS id
          , 'Boris'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            9      AS id
          , 'Mark'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            10      AS id
          , 'Stan'  AS a
        FROM
            dual
    ), create_last_name AS (
        SELECT
            1         AS id
          , 'Ladutsko'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2          AS id
          , 'Smith'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3        AS id
          , 'Stanley'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4         AS id
          , 'Brown'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5         AS id
          , 'Abel'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            6         AS id
          , 'Johnaton'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            7         AS id
          , 'Lee'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            8         AS id
          , 'Grey'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            9         AS id
          , 'Sobolev'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            10         AS id
          , 'Petrov'  AS a
        FROM
            dual
    ), create_country AS (
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
          , 'Russia Moskow'  AS a
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
    ), create_address AS (
        SELECT
            1         AS id
          , 'Shafarnyanskogo st.'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2          AS id
          , 'Esenina st.'  AS a
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
          , 'Kosmonavtov st.'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            6         AS id
          , 'Gross st.'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            7         AS id
          , 'Garden st.'  AS a
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
          , 'Tolbuhina st.'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            10         AS id
          , 'Central sq.'  AS a
        FROM
            dual
    ), create_email AS (
        SELECT
            1         AS id
          , 'genius@gmail.com'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2          AS id
          , 'nagibator@gmail.com'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3        AS id
          , 'gog@gmail.com'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4         AS id
          , 'meme@gmail.com'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            5         AS id
          , 'gunpower@mail.ru'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            6         AS id
          , 'dmdmd@datamola.com'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            7         AS id
          , 'lemon@inbox.ru'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            8         AS id
          , 'world@outlook.com'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            9         AS id
          , 'genesis12@gmail.com'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            10         AS id
          , 'hello1267@gmail.com'  AS a
        FROM
            dual
    /*    ), create_valid_from_date AS (
        SELECT 
        1 as id,
        TO_DATE(TRUNC(DBMS_RANDOM.VALUE(
            TO_CHAR(TO_DATE('01-01-2019','dd-mm-yyyy'),'J'),
             TO_CHAR(TO_DATE('01-01-2022','dd-mm-yyyy'),'J'))),'J') as a
        FROM DUAL
        CONNECT BY level <= 10*/
        ), create_is_active AS (
        SELECT
            1         AS id
          , 'yes'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2          AS id
          , 'no'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3        AS id
          , 'Error'  AS a
        FROM
            dual
            ) /*, create_client_payment_method AS (
        SELECT
            1         AS id
          , 'Cash'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            2          AS id
          , 'Card'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            3        AS id
          , 'Check'  AS a
        FROM
            dual
    )*/, create_customer AS (
        SELECT
            a.* ,
            trunc(dbms_random.value(1, 11))                  AS id_first_name,
            trunc(dbms_random.value(1, 11))                  AS id_last_name,
            trunc(dbms_random.value(1, 11))                  AS id_country,
            trunc(dbms_random.value(1, 11))                  AS id_address,
            trunc(dbms_random.value(1, 11))                  AS id_email,
            trunc(dbms_random.value(1000001, 9999999))       AS phone_number,
            trunc(dbms_random.value(16, 65))                 AS age,
           --????????? trunc(dbms_random.value(1, 1))                   AS valid_from_date
            trunc(dbms_random.value(1, 4))                   AS id_active
      --    , trunc(dbms_random.value(1, 3))                   AS id_customer_payment_method*/
        FROM
            (
                SELECT
                    ROWNUM rn
                FROM
                    dual
                CONNECT BY
                    level <= 1500
            ) a
    )
    SELECT
        c_name.a,
        c_surname.a,
        c_country.a,
        c_address.a,
        c_email.a,
        cr_customer.phone_number,
        cr_customer.age,
        --??????cr_customer.valid_from_date,
        c_is_active.a
  --    , c_payment_method.a
    FROM
        create_customer  cr_customer
        LEFT OUTER JOIN create_first_name              c_name              ON cr_customer.id_first_name = c_name.id
        LEFT OUTER JOIN create_last_name           c_surname           ON cr_customer.id_last_name = c_surname.id
        LEFT OUTER JOIN create_country       c_country        ON cr_customer.id_country = c_country.id
        LEFT OUTER JOIN create_address           c_address           ON cr_customer.id_address = c_address.id
        LEFT OUTER JOIN create_email           c_email          ON cr_customer.id_email = c_email.id
        LEFT OUTER JOIN create_is_active   c_is_active  ON cr_customer.id_active = c_is_active.id;
        --??????LEFT OUTER JOIN create_valid_from_date   c_valid_from  ON cr_customer.valid_from_date = c_valid_from.id;
        --LEFT OUTER JOIN create_client_payment_method    c_payment_method    ON cr_customer.id_customer_payment_method = c_payment_method.id;   

--select * from sa_customers