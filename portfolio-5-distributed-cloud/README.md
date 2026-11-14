# Portfolio 5: Distributed and Cloud Database Exercise

## 1. Overview
As e-commerce and logistics platforms scale globally, single-node relational databases become choke points. This module covers architecture patterns for high availability, fault tolerance, horizontal scaling, and replication strategies for **Apex Stores & Logistics**.

---

## 2. Distributed Architecture Strategy
To handle multi-region traffic and massive transactional loads, the following cloud architecture choices were designed:
* **Sharding Strategy:** Implementing **Hashed Sharding** using `customer_id` as the shard key[cite: 3]. This ensures even data distribution across 4 distinct database clusters, preventing write bottlenecks on a single server[cite: 3].
* **Replication Topology:** Utilizing a **Leader-Follower (Master-Slave)** replication model. All write operations (orders, payments, inventory updates) are routed to the primary node in the `af-south-1` region, while read-heavy tasks (such as catalog browsing and product searches) are scaled across read replicas in `eu-west-1` and `us-east-1`[cite: 3].
* **CAP Theorem Trade-off:** 
  * For financial ledgers and payment processing, the system enforces **Strong Consistency (CP)** to prevent double-spending or balance mismatches[cite: 3].
  * For the product catalog and cart caching, the system opts for **Availability and Partition tolerance (AP)** to ensure users can always browse items even during minor network partitions[cite: 3].

---

## 3. Configuration File
Refer to [`cluster-config.json`](./cluster-config.json) for the simulated distributed database cluster and replica set configuration parameters[cite: 4].