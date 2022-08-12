--alter table u_dw_references.t_addresses
--   drop constraint FK_Adress2ADRS_Types;

--drop table u_dw_references.t_addresses cascade constraints;

/*==============================================================*/
/* Table: t_addresses                                         */
/*==============================================================*/
create table u_dw_references.t_addresses 
(
   adress_id          NUMBER(22,0)         not null,
   adress_type_id     NUMBER(22,0)         not null,
   country_id         NUMBER(22,0)         not null,
   zip                VARCHAR(200)         not null,
   state_id           NUMBER(22,0)         not null,
   district_id        NUMBER(22,0)         not null,
   city_id            NUMBER(22,0)         not null,
   street_id          NUMBER(22,0)         not null,
   building_num       VARCHAR2(30 CHAR)    not null,
   apartment_num      VARCHAR2(30 CHAR),
   constraint PK_T_ADDRESSES primary key (adress_id)
         using index tablespace TS_DW_IDX_01
)
tablespace TS_DW_DATA_01;

comment on table u_dw_references.t_addresses is
'Catalogue of System Adresses';

alter table u_dw_references.t_addresses
   add constraint CKC_BUILDING_NUM_T_ADDRES check (building_num = upper(building_num));

alter table u_dw_references.t_addresses
   add constraint CKC_APARTMENT_NUM_T_ADDRES check (apartment_num is null or (apartment_num = upper(apartment_num)));

alter table u_dw_references.t_addresses
   add constraint FK_Adress2ADRS_Types foreign key (adress_type_id)
      references u_dw_references.t_address_types (adress_type_id)
      on delete cascade;