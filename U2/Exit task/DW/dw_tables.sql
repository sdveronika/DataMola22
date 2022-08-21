--DROP TABLESPACE ts_dw_data_01 INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
--DROP USER dw_data CASCADE;

CREATE TABLESPACE ts_dw_data_01
DATAFILE '/oracle/u02/oradata/VSadovskaiadb/db_ts_dw_data_01.dat'
SIZE 200M
AUTOEXTEND ON NEXT 100M
SEGMENT SPACE MANAGEMENT AUTO;
 
CREATE USER dw_data
IDENTIFIED BY "%PWD%"
DEFAULT TABLESPACE ts_dw_data_01;

GRANT CONNECT,RESOURCE TO dw_data;

--------------------------------------------------------------------------------
DROP TABLE dw_data.order_fact;

CREATE TABLE dw_data.order_fact(
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
delivery CHAR(1) NOT NULL CHECK (delivery IN ('N','Y')),
CONSTRAINT ORDER_ID_PK PRIMARY KEY ( order_id ) ENABLE)
PARTITION BY RANGE (date_id) 
subpartition by hash(client_id) subpartitions 4
( 
PARTITION quarter_1 VALUES LESS THAN(to_date('01.04.2021','DD.MM.YYYY')) 
    ( 
    subpartition quarter_1_sub_1, 
    subpartition quarter_1_sub_2,
    subpartition quarter_1_sub_3,
    subpartition quarter_1_sub_4 
    ), 
PARTITION quarter_2 VALUES LESS THAN(to_date('01.07.2021','DD.MM.YYYY'))  
    ( 
    subpartition quarter_2_sub_1, 
    subpartition quarter_2_sub_2,
    subpartition quarter_2_sub_3,
    subpartition quarter_2_sub_4 
    ), 
PARTITION quarter_3 VALUES LESS THAN(to_date('01.10.2021','DD.MM.YYYY'))  
    ( 
    subpartition quarter_3_sub_1, 
    subpartition quarter_3_sub_2,
    subpartition quarter_3_sub_3,
    subpartition quarter_3_sub_4 
    ),
PARTITION quarter_4 VALUES LESS THAN(to_date('01.01.2022','DD.MM.YYYY'))  
    ( 
    subpartition quarter_4_sub_1, 
    subpartition quarter_4_sub_2,
    subpartition quarter_4_sub_3,
    subpartition quarter_4_sub_4 
    ) 
);

ALTER TABLE dw_data.order_fact
ADD CONSTRAINT client_fk
    FOREIGN KEY (client_id)
    REFERENCES dw_data.client_dimension(client_id);

ALTER TABLE dw_data.order_fact
ADD CONSTRAINT employee_fk
    FOREIGN KEY (employee_id)
    REFERENCES dw_data.employee_dimension(employee_id); 
    
ALTER TABLE dw_data.order_fact
ADD CONSTRAINT restaurant_fk
    FOREIGN KEY (restaurant_id)
    REFERENCES dw_data.restaurant_dimension(restaurant_id); 
    
ALTER TABLE dw_data.order_fact
ADD CONSTRAINT period_fk
    FOREIGN KEY (period_id)
    REFERENCES dw_data.dim_gen_period(period_id);
    
ALTER TABLE dw_data.order_fact
ADD CONSTRAINT payment_method_fk
    FOREIGN KEY (payment_method_id)
    REFERENCES dw_data.payment_method_dimension(payment_method_id); 
    
ALTER TABLE dw_data.order_fact
ADD CONSTRAINT dish_fk
    FOREIGN KEY (dish_id)
    REFERENCES dw_data.dish_dimension(dish_id);
    
DROP SEQUENCE SEQ_ORDER_FACT;
CREATE SEQUENCE SEQ_ORDER_FACT
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
----------------------------------------------------------
--DROP TABLE dw_data.dish_dimension;

CREATE TABLE dw_data.dish_dimension(
dish_id NUMBER,
dish_name VARCHAR2(20) NOT NULL,
dish_category VARCHAR2(20) NOT NULL,
price DECIMAL (10,2) NOT NULL,
composition VARCHAR2(150) NOT NULL,
weight DECIMAL (10,2) NOT NULL,
status CHAR(1) NOT NULL CHECK (status IN ('N','Y')),
CONSTRAINT DISH_ID_PK PRIMARY KEY ( dish_id ) ENABLE);

DROP SEQUENCE SEQ_DISH_DIM;
CREATE SEQUENCE SEQ_DISH_DIM
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
----------------------------------------------------------
--DROP TABLE dw_data.client_dimension;

CREATE TABLE dw_data.client_dimension(
client_id NUMBER,
first_name VARCHAR2(20) NOT NULL,
last_name VARCHAR2(20) NOT NULL,
phone VARCHAR2(20) NOT NULL,
email VARCHAR2(40) NOT NULL,
street VARCHAR2(40) NOT NULL,
country VARCHAR2(20) NOT NULL,
city VARCHAR2(20) NOT NULL,
status CHAR(1) NOT NULL CHECK (status IN ('N','Y')),
CONSTRAINT CLIENT_UNIQUE UNIQUE (phone, email),
CONSTRAINT CLIENT_ID_PK PRIMARY KEY ( client_id ) ENABLE);

DROP SEQUENCE SEQ_CLIENT_DIM;
CREATE SEQUENCE SEQ_CLIENT_DIM
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;
 
----------------------------------------------------------
--DROP TABLE dw_data.restaurant_dimension;

CREATE TABLE dw_data.restaurant_dimension(
restaurant_id NUMBER,
phone VARCHAR2(20) NOT NULL,
email VARCHAR2(40) NOT NULL,
address VARCHAR2(40) NOT NULL,
country VARCHAR2(20) NOT NULL,
city VARCHAR2(20) NOT NULL,
building INT,
apartment INT,
status CHAR(1) NOT NULL CHECK (status IN ('N','Y')),
CONSTRAINT RESTAURANT_UNIQUE UNIQUE (phone, email),
CONSTRAINT RESTAURANT_ID_PK PRIMARY KEY ( restaurant_id ) ENABLE);

DROP SEQUENCE SEQ_RESTAURANT_DIM;
CREATE SEQUENCE SEQ_RESTAURANT_DIM
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

----------------------------------------------------------
--DROP TABLE dw_data.employee_dimension;

SELECT * FROM dw_data.employee_dimension;

CREATE TABLE dw_data.employee_dimension(
employee_id NUMBER,
first_name VARCHAR2(20) NOT NULL,
last_name VARCHAR2(20) NOT NULL,
phone VARCHAR2(20) NOT NULL,
email VARCHAR2(40) NOT NULL,
department VARCHAR2(20) NOT NULL,
job_title VARCHAR2(20) NOT NULL,
address VARCHAR2(40) NOT NULL,
country VARCHAR2(20) NOT NULL,
city VARCHAR2(20) NOT NULL,
building INT NOT NULL,
apartment INT NOT NULL,
start_date DATE NOT NULL,
end_date DATE NOT NULL,
is_active CHAR(1) NOT NULL CHECK (is_active IN ('N','Y')),
CONSTRAINT EMPLOYEE_ID_PK PRIMARY KEY ( employee_id ) ENABLE);

DROP SEQUENCE SEQ_EMPLOYEE_DIM;
CREATE SEQUENCE SEQ_EMPLOYEE_DIM
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

----------------------------------------------------------
--DROP TABLE dw_data.payment_method_dimension;

CREATE TABLE dw_data.payment_method_dimension(
payment_method_id NUMBER,
payment_method_name VARCHAR2(20) NOT NULL,
status CHAR(1) NOT NULL CHECK (status IN ('N','Y')),
CONSTRAINT PAYMENT_METHOD_UNIQUE UNIQUE (payment_method_name),
CONSTRAINT PAYMENT_METHOD_ID_PK PRIMARY KEY ( payment_method_id ) ENABLE);

DROP SEQUENCE SEQ_PAYMENT_METHOD_DIM;
CREATE SEQUENCE SEQ_PAYMENT_METHOD_DIM
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

--------------------------------------------------------
--DROP TABLE dw_data.dim_gen_period;

CREATE TABLE dw_data.dim_gen_period (
    period_id      NUMBER,
    valid_from     DATE NOT NULL,
    valid_to       DATE NOT NULL,
    promotion_name  VARCHAR2(100) NOT NULL,
    promotion_percent DECIMAL (5,2) NOT NULL,
    decription    VARCHAR2(100) NOT NULL,
    CONSTRAINT GEN_PERIOD_ID_PK PRIMARY KEY ( period_id) ENABLE
);

DROP SEQUENCE SEQ_GEN_PERIOD_DIM;
CREATE SEQUENCE SEQ_GEN_PERIOD_DIM
 START WITH     1
 INCREMENT BY   1
 NOCACHE
 NOCYCLE;

----------------------------------------------------------
--DROP TABLE dw_data.DIM_geo_locations;

--CREATE TABLE dw_data.DIM_geo_locations (
--   Geo_id             NUMBER(10,0) NOT NULL,
--   Geo_group_id       NUMBER(10) NOT NULL,
--   Geo_group_desc     VARCHAR2(200) NOT NULL,
--   Geo_sub_group_id   NUMBER(10) NOT NULL,
--   Geo_dub_group_desc VARCHAR2(200) NOT NULL,
--   Geo_system_code    NUMBER(10) NOT NULL,
--   Geo_system_desc    VARCHAR2(200) NOT NULL,
--   Geo_region_id      NUMBER(10) NOT NULL,
--   Geo_region_desc    VARCHAR2(200) NOT NULL,
--   Geo_country_code_a2 VARCHAR2(200) NOT NULL,
--   Geo_country_code_a3 VARCHAR2(200) NOT NULL,
--   Geo_country_id     NUMBER(10) NOT NULL,
--   Geo_country_desc   VARCHAR2(200) NOT NULL,
--   CONSTRAINT geo_locations_dimension_PK PRIMARY KEY (Geo_id) ENABLE);

--DROP SEQUENCE SEQ_GEO_LOCATION_DIM;
--CREATE SEQUENCE SEQ_GEO_LOCATION_DIM
-- START WITH     1
-- INCREMENT BY   1
-- NOCACHE
-- NOCYCLE;

----------------------------------------------------------
--DROP TABLE dw_data.date_dimension;

--CREATE TABLE dw_data.date_dimension(
--TIME_ID                       DATE NOT NULL,       
--DAY_NAME                      VARCHAR2(44) NOT NULL,
--DAY_NUMBER_IN_WEEK            VARCHAR2(1) NOT NULL,
--DAY_NUMBER_IN_MONTH           VARCHAR2(2) NOT NULL,
--DAY_NUMBER_IN_YEAR            VARCHAR2(3) NOT NULL,
--CALENDAR_WEEK_NUMBER          VARCHAR2(1) NOT NULL,
--WEEK_ENDING_DATE              DATE NOT NULL,
--CALENDAR_MONTH_NUMBER         VARCHAR2(2) NOT NULL,
--DAYS_IN_CAL_MONTH             VARCHAR2(2) NOT NULL,
--END_OF_CAL_MONTH              DATE NOT NULL,
--CALENDAR_MONTH_NAME           VARCHAR2(32 ) NOT NULL,
--DAYS_IN_CAL_QUARTER           NUMBER NOT NULL,
--BEG_OF_CAL_QUARTER            DATE NOT NULL,
--END_OF_CAL_QUARTER            DATE NOT NULL,
--CALENDAR_QUARTER_NUMBER       VARCHAR2(1) NOT NULL, 
--CALENDAR_YEAR                 VARCHAR2(4) NOT NULL,  
--DAYS_IN_CAL_YEAR              NUMBER NOT NULL,     
--BEG_OF_CAL_YEAR               DATE NOT NULL,      
--END_OF_CAL_YEAR               DATE NOT NULL,
--CONSTRAINT DATE_ID_PK PRIMARY KEY ( time_id ) ENABLE);

--DROP SEQUENCE SEQ_DATE_DIM;
--CREATE SEQUENCE SEQ_DATE_DIM
-- START WITH     1
-- INCREMENT BY   1
-- NOCACHE
-- NOCYCLE;
 