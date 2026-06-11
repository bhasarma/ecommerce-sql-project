CREATE TABLE inventory (
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
);