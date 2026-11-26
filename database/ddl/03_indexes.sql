-- Name: ISHIMWE Pitie | Student ID: 29767 | Group: B | Project: MilkTrack
-- 03_indexes.sql - indexes and before/after execution plan
CONNECT pitie_admin/pitie@//192.168.56.1:1521/b_29767_pitie_milktrack_db
SET LINESIZE 200 PAGESIZE 60 SERVEROUTPUT ON
SHOW CON_NAME
EXEC DBMS_STATS.GATHER_SCHEMA_STATS('PITIE_ADMIN');

PROMPT === BEFORE indexes ===
EXPLAIN PLAN FOR SELECT * FROM milk_deliveries WHERE farmer_id = 7;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

CREATE INDEX idx_farmers_centre_id          ON farmers(centre_id)                       TABLESPACE milktrack_idx;
CREATE INDEX idx_milk_deliveries_farmer_id  ON milk_deliveries(farmer_id)               TABLESPACE milktrack_idx;
CREATE INDEX idx_milk_deliveries_centre_date ON milk_deliveries(centre_id, delivery_date) TABLESPACE milktrack_idx;
CREATE INDEX idx_payments_farmer_id         ON payments(farmer_id)                      TABLESPACE milktrack_idx;
CREATE INDEX idx_quality_tests_grade        ON quality_tests(grade)                     TABLESPACE milktrack_idx;
CREATE INDEX idx_farmers_upper_full_name    ON farmers(UPPER(full_name))                TABLESPACE milktrack_idx;

EXEC DBMS_STATS.GATHER_SCHEMA_STATS('PITIE_ADMIN');

PROMPT === AFTER indexes ===
EXPLAIN PLAN FOR SELECT * FROM milk_deliveries WHERE farmer_id = 7;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

SELECT index_name, table_name, tablespace_name, status FROM user_indexes ORDER BY table_name, index_name;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') AS run_time FROM dual;