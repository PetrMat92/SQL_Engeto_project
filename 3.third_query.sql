-- Která kategorie potravin zdražuje nejpomaleji (je u ní nejnižší percentuální meziroční nárůst)?

WITH avg_price_trend AS (
  SELECT 
      tpm.`year` AS year,
      tpm.name AS food_product,
      tpm.data_type, 
      AVG(tpm.average_value) AS avg_price,
      LAG(tpm.average_value) OVER (PARTITION BY tpm.name ORDER BY tpm.`year`) AS avg_previous_year,
      (tpm.average_value / LAG(tpm.average_value) OVER (PARTITION BY tpm.name ORDER BY tpm.`year`) - 1) * 100 AS average_growth_percent
  FROM t_petr_matejicek_project_SQL_primary_final tpm
  WHERE tpm.data_type = 'Průměrná cena za jednotku'
  GROUP BY tpm.`year`, tpm.name, tpm.data_type
)
SELECT 
    food_product,
    ROUND(SUM(average_growth_percent) / (COUNT(*) - 1), 2) AS average_growth_rate  
FROM avg_price_trend
GROUP BY food_product
ORDER BY average_growth_rate ASC;
