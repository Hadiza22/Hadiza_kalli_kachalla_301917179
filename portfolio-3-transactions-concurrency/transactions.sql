-- PL/pgSQL Transaction Script with Row-Level Locking and Error Handling

BEGIN;

-- Set transaction isolation level for financial consistency
SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;

-- Step 1: Check inventory availability with pessimistic locking (SELECT FOR UPDATE)
SELECT stock_quantity, unit_price 
FROM products 
WHERE product_id = 104 
FOR UPDATE;

-- Step 2: Insert order header
INSERT INTO orders (customer_id, order_status, total_amount)
VALUES (12, 'Pending', 45000.00);

-- Retrieve generated order ID
-- (In application code: SELECT currval('orders_order_id_seq');)

-- Step 3: Insert order items and decrement stock
INSERT INTO order_items (order_id, product_id, quantity, subtotal)
VALUES (currval('orders_order_id_seq'), 104, 1, 45000.00);

UPDATE products 
SET stock_quantity = stock_quantity - 1 
WHERE product_id = 104;

-- Step 4: Record payment
INSERT INTO payments (order_id, payment_method, amount_paid, payment_status)
VALUES (currval('orders_order_id_seq'), 'Card', 45000.00, 'Successful');

-- Update order status to paid
UPDATE orders 
SET order_status = 'Paid' 
WHERE order_id = currval('orders_order_id_seq');

COMMIT;