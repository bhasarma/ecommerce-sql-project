CREATE TABLE customers (
    customer_id BIGSERIAL PRIMARY KEY,

    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,

    email VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(30),

    date_of_birth DATE,

    gender VARCHAR(20)
        CHECK (gender IN (
            'male',
            'female',
            'non-binary',
            'prefer_not_to_say'
        )),
    
    last_login_date TIMESTAMPTZ,

    account_status VARCHAR(20) NOT NULL
        DEFAULT 'active'
        CHECK (account_status IN (
            'active',
            'inactive',
            'suspended',
            'deleted'
        )),

    loyalty_tier VARCHAR(20) NOT NULL
        DEFAULT 'bronze'
        CHECK (loyalty_tier IN (
            'bronze',
            'silver',
            'gold',
            'platinum'
        )),

    marketing_opt_in BOOLEAN NOT NULL DEFAULT FALSE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE INDEX idx_customers_account_status ON customers(account_status);
CREATE INDEX idx_customers_created_at ON customers(created_at);CREATE TABLE addresses (
    address_id BIGSERIAL PRIMARY KEY,
    customer_id BIGINT NOT NULL,

    address_type VARCHAR(20) NOT NULL
        CHECK (address_type IN (
            'home',
            'billing',
            'shipping',
            'office'
        )), 
    
    recipient_name VARCHAR(100) NOT NULL,

    company_name VARCHAR(100),

    address_line1 VARCHAR(255) NOT NULL,
    address_line2 VARCHAR(255),

    city VARCHAR(100) NOT NULL,
    state_province VARCHAR(100),
    postal_code VARCHAR(20) NOT NULL,
    country_code CHAR(2) NOT NULL CHECK (country_code = UPPER(country_code)),

    phone_number VARCHAR(30),

    is_default BOOLEAN NOT NULL DEFAULT FALSE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    deleted_at TIMESTAMPTZ,

    CONSTRAINT fk_addresses_customer
        FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

CREATE INDEX idx_addresses_customer_id
    ON addresses(customer_id);CREATE TABLE categories (
    category_id BIGSERIAL PRIMARY KEY,

    parent_category_id BIGINT
        REFERENCES categories(category_id)
        ON DELETE SET NULL,

    category_name VARCHAR(100) NOT NULL,

    category_slug VARCHAR(120) NOT NULL UNIQUE,

    category_description TEXT, 

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    deleted_at TIMESTAMPTZ,

    CONSTRAINT categories_name_not_empty_string
        CHECK (TRIM(category_name) <> ''),

    CONSTRAINT categories_slug_not_empty_string
        CHECK (TRIM(category_slug) <> '')
);

CREATE INDEX idx_categories_deleted_at
    ON categories(deleted_at);

CREATE INDEX idx_categories_parent_category_id
    ON categories(parent_category_id);CREATE TABLE brands(
    brand_id BIGSERIAL PRIMARY KEY,

    brand_name VARCHAR(100) NOT NULL UNIQUE,

    brand_slug VARCHAR(100) NOT NULL UNIQUE,

    brand_description TEXT,

    website_url TEXT,

    logo_url TEXT,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    
    deleted_at TIMESTAMPTZ,

    CONSTRAINT chk_brand_name_not_empty_text
        CHECK (TRIM(brand_name) <> ''),


    CONSTRAINT chk_brand_slug_not_empty_text
        CHECK (TRIM(brand_slug) <> '')
);CREATE TABLE products(
    product_id BIGSERIAL PRIMARY KEY,

    category_id BIGINT NOT NULL,

    brand_id BIGINT,    

    product_name VARCHAR(200) NOT NULL,

    product_slug VARCHAR(250) NOT NULL UNIQUE,

    product_description TEXT,

    short_description VARCHAR(500),

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    deleted_at TIMESTAMPTZ,

    CONSTRAINT fk_products_category
        FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
        ON DELETE RESTRICT,

    CONSTRAINT fk_products_brand
        FOREIGN  KEY (brand_id)
        REFERENCES brands(brand_id)
        ON DELETE SET NULL,

    CONSTRAINT chk_product_name_not_empty_text
        CHECK (TRIM(product_name) <> ''),
        
    CONSTRAINT chk_product_slug_not_empty_text
        CHECK (TRIM(product_slug) <> '')
);CREATE TABLE product_variants(
    variant_id BIGSERIAL PRIMARY KEY,

    product_id BIGINT NOT NULL
        REFERENCES products(product_id)
        ON DELETE CASCADE,

    sku VARCHAR(100) NOT NULL UNIQUE,

    variant_name VARCHAR(200) NOT  NULL,

    price NUMERIC(10,2) NOT NULL,

    compare_at_price NUMERIC(10,2),

    cost_price NUMERIC(10,2),

    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    deleted_at TIMESTAMPTZ,

    CONSTRAINT chk_price_positive
        CHECK (price >= 0),

    CONSTRAINT chk_compare_at_price_positive
        CHECK (
            compare_at_price IS NULL
            OR compare_at_price >= 0
            ),

    CONSTRAINT chk_compare_at_price_greater
        CHECK (
            compare_at_price IS NULL
            OR compare_at_price >= price
            ),

    CONSTRAINT chk_cost_price_positive
        CHECK (
            cost_price IS NULL
            OR cost_price >= 0
            ),

    CONSTRAINT chk_sku_not_empty_text
        CHECK (TRIM(sku) <> ''),

    CONSTRAINT chk_variant_name_not_empty_text
        CHECK (TRIM(variant_name) <> '')
);CREATE TABLE inventory (
    inventory_id BIGSERIAL PRIMARY KEY,

    variant_id BIGINT NOT NULL UNIQUE
        REFERENCES product_variants(variant_id)
        ON DELETE CASCADE,

    quantity_on_hand INT NOT NULL DEFAULT 0,

    quantity_reserved INT NOT NULL DEFAULT 0,

    reorder_level INT NOT NULL DEFAULT 0,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_quantity_on_hand_non_negative
        CHECK (quantity_on_hand >= 0),

    CONSTRAINT chk_quantity_reserved_non_negative
        CHECK (quantity_reserved >= 0),

    CONSTRAINT chk_stock_greater_than_reserved
        CHECK (quantity_on_hand >= quantity_reserved),

    CONSTRAINT chk_reorder_level_non_negative
        CHECK (reorder_level >= 0)
);CREATE TABLE orders (
    order_id BIGSERIAL PRIMARY KEY,

    customer_id BIGINT NOT NULL
        REFERENCES customers(customer_id)   
        ON DELETE RESTRICT,

    order_status VARCHAR(30) NOT NULL 
        DEFAULT 'pending'
        CHECK (
            order_status IN (
                'pending',
                'confirmed',
                'processing',
                'shipped',
                'delivered',
                'cancelled',
                'returned',
                'refunded'
            )
        ),
    
    billing_address_id BIGINT
        REFERENCES addresses(address_id)
        ON DELETE SET NULL,

    shipping_address_id BIGINT
        REFERENCES addresses(address_id)
        ON DELETE SET NULL,

    subtotal_amount NUMERIC(12,2) NOT NULL,
    discount_amount NUMERIC(12,2) NOT NULL DEFAULT 0,
    shipping_amount NUMERIC(12,2) NOT NULL DEFAULT 0,
    tax_amount NUMERIC(12,2) NOT NULL DEFAULT 0,
    total_amount NUMERIC(12,2) NOT NULL,
    
    currency_code CHAR(3) NOT NULL DEFAULT 'EUR',

    order_date TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    shipped_at TIMESTAMPTZ,

    delivered_at TIMESTAMPTZ,

    cancelled_at TIMESTAMPTZ,

    cancellation_reason TEXT,

    customer_note TEXT,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT chk_subtotal_non_negative
        CHECK (subtotal_amount >= 0),    

    CONSTRAINT chk_discount_non_negative
        CHECK (discount_amount >= 0),
    
    CONSTRAINT chk_shipping_non_negative
        CHECK (shipping_amount >= 0),

    CONSTRAINT chk_tax_non_negative
        CHECK (tax_amount >= 0),

    CONSTRAINT chk_total_non_negative
        CHECK (total_amount >= 0),

    CONSTRAINT chk_total_amount
        CHECK   (
            total_amount = 
            subtotal_amount
            - discount_amount
            + shipping_amount
            + tax_amount
        ),

    CONSTRAINT chk_currency_code
        CHECK (currency_code ~ '^[A-Z]{3}$')
);CREATE TABLE order_items(
    order_item_id BIGSERIAL PRIMARY KEY,

    order_id BIGINT NOT NULL
        REFERENCES orders(order_id)
        ON DELETE CASCADE,

    variant_id BIGINT NOT NULL
        REFERENCES product_variants(variant_id)
        ON DELETE RESTRICT,

    quantity INT NOT NULL,

    unit_price NUMERIC(12,2) NOT NULL,
    line_total NUMERIC(12,2) NOT NULL,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,

    CONSTRAINT  chk_order_item_quantity_positive
        CHECK (quantity > 0),
    
    CONSTRAINT  chk_order_item_unit_price_non_negative
        CHECK (unit_price >= 0),

    CONSTRAINT chk_order_item_line_total_non_negative
        CHECK (line_total >= 0),

    CONSTRAINT uq_order_variant
        UNIQUE (order_id, variant_id)   

);
CREATE TABLE payments(
    payment_id BIGSERIAL PRIMARY KEY,

    order_id BIGINT NOT NULL
        REFERENCES orders(order_id)
        ON DELETE RESTRICT,

    payment_method VARCHAR(50) NOT NULL, 

    payment_status VARCHAR(50) NOT NULL DEFAULT 'pending',

    transaction_id VARCHAR(255) UNIQUE,

    amount NUMERIC(12,2) NOT NULL,

    currency_code VARCHAR(3) NOT NULL DEFAULT 'EUR',

    payment_date TIMESTAMPTZ,

    created_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,


    CONSTRAINT chk_payment_amount_positive
        CHECK (amount > 0),

    CONSTRAINT chk_currency_code_format
        CHECK (currency_code ~ '^[A-Z]{3}$'),

    CONSTRAINT chk_payment_method
         CHECK (
            payment_method IN (
                'card',
                'paypal',
                'bank_transfer',
                'apple_pay',
                'google_pay'
            )
        ),

    CONSTRAINT chk_payment_status
        CHECK (
            payment_status IN (
                'pending',
                'authorized',
                'completed',
                'failed',
                'cancelled',
                'refunded',
                'partially_refunded'
            )
        )
);