-- Name: ISHIMWE Pitie | Student ID: 29767 | Group: B | Project: MilkTrack
SET ECHO ON
SET LINESIZE 200
CONNECT pitie_admin/pitie@//192.168.56.1:1521/b_29767_pitie_milktrack_db
SHOW CON_NAME

CREATE OR REPLACE DIRECTORY milk_dir AS 'C:\milktrack\data';

CREATE TABLE stg_milk_ext (
  ph VARCHAR2(20), temperature VARCHAR2(20), taste VARCHAR2(20), odor VARCHAR2(20),
  fat VARCHAR2(20), turbidity VARCHAR2(20), colour VARCHAR2(20), grade VARCHAR2(20)
)
ORGANIZATION EXTERNAL (
  TYPE ORACLE_LOADER
  DEFAULT DIRECTORY milk_dir
  ACCESS PARAMETERS (
    RECORDS DELIMITED BY NEWLINE
    SKIP 1
    FIELDS TERMINATED BY ','
    MISSING FIELD VALUES ARE NULL
  )
  LOCATION ('milknew.csv')
) REJECT LIMIT UNLIMITED;

-- Staging table: all columns are text so that no row is rejected
CREATE TABLE stg_milk TABLESPACE milktrack_data AS
SELECT TO_CHAR(ROWNUM) AS src_row, ph, temperature, taste, odor, fat, turbidity, colour, grade
FROM stg_milk_ext;

SELECT COUNT(*) AS rows_in_staging FROM stg_milk;
SELECT * FROM stg_milk WHERE ROWNUM <= 5;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') AS now FROM dual;