-- Má výška HDP vliv na změny ve mzdách a cenách potravin? Neboli, pokud HDP vzroste výrazněji v jednom roce, 
-- projeví se to na cenách potravin či mzdách ve stejném nebo násdujícím roce výraznějším růstem?

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
), 
avg_salary_trend AS ( 
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
), 
gdp_growth_trend AS (
    SELECT
        tsm.country,
	tsm.`year`,
	tsm.GDP,
	LAG(tsm.GDP) OVER (ORDER BY tsm.`year`) AS gdp_previous_year,
    	(tsm.GDP / LAG(tsm.gdp) OVER (PARTITION BY tsm.country ORDER BY tsm.`year`) - 1) * 100 AS gdp_growth
    FROM t_petr_matejicek_project_SQL_secondary_final tsm
    WHERE tsm.country = 'Czech Republic'
)	
SELECT
    ggt.year,
    ROUND(ggt.gdp_growth,2) AS gdp_growth_czechia,
    ROUND(AVG(apt.avg_price_growth_percent),2) AS aggregate_avg_price_growth,
    ROUND(AVG(ast.avg_salary_growth),2) AS aggregate_avg_salary_growth
FROM gdp_growth_trend ggt
JOIN avg_salary_trend ast ON ggt.year = ast.year
JOIN avg_price_trend apt ON ggt.year = apt.YEAR
WHERE ggt.gdp_growth IS NOT NULL
GROUP BY ggt.year;
