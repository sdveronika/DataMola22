DROP TABLE sa_restaurants.sa_t_payment_method;

SELECT * FROM sa_restaurants.sa_t_payment_method;

CREATE TABLE sa_restaurants.sa_t_payment_method(
payment_method_name VARCHAR2(20),
payment_method_status CHAR(1) CHECK (payment_method_status IN ('N','Y'))
) TABLESPACE ts_sa_restaurants_data_01;

INSERT INTO sa_restaurants.sa_t_payment_method
WITH CTE_FN AS (
SELECT 1 AS id, 'bank card' AS payment_method_name FROM dual 
UNION ALL 
SELECT 2 AS id, 'cash' AS payment_method_name FROM dual),
CTE_SN AS
(SELECT 1 AS id, 'Y' AS payment_method_status FROM dual
UNION ALL
SELECT 2 AS id, 'Y' AS payment_method_status FROM dual)
SELECT FN.payment_method_name, SN.payment_method_status
FROM CTE_FN FN 
LEFT OUTER JOIN CTE_SN SN ON FN.id=SN.id
;

