-- Storage level
--my
CREATE TABLESPACE ts_dw_idx_01
DATAFILE 'db_qpt_dw_idx_01.dat'
SIZE 150M
 AUTOEXTEND ON NEXT 50M
 SEGMENT SPACE MANAGEMENT AUTO;
-------------------------------------
select creation_time, name from v$datafile;

SELECT * from t_dates;

SELECT * FROM dba_users order by CREATED desc;
commit;
DROP USER DM_GEN_PERIODS CASCADE; 

DROP TABLESPACE ts_dw_data_01
INCLUDING CONTENTS AND DATAFILES;

alter system set db_create_file_dest = '/oracle/u02/oradata/DLadutkodb';


-- Storage level
create tablespace ts_sa_customers_data_001
datafile '/oracle/u02/oradata/DLadutkodb/ts_sa_customers_data_001.dat'
size 150M
    autoextend on next 50M
logging
segment space management auto
extent management local;

create user SA_CUSTOMERS
identified by "%PWD%"
default tablespace ts_sa_customers_data_001;

grant connect, resource to SA_CUSTOMERS;

   /* create tablespace ts_sa_borrowers_data_001
datafile '/oracle/u02/oradata/DLadutkodb/ts_sa_borrowers_data_001.dat'
size 150M
    autoextend on next 50M
logging
segment space management auto
extent management local;

create user SA_BORROWERS
identified by "%PWD%"
default tablespace ts_sa_borrowers_data_001;

grant connect, resource to SA_BORROWERS;*/

create tablespace ts_sa_products_data_001
datafile '/oracle/u02/oradata/DLadutkodb/ts_sa_products_data_001.dat'
size 150M
    autoextend on next 50M
logging
segment space management auto
extent management local;

create user SA_PRODUCTS
identified by "%PWD%"
default tablespace ts_sa_customers_data_001;

grant connect, resource to SA_PRODUCTS;


-- Cleansing level
create tablespace ts_dw_cleansing
datafile '/oracle/u02/oradata/DLadutkodb/ts_dw_cleansing.dat'
size 150M
    autoextend on next 50M
logging
segment space management auto
extent management local;

create user DW_CLEANSING
identified by "%PWD%"
default tablespace ts_dw_cleansing;

grant connect, resource, create view to DW_CLEANSING;


-- DW level
DROP TABLESPACE ts_dw_data_01 INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;

create tablespace ts_dw_data_01
datafile '/oracle/u02/oradata/DLadutkodb/ts_dw_data_01.dat'
size 150M reuse 
    autoextend on next 50M
logging
segment space management auto
extent management local;

create user DW_DATA
identified by "%PWD%"
default tablespace ts_dw_data_01;

grant connect, resource to DW_DATA;

--DROP USER DW_DATA CASCADE; 

-- DW - Prepare star cleansing level
create tablespace ts_sa_dw_cl_01
datafile '/oracle/u02/oradata/DLadutkodb/ts_sal_dw_cl_01.dat'
size 150M
    autoextend on next 50M
logging
segment space management auto
extent management local;

create user sa_dw_cl
identified by "%PWD%"
default tablespace ts_sa_dw_cl_01;

grant connect, resource, create view to sa_dw_cl;

-- star cleansing

create tablespace ts_sa_cl_001
datafile '/oracle/u02/oradata/DLadutkodb/ts_sa_cl_001.dat'
size 150M
    autoextend on next 50M
logging
segment space management auto
extent management local;

create user sa_cl
identified by "%PWD%"
default tablespace ts_sa_cl_001;

grant connect, resource, create view to sa_cl;


-- star level

-- fact tablespace
create tablespace ts_sa_fct_sales_01
datafile '/oracle/u02/oradata/DLadutkodb/ts_sa_fct_sales_01.dat'
size 150M
    autoextend on next 50M
logging
segment space management auto
extent management local;

create user DM_FCT_SALES
identified by "%PWD%"
default tablespace ts_sa_fct_sales_01;

grant connect, resource, create view to DM_FCT_SALES;

-- dimensions tablespaces
-- dim customers
create tablespace ts_sa_dim_customers_01
datafile '/oracle/u02/oradata/DLadutkodb/ts_sa_dim_customers_01.dat'
size 150M
    autoextend on next 50M
logging
segment space management auto
extent management local;

create user DM_CUSTOMERS
identified by "%PWD%"
default tablespace ts_sa_dim_customers_01;

grant connect, resource, create view to DM_CUSTOMERS;

-- dim products
create tablespace ts_sa_dim_products_01
datafile '/oracle/u02/oradata/DLadutkodb/ts_sa_dim_products.dat'
size 150M
    autoextend on next 50M
logging
segment space management auto
extent management local;

create user DM_PRODUCTS
identified by "%PWD%"
default tablespace ts_sa_dim_products_01;

grant connect, resource, create view to DM_PRODUCTS;

--dim_borrowers

create tablespace ts_sa_dim_borrowers_01
datafile '/oracle/u02/oradata/DLadutkodb/ts_sa_dim_borrowers.dat'
size 150M
    autoextend on next 50M
logging
segment space management auto
extent management local;

create user DM_BORROWERS
identified by "%PWD%"
default tablespace ts_sa_dim_borrowers_01;

grant connect, resource, create view to DM_BORROWERS;

-- dim geo_locations...
--???????




create tablespace ts_sa_date
datafile '/oracle/u02/oradata/DLadutkodb/ts_sa_date.dat'
size 150M
    autoextend on next 50M
logging
segment space management auto
extent management local;

create user SA_DATE
identified by "%PWD%"
default tablespace ts_sa_date;

grant connect, resource to SA_DATE;