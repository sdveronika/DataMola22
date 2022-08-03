DROP TABLE sa_restaurants.sa_t_restaurant;

SELECT * FROM sa_restaurants.sa_t_restaurant;

CREATE TABLE sa_restaurants.sa_t_restaurant(
phone VARCHAR2(20),
email VARCHAR2(40),
street VARCHAR2(40),
country VARCHAR2(20),
city VARCHAR2(20),
building INT,
apartment INT,
restaurant_status CHAR(1) CHECK (restaurant_status IN ('N','Y'))
)TABLESPACE ts_sa_restaurants_data_01;

INSERT INTO sa_restaurants.sa_t_restaurant
WITH CTE_FN AS (
SELECT 1 AS id, 'Belarus' AS country FROM dual 
UNION ALL 
SELECT 2 AS id, 'Russia' AS country FROM dual
UNION ALL 
SELECT 3 AS id, 'USA' AS country FROM dual
UNION ALL 
SELECT 4 AS id, 'Ukraine' AS country FROM dual
UNION ALL 
SELECT 5 AS id, 'Poland' AS country FROM dual
--UNION ALL 
--SELECT 6 AS id, 'Denmark' AS country FROM dual
--UNION ALL 
--SELECT 7 AS id, 'England' AS country FROM dual
--UNION ALL 
--SELECT 8 AS id, 'Estonia' AS country FROM dual
--UNION ALL 
--SELECT 9 AS id, 'Latvia' AS country FROM dual
--UNION ALL 
--SELECT 10 AS id, 'Lithuania' AS country FROM dual
--UNION ALL 
--SELECT 11 AS id, 'Austria' AS country FROM dual
--UNION ALL 
--SELECT 12 AS id, 'Germany' AS country FROM dual
--UNION ALL 
--SELECT 13 AS id, 'France' AS country FROM dual
--UNION ALL 
--SELECT 14 AS id, 'Belgium' AS country FROM dual
--UNION ALL 
--SELECT 15 AS id, 'Italy' AS country FROM dual
--UNION ALL 
--SELECT 16 AS id, 'Belarus' AS country FROM dual 
),
CTE_LN AS
(
SELECT 1 AS id, 'Minsk' AS city FROM dual 
UNION ALL 
SELECT 16 AS id, 'Brest' AS city FROM dual 
UNION ALL
SELECT 2 AS id, 'Moscow' AS city FROM dual
UNION ALL 
SELECT 3 AS id, 'New York' AS city FROM dual
UNION ALL 
SELECT 4 AS id, 'Kiev' AS city FROM dual
UNION ALL 
SELECT 5 AS id, 'Warsaw' AS city FROM dual
--UNION ALL 
--SELECT 6 AS id, 'Copenhagen' AS city FROM dual
--UNION ALL 
--SELECT 7 AS id, 'London' AS city FROM dual
--UNION ALL 
--SELECT 8 AS id, 'Tallinn' AS city FROM dual
--UNION ALL 
--SELECT 9 AS id, 'Riga' AS city FROM dual
--UNION ALL 
--SELECT 10 AS id, 'Vilnius' AS city FROM dual
--UNION ALL 
--SELECT 11 AS id, 'Vienna ' AS city FROM dual
--UNION ALL 
--SELECT 12 AS id, 'Berlin' AS city FROM dual
--UNION ALL 
--SELECT 13 AS id, 'Paris' AS city FROM dual
--UNION ALL 
--SELECT 14 AS id, 'Brussels' AS city FROM dual
--UNION ALL 
--SELECT 15 AS id, 'Rome' AS city FROM dual
),
CTE_HN AS
(
SELECT 1 AS id, 'Yesenin' AS street FROM dual 
UNION ALL 
SELECT 16 AS id, 'Zybitskaya' AS street FROM dual 
UNION ALL
SELECT 2 AS id, 'Nikolskaya' AS street FROM dual
UNION ALL 
SELECT 3 AS id, 'Fifth Avenue' AS street FROM dual
UNION ALL 
SELECT 4 AS id, 'Vladimirskaya' AS street FROM dual
UNION ALL 
SELECT 5 AS id, 'Gurchevskaya' AS street FROM dual
--UNION ALL 
--SELECT 6 AS id, 'Gammel Strand' AS street FROM dual
--UNION ALL 
--SELECT 7 AS id, 'Abby' AS street FROM dual
--UNION ALL 
--SELECT 8 AS id, 'D Dunkri' AS street FROM dual
--UNION ALL 
--SELECT 9 AS id, 'Aloyas' AS street FROM dual
--UNION ALL 
--SELECT 10 AS id, 'G Galve' AS street FROM dual
--UNION ALL 
--SELECT 11 AS id, 'Graben ' AS street FROM dual
--UNION ALL 
--SELECT 12 AS id, 'K Kaiser-Friedrich' AS street FROM dual
--UNION ALL 
--SELECT 13 AS id, 'Champs Elysees' AS street FROM dual
--UNION ALL 
--SELECT 14 AS id, 'Antoine Dansaert' AS street FROM dual
--UNION ALL 
--SELECT 15 AS id, 'Via del Corso' AS street FROM dual
),
CTE_SN AS
(SELECT 1 AS id, 'Y' AS restaurant_status FROM dual
UNION ALL
SELECT 2 AS id, 'Y' AS restaurant_status FROM dual
UNION ALL
SELECT 3 AS id, 'Y' AS restaurant_status FROM dual
UNION ALL
SELECT 4 AS id, 'Y' AS restaurant_status FROM dual
UNION ALL
SELECT 5 AS id, 'Y' AS restaurant_status FROM dual
--UNION ALL
--SELECT 6 AS id, 'Y' AS restaurant_status FROM dual
--UNION ALL
--SELECT 7 AS id, 'Y' AS restaurant_status FROM dual
--UNION ALL
--SELECT 8 AS id, 'Y' AS restaurant_status FROM dual
--UNION ALL
--SELECT 9 AS id, 'Y' AS restaurant_status FROM dual
--UNION ALL
--SELECT 10 AS id, 'Y' AS restaurant_status FROM dual
--UNION ALL
--SELECT 11 AS id, 'Y' AS restaurant_status FROM dual
--UNION ALL
--SELECT 12 AS id, 'Y' AS restaurant_status FROM dual
--UNION ALL
--SELECT 13 AS id, 'Y' AS restaurant_status FROM dual
--UNION ALL
--SELECT 14 AS id, 'Y' AS restaurant_status FROM dual
--UNION ALL
--SELECT 15 AS id, 'Y' AS restaurant_status FROM dual
--UNION ALL
--SELECT 16 AS id, 'Y' AS restaurant_status FROM dual
)
SELECT CONCAT('375',TRUNC(DBMS_RANDOM.VALUE( 290000000, 299999999))) AS phone, FN.id || '' || '@mail.ru' AS email, HN.street, FN.country, LN.city,
TRUNC(DBMS_RANDOM.VALUE( 1,100)) AS building, TRUNC(DBMS_RANDOM.VALUE( 1,300)) AS apartment, SN.restaurant_status
FROM CTE_FN FN 
LEFT OUTER JOIN CTE_LN LN ON FN.id=LN.id
LEFT OUTER JOIN CTE_HN HN ON FN.id=HN.id
LEFT OUTER JOIN CTE_SN SN ON FN.id=SN.id
;

--INSERT INTO sa_restaurants.sa_t_restaurant (phone, street, country, city, building, apartment, restaurant_status)
--SELECT phone, street, country, city, building, apartment, restaurant_status FROM(
SELECT r_p_b_a.*, country, city, street, restaurant_status FROM(
SELECT a.*, CONCAT('375',TRUNC(DBMS_RANDOM.VALUE( 290000000, 299999999))) AS phone,
TRUNC(DBMS_RANDOM.VALUE( 1,100)) AS building, TRUNC(DBMS_RANDOM.VALUE( 1,300)) AS apartment,
TRUNC(DBMS_RANDOM.VALUE( 1,15)) AS restaurant_id
FROM (SELECT 
TRUNC( sd + rn ) time_id
FROM (SELECT 
      TO_DATE( '12/31/2020', 'MM/DD/YYYY' ) sd,
      rownum rn
    FROM dual
    CONNECT BY level <= 50)
)a) r_p_b_a
LEFT OUTER JOIN (
SELECT 1 AS id, 'Belarus' AS country FROM dual 
UNION ALL 
SELECT 2 AS id, 'Russia' AS country FROM dual
UNION ALL 
SELECT 3 AS id, 'USA' AS country FROM dual
UNION ALL 
SELECT 4 AS id, 'Ukraine' AS country FROM dual
UNION ALL 
SELECT 5 AS id, 'Poland' AS country FROM dual
UNION ALL 
SELECT 6 AS id, 'Denmark' AS country FROM dual
UNION ALL 
SELECT 7 AS id, 'England' AS country FROM dual
UNION ALL 
SELECT 8 AS id, 'Estonia' AS country FROM dual
UNION ALL 
SELECT 9 AS id, 'Latvia' AS country FROM dual
UNION ALL 
SELECT 10 AS id, 'Lithuania' AS country FROM dual
UNION ALL 
SELECT 11 AS id, 'Austria' AS country FROM dual
UNION ALL 
SELECT 12 AS id, 'Germany' AS country FROM dual
UNION ALL 
SELECT 13 AS id, 'France' AS country FROM dual
UNION ALL 
SELECT 14 AS id, 'Belgium' AS country FROM dual
UNION ALL 
SELECT 15 AS id, 'Italy' AS country FROM dual
UNION ALL 
SELECT 16 AS id, 'Belarus' AS country FROM dual
) r_cn
ON r_p_b_a.restaurant_id=r_cn.id
LEFT OUTER JOIN (
SELECT 1 AS id, 'Minsk' AS city FROM dual 
UNION ALL 
SELECT 16 AS id, 'Brest' AS city FROM dual 
UNION ALL
SELECT 2 AS id, 'Moscow' AS city FROM dual
UNION ALL 
SELECT 3 AS id, 'New York' AS city FROM dual
UNION ALL 
SELECT 4 AS id, 'Kiev' AS city FROM dual
UNION ALL 
SELECT 5 AS id, 'Warsaw' AS city FROM dual
UNION ALL 
SELECT 6 AS id, 'Copenhagen' AS city FROM dual
UNION ALL 
SELECT 7 AS id, 'London' AS city FROM dual
UNION ALL 
SELECT 8 AS id, 'Tallinn' AS city FROM dual
UNION ALL 
SELECT 9 AS id, 'Riga' AS city FROM dual
UNION ALL 
SELECT 10 AS id, 'Vilnius' AS city FROM dual
UNION ALL 
SELECT 11 AS id, 'Vienna ' AS city FROM dual
UNION ALL 
SELECT 12 AS id, 'Berlin' AS city FROM dual
UNION ALL 
SELECT 13 AS id, 'Paris' AS city FROM dual
UNION ALL 
SELECT 14 AS id, 'Brussels' AS city FROM dual
UNION ALL 
SELECT 15 AS id, 'Rome' AS city FROM dual) r_ct
ON r_p_b_a.restaurant_id=r_ct.id
LEFT OUTER JOIN (
SELECT 1 AS id, 'Yesenin' AS street FROM dual 
UNION ALL 
SELECT 1 AS id, 'Zybitskaya' AS street FROM dual 
UNION ALL
SELECT 2 AS id, 'Nikolskaya' AS street FROM dual
UNION ALL 
SELECT 3 AS id, 'Fifth Avenue' AS street FROM dual
UNION ALL 
SELECT 4 AS id, 'Vladimirskaya' AS street FROM dual
UNION ALL 
SELECT 5 AS id, 'Gurchevskaya' AS street FROM dual
UNION ALL 
SELECT 6 AS id, 'Gammel Strand' AS street FROM dual
UNION ALL 
SELECT 7 AS id, 'Abby' AS street FROM dual
UNION ALL 
SELECT 8 AS id, 'D Dunkri' AS street FROM dual
UNION ALL 
SELECT 9 AS id, 'Aloyas' AS street FROM dual
UNION ALL 
SELECT 10 AS id, 'G Galve' AS street FROM dual
UNION ALL 
SELECT 11 AS id, 'Graben ' AS street FROM dual
UNION ALL 
SELECT 12 AS id, 'K Kaiser-Friedrich' AS street FROM dual
UNION ALL 
SELECT 13 AS id, 'Champs Elysees' AS street FROM dual
UNION ALL 
SELECT 14 AS id, 'Antoine Dansaert' AS street FROM dual
UNION ALL 
SELECT 15 AS id, 'Via del Corso' AS street FROM dual) r_ct
ON r_p_b_a.restaurant_id=r_ct.id
LEFT OUTER JOIN 
(SELECT 1 AS id, 'Y' AS restaurant_status FROM dual
UNION ALL
SELECT 2 AS id, 'Y' AS restaurant_status FROM dual
UNION ALL
SELECT 3 AS id, 'Y' AS restaurant_status FROM dual
UNION ALL
SELECT 4 AS id, 'Y' AS restaurant_status FROM dual
UNION ALL
SELECT 5 AS id, 'Y' AS restaurant_status FROM dual
UNION ALL
SELECT 6 AS id, 'Y' AS restaurant_status FROM dual
UNION ALL
SELECT 7 AS id, 'Y' AS restaurant_status FROM dual
UNION ALL
SELECT 8 AS id, 'Y' AS restaurant_status FROM dual
UNION ALL
SELECT 9 AS id, 'Y' AS restaurant_status FROM dual
UNION ALL
SELECT 10 AS id, 'Y' AS restaurant_status FROM dual
UNION ALL
SELECT 11 AS id, 'Y' AS restaurant_status FROM dual
UNION ALL
SELECT 12 AS id, 'Y' AS restaurant_status FROM dual
UNION ALL
SELECT 13 AS id, 'Y' AS restaurant_status FROM dual
UNION ALL
SELECT 14 AS id, 'Y' AS restaurant_status FROM dual
UNION ALL
SELECT 15 AS id, 'Y' AS restaurant_status FROM dual
) r_st
ON r_p_b_a.restaurant_id=r_st.id
--)
;

