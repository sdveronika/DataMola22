alter session set current_schema = DW_CL;
GRANT SELECT ON cl_t_employee  TO DW_DATA;
alter session set current_schema = DW_DATA;
select * from dw_cl.cl_t_employee;

CREATE OR REPLACE PACKAGE body pkg_etl_employees_dw
AS  
  PROCEDURE load_CLEAN_EMPLOYEES_DW
   AS
     BEGIN
      DECLARE
	   TYPE CURSOR_VARCHAR IS TABLE OF varchar2(100);
       TYPE CURSOR_NUMBER IS TABLE OF number(10); 
       TYPE CURSOR_INT IS TABLE OF int;
	   TYPE BIG_CURSOR IS REF CURSOR ;
	
	   ALL_INF BIG_CURSOR;
	   
	   EMPLOYEE_FIRST_NAME CURSOR_VARCHAR;
	   EMPLOYEE_LAST_NAME CURSOR_VARCHAR;
       EMPLOYEE_PHONE CURSOR_VARCHAR;
	   EMPLOYEE_EMAIL CURSOR_VARCHAR;
       EMPLOYEE_DEPARTMENT CURSOR_VARCHAR;
       EMPLOYEE_JOB_TITLE CURSOR_VARCHAR;
       EMPLOYEE_STREET CURSOR_VARCHAR;
       EMPLOYEE_COUNTRY CURSOR_VARCHAR;
       EMPLOYEE_CITY CURSOR_VARCHAR;
       EMPLOYEE_BUILDING CURSOR_INT;
       EMPLOYEE_APARTMENT CURSOR_INT;
       EMPLOYEE_STATUS CURSOR_VARCHAR;
       EMPLOYEE_FIRST_NAME_stage CURSOR_VARCHAR;
       EMPLOYEE_LAST_NAME_stage CURSOR_VARCHAR;
       EMPLOYEE_ID CURSOR_NUMBER;

	BEGIN
	   OPEN ALL_INF FOR
	       SELECT source_CL.FIRST_NAME AS FIRST_NAME_source_CL
                 , source_CL.LAST_NAME AS LAST_NAME_source_CL
	             , source_CL.PHONE AS PHONE
                 , source_CL.EMAIL AS EMAIL
                 , source_CL.DEPARTMENT AS CITY
                 , source_CL.JOB_TITLE AS CITY
	             , source_CL.STREET AS STREET
                 , source_CL.COUNTRY AS COUNTRY
                 , source_CL.CITY AS CITY
                 , source_CL.BUILDING AS CITY
                 , source_CL.APARTMENT AS CITY
                 , source_CL.EMPLOYEE_STATUS AS STATUS
                 , stage.FIRST_NAME AS FIRST_NAME_stage
                 , stage.LAST_NAME AS LAST_NAME_stage
                 , stage.EMPLOYEE_ID AS EMPLOYEE_ID
	          FROM (SELECT DISTINCT *
                           FROM dw_cl.cl_t_employee) source_CL
                     LEFT JOIN
                        dw_data.employee_dimension stage
                     ON (source_CL.FIRST_NAME = stage.FIRST_NAME AND source_CL.LAST_NAME = stage.LAST_NAME );

	   FETCH ALL_INF
	   BULK COLLECT INTO
                 EMPLOYEE_FIRST_NAME
                , EMPLOYEE_LAST_NAME 
                , EMPLOYEE_PHONE 
                , EMPLOYEE_EMAIL 
                , EMPLOYEE_DEPARTMENT 
                , EMPLOYEE_JOB_TITLE 
                , EMPLOYEE_STREET 
                , EMPLOYEE_COUNTRY 
                , EMPLOYEE_CITY 
                , EMPLOYEE_BUILDING 
                , EMPLOYEE_APARTMENT 
                , EMPLOYEE_STATUS 
                , EMPLOYEE_FIRST_NAME_stage 
                , EMPLOYEE_LAST_NAME_stage 
                , EMPLOYEE_ID;
	
	   CLOSE ALL_INF;
	
	   FOR i IN EMPLOYEE_ID.FIRST .. EMPLOYEE_ID.LAST LOOP
	      IF ( EMPLOYEE_ID ( i ) IS NULL ) THEN
	         INSERT INTO dw_data.employee_dimension ( EMPLOYEE_ID
                                             , first_name
                                             , last_name
                                             , phone
                                             , email
                                             , department
                                             , job_title
                                             , address
                                             , country
                                             , city
                                             , building
                                             , apartment
                                             , status)
	              VALUES ( SEQ_EMPLOYEE_DIM.NEXTVAL
                , EMPLOYEE_FIRST_NAME (i)
                , EMPLOYEE_LAST_NAME (i)
                , EMPLOYEE_PHONE (i)
                , EMPLOYEE_EMAIL (i)
                , EMPLOYEE_DEPARTMENT (i)
                , EMPLOYEE_JOB_TITLE (i)
                , EMPLOYEE_STREET (i)
                , EMPLOYEE_COUNTRY (i)
                , EMPLOYEE_CITY (i)
                , EMPLOYEE_BUILDING (i) 
                , EMPLOYEE_APARTMENT (i)
                , EMPLOYEE_STATUS (i));
	
	         COMMIT;
	     ELSE UPDATE dw_data.employee_dimension
         SET phone=EMPLOYEE_PHONE (i)
           , email=EMPLOYEE_EMAIL (i)
           , department=EMPLOYEE_DEPARTMENT (i)
           , job_title=EMPLOYEE_JOB_TITLE (i)
           , address=EMPLOYEE_STREET (i)
           , country=EMPLOYEE_COUNTRY (i)
           , city=EMPLOYEE_CITY (i)
           , building=EMPLOYEE_BUILDING (i)
           , apartment= EMPLOYEE_APARTMENT (i)
           , status=EMPLOYEE_STATUS (i)
         WHERE employee_id=employee_id(i);
	
	         COMMIT;
	      END IF;
	   END LOOP;
	END;
   END load_CLEAN_EMPLOYEES_DW;
END pkg_etl_employees_dw;

