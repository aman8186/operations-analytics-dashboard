USE operations_analytics;

-- 1. Count total rows
SELECT COUNT(*) AS total_rows
FROM support_tickets_raw;

-- 2. View first 10 rows
SELECT *
FROM support_tickets_raw
LIMIT 10;

-- 3. Check column-level missing values
SELECT
    SUM(CASE WHEN ticket_id = '' OR ticket_id IS NULL THEN 1 ELSE 0 END) AS missing_ticket_id,
    SUM(CASE WHEN created_at = '' OR created_at IS NULL THEN 1 ELSE 0 END) AS missing_created_at,
    SUM(CASE WHEN customer_id = '' OR customer_id IS NULL THEN 1 ELSE 0 END) AS missing_customer_id,
    SUM(CASE WHEN resolution_time_hours = '' OR resolution_time_hours IS NULL THEN 1 ELSE 0 END) AS missing_resolution_time,
    SUM(CASE WHEN csat_score = '' OR csat_score IS NULL THEN 1 ELSE 0 END) AS missing_csat_score
FROM support_tickets_raw;

-- 4. Check duplicate ticket IDs
SELECT
    ticket_id,
    COUNT(*) AS duplicate_count
FROM support_tickets_raw
GROUP BY ticket_id
HAVING COUNT(*) > 1;

-- 5. Check unique values in important columns
SELECT DISTINCT priority
FROM support_tickets_raw;

SELECT DISTINCT status
FROM support_tickets_raw;

SELECT DISTINCT sla_plan
FROM support_tickets_raw;

SELECT DISTINCT customer_sentiment
FROM support_tickets_raw;

-- 6. Check ticket volume by status
SELECT
    status,
    COUNT(*) AS total_tickets
FROM support_tickets_raw
GROUP BY status
ORDER BY total_tickets DESC;

-- 7. Check ticket volume by priority
SELECT
    priority,
    COUNT(*) AS total_tickets
FROM support_tickets_raw
GROUP BY priority
ORDER BY total_tickets DESC;

-- 8. Check ticket volume by channel
SELECT
    channel,
    COUNT(*) AS total_tickets
FROM support_tickets_raw
GROUP BY channel
ORDER BY total_tickets DESC;

-- 9. Check average CSAT by region
SELECT
    region,
    ROUND(AVG(CAST(csat_score AS DECIMAL(10,2))), 2) AS avg_csat
FROM support_tickets_raw
WHERE csat_score <> ''
GROUP BY region
ORDER BY avg_csat ASC;

-- 10. Check average resolution time by priority
SELECT
    priority,
    ROUND(AVG(CAST(resolution_time_hours AS DECIMAL(10,2))), 2) AS avg_resolution_hours
FROM support_tickets_raw
WHERE resolution_time_hours <> ''
GROUP BY priority
ORDER BY avg_resolution_hours DESC;
