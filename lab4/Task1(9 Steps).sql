--Step 1:
CREATE TABLE t2 AS
SELECT TRUNC( rownum / 100 ) id, rpad( rownum,100 ) t_pad
FROM dual
CONNECT BY rownum < 100000;
--Step 2:
CREATE INDEX t2_idx1 ON t2( id );
--Step 3:
--Block count:
select blocks from user_segments where segment_name = 'T2';
--Used Block Count: 
select count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct from t2 ;
--Explain Plan:
SET autotrace ON;

SELECT COUNT( * )
   FROM t2 ;

--Step 4:  Delete All Rows from table
DELETE FROM t2;
--Step 5:  Repeat Step 3 and collect results.
--1
SET autotrace ON;
select blocks from user_segments where segment_name = 'T2';
--2
    SET autotrace ON;
    select count(distinct (dbms_rowid.rowid_block_number(rowid))) block_ct from t2 ;
--3
SET autotrace ON;
SELECT COUNT( * )
   FROM t2 ;
--Step 6: Insert 1 row
INSERT INTO t2
( ID, T_PAD )
VALUES
(  1,'1' );

COMMIT;
--Step 7:  Repeat Step 3 and collect results.
--Step 8: Truncate Table
TRUNCATE TABLE t2;
