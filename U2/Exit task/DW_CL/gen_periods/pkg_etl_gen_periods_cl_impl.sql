alter session set current_schema = sa_restaurants;
GRANT SELECT ON sa_t_gen_period  TO DW_CL;
alter session set current_schema = DW_CL;
select * from sa_restaurants.sa_t_gen_period;

CREATE OR REPLACE PACKAGE body pkg_etl_gen_priods_cl
AS  
  PROCEDURE load_CLEAN_GEN_PERIODS
   AS
      CURSOR c_v IS
         SELECT DISTINCT valid_from
                       , valid_to
                       , promotion_name
                       , promotion_percent
                       , decription
           FROM sa_restaurants.sa_t_gen_period
           WHERE valid_from IS NOT NULL 
           AND valid_to IS NOT NULL
           AND promotion_name IS NOT NULL
           AND promotion_percent IS NOT NULL
           AND decription IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE dw_cl.cl_t_gen_period';
      FOR i IN c_v LOOP
         INSERT INTO dw_cl.cl_t_gen_period( 
                         valid_from
                       , valid_to
                       , promotion_name
                       , promotion_percent
                       , decription)
              VALUES ( i.valid_from
                       , i.valid_to
                       , i.promotion_name
                       , i.promotion_percent
                       , i.decription);
         EXIT WHEN c_v%NOTFOUND;
      END LOOP;

      COMMIT;
   END load_CLEAN_GEN_PERIODS;
END pkg_etl_gen_priods_cl;
