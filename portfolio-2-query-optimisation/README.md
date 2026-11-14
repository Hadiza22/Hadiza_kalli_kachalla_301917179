# Portfolio 2: Query Processing and Optimisation

## 1. Overview
This module evaluates query execution efficiency and performance tuning for **Apex Stores & Logistics**. Using the database schema developed in Portfolio 1, we implement complex analytical and transactional queries, examine their execution plans via `EXPLAIN ANALYZE`, and apply indexing strategies to minimize query costs and execution times.

---

## 2. Analytical & Transactional Query Design
To simulate real-world e-commerce reporting requirements, two primary queries were constructed:
1. **Monthly Revenue & Cumulative Totals:** Utilises window functions (`SUM() OVER()`) and date truncation to track revenue performance and running totals over time[cite: 11].
2. **Top-Selling Categories by Revenue:** Employs multi-table inner joins across `orders`, `order_items`, and `products` grouped by product category and name[cite: 11].

Refer to [`queries.sql`](./queries.sql) for the exact implementation script[cite: 12].

---

## 3. Query Optimisation & Indexing Strategy
When scaling past thousands of rows, unindexed foreign keys and join columns result in expensive full-table sequential scans. To solve this, the following B-tree indexes were introduced:
* `idx_orders_customer_id` on `orders(customer_id)` to speed up customer-order lookups[cite: 11].
* `idx_products_category` on `products(category)` to optimize category-based filtering and aggregations[cite: 11].
* `idx_orders_status_date` on `orders(order_status, order_date)` for fast conditional range scans on sales reports[cite: 11].

---

## 4. Execution Plan Performance Analysis
Using PostgreSQL's `EXPLAIN ANALYZE` tool, execution metrics before and after indexing were recorded:
* **Before Indexing:** The query engine relied on a Sequential Scan (`Seq Scan`) across the `order_items` and `products` tables, leading to a high total cost and execution time of ~215 ms[cite: 10].
* **After Indexing:** The query engine shifted to a Bitmap Index Scan and Hash Join combination, reducing execution time down to ~48 ms—demonstrating a major performance gain for large datasets[cite: 10].

Refer to [`execution-plans.txt`](./execution-plans.txt) for the raw console output and cost breakdowns[cite: 12].