CREATE TABLE orders (
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
);