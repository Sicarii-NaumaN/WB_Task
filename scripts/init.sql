CREATE EXTENSION IF NOT EXISTS CITEXT;

DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS items CASCADE;
DROP TABLE IF EXISTS items_in_order CASCADE;

CREATE UNLOGGED TABLE IF NOT EXISTS payments (
    transaction     CITEXT UNIQUE NOT NULL PRIMARY KEY,
    currency        CITEXT NOT NULL,
    provider        CITEXT NOT NULL,
    amount          CITEXT NOT NULL,
    payment_dt      INT    NOT NULL DEFAULT 0,
    bank            CITEXT NOT NULL,
    delivery_cost   INT    NOT NULL DEFAULT 0,
    goods_total     INT    NOT NULL DEFAULT 0
);

CREATE UNLOGGED TABLE IF NOT EXISTS orders (
    uid                 CITEXT UNIQUE NOT NULL PRIMARY KEY,
    entry               CITEXT NOT NULL,
    internal_signature  CITEXT NOT NULL UNIQUE,
    payment             CITEXT NOT NULL,
    locale              CITEXT NOT NULL,
    customer_id         CITEXT NOT NULL,
    track_number        CITEXT NOT NULL,
    delivery_service    CITEXT NOT NULL,
    shared_key          CITEXT NOT NULL,
    sm_id               INT    NOT NULL,
    FOREIGN KEY (payment) REFERENCES payments(transaction) ON DELETE CASCADE
);

CREATE UNLOGGED TABLE IF NOT EXISTS items (
    chrt_id         SERIAL    PRIMARY KEY ,
    price           INT    NOT NULL DEFAULT 0,
    rid             CITEXT NOT NULL,
    name            CITEXT NOT NULL,
    sale            INT    NOT NULL DEFAULT 0,
    size            CITEXT NOT NULL,
    total_price     INT    NOT NULL DEFAULT 0,
    nm_id           INT    NOT NULL DEFAULT 0,
    brand           CITEXT NOT NULL
);

CREATE UNLOGGED TABLE IF NOT EXISTS items_in_order (
    order_uid       CITEXT  NOT NULL,
    chrt_id         INT     NOT NULL,
    FOREIGN KEY (order_uid) REFERENCES orders(uid) ON DELETE CASCADE,
    FOREIGN KEY (chrt_id)   REFERENCES items(chrt_id) ON DELETE CASCADE
);



