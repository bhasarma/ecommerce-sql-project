CREATE TABLE categories (
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
    ON categories(parent_category_id);