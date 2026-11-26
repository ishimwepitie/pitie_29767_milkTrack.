-- Name: ISHIMWE Pitie | Student ID: 29767 | Group: B | Project: MilkTrack
-- 04_views.sql - four views
CONNECT pitie_admin/pitie@//192.168.56.1:1521/b_29767_pitie_milktrack_db
SET LINESIZE 200 PAGESIZE 60 SERVEROUTPUT ON
SHOW CON_NAME
CREATE OR REPLACE VIEW vw_delivery_report AS
SELECT d.delivery_id, d.delivery_date, f.full_name AS farmer_name, c.centre_name,
       d.litres, d.status AS delivery_status, q.grade, q.ph, p.amount, p.payment_date
FROM milk_deliveries d
JOIN farmers f ON f.farmer_id = d.farmer_id
JOIN collection_centres c ON c.centre_id = d.centre_id
LEFT JOIN quality_tests q ON q.delivery_id = d.delivery_id
LEFT JOIN payments p ON p.delivery_id = d.delivery_id
WITH READ ONLY;

CREATE OR REPLACE VIEW vw_centre_summary AS
SELECT c.centre_id, c.centre_name,
       COUNT(d.delivery_id) AS total_deliveries,
       NVL(SUM(d.litres),0) AS total_litres,
       NVL(SUM(CASE WHEN d.status='REJECTED' THEN 1 ELSE 0 END),0) AS rejected_batches,
       ROUND(100*SUM(CASE WHEN d.status='REJECTED' THEN 1 ELSE 0 END)/NULLIF(COUNT(d.delivery_id),0),1) AS rejection_pct
FROM collection_centres c
LEFT JOIN milk_deliveries d ON d.centre_id = c.centre_id
GROUP BY c.centre_id, c.centre_name;

CREATE OR REPLACE VIEW vw_daily_litres AS
SELECT delivery_date, COUNT(*) AS deliveries, SUM(litres) AS total_litres
FROM milk_deliveries
GROUP BY delivery_date;

CREATE OR REPLACE VIEW vw_active_centres AS
SELECT centre_id, centre_name, district, status
FROM collection_centres
WHERE status = 'ACTIVE'
WITH CHECK OPTION CONSTRAINT ck_vw_active_centres;

SELECT view_name FROM user_views ORDER BY view_name;
SELECT * FROM vw_centre_summary;
SELECT * FROM vw_delivery_report FETCH FIRST 5 ROWS ONLY;

PROMPT === Test: READ ONLY view must refuse DML (expect ORA-42399) ===
DELETE FROM vw_delivery_report WHERE delivery_id = 1;

PROMPT === Test: CHECK OPTION must refuse an INACTIVE row (expect ORA-01402) ===
INSERT INTO vw_active_centres (centre_name, district, status) VALUES ('View Test', 'Test', 'INACTIVE');
ROLLBACK;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') AS run_time FROM dual;