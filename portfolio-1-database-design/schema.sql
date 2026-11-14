-- PostgreSQL DDL Script for Apex Stores & Logistics (Portfolio 1)

CREATE TABLE customers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    phone_number VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    product_name VARCHAR(150) NOT NULL,
    category VARCHAR(50) NOT NULL,
    unit_price NUMERIC(10, 2) CHECK (unit_price >= 0),
    stock_quantity INT CHECK (stock_quantity >= 0),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE orders (
    order_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES customers(customer_id) ON DELETE CASCADE,
    order_status VARCHAR(30) DEFAULT 'Pending',
    total_amount NUMERIC(12, 2) CHECK (total_amount >= 0),
    order_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE order_items (
    order_item_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
    product_id INT REFERENCES products(product_id) ON DELETE RESTRICT,
    quantity INT CHECK (quantity > 0),
    subtotal NUMERIC(10, 2) CHECK (subtotal >= 0)
);

CREATE TABLE payments (
    payment_id SERIAL PRIMARY KEY,
    order_id INT REFERENCES orders(order_id) ON DELETE CASCADE,
    payment_method VARCHAR(50) NOT NULL,
    amount_paid NUMERIC(12, 2) CHECK (amount_paid >= 0),
    payment_status VARCHAR(30) DEFAULT 'Successful',
    paid_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);