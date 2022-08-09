drop table sa_employees;

alter session set current_schema = SA_PRODUCTS;

CREATE TABLE SA_EMPLOYEES (
    first_name      VARCHAR2(40) NOT NULL,
    last_name       VARCHAR2(40) NOT NULL,
    email           VARCHAR2(40) NOT NULL,
    phone           VARCHAR2(40) NOT NULL,
    POSITION_NAME   VARCHAR2(40) NOT NULL,
    POSITION_DEGREE   VARCHAR2(40) NOT NULL,
    SALES_TYPE      VARCHAR2(40) NOT NULL
    --HIRE_DATE      DATE NOT NULL
);

-------------------------------------
-------------------------------------
-------------------------------------
alter session set current_schema = SA_PRODUCTS;

INSERT INTO SA_EMPLOYEES
    WITH create_first_name AS (
        SELECT
            1      AS id
          , 'Sandy'  AS a
        FROM
            dual
        UNION 
        SELECT
            2      AS id
          , 'Anika'  AS a
        FROM
            dual
        UNION 
        SELECT
            3      AS id
          , 'Ali'  AS a
        FROM
            dual
        UNION 
        SELECT
            4      AS id
          , 'Mohammed'  AS a
        FROM
            dual
        UNION 
        SELECT
            5      AS id
          , 'Anibal'  AS a
        FROM
            dual
            UNION 
        SELECT
            6      AS id
          , 'Salamon'  AS a
        FROM
            dual
        UNION 
        SELECT
            7      AS id
          , 'Abrigel'  AS a
        FROM
            dual
        UNION 
        SELECT
            8      AS id
          , 'Miron'  AS a
        FROM
            dual
        UNION 
        SELECT
            9      AS id
          , 'Kyrill'  AS a
        FROM
            dual
        UNION 
        SELECT
            10      AS id
          , 'Maxim'  AS a
        FROM
            dual
        UNION
        SELECT
            11      AS id
          , 'Sara'  AS a
        FROM
            dual
        UNION 
        SELECT
            12      AS id
          , 'Vika'  AS a
        FROM
            dual
        UNION 
        SELECT
            13      AS id
          , 'Artem'  AS a
        FROM
            dual
        UNION 
        SELECT
            14      AS id
          , 'Dmitry'  AS a
        FROM
            dual
        UNION 
        SELECT
            15      AS id
          , 'Samuel'  AS a
        FROM
            dual
            UNION 
        SELECT
            16      AS id
          , 'Masha'  AS a
        FROM
            dual
        UNION 
        SELECT
            17      AS id
          , 'John'  AS a
        FROM
            dual
        UNION 
        SELECT
            18      AS id
          , 'Boris'  AS a
        FROM
            dual
        UNION 
        SELECT
            19      AS id
          , 'Imma'  AS a
        FROM
            dual
        UNION 
        SELECT
            20      AS id
          , 'Stasy'  AS a
        FROM
            dual
        
    ), create_last_name AS (
        SELECT
            1         AS id
          , 'Ladutsko'  AS a
        FROM
            dual
        UNION 
        SELECT
            2          AS id
          , 'Smith'  AS a
        FROM
            dual
        UNION 
        SELECT
            3        AS id
          , 'Stanley'  AS a
        FROM
            dual
        UNION 
        SELECT
            4         AS id
          , 'Brown'  AS a
        FROM
            dual
        UNION 
        SELECT
            5         AS id
          , 'Abel'  AS a
        FROM
            dual
        UNION 
        SELECT
            6         AS id
          , 'Johnaton'  AS a
        FROM
            dual
        UNION 
        SELECT
            7         AS id
          , 'Lee'  AS a
        FROM
            dual
        UNION 
        SELECT
            8         AS id
          , 'Grey'  AS a
        FROM
            dual
        UNION 
        SELECT
            9         AS id
          , 'Sobolev'  AS a
        FROM
            dual
        UNION 
        SELECT
            10         AS id
          , 'Petrov'  AS a
        FROM
            dual
                UNION 
        SELECT
            11         AS id
          , 'Black'  AS a
        FROM
            dual
                UNION 
        SELECT
            12         AS id
          , 'See'  AS a
        FROM
            dual
                UNION 
        SELECT
            13          AS id
          , 'Alumos'  AS a
        FROM
            dual
    ), create_email AS (
        SELECT
            1         AS id
          , 'genius@apple.com'  AS a
        FROM
            dual
        UNION 
        SELECT
            2          AS id
          , 'nagibator@apple.com'  AS a
        FROM
            dual
        UNION 
        SELECT
            3        AS id
          , 'gog@apple.com'  AS a
        FROM
            dual
        UNION 
        SELECT
            4         AS id
          , 'meme@apple.com'  AS a
        FROM
            dual
        UNION 
        SELECT
            5         AS id
          , 'gunpower@apple.ru'  AS a
        FROM
            dual
        UNION 
        SELECT
            6         AS id
          , 'dmdmd@apple.com'  AS a
        FROM
            dual
        UNION 
        SELECT
            7         AS id
          , 'lemon@apple.ru'  AS a
        FROM
            dual
        UNION 
        SELECT
            8         AS id
          , 'world@apple.com'  AS a
        FROM
            dual
        UNION 
        SELECT
            9         AS id
          , 'genesis12@apple.com'  AS a
        FROM
            dual
        UNION 
        SELECT
            10         AS id
          , 'hello1267@apple.com'  AS a
        FROM
            dual
        UNION
                SELECT
            11         AS id
          , 'gdjsbus@apple.com'  AS a
        FROM
            dual
        UNION 
        SELECT
            12          AS id
          , 'nuior@apple.com'  AS a
        FROM
            dual
        UNION 
        SELECT
            13        AS id
          , 'gooof@apple.com'  AS a
        FROM
            dual
        UNION 
        SELECT
            14         AS id
          , 'mama@apple.com'  AS a
        FROM
            dual
        UNION 
        SELECT
            15         AS id
          , 'gunjhbihbwer@apple.ru'  AS a
        FROM
            dual
        UNION 
        SELECT
            16         AS id
          , 'dffsfsmd@apple.com'  AS a
        FROM
            dual
        UNION 
        SELECT
            17         AS id
          , 'lemon@apple.ru'  AS a
        FROM
            dual
        UNION 
        SELECT
            18         AS id
          , 'world@apple.com'  AS a
        FROM
            dual
        UNION 
        SELECT
            19         AS id
          , 'gnoms12@apple.com'  AS a
        FROM
            dual
        UNION 
        SELECT
            20         AS id
          , 'hello1jdnjn267@apple.com'  AS a
        FROM
            dual
           ), create_position AS (
        SELECT
            1         AS id
          , 'Manager'  AS a
        FROM
            dual
        UNION 
        SELECT
            2          AS id
          , 'Sales Manager'  AS a
        FROM
            dual
        UNION 
        SELECT
            3        AS id
          , 'Product-line sales manager'  AS a
        FROM
            dual
        UNION 
        SELECT
            4         AS id
          , 'regional sales manager'  AS a
        FROM
            dual
             ), create_degree AS (
        SELECT
            1         AS id
          , 'Junior'  AS a
        FROM
            dual
        UNION 
        SELECT
            2          AS id
          , 'Middle'  AS a
        FROM
            dual
        UNION 
        SELECT
            3        AS id
          , 'Senior'  AS a
        FROM
            dual
        UNION 
        SELECT
            4         AS id
          , 'Top'  AS a
        FROM
            dual
             ), create_type AS (
        SELECT
            1         AS id
          , 'B2B'  AS a
        FROM
            dual
        UNION 
        SELECT
            2          AS id
          , 'B2C'  AS a
        FROM
            dual
        UNION 
        SELECT
            3        AS id
          , 'Enterprice'  AS a
        FROM
            dual
        UNION 
        SELECT
            4         AS id
          , 'Direct'  AS a
        FROM
            dual
        ), create_employee AS (
        SELECT
            a.* ,
            trunc(dbms_random.value(1, 21))                  AS id_first_name,
            trunc(dbms_random.value(1, 14))                  AS id_last_name,
            trunc(dbms_random.value(1, 21))                  AS id_email,
            trunc(dbms_random.value(1000001, 9999999))       AS phone_number,
            trunc(dbms_random.value(1, 5))                   AS id_position,
            trunc(dbms_random.value(1, 5))                   AS id_degree,
            trunc(dbms_random.value(1, 5))                   AS id_type
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
        e_name.a,
        e_surname.a,
        e_email.a,
        cr_employee.phone_number,
        e_position.a,
        e_degree.a,
        e_type.a
    FROM
        create_employee  cr_employee
        LEFT OUTER JOIN create_first_name              e_name              ON cr_employee.id_first_name = e_name.id
        LEFT OUTER JOIN create_last_name           e_surname           ON cr_employee.id_last_name = e_surname.id
        LEFT OUTER JOIN create_email           e_email          ON cr_employee.id_email = e_email.id
        LEFT OUTER JOIN create_position           e_position          ON cr_employee.id_position = e_position.id
        LEFT OUTER JOIN create_degree           e_degree           ON cr_employee.id_degree = e_degree.id
        LEFT OUTER JOIN create_type           e_type           ON cr_employee.id_type = e_type.id
--select * from sa_employees



