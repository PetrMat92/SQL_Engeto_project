CREATE TABLE IF NOT EXISTS t_petr_matejicek_project_SQL_secondary_final AS (
    SELECT
        c.country,
	e.`year`, 
	e.GDP
	e.gini
	e.taxes
    FROM countries c 
    JOIN economies e 
	ON c.country = e.country
    WHERE e.`year`BETWEEN 
        (SELECT MIN(`year`)  
        FROM t_petr_matejicek_project_SQL_primary_final
	WHERE data_type = 'Průměrná cena za jednotku') 
	    AND (SELECT MAX(`year`)
		FROM t_petr_matejicek_project_SQL_primary_final
		WHERE data_type = 'Průměrná cena za jednotku')
    ORDER BY c.country, e.`year`);
