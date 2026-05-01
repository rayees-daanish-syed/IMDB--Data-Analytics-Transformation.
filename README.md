# 🎬 IMDB Data Analytics: Film Industry Performance & Trends

![SQL](https://img.shields.io/badge/SQL-Data_Analytics-blue.svg)
![Status](https://img.shields.io/badge/Status-Completed-success.svg)

## 📌 Project Overview
The primary goal of this project is to derive actionable insights from a comprehensive IMDB dataset to evaluate film industry performance, genre popularity, and actor/director influence. By leveraging advanced SQL querying, this analysis bridges the gap between raw cinematic data and strategic business intelligence, identifying patterns that drive audience engagement and commercial success.

## 🎯 Problem Statement
This analysis addresses key complexities within large-scale movie databases, including:
* **Performance Metrics:** Quantifying the correlation between production budgets, global box office revenue, and critical reception scores.
* **Trend Identification:** Mapping shifts in genre preferences and narrative styles over distinct chronological periods to forecast emerging market interests.
* **Talent Analytics:** Evaluating the impact of key stakeholders—directors and principal cast members—on a project's marketability and critical success.
* **Data Integrity & Aggregation:** Optimizing complex join operations and nested queries to synthesize disparate data points across multiple relational tables into coherent, decision-ready reports.

## 🗄️ Dataset Description
The dataset contains relational tables capturing historical IMDB data, including:
* **Movies:** Details on titles, release years, durations, and languages.
* **Ratings:** IMDB scores and total vote counts.
* **Genre:** Categorization of films (Action, Drama, Comedy, etc.).
* **Crew & Cast:** Information regarding directors and principal actors.
* **Financials:** (If applicable) Budget and gross revenue figures.

## 🛠️ Tech Stack
* **Language:** SQL
* **Techniques Used:** 
  * Complex `JOIN` operations
  * Aggregate functions (`SUM`, `AVG`, `COUNT`)
  * Window functions (e.g., `RANK()`, `DENSE_RANK()`)
  * Common Table Expressions (CTEs)
  * Subqueries and Data Filtering

## 📂 Repository Structure
```text
├── IMDB+question(Final_script).sql   # Main SQL script containing all queries and analysis
└── README.md                         # Project documentation
