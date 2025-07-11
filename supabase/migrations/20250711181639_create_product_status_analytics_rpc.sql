CREATE OR REPLACE FUNCTION get_product_status_stats(user_id UUID DEFAULT NULL)
RETURNS TABLE (
    status_type TEXT,
    count BIGINT
) 
LANGUAGE plpgsql
AS $$
DECLARE
    total_count BIGINT;
BEGIN
    -- 返回統計結果
    RETURN QUERY
    WITH status_stats AS (
        SELECT 
            CASE 
                WHEN status = 'inUse' AND expiry_date > CURRENT_DATE + INTERVAL '30 days' THEN 'inUse'
                WHEN status = 'inUse' AND expiry_date <= CURRENT_DATE + INTERVAL '30 days' AND expiry_date > CURRENT_DATE THEN 'expiring'
                WHEN (status = 'inUse' AND expiry_date <= CURRENT_DATE) OR status = 'deprecated' THEN 'deprecated'
                WHEN status = 'finished' THEN 'finished'
                ELSE 'other'
            END as status_category,
            COUNT(*) as status_count
        FROM products
        WHERE (user_id IS NULL OR "user" = user_id)
        GROUP BY 
            CASE 
                WHEN status = 'inUse' AND expiry_date > CURRENT_DATE + INTERVAL '30 days' THEN 'inUse'
                WHEN status = 'inUse' AND expiry_date <= CURRENT_DATE + INTERVAL '30 days' AND expiry_date > CURRENT_DATE THEN 'expiring'
                WHEN (status = 'inUse' AND expiry_date <= CURRENT_DATE) OR status = 'deprecated' THEN 'deprecated'
                WHEN status = 'finished' THEN 'finished'
                ELSE 'other'
            END
    )
    SELECT 
        status_category::TEXT,
        status_count
    FROM status_stats
    ORDER BY status_count DESC;
END;
$$;
