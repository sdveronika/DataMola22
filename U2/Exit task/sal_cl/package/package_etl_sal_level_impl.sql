alter session set current_schema = dw_data;
GRANT SELECT ON order_fact  TO sal_cl;
alter session set current_schema = sal_cl;

CREATE OR REPLACE PACKAGE body pkg_etl_sal_level
AS  
  PROCEDURE load_sal_order_fact
  AS
  BEGIN
    MERGE INTO sal_cl.order_fact a
    USING (SELECT * FROM dw_data.order_fact) b
    ON (a.order_id=b.order_id)
    WHEN MATCHED THEN 
                UPDATE SET a.client_id = b.client_id
    WHEN NOT MATCHED THEN 
                INSERT (a.order_id,
                        a.client_id,
                        a.employee_id,
                        a.restaurant_id,
                        a.date_id,
                        a.period_id,
                        a.payment_method_id,
                        a.dish_id,
                        a.dish_amount,
                        a.total_cost,
                        a.delivery)
                VALUES (b.order_id,
                        b.client_id,
                        b.employee_id,
                        b.restaurant_id,
                        b.date_id,
                        b.period_id,
                        b.payment_method_id,
                        b.dish_id,
                        b.dish_amount,
                        b.total_cost,
                        b.delivery);
COMMIT;
   END load_sal_order_fact;
END pkg_etl_sal_level;