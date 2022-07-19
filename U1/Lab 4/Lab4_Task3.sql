CREATE UNIQUE INDEX udx_t1 ON t1( t_pad );

SELECT t1.*  FROM t1 where t1.t_pad = '1'; 