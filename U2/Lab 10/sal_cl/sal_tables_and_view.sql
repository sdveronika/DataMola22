DROP TABLE sal_cl.order_fact;

CREATE TABLE sal_cl.order_fact(
order_id NUMBER,
client_id NUMBER NOT NULL,
employee_id NUMBER NOT NULL,
restaurant_id NUMBER NOT NULL,
date_id DATE NOT NULL,
period_id NUMBER NOT NULL,
payment_method_id NUMBER NOT NULL,
dish_id NUMBER NOT NULL,
dish_amount INT NOT NULL,
total_cost DECIMAL (11,2) NOT NULL,
delivery CHAR(1) NOT NULL CHECK (delivery IN ('N','Y')))
PARTITION BY RANGE (date_id) 
--subpartition by hash(client_id) subpartitions 4
( 
PARTITION quarter_1 VALUES LESS THAN(to_date('01.04.2021','DD.MM.YYYY')),
PARTITION quarter_2 VALUES LESS THAN(to_date('01.07.2021','DD.MM.YYYY')),
PARTITION quarter_3 VALUES LESS THAN(to_date('01.10.2021','DD.MM.YYYY')),
PARTITION quarter_4 VALUES LESS THAN(to_date('01.01.2022','DD.MM.YYYY'))
);

----------------------------------------------------------
--DROP VIEW sal_cl.w_dish_dimension;

CREATE OR REPLACE VIEW sal_cl.w_dish_dimension
AS SELECT * FROM dw_data.dish_dimension;

----------------------------------------------------------
--DROP VIEW sal_cl.w_client_dimension;

CREATE OR REPLACE VIEW sal_cl.w_client_dimension
AS SELECT * FROM dw_data.client_dimension;

SELECT * FROM sal_cl.w_client_dimension;
 
----------------------------------------------------------
--DROP VIEW sal_cl.w_restaurant_dimension;

CREATE OR REPLACE VIEW sal_cl.w_restaurant_dimension
AS SELECT * FROM dw_data.restaurant_dimension;

----------------------------------------------------------
--DROP VIEW sal_cl.w_employee_dimension;

CREATE OR REPLACE VIEW sal_cl.w_employee_dimension
AS SELECT * FROM dw_data.employee_dimension;

----------------------------------------------------------
--DROP VIEW sal_cl.w_payment_method_dimension;

CREATE OR REPLACE VIEW sal_cl.w_payment_method_dimension
AS SELECT * FROM dw_data.payment_method_dimension;

--------------------------------------------------------
--DROP VIEW sal_cl.w_dim_gen_period;

CREATE OR REPLACE VIEW sal_cl.w_dim_gen_period 
AS SELECT * FROM dw_data.dim_gen_period;

--------------------------------------------------------
--DROP VIEW sal_cl.w_employee_dim_actual_position;

CREATE OR REPLACE VIEW sal_cl.w_employee_dim_actual_position AS
SELECT first_name|| ' ' || last_name AS employee_name,
       phone,
       email,
       department,
       job_title AS position,
       start_date,
       (TO_DATE(SYSDATE, 'DD/MM/YYYY')-TO_DATE(start_date,'DD/MM/YYYY')) AS num_daya_at_position
FROM dw_data.employee_dimension
WHERE is_active='Y';

--------------------------------------------------------
--DROP VIEW sal_cl.w_employee_dim_work;

CREATE OR REPLACE VIEW sal_cl.w_employee_dim_work AS 
SELECT DISTINCT TRUNC(date_id, 'MM') AS month,
       first_name|| ' ' || last_name AS employee_name,
       job_title AS position,
       COUNT(order_id) AS orders_count_employee,
       SUM(total_cost) AS employee_profit
FROM dw_data.order_fact ord
  RIGHT JOIN dw_data.employee_dimension emp
  ON (ord.employee_id=emp.employee_id)
GROUP BY TRUNC(date_id, 'MM'), first_name|| ' ' || last_name, job_title
ORDER BY 1,2,3,4,5;

--------------------------------------------------------
--DROP VIEW sal_cl.w_restaurant_profit;

CREATE OR REPLACE VIEW sal_cl.w_restaurant_profit AS
SELECT DISTINCT TRUNC(date_id, 'MM') AS month,
       country,
       city,
       SUM (total_cost) AS total_profit,
       SUM (dish_amount) AS total_dish_amount,
       COUNT (order_id) AS total_order_count
FROM dw_data.order_fact ord
  RIGHT JOIN dw_data.dish_dimension dsh
  ON (ord.dish_id=dsh.dish_id)
  RIGHT JOIN dw_data.restaurant_dimension rst
  ON (rst.restaurant_id=ord.restaurant_id)
GROUP BY TRUNC(date_id, 'MM'),country,city
ORDER BY 1,4,5,6;

--------------------------------------------------------
--DROP VIEW sal_cl.w_top_dishes;

CREATE OR REPLACE VIEW sal_cl.w_top_dishes AS
SELECT DISTINCT TRUNC(date_id, 'MM') AS month,
       country,
       city,
       dish_name,
       SUM(dish_amount) AS total_dish_amount
FROM dw_data.order_fact ord
  RIGHT JOIN dw_data.dish_dimension dsh
  ON (ord.dish_id=dsh.dish_id)
  RIGHT JOIN dw_data.restaurant_dimension rst
  ON (rst.restaurant_id=ord.restaurant_id)
GROUP BY TRUNC(date_id, 'MM'),country,city, dish_name
ORDER BY 1,2,3,5 DESC;

--------------------------------------------------------
--DROP VIEW sal_cl.w_restaurant_visits;

CREATE OR REPLACE VIEW sal_cl.w_restaurant_visits AS
SELECT DISTINCT TRUNC(date_id, 'MM') AS month,
       country,
       city,
       COUNT(order_id) AS total_visits_count
FROM dw_data.order_fact ord
  RIGHT JOIN dw_data.restaurant_dimension rst
  ON (rst.restaurant_id=ord.restaurant_id)
WHERE delivery='N'
GROUP BY TRUNC(date_id, 'MM'),country,city
ORDER BY 1,4 DESC;
   