# AI-Driven Operations Analytics Dashboard

## Project Overview

This project analyzes 100,000 IT support tickets for a SaaS-style business. The goal is to help operations managers monitor SLA performance, customer satisfaction, reopen rates, product issue trends, and high-risk unresolved tickets.

The project combines SQL, Python, machine learning, and Power BI to create an end-to-end analytics solution.

## Business Problem

Support teams handle thousands of customer tickets across different regions, channels, product areas, and priority levels. If tickets are not resolved within the promised SLA time, customers may become dissatisfied, tickets may be reopened, and the company may lose customer trust.

This project helps identify:
- Which tickets breach SLA
- Which product areas create more support pressure
- Which channels have higher reopen rates
- Which customers show lower satisfaction
- Which unresolved tickets should be handled first

## Tools Used

- MySQL Workbench
- SQL
- Python
- Pandas
- Scikit-learn
- Google Colab
- Power BI Desktop
- VS Code

## Dataset

Dataset: Synthetic IT Support Tickets  
Rows: 100,000  
Domain: IT support / SaaS customer service operations  
Source: Kaggle

## Key KPIs

- Total tickets: 100,000
- SLA breach rate: 13.58%
- Within SLA tickets: 46,530
- Breached tickets: 13,583
- Not resolved tickets: 39,887
- Average resolution time: 45.01 hours
- Average CSAT score: 2.24 / 5
- Reopen rate: 5.05%

## Machine Learning Model

A Random Forest Classifier was trained to predict SLA breach risk for unresolved tickets.

Features used:
- Customer segment
- Channel
- Product area
- Issue type
- Priority
- SLA plan
- Customer sentiment
- Platform
- Region
- Attachment flag
- Created hour

Model accuracy: 78.36%

The model classified unresolved tickets into:
- Low Risk: 31,446
- Medium Risk: 7,402
- High Risk: 1,039

## Dashboard Pages

1. Executive Overview
2. SLA Performance
3. Customer Experience
4. Risk Prediction Queue

## Business Impact

The dashboard helps operations managers identify SLA bottlenecks, monitor customer satisfaction, track reopened tickets, and prioritize high-risk unresolved tickets before they breach SLA.