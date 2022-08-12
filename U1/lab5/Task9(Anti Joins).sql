--not exists
set autotrace on explain;
select /*+  gather_plan_statistics not exists ANTIJOIN */ dname
from scott.dept d 
where not exists (select null from scott.emp e
where e.deptno = d.deptno); 

--not in

set autotrace on explain;
select /*+  gather_plan_statistics not in */ dname
from scott.dept d 
where deptno not in 
(select deptno from scott.emp e);

--minus
set autotrace on explain;
select /*+  gather_plan_statistics minus*/  dname
from scott.dept 
where deptno in 
(select deptno from scott.dept minus
    select deptno from scott.dept);
   
--left outer anti join  
set autotrace on explain;
select /*+  gather_plan_statistics left outer */ dname
from scott.dept d, scott.emp e
where d.deptno = e.empno(+)  
and e.deptno is null;