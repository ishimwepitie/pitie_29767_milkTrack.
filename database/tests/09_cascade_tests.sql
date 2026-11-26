-- Name: ISHIMWE Pitie | Student ID: 29767 | Group: B | Project: MilkTrack
-- 09_cascade_tests.sql - ON DELETE CASCADE and SET NULL (all rolled back)
CONNECT pitie_admin/pitie@//192.168.56.1:1521/b_29767_pitie_milktrack_db
SET LINESIZE 200 PAGESIZE 60 SERVEROUTPUT ON
SHOW CON_NAME
DECLARE
  n NUMBER; c NUMBER; fid NUMBER; cid NUMBER;
BEGIN
  -- CASCADE: deleting a delivery deletes its quality test
  SELECT COUNT(*) INTO n FROM quality_tests WHERE delivery_id = 1;
  DBMS_OUTPUT.PUT_LINE('CASCADE before: tests for delivery 1 = '||n);
  DELETE FROM payments WHERE delivery_id = 1;          -- payment (NO ACTION) must go first
  DELETE FROM milk_deliveries WHERE delivery_id = 1;
  SELECT COUNT(*) INTO n FROM quality_tests WHERE delivery_id = 1;
  DBMS_OUTPUT.PUT_LINE('CASCADE after : tests for delivery 1 = '||n||'  (expected 0)');
  ROLLBACK;

  -- SET NULL: deleting a centre keeps the farmer, centre_id becomes NULL
  INSERT INTO collection_centres(centre_name,district) VALUES ('Temp Centre','Test') RETURNING centre_id INTO cid;
  INSERT INTO farmers(full_name,phone,centre_id) VALUES ('Temp Farmer','0799999999',cid) RETURNING farmer_id INTO fid;
  DELETE FROM collection_centres WHERE centre_id = cid;
  SELECT COUNT(*) INTO n FROM farmers WHERE farmer_id = fid;
  SELECT COUNT(*) INTO c FROM farmers WHERE farmer_id = fid AND centre_id IS NULL;
  DBMS_OUTPUT.PUT_LINE('SET NULL: farmer still exists = '||n||', centre_id is NULL = '||c||'  (expected 1 and 1)');
  ROLLBACK;
END;
/
SELECT COUNT(*) AS tests_after_rollback FROM quality_tests;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') AS run_time FROM dual;