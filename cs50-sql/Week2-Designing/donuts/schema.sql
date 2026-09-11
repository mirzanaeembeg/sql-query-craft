CREATE TABLE ingredients (
    id INTEGER NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    per_unit_price INTEGER NOT NULL
);

CREATE TABLE donuts (
    id INTEGER NOT NULL PRIMARY KEY,
    name TEXT NOT NULL,
    gluten_free TEXT NOT NULL CHECK(gluten_free IN ('YESS', 'NO')),
    price_per_donut INTEGER NOT NULL,
    ingredients_id INTEGER NOT NULL,
    FOREIGN KEY("ingredients_id") REFERENCES ingredients("id")
);

CREATE TABLE customers (
    id INTEGER NOT NULL PRIMARY KEY,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    order_history TEXT
);

CREATE TABLE orders (
    order_no INTEGER NOT NULL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
    customer_first_name TEXT NOT NULL,
    customer_last_name TEXT NOT NULL,
    number_of_donuts INTEGER NOT NULL,
    FOREIGN KEY("customer_id", "customer_first_name", "customer_last_name") REFERENCES customers("id", "first_name", "last_name")
);

