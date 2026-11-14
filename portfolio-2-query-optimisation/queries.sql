-- Complex Analytical & Transactional Queries for Apex Stores & Logistics

-- 1. Monthly Revenue Aggregation using Window Functions
SELECT 
    DATE_TRUNC('month', order_date) AS sales_month,
    COUNT(order_id) AS total_orders,
    SUM(total_amount) AS monthly_revenue,
    SUM(SUM(total_amount)) OVER (ORDER BY DATE_TRUNC('month', order_date)) AS cumulative_revenue
FROM orders
WHERE order_status = 'Paid'
GROUP BY DATE_TRUNC('month', order_date)
ORDER BY sales_month;

-- 2. Top-Selling Products by Category
SELECT 
    p.category,
    p.product_name,
    SUM(oi.quantity) AS total_units_sold,
    SUM(oi.subtotal) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.category, p.product_name
ORDER BY total_revenue DESC
LIMIT 10;

-- 3. Optimised Index Creation for Foreign Keys and Frequent Filters
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
CREATE INDEX idx_products_category ON products(category);
CREATE INDEX idx_orders_status_date ON orders(order_status, order_date);