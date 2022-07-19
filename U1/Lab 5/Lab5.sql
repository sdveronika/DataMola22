--Task 1
SET AUTOTRACE OFF;
SELECT COUNT(*) FROM emp 
WHERE empno=7839;

SET AUTOTRACE ON;
SELECT COUNT(*) FROM emp 
WHERE empno=7839;

SET AUTOTRACE ON EXPLAIN;
SELECT COUNT(*) FROM emp 
WHERE empno=7839;

SET AUTOTRACE ON STATISTICS;
SELECT COUNT(*) FROM emp 
WHERE empno=7839;

SET AUTOTRACE ON EXPLAIN STATISTICS;
SELECT COUNT(*) FROM emp 
WHERE empno=7839;

--Task 2
SET AUTOTRACE ON EXPLAIN;
SELECT * FROM emp e, dept d
WHERE e.deptno=d.deptno
AND d.deptno=10;
SELECT * FROM TABLE(dbms_xpalin.dispaly);

--Task 3
SET AUTOTRACE ON EXPLAIN;
SELECT /*+ USE_MERGE(dept emp) */ *
FROM dept, emp
WHERE emp.deptno=dept.deptno;
SELECT * FROM TABLE(dbms_xpalin.dispaly);

--Task 4
SET AUTOTRACE ON EXPLAIN;
SELECT /*+ USE_HASH(dept emp) */ *
FROM dept, emp
WHERE emp.deptno=dept.deptno;
SELECT * FROM TABLE(dbms_xpalin.dispaly);

--Task 5
SET AUTOTRACE ON EXPLAIN;
SELECT * FROM dept, emp;
SELECT * FROM TABLE(dbms_xpalin.dispaly);  

--Task 6
CREATE TABLE a AS 
SELECT * FROM EMP
WHERE deptno IN (10,20);

CREATE TABLE b AS 
SELECT * FROM EMP
WHERE deptno IN (20,30);

SET AUTOTRACE ON EXPLAIN;
SELECT * FROM a 
RIGHT OUTER JOIN b
ON (a.deptno=b.deptno);
SELECT * FROM TABLE(dbms_xpalin.dispaly); 

SET AUTOTRACE ON EXPLAIN;
SELECT * FROM a 
LEFT OUTER JOIN b
ON (a.deptno=b.deptno);
SELECT * FROM TABLE(dbms_xpalin.dispaly); 

--Task 7
SET AUTOTRACE ON EXPLAIN;
SELECT * FROM a 
FULL OUTER JOIN b
ON (a.deptno=b.deptno);
SELECT * FROM TABLE(dbms_xpalin.dispaly);

--Task 8
SET AUTOTRACE ON EXPLAIN;
SELECT /*using in*/ ename, job, deptno
FROM a 
WHERE deptno IN (SELECT deptno FROM b);
SELECT * FROM TABLE(dbms_xpalin.dispaly);

SET AUTOTRACE ON EXPLAIN;
SELECT /*using exists*/ ename, job, deptno
FROM a 
WHERE EXISTS (SELECT NULL FROM b
WHERE b.deptno=a.deptno);
SELECT * FROM TABLE(dbms_xpalin.dispaly);

SET AUTOTRACE ON EXPLAIN;
SELECT /*inner join*/ a.ename, a.job, a.deptno
FROM a,b 
WHERE b.empno=a.empno;
SELECT * FROM TABLE(dbms_xpalin.dispaly);

SET AUTOTRACE ON EXPLAIN;
SELECT /*inner join witn distinct*/ a.ename
FROM a,b 
WHERE b.empno=a.empno;
SELECT * FROM TABLE(dbms_xpalin.dispaly);


SET AUTOTRACE ON EXPLAIN;
SELECT /*ugly intersect */ a.ename
FROM a,
(SELECT empno FROM b) d
WHERE b.empno=a.empno;
SELECT * FROM TABLE(dbms_xpalin.dispaly);

SET AUTOTRACE ON EXPLAIN;
SELECT /* ANY subquery */ ename
FROM a
WHERE empno= ANY (SELECT empno FROM b);
SELECT * FROM TABLE(dbms_xpalin.dispaly);

--Task 9
SET AUTOTRACE ON EXPLAIN;
SELECT /* NOT IN */ ename
FROM a 
WHERE empno NOT IN (SELECT empno FROM b);
SELECT * FROM TABLE(dbms_xpalin.dispaly);

SET AUTOTRACE ON EXPLAIN;
SELECT /* NOT EXISTS */ ename
FROM a 
WHERE NOT EXISTS (SELECT NULL FROM b
WHERE b.empno=a.empno);
SELECT * FROM TABLE(dbms_xpalin.dispaly);

SET AUTOTRACE ON EXPLAIN;
SELECT /* MINUS */ ename
FROM a 
WHERE empno IN
(SELECT empno FROM a
MINUS
SELECT empno FROM b);
SELECT * FROM TABLE(dbms_xpalin.dispaly);

SET AUTOTRACE ON EXPLAIN;
SELECT /* LEFT OUTER */ a.ename
FROM a 
LEFT OUTER JOIN b
ON a.empno=b.empno
WHERE b.empno IS NULL;
SELECT * FROM TABLE(dbms_xpalin.dispaly);
