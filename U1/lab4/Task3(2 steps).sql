--Step 1:
CREATE UNIQUE INDEX udx_t1 ON t1( t_pad );
--Step 2
set autotrace on;
select t1.* from t1 where t1.t_pad = '1';
drop table t1;
drop INDEX udx_t1;