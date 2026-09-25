# Bank Loan & Credit Risk Analysis --- SQL Analysis

##  Project Overview

This project analyzes a large-scale **Bank Loan & Credit Risk** dataset
using **PostgreSQL and SQL**.

The objective is to understand the loan portfolio, customer credit
characteristics, default patterns, risk segments, and monetary exposure
associated with loan defaults.

The analysis uses **255,347 loan records and 18 columns** and focuses on
business-oriented credit-risk questions rather than only basic SQL
operations.

------------------------------------------------------------------------

##  Business Objective

The main business question is:

> **How can a financial institution understand loan default patterns and
> identify customer segments associated with higher credit risk?**

The SQL analysis focuses on:

-   Loan portfolio overview
-   Default rate
-   Loan exposure
-   Credit score risk
-   DTI risk
-   Loan purpose analysis
-   Employment-based risk analysis
-   Credit score + DTI segmentation
-   Defaulted loan exposure
-   High-risk borrower identification
-   Business KPIs for management reporting

------------------------------------------------------------------------

##  Dataset Overview

  Metric                                    Value
  ----------------------- -----------------------
  Total Rows / Loans                  **255,347**
  Total Columns                            **18**
  Unique Loan IDs                     **255,347**
  Duplicate Loan IDs                        **0**
  NULL Values                               **0**
  Non-Default Loans                   **225,694**
  Defaulted Loans                      **29,653**
  Overall Default Rate                 **11.61%**
  Total Loan Exposure       **32,576,880,572.00**
  Average Loan Amount              **127,578.87**
  Average Interest Rate                **13.49%**
  Average Credit Score                 **574.26**
  Average DTI Ratio                      **0.50**

------------------------------------------------------------------------

##  Dataset Columns

The dataset contains 18 columns:

1.  `LoanID` --- Unique loan identifier
2.  `Age` --- Borrower's age
3.  `Income` --- Borrower's income
4.  `LoanAmount` --- Loan amount
5.  `CreditScore` --- Borrower's credit score
6.  `MonthsEmployed` --- Months employed
7.  `NumCreditLines` --- Number of credit lines
8.  `InterestRate` --- Loan interest rate
9.  `LoanTerm` --- Loan term
10. `DTIRatio` --- Debt-to-income ratio
11. `Education` --- Education level
12. `EmploymentType` --- Employment category
13. `MaritalStatus` --- Marital status
14. `HasMortgage` --- Mortgage status
15. `HasDependents` --- Dependents status
16. `LoanPurpose` --- Purpose of the loan
17. `HasCoSigner` --- Co-signer status
18. `Default` --- Loan default indicator

In the PostgreSQL implementation, the columns were normalized to
SQL-friendly names such as `loan_id`, `loan_amount`, `credit_score`,
`dti_ratio`, and `default_flag`.

------------------------------------------------------------------------

#  Data Quality Checks

Before business analysis, the dataset was validated in PostgreSQL.

### Row Count

``` sql
SELECT COUNT(*) AS total_rows
FROM banking.loan_default;
```

Result:

**255,347 rows**

### Duplicate Check

``` sql
SELECT
    loan_id,
    COUNT(*) AS duplicate_count
FROM banking.loan_default
GROUP BY loan_id
HAVING COUNT(*) > 1;
```

Result:

**0 duplicate Loan IDs**

### NULL Check

All analyzed columns returned:

**0 NULL values**

### Default Validation

``` sql
SELECT
    default_flag,
    COUNT(*) AS loan_count
FROM banking.loan_default
GROUP BY default_flag;
```

Results:

    Default Flag     Loans   Percentage
  -------------- --------- ------------
               0   225,694       88.39%
               1    29,653       11.61%

------------------------------------------------------------------------

#  Overall Portfolio Analysis

The SQL analysis calculated the following portfolio metrics:

-   **255,347 total loans**
-   **255,347 unique loans**
-   **32.58 billion total loan exposure**
-   **127,578.87 average loan amount**
-   **13.49% average interest rate**
-   **574.26 average credit score**
-   **0.50 average DTI ratio**
-   **29,653 defaulted loans**
-   **11.61% overall default rate**

These KPIs provide the overall portfolio baseline for the credit-risk
analysis.

------------------------------------------------------------------------

#  Default Rate Analysis

The overall observed default rate is:

**11.61%**

This means that 29,653 of the 255,347 loans in the dataset are marked as
defaulted.

The analysis then compares default rates across different customer and
loan characteristics.

------------------------------------------------------------------------

#  Loan Purpose Risk Analysis

Observed default rates by loan purpose:

  Loan Purpose     Total Loans   Defaulted Loans   Default Rate
  -------------- ------------- ----------------- --------------
  Business              51,298             6,323     **12.33%**
  Auto                  50,844             6,041     **11.88%**
  Education             51,005             6,038     **11.84%**
  Other                 50,914             6,002     **11.79%**
  Home                  51,286             5,249     **10.23%**

### Business Observation

Among the displayed loan-purpose categories, **Business loans have the
highest observed default rate at 12.33%**, while Home loans have the
lowest at 10.23%.

This is an observed relationship in the dataset and does not by itself
establish causation.

------------------------------------------------------------------------

#  Loan Exposure by Purpose

  -----------------------------------------------------------------------
  Loan Purpose           Total Loan       Average Loan Defaulted Exposure
                           Exposure                    
  -------------- ------------------ ------------------ ------------------
  Business            6,522,120,439         127,141.81        907,676,057

  Auto                6,500,807,511         127,857.91        880,252,835

  Other               6,498,135,901         127,629.65        868,921,638

  Education           6,510,575,194         127,645.82        866,652,579

  Home                6,545,241,527         127,622.38        761,809,422
  -----------------------------------------------------------------------

### Business Interpretation

Default count alone does not describe the complete financial impact.

The project therefore also calculates **defaulted loan exposure**, which
represents the loan amount associated with defaulted records.

------------------------------------------------------------------------

#  Credit Score Risk Analysis

Borrowers were segmented into credit-score groups:

  Credit Score Group     Total Loans   Defaulted Loans   Default Rate
  -------------------- ------------- ----------------- --------------
  Poor                       130,223            16,245     **12.47%**
  Fair                        41,847             4,784     **11.43%**
  Good                        32,073             3,409     **10.63%**
  Very Good                   27,736             2,912     **10.50%**
  Excellent                   23,468             2,303      **9.81%**

### Credit Risk Observation

In this dataset, the observed default rate decreases across the
credit-score groups from **12.47% for Poor** to **9.81% for Excellent**.

This indicates an association between credit-score segment and observed
default rate in this dataset.

------------------------------------------------------------------------

#  DTI Risk Analysis

Borrowers were segmented using DTI ratio:

  DTI Group         Total Loans   Average Loan   Default Rate
  --------------- ------------- -------------- --------------
  Very High DTI         129,297     127,677.45     **12.14%**
  High DTI               47,961     127,693.11     **11.50%**
  Moderate DTI           47,765     127,490.74     **11.10%**
  Low DTI                30,324     127,116.65     **10.36%**

### DTI Observation

The **Very High DTI** group has the highest observed default rate at
**12.14%**, while the Low DTI group has the lowest at **10.36%**.

------------------------------------------------------------------------

#  Credit Score + DTI Risk Segmentation

A combined risk analysis was performed using:

-   Credit Score Group
-   DTI Group
-   Default Flag
-   Loan Amount

Example observed segments include:

  Credit Group   DTI Group         Total Loans   Default Rate
  -------------- --------------- ------------- --------------
  Poor           Very High DTI          66,160     **12.91%**
  Poor           High DTI               24,397     **12.50%**
  Poor           Moderate DTI           24,334     **12.10%**
  Fair           Very High DTI          21,026     **11.95%**
  Fair           High DTI                7,900     **11.43%**

The combined segmentation helps identify groups where multiple risk
indicators occur together.

------------------------------------------------------------------------

#  Employment + Loan Purpose Risk

The project also analyzes default rates across combinations of:

-   Loan Purpose
-   Employment Type

Example results from the analysis:

  ------------------------------------------------------------------------
  Loan        Employment       Total Loans Defaulted Loans    Default Rate
  Purpose     Type                                         
  ----------- ------------ --------------- --------------- ---------------
  Business    Unemployed            12,930           1,858      **14.37%**

  Education   Unemployed            12,726           1,775      **13.95%**

  Auto        Unemployed            12,565           1,748      **13.91%**

  Other       Unemployed            12,777           1,749      **13.69%**

  Business    Part-time             12,819           1,611      **12.57%**
  ------------------------------------------------------------------------

This analysis demonstrates how SQL can combine multiple business
dimensions to identify higher observed default-rate segments.

------------------------------------------------------------------------

#  SQL Techniques Used

The project demonstrates practical PostgreSQL skills including:

### Basic SQL

-   `SELECT`
-   `WHERE`
-   `GROUP BY`
-   `ORDER BY`
-   `HAVING`
-   `COUNT`
-   `SUM`
-   `AVG`
-   `MIN`
-   `MAX`

### Intermediate SQL

-   `CASE WHEN`
-   Conditional aggregation
-   `COUNT(DISTINCT ...)`
-   `FILTER`
-   Percentage calculations
-   Data-quality validation

### Advanced SQL

-   Common Table Expressions (`WITH`)
-   Window Functions
-   `RANK() OVER()`
-   Multi-dimensional risk segmentation
-   Conditional exposure calculations

------------------------------------------------------------------------

#  Key Business Insights

Based on the SQL analysis:

1.  The dataset contains **255,347 unique loans** with **no duplicate
    Loan IDs and no NULL values** in the validated fields.

2.  **29,653 loans are marked as defaulted**, resulting in an overall
    observed default rate of **11.61%**.

3.  The total loan exposure is approximately **32.58 billion**, with an
    average loan amount of **127,578.87**.

4.  The average borrower credit score is **574.26**, while the average
    DTI ratio is **0.50**.

5.  Among the analyzed loan purposes, **Business loans show the highest
    observed default rate at 12.33%**.

6.  The **Poor credit-score group has a 12.47% observed default rate**,
    compared with **9.81% for the Excellent group**.

7.  The **Very High DTI group has a 12.14% observed default rate**,
    compared with **10.36% for the Low DTI group**.

8.  Combining credit score and DTI reveals more granular risk segments,
    with **Poor Credit + Very High DTI** showing a **12.91% observed
    default rate** among the displayed segments.

9.  Loan-purpose analysis is extended beyond default counts to
    **defaulted loan exposure**, providing a monetary view of credit
    risk.

------------------------------------------------------------------------

#  Tools Used

-   **PostgreSQL**
-   **pgAdmin 4**
-   **SQL**

### Next Phase

The SQL analysis will be followed by:

**Python + Pandas + NumPy + Matplotlib + Seaborn**

The Python phase will focus on exploratory data analysis, distributions,
outliers, relationships between financial variables, and visual
investigation of default patterns.

------------------------------------------------------------------------

##  Project Structure

``` text
Bank-Loan-Credit-Risk-Analysis/
│
├── SQL/
│   └── bank_loan_credit_risk_analysis.sql
│
├── Python/
│   └── ...
│
├── PowerBI/
│   └── ...
│
├── Images/
│   └── ...
│
└── README.md
```

------------------------------------------------------------------------

##  Project Summary

**Bank Loan & Credit Risk Analysis** is a large-scale SQL analytics
project built on **255K+ loan records**. The project uses PostgreSQL to
perform data-quality validation, portfolio analysis, default analysis,
credit-risk segmentation, loan-exposure analysis, and multi-dimensional
business analysis.

The project demonstrates the ability to convert raw financial data into
**business-oriented credit-risk insights using SQL**.
