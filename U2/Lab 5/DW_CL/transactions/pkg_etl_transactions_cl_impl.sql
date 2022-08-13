alter session set current_schema = sa_orders;
GRANT SELECT ON sa_t_transaction  TO DW_CL;
alter session set current_schema = DW_CL;
select * from sa_orders.sa_t_transaction;

CREATE OR REPLACE PACKAGE body pkg_etl_transactions_cl
AS  
  PROCEDURE load_CLEAN_TRANSACTIONS
   AS
      CURSOR c_v IS
         SELECT DISTINCT first_name_c
                       , last_name_c
                       , phone_c
                       , email_c
                       , street_c
                       , country_c
                       , city_c
                       , client_status
                       , dish_name
                       , dish_category
                       , price
                       , composition
                       , weight
                       , dish_status
                       , phone_r
                       , email_r
                       , street_r
                       , country_r
                       , city_r
                       , building_r
                       , apartment_r
                       , restaurant_status
                       , first_name_e
                       , last_name_e
                       , phone_e
                       , email_e
                       , department
                       , job_title
                       , street_e
                       , country_e
                       , city_e
                       , building_e
                       , apartment_e
                       , employee_status
                       , payment_method_name
                       , payment_method_status
                       , order_date
                       , total_cost
                       , delivery
           FROM sa_orders.sa_t_transaction
           WHERE first_name_c IS NOT NULL 
           AND  last_name_c IS NOT NULL
           AND phone_c IS NOT NULL
           AND email_c IS NOT NULL
           AND street_c IS NOT NULL
           AND country_c IS NOT NULL
           AND city_c IS NOT NULL
           AND client_status IS NOT NULL
           AND dish_name IS NOT NULL
           AND dish_category IS NOT NULL
           AND price IS NOT NULL
           AND composition IS NOT NULL
           AND weight IS NOT NULL
           AND dish_status IS NOT NULL
           AND phone_r IS NOT NULL
           AND email_r IS NOT NULL
           AND street_r IS NOT NULL
           AND country_r IS NOT NULL
           AND city_r IS NOT NULL
           AND building_r IS NOT NULL
           AND apartment_r IS NOT NULL
           AND restaurant_status IS NOT NULL
           AND first_name_e IS NOT NULL
           AND last_name_e IS NOT NULL
           AND phone_e IS NOT NULL
           AND email_e IS NOT NULL
           AND department IS NOT NULL
           AND job_title IS NOT NULL
           AND street_e IS NOT NULL
           AND country_e IS NOT NULL
           AND city_e IS NOT NULL
           AND building_e IS NOT NULL
           AND apartment_e IS NOT NULL
           AND employee_status IS NOT NULL
           AND payment_method_name IS NOT NULL
           AND payment_method_status IS NOT NULL
           AND order_date IS NOT NULL
           AND total_cost IS NOT NULL
           AND delivery IS NOT NULL;
   BEGIN
       EXECUTE IMMEDIATE 'TRUNCATE TABLE dw_cl.cl_t_transaction';
      FOR i IN c_v LOOP
         INSERT INTO dw_cl.cl_t_transaction( 
                       first_name_c
                       , last_name_c
                       , phone_c
                       , email_c
                       , street_c
                       , country_c
                       , city_c
                       , client_status
                       , dish_name
                       , dish_category
                       , price
                       , composition
                       , weight
                       , dish_status
                       , phone_r
                       , email_r
                       , street_r
                       , country_r
                       , city_r
                       , building_r
                       , apartment_r
                       , restaurant_status
                       , first_name_e
                       , last_name_e
                       , phone_e
                       , email_e
                       , department
                       , job_title
                       , street_e
                       , country_e
                       , city_e
                       , building_e
                       , apartment_e
                       , employee_status
                       , payment_method_name
                       , payment_method_status
                       , order_date
                       , total_cost
                       , delivery)
              VALUES ( i.first_name_c
                       , i.last_name_c
                       , i.phone_c
                       , i.email_c
                       , i.street_c
                       , i.country_c
                       , i.city_c
                       , i.client_status
                       , i.dish_name
                       , i.dish_category
                       , i.price
                       , i.composition
                       , i.weight
                       , i.dish_status
                       , i.phone_r
                       , i.email_r
                       , i.street_r
                       , i.country_r
                       , i.city_r
                       , i.building_r
                       , i.apartment_r
                       , i.restaurant_status
                       , i.first_name_e
                       , i.last_name_e
                       , i.phone_e
                       , i.email_e
                       , i.department
                       , i.job_title
                       , i.street_e
                       , i.country_e
                       , i.city_e
                       , i.building_e
                       , i.apartment_e
                       , i.employee_status
                       , i.payment_method_name
                       , i.payment_method_status
                       , i.order_date
                       , i.total_cost
                       , i.delivery);
         EXIT WHEN c_v%NOTFOUND;
      END LOOP;

      COMMIT;
   END load_CLEAN_TRANSACTIONS;
END pkg_etl_transactions_cl;
