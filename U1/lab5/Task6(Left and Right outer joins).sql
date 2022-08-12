--Left outer JOIN
set autotrace on explain;
select /*+ gather_plan_statistics */ e.ename , e.deptno, e.job, d.dname 
from scott.emp e, scott.dept d
where e.deptno = d.deptno(+);

--Right outer JOIN
set autotrace on explain;
select /*+ gather_plan_statistics */ e.ename , e.deptno, e.job, d.dname 
from scott.emp e, scott.dept d
where e.deptno(+) = d.deptno;