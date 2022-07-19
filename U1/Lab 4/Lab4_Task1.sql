CREATE TABLE t2 AS 
SELECT TRUNC( rownum / 100 ) id, rpad( rownum,100 ) t_pad 
FROM dual 
CONNECT BY rownum < 100000; 

CREATE INDEX t2_idx1 ON t2 ( id ); 

SELECT BLOCKS FROM user_segments WHERE segment_name = 'T2'; 

SELECT COUNT (DISTINCT (dbms_rowid.rowid_block_number(rowid))) block_ct
FROM t2 ;

SET AUTOTRACE TRACEONLY;
SELECT COUNT( * ) FROM t2 ; 

DELETE FROM t2; 

INSERT INTO t2 ( ID, T_PAD ) 
VALUES (  1,'1' );

SELECT BLOCKS FROM user_segments WHERE segment_name = 'T2'; 

SELECT COUNT (DISTINCT (dbms_rowid.rowid_block_number(rowid))) block_ct
FROM t2 ;

SET AUTOTRACE TRACEONLY;
SELECT COUNT( * ) FROM t2 ;

TRUNCATE TABLE t2;

SELECT BLOCKS FROM user_segments WHERE segment_name = 'T2'; 

SELECT COUNT (DISTINCT (dbms_rowid.rowid_block_number(rowid))) block_ct
FROM t2 ;

SET AUTOTRACE TRACEONLY;
SELECT COUNT( * ) FROM t2 ;