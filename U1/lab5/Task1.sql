set autotrace on explain;
SELECT /*+ gather_plan_statistics */  *
FROM scott.emp e, scott.dept d
WHERE e.deptno = d.deptno
AND d.deptno   = 10