alter session set current_schema = DW_DATA;

create table DIM_GEO_LOCATIONS (
   COUNTRY_NAME         CHAR(20),
   COUNTRY_CODE         NUMBER(10),
   COUNTRY_CODE_A2      CHAR(2),
   COUNTRY_CODE_A3      CHAR(3),
   COUNTRY_DESC         VARCHAR2(150),
   REGIO_CODE           NUMBER(10),
   REGIO_NAME           CHAR(20),
   REGIO_DESC           VARCHAR2(150),
   CITY_CODE            NUMBER(10),
   CITY_NAME            CHAR(25),
   CITY_DESC            VARCHAR2(150),
   INSERT_DT            DATE,
   UPDATE_DT            DATE,
   constraint PK_DIM_GEO primary key (GEO_ID)
);
