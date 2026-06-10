CREATE TABLE addresses (
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
    ON addresses(customer_id);