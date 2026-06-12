CREATE TABLE product_variants(
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
);