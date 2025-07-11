CREATE OR REPLACE FUNCTION get_brand_stats(
    user_id UUID DEFAULT NULL,
    start_date DATE DEFAULT NULL,
    end_date DATE DEFAULT NULL
)
RETURNS TABLE(
    brand_id UUID,
    brand_name TEXT,
    total_amount DECIMAL,
    product_count INTEGER
) 
LANGUAGE plpgsql
AS $$
BEGIN
    RETURN QUERY
    SELECT 
        b.id as brand_id,
        b.brand_name::TEXT as brand_name,
        COALESCE(SUM(CASE 
            WHEN (start_date IS NULL OR p.purchase_date >= start_date)
                AND (end_date IS NULL OR p.purchase_date <= end_date)
            THEN p.price 
            ELSE 0 
        END), 0) as total_amount,
        COUNT(CASE 
            WHEN (start_date IS NULL OR p.purchase_date >= start_date)
                AND (end_date IS NULL OR p.purchase_date <= end_date)
            THEN p.id 
            ELSE NULL 
        END)::INTEGER as product_count
    FROM brands b
    LEFT JOIN products p ON b.id = p.brand
    WHERE 
        (user_id IS NULL OR b."user" = user_id)
    GROUP BY b.id, b.brand_name
    ORDER BY total_amount DESC, product_count DESC;
END;
$$;