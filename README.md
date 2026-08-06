# Customer-Churn-Project

## Business Problem

A telecom company is losing a significant share of its customer base each cycle, but doesn't have a clear, data-backed view of **who is churning and why**. Acquiring a new customer costs far more than retaining an existing one, so the business needs an analysis that identifies the highest-risk customer segments and the account/service factors most associated with churn — so that retention efforts (offers, outreach, service changes) can be targeted rather than blanket.

This project analyzes 7,043 customer records (IBM Telco Customer Churn dataset) using SQL to answer nine specific business questions, and translates the findings into concrete retention recommendations.

## Approach

End-to-end: SQL analysis → dashboard → recommendation. Queried a 7,043-record customer dataset in MySQL to answer 9 targeted business questions on churn drivers (contract type, tenure, service usage, payment behavior), then translated the findings into a dashboard and retention recommendations.

1. Loaded the raw dataset into MySQL and cleaned known data issues (blank `TotalCharges` values converted to NULL, column typed as numeric)
2. Framed 9 business questions covering contract structure, tenure, pricing, service usage, payment behavior, demographics, and billing preferences
3. Wrote and ran SQL queries to answer each question
4. Interpreted results into findings and business recommendations
5. Built a Power BI dashboard to present findings visually *(see dashboard section)*

## Key Findings

| # | Question | Finding |
|---|----------|---------|
| 1 | What is the overall churn rate? | **26.54%** of customers churned (1,869 of 7,043) |
| 2 | Does contract type affect churn? | Month-to-month customers churn at **42.71%** vs 11.27% (one-year) and 2.83% (two-year) — a ~15x gap between the extremes |
| 3 | Does tenure affect churn? | Churn falls from **47.44%** (under 12 months) to **6.61%** (60+ months) — the first year is the highest-risk window |
| 4 | Does monthly spend affect churn? | High-spend customers (>$70/mo) churn at **35.11%**, over 3x the rate of low-spend customers (10.61%) |
| 5 | Does internet service + tech support affect churn? | Fiber optic customers without tech support churn at **49.37%** — the single highest-risk segment found |
| 6 | Does payment method affect churn? | Electronic check users churn at **45.29%**, roughly 3x automatic payment methods (15–17%) |
| 7 | Are senior citizens more likely to churn? | Seniors churn at **41.68%** vs 23.61% for non-seniors |
| 8 | Does paperless billing correlate with churn? | Paperless billing customers churn at **33.57%** vs 16.33% for paper billing |
| 9 | Do add-on protection services reduce churn? | Customers with neither online security nor device protection churn at **47.05%**, dropping to **10.17%** with both |

## Business Recommendations

1. **Give new customers a discount to switch to a 1-year plan.** Month-to-month customers churn the most, so locking them in early could help a lot.
2. **Offer free tech support to Fiber customers who don't have it.** This group has the highest churn of all — support could keep more of them.
3. **Bundle security and device protection together.** Customers with both churn far less, so packaging them could boost retention.
4. **Push customers to switch from electronic check to autopay.** Manual payment users churn 3x more — autopay may help reduce that.
5. **Build a separate retention plan for senior citizens.** They churn almost twice as much as other customers.

## Tools Used

- **MySQL** — data cleaning, exploratory analysis, business-question-driven SQL queries
- **Power BI** — dashboard visualization of findings *(see /dashboard)*
- **AI (Claude)** — used to generate AI-assisted business insights from the SQL findings
- **Dataset**: [IBM Telco Customer Churn](https://www.kaggle.com/datasets/blastchar/telco-customer-churn) (Kaggle, 7,043 rows, 21 fields)
