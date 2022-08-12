set autotrace on explain;
select /*+ gather_plan_statistics */ e.ename, e.deptno, e.job, d.dname 
    from scott.emp e
    full outer join
    scott.dept d 
    on(e.deptno = d.deptno);
    