-- Creates the `invoices` and `invoice_items` tables.
-- Idempotent: safe to run repeatedly. Requires the `items` table (see seed_items.sql).

BEGIN;

CREATE TABLE IF NOT EXISTS invoices (
    id               BIGINT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    invoice_date     DATE          NOT NULL,
    amount           NUMERIC(10,2) NOT NULL CHECK (amount >= 0),
    delivery_address TEXT          NOT NULL
);

CREATE TABLE IF NOT EXISTS invoice_items (
    invoice_id BIGINT        NOT NULL REFERENCES invoices (id) ON DELETE CASCADE,
    item_id    BIGINT        NOT NULL REFERENCES items (id) ON DELETE RESTRICT,
    quantity   INTEGER       NOT NULL CHECK (quantity > 0),
    unit_price NUMERIC(10,2) NOT NULL CHECK (unit_price >= 0),
    PRIMARY KEY (invoice_id, item_id)
);

CREATE INDEX IF NOT EXISTS invoice_items_item_id_idx ON invoice_items (item_id);

COMMIT;
