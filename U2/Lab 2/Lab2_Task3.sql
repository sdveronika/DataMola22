SELECT DECODE ( GROUPING_ID ( TRUNC ( order_date, 'YYYY' )
                            , TRUNC ( order_date, 'Q' )
                            , TRUNC ( order_date, 'MM' )
                            , TRUNC ( order_date, 'DD' ) )
                , 7, 'Total for year'
                , 15, 'GRANT TOTAL'
                , TRUNC ( order_date, 'YYYY' ) ) AS year
    , DECODE ( GROUPING_ID (  TRUNC ( order_date, 'YYYY' )
                            , TRUNC ( order_date, 'Q' )
                            , TRUNC ( order_date, 'MM' )
                            , TRUNC ( order_date, 'DD' ) )
                , 3, 'Total for quarter'
                , TRUNC (order_date, 'Q' ) ) AS quarter
    , DECODE ( GROUPING_ID (  TRUNC ( order_date, 'YYYY' )
                            , TRUNC ( order_date, 'Q' )
                            , TRUNC ( order_date, 'MM' )
                            , TRUNC ( order_date, 'DD' ) )
                , 1, 'Total for month'
                , TRUNC ( order_date, 'MM' ) ) AS month
    , DECODE ( GROUPING_ID ( TRUNC ( order_date, 'YYYY' )
                            , TRUNC ( order_date, 'Q' )
                            , TRUNC ( order_date, 'MM' )
                            , TRUNC ( order_date, 'DD' ) )
                , 15, ''
                , TRUNC ( order_date, 'DD' ) ) AS day
    ,  SUM(total_cost) AS total_cost
FROM sa_orders.sa_t_transaction
GROUP BY ROLLUP ( TRUNC ( order_date, 'YYYY' ), 
                  TRUNC ( order_date, 'Q' ), 
                  TRUNC ( order_date, 'MM' ), 
                  TRUNC ( order_date, 'DD' ) );
