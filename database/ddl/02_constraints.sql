-- Name: ISHIMWE Pitie | Student ID: 29767 | Group: B | Project: MilkTrack
SET ECHO ON
SET LINESIZE 200
CONNECT pitie_admin/pitie@//192.168.56.1:1521/b_29767_pitie_milktrack_db
SHOW CON_NAME

-- Primary keys (indexes stored in the index tablespace)
ALTER TABLE collection_centres ADD CONSTRAINT pk_collection_centres PRIMARY KEY (centre_id) USING INDEX TABLESPACE milktrack_idx;
ALTER TABLE farmers ADD CONSTRAINT pk_farmers PRIMARY KEY (farmer_id) USING INDEX TABLESPACE milktrack_idx;
ALTER TABLE payment_rates ADD CONSTRAINT pk_payment_rates PRIMARY KEY (rate_id) USING INDEX TABLESPACE milktrack_idx;
ALTER TABLE milk_deliveries ADD CONSTRAINT pk_milk_deliveries PRIMARY KEY (delivery_id) USING INDEX TABLESPACE milktrack_idx;
ALTER TABLE quality_tests ADD CONSTRAINT pk_quality_tests PRIMARY KEY (test_id) USING INDEX TABLESPACE milktrack_idx;
ALTER TABLE payments ADD CONSTRAINT pk_payments PRIMARY KEY (payment_id) USING INDEX TABLESPACE milktrack_idx;

-- Unique constraints
ALTER TABLE collection_centres ADD CONSTRAINT uq_collection_centres_centre_name UNIQUE (centre_name) USING INDEX TABLESPACE milktrack_idx;
ALTER TABLE farmers ADD CONSTRAINT uq_farmers_phone UNIQUE (phone) USING INDEX TABLESPACE milktrack_idx;
ALTER TABLE payment_rates ADD CONSTRAINT uq_payment_rates_grade_date UNIQUE (grade, effective_date) USING INDEX TABLESPACE milktrack_idx;
ALTER TABLE quality_tests ADD CONSTRAINT uq_quality_tests_delivery_id UNIQUE (delivery_id) USING INDEX TABLESPACE milktrack_idx;
ALTER TABLE payments ADD CONSTRAINT uq_payments_delivery_id UNIQUE (delivery_id) USING INDEX TABLESPACE milktrack_idx;

-- Check constraints
ALTER TABLE collection_centres ADD CONSTRAINT ck_collection_centres_status CHECK (status IN ('ACTIVE','INACTIVE'));
ALTER TABLE farmers ADD CONSTRAINT ck_farmers_phone CHECK (REGEXP_LIKE(phone, '^[0-9]{10,15}$'));
ALTER TABLE payment_rates ADD CONSTRAINT ck_payment_rates_grade CHECK (grade IN ('low','medium','high'));
ALTER TABLE payment_rates ADD CONSTRAINT ck_payment_rates_price_per_litre CHECK (price_per_litre > 0);
ALTER TABLE milk_deliveries ADD CONSTRAINT ck_milk_deliveries_litres CHECK (litres > 0 AND litres <= 5000);
ALTER TABLE milk_deliveries ADD CONSTRAINT ck_milk_deliveries_status CHECK (status IN ('PENDING','ACCEPTED','REJECTED'));
ALTER TABLE quality_tests ADD CONSTRAINT ck_quality_tests_ph CHECK (ph BETWEEN 0 AND 14);
ALTER TABLE quality_tests ADD CONSTRAINT ck_quality_tests_temperature CHECK (temperature BETWEEN 0 AND 100);
ALTER TABLE quality_tests ADD CONSTRAINT ck_quality_tests_taste CHECK (taste IN (0,1));
ALTER TABLE quality_tests ADD CONSTRAINT ck_quality_tests_odor CHECK (odor IN (0,1));
ALTER TABLE quality_tests ADD CONSTRAINT ck_quality_tests_fat CHECK (fat IN (0,1));
ALTER TABLE quality_tests ADD CONSTRAINT ck_quality_tests_turbidity CHECK (turbidity IN (0,1));
ALTER TABLE quality_tests ADD CONSTRAINT ck_quality_tests_colour CHECK (colour BETWEEN 0 AND 255);
ALTER TABLE quality_tests ADD CONSTRAINT ck_quality_tests_grade CHECK (grade IN ('low','medium','high'));
ALTER TABLE payments ADD CONSTRAINT ck_payments_amount CHECK (amount >= 0);

-- Foreign keys with delete rules
ALTER TABLE farmers ADD CONSTRAINT fk_farmers_collection_centres
  FOREIGN KEY (centre_id) REFERENCES collection_centres (centre_id) ON DELETE SET NULL;
ALTER TABLE milk_deliveries ADD CONSTRAINT fk_milk_deliveries_farmers
  FOREIGN KEY (farmer_id) REFERENCES farmers (farmer_id);
ALTER TABLE milk_deliveries ADD CONSTRAINT fk_milk_deliveries_collection_centres
  FOREIGN KEY (centre_id) REFERENCES collection_centres (centre_id);
ALTER TABLE quality_tests ADD CONSTRAINT fk_quality_tests_milk_deliveries
  FOREIGN KEY (delivery_id) REFERENCES milk_deliveries (delivery_id) ON DELETE CASCADE;
ALTER TABLE payments ADD CONSTRAINT fk_payments_milk_deliveries
  FOREIGN KEY (delivery_id) REFERENCES milk_deliveries (delivery_id);
ALTER TABLE payments ADD CONSTRAINT fk_payments_farmers
  FOREIGN KEY (farmer_id) REFERENCES farmers (farmer_id);

-- Status of all constraints
COL constraint_name FORMAT A40
COL table_name FORMAT A20
SELECT constraint_name, constraint_type, table_name, status, validated
FROM user_constraints WHERE constraint_name NOT LIKE 'SYS%' ORDER BY table_name, constraint_type, constraint_name;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') AS now FROM dual;