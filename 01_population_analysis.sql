-- =====================================
-- Project: EHR SQL Analysis
-- Author: Joey
-- Module: Population Analysis
-- Database: Synthea EHR (PostgreSQL)
-- =====================================

-- 1. Total patients
SELECT COUNT(*) AS total_patients
FROM patients;

-- 2. Gender distribution
SELECT 
    gender,
    COUNT(*) AS patient_count
FROM patients
GROUP BY gender
ORDER BY patient_count DESC;

-- 3. Age group distribution
WITH base AS (
  SELECT
    EXTRACT(YEAR FROM AGE(CURRENT_DATE, birth_date))::int AS age
  FROM patients
),
bucket AS (
  SELECT
    CASE
      WHEN age BETWEEN 0 AND 17 THEN '0-17'
      WHEN age BETWEEN 18 AND 34 THEN '18-34'
      WHEN age BETWEEN 35 AND 49 THEN '35-49'
      WHEN age BETWEEN 50 AND 64 THEN '50-64'
      ELSE '65+'
    END AS age_group,
    CASE
      WHEN age BETWEEN 0 AND 17 THEN 1
      WHEN age BETWEEN 18 AND 34 THEN 2
      WHEN age BETWEEN 35 AND 49 THEN 3
      WHEN age BETWEEN 50 AND 64 THEN 4
      ELSE 5
    END AS age_group_rank
  FROM base
)
SELECT
  age_group,
  COUNT(*) AS patient_count
FROM bucket
GROUP BY age_group, age_group_rank
ORDER BY age_group_rank;
