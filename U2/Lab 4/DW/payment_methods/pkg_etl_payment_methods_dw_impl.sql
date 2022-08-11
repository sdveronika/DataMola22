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
END pkg_etl_payment_methods_dw;


