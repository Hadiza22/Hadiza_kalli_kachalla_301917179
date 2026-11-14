# MIT 8103: Advanced Database Systems Portfolio
**Academic Session:** 2026/2027 (First Semester)  
**Course Code:** MIT 8103  
**Assessment Type:** Individual Practical Database Portfolio

---

## Student & Repository Information
* **Student Name:** Hadiza Kalli Kachalla
* **Student ID:** 30191719
* **GitHub Repository Link:** [https://github.com/Hadiza22/Hadiza_kalli_kachalla_301917179](https://github.com/Hadiza22/Hadiza_kalli_kachalla_301917179)
* **Selected Organisation / Case Study:** **Apex Stores & Logistics**

---

## 1. Selected Organisation & Case Study
**Apex Stores & Logistics** is a mid-sized hybrid e-commerce and delivery platform operating across urban centers. The platform handles product catalogs, customer profiles, dynamic order processing, inventory management, secure payments, and last-mile delivery tracking.

* **Primary Users:** Customers (buyers), Vendor Partners (merchants), Logistics Drivers, and System Administrators.
* **Core Data Stored:** Customer credentials, product inventory, order lines, payment audit logs, geospatial delivery checkpoints, and driver shifts.
* **Key Operations Supported:** High-concurrency inventory decrement during flash sales, ACID-compliant payment processing, complex analytical joins for sales reporting, flexible product attribute storage using NoSQL, and multi-region read scaling strategies.

---

## 2. Portfolio Components Index & Summary

| Component | Focus Area | Status | Folder Link |
| :--- | :--- | :--- | :--- |
| **Portfolio 1** | Database Design and Modelling | Completed | [`/portfolio-1-database-design`](./portfolio-1-database-design) |
| **Portfolio 2** | Query Processing and Optimisation | Completed | [`/portfolio-2-query-optimisation`](./portfolio-2-query-optimisation) |
| **Portfolio 3** | Transactions and Concurrency Control | Completed | [`/portfolio-3-transactions-concurrency`](./portfolio-3-transactions-concurrency) |
| **Portfolio 4** | NoSQL and Advanced Data Models | Completed | [`/portfolio-4-nosql`](./portfolio-4-nosql) |
| **Portfolio 5** | Distributed and Cloud Databases | Completed | [`/portfolio-5-distributed-cloud`](./portfolio-5-distributed-cloud) |

### Summary of Portfolio Activities
* **Portfolio 1 (Database Design & Modelling):** Designed a normalised relational schema up to 3NF consisting of `customers`, `products`, `orders`, `order_items`, and `payments`, complete with entity-relationship diagrams, referential integrity constraints, and check clauses.
* **Portfolio 2 (Query Processing & Optimisation):** Developed complex analytical queries utilizing window functions (`SUM() OVER()`) and multi-table joins. Analyzed execution plans via `EXPLAIN ANALYZE` and significantly reduced execution times by introducing targeted B-tree indexes.
* **Portfolio 3 (Transactions & Concurrency Control):** Implemented explicit ACID transactions with `REPEATABLE READ` isolation, using `SELECT ... FOR UPDATE` row-level locking to prevent race conditions during high-demand checkouts and demonstrating deadlock detection and resolution.
* **Portfolio 4 (NoSQL & Advanced Data Models):** Built a document-oriented MongoDB schema for semi-structured product catalogs featuring nested variant arrays and specification sub-documents, supported by schema validation and aggregation pipelines.
* **Portfolio 5 (Distributed & Cloud Databases):** Formulated a multi-region cloud scaling strategy utilizing leader-follower replication, hashed sharding keys (`customer_id`), and CAP theorem consistency trade-offs across financial and catalog workloads.

---

## 3. Individual Technical Reflection
Building this portfolio provided hands-on insight into real-world database engineering challenges and bridged the gap between abstract theory and practical execution. Designing pessimistic transaction locks for checkout concurrency in Portfolio 3 highlighted the delicate balance between high system throughput, deadlock risks, and strict data integrity. Meanwhile, implementing the NoSQL catalog model in Portfolio 4 demonstrated how flexible document structures effectively complement rigid relational ledgers in modern hybrid architectures.

---

## 4. AI Use Declaration
* **AI Tool Used:** Claude / Gemini AI assistants.
* **Purpose:** Used as a coding and documentation sounding board for syntax structures (PostgreSQL window functions, PL/pgSQL locks, and MongoDB validation schemas) and formatting consistency.
* **Verification:** All SQL scripts, database schemas, execution plans, and architectural configurations were personally reviewed, executed, tested, and verified by me.