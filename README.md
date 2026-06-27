# ecommerce SQL project

 A sql project on ecommerce data. Ongoing as on June 14, 2026.

## Project Structure

```text
ecommerce-sql-project/
├── data_generator
│   ├── config.py
│   ├── generate_all.py
│   ├── generators
│   │   ├── addresses.py
│   │   ├── brands.py
│   │   ├── categories.py
│   │   ├── customers.py
│   │   ├── __init__.py
│   │   ├── inventory.py
│   │   ├── order_items.py
│   │   ├── orders.py
│   │   ├── payments.py
│   │   ├── products.py
│   │   └── product_variants.py
│   ├── __init__.py
│   ├── resources
│   │   ├── email_domains.json
│   │   ├── first_name_female.txt
│   │   ├── first_name_male.txt
│   │   └── surnames.txt
│   ├── tests
│   │   ├── test_addresses.py
│   │   ├── test_brands.py
│   │   ├── test_categories.py
│   │   ├── test_customers.py
│   │   ├── test_inventory.py
│   │   ├── test_order_items.py
│   │   ├── test_orders.py
│   │   ├── test_payments.py
│   │   ├── test_products.py
│   │   └── test_product_variants.py
│   └── utils.py
├── docs
│   ├── creating-table.md
│   └── images
│       └── ecommerce_er_diagram.svg
├── exports
├── generated_data
├── LICENSE
├── queries
├── README.html
├── README.md
├── requirements.txt
├── schema
│   ├── 001_create_customers.sql
│   ├── 002_create_addresses.sql
│   ├── 003_create_categories.sql
│   ├── 004_create_brands.sql
│   ├── 005_create_products.sql
│   ├── 006_create_product_variants.sql
│   ├── 007_create_inventory.sql
│   ├── 008_create_orders.sql
│   ├── 009_create_order_items.sql
│   └── 010_create_payments.sql
├── schema.sql
├── scripts
│   └── setup_database.sql
└── seed_data
    ├── 001_customers.sql
    ├── 002_addresses.sql
    ├── 003_categories.sql
    ├── 004_brands.sql
    ├── 005_products.sql
    ├── 006_product_variants.sql
    ├── 007_inventory.sql
    ├── 008_orders.sql
    ├── 009_order_items.sql
    └── 010_payments.sql
```

## Entity Relationship (ER) Diagram

![ER Diagram](docs/images/ecommerce_er_diagram.svg)

**Interactive Diagram:** https://dbdocs.io/b.sarma1729/Ecommerce-Databse-ER-Diagram?view=relationships