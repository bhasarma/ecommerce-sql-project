CREATE TABLE order_items(
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

CREATE INDEX idx_order_items_order_id
    ON order_items(order_id); 
