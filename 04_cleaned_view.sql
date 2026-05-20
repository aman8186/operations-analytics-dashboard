USE operations_analytics;

CREATE OR REPLACE VIEW support_tickets_cleaned AS
SELECT
    ticket_id,
    STR_TO_DATE(created_at, '%Y-%m-%dT%H:%i:%s') AS created_at,
    customer_id,
    customer_segment,
    channel,
    product_area,
    issue_type,
    priority,
    status,
    sla_plan,
    initial_message,
    agent_first_reply,
    resolution_summary,
    CASE
        WHEN resolution_time_hours = '' THEN NULL
        ELSE CAST(resolution_time_hours AS DECIMAL(10,2))
    END AS resolution_time_hours,
    CASE
        WHEN reopened = '' THEN NULL
        ELSE CAST(reopened AS UNSIGNED)
    END AS reopened,
    customer_sentiment,
    CASE
        WHEN csat_score = '' THEN NULL
        ELSE CAST(csat_score AS UNSIGNED)
    END AS csat_score,
    CASE
        WHEN has_attachment = '' THEN NULL
        ELSE CAST(has_attachment AS UNSIGNED)
    END AS has_attachment,
    platform,
    region
FROM support_tickets_raw;
