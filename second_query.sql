-- Kolik je možné si koupit litrů mléka a kilogramů chleba za první a poslední srovnatelné období v dostupných datech cen a mezd?

WITH price_section AS (
	SELECT 
		year,
		name AS food_product,
		average_value,
		unit
	FROM t_petr_matejicek_project_SQL_primary_final
	WHERE year IN 
		(SELECT MIN(`year`)  
		FROM t_petr_matejicek_project_SQL_primary_final
		WHERE data_type = 'Průměrná cena za jednotku'
		UNION
		SELECT MAX(`year`)
		FROM t_petr_matejicek_project_SQL_primary_final
		WHERE data_type = 'Průměrná cena za jednotku')
		AND (name LIKE '%Mléko%' OR name LIKE '%chléb%')
), 
salary_section AS (
	SELECT 
		year,
		data_type,
		ROUND(AVG(average_value), 2) AS avg_payroll,
		unit
	FROM t_petr_matejicek_project_SQL_primary_final
	WHERE year IN 
		(SELECT MIN(`year`)  
		FROM t_petr_matejicek_project_SQL_primary_final
		WHERE data_type = 'Průměrná cena za jednotku'
		UNION
		SELECT MAX(`year`)
		FROM t_petr_matejicek_project_SQL_primary_final
		WHERE data_type = 'Průměrná cena za jednotku')
		AND data_type = 'Průměrná hrubá mzda na zaměstnance'
	GROUP BY year, data_type
)
SELECT 	
	ps.year,
	ps.food_product,
	CONCAT(FORMAT(ps.average_value, 2), ' czk per ', ps.unit) AS mean_price_per_unit,
	CONCAT(FORMAT(ss.avg_payroll, 0), ' czk') AS average_salary,
	CONCAT(FORMAT(ss.avg_payroll / ps.average_value, 0), ' ', ps.unit) AS units_for_avg_salary
FROM price_section ps
JOIN salary_section ss ON ps.year = ss.year;
