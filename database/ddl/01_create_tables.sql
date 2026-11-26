-- Name: ISHIMWE Pitie | Student ID: 29767 | Group: B | Project: MilkTrack
SET ECHO ON
CONNECT pitie_admin/pitie@//192.168.56.1:1521/b_29767_pitie_milktrack_db
SHOW USER
SHOW CON_NAME

CREATE TABLE collection_centres (
  centre_id    NUMBER(10) GENERATED ALWAYS AS IDENTITY,
  centre_name  VARCHAR2(60) CONSTRAINT nn_collection_centres_centre_name NOT NULL,
  district     VARCHAR2(40) CONSTRAINT nn_collection_centres_district NOT NULL,
  status       VARCHAR2(10) DEFAULT 'ACTIVE' CONSTRAINT nn_collection_centres_status NOT NULL
) TABLESPACE milktrack_data;

CREATE TABLE farmers (
  farmer_id        NUMBER(10) GENERATED ALWAYS AS IDENTITY,
  full_name        VARCHAR2(80) CONSTRAINT nn_farmers_full_name NOT NULL,
  phone            VARCHAR2(15) CONSTRAINT nn_farmers_phone NOT NULL,
  centre_id        NUMBER(10),
  registered_date  DATE DEFAULT SYSDATE CONSTRAINT nn_farmers_registered_date NOT NULL
) TABLESPACE milktrack_data;

CREATE TABLE payment_rates (
  rate_id          NUMBER(10) GENERATED ALWAYS AS IDENTITY,
  grade            VARCHAR2(10) CONSTRAINT nn_payment_rates_grade NOT NULL,
  price_per_litre  NUMBER(8,2) CONSTRAINT nn_payment_rates_price_per_litre NOT NULL,
  effective_date   DATE DEFAULT SYSDATE CONSTRAINT nn_payment_rates_effective_date NOT NULL
) TABLESPACE milktrack_data;

CREATE TABLE milk_deliveries (
  delivery_id    NUMBER(10) GENERATED ALWAYS AS IDENTITY,
  farmer_id      NUMBER(10) CONSTRAINT nn_milk_deliveries_farmer_id NOT NULL,
  centre_id      NUMBER(10) CONSTRAINT nn_milk_deliveries_centre_id NOT NULL,
  delivery_date  DATE DEFAULT SYSDATE CONSTRAINT nn_milk_deliveries_delivery_date NOT NULL,
  litres         NUMBER(6,2) CONSTRAINT nn_milk_deliveries_litres NOT NULL,
  status         VARCHAR2(10) DEFAULT 'PENDING' CONSTRAINT nn_milk_deliveries_status NOT NULL
) TABLESPACE milktrack_data;

CREATE TABLE quality_tests (
  test_id      NUMBER(10) GENERATED ALWAYS AS IDENTITY,
  delivery_id  NUMBER(10) CONSTRAINT nn_quality_tests_delivery_id NOT NULL,
  ph           NUMBER(3,1) CONSTRAINT nn_quality_tests_ph NOT NULL,
  temperature  NUMBER(3) CONSTRAINT nn_quality_tests_temperature NOT NULL,
  taste        NUMBER(1) CONSTRAINT nn_quality_tests_taste NOT NULL,
  odor         NUMBER(1) CONSTRAINT nn_quality_tests_odor NOT NULL,
  fat          NUMBER(1) CONSTRAINT nn_quality_tests_fat NOT NULL,
  turbidity    NUMBER(1) CONSTRAINT nn_quality_tests_turbidity NOT NULL,
  colour       NUMBER(3) CONSTRAINT nn_quality_tests_colour NOT NULL,
  grade        VARCHAR2(10) CONSTRAINT nn_quality_tests_grade NOT NULL
) TABLESPACE milktrack_data;

CREATE TABLE payments (
  payment_id    NUMBER(10) GENERATED ALWAYS AS IDENTITY,
  delivery_id   NUMBER(10) CONSTRAINT nn_payments_delivery_id NOT NULL,
  farmer_id     NUMBER(10) CONSTRAINT nn_payments_farmer_id NOT NULL,
  amount        NUMBER(10,2) CONSTRAINT nn_payments_amount NOT NULL,
  payment_date  DATE DEFAULT SYSDATE CONSTRAINT nn_payments_payment_date NOT NULL
) TABLESPACE milktrack_data;

SELECT table_name, tablespace_name FROM user_tables ORDER BY table_name;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') AS now FROM dual;