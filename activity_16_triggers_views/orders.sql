CREATE DATABASE orders;

\c orders

CREATE TABLE Products(
    id SERIAL PRIMARY KEY,
    descr VARCHAR(25) NOT NULL,
    price DECIMAL(10, 21) NOT NULL,
    CHECK (price >= 0)
);