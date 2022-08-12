alter session set current_schema = SA_PRODUCTS;

drop table SA_PRODUCTS;

alter session set current_schema = SA_PRODUCTS;

create table SA_PRODUCTS (
   PRODUCT_NAME         VARCHAR2(30),
   MODEL_NAME           VARCHAR2(20),
   MEMORY_AMOUNT        NUMBER(22,0),
   COLOR_NAME           VARCHAR2(25),
   PRICE                NUMBER(10),
   INSERT_DT            DATE,
   UPDATE_DT            DATE
);

-------------------------------------
-------------------------------------
-------------------------------------
alter session set current_schema = SA_PRODUCTS;

INSERT INTO SA_PRODUCTS
    WITH create_product_name AS (
        SELECT
            1      AS id
          , 'Iphone'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            2      AS id
          , 'Ipad'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            3      AS id
          , 'Ipod'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4         AS id
          , 'AirPods'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            5          AS id
          , 'Imac'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            6        AS id
          , 'Imouse'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            7         AS id
          , 'MacBook'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            8         AS id
          , 'Ipan'  AS a
        FROM
            dual
        ), 
        create_model_name AS (
        SELECT
            1      AS id
          , 'XS'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            2      AS id
          , '11'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            3      AS id
          , '12'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4         AS id
          , 'Pro'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            5          AS id
          , 'Air'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            6        AS id
          , 'Max'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            7         AS id
          , '8'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            8         AS id
          , 'Mini'  AS a
        FROM
            dual
        ),create_memory AS (
        SELECT
            1      AS id
          , '16'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            2      AS id
          , '32'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            3      AS id
          , '64'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4         AS id
          , '128'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            5          AS id
          , '256'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            6        AS id
          , '512'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            7         AS id
          , '1024'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            8         AS id
          , '2048'  AS a
        FROM
            dual
         ), 
        create_color AS (
        SELECT
            1      AS id
          , 'White'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            2      AS id
          , 'Black'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            3      AS id
          , 'Grey'  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4         AS id
          , 'Blue'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            5          AS id
          , 'Red'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            6        AS id
          , 'Green'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            7         AS id
          , 'Yellow'  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            8         AS id
          , 'Pink'  AS a
        FROM
            dual
          ), 
        create_price AS (
        SELECT
            1      AS id
          , 599  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            2      AS id
          , 699  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            3      AS id
          , 899  AS a
        FROM
            dual
        UNION ALL
        SELECT
            4         AS id
          , 999  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            5          AS id
          , 1099  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            6        AS id
          , 1199  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            7         AS id
          , 1499  AS a
        FROM
            dual
        UNION ALL 
        SELECT
            8         AS id
          , 1999  AS a
        FROM
            dual
         ), create_insert_date AS (
        SELECT 
        1 as id,
        TO_DATE(TRUNC(DBMS_RANDOM.VALUE(
            TO_CHAR(TO_DATE('01-01-2020','dd-mm-yyyy'),'J'),
             TO_CHAR(TO_DATE('01-01-2022','dd-mm-yyyy'),'J'))),'J') as a
        FROM DUAL
        CONNECT BY level <= 17
        ), create_product AS (
        SELECT
            a.* ,
            trunc(dbms_random.value(1, 9))                  AS id_product_name,
            trunc(dbms_random.value(1, 9))                  AS id_model_name,
            trunc(dbms_random.value(1, 9))                  AS id_memory,
            trunc(dbms_random.value(1, 9))                  AS id_color,
            trunc(dbms_random.value(1, 9))                  AS id_price,
            trunc(dbms_random.value(1, 1))                  AS id_insert_date
        FROM
            (
                SELECT
                    ROWNUM rn
                FROM
                    dual
                CONNECT BY
                    level <= 35
            ) a
    )
    SELECT
        p_name.a,
        p_model.a,
        p_memory.a,
        p_color.a,
        p_price.a,
        p_ins_date.a,
        TO_DATE(P_INS_DATE.A + dbms_random.value(13, 99))
        
    FROM
        create_product  cr_product
        LEFT OUTER JOIN create_product_name             p_name              ON cr_product.id_product_name = p_name.id
        LEFT OUTER JOIN create_model_name           p_model           ON cr_product.id_model_name = p_model.id
        LEFT OUTER JOIN create_memory           p_memory           ON cr_product.id_memory = p_memory.id
        LEFT OUTER JOIN create_color           p_color           ON cr_product.id_color = p_color.id
        LEFT OUTER JOIN create_price           p_price           ON cr_product.id_price = p_price.id
        LEFT OUTER JOIN create_insert_date           p_ins_date           ON cr_product.id_insert_date = p_ins_date.id
--select * from SA_PRODUCTS
