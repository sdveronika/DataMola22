DROP TABLE sa_restaurants.sa_t_dish;

CREATE TABLE sa_restaurants.sa_t_dish(
dish_name VARCHAR2(20),
dish_category VARCHAR2(20),
price DECIMAL (10,2),
composition VARCHAR2(150),
weight DECIMAL (10,2),
dish_status CHAR(2) CHECK (dish_status IN ('N','Y'))
)TABLESPACE ts_sa_restaurants_data_01;

SELECT * FROM sa_restaurants.sa_t_dish;

INSERT INTO sa_restaurants.sa_t_dish
WITH CTE_FN AS (SELECT 1 AS id, 'chebupelli' AS dish_name FROM dual 
UNION ALL 
SELECT 2 AS id, 'pasta' AS dish_name FROM dual
UNION ALL 
SELECT 3 AS id, 'soup' AS dish_name FROM dual
UNION ALL 
SELECT 4 AS id, 'pizza' AS dish_name FROM dual
UNION ALL 
SELECT 5 AS id, 'greek salad' AS dish_name FROM dual
--UNION ALL 
--SELECT 6 AS id, 'khachapuri' AS dish_name FROM dual
--UNION ALL 
--SELECT 7 AS id, 'khinkali' AS dish_name FROM dual
--UNION ALL 
--SELECT 8 AS id, 'rice with vegetables' AS dish_name FROM dual
--UNION ALL 
--SELECT 9 AS id, 'pilaf' AS dish_name FROM dual
--UNION ALL 
--SELECT 10 AS id, 'rustic potatoes' AS dish_name FROM dual
),
CTE_LN AS
(SELECT 1 AS id, 'chebupelli ingredients' AS composition FROM dual 
UNION ALL 
SELECT 2 AS id, 'pasta ingredients' AS composition FROM dual
UNION ALL 
SELECT 3 AS id, 'soup ingredients' AS composition FROM dual
UNION ALL 
SELECT 4 AS id, 'pizza ingredients' AS composition FROM dual
UNION ALL 
SELECT 5 AS id, 'greek salad ingredients' AS composition FROM dual
--UNION ALL 
--SELECT 6 AS id, 'khachapuri ingredients' AS composition FROM dual
--UNION ALL 
--SELECT 7 AS id, 'khinkali ingredients' AS composition FROM dual
--UNION ALL 
--SELECT 8 AS id, 'rice with vegetables ingredients' AS composition FROM dual
--UNION ALL 
--SELECT 9 AS id, 'pilaf ingredients' AS composition FROM dual
--UNION ALL 
--SELECT 10 AS id, 'rustic potatoes ingredients' AS composition FROM dual
),
CTE_KN AS 
(
SELECT 1 AS id, 'hot' AS dish_category FROM dual 
UNION ALL 
SELECT 2 AS id, 'hot' AS dish_category FROM dual
UNION ALL 
SELECT 3 AS id, 'hot' AS dish_category FROM dual
UNION ALL 
SELECT 4 AS id, 'hot' AS dish_category FROM dual
UNION ALL 
SELECT 5 AS id, 'appetizer' AS dish_category FROM dual
--UNION ALL 
--SELECT 6 AS id, 'hot' AS dish_category FROM dual
--UNION ALL 
--SELECT 7 AS id, 'hot' AS dish_category FROM dual
--UNION ALL 
--SELECT 8 AS id, 'hot' AS dish_category FROM dual
--UNION ALL 
--SELECT 9 AS id, 'hot' AS dish_category FROM dual
--UNION ALL 
--SELECT 10 AS id, 'hot' AS dish_category FROM dual
), 
CTE_HN AS
(SELECT 1 AS id, 'Y' AS dish_status FROM dual
UNION ALL
SELECT 2 AS id, 'Y' AS dish_status FROM dual
UNION ALL
SELECT 3 AS id, 'Y' AS dish_status FROM dual
UNION ALL
SELECT 4 AS id, 'Y' AS dish_status FROM dual
UNION ALL
SELECT 5 AS id, 'Y' AS dish_status FROM dual
--UNION ALL
--SELECT 6 AS id, 'Y' AS dish_status FROM dual
--UNION ALL
--SELECT 7 AS id, 'Y' AS dish_status FROM dual
--UNION ALL
--SELECT 8 AS id, 'Y' AS dish_status FROM dual
--UNION ALL
--SELECT 9 AS id, 'Y' AS dish_status FROM dual
--UNION ALL
--SELECT 10 AS id, 'Y' AS dish_status FROM dual
)
SELECT FN.dish_name, KN.dish_category,TRUNC(DBMS_RANDOM.VALUE( 5,100)) AS price,  LN.composition,  TRUNC(DBMS_RANDOM.VALUE( 100,1000)) AS weight , HN.dish_status
FROM CTE_FN FN 
LEFT OUTER JOIN CTE_LN LN ON FN.id=LN.id
LEFT OUTER JOIN CTE_KN KN ON FN.id=KN.id
LEFT OUTER JOIN CTE_HN HN ON FN.id=HN.id
;
