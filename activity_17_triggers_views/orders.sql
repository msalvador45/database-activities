CREATE DATABASE orders;

\c orders

CREATE TABLE Products(
    id SERIAL PRIMARY KEY,
    descr VARCHAR(25) NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    CHECK (price >= 0)
);

INSERT INTO Products (descr, price) VALUES
    ('Ninja Sword', 250.00),
    ('Dummy', 50.00), 
    ('Fake Blood', 5.00),
    ('Rubber Ducky', 1.00),
    ('Bathtub Soap', 3.00),
    ('Brazilian Coffe', 5.00),
    ('Running Shoes', 50.00);

INSERT INTO(
    
)

CREATE TABLE Items (
    order_number INT NOT NULL,
    product_id INT NOT NULL,
    qtt INT NOT NULL,
    PRIMARY KEY (order_number, product_id)
    FOREIGN KEY (order_number,) REFERENCES Orders(number),
    FOREIGN KEY (product_id) REFERENCES Products(id)
);

-- postgres does not care about indentation
-- fore readability
CREATE FUNCTION check_qtt_before_insert() RETURNS TRIGGER
    LANGUAGE plpsql
    AS $$
        BEGIN
            IF NEW.qtt <=0 THEN
                NEW.qtt =1;
            END IF;
            RETURN NEW;
        END;
    $$;
CREATE TRIGGER items_qtt_at_least_1
    BEFORE INSERT ON Items
    FOR EACH ROW 
    EXECUTE PROCEDURE check_qtt_before_insert();

CREATE VIEW OrdersTotalByMonth AS
   SELECT FROM 

CREATE VIEW OrdersTotalByYear AS