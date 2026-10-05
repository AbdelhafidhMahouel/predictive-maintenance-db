-- 02_load_data.sql
-- Loads the five CSV files into the tables.
-- The files were placed in C:\temp. Change the path if yours is different.
-- Run one statement at a time, machines first (the others reference it).

COPY machines FROM 'C:\temp\PdM_machines.csv'
WITH (FORMAT csv, HEADER true);

COPY telemetry FROM 'C:\temp\PdM_telemetry.csv'
WITH (FORMAT csv, HEADER true);

-- The event tables have a serial key that is not in the files,
-- so the columns to load are listed.

COPY errors (error_time, machine_id, error_id) FROM 'C:\temp\PdM_errors.csv'
WITH (FORMAT csv, HEADER true);

COPY maintenance (maint_time, machine_id, component) FROM 'C:\temp\PdM_maint.csv'
WITH (FORMAT csv, HEADER true);

COPY failures (failure_time, machine_id, component) FROM 'C:\temp\PdM_failures.csv'
WITH (FORMAT csv, HEADER true);
