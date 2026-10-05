-- 04_analysis_queries.sql
-- The analysis queries shown in the report.

-- Query 1: Which component fails most?
SELECT component, COUNT(*) AS total_failures
FROM failures
GROUP BY component
ORDER BY total_failures DESC;

-- Query 2: Which machine model fails most, per machine?
SELECT m.model,
       COUNT(DISTINCT m.machine_id) AS machines,
       COUNT(f.failure_no)          AS total_failures,
       ROUND(COUNT(f.failure_no)::numeric
             / COUNT(DISTINCT m.machine_id), 2) AS failures_per_machine
FROM machines m
LEFT JOIN failures f ON f.machine_id = m.machine_id
GROUP BY m.model
ORDER BY failures_per_machine DESC;

-- Query 3: Do older machines fail more?
SELECT CASE WHEN m.age <= 5  THEN '0-5 years'
            WHEN m.age <= 10 THEN '6-10 years'
            WHEN m.age <= 15 THEN '11-15 years'
            ELSE '16-20 years' END AS age_group,
       COUNT(DISTINCT m.machine_id) AS machines,
       COUNT(f.failure_no)          AS total_failures,
       ROUND(COUNT(f.failure_no)::numeric
             / COUNT(DISTINCT m.machine_id), 2) AS failures_per_machine
FROM machines m
LEFT JOIN failures f ON f.machine_id = m.machine_id
GROUP BY 1
ORDER BY MIN(m.age);

-- Query 4: Do the sensors change in the 24 hours before a failure?
SELECT 'All readings' AS period,
       ROUND(AVG(volt), 2)      AS avg_volt,
       ROUND(AVG(rotate), 2)    AS avg_rotate,
       ROUND(AVG(pressure), 2)  AS avg_pressure,
       ROUND(AVG(vibration), 2) AS avg_vibration
FROM telemetry
UNION ALL
SELECT '24 hours before a failure',
       ROUND(AVG(t.volt), 2),
       ROUND(AVG(t.rotate), 2),
       ROUND(AVG(t.pressure), 2),
       ROUND(AVG(t.vibration), 2)
FROM failures f
JOIN telemetry t
  ON t.machine_id = f.machine_id
 AND t.reading_time >= f.failure_time - INTERVAL '24 hours'
 AND t.reading_time <  f.failure_time;

-- Query 5: The ten machines with the most failures.
SELECT m.machine_id, m.model, m.age,
       (SELECT COUNT(*) FROM failures f     WHERE f.machine_id  = m.machine_id) AS failures,
       (SELECT COUNT(*) FROM errors e       WHERE e.machine_id  = m.machine_id) AS errors,
       (SELECT COUNT(*) FROM maintenance mt WHERE mt.machine_id = m.machine_id) AS maintenance_records
FROM machines m
ORDER BY failures DESC, errors DESC
LIMIT 10;
