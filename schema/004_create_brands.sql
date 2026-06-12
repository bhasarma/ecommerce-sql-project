CREATE TABLE brands(
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
);