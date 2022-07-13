CREATE CLUSTER emp_dept_clusterr ( 
   deptno NUMBER( 2  ) ) 
  HASHKEYS 10000 
  HASH IS deptno 
  SIZE 256; 

drop cluster emp_dept_clusterr;