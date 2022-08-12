set autotrace on explain;
SELECT /*+ use_merge(e d) gather_plan_statistics */  *
FROM scott.emp e, scott.dept d
WHERE e.deptno = d.deptno

