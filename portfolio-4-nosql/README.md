# Portfolio 4: NoSQL and Advanced Data Models

## 1. Overview
This module explores NoSQL data modelling using MongoDB for **Apex Stores & Logistics**. In modern e-commerce architectures, product catalogs require high read performance, flexible schemas, and nested attributes without enforcing rigid tabular structures.

---

## 2. NoSQL Model Justification & Design Choices
Unlike relational databases that normalize attributes across multiple joined tables, this NoSQL implementation utilizes a **Document-oriented model** (`catalog` collection):
* **Embedded Sub-documents:** Product variants (SKUs, pricing, stock levels) and customer reviews are embedded directly inside the main product document. This allows a product page to be retrieved in a single read operation (`O(1)` query complexity) without expensive multi-table joins.
* **Flexible Schemas:** Different product categories (e.g., Electronics vs. Fashion) require entirely different specification attributes. MongoDB’s schemaless nature allows diverse attributes to be stored cleanly inside an `attributes` sub-object without modifying table definitions or leaving null columns.

---

## 3. Implementation Scripts
Refer to [`mongodb-queries.js`](./mongodb-queries.js) for the complete collection validation rules, sample document insertions, and aggregation pipelines.