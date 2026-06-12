CREATE TABLE products(
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
);