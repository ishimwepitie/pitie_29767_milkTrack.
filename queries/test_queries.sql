-- Name: ISHIMWE Pitie | Student ID: 29767 | Group: B | Project: MilkTrack
-- test_queries.sql - sample analytical queries
CONNECT pitie_admin/pitie@//192.168.56.1:1521/b_29767_pitie_milktrack_db
SET LINESIZE 200 PAGESIZE 60 SERVEROUTPUT ON
SHOW CON_NAME
PROMPT === Q1 Simple SELECT with filter ===
SELECT delivery_id, farmer_id, litres, status FROM milk_deliveries WHERE status='REJECTED' FETCH FIRST 10 ROWS ONLY;

PROMPT === Q2 JOIN (view over 5 tables) ===
SELECT farmer_name, centre_name, delivery_date, litres, grade, amount FROM vw_delivery_report ORDER BY delivery_date, delivery_id FETCH FIRST 10 ROWS ONLY;

PROMPT === Q3 GROUP BY: litres and rejection rate per centre ===
SELECT * FROM vw_centre_summary ORDER BY total_litres DESC;

PROMPT === Q4 GROUP BY + HAVING: grade distribution ===
SELECT grade, COUNT(*) AS tests, ROUND(AVG(ph),2) AS avg_ph FROM quality_tests GROUP BY grade HAVING COUNT(*) > 0 ORDER BY tests DESC;

PROMPT === Q5 Subquery: farmers delivering more than the average farmer ===
SELECT f.full_name, SUM(d.litres) AS total_litres
FROM farmers f JOIN milk_deliveries d ON d.farmer_id = f.farmer_id
GROUP BY f.full_name
HAVING SUM(d.litres) > (SELECT AVG(s) FROM (SELECT SUM(litres) AS s FROM milk_deliveries GROUP BY farmer_id))
ORDER BY total_litres DESC;

PROMPT === Q6 Top 5 farmers by money received ===
SELECT f.full_name, SUM(p.amount) AS total_paid
FROM payments p JOIN farmers f ON f.farmer_id = p.farmer_id
GROUP BY f.full_name ORDER BY total_paid DESC FETCH FIRST 5 ROWS ONLY;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') AS run_time FROM dual;