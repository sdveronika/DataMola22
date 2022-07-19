CREATE TABLE emp AS 
SELECT 
  object_id empno,
  object_name ename,
  created hiredate,
  owner job 
FROM all_objects;

ALTER TABLE emp ADD CONSTRAINT emp_pk PRIMARY KEY(empno);

BEGIN
  dbms_stats.gather_table_stats( user, 'EMP', cascade=>true ); 
END; 

CREATE TABLE heap_addresses 
  ( 
    empno REFERENCES emp(empno) ON DELETE CASCADE,
    addr_type VARCHAR2(10),
    street    VARCHAR2(20),
    city      VARCHAR2(20),
    state     VARCHAR2(2),
    zip       NUMBER,
    PRIMARY KEY (empno,addr_type) 
  );
  
  CREATE TABLE iot_addresses 
  ( 
    empno REFERENCES emp(empno) ON DELETE CASCADE,
    addr_type VARCHAR2(10),
    street    VARCHAR2(20),
    city      VARCHAR2(20),
    state     VARCHAR2(2),
    zip       NUMBER,
    PRIMARY KEY (empno,addr_type) 
  ) 
  ORGANIZATION INDEX;
  
INSERT INTO heap_addresses 
SELECT empno, 'WORK' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 

INSERT INTO iot_addresses 
SELECT empno , 'WORK' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 

INSERT INTO heap_addresses 
SELECT empno, 'HOME' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 

INSERT INTO iot_addresses 
SELECT empno, 'HOME' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 

INSERT INTO heap_addresses 
SELECT empno, 'PREV' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 

INSERT INTO iot_addresses 
SELECT empno, 'PREV' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 

INSERT INTO heap_addresses 
SELECT empno, 'SCHOOL' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 

INSERT INTO iot_addresses 
SELECT empno, 'SCHOOL' , '123 main street' , 'Washington' , 'DC' , 20123 FROM emp; 

COMMIT; 

EXEC dbms_stats.gather_table_stats( user, 'HEAP_ADDRESSES' ); 

EXEC dbms_stats.gather_table_stats( user, 'IOT_ADDRESSES' ); 

/*SET AUTOTRACE TRACEONLY;
SET AUTOTRACE OFF;*/

EXPLAIN PLAN FOR
SELECT * FROM emp, heap_addresses 
WHERE emp.empno = heap_addresses.empno 
AND emp.empno   = 42; 
SELECT * FROM TABLE(dbms_xplan.display );

EXPLAIN PLAN FOR
SELECT * FROM emp, iot_addresses 
WHERE emp.empno = iot_addresses.empno 
AND emp.empno   = 42;  
SELECT * FROM TABLE(dbms_xplan.display );

DROP TABLE iot_addresses;

DROP TABLE heap_addresses;

DROP TABLE emp;

