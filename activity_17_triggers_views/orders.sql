CREATE DATABASE orders;

\c orders

CREATE TABLE Products(
    id SERIAL PRIMARY KEY,
    descr VARCHAR(25) NOT NULL,
    price DECIMAL(10, 21) NOT NULL,
    CHECK (price >= 0)
);

INSERT INTO Products (descr, price) VALUES
    ('Ninja Sword', 250.00),
    ('Dummy', 50.00), 
    ('Fake Blood', 5.00);