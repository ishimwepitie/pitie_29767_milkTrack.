-- Name: ISHIMWE Pitie | Student ID: 29767 | Group: B | Project: MilkTrack
SET ECHO ON
SET LINESIZE 200
CONNECT pitie_admin/pitie@//192.168.56.1:1521/b_29767_pitie_milktrack_db
SHOW CON_NAME

-- 1. Parent: collection_centres (simulated)
INSERT INTO collection_centres (centre_name, district) VALUES ('Musanze Centre', 'Musanze');
INSERT INTO collection_centres (centre_name, district) VALUES ('Huye Centre', 'Huye');
INSERT INTO collection_centres (centre_name, district) VALUES ('Rubavu Centre', 'Rubavu');
INSERT INTO collection_centres (centre_name, district) VALUES ('Nyagatare Centre', 'Nyagatare');
INSERT INTO collection_centres (centre_name, district) VALUES ('Rwamagana Centre', 'Rwamagana');

-- 2. Parent: payment_rates (grade prices)
INSERT INTO payment_rates (grade, price_per_litre) VALUES ('high', 500);
INSERT INTO payment_rates (grade, price_per_litre) VALUES ('medium', 400);
INSERT INTO payment_rates (grade, price_per_litre) VALUES ('low', 250);

-- 3. Parent: farmers (50 simulated farmers spread over the 5 centres)
INSERT INTO farmers (full_name, phone, centre_id)
SELECT 'Farmer ' || LPAD(LEVEL, 3, '0'), '078800' || LPAD(LEVEL, 4, '0'), MOD(LEVEL - 1, 5) + 1
FROM dual CONNECT BY LEVEL <= 50;

-- 4. Child: milk_deliveries (one delivery for every cleaned sample)
INSERT INTO milk_deliveries (farmer_id, centre_id, delivery_date, litres, status)
SELECT f.farmer_id, f.centre_id,
       DATE '2026-09-01' + MOD(c.src_row - 1, 60),
       10 + MOD(c.src_row * 7, 91),
       CASE c.grade WHEN 'low' THEN 'REJECTED' ELSE 'ACCEPTED' END
FROM clean_milk c
JOIN farmers f ON f.farmer_id = MOD(c.src_row - 1, 50) + 1
ORDER BY c.src_row;

-- 5. Child: quality_tests (the real Kaggle measurements)
INSERT INTO quality_tests (delivery_id, ph, temperature, taste, odor, fat, turbidity, colour, grade)
SELECT d.delivery_id, c.ph, c.temperature, c.taste, c.odor, c.fat, c.turbidity, c.colour, c.grade
FROM clean_milk c
JOIN (SELECT delivery_id, ROW_NUMBER() OVER (ORDER BY delivery_id) AS rn FROM milk_deliveries) d
  ON d.rn = c.src_row;

-- 6. Child: payments (0 for rejected batches)
INSERT INTO payments (delivery_id, farmer_id, amount, payment_date)
SELECT d.delivery_id, d.farmer_id,
       CASE WHEN d.status = 'ACCEPTED' THEN ROUND(d.litres * r.price_per_litre, 2) ELSE 0 END,
       d.delivery_date + 2
FROM milk_deliveries d
JOIN quality_tests q ON q.delivery_id = d.delivery_id
JOIN payment_rates r ON r.grade = q.grade;

COMMIT;

SELECT 'collection_centres' AS table_name, COUNT(*) AS row_count FROM collection_centres
UNION ALL SELECT 'farmers', COUNT(*) FROM farmers
UNION ALL SELECT 'payment_rates', COUNT(*) FROM payment_rates
UNION ALL SELECT 'milk_deliveries', COUNT(*) FROM milk_deliveries
UNION ALL SELECT 'quality_tests', COUNT(*) FROM quality_tests
UNION ALL SELECT 'payments', COUNT(*) FROM payments;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') AS now FROM dual;