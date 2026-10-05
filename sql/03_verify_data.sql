-- 03_verify_data.sql
-- Checks that the data loaded completely and correctly.

-- Row counts for every table.
-- Expected: machines 100, telemetry 876100, errors 3919,
--           maintenance 3286, failures 761.
SELECT 'machines' AS table_name, COUNT(*) AS row_count FROM machines
UNION ALL SELECT 'telemetry', COUNT(*) FROM telemetry
UNION ALL SELECT 'errors', COUNT(*) FROM errors
UNION ALL SELECT 'maintenance', COUNT(*) FROM maintenance
UNION ALL SELECT 'failures', COUNT(*) FROM failures;

-- Table structure with the data type of every column.
SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'public'
ORDER BY table_name, ordinal_position;

-- Date range of the sensor readings and number of machines reporting.
-- Expected: 2015-01-01 06:00 to 2016-01-01 06:00, 100 machines.
SELECT MIN(reading_time) AS first_reading,
       MAX(reading_time) AS last_reading,
       COUNT(DISTINCT machine_id) AS machines_reporting
FROM telemetry;

-- A sample of each table (run one at a time).
SELECT * FROM machines LIMIT 10;
SELECT * FROM telemetry LIMIT 10;
SELECT * FROM errors LIMIT 10;
SELECT * FROM maintenance LIMIT 10;
SELECT * FROM failures LIMIT 10;
