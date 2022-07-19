--semijoin
set autotrace on explain;
select /*+  gather_plan_statistics semijoin */ dname
from scott.dept d 
where deptno in (select deptno from scott.emp e);

--no semijoin 
set autotrace on explain;
select /*+  gather_plan_statistics no_semijoin */ dname
from scott.dept d 
where deptno in (select deptno from scott.emp e);

--exists
set autotrace on explain;
select /*+  gather_plan_statistics */ dname
from scott.dept d 
where exists (select null from scott.emp e
where e.deptno = d.deptno); 

--inner join with distinct
set autotrace on explain;
select /*+  gather_plan_statistics inner join with distinct */ distinct dname
from scott.dept d ,scott.emp e
where d.deptno = e.deptno ; 

