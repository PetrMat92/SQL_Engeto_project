
-- 1) This query calculates the average value for payroll and price data from two different tables, grouped by year and name. 
-- 2) It includes a UNION operation to combine the results and calculates the average price per unit. 
-- 3) The query uses CTEs (Common Table Expressions) to organize the logic into  separate sections for easier readability.

CREATE TABLE IF NOT EXISTS t_petr_matejicek_project_SQL_primary_final AS (
WITH price_section AS (
    SELECT
        YEAR(cp.date_from) AS year, 
        cpc.name AS name,
        AVG(cp.value) AS avg_price_value,
        cpc.price_unit AS unit
    FROM czechia_price cp 
    JOIN czechia_price_category cpc 
        ON cp.category_code = cpc.code 
    GROUP BY YEAR(cp.date_from), cpc.name, cpc.price_unit 
),
payroll_section AS (
    SELECT
        cp.payroll_year AS year,
        cpib.name,
        cvt.name AS data_type,
        AVG(cp.value) AS average_value,
        cpu.name AS unit
    FROM czechia_payroll cp
    JOIN czechia_payroll_industry_branch cpib 
        ON cp.industry_branch_code = cpib.code 
    JOIN czechia_payroll_unit cpu
        ON cp.unit_code = cpu.code 
    JOIN czechia_payroll_value_type cvt 
        ON cp.value_type_code = cvt.code
    WHERE  cp.value_type_code = 5958 
        AND cp.calculation_code = 100
        AND cp.industry_branch_code IS NOT NULL 
        AND cp.payroll_year BETWEEN 2000 AND 2021 -- Update the WHERE clause here
    GROUP BY cp.payroll_year, cpib.name
    ORDER BY cp.payroll_year, cpib.name 
)
SELECT
    ps.year,
    ps.name,
    ps.data_type,
    ROUND(AVG(ps.average_value),2) AS average_value,
    ps.unit
FROM payroll_section ps
GROUP BY ps.year, ps.name
UNION ALL 
SELECT 
    prs.year,
    prs.name,
    'Průměrná cena za jednotku' AS data_type,
    ROUND(prs.avg_price_value,2) AS average_value,
    prs.unit 
FROM price_section prs
GROUP BY prs.year, prs.name);






