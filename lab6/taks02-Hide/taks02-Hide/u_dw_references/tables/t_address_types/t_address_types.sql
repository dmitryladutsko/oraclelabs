--drop table u_dw_references.t_address_types cascade constraints;

/*==============================================================*/
/* Table: t_address_types                                     */
/*==============================================================*/
create table u_dw_references.t_address_types 
(
   adress_type_id     NUMBER(22,0)         not null,
   adress_type_code   VARCHAR2(30 CHAR)    not null,
   adress_type_desc   VARCHAR2(200 CHAR)   not null,
   constraint PK_T_ADDRESS_TYPES primary key (adress_type_id)
         using index tablespace TS_REFERENCES_IDX_01
)
tablespace TS_REFERENCES_DATA_01;

alter table u_dw_references.t_address_types
   add constraint CKC_ADRESS_TYPE_CODE_T_ADDRES check (adress_type_code = upper(adress_type_code));