--1. Prerequisites:

create tablespace tbs_lab datafile 'db_lab_001.dat' 
size 5M autoextend ON next 5M MAXSIZE 100M;

create user $DLadutko$ identified by 220025220025 default tablespace tbs_lab;

grant connect to DLadutko;
grant resource to DLadutko;

