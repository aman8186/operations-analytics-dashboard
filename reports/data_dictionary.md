# Data Dictionary

Dataset: `synthetic_it_support_tickets.csv`
Rows: 100,000
Business domain: IT/SaaS customer support operations

## Main Table: support_tickets_raw

| Column | Meaning | Use in Project |
|---|---|---|
| ticket_id | Unique ticket identifier | Primary key |
| created_at | Ticket creation timestamp | Trend analysis by day, month, hour |
| customer_id | Unique customer identifier | Customer-level repeat issue analysis |
| customer_segment | Customer type such as individual, enterprise, education | Segment-wise SLA and CSAT analysis |
| channel | Ticket source such as email, chat, phone, web, in-app | Channel performance comparison |
| product_area | Product module related to the issue | Product bottleneck analysis |
| issue_type | Type of customer problem | Root cause analysis |
| priority | Ticket urgency | SLA risk and workload analysis |
| status | Current/final ticket status | Open vs resolved performance |
| sla_plan | Customer SLA plan | SLA benchmark and breach logic |
| initial_message | Customer's issue text | Text analysis or issue examples |
| agent_first_reply | Agent's first response text | Response quality context |
| resolution_summary | Final resolution note | Closure pattern analysis |
| resolution_time_hours | Time taken to resolve the ticket | Main KPI for SLA and prediction |
| reopened | Whether the ticket was reopened | Quality and repeat-work KPI |
| customer_sentiment | Customer mood/sentiment | CSAT and escalation analysis |
| csat_score | Customer satisfaction rating | Quality outcome KPI |
| has_attachment | Whether ticket included an attachment | Complexity indicator |
| platform | Platform used by customer | Platform issue analysis |
| region | Customer region | Regional performance comparison |

## Target KPIs

- Total tickets
- Resolved tickets
- Open/in-progress tickets
- Average resolution time
- SLA breach rate
- Reopen rate
- Average CSAT score
- Ticket volume by channel, priority, product area, and region
- High-risk tickets likely to breach SLA

## Planned Advanced Features

- Data quality checks for missing values, invalid values, and duplicate tickets
- SLA breach flag based on priority and SLA plan
- SQL dashboard queries using joins, CTEs, CASE statements, and window functions
- Python model to predict SLA breach risk
- Power BI dashboard for operations managers
