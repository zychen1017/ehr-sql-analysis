-- =====================================
-- Project: EHR SQL Analysis
-- Author: Joey
-- Database: Synthea EHR
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
