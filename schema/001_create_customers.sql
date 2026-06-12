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
CREATE INDEX idx_customers_created_at ON customers(created_at);