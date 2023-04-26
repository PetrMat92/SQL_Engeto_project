-- Rostou v průběhu let mzdy ve všech odvětvích, nebo v některých klesají?

WITH avg_sal_trend AS (
  SELECT 
    tpm.`year` AS year,
    tpm.name AS industry_branch,
    tpm.data_type, 
    AVG(tpm.average_value) AS avg_salary,
    AVG(tpm.average_value) > (
      SELECT AVG(tpm2.average_value)
      FROM t_petr_matejicek_project_SQL_primary_final tpm2
      WHERE tpm2.`year` = tpm.`year` - 1
      	AND tpm2.name = tpm.name
      	AND tpm2.data_type = 'Průměrná hrubá mzda na zaměstnance' 
      GROUP BY tpm2.name 
    ) AS salary_trend,
    LAG(tpm.average_value) OVER (PARTITION BY tpm.name ORDER BY tpm.`year`) AS avg_previous_year,
	 tpm.average_value / LAG(tpm.average_value) OVER (PARTITION BY tpm.name ORDER BY tpm.`year`) AS average_growth
  FROM t_petr_matejicek_project_SQL_primary_final tpm
  GROUP BY tpm.`year`, tpm.name, tpm.data_type
)
SELECT 
  year, 
  industry_branch,
  data_type,
  avg_salary, 
  CASE 
    WHEN salary_trend THEN 'Rising'
    ELSE 'Declining'
  END AS salary_trend,
  ROUND((avg_sal_trend.average_growth - 1) * 100, 2) AS growth_rate
FROM avg_sal_trend
WHERE data_type = 'Průměrná hrubá mzda na zaměstnance'
  AND salary_trend = FALSE 
ORDER BY year, industry_branch;

