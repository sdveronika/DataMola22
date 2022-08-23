DROP TABLE sal_cl.quarter_1_new ;

CREATE TABLE sal_cl.quarter_1_new 
(order_id NUMBER,
client_id NUMBER NOT NULL,
employee_id NUMBER NOT NULL,
restaurant_id NUMBER NOT NULL,
date_id DATE NOT NULL,
period_id NUMBER NOT NULL,
payment_method_id NUMBER NOT NULL,
dish_id NUMBER NOT NULL,
dish_amount INT NOT NULL,
total_cost DECIMAL (11,2) NOT NULL,
delivery CHAR(1) NOT NULL CHECK (delivery IN ('N','Y')));

INSERT INTO sal_cl.quarter_1_new (order_id
                                , client_id
                                , employee_id
                                , restaurant_id
                                , date_id
                                , period_id
                                , payment_method_id
                                , dish_id
                                , dish_amount
                                , total_cost
                                , delivery)
SELECT order_id
      , client_id
      , employee_id
      , restaurant_id
      , date_id
      , period_id
      , payment_method_id
      , dish_id
      , dish_amount
      , total_cost
      , delivery FROM sal_cl.order_fact
                 PARTITION (quarter_1);
                 
SELECT DISTINCT * FROM sal_cl.quarter_1_new
WHERE order_id=270817;

UPDATE sal_cl.quarter_1_new
SET total_cost=total_cost*2,
    dish_amount=dish_amount*2;

ALTER TABLE sal_cl.order_fact EXCHANGE PARTITION quarter_1
WITH TABLE sal_cl.quarter_1_new INCLUDING INDEXES WITHOUT VALIDATION
UPDATE GLOBAL INDEXES;

SELECT * FROM sal_cl.order_fact
WHERE order_id BETWEEN 270817 AND 270821;

SELECT * FROM sal_cl.order_fact
PARTITION (quarter_1);

ALTER TABLE sal_cl.order_fact MERGE PARTITIONS quarter_1, quarter_2 
INTO PARTITION quarter_1_2 TABLESPACE ts_dw_str_cls
COMPRESS UPDATE GLOBAL INDEXES PARALLEL 4;

SELECT * FROM sal_cl.order_fact PARTITION (quarter_1_2);

