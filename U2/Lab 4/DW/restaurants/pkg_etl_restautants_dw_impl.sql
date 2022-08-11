alter session set current_schema = DW_CL;
GRANT SELECT ON cl_t_restaurant  TO DW_DATA;
alter session set current_schema = DW_DATA;
select * from dw_cl.cl_t_restaurant;

CREATE OR REPLACE PACKAGE body pkg_etl_restaurants_dw
AS  
  PROCEDURE load_CLEAN_RESTAURANTS_DW
   AS
     BEGIN
      DECLARE
	   TYPE CURSOR_VARCHAR IS TABLE OF varchar2(100);
       TYPE CURSOR_NUMBER IS TABLE OF number(10); 
       TYPE CURSOR_INT IS TABLE OF int;
	   TYPE BIG_CURSOR IS REF CURSOR ;
	
	   ALL_INF BIG_CURSOR;
	   
       RESTAURANT_PHONE CURSOR_VARCHAR;
	   RESTAURANT_EMAIL CURSOR_VARCHAR;
       RESTAURANT_STREET CURSOR_VARCHAR;
       RESTAURANT_COUNTRY CURSOR_VARCHAR;
       RESTAURANT_CITY CURSOR_VARCHAR;
       RESTAURANT_BUILDING CURSOR_INT;
       RESTAURANT_APARTMENT CURSOR_INT;
       RESTAURANT_STATUS CURSOR_VARCHAR;
       RESTAURANT_PHONE_STAGE CURSOR_VARCHAR;
       RESTAURANT_EMAIL_STAGE CURSOR_VARCHAR;
       RESTAURANT_ID CURSOR_NUMBER;

	BEGIN
	   OPEN ALL_INF FOR
	       SELECT source_CL.PHONE AS PHONE_SOURCE_CL
                 , source_CL.EMAIL AS EMAIL_SOURCE_CL
	             , source_CL.STREET AS STREET
                 , source_CL.COUNTRY AS COUNTRY
                 , source_CL.CITY AS CITY
                 , source_CL.BUILDING AS BUILDING
                 , source_CL.APARTMENT AS APARTMENT
                 , source_CL.RESTAURANT_STATUS AS STATUS
                 , stage.PHONE AS PHONE_STAGE
                 , stage.EMAIL AS EMAIL_STAGE
                 , stage.RESTAURANT_ID AS RESTAURANT_ID
	          FROM (SELECT DISTINCT *
                           FROM dw_cl.cl_t_restaurant) source_CL
                     LEFT JOIN
                        dw_data.restaurant_dimension stage
                     ON (source_CL.PHONE = stage.PHONE AND source_CL.EMAIL = stage.EMAIL );

	
	   FETCH ALL_INF
	   BULK COLLECT INTO
                 RESTAURANT_PHONE 
               , RESTAURANT_EMAIL  
               , RESTAURANT_STREET 
               , RESTAURANT_COUNTRY
               , RESTAURANT_CITY 
               , RESTAURANT_BUILDING 
               , RESTAURANT_APARTMENT 
               , RESTAURANT_STATUS 
               , RESTAURANT_PHONE_STAGE 
               , RESTAURANT_EMAIL_STAGE 
               , RESTAURANT_ID;
	
	   CLOSE ALL_INF;
	
	   FOR i IN RESTAURANT_ID.FIRST .. RESTAURANT_ID.LAST LOOP
	      IF ( RESTAURANT_ID ( i ) IS NULL ) THEN
	         INSERT INTO dw_data.restaurant_dimension ( RESTAURANT_ID
                                             , phone
                                             , email
                                             , address
                                             , country
                                             , city
                                             , building
                                             , apartment
                                             , status)
	              VALUES ( SEQ_RESTAURANT_DIM.NEXTVAL
	                   , RESTAURANT_PHONE (i)
                       , RESTAURANT_EMAIL (i)
                       , RESTAURANT_STREET (i)
                       , RESTAURANT_COUNTRY (i)
                       , RESTAURANT_CITY (i)
                       , RESTAURANT_BUILDING (i) 
                       , RESTAURANT_APARTMENT (i)
                       , RESTAURANT_STATUS (i));
	
	         COMMIT;
	     ELSE UPDATE dw_data.restaurant_dimension
         SET address=RESTAURANT_STREET (i)
           , country=RESTAURANT_COUNTRY (i)
           , city=RESTAURANT_CITY (i)
           , building=RESTAURANT_BUILDING (i)
           , apartment=RESTAURANT_APARTMENT (i)
           , status=RESTAURANT_STATUS (i)
         WHERE restaurant_id=RESTAURANT_ID(i);
	
	         COMMIT;
	      END IF;
	   END LOOP;
	END;
   END load_CLEAN_RESTAURANTS_DW;
END pkg_etl_restaurants_dw;

