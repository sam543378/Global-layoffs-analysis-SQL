-- EXPLORATORY DATA ANALYSIS (EDA)

-- In this section, we are performing an exploratory analysis of the layoffs dataset. 
-- The goal is to uncover trends, patterns, outliers, and insights that can help in understanding the scope of layoffs globally.
-- EDA provides a foundation for further analysis and visualization by identifying key data points.

-- Step 1: Display the raw data for an overview.
SELECT * 
FROM world_layoffs.layoffs_staging2;

-- BASIC INSIGHTS

-- Find the maximum number of employees laid off in a single instance to understand the scale of the largest layoff event.
SELECT MAX(total_laid_off)
FROM world_layoffs.layoffs_staging2;

-- Analyze the range of percentage layoffs to identify the companies with the most significant layoffs relative to their workforce.
SELECT MAX(percentage_laid_off), MIN(percentage_laid_off)
FROM world_layoffs.layoffs_staging2
WHERE percentage_laid_off IS NOT NULL;

-- Identify companies where 100% of employees were laid off, indicating complete shutdowns, typically among startups.
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE percentage_laid_off = 1;

-- Sort these companies by funds raised to explore financial backgrounds of startups that went under.
SELECT *
FROM world_layoffs.layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- INSIGHTFUL GROUP ANALYSIS

-- Companies with the largest single-day layoffs.
SELECT company, total_laid_off, `date`
FROM world_layoffs.layoffs_staging
ORDER BY total_laid_off DESC
LIMIT 5;

-- Companies with the highest cumulative layoffs across the dataset.
SELECT company, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY company
ORDER BY SUM(total_laid_off) DESC
LIMIT 10;

-- Locations with the highest layoffs, highlighting geographical trends.
SELECT location, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY location
ORDER BY SUM(total_laid_off) DESC
LIMIT 10;

-- Countries with the largest layoffs over the dataset's timeframe.
SELECT country, SUM(total_laid_off) AS Total_laid_off
FROM world_layoffs.layoffs_staging2
GROUP BY country
ORDER BY SUM(total_laid_off) DESC
LIMIT 10;

-- Yearly trends in layoffs to track annual patterns.
SELECT YEAR(date) AS year, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY YEAR(date)
ORDER BY year ASC;

-- Industries most affected by layoffs to identify sector-level trends.
SELECT industry, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY industry
ORDER BY SUM(total_laid_off) DESC;

-- Funding stage trends, identifying layoffs across different company stages.
SELECT stage, SUM(total_laid_off)
FROM world_layoffs.layoffs_staging2
GROUP BY stage
ORDER BY SUM(total_laid_off) DESC;

-- ADVANCED ANALYSIS

-- Rolling total of layoffs by month to track cumulative trends over time.
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE SUBSTRING(date,1,7) IS NOT NULL
GROUP BY dates
ORDER BY dates ASC;

-- now  we use it in a CTE so we can query off of it
WITH DATE_CTE AS 
(
SELECT SUBSTRING(date,1,7) as dates, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE SUBSTRING(date,1,7) IS NOT NULL
GROUP BY dates
ORDER BY dates ASC
)
SELECT dates, total_laid_off, SUM(total_laid_off) OVER (ORDER BY dates ASC) as rolling_total_layoffs
FROM DATE_CTE
ORDER BY dates ASC;

-- Analyze the top companies with the most layoffs per year using window functions for ranking.
WITH Company_Year AS 
(
  SELECT company, YEAR(date) AS years, SUM(total_laid_off) AS total_laid_off
  FROM layoffs_staging2
  GROUP BY company, YEAR(date)
)
, Company_Year_Rank AS (
  SELECT company, years, total_laid_off, DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
  FROM Company_Year
)
SELECT company, years, total_laid_off, ranking
FROM Company_Year_Rank
WHERE ranking <= 3
AND years IS NOT NULL
ORDER BY years ASC, total_laid_off DESC;




