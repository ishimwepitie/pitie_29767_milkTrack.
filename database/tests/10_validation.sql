-- Name: ISHIMWE Pitie | Student ID: 29767 | Group: B | Project: MilkTrack
-- 10_validation.sql - counts, orphans, rules, status
CONNECT pitie_admin/pitie@//192.168.56.1:1521/b_29767_pitie_milktrack_db
SET LINESIZE 200 PAGESIZE 60 SERVEROUTPUT ON
SHOW CON_NAME
PROMPT === 1. Row counts (expected 5/50/3/1059/1059/1059) ===
SELECT 'collection_centres' AS tbl, COUNT(*) AS rows_count FROM collection_centres UNION ALL
SELECT 'farmers', COUNT(*) FROM farmers UNION ALL
SELECT 'payment_rates', COUNT(*) FROM payment_rates UNION ALL
SELECT 'milk_deliveries', COUNT(*) FROM milk_deliveries UNION ALL
SELECT 'quality_tests', COUNT(*) FROM quality_tests UNION ALL
SELECT 'payments', COUNT(*) FROM payments;

PROMPT === 2. Orphan rows (all must be 0) ===
SELECT 'deliveries without farmer' AS check_name, COUNT(*) AS problems FROM milk_deliveries d WHERE NOT EXISTS (SELECT 1 FROM farmers f WHERE f.farmer_id=d.farmer_id) UNION ALL
SELECT 'deliveries without centre', COUNT(*) FROM milk_deliveries d WHERE NOT EXISTS (SELECT 1 FROM collection_centres c WHERE c.centre_id=d.centre_id) UNION ALL
SELECT 'tests without delivery', COUNT(*) FROM quality_tests q WHERE NOT EXISTS (SELECT 1 FROM milk_deliveries d WHERE d.delivery_id=q.delivery_id) UNION ALL
SELECT 'payments without delivery', COUNT(*) FROM payments p WHERE NOT EXISTS (SELECT 1 FROM milk_deliveries d WHERE d.delivery_id=p.delivery_id) UNION ALL
SELECT 'farmers with unknown centre', COUNT(*) FROM farmers f WHERE f.centre_id IS NOT NULL AND NOT EXISTS (SELECT 1 FROM collection_centres c WHERE c.centre_id=f.centre_id);

PROMPT === 3. Business rules (all must be 0) ===
SELECT 'deliveries without test' AS check_name, COUNT(*) AS problems FROM milk_deliveries d WHERE NOT EXISTS (SELECT 1 FROM quality_tests q WHERE q.delivery_id=d.delivery_id) UNION ALL
SELECT 'deliveries without payment', COUNT(*) FROM milk_deliveries d WHERE NOT EXISTS (SELECT 1 FROM payments p WHERE p.delivery_id=d.delivery_id) UNION ALL
SELECT 'amount different from litres x rate', COUNT(*)
  FROM milk_deliveries d JOIN quality_tests q ON q.delivery_id=d.delivery_id
  JOIN payment_rates r ON r.grade=q.grade JOIN payments p ON p.delivery_id=d.delivery_id
  WHERE p.amount <> CASE WHEN d.status='ACCEPTED' THEN d.litres*r.price_per_litre ELSE 0 END UNION ALL
SELECT 'low grade not rejected', COUNT(*) FROM milk_deliveries d JOIN quality_tests q ON q.delivery_id=d.delivery_id WHERE q.grade='low' AND d.status<>'REJECTED';

PROMPT === 4. Constraints (all ENABLED / VALIDATED) ===
SELECT constraint_type, status, validated, COUNT(*) AS total FROM user_constraints GROUP BY constraint_type, status, validated ORDER BY 1;

PROMPT === 5. Invalid objects (expect no rows) ===
SELECT object_name, object_type FROM user_objects WHERE status <> 'VALID';

PROMPT === 6. Duplicates flagged in cleaning ===
SELECT * FROM cleaning_log ORDER BY 1;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') AS run_time FROM dual;