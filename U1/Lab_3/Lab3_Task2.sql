PURGE RECYCLEBIN;

CREATE TABLE t ( x INT PRIMARY KEY, y CLOB, z BLOB); 

SELECT segment_name, segment_type FROM user_segments; 

DROP TABLE T;

CREATE TABLE t ( x INT PRIMARY KEY, y CLOB, z BLOB) SEGMENT CREATION IMMEDIATE; 

SELECT segment_name, segment_type FROM user_segments;

SELECT DBMS_METADATA.GET_DDL('TABLE','T') FROM dual;
