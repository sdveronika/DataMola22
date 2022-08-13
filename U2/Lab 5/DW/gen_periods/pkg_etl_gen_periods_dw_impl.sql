alter session set current_schema = DW_CL;
GRANT SELECT ON cl_t_gen_period  TO DW_DATA;
alter session set current_schema = DW_DATA;
select * from dw_cl.cl_t_gen_period;

CREATE OR REPLACE PACKAGE body pkg_etl_gen_periods_dw
AS  
  PROCEDURE load_CLEAN_GEN_PERIODS_DW
   AS
     BEGIN
     MERGE INTO dw_data.dim_gen_period A
     USING ( SELECT valid_from, valid_to, promotion_name, promotion_percent, decription
             FROM dw_cl.cl_t_gen_period) B
             ON (a.valid_from=b.valid_from AND a.valid_to=b.valid_to AND a.promotion_name=b.promotion_name)
             WHEN MATCHED THEN 
                UPDATE SET a.promotion_percent=b.promotion_percent,
                           a.decription=b.decription
             WHEN NOT MATCHED THEN 
                INSERT (a.period_id, a.valid_from, a.valid_to, a.promotion_name, a.promotion_percent, a.decription)
                VALUES (SEQ_GEN_PERIOD_DIM.NEXTVAL, b.valid_from, b.valid_to, b.promotion_name, b.promotion_percent, b.decription);
     COMMIT;
   END load_CLEAN_GEN_PERIODS_DW;
END pkg_etl_gen_periods_dw;



