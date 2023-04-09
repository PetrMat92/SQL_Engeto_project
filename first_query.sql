-- Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

WITH avg_sal_trend AS (
  SELECT cp.payroll_year AS year,
         cpib.code, 
         cpib.name AS industry_branch, 
         AVG(cp.value) AS avg_salary,
         AVG(cp.value) > (
            SELECT AVG(cp2.value)
            FROM czechia_payroll cp2
            WHERE cp2.payroll_year = cp.payroll_year - 1
            AND cp2.industry_branch_code = cp.industry_branch_code
            AND cp2.value_type_code = 5958
            GROUP BY cp2.industry_branch_code
         ) AS salary_trend
  FROM czechia_payroll cp
  JOIN czechia_payroll_industry_branch cpib ON cp.industry_branch_code = cpib.code
  WHERE cp.value_type_code = 5958
  GROUP BY cp.payroll_year, cpib.code, cpib.name
)
SELECT year, industry_branch, avg_salary, 
	CASE WHEN salary_trend 
	 	THEN 'Rising' 
	 	ELSE 'Not Rising' 
	END AS salary_trend
FROM avg_sal_trend
HAVING salary_trend = 'Not Rising' AND year != 2000
ORDER BY year;
