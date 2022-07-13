--Step 1: 
  CREATE cluster emp_dept_cluster( deptno NUMBER( 2 ) )
    SIZE 1024 
    STORAGE( INITIAL 100K NEXT 50K );
--Step 2:
CREATE INDEX idxcl_emp_dept on cluster emp_dept_cluster;
---Step 3:
 CREATE TABLE dept
  (
    deptno NUMBER( 2 ) PRIMARY KEY
  , dname  VARCHAR2( 14 )
  , loc    VARCHAR2( 13 )
  )
  cluster emp_dept_cluster ( deptno ) ;
 
 CREATE TABLE emp
  (
    empno NUMBER PRIMARY KEY
  , ename VARCHAR2( 10 )
  , job   VARCHAR2( 9 )
  , mgr   NUMBER
  , hiredate DATE
  , sal    NUMBER
  , comm   NUMBER
  , deptno NUMBER( 2 ) REFERENCES dept( deptno )
  )
  cluster emp_dept_cluster ( deptno ) ;
  
--Step 4(Extra insert not to use Scott schema):

INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES
    (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES
    (40,'OPERATIONS','BOSTON');
INSERT INTO EMP VALUES
(7369,'SMITH','CLERK',7902,to_date('17-12-1980','dd-mm-yyyy'),800,NULL,20);
INSERT INTO EMP VALUES
(7499,'ALLEN','SALESMAN',7698,to_date('20-2-1981','dd-mm-yyyy'),1600,300,30);
INSERT INTO EMP VALUES
(7521,'WARD','SALESMAN',7698,to_date('22-2-1981','dd-mm-yyyy'),1250,500,30);
INSERT INTO EMP VALUES
(7566,'JONES','MANAGER',7839,to_date('2-4-1981','dd-mm-yyyy'),2975,NULL,20);
INSERT INTO EMP VALUES
(7654,'MARTIN','SALESMAN',7698,to_date('28-9-1981','dd-mm-yyyy'),1250,1400,30);
INSERT INTO EMP VALUES
(7698,'BLAKE','MANAGER',7839,to_date('1-5-1981','dd-mm-yyyy'),2850,NULL,30);
INSERT INTO EMP VALUES
(7844,'TURNER','SALESMAN',7698,to_date('8-9-1981','dd-mm-yyyy'),1500,0,30);
INSERT INTO EMP VALUES
(7900,'JAMES','CLERK',7698,to_date('3-12-1981','dd-mm-yyyy'),950,NULL,30);
INSERT INTO EMP VALUES
(7902,'FORD','ANALYST',7566,to_date('3-12-1981','dd-mm-yyyy'),3000,NULL,20);
commit;

--Step 5:
SELECT *
   FROM
  (
     SELECT dept_blk, emp_blk, CASE WHEN dept_blk <> emp_blk THEN '*' END flag, deptno
       FROM
      (
         SELECT dbms_rowid.rowid_block_number( dept.rowid ) dept_blk, dbms_rowid.rowid_block_number( emp.rowid ) emp_blk, dept.deptno
           FROM emp , dept
          WHERE emp.deptno = dept.deptno
      )
  )
ORDER BY deptno
--Step 6: Drop all tables;

drop table dept;
drop table emp;
drop cluster emp_dept_cluster;