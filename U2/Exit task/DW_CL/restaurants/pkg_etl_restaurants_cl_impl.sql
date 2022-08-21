alter session set current_schema = sa_restaurants;
GRANT SELECT ON sa_t_restaurant  TO DW_CL;
alter session set current_schema = DW_CL;
select * from sa_restaurants.sa_t_restaurant;

CREATE OR REPLACE PACKAGE body pkg_etl_restaurants_cl
AS  
  PROCEDURE load_CLEAN_RESTAURANTS
   AS
      CURSOR c_v IS
         SELECT DISTINCT phone
                       , email
                       , street
                       , country
                       , city
                       , building
                       , apartment
                       , restaurant_status
           FROM sa_restaurants.sa_t_restaurant
           WHERE phone IS NOT NULL 
           AND email IS NOT NULL
           AND street IS NOT NULL
           AND country IS NOT NULL
           AND street IS NOT NULL
           AND city IS NOT NULL
           AND building IS NOT NULL
           AND apartment IS NOT NULL
           AND restaurant_status IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE dw_cl.cl_t_restaurant';
      FOR i IN c_v LOOP
         INSERT INTO dw_cl.cl_t_restaurant( 
                       phone
                       , email
                       , street
                       , country
                       , city
                       , building
                       , apartment
                       , restaurant_status)
              VALUES ( i.phone
                       , i.email
                       , i.street
                       , i.country
                       , i.city
                       , i.building
                       , i.apartment
                       , i.restaurant_status);
         EXIT WHEN c_v%NOTFOUND;
      END LOOP;

      COMMIT;
   END load_CLEAN_RESTAURANTS;
END pkg_etl_restaurants_cl;
