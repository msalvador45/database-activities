-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student(s): Miguel Salvador
-- Description: SQL for the In-N-Out Store

DROP DATABASE innout;

CREATE DATABASE innout;

\c innout

-- TODO: table create statements
CREATE TABLE Customers ( 
    id SERIAL PRIMARY KEY,
    name VARCHAR(40) NOT NULL,
    gender VARCHAR(1) DEFAULT '?'
);

CREATE TABLE Sales (
    customer_id SERIAL,
    item_code VARCHAR(5),
    date_sold DATE NOT NULL,
    time_sold TIME NOT NULL,
    number_of_items INTEGER NOT NULL,
    ammount_paid FLOAT NOT NULL,
    PRIMARY KEY (customer_id, item_code)
);

CREATE TABLE Items (
    code VARCHAR(10) PRIMARY KEY,
    description VARCHAR(300) NOT NULL,
    price FLOAT NOT NULL,
    category_code VARCHAR(3)
);

CREATE TABLE Categories (
    code VARCHAR(3) PRIMARY key,
    description VARCHAR(300) NOT NULL
);

-- TODO: table insert statements
INSERT INTO Customers (name, gender) VALUES
    ('Migui Tzoni', 'M'),
    ('Chalino Sanchez', 'M'),
    ('Selena Quintanilla', 'F'),
    ('Eduardo Vasquez', 'M');

INSERT INTO Customers (name) VALUES
    ('Kurt Kobain');

INSERT INTO Categories (code, description) VALUES
    ('BVR', 'beverages'),
    ('DRY', 'dairy'),
    ('PRD', 'produce'),
    ('FRZ', 'frozen'),
    ('BKY', 'bakery'),
    ('MEA', 'meat');

INSERT INTO Items (code, description, price, category_code) VALUES
    ('IN001','fanta', 10.43, 'BVR'),
    ('IN202','chicken', 40.56, 'MEA'),
    ('N457', 'cookies', 8.83, 'BKY'),
    ('IN870', 'pizza',4.99, 'FRZ'),
    ('IN232', 'milk', 20.12, 'DRY')

INSERT INTO ITEMS (code, description, price, category_code) VALUES
    ('IN835', 'eggs', 54.99, NULL);

INSERT INTO Sales (customer_id, item_code, date_sold, time_sold, number_of_items, ammount_paid) VALUES
    (1, 'IN202', '2023-01-18', '10:34', 3, 23.23),
    (4, 'IN232', '2023-03-14', '23:59', 1, 10.21),
    (1, 'IN870', '2023-02-14', '17:30', 1, 5.99);

-- TODO: SQL queries

-- a) all customer names in alphabetical order
SELECT (name) FROM Customers
ORDER BY 1;

-- b) number of items (labeled as total_items) in the database 
SELECT COUNT(*) AS total_items FROM Customers;

-- c) number of customers (labeled as number_customers) by gender
SELECT gender, COUNT(*) AS number_customers FROM Customers
GROUP BY gender ORDER BY gender;

-- d) a list of all item codes (labeled as code) and descriptions (labeled as description) followed by their category descriptions (labeled as category) in numerical order of their codes (items that do not have a category should not be displayed)
SELECT A.code, A.category_code AS description, B.description AS Category FROM Items A 
INNER JOIN Categories B 
ON A.category_code = B.code;

-- e) a list of all item codes (labeled as code) and descriptions (labeled as description) in numerical order of their codes for the items that do not have a category
SELECT code, category_code AS description FROM Items
WHERE category_code = NULL
ORDER BY code;

-- f) a list of the category descriptions (labeled as category) that do not have an item in alphabetical order
SELECT A.description AS category FROM Categories A 
INNER JOIN Items B 
ON A.code = B.category_code
WHERE B.category_code = NULL
ORDER BY 1;

-- g) set a variable named "ID" and assign a valid customer id to it; then show the content of the variable using a select statement
\set ID 1
SELECT :ID;

-- h) a list describing all items purchased by the customer identified by the variable "ID" (you must used the variable), showing, the date of the purchase (labeled as date), the time of the purchase (labeled as time and in hh:mm:ss format), the item's description (labeled as item), the quantity purchased (labeled as qtt), the item price (labeled as price), and the total amount paid (labeled as total_paid).
SELECT customer_id, date_sold AS date, time_sold AS time, description AS item, number_of_items AS qtt, price, ammount_paid AS total_paid FROM Sales A
INNER JOIN Customers B
ON A.customer_id = B.id 
INNER JOIN Items C 
ON A.Item_code = C.code
WHERE customer_id = :ID;

-- i) the total amount of sales per day showing the date and the total amount paid in chronological order
SELECT COUNT(*) AS total, CONCAT(date_sold,',', ammount_paid) AS date_sold_and_amt_paid FROM SALES
GROUP BY date_sold_and_amt_paid
ORDER BY date_sold_and_amt_paid;

-- j) the description of the top item (labeled as item) in sales with the total sales amount (labeled as total_paid)

-- k) the descriptions of the top 3 items (labeled as item) in number of times they were purchased, showing that quantity as well (labeled as total)

-- l) the name of the customers who never made a purchase 