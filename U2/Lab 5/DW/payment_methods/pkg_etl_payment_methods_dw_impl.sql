alter session set current_schema = DW_CL;
GRANT SELECT ON cl_t_payment_method  TO DW_DATA;
alter session set current_schema = DW_DATA;
select * from dw_cl.cl_t_payment_method;

CREATE OR REPLACE PACKAGE body pkg_etl_payment_methods_dw
AS  
  PROCEDURE load_CLEAN_PAYMENT_METHODS_DW
   AS
     BEGIN
     MERGE INTO dw_data.payment_method_dimension A
     USING ( SELECT payment_method_name, payment_method_status
             FROM dw_cl.cl_t_payment_method) B
             ON (a.payment_method_name=b.payment_method_name)
             WHEN MATCHED THEN 
                UPDATE SET a.status=b.payment_method_status
             WHEN NOT MATCHED THEN 
                INSERT (a.payment_method_id, a.payment_method_name, a.status)
                VALUES (SEQ_PAYMENT_METHOD_DIM.NEXTVAL, b.payment_method_name, b.payment_method_status);
     COMMIT;
   END load_CLEAN_PAYMENT_METHODS_DW;
   
   PROCEDURE load_CLEAN_PAYMENT_METHODS_DW_with_to_refcursor_func
   AS
     BEGIN 
     DECLARE 
       cursor_id NUMBER (25);
       cur_count NUMBER (38);
       quary_cur VARCHAR2(2000);
       TYPE ref_crsr IS REF CURSOR;
       ref_cursor ref_crsr;
       TYPE type_rec IS RECORD
	   (  payment_method_name  VARCHAR2 ( 100 )
	    , status char(1)
        , payment_method_id  INT
	   );
       one_record type_rec;
       
     BEGIN 
     quary_cur:= 'SELECT payment_method_name, status, payment_method_id FROM
                        (SELECT source.payment_method_name AS payment_method_name, 
                         source.payment_method_status AS status,
                         stage.payment_method_id AS payment_method_id
                  FROM dw_cl.cl_t_payment_method source
                  LEFT JOIN dw_data.payment_method_dimension stage
                  ON (source.payment_method_name=stage.payment_method_name))';
                  
      cursor_id:=DBMS_SQL.open_cursor;
      
      DBMS_SQL.PARSE(cursor_id, quary_cur, DBMS_SQL.NATIVE);
      
      cur_count:= DBMS_SQL.EXECUTE(cursor_id);
      
      ref_cursor:= DBMS_SQL.TO_REFCURSOR(cursor_id);
      
      LOOP
      FETCH ref_cursor INTO one_record;
      EXIT WHEN ref_cursor%NOTFOUND;
      IF (one_record.payment_method_id IS NULL) THEN
                INSERT INTO dw_data.payment_method_dimension(payment_method_id, 
                                                             payment_method_name, 
                                                             status)
                VALUES (SEQ_PAYMENT_METHOD_DIM.NEXTVAL,
                        one_record.payment_method_name, 
                        one_record.status
                        ); 
      END IF;
      END LOOP;
    COMMIT;
    END;
   END load_CLEAN_PAYMENT_METHODS_DW_with_to_refcursor_func;
   
   PROCEDURE load_CLEAN_PAYMENT_METHODS_DW_with_to_cursor_number_func
   AS
  BEGIN
    DECLARE 
     TYPE curtype IS REF CURSOR;
     src_cur   curtype;
     curid     NUMBER;
     desctab   DBMS_SQL.DESC_TAB;
     colcnt    NUMBER;
     payment_method_name VARCHAR(20);
     status CHAR(1);
     payment_method_id NUMBER;
     sql_stmt VARCHAR2(2000);
     
     BEGIN
     sql_stmt:= 'SELECT payment_method_name, status, payment_method_id FROM
                        (SELECT source.payment_method_name AS payment_method_name, 
                         source.payment_method_status AS status,
                         stage.payment_method_id AS payment_method_id
                  FROM dw_cl.cl_t_payment_method source
                  LEFT JOIN dw_data.payment_method_dimension stage
                  ON (source.payment_method_name=stage.payment_method_name))';
                
      OPEN src_cur FOR sql_stmt;
      
      curid := DBMS_SQL.TO_CURSOR_NUMBER(src_cur);
      
      DBMS_SQL.DESCRIBE_COLUMNS(curid, colcnt, desctab);
            
      FOR i IN 1 .. colcnt LOOP
    IF desctab(i).col_type = 2 THEN
      DBMS_SQL.DEFINE_COLUMN(curid, i,payment_method_id );
    ELSIF desctab(i).col_type = 96 THEN
      DBMS_SQL.DEFINE_COLUMN(curid, i, status,1);
    ELSE
      DBMS_SQL.DEFINE_COLUMN(curid, i, payment_method_name,20);
    END IF;
  END LOOP;

  -- Fetch rows with DBMS_SQL package:  DBMS_SQL.COLUMN_VALUE
  WHILE DBMS_SQL.FETCH_ROWS(curid) > 0 LOOP
    FOR i IN 1 .. colcnt LOOP
       IF desctab(i).col_type = 2 THEN
      DBMS_SQL.COLUMN_VALUE(curid, i,payment_method_id );
    ELSIF desctab(i).col_type = 96 THEN
      DBMS_SQL.COLUMN_VALUE(curid, i, status);
    ELSE
      DBMS_SQL.COLUMN_VALUE(curid, i, payment_method_name);
    END IF;
    END LOOP;
    IF(payment_method_id IS NULL) THEN
    INSERT INTO dw_data.payment_method_dimension(payment_method_id, 
                                                 payment_method_name, 
                                                 status)
                VALUES (SEQ_PAYMENT_METHOD_DIM.NEXTVAL,
                        payment_method_name, 
                        status); 
    END IF;
  END LOOP;
  END;
   END load_CLEAN_PAYMENT_METHODS_DW_with_to_cursor_number_func;
   
END pkg_etl_payment_methods_dw;


