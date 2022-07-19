
drop table employees;

--Step 1:
CREATE TABLE employees AS
    SELECT *
      FROM scott.emp;
--Step 2: 
CREATE INDEX idx_emp01 ON employees
      ( empno, ename, job );

--Step 3:  Get trace and statistic of explain plan
set autotrace on;
SELECT /*+INDEX_SS(emp idx_emp01)*/ emp.* FROM employees emp where ename = 'SCOTT';

SELECT /*+FULL*/ emp.* FROM employees emp WHERE ename = 'SCOTT';

--Count of Blocks
SELECT BLOCKS FROM user_segments WHERE segment_name = 'EMPLOYEES';

--Count of Used Blocks
SELECT COUNT(DISTINCT (dbms_rowid.rowid_block_number(rowid))) block_ct FROM EMPLOYEES ;





select * from employees ;

--1
SET autotrace ON;
select blocks from user_segments where segment_name = 'T1';
--2
SET autotrace ON;
select count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct from t1 ;
--3
SET autotrace ON;
SELECT COUNT( * )
FROM t1 ;


--1
SET autotrace ON;
select blocks from user_segments where segment_name = 'T2';
--2
SET autotrace ON;
select count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct from t2 ;
--3
SET autotrace ON;
SELECT COUNT( * )
FROM t2 ;

--1
SET autotrace ON;
select blocks from user_segments where segment_name = 'employees';
--2
SET autotrace ON;
select count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct from employees ;
--3
SET autotrace ON;
SELECT COUNT( * )
FROM employees ;


