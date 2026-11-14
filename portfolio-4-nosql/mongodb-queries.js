// MongoDB Document Model & Aggregation Scripts for Apex Stores & Logistics

// 1. Create Collection with JSON Schema Validation
db.createCollection("catalog", {
   validator: {
      $jsonSchema: {
         bsonType: "object",
         required: ["product_name", "category", "base_price", "attributes", "variants"],
         properties: {
            product_name: { bsonType: "string" },
            category: { bsonType: "string" },
            base_price: { bsonType: "double" },
            attributes: { bsonType: "object" },
            variants: {
               bsonType: "array",
               items: {
                  bsonType: "object",
                  required: ["sku", "price", "stock"],
                  properties: {
                     sku: { bsonType: "string" },
                     price: { bsonType: "double" },
                     stock: { bsonType: "int" }
                  }
               }
            }
         }
      }
   }
});

// 2. Insert Sample Product Document (Smartphone with dynamic specifications)
db.catalog.insertOne({
   product_name: "Apex Ultra Pro X",
   category: "Electronics",
   base_price: 350000.00,
   attributes: {
      brand: "ApexTech",
      screen_size_inches: 6.8,
      storage_options: ["128GB", "256GB", "512GB"],
      water_resistant: true
   },
   variants: [
      { sku: "APEX-UPX-128", price: 350000.00, stock: 25 },
      { sku: "APEX-UPX-128", price: 395000.00, stock: 12 }
   ],
   reviews: [
      { user_id: 102, rating: 5, comment: "Exceptional battery life and camera.", date: new Date() }
   ]
});

// 3. Aggregation Pipeline: Find average price by category and count variants
db.catalog.aggregate([
   { $group: {
        _id: "$category",
        average_base_price: { $avg: "$base_price" },
        total_products: { $sum: 1 },
        total_variants_available: { $sum: { $size: "$variants" } }
   }}
]);