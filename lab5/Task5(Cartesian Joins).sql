set autotrace on explain;
SELECT /*+ gather_plan_statistics */ * 
  FROM scott.emp, scott.dept