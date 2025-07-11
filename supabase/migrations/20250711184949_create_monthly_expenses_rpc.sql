-- 創建月度統計的RPC函數
CREATE OR REPLACE FUNCTION get_monthly_expenses(
    start_year INTEGER,
    start_month INTEGER,
    end_year INTEGER,
    end_month INTEGER,
    user_id UUID DEFAULT NULL
)
RETURNS TABLE(
    year INTEGER,
    month INTEGER,
    total_amount DECIMAL,
    product_count INTEGER
) 
LANGUAGE plpgsql
AS $$
DECLARE
    start_date DATE;
    end_date DATE;
BEGIN
    -- 設定開始和結束日期
    start_date := make_date(start_year, start_month, 1);
    end_date := make_date(end_year, end_month, 1) + INTERVAL '1 month' - INTERVAL '1 day';
    
    -- 返回月度統計資料
    RETURN QUERY
    WITH months AS (
        -- 生成月份序列
        SELECT 
            EXTRACT(YEAR FROM generate_series)::INTEGER as year,
            EXTRACT(MONTH FROM generate_series)::INTEGER as month
        FROM generate_series(
            start_date,
            end_date,
            INTERVAL '1 month'
        )
    ),
    monthly_data AS (
        -- 計算每個月的統計資料
        SELECT 
            EXTRACT(YEAR FROM p.purchase_date)::INTEGER as year,
            EXTRACT(MONTH FROM p.purchase_date)::INTEGER as month,
            SUM(p.price) as total_amount,
            COUNT(p.id)::INTEGER as product_count
        FROM products p
        WHERE 
            p.purchase_date >= start_date 
            AND p.purchase_date <= end_date
            AND (user_id IS NULL OR p.user = user_id)
        GROUP BY 
            EXTRACT(YEAR FROM p.purchase_date),
            EXTRACT(MONTH FROM p.purchase_date)
    )
    SELECT 
        m.year,
        m.month,
        COALESCE(md.total_amount, 0) as total_amount,
        COALESCE(md.product_count, 0) as product_count
    FROM months m
    LEFT JOIN monthly_data md ON m.year = md.year AND m.month = md.month
    ORDER BY m.year, m.month;
END;
$$;