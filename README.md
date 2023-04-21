# SQL_Engeto_project

# Introduction

You work in the analytical department of an independent organization that focuses on the standard of living of citizens. You and your colleagues have agreed to answer specific research questions about the accessibility of basic food items for the general public. Your colleagues have already formulated these questions and will pass on the information to the press department, which will present the results at a conference on this topic in the near future.

# First research question 

**Q: Has there been an increase in wages in all sectors over the years, or has there been a decrease in some sectors?**

The dataset used in the research comes from the Open Data Portal of the Czech Republic, which contains information on wages in various sectors for the period from 2000 to 2021.

On the basis of the data in the table, wage growth has not been uniform across all industries over the years. There has been a decline in wages in some sectors. For example, in 2009, the average gross wage per employee declined in mining and quarrying, accommodation and food services, wholesale and retail trade, and agriculture, forestry and fishing. In 2013, the average gross salary per employee declined in most industries including Cultural, Entertainment and Recreational Activities, Financial and Insurance Activities, Professional, Scientific and Technical Activities, and Electricity, Gas, Steam, Air Conditioning Supply etc.

_These findings are consistent with the pattern of GDP growth in the Czech Republic, which experienced recessions in 2008, 2013, and 2020._


| Year | Industry |	Average Gross Salary | Trend |	Change 
| :---: | :---: | :---: | :---: | :---: |
| 2013 | Banking and Insurance |	45233.5 CZK | Declining |	-9.0%
| 2020 |	Real Estate Activities |	27611.75 CZK |	Declining |	-7.17%
| 2020 |	Accommodation and Food Service |	18443.75 CZK |	Declining |	-6.87%
| 2009 | Mining and Quarrying |	27960.5 CZK |	Declining |	-4.36%
| 2013 | Electricity and Gas |	40299.75 CZK |	Declining |	-4.29%

see 1.first_query.sql file in the repository

# Second research question

**Q: How many liters of milk and kilograms of bread is it possible to buy for the first and last comparable period in the available data on prices and wages?**

The dataset used in the research comes from the Open Data Portal of the Czech Republic, which contains information on wages in various sectors and information about prices of selected food products for the period from 2006 to 20018.

For the first comparable period in the available data (2006), it is possible to buy 1,409 liters of milk and 1,262 kilograms of bread with 20,342 CZK. For the last comparable period (2018), it is possible to buy 1,614 liters of milk and 1,319 kilograms of bread with 31,980 CZK.

| Year | Food product |	mean price per unit| average salary |	units for avg salary
| :---: | :---: | :---: | :---: | :---: |
| 2006 | Chléb konzumní kmínový |	16.12 czk per kg | 20,342 czk|	1,262 kg
| 2006 | Mléko polotučné pasterované |	14.44 czk per l |	20,342 czk|	1,409 l
| 2018 | Chléb konzumní kmínový |	24.24 czk per kg |	31,980 czk |	1,319 kg
| 2018 | Mléko polotučné pasterované |	19.82 czk per l |	31,980 czk |	1,614 l

see 2.second_query.sql file in the repository

# Third research question

**Q: Which food category exhibits the least inflationary pressure, indicated by the lowest year-on-year percentage increase in prices?**

The dataset used in the research comes from the Open Data Portal of the Czech Republic, which contains information about prices of selected food products  for the period from 2006 to 20018.

The food category with the least inflationary pressure is  sugar with a decrease of -1.92%. The food category with the lowest year-on-year percentage increase in prices is banana with average annual increase of 0.81%.

| Food product | average price growth rate (%)
| :---: | :---: |
| Cukr krystalový| -1.92 | 
| Rajská jablka červená kulatá | -0.74 |	
| Banány žluté | 0.81 |	
| Vepřová pečeně s kostí | 0.99 |	

see 3.third_query.sql

# Fourth research question 

**Q: Is there a year in which the year-on-year increase in food prices was significantly higher than the increase in wages (greater than 10%)?**

The dataset used in the research comes from the Open Data Portal of the Czech Republic, which contains information on wages in various sectors and information about prices of selected food products for the period from 2006 to 20018. 

There is no year in which the year-on-year increase in food prices was significantly higher than the increase in wages (greater than 10%):

| Year | Aggregate avg price growth |	Aggregate avg salary growth| Percentage difference
| :---: | :---: | :---: | :---: | 
| 2013 | 6.01 |	-0.78 | 6.79|	
| 2012 | 7.47 |	2.83 |	4.64|	
| 2011 | 4.84 |	2.15 |	2.69 |
| 2007 | 9.26 |	6.92 |	2.34 |	

# Fifth research question 

**Q: Does the GDP level affect changes in wages and food prices? In other words, if the GDP increases significantly in one year, will it result in a more significant increase in food prices or wages in the same or following year?**

The dataset used in the research comes from the Open Data Portal of the Czech Republic, which contains information on wages in various sectors, information about prices of selected food products and data about countries in the world concerning their GDP, GINI, tax burden, etc. To accommodate the time constraint in the table in price development, the dataset must be restricted solely to the period from 2006 to 2018 and to only include data for the Czechia.

Without further analysis, it is difficult to draw a definite conclusion about the relationship between changes in GDP, wages, and food prices based on the given dataset. The relationship between these variables is inconclusive and does not allow us to determine whether there is a significant impact of GDP on wages and food prices.

| Year | GDP growth (CZE) | Aggregate avg price growth (CZE)|	Aggregate avg salary growth (CZE)|
| :---: | :---: | :---: | :---: | 
| 2007|	5.57|	9.26|	6.92|
|2008|	2.69|	8.92|	7.41|
|2009|	-4.66|	-6.59|	3.11|
|2010|	2.43|	1.52|	2.19|
|2011|	1.76|	4.84|	2.15|
|2012|	-0.79|	7.47|	2.83|
|2013|	-0.05|	6.01|	-0.78|
|2014|	2.26|	-0.62|	2.49|
|2015|	5.39|	-0.69|	2.78|
|2016|2.54|	-1.4|	3.97|
|2017|	5.17|	7.06|	6.73|
|2018|	3.2|	2.41|	7.67|

See 5.fifth_query.sql 









