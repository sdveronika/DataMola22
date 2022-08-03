DROP TABLE sa_restaurants.sa_t_employee;

SELECT * FROM sa_restaurants.sa_t_employee;

CREATE TABLE sa_restaurants.sa_t_employee(
first_name VARCHAR2(20),
last_name VARCHAR2(20),
phone VARCHAR2(20),
email VARCHAR2(40),
department VARCHAR2(20),
job_title VARCHAR2(20),
street VARCHAR2(40),
country VARCHAR2(20),
city VARCHAR2(20),
building INT,
apartment INT,
employee_status CHAR(1) CHECK (employee_status IN ('N','Y'))) 
TABLESPACE ts_sa_restaurants_data_01;

INSERT INTO sa_restaurants.sa_t_employee
WITH CTE_FN AS (
--SELECT 1 AS id, 'Adriana' AS first_name FROM dual 
--UNION ALL 
--SELECT 2 AS id, 'Ada' AS first_name FROM dual
--UNION ALL 
--SELECT 3 AS id, 'Alice' AS first_name FROM dual
--UNION ALL 
--SELECT 4 AS id, 'Alyssa' AS first_name FROM dual
--UNION ALL 
--SELECT 5 AS id, 'Anna' AS first_name FROM dual
--UNION ALL 
--SELECT 6 AS id, 'Christina' AS first_name FROM dual
--UNION ALL 
--SELECT 7 AS id, 'Ñlara' AS first_name FROM dual
--UNION ALL 
--SELECT 8 AS id, 'Veronika' AS first_name FROM dual
--UNION ALL 
--SELECT 9 AS id, 'Eva' AS first_name FROM dual
--UNION ALL 
SELECT 10 AS id, 'Vera' AS first_name FROM dual
UNION ALL 
SELECT 11 AS id, 'Alexandra' AS first_name FROM dual
UNION ALL 
SELECT 12 AS id, 'Rita' AS first_name FROM dual
--UNION ALL 
--SELECT 13 AS id, 'Ian' AS first_name FROM dual
--UNION ALL 
--SELECT 14 AS id, 'Pavel' AS first_name FROM dual
--UNION ALL 
--SELECT 15 AS id, 'Prokhor' AS first_name FROM dual
--UNION ALL 
--SELECT 16 AS id, 'Oleg' AS first_name FROM dual
--UNION ALL 
--SELECT 17 AS id, 'Maxim' AS first_name FROM dual
--UNION ALL 
--SELECT 18 AS id, 'Miron' AS first_name FROM dual
--UNION ALL 
--SELECT 19 AS id, 'Nikita' AS first_name FROM dual
--UNION ALL 
--SELECT 20 AS id, 'Lev' AS first_name FROM dual
--UNION ALL 
--SELECT 21 AS id, 'Konstantin' AS first_name FROM dual
--UNION ALL 
--SELECT 22 AS id, 'Leon' AS first_name FROM dual
--UNION ALL 
--SELECT 23 AS id, 'Miron' AS first_name FROM dual
UNION ALL 
SELECT 24 AS id, 'Ivan' AS first_name FROM dual
UNION ALL 
SELECT 25 AS id, 'Ignat' AS first_name FROM dual
),
CTE_LN AS
(
--SELECT 1 AS id, 'Karnitskaya' AS last_name FROM dual 
--UNION ALL 
--SELECT 2 AS id, 'Alymova' AS last_name FROM dual
--UNION ALL 
--SELECT 3 AS id, 'Lysenko' AS last_name FROM dual
--UNION ALL 
--SELECT 4 AS id, 'Malysheva' AS last_name FROM dual
--UNION ALL 
--SELECT 5 AS id, 'Buynova' AS last_name FROM dual
--UNION ALL 
--SELECT 6 AS id, 'Mayorova' AS last_name FROM dual
--UNION ALL 
--SELECT 7 AS id, 'Zaykova' AS last_name FROM dual
--UNION ALL 
--SELECT 8 AS id, 'Sadovskaya' AS last_name FROM dual
--UNION ALL 
--SELECT 9 AS id, 'Moshko' AS last_name FROM dual
--UNION ALL 
SELECT 10 AS id, 'Lebedeva' AS last_name FROM dual
UNION ALL 
SELECT 11 AS id, 'Etkina' AS last_name FROM dual
UNION ALL 
SELECT 12 AS id, 'Astafyeva' AS last_name FROM dual
--UNION ALL 
--SELECT 13 AS id, 'Astafyev' AS last_name FROM dual
--UNION ALL 
--SELECT 14 AS id, 'Moshko' AS last_name FROM dual
--UNION ALL 
--SELECT 15 AS id, 'Lebedev' AS last_name FROM dual
--UNION ALL 
--SELECT 16 AS id, 'Etkin' AS last_name FROM dual
--UNION ALL 
--SELECT 17 AS id, 'Mayorov' AS last_name FROM dual
--UNION ALL 
--SELECT 18 AS id, 'Buynova' AS last_name FROM dual
--UNION ALL 
--SELECT 19 AS id, 'Malyshev' AS last_name FROM dual
--UNION ALL 
--SELECT 20 AS id, 'Alymov' AS last_name FROM dual
--UNION ALL 
--SELECT 21 AS id, 'Lysenko' AS last_name FROM dual
--UNION ALL 
--SELECT 22 AS id, 'Yerin' AS last_name FROM dual
--UNION ALL 
--SELECT 23 AS id, 'Parfenov' AS last_name FROM dual
UNION ALL 
SELECT 24 AS id, 'Semin' AS last_name FROM dual
UNION ALL 
SELECT 25 AS id, 'Aksenov' AS last_name FROM dual),
CTE_RN AS
(
--SELECT 1 AS id, 'department_name_1' AS department FROM dual 
--UNION ALL
--SELECT 2 AS id, 'department_name_2' AS department FROM dual
--UNION ALL 
--SELECT 3 AS id, 'department_name_3' AS department FROM dual
--UNION ALL 
--SELECT 4 AS id, 'department_name_4' AS department FROM dual
--UNION ALL 
--SELECT 5 AS id, 'department_name_5' AS department FROM dual
--UNION ALL
--SELECT 6 AS id, 'department_name_1' AS department FROM dual
--UNION ALL 
--SELECT 7 AS id, 'department_name_2' AS department FROM dual
--UNION ALL 
--SELECT 8 AS id, 'department_name_3' AS department FROM dual
--UNION ALL 
--SELECT 9 AS id, 'department_name_4' AS department FROM dual
--UNION ALL
SELECT 10 AS id, 'department_name_5' AS department FROM dual
UNION ALL 
SELECT 11 AS id, 'department_name_1' AS department FROM dual
UNION ALL 
--SELECT 12 AS id, 'department_name_2' AS department FROM dual
--UNION ALL 
--SELECT 13 AS id, 'department_name_3' AS department FROM dual
--UNION ALL
--SELECT 14 AS id, 'department_name_4' AS department FROM dual
--UNION ALL 
--SELECT 15 AS id, 'department_name_5' AS department FROM dual
--UNION ALL 
--SELECT 16 AS id, 'department_name_1' AS department FROM dual
--UNION ALL 
--SELECT 17 AS id, 'department_name_2' AS department FROM dual
--UNION ALL
--SELECT 18 AS id, 'department_name_3' AS department FROM dual
--UNION ALL 
--SELECT 19 AS id, 'department_name_4' AS department FROM dual
--UNION ALL 
--SELECT 20 AS id, 'department_name_5' AS department FROM dual
--UNION ALL 
--SELECT 21 AS id, 'department_name_1' AS department FROM dual
--UNION ALL 
--SELECT 22 AS id, 'department_name_2' AS department FROM dual
--UNION ALL 
--SELECT 23 AS id, 'department_name_3' AS department FROM dual
--UNION ALL 
SELECT 24 AS id, 'department_name_4' AS department FROM dual
UNION ALL 
SELECT 25 AS id, 'department_name_5' AS department FROM dual),
CTE_WN AS
(
--SELECT 1 AS id, 'job_title_1' AS job_title FROM dual 
--UNION ALL
--SELECT 2 AS id, 'job_title_1' AS job_title FROM dual
--UNION ALL 
--SELECT 3 AS id, 'job_title_1' AS job_title FROM dual
--UNION ALL 
--SELECT 4 AS id, 'job_title_1' AS job_title FROM dual
--UNION ALL 
--SELECT 5 AS id, 'job_title_1' AS job_title FROM dual
--UNION ALL
--SELECT 6 AS id, 'job_title_2' AS job_title FROM dual
--UNION ALL 
--SELECT 7 AS id, 'job_title_2' AS job_title FROM dual
--UNION ALL 
--SELECT 8 AS id, 'job_title_2' AS job_title FROM dual
--UNION ALL 
SELECT 9 AS id, 'job_title_2' AS job_title FROM dual
UNION ALL
SELECT 10 AS id, 'job_title_2' AS job_title FROM dual
UNION ALL 
SELECT 11 AS id, 'job_title_3' AS job_title FROM dual
UNION ALL 
--SELECT 12 AS id, 'job_title_3' AS job_title FROM dual
--UNION ALL 
--SELECT 13 AS id, 'job_title_3' AS job_title FROM dual
--UNION ALL
--SELECT 14 AS id, 'job_title_3' AS job_title FROM dual
--UNION ALL 
--SELECT 15 AS id, 'job_title_3' AS job_title FROM dual
--UNION ALL 
--SELECT 16 AS id, 'job_title_4' AS job_title FROM dual
--UNION ALL 
--SELECT 17 AS id, 'job_title_4' AS job_title FROM dual
--UNION ALL
--SELECT 18 AS id, 'job_title_4' AS job_title FROM dual
--UNION ALL 
--SELECT 19 AS id, 'job_title_4' AS job_title FROM dual
--UNION ALL 
--SELECT 20 AS id, 'job_title_4' AS job_title FROM dual
--UNION ALL 
--SELECT 21 AS id, 'job_title_5' AS job_title FROM dual
--UNION ALL 
--SELECT 22 AS id, 'job_title_5' AS job_title FROM dual
--UNION ALL 
--SELECT 23 AS id, 'job_title_5' AS job_title FROM dual
--UNION ALL 
SELECT 24 AS id, 'job_title_5' AS job_title FROM dual
UNION ALL 
SELECT 25 AS id, 'job_title_5' AS job_title FROM dual),
CTE_HN AS
(
--SELECT 1 AS id, 'Yesenin' AS street FROM dual 
--UNION ALL
--SELECT 2 AS id, 'Nikolskaya' AS street FROM dual
--UNION ALL 
--SELECT 3 AS id, 'Fifth Avenue' AS street FROM dual
--UNION ALL 
--SELECT 4 AS id, 'Vladimirskaya' AS street FROM dual
--UNION ALL 
--SELECT 5 AS id, 'Gurchevskaya' AS street FROM dual
--UNION ALL 
--SELECT 6 AS id, 'Gammel Strand' AS street FROM dual
--UNION ALL 
--SELECT 7 AS id, 'Abby' AS street FROM dual
--UNION ALL 
--SELECT 8 AS id, 'D Dunkri' AS street FROM dual
--UNION ALL 
SELECT 9 AS id, 'Aloyas' AS street FROM dual
UNION ALL 
SELECT 10 AS id, 'G Galve' AS street FROM dual
UNION ALL 
SELECT 11 AS id, 'Graben ' AS street FROM dual
UNION ALL 
--SELECT 12 AS id, 'K Kaiser-Friedrich' AS street FROM dual
--UNION ALL 
--SELECT 13 AS id, 'Champs Elysees' AS street FROM dual
--UNION ALL 
--SELECT 14 AS id, 'Antoine Dansaert' AS street FROM dual
--UNION ALL 
--SELECT 15 AS id, 'Via del Corso' AS street FROM dual
--UNION ALL 
--SELECT 16 AS id, 'Abby' AS street FROM dual
--UNION ALL 
--SELECT 17 AS id, 'D Dunkri' AS street FROM dual
--UNION ALL 
--SELECT 18 AS id, 'Aloyas' AS street FROM dual
--UNION ALL 
--SELECT 19 AS id, 'G Galve' AS street FROM dual
--UNION ALL 
--SELECT 20 AS id, 'Graben ' AS street FROM dual
--UNION ALL 
--SELECT 21 AS id, 'K Kaiser-Friedrich' AS street FROM dual
--UNION ALL 
--SELECT 22 AS id, 'Champs Elysees' AS street FROM dual
--UNION ALL 
--SELECT 23 AS id, 'Antoine Dansaert' AS street FROM dual
--UNION ALL 
SELECT 24 AS id, 'Via del Corso' AS street FROM dual
UNION ALL 
SELECT 25 AS id, 'Zybitskaya' AS street FROM dual ),
CTE_DN AS (
--SELECT 1 AS id, 'Belarus' AS country FROM dual 
--UNION ALL 
--SELECT 2 AS id, 'Russia' AS country FROM dual
--UNION ALL 
--SELECT 3 AS id, 'USA' AS country FROM dual
--UNION ALL 
--SELECT 4 AS id, 'Ukraine' AS country FROM dual
--UNION ALL 
--SELECT 5 AS id, 'Poland' AS country FROM dual
--UNION ALL 
--SELECT 6 AS id, 'Denmark' AS country FROM dual
--UNION ALL 
--SELECT 7 AS id, 'England' AS country FROM dual
--UNION ALL 
--SELECT 8 AS id, 'Estonia' AS country FROM dual
--UNION ALL 
SELECT 9 AS id, 'Latvia' AS country FROM dual
UNION ALL 
SELECT 10 AS id, 'Lithuania' AS country FROM dual
UNION ALL 
SELECT 11 AS id, 'Austria' AS country FROM dual
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
--UNION ALL 
--SELECT 17 AS id, 'England' AS country FROM dual
--UNION ALL 
--SELECT 18 AS id, 'Estonia' AS country FROM dual
--UNION ALL 
--SELECT 19 AS id, 'Latvia' AS country FROM dual
--UNION ALL 
--SELECT 20 AS id, 'Lithuania' AS country FROM dual
--UNION ALL 
--SELECT 21 AS id, 'Austria' AS country FROM dual
--UNION ALL 
--SELECT 22 AS id, 'Germany' AS country FROM dual
--UNION ALL 
--SELECT 23 AS id, 'France' AS country FROM dual
UNION ALL 
SELECT 24 AS id, 'Belgium' AS country FROM dual
UNION ALL 
SELECT 25 AS id, 'Belarus' AS country FROM dual ),
CTE_ZN AS
(
--SELECT 1 AS id, 'Minsk' AS city FROM dual  
--UNION ALL
--SELECT 2 AS id, 'Moscow' AS city FROM dual
--UNION ALL 
--SELECT 3 AS id, 'New York' AS city FROM dual
--UNION ALL 
--SELECT 4 AS id, 'Kiev' AS city FROM dual
--UNION ALL 
--SELECT 5 AS id, 'Warsaw' AS city FROM dual
--UNION ALL 
--SELECT 6 AS id, 'Copenhagen' AS city FROM dual
--UNION ALL 
--SELECT 7 AS id, 'London' AS city FROM dual
--UNION ALL 
--SELECT 8 AS id, 'Tallinn' AS city FROM dual
--UNION ALL 
SELECT 9 AS id, 'Riga' AS city FROM dual
UNION ALL 
SELECT 10 AS id, 'Vilnius' AS city FROM dual
UNION ALL 
SELECT 11 AS id, 'Vienna ' AS city FROM dual
--UNION ALL 
--SELECT 12 AS id, 'Berlin' AS city FROM dual
--UNION ALL 
--SELECT 13 AS id, 'Paris' AS city FROM dual
--UNION ALL 
--SELECT 14 AS id, 'Brussels' AS city FROM dual
--UNION ALL 
--SELECT 15 AS id, 'Rome' AS city FROM dual
--UNION ALL 
--SELECT 16 AS id, 'Brest' AS city FROM dual
--UNION ALL 
--SELECT 17 AS id, 'London' AS city FROM dual
--UNION ALL 
--SELECT 18 AS id, 'Tallinn' AS city FROM dual
--UNION ALL 
--SELECT 19 AS id, 'Riga' AS city FROM dual
--UNION ALL 
--SELECT 20 AS id, 'Vilnius' AS city FROM dual
--UNION ALL 
--SELECT 21 AS id, 'Vienna ' AS city FROM dual
--UNION ALL 
--SELECT 22 AS id, 'Berlin' AS city FROM dual
--UNION ALL 
--SELECT 23 AS id, 'Paris' AS city FROM dual
UNION ALL 
SELECT 24 AS id, 'Brussels' AS city FROM dual
UNION ALL 
SELECT 25 AS id, 'Brest' AS city FROM dual),
CTE_SN AS
(SELECT 1 AS id, 'Y' AS employee_status FROM dual)
SELECT FN.first_name, LN.last_name, CONCAT('375',TRUNC(DBMS_RANDOM.VALUE( 290000000, 299999999))) AS phone,
FN.first_name || '' || LN.last_name || ''|| '@mail.ru' AS email,RN.department, WN.job_title,
 HN.street, DN.country, ZN.city, TRUNC(DBMS_RANDOM.VALUE( 1,100)) AS building, TRUNC(DBMS_RANDOM.VALUE( 1,300)) AS apartment,
SN.employee_status
FROM CTE_FN FN 
LEFT OUTER JOIN CTE_LN LN ON FN.id=LN.id
LEFT OUTER JOIN CTE_RN RN ON FN.id=RN.id
LEFT OUTER JOIN CTE_WN WN ON FN.id=WN.id
LEFT OUTER JOIN CTE_HN HN ON FN.id=HN.id
LEFT OUTER JOIN CTE_DN DN ON FN.id=DN.id
LEFT OUTER JOIN CTE_ZN ZN ON FN.id=ZN.id
CROSS JOIN CTE_SN SN
;