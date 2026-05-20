USE operations_analytics;

-- 1. Main dashboard KPIs
SELECT
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN sla_status = 'Within SLA' THEN 1 ELSE 0 END) AS within_sla_tickets,
    SUM(CASE WHEN sla_status = 'Breached' THEN 1 ELSE 0 END) AS breached_tickets,
    SUM(CASE WHEN sla_status = 'Not Resolved' THEN 1 ELSE 0 END) AS not_resolved_tickets,
    ROUND(SUM(CASE WHEN sla_status = 'Breached' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS sla_breach_rate,
    ROUND(AVG(resolution_time_hours), 2) AS avg_resolution_hours,
    ROUND(AVG(csat_score), 2) AS avg_csat_score,
    ROUND(SUM(CASE WHEN reopened = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS reopen_rate
FROM support_tickets_sla;

-- 2. Monthly ticket volume
SELECT
    DATE_FORMAT(created_at, '%Y-%m') AS month,
    COUNT(*) AS total_tickets
FROM support_tickets_sla
GROUP BY DATE_FORMAT(created_at, '%Y-%m')
ORDER BY month;

-- 3. Ticket volume by product area
SELECT
    product_area,
    COUNT(*) AS total_tickets
FROM support_tickets_sla
GROUP BY product_area
ORDER BY total_tickets DESC;

-- 4. Ticket volume by channel
SELECT
    channel,
    COUNT(*) AS total_tickets
FROM support_tickets_sla
GROUP BY channel
ORDER BY total_tickets DESC;

-- 5. Average resolution time by priority
SELECT
    priority,
    ROUND(AVG(resolution_time_hours), 2) AS avg_resolution_hours
FROM support_tickets_sla
WHERE resolution_time_hours IS NOT NULL
GROUP BY priority
ORDER BY avg_resolution_hours DESC;

-- 6. Average CSAT by region
SELECT
    region,
    ROUND(AVG(csat_score), 2) AS avg_csat_score
FROM support_tickets_sla
GROUP BY region
ORDER BY avg_csat_score ASC;

-- 7. Reopen rate by channel
SELECT
    channel,
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN reopened = 1 THEN 1 ELSE 0 END) AS reopened_tickets,
    ROUND(SUM(CASE WHEN reopened = 1 THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS reopen_rate
FROM support_tickets_sla
GROUP BY channel
ORDER BY reopen_rate DESC;

-- 8. SLA breach rate by product area
SELECT
    product_area,
    COUNT(*) AS total_tickets,
    SUM(CASE WHEN sla_status = 'Breached' THEN 1 ELSE 0 END) AS breached_tickets,
    ROUND(SUM(CASE WHEN sla_status = 'Breached' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS breach_rate
FROM support_tickets_sla
GROUP BY product_area
ORDER BY breach_rate DESC;

-- 9. Top issue types
SELECT
    issue_type,
    COUNT(*) AS total_tickets
FROM support_tickets_sla
GROUP BY issue_type
ORDER BY total_tickets DESC;

-- 10. High-risk unresolved tickets
SELECT
    ticket_id,
    created_at,
    customer_segment,
    channel,
    product_area,
    issue_type,
    priority,
    sla_plan,
    customer_sentiment,
    csat_score,
    region
FROM support_tickets_sla
WHERE sla_status = 'Not Resolved'
  AND priority IN ('critical', 'high')
ORDER BY created_at ASC
LIMIT 100;
