CREATE MATERIALIZED VIEW mv_month_profit
BUILD DEFERRED
REFRESH COMPLETE ON DEMAND
AS
SELECT /*+ gather_plan_statistics */ TRUNC ( order_date, 'MM' ) AS order_date, 
    DECODE (GROUPING(country_r), 1, 'All countries', country_r) AS country_r,
    DECODE (GROUPING(city_r), 1, 'All cities', city_r) AS city_r,
    SUM(total_cost) AS profit
FROM sa_orders.sa_t_transaction
GROUP BY TRUNC ( order_date, 'MM' ),CUBE(  country_r, city_r)
HAVING  GROUPING_ID (country_r)<1 
ORDER BY 1, 2, 3, 4;

SELECT * FROM mv_month_profit;

EXECUTE DBMS_MVIEW.REFRESH('mv_month_profit');