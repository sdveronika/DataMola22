alter session set current_schema = sa_restaurants;
GRANT SELECT ON sa_t_dish  TO DW_CL;
alter session set current_schema = DW_CL;
select * from sa_restaurants.sa_t_dish;

CREATE OR REPLACE PACKAGE body pkg_etl_dishes_cl
AS  
  PROCEDURE load_CLEAN_DISHES
   AS
      CURSOR c_v1 IS
         SELECT  dish_name
                       , dish_category
                       , price
                       , composition
                       , weight
                       , dish_status
           FROM  sa_restaurants.sa_t_dish
           WHERE dish_name IS NOT NULL 
           AND dish_category IS NOT NULL
           AND price IS NOT NULL
           AND composition IS NOT NULL
           AND weight IS NOT NULL
           AND dish_status IS NOT NULL;
   BEGIN
   EXECUTE IMMEDIATE 'TRUNCATE TABLE dw_cl.cl_t_dish';
      FOR i IN c_v1 LOOP
         INSERT INTO dw_cl.cl_t_dish( 
                         dish_name
                       , dish_category
                       , price
                       , composition
                       , weight
                       , dish_status)
              VALUES ( i.dish_name
                       , i.dish_category
                       , i.price
                       , i.composition
                       , i.weight
                       , i.dish_status);
         EXIT WHEN c_v1%NOTFOUND;
      END LOOP;

      COMMIT;
   END load_CLEAN_DISHES;
END pkg_etl_dishes_cl;
