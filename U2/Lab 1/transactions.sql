DROP TABLE sa_orders.sa_t_transaction;

SELECT trunc(order_date, 'MM'),SUM(total_cost) FROM sa_orders.sa_t_transaction
GROUP BY trunc(order_date, 'MM');

CREATE TABLE sa_orders.sa_t_transaction(
--
first_name_c VARCHAR2(20),
last_name_c VARCHAR2(20),
phone_c VARCHAR2(20),
email_c VARCHAR2(40),
street_c VARCHAR2(40),
country_c VARCHAR2(20),
city_c VARCHAR2(20),
client_status CHAR(1) CHECK (client_status IN ('N','Y')),
--
dish_name VARCHAR2(20),
dish_category VARCHAR2(20),
price DECIMAL (10,2),
composition VARCHAR2(150),
weight DECIMAL (10,2),
dish_status CHAR(2) CHECK (dish_status IN ('N','Y')),
--
phone_r VARCHAR2(20),
email_r VARCHAR2(40),
street_r VARCHAR2(40),
country_r VARCHAR2(20),
city_r VARCHAR2(20),
building_r INT,
apartment_r INT,
restaurant_status CHAR(1) CHECK (restaurant_status IN ('N','Y')),
--
first_name_e VARCHAR2(20),
last_name_e VARCHAR2(20),
phone_e VARCHAR2(20),
email_e VARCHAR2(40),
department VARCHAR2(20),
job_title VARCHAR2(20),
street_e VARCHAR2(40),
country_e VARCHAR2(20),
city_e VARCHAR2(20),
building_e INT,
apartment_e INT,
employee_status CHAR(1) CHECK (employee_status IN ('N','Y')), 
--
payment_method_name VARCHAR2(20),
payment_method_status CHAR(1) CHECK (payment_method_status IN ('N','Y')),
--
order_date DATE,
total_cost DECIMAL (11,2) NOT NULL,
delivery CHAR(1) NOT NULL CHECK (delivery IN ('N','Y'))
)TABLESPACE ts_sa_restaurants_data_01;

INSERT INTO sa_orders.sa_t_transaction
(first_name_c,
last_name_c,
phone_c,
email_c,
street_c,
country_c,
city_c,
client_status,
dish_name,
dish_category,
price,
composition,
weight,
dish_status,
phone_r,
email_r,
street_r,
country_r,
city_r,
building_r,
apartment_r,
restaurant_status,
first_name_e,
last_name_e,
phone_e,
email_e,
department,
job_title,
street_e,
country_e,
city_e,
building_e,
apartment_e,
employee_status,
payment_method_name,
payment_method_status,
order_date,
total_cost,
delivery)
SELECT c.first_name,
c.last_name,
c.phone,
c.email,
c.street,
c.country,
c.city,
c.client_status,
d.dish_name,
d.dish_category,
d.price,
d.composition,
d.weight,
d.dish_status,
r.phone,
r.email,
r.street,
r.country,
r.city,
r.building,
r.apartment,
r.restaurant_status,
e.first_name,
e.last_name,
e.phone,
e.email,
e.department,
e.job_title,
e.street,
e.country,
e.city,
e.building,
e.apartment,
e.employee_status,
pm.payment_method_name,
pm.payment_method_status,
a.order_date,
TRUNC(DBMS_RANDOM.VALUE( 5, 1500)) AS total_cost,
deliv.delivery
FROM sa_restaurants.sa_t_dish d,
sa_restaurants.sa_t_restaurant r,
sa_clients.sa_t_client c,
sa_restaurants.sa_t_payment_method pm,
sa_restaurants.sa_t_employee e
CROSS JOIN (SELECT 
TRUNC( sd + rn ) order_date
FROM (SELECT 
      TO_DATE( '12/31/2020', 'MM/DD/YYYY' ) sd,
      rownum rn
    FROM dual
    CONNECT BY level <= 365)) a
CROSS JOIN (SELECT delivery FROM (SELECT 1 AS id, 'Y' AS delivery  FROM dual)) deliv;
