GRANT CREATE MATERIALIZED VIEW, CREATE TABLE, CREATE VIEW, QUERY REWRITE TO SA_ORDERS;
alter session set query_rewrite_enabled = true;
grant query rewrite to SA_ORDERS;
grant create materialized view to SA_ORDERS;

GRANT ON COMMIT REFRESH on sa_orders.sa_t_transaction TO SA_ORDERS;
GRANT QUERY REWRITE  TO SA_ORDERS;
GRANT UPDATE ON sa_orders.sa_t_transaction TO SA_ORDERS;

ALTER SESSION SET current_schema=SA_ORDERS;

--DROP MATERIALIZED VIEW LOG ON sa_orders.sa_t_transaction; 

CREATE MATERIALIZED VIEW LOG ON sa_orders.sa_t_transaction
WITH 
rowid, SEQUENCE (first_name_c, last_name_c, phone_c, email_c,
                 street_c, country_c, city_c, client_status,
                 dish_name, dish_category, price, composition,
                 weight, dish_status, phone_r, email_r, street_r,
                 country_r, city_r, building_r, apartment_r, 
                 restaurant_status, first_name_e, last_name_e,
                 phone_e, email_e, department, job_title,
                 street_e, country_e, city_e, building_e, 
                 apartment_e, employee_status, 
                 payment_method_name, payment_method_status,
                 order_date, total_cost, delivery)
INCLUDING NEW VALUES
;           
--DROP MATERIALIZED VIEW SA_ORDERS.mv_daily_profit;

CREATE MATERIALIZED VIEW SA_ORDERS.mv_daily_profit
PARALLEL
BUILD IMMEDIATE
REFRESH COMPLETE ON COMMIT
ENABLE QUERY REWRITE
AS
SELECT TRUNC ( order_date, 'DD' ) AS order_date, country_r, city_r,
SUM(total_cost) AS profit
FROM sa_orders.sa_t_transaction 
GROUP BY TRUNC ( order_date, 'DD' ), country_r,  city_r;


SELECT * FROM mv_daily_profit
ORDER BY 1,2;

UPDATE sa_orders.sa_t_transaction 
SET total_cost=total_cost/2
WHERE country_r='Russia';

COMMIT;