--Step 1:
Create table t ( x int primary key, y clob, z blob );
drop table t;
--Step 2:
PURGE RECYCLEBIN;
select segment_name, segment_type from user_segments;
--Step 3: 
Create table t
               ( x int primary key,
                 y clob,
                 z blob )
    SEGMENT CREATION IMMEDIATE
   /
--Step 4:
select segment_name, segment_type from user_segments;
--Step 5: 
SELECT DBMS_METADATA.GET_DDL('TABLE','T') FROM dual

