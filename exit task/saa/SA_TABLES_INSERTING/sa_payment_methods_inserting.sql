alter session set current_schema = SA_CUSTOMERS;

DROP TABLE SA_PAYMENT_METHODS;

alter session set current_schema = SA_CUSTOMERS;

CREATE TABLE SA_PAYMENT_METHODS(
    PAYMENT_METHOD_NAME VARCHAR2(40) NOT NULL,
    BANK_NAME   VARCHAR2(40) NOT NULL
);

-------------------------------------
-------------------------------------
-------------------------------------
alter session set current_schema = SA_CUSTOMERS;

INSERT INTO SA_PAYMENT_METHODS
    WITH create_method AS (
        SELECT
            1      AS id
          , 'Cash'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            2      AS id
          , 'Card'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            3      AS id
          , 'Legal Entity Payment'  AS a
        FROM
            dual
    ), create_bank_name AS (
        SELECT
            1         AS id
          , 'Wells Fargo Bank'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            2          AS id
          , 'Millenium Bank'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            3        AS id
          , 'Belarus Bank'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            4         AS id
          , 'JPMorgan Chase Bank'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            5         AS id
          , 'Tinkoff Bank'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            6         AS id
          , 'Sber Bank'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            7         AS id
          , 'Moldova National Bank'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            8         AS id
          , 'Deutsche Bank'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            9         AS id
          , 'Landesbank Baden-Württemberg Bank'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            10         AS id
          , 'Barclays'  AS a
        FROM
            dual
                UNION ALL 
        SELECT
            11         AS id
          , 'Metro Bank'  AS a
        FROM
            dual
                UNION ALL 
        SELECT
            12         AS id
          , 'Royal Bank of Scotland'  AS a
        FROM
            dual
                UNION ALL 
        SELECT
            13          AS id
          , 'Raiffeisen Bank'  AS a
        FROM
            dual
                UNION ALL
        SELECT
            14         AS id
          , 'Ukrexim Bank'  AS a
        FROM
            dual
        ), create_payment_method AS (
        SELECT
            a.* ,
            trunc(dbms_random.value(1, 4))                  AS id_payment_method,
            trunc(dbms_random.value(1, 15))                 AS id_bank_name
        FROM
            (
                SELECT
                    ROWNUM rn
                FROM
                    dual
                CONNECT BY
                    level <= 10
            ) a
    )
    SELECT
        b_type.a,
        b_name.a
    FROM
        create_payment_method  cr_payment_method
        LEFT OUTER JOIN create_method              b_type              ON cr_payment_method.id_payment_method = b_type.id
        LEFT OUTER JOIN create_bank_name           b_name           ON cr_payment_method.id_bank_name = b_name.id
--select * from sa_payment_methods

