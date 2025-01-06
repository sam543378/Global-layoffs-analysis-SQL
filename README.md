# Global Layoffs Analysis

## Data Cleaning and EDA

This project explores global layoff trends using data from the Layoffs 2022 Dataset. The analysis involves two main phases:

## Data Cleaning
Preparing the dataset for accurate and reliable analysis.
## Exploratory Data Analysis (EDA): 
eriving meaningful insights and trends.

## Project Objectives

**Data Cleaning**
Handle duplicates, missing values, and standardize data for consistency.

**EDA** 
Uncover trends in layoffs across companies, industries, countries, and over time.

## Dataset

**Source**

- Dataset source: [Kaggle - Layoffs 2022](https://www.kaggle.com/datasets/swaptr/layoffs-2022)

**Description**

Contains information about layoffs in various companies globally, including company details, industries, layoff counts, dates, and locations.

## Project Workflow
## 1. Data Cleaning


Steps:

**Create and set up a staging database to preserve the raw dataset**.

**Remove duplicates** using SQL ROW_NUMBER() and eliminate redundant entries.

**Handle missing values** 
- Populate missing "industry" data using company-specific values.

- Retain NULLs in numeric fields for clarity but remove rows where both "total_laid_off" and "percentage_laid_off" are NULL.
  
**Standardize data**

- Normalize "industry" and "country" fields to eliminate inconsistencies.
- Convert "date" column to a proper DATE format.
  
**Remove temporary columns** used during cleaning.

**Output**:

A clean and standardized dataset ready for analysis.

## 2. Exploratory Data Analysis (EDA)

**Goals**

- Identify key trends, outliers, and patterns in the dataset.

- Understand the scope of layoffs globally.

**Key Insights**

- Largest single-day layoffs and companies with the highest cumulative layoffs.

- Industries and countries most impacted by layoffs.

- Trends over time, including yearly and monthly layoffs.

- Companies that shut down entirely, marked by 100% layoffs.

## Techniques

- Aggregations (SUM, MAX, MIN) and ranking (DENSE_RANK).

- Window functions for rolling totals and yearly rankings.
- Grouping and filtering for sector, location, and funding stage analysis.

## Key Findings

**Industries**

 Tech and crypto industries faced the most significant layoffs.

**Geographies**

 The United States experienced the highest layoffs by volume.

**Time Trends**

 Layoffs peaked during specific months, highlighting seasonal or economic factors.

**Funding Stages**

 Startups in early funding stages saw disproportionately higher layoffs.
 

## Tools and Technologies

**Database**: MySQL

**Programming**: SQL

**Data Source**: Kaggle

## How to Use

- Clone this repository.

- Load the dataset into the database using the provided schema.

- Execute the SQL scripts for data cleaning and EDA.

- Review the findings or customize queries for deeper insights.





