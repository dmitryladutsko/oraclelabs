set autotrace on explain;
SELECT /*+  gather_plan_statistics USE_HASH (e d) */  *
FROM scott.emp e, scott.dept d
WHERE e.deptno = d.deptno