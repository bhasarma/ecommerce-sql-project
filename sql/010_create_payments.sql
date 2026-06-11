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
                'partially_refunded'CREATE TABLE payments(
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
        )

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