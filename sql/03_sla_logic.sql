USE operations_analytics;

-- Step 1: Understand SLA plans and priorities
SELECT
    sla_plan,
    priority,
    COUNT(*) AS total_tickets
FROM support_tickets_raw
GROUP BY sla_plan, priority
ORDER BY sla_plan, priority;

-- Step 2: Create SLA target hours using business rules
SELECT
    ticket_id,
    priority,
    sla_plan,
    resolution_time_hours,
    CASE
        WHEN sla_plan = 'platinum' AND priority = 'critical' THEN 4
        WHEN sla_plan = 'platinum' AND priority = 'high' THEN 8
        WHEN sla_plan = 'platinum' AND priority = 'medium' THEN 24
        WHEN sla_plan = 'platinum' AND priority = 'low' THEN 48

        WHEN sla_plan = 'gold' AND priority = 'critical' THEN 8
        WHEN sla_plan = 'gold' AND priority = 'high' THEN 16
        WHEN sla_plan = 'gold' AND priority = 'medium' THEN 36
        WHEN sla_plan = 'gold' AND priority = 'low' THEN 72

        WHEN sla_plan = 'standard' AND priority = 'critical' THEN 12
        WHEN sla_plan = 'standard' AND priority = 'high' THEN 24
        WHEN sla_plan = 'standard' AND priority = 'medium' THEN 48
        WHEN sla_plan = 'standard' AND priority = 'low' THEN 96

        ELSE 72
    END AS sla_target_hours
FROM support_tickets_raw
LIMIT 20;

-- Step 3: Identify SLA breached tickets
SELECT
    ticket_id,
    priority,
    sla_plan,
    status,
    resolution_time_hours,
    CASE
        WHEN sla_plan = 'platinum' AND priority = 'critical' THEN 4
        WHEN sla_plan = 'platinum' AND priority = 'high' THEN 8
        WHEN sla_plan = 'platinum' AND priority = 'medium' THEN 24
        WHEN sla_plan = 'platinum' AND priority = 'low' THEN 48
        WHEN sla_plan = 'gold' AND priority = 'critical' THEN 8
        WHEN sla_plan = 'gold' AND priority = 'high' THEN 16
        WHEN sla_plan = 'gold' AND priority = 'medium' THEN 36
        WHEN sla_plan = 'gold' AND priority = 'low' THEN 72
        WHEN sla_plan = 'standard' AND priority = 'critical' THEN 12
        WHEN sla_plan = 'standard' AND priority = 'high' THEN 24
        WHEN sla_plan = 'standard' AND priority = 'medium' THEN 48
        WHEN sla_plan = 'standard' AND priority = 'low' THEN 96
        ELSE 72
    END AS sla_target_hours,
    CASE
        WHEN resolution_time_hours = '' THEN 'Not Resolved'
        WHEN CAST(resolution_time_hours AS DECIMAL(10,2)) >
            CASE
                WHEN sla_plan = 'platinum' AND priority = 'critical' THEN 4
                WHEN sla_plan = 'platinum' AND priority = 'high' THEN 8
                WHEN sla_plan = 'platinum' AND priority = 'medium' THEN 24
                WHEN sla_plan = 'platinum' AND priority = 'low' THEN 48
                WHEN sla_plan = 'gold' AND priority = 'critical' THEN 8
                WHEN sla_plan = 'gold' AND priority = 'high' THEN 16
                WHEN sla_plan = 'gold' AND priority = 'medium' THEN 36
                WHEN sla_plan = 'gold' AND priority = 'low' THEN 72
                WHEN sla_plan = 'standard' AND priority = 'critical' THEN 12
                WHEN sla_plan = 'standard' AND priority = 'high' THEN 24
                WHEN sla_plan = 'standard' AND priority = 'medium' THEN 48
                WHEN sla_plan = 'standard' AND priority = 'low' THEN 96
                ELSE 72
            END
        THEN 'Breached'
        ELSE 'Within SLA'
    END AS sla_status
FROM support_tickets_raw
LIMIT 50;

-- Step 4: SLA breach summary
SELECT
    sla_status,
    COUNT(*) AS total_tickets
FROM (
    SELECT
        CASE
            WHEN resolution_time_hours = '' THEN 'Not Resolved'
            WHEN CAST(resolution_time_hours AS DECIMAL(10,2)) >
                CASE
                    WHEN sla_plan = 'platinum' AND priority = 'critical' THEN 4
                    WHEN sla_plan = 'platinum' AND priority = 'high' THEN 8
                    WHEN sla_plan = 'platinum' AND priority = 'medium' THEN 24
                    WHEN sla_plan = 'platinum' AND priority = 'low' THEN 48
                    WHEN sla_plan = 'gold' AND priority = 'critical' THEN 8
                    WHEN sla_plan = 'gold' AND priority = 'high' THEN 16
                    WHEN sla_plan = 'gold' AND priority = 'medium' THEN 36
                    WHEN sla_plan = 'gold' AND priority = 'low' THEN 72
                    WHEN sla_plan = 'standard' AND priority = 'critical' THEN 12
                    WHEN sla_plan = 'standard' AND priority = 'high' THEN 24
                    WHEN sla_plan = 'standard' AND priority = 'medium' THEN 48
                    WHEN sla_plan = 'standard' AND priority = 'low' THEN 96
                    ELSE 72
                END
            THEN 'Breached'
            ELSE 'Within SLA'
        END AS sla_status
    FROM support_tickets_raw
) AS sla_data
GROUP BY sla_status
ORDER BY total_tickets DESC;
