# Bank Loan & Credit Risk Analysis

## Project Overview

**Bank Loan & Credit Risk Analysis** is an end-to-end Data Analytics
project built to analyze a large-scale banking loan portfolio and
understand loan-default and credit-risk patterns.

The project uses **PostgreSQL, SQL, Python, Pandas, NumPy, Matplotlib,
Seaborn, and Power BI** to transform raw loan data into
business-oriented insights.

The dataset contains **255,347 loan records and 18 columns**. The
workflow covers data-quality validation, SQL business analysis, Python
exploratory data analysis, risk segmentation, and an interactive Power
BI dashboard.

## Business Objective

The project aims to answer:

-   How large is the loan portfolio?
-   What is the observed loan default rate?
-   How does default rate vary across credit-score groups?
-   How does DTI relate to observed default patterns?
-   Which loan purposes have different default rates?
-   How do employment characteristics relate to defaults?
-   What is the loan exposure associated with defaults?
-   Which borrower segments show multiple risk indicators?
-   How can these findings be presented in an interactive dashboard?

> **Note:** The project identifies patterns and associations in the
> dataset. Observed relationships do not by themselves establish
> causation.

# Dataset Overview

  ----------------------- -------------------
  Metric                  Value
  Total Rows / Loans      **255,347**
  Total Columns           **18**
  Unique Loan IDs         **255,347**
  Duplicate Rows          **0**
  NULL Values             **0**
  Non-Default Loans       **225,694**
  Defaulted Loans         **29,653**
  Overall Default Rate    **11.61%**
  Total Loan Exposure     **32.58 Billion**
  Average Loan Amount     **127,578.87**
  Average Interest Rate   **13.49%**
  Average Credit Score    **574.26**
  Average DTI Ratio       **0.50**
  ----------------------- -------------------

# Dataset Columns

  -------------------- -------------------------------
  Column               Description
  *loan_id*            Unique loan identifier
  *age*                Borrower\'s age
  *income*             Borrower\'s income
  *loan_amount*        Loan amount
  *credit_score*       Borrower\'s credit score
  *months_employed*    Employment duration in months
  *num_credit_lines*   Number of credit lines
  *interest_rate*      Loan interest rate
  *loan_term*          Loan term
  *dti_ratio*          Debt-to-income ratio
  *education*          Education level
  *employment_type*    Employment category
  *marital_status*     Marital status
  *has_mortgage*       Mortgage status
  *has_dependents*     Dependent status
  *loan_purpose*       Purpose of the loan
  *has_cosigner*       Co-signer status
  *default_flag*       Loan default indicator
  -------------------- -------------------------------

# Tools & Technologies

### Database & SQL

-   PostgreSQL
-   pgAdmin 4
-   SQL
-   CTEs
-   CASE WHEN
-   Conditional Aggregation
-   Window Functions

### Python

-   Python
-   Pandas
-   NumPy
-   Matplotlib
-   Seaborn
-   SQLAlchemy
-   Psycopg2

### Visualization & BI

-   Power BI
-   DAX
-   KPI Cards
-   Bar & Column Charts
-   Donut Charts
-   Heatmaps
-   Slicers
-   Interactive Dashboard

# End-to-End Workflow

*Raw Loan Dataset*

* ↓*

*PostgreSQL*

* ↓*

*Data Quality Checks*

* ↓*

*SQL Business Analysis*

* ↓*

*Python + Pandas EDA*

* ↓*

*Statistical & Visual Analysis*

* ↓*

*Power BI + DAX*

* ↓*

*Interactive Credit Risk Dashboard*

* ↓*

*Business Insights*

# PostgreSQL & SQL Analysis

The dataset was imported into PostgreSQL using:

*Schema: banking*

*Table: banking.loan_default*

## Data Quality Validation

Performed checks for:

-   Row count
-   Column count
-   Duplicate records
-   Duplicate Loan IDs
-   NULL values
-   Default distribution
-   Data consistency

### Results

*Total Rows = 255,347*

*Unique Loan IDs = 255,347*

*Duplicate IDs = 0*

*NULL Values = 0*

## SQL Analysis Performed

-   Overall portfolio KPIs
-   Default rate
-   Loan exposure
-   Average loan amount
-   Average interest rate
-   Credit-score analysis
-   DTI analysis
-   Loan-purpose analysis
-   Employment analysis
-   Credit Score + DTI segmentation
-   Defaulted loan exposure
-   High-risk borrower analysis

# Major SQL Findings

## Overall Default

*Total Loans = 255,347*

*Defaulted Loans = 29,653*

*Non-Default Loans = 225,694*

*Default Rate = 11.61%*

## Default Rate by Credit Score Group

  -------------------- ------------- ----------------- --------------
  Credit Score Group   Total Loans   Defaulted Loans   Default Rate
  Poor                 130,223       16,245            **12.47%**
  Fair                 41,847        4,784             **11.43%**
  Good                 32,073        3,409             **10.63%**
  Very Good            27,736        2,912             **10.50%**
  Excellent            23,468        2,303             **9.81%**
  -------------------- ------------- ----------------- --------------

The observed default rate decreases across these credit-score groups in
this dataset.

## Default Rate by DTI Group

  --------------- ------------- --------------
  DTI Group       Total Loans   Default Rate
  Very High DTI   129,297       **12.14%**
  High DTI        47,961        **11.50%**
  Moderate DTI    47,765        **11.10%**
  Low DTI         30,324        **10.36%**
  --------------- ------------- --------------

## Default Rate by Loan Purpose

  -------------- ------------- ----------------- --------------
  Loan Purpose   Total Loans   Defaulted Loans   Default Rate
  Business       51,298        6,323             **12.33%**
  Auto           50,844        6,041             **11.88%**
  Education      51,005        6,038             **11.84%**
  Other          50,914        6,002             **11.79%**
  Home           51,286        5,249             **10.23%**
  -------------- ------------- ----------------- --------------

## Loan Exposure by Purpose

  -------------- ---------------- --------------------
  Loan Purpose   Total Exposure   Defaulted Exposure
  Business       6.522B           907.676M
  Auto           6.501B           880.253M
  Other          6.498B           868.922M
  Education      6.511B           866.653M
  Home           6.545B           761.809M
  -------------- ---------------- --------------------

The analysis considers both default rate and defaulted exposure to
provide percentage and monetary views of portfolio risk.

# Python Exploratory Data Analysis

The PostgreSQL table was loaded into Pandas using SQLAlchemy:

*query = \"\"\"*

*SELECT \**

*FROM banking.loan_default;*

*\"\"\"*

*df = pd.read_sql(query, engine)*

## Python Data Quality Checks

Validated:

-   *df.shape*
-   *df.info()*
-   NULL values
-   Duplicate rows
-   Unique Loan IDs
-   Default distribution

Results:

-   **255,347 rows**
-   **18 columns**
-   **0 NULL values**
-   **0 duplicate rows**
-   **255,347 unique Loan IDs**

## Python EDA Performed

### Distribution Analysis

-   Credit Score
-   Loan Amount
-   Income
-   DTI
-   Interest Rate
-   Default Distribution

### Default Comparison

-   Credit Score: Default vs Non-Default
-   DTI: Default vs Non-Default
-   Income: Default vs Non-Default
-   Loan Amount: Default vs Non-Default
-   Interest Rate: Default vs Non-Default

### Categorical Analysis

-   Employment Type
-   Education
-   Mortgage Status
-   Dependents
-   Co-signer
-   Loan Purpose

### Cross Analysis

-   Loan Purpose + Employment Type
-   Credit Score + DTI

### Statistical Analysis

-   Correlation Matrix
-   Correlation Heatmap
-   IQR-based Outlier Analysis

# High-Risk Borrower Segmentation

A project-specific high-risk segment was created using:

*Credit Score \< 580*

*AND*

*DTI Ratio \>= 0.50*

The segment was compared with other borrowers using:

-   Loan count
-   Defaulted loans
-   Default rate
-   Total loan exposure
-   Average loan amount
-   Average credit score
-   Average DTI

This is an analytical definition created for this project and is not a
formal lending-policy classification.

# Power BI Dashboard

Power BI converts the SQL and Python analysis into an interactive
business dashboard.

## Dashboard Pages

*Page 1 → Loan Portfolio Overview*

*Page 2 → Credit Risk Analysis*

*Page 3 → Borrower & Default Analysis*

*Page 4 → High-Risk Segmentation*

## Page 1 --- Loan Portfolio Overview

### KPI Cards

-   Total Loans
-   Defaulted Loans
-   Default Rate
-   Total Loan Exposure
-   Average Loan Amount
-   Average Credit Score

### Visuals

-   Default vs Non-Default Loans
-   Loans by Purpose
-   Default Rate by Loan Purpose
-   Loans by Employment Type
-   Loans by Credit Score Group

## Page 2 --- Credit Risk Analysis

-   Default Rate by Credit Score Group
-   Default Rate by DTI Group
-   Credit Score vs Default
-   DTI vs Default
-   Credit Score + DTI Segmentation
-   Interest Rate Analysis
-   Defaulted Loan Exposure

## Page 3 --- Borrower & Default Analysis

-   Employment Type
-   Education Level
-   Mortgage Status
-   Dependents
-   Co-signer Status
-   Loan Purpose
-   Default Rate comparisons
-   Borrower profile comparisons

## Page 4 --- High-Risk Segmentation

-   High-Risk Loan Count
-   High-Risk Default Count
-   High-Risk Default Rate
-   High-Risk Loan Exposure
-   Risk by Loan Purpose
-   Credit Score + DTI risk matrix

# Key Power BI DAX Measures

### Total Loans

*Total Loans =*

*COUNTROWS(loan_default)*

### Defaulted Loans

*Defaulted Loans =*

*CALCULATE(*

* COUNTROWS(loan_default),*

* loan_default\[default_flag\] = 1*

*)*

### Default Rate

*Default Rate =*

*DIVIDE(*

* \[Defaulted Loans\],*

* \[Total Loans\],*

* 0*

*)*

### Total Loan Exposure

*Total Loan Exposure =*

*SUM(loan_default\[loan_amount\])*

### Average Loan Amount

*Average Loan Amount =*

*AVERAGE(loan_default\[loan_amount\])*

### Average Credit Score

*Average Credit Score =*

*AVERAGE(loan_default\[credit_score\])*

# Project Structure

*Bank-Loan-Credit-Risk-Analysis/*

*│*

*├── README.md*

*│*

*├── SQL/*

*│ └── bank_loan_credit_risk_analysis.sql*

*│*

*├── Python/*

*│ ├── Bank_Loan_Credit_Risk_Analysis.ipynb*

*│ ├── credit_score_risk_analysis.csv*

*│ ├── dti_risk_analysis.csv*

*│ ├── loan_purpose_risk_analysis.csv*

*│ ├── employment_risk_analysis.csv*

*│ ├── high_risk_segment_analysis.csv*

*│ ├── credit_dti_risk_segments.csv*

*│ └── python_final_kpis.csv*

*│*

*├── PowerBI/*

*│ └── Bank_Loan_Credit_Risk_Dashboard.pbix*

*│*

*└── *

* ├── dashboard_overview.png*

* ├── credit_risk_analysis.png*

* ├── borrower_analysis.png*

* └── high_risk_segmentation.png*

#  Key Business Insights

1.  The portfolio contains **255,347 unique loans** with no duplicate
    Loan IDs and no NULL values in the validated fields.
2.  **29,653 loans are marked as defaulted**, producing an overall
    observed default rate of **11.61%**.
3.  Total loan exposure is approximately **32.58 billion**, with an
    average loan amount of approximately **127,579**.
4.  The observed default rate varies across credit-score groups, from
    **12.47% in the Poor group** to **9.81% in the Excellent group**.
5.  The Very High DTI group has an observed default rate of **12.14%**,
    compared with **10.36% for the Low DTI group**.
6.  Among the analyzed loan purposes, Business loans have an observed
    default rate of **12.33%**.
7.  The project evaluates **defaulted loan exposure** in addition to
    default counts, providing a monetary perspective on risk.
8.  Combining credit score and DTI provides a more granular way to
    examine borrower segments with multiple risk indicators.
9.  Python EDA extends the SQL analysis through distributions, boxplots,
    correlation analysis, heatmaps, and outlier detection.
10. Power BI converts the analytical results into an interactive
    dashboard for portfolio monitoring and business reporting.

# Skills Demonstrated

-   Data Cleaning & Validation
-   PostgreSQL
-   SQL Data Analysis
-   Advanced SQL
-   CTEs
-   CASE Statements
-   Window Functions
-   Conditional Aggregation
-   Python
-   Pandas
-   NumPy
-   Exploratory Data Analysis
-   Matplotlib
-   Seaborn
-   Correlation Analysis
-   Outlier Detection
-   Risk Segmentation
-   Power BI
-   DAX
-   Data Visualization
-   Business Intelligence
-   Financial / Credit Risk Analytics
-   Business Insight Generation

# Resume Project Description

**Bank Loan & Credit Risk Analysis \| PostgreSQL \| SQL \| Python \|
Power BI**

-   Analyzed **255K+ loan records** to evaluate portfolio performance,
    loan defaults, credit characteristics, and financial exposure.
-   Performed SQL-based data validation and business analysis using
    **PostgreSQL**, covering default rate, credit score, DTI, loan
    purpose, employment, and loan exposure.
-   Used **Python, Pandas, NumPy, Matplotlib, and Seaborn** for
    exploratory data analysis, distributions, correlation analysis,
    outlier detection, and risk segmentation.
-   Built an interactive **Power BI credit-risk dashboard** with DAX
    KPIs, default analysis, loan-purpose analysis, credit-risk
    segmentation, and borrower insights.
-   Identified observed differences in default rates across
    credit-score, DTI, loan-purpose, and borrower segments and
    translated findings into business-oriented risk insights.

## Conclusion

This project demonstrates a complete Data Analytics workflow:

*SQL*

* ↓*

*Data Validation*

* ↓*

*Business Analysis*

* ↓*

*Python EDA*

* ↓*

*Risk Segmentation*

* ↓*

*Power BI*

* ↓*

*Interactive Dashboard*

* ↓*

*Business Insights*

The project demonstrates practical skills relevant to **Data Analyst,
Business Analyst, Banking Analytics, BFSI Analytics, Credit Risk
Analytics, and BI Analyst** roles.
