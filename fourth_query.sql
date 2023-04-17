-- Existuje rok, ve kterém byl meziroční nárůst cen potravin výrazně vyšší než růst mezd (větší než 10 %)?

WITH avg_price_trend AS (
  SELECT 
    tpm.`year` AS year,
    tpm.name AS food_product,
    tpm.data_type, 
    AVG(tpm.average_value) AS avg_price,
    LAG(tpm.average_value) OVER (PARTITION BY tpm.name ORDER BY tpm.`year`) AS avg_previous_year,
    (tpm.average_value / LAG(tpm.average_value) OVER (PARTITION BY tpm.name ORDER BY tpm.`year`) - 1) * 100 AS avg_price_growth_percent
  FROM t_petr_matejicek_project_SQL_primary_final tpm
  WHERE tpm.data_type = 'Průměrná cena za jednotku'
  GROUP BY tpm.`year`, tpm.name, tpm.data_type
), avg_salary_trend AS ( 
  SELECT 
    tpm.`year` AS year,
    tpm.name AS salary_branch,
    tpm.data_type, 
    AVG(tpm.average_value) AS avg_salary,
    LAG(tpm.average_value) OVER (PARTITION BY tpm.name ORDER BY tpm.`year`) AS avg_previous_year,
    (tpm.average_value / LAG(tpm.average_value) OVER (PARTITION BY tpm.name ORDER BY tpm.`year`) - 1) * 100 AS avg_salary_growth
  FROM t_petr_matejicek_project_SQL_primary_final tpm
  WHERE tpm.data_type = 'Průměrná hrubá mzda na zaměstnance'
  GROUP BY tpm.`year`, tpm.name, tpm.data_type  
)
SELECT 
  apt.year,
  ROUND(AVG(apt.avg_price_growth_percent),2) AS aggregate_avg_price_growth,
  ROUND(AVG(ast.avg_salary_growth),2) AS aggregate_avg_salary_growth,
  ROUND(AVG(apt.avg_price_growth_percent) - AVG(ast.avg_salary_growth),2) AS percentage_difference
FROM avg_price_trend apt
JOIN avg_salary_trend ast ON apt.year = ast.year
GROUP BY apt.year
HAVING AVG(apt.avg_price_growth_percent) > AVG(ast.avg_salary_growth)
ORDER BY apt.year ASC;

