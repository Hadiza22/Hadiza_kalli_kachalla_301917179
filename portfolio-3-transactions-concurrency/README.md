# Portfolio 3: Transactions and Concurrency Control

## 1. Overview
This module explores ACID properties (Atomicity, Consistency, Isolation, Durability) and concurrency control mechanisms for **Apex Stores & Logistics**. In high-traffic retail environments, concurrent database transactions can lead to race conditions, lost updates, or deadlocks if not properly managed.

---

## 2. Transaction Management & Atomicity
Checkout workflows require multiple steps:
1. Validating and locking product inventory.
2. Creating an order header.
3. Inserting order items and decrementing stock.
4. Logging payment verification and finalizing order status.

Using explicit `BEGIN`, `COMMIT`, and `ROLLBACK` blocks in PL/pgSQL ensures that if any step fails (e.g., payment failure or insufficient stock), the entire transaction rolls back to maintain database consistency.

---

## 3. Concurrency Control & Locking Mechanisms
To prevent race conditions during flash sales where multiple users attempt to buy the last remaining stock item:
* **Pessimistic Locking (`SELECT ... FOR UPDATE`):** Used during the inventory check phase to acquire an exclusive row-level lock on specific product records. Other concurrent transactions are forced to wait until the lock is released.
* **Isolation Levels:** Evaluated under `REPEATABLE READ` to ensure strict financial reporting consistency and avoid phantom reads during concurrent updates.

---

## 4. Deadlock Detection & Resolution
During high-concurrency multi-table updates, deadlocks can occur when two transactions request locks on resources in reverse order. 
* **Simulation:** Transaction A locked an `orders` row while waiting for a `payments` row, while Transaction B locked the `payments` row and waited for the `orders` row.
* **Resolution:** PostgreSQL's deadlock detector successfully caught the cycle, aborting one transaction with an error. The application logic was then refactored to enforce a standardized lock acquisition order across all services.

Refer to [`transactions.sql`](./transactions.sql) and [`concurrency-logs.txt`](./concurrency-logs.txt) for the complete code and execution console logs.