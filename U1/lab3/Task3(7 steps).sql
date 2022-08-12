--Step 1:
CREATE TABLE emp AS
SELECT
  object_id empno
, object_name ename
, created hiredate
, owner job
FROM
  all_objects 
/
--Create Index:
alter table emp add constraint emp_pk primary key(empno)
--Calculate Statistic:
begin
  dbms_stats.gather_table_stats( user, 'EMP', cascade=>true );
end;
--Step 2:
CREATE TABLE heap_addresses
  (
    empno REFERENCES emp(empno) ON DELETE CASCADE
  , addr_type VARCHAR2(10)
  , street    VARCHAR2(20)
  , city      VARCHAR2(20)
  , state     VARCHAR2(2)
  , zip       NUMBER
  , PRIMARY KEY (empno,addr_type)
  )
/
--Step 3:
CREATE TABLE iot_addresses
  (
    empno REFERENCES emp(empno) ON DELETE CASCADE
  , addr_type VARCHAR2(10)
  , street    VARCHAR2(20)
  , city      VARCHAR2(20)
  , state     VARCHAR2(2)
  , zip       NUMBER
  , PRIMARY KEY (empno,addr_type)
  )
  ORGANIZATION INDEX
/
--Step 4: Initial inserts:
INSERT INTO heap_addresses
SELECT empno, 'WORK' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
  
INSERT INTO iot_addresses
SELECT empno , 'WORK' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;

INSERT INTO heap_addresses
SELECT empno, 'HOME' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
  
INSERT INTO iot_addresses
SELECT empno, 'HOME' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;

INSERT INTO heap_addresses
SELECT empno, 'PREV' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
  
INSERT INTO iot_addresses
SELECT empno, 'PREV' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;

INSERT INTO heap_addresses
SELECT empno, 'SCHOOL' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;
  
INSERT INTO iot_addresses
SELECT empno, 'SCHOOL' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp;

Commit;

--Step 5: Calculate statistic:

exec dbms_stats.gather_table_stats( user, 'HEAP_ADDRESSES' );
exec dbms_stats.gather_table_stats( user, 'IOT_ADDRESSES' );
--Step 6:  Compare Trace and Performance:

--Explain 1:
set autotrace traceonly;

SELECT *
   FROM emp ,
        heap_addresses
  WHERE emp.empno = heap_addresses.empno
  AND emp.empno   = 42;

--Explain 2:
SELECT *
   FROM emp ,
        iot_addresses
  WHERE emp.empno = iot_addresses.empno
  AND emp.empno   = 42; 

--Step 7: Drop all tables;
drop table emp;
drop table heap_addresses;
drop table iot_addresses;
