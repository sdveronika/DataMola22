DROP TABLE sa_restaurants.sa_t_gen_period;

SELECT * FROM sa_restaurants.sa_t_gen_period;

CREATE TABLE sa_restaurants.sa_t_gen_period (
    valid_from     DATE ,
    valid_to       DATE ,
    promotion_name  VARCHAR2(100) ,
    promotion_percent DECIMAL (4,2),
    decription    VARCHAR2(100)
)TABLESPACE ts_sa_restaurants_data_01;

INSERT INTO sa_restaurants.sa_t_gen_period
WITH CTE_FN AS 
(SELECT 1 AS id, TO_DATE('01.01.2022','DD.MM.YYYY') AS valid_from FROM dual 
UNION ALL 
SELECT 2 AS id, TO_DATE('01.02.2022','DD.MM.YYYY') AS valid_from FROM dual
UNION ALL 
SELECT 3 AS id, TO_DATE('01.03.2022','DD.MM.YYYY') AS valid_from FROM dual
UNION ALL 
SELECT 4 AS id, TO_DATE('01.04.2022','DD.MM.YYYY') AS valid_from FROM dual
UNION ALL 
SELECT 5 AS id, TO_DATE('01.05.2022','DD.MM.YYYY') AS valid_from FROM dual),
CTE_TN AS 
(SELECT 1 AS id, TO_DATE('20.01.2022','DD.MM.YYYY') AS valid_to FROM dual 
UNION ALL 
SELECT 2 AS id, TO_DATE('15.02.2022','DD.MM.YYYY') AS valid_to FROM dual
UNION ALL 
SELECT 3 AS id, TO_DATE('10.03.2022','DD.MM.YYYY') AS valid_to FROM dual
UNION ALL 
SELECT 4 AS id, TO_DATE('15.04.2022','DD.MM.YYYY') AS valid_to FROM dual
UNION ALL 
SELECT 5 AS id, TO_DATE('25.05.2022','DD.MM.YYYY') AS valid_to FROM dual),
CTE_PN AS
(SELECT 1 AS id, 'promotion_name_1' AS promotion_name FROM dual 
UNION ALL 
SELECT 2 AS id, 'promotion_name_2' AS promotion_name FROM dual
UNION ALL 
SELECT 3 AS id, 'promotion_name_3' AS promotion_name FROM dual
UNION ALL 
SELECT 4 AS id, 'promotion_name_4' AS promotion_name FROM dual
UNION ALL 
SELECT 5 AS id, 'promotion_name_5' AS promotion_name FROM dual),
CTE_KN AS 
(SELECT 1 AS id, 25 AS promotion_percent FROM dual 
UNION ALL 
SELECT 2 AS id, 15 AS promotion_percent FROM dual
UNION ALL 
SELECT 3 AS id, 10 AS promotion_percent FROM dual
UNION ALL 
SELECT 4 AS id, 5 AS promotion_percent FROM dual
UNION ALL 
SELECT 5 AS id, 20 AS promotion_percent FROM dual),
CTE_DN AS
(SELECT 1 AS id, 'decription_1' AS decription FROM dual 
UNION ALL 
SELECT 2 AS id, 'decription_2' AS decription FROM dual
UNION ALL 
SELECT 3 AS id, 'decription_3' AS decription FROM dual
UNION ALL 
SELECT 4 AS id, 'decription_4' AS decription FROM dual
UNION ALL 
SELECT 5 AS id, 'decription_5' AS decription FROM dual)
SELECT FN.valid_from, TN.valid_to, PN.promotion_name, KN.promotion_percent, DN.decription
FROM CTE_FN FN 
LEFT OUTER JOIN CTE_TN TN ON FN.id=TN.id
LEFT OUTER JOIN CTE_PN PN ON FN.id=PN.id
LEFT OUTER JOIN CTE_KN KN ON FN.id=KN.id
LEFT OUTER JOIN CTE_DN DN ON FN.id=DN.id
;