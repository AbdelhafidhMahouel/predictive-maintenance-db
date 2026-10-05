-- 05_add_indexes.sql
-- Optional: indexes on the foreign key columns of the three event tables.
-- PostgreSQL does not index foreign keys automatically, so these speed up
-- the joins and per-machine lookups used in 04_analysis_queries.sql.
-- The telemetry table needs no extra index: its primary key
-- (machine_id, reading_time) already covers lookups by machine and time.

CREATE INDEX IF NOT EXISTS idx_errors_machine_id      ON errors (machine_id);
CREATE INDEX IF NOT EXISTS idx_maintenance_machine_id ON maintenance (machine_id);
CREATE INDEX IF NOT EXISTS idx_failures_machine_id    ON failures (machine_id);

-- Refresh the planner statistics after loading the data.
ANALYZE;
