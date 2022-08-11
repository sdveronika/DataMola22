alter session set current_schema = DW_CL;
GRANT SELECT ON cl_t_dish  TO DW_DATA;
alter session set current_schema = DW_DATA;
select * from dw_cl.cl_t_dish;

CREATE OR REPLACE PACKAGE body pkg_etl_dishes_dw
AS  
  PROCEDURE load_CLEAN_DISHES_DW
   AS
     BEGIN
      DECLARE
	   TYPE CURSOR_VARCHAR IS TABLE OF varchar2(200);
       TYPE CURSOR_NUMBER IS TABLE OF number(10); 
       TYPE CURSOR_DECIMAL IS TABLE OF decimal(10,2);
	   TYPE BIG_CURSOR IS REF CURSOR ;
	
	   ALL_INF BIG_CURSOR;
	   
	   DISH_NAME CURSOR_VARCHAR;
	   DISH_CATEGORY CURSOR_VARCHAR;
       DISH_PRICE CURSOR_DECIMAL;
       DISH_COMPOSITION CURSOR_VARCHAR;
       DISH_WEIGHT CURSOR_DECIMAL;
       DISH_STATUS CURSOR_VARCHAR;
       DISH_NAME_stage CURSOR_VARCHAR;
       DISH_PRICE_stage CURSOR_DECIMAL;
       DISH_ID CURSOR_NUMBER;

	BEGIN
	   OPEN ALL_INF FOR
	       SELECT source_CL.DISH_NAME AS DISH_NAME_source_CL
                 , source_CL.DISH_CATEGORY AS DISH_CATEGORY_source_CL
	             , source_CL.PRICE AS PRICE
                 , source_CL.COMPOSITION AS COMPOSITION
                 , source_CL.WEIGHT AS WEIGHT
                 , source_CL.DISH_STATUS AS STATUS
                 , stage.DISH_NAME AS DISH_NAME_stage
                 , stage.WEIGHT AS WEIGHT_stage
                 , stage.DISH_ID AS DISH_ID
	          FROM (SELECT DISTINCT *
                           FROM dw_cl.cl_t_dish) source_CL
                     LEFT JOIN
                       dw_data.dish_dimension stage
                     ON (source_CL.DISH_NAME = stage.DISH_NAME AND source_CL.WEIGHT = stage.WEIGHT );

	   FETCH ALL_INF
	   BULK COLLECT INTO
                   DISH_NAME 
	             , DISH_CATEGORY 
                 , DISH_PRICE 
                 , DISH_COMPOSITION 
                 , DISH_WEIGHT 
                 , DISH_STATUS 
                 , DISH_NAME_stage 
                 , DISH_PRICE_stage 
                 , DISH_ID ;
	
	   CLOSE ALL_INF;
	
	   FOR i IN DISH_ID.FIRST .. DISH_ID.LAST LOOP
	      IF ( DISH_ID ( i ) IS NULL ) THEN
	         INSERT INTO dw_data.dish_dimension ( DISH_ID
                                             , dish_name
                                             , dish_category
                                             , price
                                             , composition
                                             , weight
                                             , status)
	              VALUES ( SEQ_DISH_DIM.NEXTVAL
                 , DISH_NAME (i)
	             , DISH_CATEGORY (i)
                 , DISH_PRICE (i)
                 , DISH_COMPOSITION (i)
                 , DISH_WEIGHT (i)
                 , DISH_STATUS (i));
	
	         COMMIT;
	     ELSE UPDATE dw_data.dish_dimension
         SET dish_name=DISH_NAME (i),
             price=DISH_PRICE (i),
             composition=DISH_COMPOSITION (i),
             weight=DISH_WEIGHT (i),
             status=DISH_STATUS (i)
         WHERE dish_id=dish_id(i);
	
	         COMMIT;
	      END IF;
	   END LOOP;
	END;
   END load_CLEAN_DISHES_DW;
END pkg_etl_dishes_dw;

