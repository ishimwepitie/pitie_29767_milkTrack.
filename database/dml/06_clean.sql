-- Name: ISHIMWE Pitie | Student ID: 29767 | Group: B | Project: MilkTrack
SET ECHO ON
SET LINESIZE 200
CONNECT pitie_admin/pitie@//192.168.56.1:1521/b_29767_pitie_milktrack_db
SHOW CON_NAME

CREATE TABLE cleaning_log (
  step_no       NUMBER,
  step_name     VARCHAR2(80),
  rows_changed  NUMBER,
  logged_at     DATE DEFAULT SYSDATE
) TABLESPACE milktrack_data;

-- Step 1: trim spaces
INSERT INTO cleaning_log (step_no, step_name, rows_changed)
SELECT 1, 'Trim spaces', COUNT(*) FROM stg_milk
WHERE ph <> TRIM(ph) OR temperature <> TRIM(temperature) OR taste <> TRIM(taste) OR odor <> TRIM(odor)
   OR fat <> TRIM(fat) OR turbidity <> TRIM(turbidity) OR colour <> TRIM(colour) OR grade <> TRIM(grade);
UPDATE stg_milk SET ph = TRIM(ph), temperature = TRIM(temperature), taste = TRIM(taste), odor = TRIM(odor),
  fat = TRIM(fat), turbidity = TRIM(turbidity), colour = TRIM(colour), grade = TRIM(grade);

-- Step 2: merge spelling variants of grade (to lower case)
INSERT INTO cleaning_log (step_no, step_name, rows_changed)
SELECT 2, 'Merge grade spelling variants (lower case)', COUNT(*) FROM stg_milk WHERE grade <> LOWER(grade);
UPDATE stg_milk SET grade = LOWER(grade) WHERE grade <> LOWER(grade);

-- Step 3: rows that cannot be converted to numbers
INSERT INTO cleaning_log (step_no, step_name, rows_changed)
SELECT 3, 'Rows with a value that is not a number', COUNT(*) FROM stg_milk
WHERE VALIDATE_CONVERSION(ph AS NUMBER) = 0 OR VALIDATE_CONVERSION(temperature AS NUMBER) = 0
   OR VALIDATE_CONVERSION(taste AS NUMBER) = 0 OR VALIDATE_CONVERSION(odor AS NUMBER) = 0
   OR VALIDATE_CONVERSION(fat AS NUMBER) = 0 OR VALIDATE_CONVERSION(turbidity AS NUMBER) = 0
   OR VALIDATE_CONVERSION(colour AS NUMBER) = 0;

-- Step 4: rows with an empty value
INSERT INTO cleaning_log (step_no, step_name, rows_changed)
SELECT 4, 'Rows with an empty value', COUNT(*) FROM stg_milk
WHERE ph IS NULL OR temperature IS NULL OR taste IS NULL OR odor IS NULL
   OR fat IS NULL OR turbidity IS NULL OR colour IS NULL OR grade IS NULL;

-- Step 5: convert types into a cleaned table and number the exact duplicates
CREATE TABLE clean_milk TABLESPACE milktrack_data AS
SELECT TO_NUMBER(src_row) AS src_row, TO_NUMBER(ph) AS ph, TO_NUMBER(temperature) AS temperature,
       TO_NUMBER(taste) AS taste, TO_NUMBER(odor) AS odor, TO_NUMBER(fat) AS fat,
       TO_NUMBER(turbidity) AS turbidity, TO_NUMBER(colour) AS colour, grade,
       ROW_NUMBER() OVER (PARTITION BY ph, temperature, taste, odor, fat, turbidity, colour, grade
                          ORDER BY TO_NUMBER(src_row)) AS dup_no
FROM stg_milk;
INSERT INTO cleaning_log (step_no, step_name, rows_changed)
SELECT 5, 'Rows converted to numeric types', COUNT(*) FROM clean_milk;

-- Step 6: exact duplicate rows (flagged, kept as separate samples)
INSERT INTO cleaning_log (step_no, step_name, rows_changed)
SELECT 6, 'Exact duplicate rows flagged (dup_no > 1)', COUNT(*) FROM clean_milk WHERE dup_no > 1;
COMMIT;

COL step_name FORMAT A50
SELECT step_no, step_name, rows_changed FROM cleaning_log ORDER BY step_no;
SELECT grade, COUNT(*) AS rows_per_grade FROM clean_milk GROUP BY grade ORDER BY grade;
SELECT COUNT(*) AS total_rows, COUNT(CASE WHEN dup_no = 1 THEN 1 END) AS unique_rows FROM clean_milk;
SELECT TO_CHAR(SYSDATE,'YYYY-MM-DD HH24:MI:SS') AS now FROM dual;