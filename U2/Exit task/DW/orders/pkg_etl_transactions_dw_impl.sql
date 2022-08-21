alter session set current_schema = DW_CL;
GRANT SELECT ON cl_t_transaction  TO DW_DATA;
alter session set current_schema = DW_DATA;
select * from dw_cl.cl_t_transaction;

CREATE OR REPLACE PACKAGE body pkg_etl_transactions_dw
AS  
  PROCEDURE load_CLEAN_TRANSACTIONS_DW
   AS
     BEGIN
      DECLARE
       period_id_v NUMBER;
	   TYPE CURSOR_VARCHAR IS TABLE OF varchar2(100);
       TYPE CURSOR_NUMBER IS TABLE OF number(10);
       TYPE CURSOR_DATE IS TABLE OF date;
       TYPE CURSOR_DECIMAL IS TABLE OF decimal(11,2);
	   TYPE BIG_CURSOR IS REF CURSOR ;
	
	   ALL_INF BIG_CURSOR;
	   
	   CLIENT_ID CURSOR_NUMBER;
       EMPLOYEE_ID CURSOR_NUMBER;
       RESTAURANT_ID CURSOR_NUMBER;
       DATE_ID CURSOR_DATE;
       PAYMENT_METHOD_ID CURSOR_NUMBER;
       TOTAL_COST CURSOR_DECIMAL;
       DELIVERY CURSOR_VARCHAR;
       ORDER_ID CURSOR_NUMBER;
       DISH_ID CURSOR_NUMBER;
       DISH_PRICE CURSOR_DECIMAL;

	BEGIN
	   OPEN ALL_INF FOR
	       SELECT cl.client_id
                , emp.employee_id
                , rst.restaurant_id
                , source_cl.order_date
                , pmd.payment_method_id
                , source_cl.total_cost
                , source_cl.delivery
                , trn.order_id
                , dsh.dish_id
                , dsh.price
	          FROM (SELECT DISTINCT *
                           FROM dw_cl.cl_t_transaction) source_cl
                     LEFT JOIN
                        dw_data.client_dimension cl
                     ON (source_cl.first_name_c = cl.first_name AND source_cl.last_name_c = cl.last_name)
                     LEFT JOIN 
                        dw_data.dish_dimension dsh
                     ON (source_cl.dish_name=dsh.dish_name AND source_cl.dish_category=dsh.dish_category)
                     LEFT JOIN 
                        dw_data.restaurant_dimension rst
                     ON (source_cl.phone_r=rst.phone AND source_cl.email_r=rst.email)
                     LEFT JOIN 
                        dw_data.employee_dimension emp
                     ON (source_cl.first_name_e=emp.first_name AND source_cl.last_name_e=emp.last_name)
                     LEFT JOIN
                        dw_data.payment_method_dimension pmd
                     ON (source_cl.payment_method_name=pmd.payment_method_name)
                     LEFT JOIN 
                        dw_data.order_fact trn
                     ON (cl.client_id=trn.client_id AND emp.employee_id=trn.employee_id AND 
                         rst.restaurant_id=trn.restaurant_id AND source_cl.order_date=trn.date_id AND
                         pmd.payment_method_id=trn.payment_method_id AND
                         source_cl.total_cost=trn.total_cost AND source_cl.delivery=trn.delivery)
                     WHERE emp.is_active='Y';

	
	   FETCH ALL_INF
	   BULK COLLECT INTO
               CLIENT_ID 
             , EMPLOYEE_ID 
             , RESTAURANT_ID 
             , DATE_ID 
             , PAYMENT_METHOD_ID 
             , TOTAL_COST 
             , DELIVERY 
             , ORDER_ID
             , DISH_ID
             , DISH_PRICE; 
	
	   CLOSE ALL_INF;
	
	   FOR i IN ORDER_ID.FIRST .. ORDER_ID.LAST LOOP 
       
       SELECT period_id INTO period_id_v FROM dw_data.dim_gen_period
       WHERE DATE_ID (i) >= valid_from AND DATE_ID (i) <= valid_to;
       
	      IF ( ORDER_ID ( i ) IS NULL ) THEN
	         INSERT INTO dw_data.order_fact ( ORDER_ID
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
	              VALUES ( SEQ_ORDER_FACT.NEXTVAL
	                     , CLIENT_ID (i)
                         , EMPLOYEE_ID (i)
                         , RESTAURANT_ID (i)
                         , DATE_ID (i)
 	                     , period_id_v
                         , PAYMENT_METHOD_ID (i)
                         , DISH_ID (i)
                         , TRUNC(TOTAL_COST(i)/DISH_PRICE(i),0)
                         , TOTAL_COST (i)
                         , DELIVERY (i));       
	         COMMIT;
	      END IF;
	   END LOOP;
	END;
   END load_CLEAN_TRANSACTIONS_DW;
END pkg_etl_transactions_dw;
