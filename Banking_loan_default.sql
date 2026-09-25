CREATE SCHEMA banking ;

CREATE TABLE banking.loan_default (
    loan_id VARCHAR(50),
    age INT,
    income NUMERIC(12,2),
    loan_amount NUMERIC(12,2),
    credit_score INT,
    months_employed INT,
    num_credit_lines INT,
    interest_rate NUMERIC(6,2),
    loan_term INT,
    dti_ratio NUMERIC(5,2),
    education VARCHAR(50),
    employment_type VARCHAR(50),
    marital_status VARCHAR(50),
    has_mortgage VARCHAR(10),
    has_dependents VARCHAR(10),
    loan_purpose VARCHAR(50),
    has_cosigner VARCHAR(10),
    default_flag INT
);

-- total rows
SELECT COUNT (*)
FROM banking.loan_default ;

SELECT * FROM banking.loan_default
LIMIT 10 ;


SELECT column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'banking'
AND table_name = 'loan_default'
ORDER BY ordinal_position;


-- check duplicate loan ids
SELECT loan_id, COUNT(*)
FROM banking.loan_default
GROUP BY loan_id
HAVING COUNT(*) > 1;


-- check null values
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(age) AS age_nulls,
    COUNT(*) - COUNT(income) AS income_nulls,
    COUNT(*) - COUNT(loan_amount) AS loan_amount_nulls,
    COUNT(*) - COUNT(credit_score) AS credit_score_nulls,
    COUNT(*) - COUNT(interest_rate) AS interest_rate_nulls,
    COUNT(*) - COUNT(default_flag) AS default_nulls
FROM banking.loan_default;

-- default distribution
SELECT
    default_flag,
    COUNT(*) AS loan_count
FROM banking.loan_default
GROUP BY default_flag
ORDER BY default_flag;


-- columns checks
SELECT
    column_name,
    data_type
FROM information_schema.columns
WHERE table_schema = 'banking'
  AND table_name = 'loan_default'
ORDER BY ordinal_position;

-- null checks complte
SELECT
    COUNT(*) AS total_rows,
    COUNT(*) - COUNT(loan_id) AS loan_id_nulls,
    COUNT(*) - COUNT(age) AS age_nulls,
    COUNT(*) - COUNT(income) AS income_nulls,
    COUNT(*) - COUNT(loan_amount) AS loan_amount_nulls,
    COUNT(*) - COUNT(credit_score) AS credit_score_nulls,
    COUNT(*) - COUNT(months_employed) AS months_employed_nulls,
    COUNT(*) - COUNT(num_credit_lines) AS credit_lines_nulls,
    COUNT(*) - COUNT(interest_rate) AS interest_rate_nulls,
    COUNT(*) - COUNT(loan_term) AS loan_term_nulls,
    COUNT(*) - COUNT(dti_ratio) AS dti_nulls,
    COUNT(*) - COUNT(education) AS education_nulls,
    COUNT(*) - COUNT(employment_type) AS employment_nulls,
    COUNT(*) - COUNT(marital_status) AS marital_nulls,
    COUNT(*) - COUNT(has_mortgage) AS mortgage_nulls,
    COUNT(*) - COUNT(has_dependents) AS dependents_nulls,
    COUNT(*) - COUNT(loan_purpose) AS purpose_nulls,
    COUNT(*) - COUNT(has_cosigner) AS cosigner_nulls,
    COUNT(*) - COUNT(default_flag) AS default_nulls
FROM banking.loan_default;

-- default distribution
SELECT
    default_flag,
    COUNT(*) AS loan_count,
    ROUND(
        COUNT(*) * 100.0 /
        SUM(COUNT(*)) OVER (),
        2
    ) AS percentage
FROM banking.loan_default
GROUP BY default_flag
ORDER BY default_flag;

-- min max check for default values
SELECT
    MIN(age) AS min_age,
    MAX(age) AS max_age,
    ROUND(AVG(age), 2) AS avg_age,

    MIN(income) AS min_income,
    MAX(income) AS max_income,
    ROUND(AVG(income), 2) AS avg_income,

    MIN(loan_amount) AS min_loan,
    MAX(loan_amount) AS max_loan,
    ROUND(AVG(loan_amount), 2) AS avg_loan,

    MIN(credit_score) AS min_credit_score,
    MAX(credit_score) AS max_credit_score,
    ROUND(AVG(credit_score), 2) AS avg_credit_score
FROM banking.loan_default;


-- invalid age check
SELECT COUNT(*) AS invalid_age
FROM banking.loan_default
WHERE age < 18 OR age > 100;

-- invalid income
SELECT COUNT(*) AS invalid_income
FROM banking.loan_default
WHERE income <= 0;

-- invalid loan ammount
SELECT COUNT(*) AS invalid_loan_amount
FROM banking.loan_default
WHERE loan_amount <= 0;

-- invalid credit score
SELECT COUNT(*) AS invalid_credit_score
FROM banking.loan_default
WHERE credit_score < 300
   OR credit_score > 850;

-- invalid interst rate
SELECT COUNT(*) AS invalid_interest_rate
FROM banking.loan_default
WHERE interest_rate < 0
   OR interest_rate > 100;

-- invalid dti ratio
SELECT COUNT(*) AS invalid_dti
FROM banking.loan_default
WHERE dti_ratio < 0;


-- month employed validation
SELECT
    COUNT(*) AS invalid_months_employed
FROM banking.loan_default
WHERE months_employed < 0;

-- credit line validation
SELECT
    COUNT(*) AS invalid_credit_lines
FROM banking.loan_default
WHERE num_credit_lines < 0;


-- education validation
SELECT
    education,
    COUNT(*) AS customer_count
FROM banking.loan_default
GROUP BY education
ORDER BY customer_count DESC;

-- check education type
SELECT
    employment_type,
    COUNT(*) AS customer_count
FROM banking.loan_default
GROUP BY employment_type
ORDER BY customer_count DESC;

-- check marital status
SELECT
    marital_status,
    COUNT(*) AS customer_count
FROM banking.loan_default
GROUP BY marital_status
ORDER BY customer_count DESC;

-- check loan perpose 
SELECT
    loan_purpose,
    COUNT(*) AS loan_count
FROM banking.loan_default
GROUP BY loan_purpose
ORDER BY loan_count DESC;

-- dependes
SELECT
    has_mortgage,
    has_dependents,
    has_cosigner,
    COUNT(*) AS customer_count
FROM banking.loan_default
GROUP BY
    has_mortgage,
    has_dependents,
    has_cosigner
ORDER BY customer_count DESC;

-- loan overview
SELECT
    COUNT(*) AS total_loans,
    COUNT(DISTINCT loan_id) AS unique_loans,
    ROUND(SUM(loan_amount), 2) AS total_loan_amount,
    ROUND(AVG(loan_amount), 2) AS average_loan_amount,
    ROUND(AVG(interest_rate), 2) AS average_interest_rate,
    ROUND(AVG(credit_score), 2) AS average_credit_score,
    ROUND(AVG(dti_ratio), 2) AS average_dti_ratio
FROM banking.loan_default;

-- default rate 
SELECT
    COUNT(*) AS total_loans,
    SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(
        SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS default_rate
FROM banking.loan_default;

-- default vs non default loan amount
SELECT
    default_flag,
    COUNT(*) AS loan_count,
    ROUND(SUM(loan_amount), 2) AS total_loan_amount,
    ROUND(AVG(loan_amount), 2) AS average_loan_amount
FROM banking.loan_default
GROUP BY default_flag
ORDER BY default_flag;

-- default rate by loan parpose
SELECT
    loan_purpose,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(
        SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS default_rate
FROM banking.loan_default
GROUP BY loan_purpose
ORDER BY default_rate DESC;

-- default rate by employment type 
SELECT
    employment_type,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(
        SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS default_rate
FROM banking.loan_default
GROUP BY employment_type
ORDER BY default_rate DESC;

-- default rate by education
SELECT
    education,
    COUNT(*) AS total_loans,
    SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END) AS defaulted_loans,
    ROUND(
        SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS default_rate
FROM banking.loan_default
GROUP BY education
ORDER BY default_rate DESC;

-- credit score risq analisis
SELECT
    CASE
        WHEN credit_score < 580 THEN 'Poor'
        WHEN credit_score < 670 THEN 'Fair'
        WHEN credit_score < 740 THEN 'Good'
        WHEN credit_score < 800 THEN 'Very Good'
        ELSE 'Excellent'
    END AS credit_score_group,

    COUNT(*) AS total_loans,

    SUM(
        CASE
            WHEN default_flag = 1 THEN 1
            ELSE 0
        END
    ) AS defaulted_loans,

    ROUND(
        SUM(
            CASE
                WHEN default_flag = 1 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS default_rate

FROM banking.loan_default

GROUP BY
    CASE
        WHEN credit_score < 580 THEN 'Poor'
        WHEN credit_score < 670 THEN 'Fair'
        WHEN credit_score < 740 THEN 'Good'
        WHEN credit_score < 800 THEN 'Very Good'
        ELSE 'Excellent'
    END

ORDER BY default_rate DESC;

-- income group default analisis
SELECT
    CASE
        WHEN income < 30000 THEN 'Low Income'
        WHEN income < 60000 THEN 'Middle Income'
        WHEN income < 100000 THEN 'Upper Middle Income'
        ELSE 'High Income'
    END AS income_group,

    COUNT(*) AS total_loans,

    ROUND(AVG(loan_amount), 2) AS avg_loan_amount,

    SUM(
        CASE
            WHEN default_flag = 1 THEN 1
            ELSE 0
        END
    ) AS defaulted_loans,

    ROUND(
        SUM(
            CASE
                WHEN default_flag = 1 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS default_rate

FROM banking.loan_default

GROUP BY
    CASE
        WHEN income < 30000 THEN 'Low Income'
        WHEN income < 60000 THEN 'Middle Income'
        WHEN income < 100000 THEN 'Upper Middle Income'
        ELSE 'High Income'
    END

ORDER BY default_rate DESC;

-- loan amount default analisis
SELECT
    CASE
        WHEN loan_amount < 10000 THEN 'Small Loan'
        WHEN loan_amount < 25000 THEN 'Medium Loan'
        WHEN loan_amount < 50000 THEN 'Large Loan'
        ELSE 'Very Large Loan'
    END AS loan_size_group,

    COUNT(*) AS total_loans,

    ROUND(AVG(loan_amount), 2) AS avg_loan_amount,

    ROUND(
        SUM(loan_amount),
        2
    ) AS total_loan_amount,

    ROUND(
        SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS default_rate

FROM banking.loan_default

GROUP BY
    CASE
        WHEN loan_amount < 10000 THEN 'Small Loan'
        WHEN loan_amount < 25000 THEN 'Medium Loan'
        WHEN loan_amount < 50000 THEN 'Large Loan'
        ELSE 'Very Large Loan'
    END

ORDER BY default_rate DESC;

-- dti ration analisis
SELECT
    CASE
        WHEN dti_ratio < 0.20 THEN 'Low DTI'
        WHEN dti_ratio < 0.35 THEN 'Moderate DTI'
        WHEN dti_ratio < 0.50 THEN 'High DTI'
        ELSE 'Very High DTI'
    END AS dti_group,

    COUNT(*) AS total_loans,

    ROUND(AVG(loan_amount), 2) AS avg_loan_amount,

    ROUND(
        SUM(CASE WHEN default_flag = 1 THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS default_rate

FROM banking.loan_default

GROUP BY
    CASE
        WHEN dti_ratio < 0.20 THEN 'Low DTI'
        WHEN dti_ratio < 0.35 THEN 'Moderate DTI'
        WHEN dti_ratio < 0.50 THEN 'High DTI'
        ELSE 'Very High DTI'
    END

ORDER BY default_rate DESC;

-- credit score + default analisis (credit risq analisis)
SELECT
    CASE
        WHEN credit_score < 580 THEN 'Poor'
        WHEN credit_score < 670 THEN 'Fair'
        WHEN credit_score < 740 THEN 'Good'
        WHEN credit_score < 800 THEN 'Very Good'
        ELSE 'Excellent'
    END AS credit_score_group,

    COUNT(*) AS total_loans,

    SUM(
        CASE WHEN default_flag = 1 THEN 1 ELSE 0 END
    ) AS defaulted_loans,

    ROUND(
        SUM(
            CASE WHEN default_flag = 1 THEN 1 ELSE 0 END
        ) * 100.0 / COUNT(*),
        2
    ) AS default_rate

FROM banking.loan_default

GROUP BY 1
ORDER BY default_rate DESC;

-- high risq borrow sedment (credit score+dti+defalut)
WITH risk_segments AS (

    SELECT
        CASE
            WHEN credit_score < 580 THEN 'Poor'
            WHEN credit_score < 670 THEN 'Fair'
            WHEN credit_score < 740 THEN 'Good'
            WHEN credit_score < 800 THEN 'Very Good'
            ELSE 'Excellent'
        END AS credit_score_group,

        CASE
            WHEN dti_ratio < 0.20 THEN 'Low DTI'
            WHEN dti_ratio < 0.35 THEN 'Moderate DTI'
            WHEN dti_ratio < 0.50 THEN 'High DTI'
            ELSE 'Very High DTI'
        END AS dti_group,

        default_flag,
        loan_amount

    FROM banking.loan_default
)

SELECT
    credit_score_group,
    dti_group,

    COUNT(*) AS total_loans,

    SUM(
        CASE WHEN default_flag = 1 THEN 1 ELSE 0 END
    ) AS defaulted_loans,

    ROUND(
        SUM(
            CASE WHEN default_flag = 1 THEN 1 ELSE 0 END
        ) * 100.0 / COUNT(*),
        2
    ) AS default_rate,

    ROUND(AVG(loan_amount), 2) AS avg_loan_amount

FROM risk_segments

GROUP BY
    credit_score_group,
    dti_group

ORDER BY default_rate DESC;

-- top risq segment
WITH risk_segments AS (

    SELECT
        CASE
            WHEN credit_score < 580 THEN 'Poor'
            WHEN credit_score < 670 THEN 'Fair'
            WHEN credit_score < 740 THEN 'Good'
            WHEN credit_score < 800 THEN 'Very Good'
            ELSE 'Excellent'
        END AS credit_score_group,

        CASE
            WHEN dti_ratio < 0.20 THEN 'Low DTI'
            WHEN dti_ratio < 0.35 THEN 'Moderate DTI'
            WHEN dti_ratio < 0.50 THEN 'High DTI'
            ELSE 'Very High DTI'
        END AS dti_group,

        default_flag

    FROM banking.loan_default
)

SELECT
    credit_score_group,
    dti_group,
    COUNT(*) AS total_loans,

    ROUND(
        AVG(default_flag) * 100,
        2
    ) AS default_rate

FROM risk_segments

GROUP BY
    credit_score_group,
    dti_group

HAVING COUNT(*) >= 1000

ORDER BY default_rate DESC;

-- loan purpose + employment type risq
SELECT
    loan_purpose,
    employment_type,

    COUNT(*) AS total_loans,

    SUM(
        CASE WHEN default_flag = 1 THEN 1 ELSE 0 END
    ) AS defaulted_loans,

    ROUND(
        SUM(
            CASE WHEN default_flag = 1 THEN 1 ELSE 0 END
        ) * 100.0 / COUNT(*),
        2
    ) AS default_rate

FROM banking.loan_default

GROUP BY
    loan_purpose,
    employment_type

HAVING COUNT(*) >= 1000

ORDER BY default_rate DESC;

-- high value loan analisis
SELECT
    CASE
        WHEN loan_amount < 50000 THEN 'Below 50K'
        WHEN loan_amount < 100000 THEN '50K-100K'
        WHEN loan_amount < 200000 THEN '100K-200K'
        ELSE '200K+'
    END AS loan_value_group,

    COUNT(*) AS total_loans,

    ROUND(
        SUM(loan_amount),
        2
    ) AS total_loan_exposure,

    ROUND(
        AVG(loan_amount),
        2
    ) AS avg_loan_amount,

    SUM(
        CASE WHEN default_flag = 1 THEN 1 ELSE 0 END
    ) AS defaulted_loans,

    ROUND(
        SUM(
            CASE WHEN default_flag = 1 THEN loan_amount ELSE 0 END
        ),
        2
    ) AS defaulted_loan_exposure

FROM banking.loan_default

GROUP BY 1

ORDER BY total_loan_exposure DESC;

-- top loan purpose by loan exposer
SELECT
    loan_purpose,

    COUNT(*) AS total_loans,

    ROUND(
        SUM(loan_amount),
        2
    ) AS total_loan_exposure,

    ROUND(
        AVG(loan_amount),
        2
    ) AS average_loan_amount,

    ROUND(
        SUM(
            CASE WHEN default_flag = 1
                 THEN loan_amount
                 ELSE 0
            END
        ),
        2
    ) AS defaulted_exposure

FROM banking.loan_default

GROUP BY loan_purpose

ORDER BY defaulted_exposure DESC;

-- rank loan perpose
WITH purpose_analysis AS (

    SELECT
        loan_purpose,

        COUNT(*) AS total_loans,

        ROUND(
            SUM(loan_amount),
            2
        ) AS total_loan_exposure,

        ROUND(
            SUM(
                CASE WHEN default_flag = 1
                     THEN loan_amount
                     ELSE 0
                END
            ),
            2
        ) AS defaulted_exposure

    FROM banking.loan_default

    GROUP BY loan_purpose
)

SELECT
    loan_purpose,
    total_loans,
    total_loan_exposure,
    defaulted_exposure,

    RANK() OVER (
        ORDER BY defaulted_exposure DESC
    ) AS exposure_rank

FROM purpose_analysis

ORDER BY exposure_rank;

-- management summery 
SELECT
    COUNT(*) AS total_loans,

    COUNT(DISTINCT loan_id) AS unique_loans,

    ROUND(
        SUM(loan_amount),
        2
    ) AS total_loan_exposure,

    ROUND(
        AVG(loan_amount),
        2
    ) AS average_loan_amount,

    ROUND(
        AVG(interest_rate),
        2
    ) AS average_interest_rate,

    ROUND(
        AVG(credit_score),
        2
    ) AS average_credit_score,

    ROUND(
        AVG(dti_ratio),
        2
    ) AS average_dti,

    SUM(
        CASE
            WHEN default_flag = 1 THEN 1
            ELSE 0
        END
    ) AS defaulted_loans,

    ROUND(
        SUM(
            CASE
                WHEN default_flag = 1 THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS default_rate,

    ROUND(
        SUM(
            CASE
                WHEN default_flag = 1
                THEN loan_amount
                ELSE 0
            END
        ),
        2
    ) AS defaulted_loan_exposure

FROM banking.loan_default;

-- high risq customer profile
SELECT
    COUNT(*) AS high_risk_customers,

    SUM(
        CASE
            WHEN default_flag = 1
            THEN 1
            ELSE 0
        END
    ) AS high_risk_defaults,

    ROUND(
        SUM(
            CASE
                WHEN default_flag = 1
                THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS default_rate,

    ROUND(
        SUM(loan_amount),
        2
    ) AS total_loan_exposure,

    ROUND(
        SUM(
            CASE
                WHEN default_flag = 1
                THEN loan_amount
                ELSE 0
            END
        ),
        2
    ) AS defaulted_exposure

FROM banking.loan_default

WHERE credit_score < 580
  AND dti_ratio >= 0.50;

  


