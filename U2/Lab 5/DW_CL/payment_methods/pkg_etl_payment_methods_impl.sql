alter session set current_schema = sa_restaurants;
GRANT SELECT ON sa_t_payment_method  TO DW_CL;
alter session set current_schema = DW_CL;
select * from sa_restaurants.sa_t_payment_method;

CREATE OR REPLACE PACKAGE body pkg_etl_payment_methods_cl
AS  
  PROCEDURE load_CLEAN_PAYMENT_METHODS
   AS
      CURSOR c_v IS
         SELECT DISTINCT payment_method_name
                       , payment_method_status
           FROM sa_restaurants.sa_t_payment_method
           WHERE payment_method_name IS NOT NULL 
           AND payment_method_status IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE dw_cl.cl_t_payment_method';
      FOR i IN c_v LOOP
         INSERT INTO dw_cl.cl_t_payment_method( 
                        payment_method_name
                       , payment_method_status)
              VALUES ( i.payment_method_name
                       , i.payment_method_status );
         EXIT WHEN c_v%NOTFOUND;
      END LOOP;

      COMMIT;
   END load_CLEAN_PAYMENT_METHODS;
END pkg_etl_payment_methods_cl;
