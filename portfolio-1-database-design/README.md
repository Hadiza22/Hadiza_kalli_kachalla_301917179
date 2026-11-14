# Portfolio 1: Database Design and Modelling

## 1. Case Study Context: Apex Stores & Logistics
**Apex Stores & Logistics** is a mid-sized hybrid e-commerce and delivery platform operating across urban centers[cite: 2]. The system manages online retail storefronts, customer profiles, real-time stock tracking, order processing, and payment settlements[cite: 2].

To support daily operations reliably, the relational database must handle:
* **Customers & Vendors:** Managing buyer profiles and contact records[cite: 2, 13].
* **Inventory & Catalog:** Tracking product pricing and available stock counts[cite: 2, 13].
* **Order Processing:** Recording multi-item orders and tracking fulfillment states (`Pending`, `Paid`, `Shipped`, `Delivered`)[cite: 14].
* **Financial Settlements:** Logging verified payment transactions against specific orders[cite: 14].

---

## 2. Entity-Relationship (ER) Breakdown
Before writing SQL, the domain was broken down into five core entities to separate transactional records from master reference data[cite: 14]:

1. **`customers` (Strong Entity):** Stores unique buyer records (`customer_id`, `full_name`, `email`, `phone_number`)[cite: 13].
2. **`products` (Strong Entity):** Holds catalog items (`product_id`, `product_name`, `category`, `unit_price`, `stock_quantity`)[cite: 13].
3. **`orders` (Weak/Dependent Entity):** Captures order headers (`order_id`, `customer_id`, `order_status`, `total_amount`, `order_date`)[cite: 13].
4. **`order_items` (Associative/Junction Entity):** Resolves the many-to-many ($M:N$) relationship between `orders` and `products` (`order_item_id`, `order_id`, `product_id`, `quantity`, `subtotal`)[cite: 13, 14].
5. **`payments` (Dependent Entity):** Stores financial settlement details (`payment_id`, `order_id`, `payment_method`, `amount_paid`, `payment_status`)[cite: 13].

### Cardinality & Relationships
* **Customer $\rightarrow$ Orders ($1:N$):** One customer can place multiple orders over time, while each order belongs to exactly one customer.
* **Orders $\leftrightarrow$ Products ($M:N$):** A single order can contain many products, and any product can appear across numerous orders. This is resolved using the `order_items` bridge table[cite: 14].
* **Order $\rightarrow$ Payments ($1:N$):** An order can have one or more payment attempts (e.g., a failed card attempt followed by a successful transfer), linking each payment record back to `order_id`[cite: 13].

> **Note on ER Diagram:** *(Save your visual ER diagram image—exported from pgAdmin, Draw.io, or DBeaver—as `er-diagram.png` in this folder and link it here: `![ER Diagram](./er-diagram.png)`)*[cite: 14].

---

## 3. Relational Schema & Integrity Constraints
The physical schema is implemented in PostgreSQL (see [`schema.sql`](./schema.sql))[cite: 13, 14]. Specific constraints were enforced at the database engine level rather than relying solely on application code:

* **Primary Keys (`PRIMARY KEY`):** Every table uses an auto-incrementing `SERIAL` surrogate key (`customer_id`, `product_id`, `order_id`, etc.) for fast indexing and compact foreign key joins[cite: 13].
* **Unique Constraints (`UNIQUE`):** Applied to `customers.email` to prevent duplicate account registrations under the same email address[cite: 13].
* **Referential Integrity (`FOREIGN KEY`):**
  * `orders.customer_id` uses `ON DELETE CASCADE` so orphaned order headers do not remain if a test customer profile is purged[cite: 13].
  * `order_items.product_id` uses `ON DELETE RESTRICT` to prevent staff from accidentally deleting a product that already has historical sales records[cite: 13].
* **Domain & Business Rule Checks (`CHECK`):**
  * `unit_price >= 0` and `stock_quantity >= 0` on `products` prevent negative pricing or overselling stock below zero[cite: 13].
  * `quantity > 0` on `order_items` ensures empty zero-item lines cannot be inserted into an order[cite: 13].

---

## 4. Normalisation Explanation (Up to 3NF)
To eliminate update, insertion, and deletion anomalies, the schema was normalised progressively to **Third Normal Form (3NF)**[cite: 14]:

* **First Normal Form (1NF):** All attributes hold atomic, single values (e.g., storing a single `phone_number` and `email` per customer row rather than comma-separated lists), and every table has a defined primary key[cite: 13].
* **Second Normal Form (2NF):** All tables are in 1NF and contain no partial dependencies. Because every table uses a single-column surrogate primary key (`SERIAL`), non-key attributes depend on the entire primary key[cite: 13]. For instance, `quantity` and `subtotal` in `order_items` depend strictly on `order_item_id` (and the combination of `order_id` and `product_id`), while `product_name` and `unit_price` remain in `products` rather than being duplicated on every order line[cite: 13].
* **Third Normal Form (3NF):** All transitive dependencies have been removed. Non-key columns depend *only* on their table's primary key and not on other non-key columns. For example, customer contact details (`full_name`, `email`) are isolated in `customers` rather than stored inside `orders`; if a customer updates their phone number, it only needs to be updated in one row without causing update anomalies across past orders[cite: 13].

---

## 5. How to Run & Verify
1. Open your PostgreSQL client (`psql`, pgAdmin, or Codespaces terminal).
2. Create a database for the case study:
   ```sql
   CREATE DATABASE apex_logistics_db;