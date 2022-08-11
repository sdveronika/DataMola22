--DROP USER dw_cl CASCADE;
--DROP TABLESPACE ts_dw_cl INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;

CREATE TABLESPACE ts_dw_cl
DATAFILE '/oracle/u02/oradata/VSadovskaiadb/db_ts_dw_cl.dat'
SIZE 200M
AUTOEXTEND ON NEXT 100M
SEGMENT SPACE MANAGEMENT AUTO;
 
CREATE USER dw_cl
IDENTIFIED BY "%PWD%"
DEFAULT TABLESPACE ts_dw_cl;

GRANT CONNECT,RESOURCE, CREATE VIEW TO dw_cl;
GRANT UNLIMITED TABLESPACE TO dw_cl;

--------------------------------------------------------------------------------

--DROP TABLE dw_cl.cl_t_client;

CREATE TABLE dw_cl.cl_t_client(
first_name VARCHAR2(20) NOT NULL,
last_name VARCHAR2(20) NOT NULL,
phone VARCHAR2(20) NOT NULL,
email VARCHAR2(40) NOT NULL,
street VARCHAR2(40) NOT NULL,
country VARCHAR2(20) NOT NULL,
city VARCHAR2(20) NOT NULL,
client_status CHAR(1)NOT NULL CHECK (client_status IN ('N','Y'))
)TABLESPACE ts_dw_cl;

--------------------------------------------------------------------------------

--DROP TABLE dw_cl.cl_t_dish;

CREATE TABLE dw_cl.cl_t_dish(
dish_name VARCHAR2(20) NOT NULL,
dish_category VARCHAR2(20) NOT NULL,
price DECIMAL (10,2) NOT NULL,
composition VARCHAR2(150) NOT NULL,
weight DECIMAL (10,2) NOT NULL,
dish_status CHAR(1) NOT NULL CHECK (dish_status IN ('N','Y'))
)TABLESPACE ts_dw_cl;

--------------------------------------------------------------------------------

--DROP TABLE dw_cl.cl_t_employee;

CREATE TABLE dw_cl.cl_t_employee(
first_name VARCHAR2(20) NOT NULL,
last_name VARCHAR2(20) NOT NULL,
phone VARCHAR2(20) NOT NULL,
email VARCHAR2(40) NOT NULL,
department VARCHAR2(20) NOT NULL,
job_title VARCHAR2(20)NOT NULL,
street VARCHAR2(40) NOT NULL,
country VARCHAR2(20) NOT NULL,
city VARCHAR2(20) NOT NULL,
building INT NOT NULL,
apartment INT NOT NULL,
employee_status CHAR(1) NOT NULL CHECK (employee_status IN ('N','Y'))) 
TABLESPACE ts_dw_cl;

--------------------------------------------------------------------------------

--DROP TABLE dw_cl.cl_t_gen_period;

CREATE TABLE dw_cl.cl_t_gen_period (
    valid_from     DATE NOT NULL,
    valid_to       DATE NOT NULL,
    promotion_name  VARCHAR2(100) NOT NULL,
    promotion_percent DECIMAL (4,2) NOT NULL,
    decription    VARCHAR2(100) NOT NULL
)TABLESPACE ts_dw_cl;

--------------------------------------------------------------------------------

--DROP TABLE dw_cl.cl_t_payment_method;

CREATE TABLE dw_cl.cl_t_payment_method(
payment_method_name VARCHAR2(20) NOT NULL,
payment_method_status CHAR(1) NOT NULL CHECK (payment_method_status IN ('N','Y'))
) TABLESPACE ts_dw_cl;

--------------------------------------------------------------------------------

--DROP TABLE dw_cl.cl_t_restaurant;

CREATE TABLE dw_cl.cl_t_restaurant(
phone VARCHAR2(20) NOT NULL,
email VARCHAR2(40) NOT NULL,
street VARCHAR2(40) NOT NULL,
country VARCHAR2(20) NOT NULL,
city VARCHAR2(20) NOT NULL,
building INT NOT NULL,
apartment INT NOT NULL,
restaurant_status CHAR(1) NOT NULL CHECK (restaurant_status IN ('N','Y'))
)TABLESPACE ts_dw_cl;

--------------------------------------------------------------------------------

--DROP TABLE dw_cl.cl_t_transaction;

SELECT order_date FROM dw_cl.cl_t_transaction;

CREATE TABLE dw_cl.cl_t_transaction(
--
first_name_c VARCHAR2(20) NOT NULL,
last_name_c VARCHAR2(20) NOT NULL,
phone_c VARCHAR2(20) NOT NULL,
email_c VARCHAR2(40) NOT NULL,
street_c VARCHAR2(40) NOT NULL,
country_c VARCHAR2(20) NOT NULL,
city_c VARCHAR2(20) NOT NULL,
client_status CHAR(1) NOT NULL CHECK (client_status IN ('N','Y')),
--
dish_name VARCHAR2(20) NOT NULL,
dish_category VARCHAR2(20) NOT NULL,
price DECIMAL (10,2) NOT NULL,
composition VARCHAR2(150) NOT NULL,
weight DECIMAL (10,2) NOT NULL,
dish_status CHAR(2) NOT NULL CHECK (dish_status IN ('N','Y')),
--
phone_r VARCHAR2(20) NOT NULL,
email_r VARCHAR2(40) NOT NULL,
street_r VARCHAR2(40) NOT NULL,
country_r VARCHAR2(20) NOT NULL,
city_r VARCHAR2(20) NOT NULL,
building_r INT NOT NULL,
apartment_r INT NOT NULL,
restaurant_status CHAR(1) NOT NULL CHECK (restaurant_status IN ('N','Y')),
--
first_name_e VARCHAR2(20) NOT NULL,
last_name_e VARCHAR2(20) NOT NULL,
phone_e VARCHAR2(20) NOT NULL,
email_e VARCHAR2(40) NOT NULL,
department VARCHAR2(20) NOT NULL,
job_title VARCHAR2(20) NOT NULL,
street_e VARCHAR2(40) NOT NULL,
country_e VARCHAR2(20) NOT NULL,
city_e VARCHAR2(20) NOT NULL,
building_e INT NOT NULL,
apartment_e INT NOT NULL,
employee_status CHAR(1) NOT NULL CHECK (employee_status IN ('N','Y')), 
--
payment_method_name VARCHAR2(20) NOT NULL,
payment_method_status CHAR(1) NOT NULL CHECK (payment_method_status IN ('N','Y')),
--
order_date DATE NOT NULL,
total_cost DECIMAL (11,2) NOT NULL,
delivery CHAR(1) NOT NULL CHECK (delivery IN ('N','Y'))
)TABLESPACE ts_dw_cl;