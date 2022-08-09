--DROP USER SB_MBackUp CASCADE;
--DROP TABLESPACE geo_denormalized_t INCLUDING CONTENTS AND DATAFILES CASCADE CONSTRAINTS;
--DROP TABLE SB_MBackUp.geo_denormalized_tab; 

CREATE TABLESPACE geo_denormalized_t
DATAFILE '/oracle/u02/oradata/VSadovskaiadb/db_geo_denormalized_t.dat'
SIZE 150M
AUTOEXTEND ON NEXT 50M
SEGMENT SPACE MANAGEMENT AUTO;

CREATE USER SB_MBackUp 
IDENTIFIED BY "%PWD%"
DEFAULT TABLESPACE geo_denormalized_t;

GRANT CONNECT,RESOURCE TO SB_MBackUp;
GRANT SELECT ANY TABLE TO SB_MBackUp;

ALTER USER SB_MBackUp QUOTA UNLIMITED ON geo_denormalized_t;
          
CREATE TABLE SB_MBackUp.geo_denormalized_tab
TABLESPACE geo_denormalized_t
AS  
SELECT pgid.cid
     , pgid.pid
     , pgid.link_type_id
     , pgid.id_type
     , pgid.lev_count
     , pgid.geo_path
     , cnt.country_id
     , cnt.region_desc AS country_name
     , prt.part_desc
     , reg.region_desc
  FROM (  SELECT country_geo_id
               , SUM ( region ) AS region_geo_id
               , SUM ( contenet ) AS contenet_geo_id
            FROM (    SELECT CONNECT_BY_ROOT ( child_geo_id ) AS country_geo_id
                           , parent_geo_id
                           , link_type_id
                           , DECODE ( link_type_id, 2, parent_geo_id ) AS contenet
                           , DECODE ( link_type_id, 3, parent_geo_id ) AS region
                        FROM u_dw_references.w_geo_object_links
                  CONNECT BY PRIOR parent_geo_id = child_geo_id
                  START WITH child_geo_id IN (SELECT DISTINCT geo_id
                                                FROM u_dw_references.cu_countries))
        GROUP BY country_geo_id) geo
       LEFT JOIN u_dw_references.cu_countries cnt
          ON ( geo.country_geo_id = cnt.geo_id )
       LEFT JOIN u_dw_references.cu_geo_regions reg
          ON ( geo.region_geo_id = reg.geo_id )
                 LEFT JOIN u_dw_references.cu_geo_parts prt
          ON ( geo.contenet_geo_id = prt.geo_id )
        RIGHT OUTER JOIN 
        (SELECT child_geo_id,
        LPAD ( ' ', 2 * LEVEL, ' ' ) || child_geo_id AS cid
    , parent_geo_id AS pid
    , link_type_id
    , DECODE ( LEVEL,  1, 'ROOT',  2, 'BRANCH',  'LEAF' ) AS id_type
    , DECODE ( ( SELECT COUNT ( * )
                 FROM u_dw_references.t_geo_object_links a
                 WHERE a.parent_geo_id = b.child_geo_id )
                            , 0, NULL, ( SELECT COUNT ( * )
                            FROM u_dw_references.t_geo_object_links a
                            WHERE a.parent_geo_id = b.child_geo_id ) ) AS lev_count
    , SYS_CONNECT_BY_PATH ( parent_geo_id, ':' ) AS geo_path
             FROM u_dw_references.t_geo_object_links b
       CONNECT BY PRIOR child_geo_id = parent_geo_id
ORDER SIBLINGS BY child_geo_id) pgid
ON geo.country_geo_id=pgid.cid;

SELECT * FROM SB_MBackUp.geo_denormalized_tab;
