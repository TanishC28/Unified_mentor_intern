USE employee_attrition;
SELECT * FROM employees;

CREATE TABLE employees_staging LIKE employees;
SELECT * FROM employees_staging;
INSERT INTO employees_staging SELECT * FROM employees;

-- Attrition Rate
SELECT COUNT(*) AS total_employees, 
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_attrition,
(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS attrition_rate
FROM employees_staging;

-- Attrition Rate by Department
SELECT Department,
COUNT(*) AS total_employees, 
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_attrition,
(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS attrition_rate
FROM employees_staging
GROUP BY Department;


-- Performance and Attrition
SELECT PerformanceRating, 
COUNT(*) AS total_employees,
SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS total_attrition,
(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS attrition_rate
FROM employees_staging
GROUP BY PerformanceRating;

-- Average Tenure
SELECT AVG(YearsAtCompany) AS average_tenure FROM employees_staging;

-- Tenure Based Attrition Rate
SELECT 
CASE 
	WHEN YearsAtCompany < 1 THEN 'Less than 1 year'
	WHEN YearsAtCompany BETWEEN 1 AND 3 THEN '1-3 years'
	WHEN YearsAtCompany BETWEEN 3 AND 5 THEN '3-5 years'
	ELSE 'More than 5 years'
END AS tenure_range,
(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS attrition_rate
FROM employees_staging
GROUP BY tenure_range;


-- Age Based Attrition Rate
SELECT 
CASE 
	WHEN Age < 30 THEN 'Under 30'
	WHEN Age BETWEEN 30 AND 40 THEN '30-40'
	WHEN Age BETWEEN 40 AND 50 THEN '40-50'
	ELSE 'Above 50'
END AS age_group,
(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS attrition_rate
FROM employees_staging
GROUP BY age_group;

-- Work Life Balance Based Attrition Rate
SELECT WorkLifeBalance,
(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS attrition_rate
FROM employees_staging
GROUP BY WorkLifeBalance
ORDER BY WorkLifeBalance;

-- Job Satisfaction Based Attrition Rate
SELECT JobSatisfaction,
(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS attrition_rate
FROM employees_staging
GROUP BY JobSatisfaction
ORDER BY JobSatisfaction;

-- Promotion Based Attrition Rate
SELECT YearsSinceLastPromotion,
(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS attrition_rate
FROM employees_staging
GROUP BY YearsSinceLastPromotion
ORDER BY YearsSinceLastPromotion;

-- Managerial Relationship Based
SELECT YearsWithCurrManager,
(SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) / COUNT(*)) * 100 AS attrition_rate
FROM employees_staging
GROUP BY YearsWithCurrManager
ORDER BY YearsWithCurrManager;















