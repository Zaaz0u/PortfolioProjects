--SELECT *
--FROM `lexical-sol-333520.Portfolio_Data_PH.Covid_deaths`
--WHERE continent is not null
--ORDER BY 3,4


-- Select the data we are going to use
/*
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM `lexical-sol-333520.Portfolio_Data_PH.Covid_deaths`
WHERE continent is not null
ORDER BY 1,2


--Looking at total case vs total deaths
-- Show likelyhood of dying if you contract covid in your country

SELECT location, date, total_cases, new_cases, total_deaths, (total_deaths/total_cases)*100 AS Lethality
FROM `lexical-sol-333520.Portfolio_Data_PH.Covid_deaths`
WHERE location LIKE 'France'
AND continent is not null
ORDER BY 1,2


--Looking at the total case vs the population
--Shows what percentage of the population has been infected

SELECT location, date, population, total_cases, (total_cases/population)*100 AS Percent_Population_infected
FROM `lexical-sol-333520.Portfolio_Data_PH.Covid_deaths`
WHERE location LIKE 'France'
AND continent is not null
ORDER BY 1,2



-- Looking at countries with highest infected rate compared to population

SELECT location, population, MAX(total_cases) AS HighestInfectionCount, MAX((total_cases/population))*100 AS Population_infected
FROM `lexical-sol-333520.Portfolio_Data_PH.Covid_deaths`
WHERE continent is not null
GROUP BY 1,2
ORDER BY Population_infected DESC


-- Looking at countries with highest death count by population

SELECT location, MAX(total_deaths) AS Total_deaths_count
FROM `lexical-sol-333520.Portfolio_Data_PH.Covid_deaths`
WHERE continent is not null
GROUP BY 1
ORDER BY Total_deaths_count DESC


-- Let's check the continents with the highest death count

SELECT continent, MAX(total_deaths) AS Total_deaths_count
FROM `lexical-sol-333520.Portfolio_Data_PH.Covid_deaths`
WHERE continent is not null
GROUP BY 1
ORDER BY Total_deaths_count DESC

--Global numbers

SELECT SUM(new_cases) AS total_cases, SUM(new_deaths) AS total_deaths, SUM(new_deaths)/SUM(new_cases)*100 AS Death_Percentage
FROM `lexical-sol-333520.Portfolio_Data_PH.Covid_deaths`
WHERE new_cases != 0
AND new_deaths != 0
AND continent is not null
--GROUP BY date
ORDER BY 1,2 



-- Looking at Total Population vs Vaccination

SELECT CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations,
SUM(CV.new_vaccinations) OVER (PARTITION BY CD.location ORDER BY CD.location, CD.date) AS Rolling_People_Vaccinated
FROM `lexical-sol-333520.Portfolio_Data_PH.Covid_deaths` AS CD
JOIN `lexical-sol-333520.Portfolio_Data_PH.Covid_vaccination` AS CV
ON CV.location = CD.location AND CV.date = CD.date
WHERE CD.continent is not null
order by 2,3


--USE CTE 

WITH PopvsVac AS (Continent, Location, Date, Population, New_Vaccinations, Rolling_People_Vaccinated)
AS 
(
SELECT CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations,
SUM(CV.new_vaccinations) OVER (PARTITION BY CD.location ORDER BY CD.location, CD.date) AS Rolling_People_Vaccinated
--(Rolling_People_Vacciated/Population)*100
FROM `lexical-sol-333520.Portfolio_Data_PH.Covid_deaths` AS CD
JOIN `lexical-sol-333520.Portfolio_Data_PH.Covid_vaccination` AS CV
ON CV.location = CD.location AND CV.date = CD.date
WHERE CD.continent is not null

)

SELECT *, (Rolling_People_Vaccinated/Population) * 100
FROM PopvsVac


-- TEMP TABLE

DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(Continent nvarchar(225),
Location nvarchar(225),
Date datetime, 
Population numeric, 
New_Vaccinations numeric, 
Rolling_People_Vaccinated numeric
)


INSERT INTO #PercentPopulationVaccinated

(
SELECT CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations,
SUM(CV.new_vaccinations) OVER (PARTITION BY CD.location ORDER BY CD.location, CD.date) AS Rolling_People_Vaccinated
--(Rolling_People_Vacciated/Population)*100
FROM `lexical-sol-333520.Portfolio_Data_PH.Covid_deaths` AS CD
JOIN `lexical-sol-333520.Portfolio_Data_PH.Covid_vaccination` AS CV
ON CV.location = CD.location AND CV.date = CD.date
WHERE CD.continent is not null

)

SELECT *, (Rolling_People_Vaccinated/Population) * 100
FROM #PercentPopulationVaccinated



-- Create view to store data for visualization


CREATE VIEW PercentPopulationVaccinated AS
SELECT CD.continent, CD.location, CD.date, CD.population, CV.new_vaccinations,
SUM(CV.new_vaccinations) OVER (PARTITION BY CD.location ORDER BY CD.location, CD.date) AS Rolling_People_Vaccinated
--(Rolling_People_Vacciated/Population)*100
FROM `lexical-sol-333520.Portfolio_Data_PH.Covid_deaths` AS CD
JOIN `lexical-sol-333520.Portfolio_Data_PH.Covid_vaccination` AS CV
ON CV.location = CD.location AND CV.date = CD.date
WHERE CD.continent is not null

*/
