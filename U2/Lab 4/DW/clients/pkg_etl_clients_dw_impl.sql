alter session set current_schema = DW_CL;
GRANT SELECT ON cl_t_client  TO DW_DATA;
alter session set current_schema = DW_DATA;
select * from dw_cl.cl_t_client;

CREATE OR REPLACE PACKAGE body pkg_etl_clients_dw
AS  
  PROCEDURE load_CLEAN_CLIENTS_DW
   AS
     BEGIN
      DECLARE
	   TYPE CURSOR_VARCHAR IS TABLE OF varchar2(100);
       TYPE CURSOR_NUMBER IS TABLE OF number(10); 
	   TYPE BIG_CURSOR IS REF CURSOR ;
	
	   ALL_INF BIG_CURSOR;
	   
	   CLIENT_FIRST_NAME CURSOR_VARCHAR;
	   CLIENT_LAST_NAME CURSOR_VARCHAR;
       CLIENT_PHONE CURSOR_VARCHAR;
	   CLIENT_EMAIL CURSOR_VARCHAR;
       CLIENT_STREET CURSOR_VARCHAR;
       CLIENT_COUNTRY CURSOR_VARCHAR;
       CLIENT_CITY CURSOR_VARCHAR;
       CLIENT_STATUS CURSOR_VARCHAR;
       FIRST_NAME_stage CURSOR_VARCHAR;
       LAST_NAME_stage CURSOR_VARCHAR;
       CLIENT_ID CURSOR_NUMBER;

	BEGIN
	   OPEN ALL_INF FOR
	       SELECT source_CL.FIRST_NAME AS FIRST_NAME_source_CL
                 , source_CL.LAST_NAME AS LAST_NAME_source_CL
	             , source_CL.PHONE AS PHONE
                 , source_CL.EMAIL AS EMAIL
	             , source_CL.STREET AS STREET
                 , source_CL.COUNTRY AS COUNTRY
                 , source_CL.CITY AS CITY
                 , source_CL.CLIENT_STATUS AS STATUS
                 , stage.FIRST_NAME AS FIRST_NAME_stage
                 , stage.LAST_NAME AS LAST_NAME_stage
                 , stage.CLIENT_ID AS CLIENT_ID
	          FROM (SELECT DISTINCT *
                           FROM dw_cl.cl_t_client) source_CL
                     LEFT JOIN
                        dw_data.client_dimension stage
                     ON (source_CL.FIRST_NAME = stage.FIRST_NAME AND source_CL.LAST_NAME = stage.LAST_NAME );

	
	   FETCH ALL_INF
	   BULK COLLECT INTO
                 CLIENT_FIRST_NAME
                , CLIENT_LAST_NAME
                , CLIENT_PHONE
                , CLIENT_EMAIL
                , CLIENT_STREET
                , CLIENT_COUNTRY
                , CLIENT_CITY
                , CLIENT_STATUS
                , FIRST_NAME_stage
                , LAST_NAME_stage
                , CLIENT_ID;
	
	   CLOSE ALL_INF;
	
	   FOR i IN CLIENT_ID.FIRST .. CLIENT_ID.LAST LOOP
	      IF ( CLIENT_ID ( i ) IS NULL ) THEN
	         INSERT INTO dw_data.client_dimension ( CLIENT_ID
                                             , first_name
                                             , last_name
                                             , phone
                                             , email
                                             , street
                                             , country
                                             , city
                                             , status)
	              VALUES ( SEQ_CLIENT_DIM.NEXTVAL
	                     , CLIENT_FIRST_NAME (i)
                         , CLIENT_LAST_NAME (i)
                         , CLIENT_PHONE (i)
                         , CLIENT_EMAIL (i)
                         , CLIENT_STREET (i)
                         , CLIENT_COUNTRY (i)
                         , CLIENT_CITY (i)
                         , CLIENT_STATUS (i));
	
	         COMMIT;
	     ELSE UPDATE dw_data.client_dimension 
         SET phone=CLIENT_PHONE (i)
           , email=CLIENT_EMAIL (i)
           , street=CLIENT_STREET (i)
           , country=CLIENT_COUNTRY (i)
           , city=CLIENT_CITY (i)
           , status=CLIENT_STATUS (i)
         WHERE client_id=client_id(i);
	
	         COMMIT;
	      END IF;
	   END LOOP;
	END;
   END load_CLEAN_CLIENTS_DW;
END pkg_etl_clients_dw;

