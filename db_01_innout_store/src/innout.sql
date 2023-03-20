-- CS3810: Principles of Database Systems
-- Instructor: Thyago Mota
-- Student(s): 
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
    ('IN384','carrots', 3.99, 'PRD'),
    ('IN457', 'cookies', 8.83, 'BKY'),
    ('IN870', 'pizza',4.99, 'FRZ'),
    ('IN232', 'milk', 20.12, 'DRY');

INSERT INTO Sales (customer_id, item_code, date_sold, time_sold, number_of_items, ammount_paid) VALUES
    (1, 'IN202', '2023-01-18', '10:34', 3, 23.23),
    (4, 'IN232', '2023-03-14', '23:59', 1, 10.21),
    (1, 'IN870', '2023-02-14', '17:30', 1, 5.99);

-- TODO: SQL queries

-- a) all customer names in alphabetical order
SELECT (name) FROM Customers
ORDER BY 1;

-- b) number of items (labeled as total_items) in the database 

-- c) number of customers (labeled as number_customers) by gender

-- d) a list of all item codes (labeled as code) and descriptions (labeled as description) followed by their category descriptions (labeled as category) in numerical order of their codes (items that do not have a category should not be displayed)

-- e) a list of all item codes (labeled as code) and descriptions (labeled as description) in numerical order of their codes for the items that do not have a category

-- f) a list of the category descriptions (labeled as category) that do not have an item in alphabetical order

-- g) set a variable named "ID" and assign a valid customer id to it; then show the content of the variable using a select statement

-- h) a list describing all items purchased by the customer identified by the variable "ID" (you must used the variable), showing, the date of the purchase (labeled as date), the time of the purchase (labeled as time and in hh:mm:ss format), the item's description (labeled as item), the quantity purchased (labeled as qtt), the item price (labeled as price), and the total amount paid (labeled as total_paid).

-- i) the total amount of sales per day showing the date and the total amount paid in chronological order

-- j) the description of the top item (labeled as item) in sales with the total sales amount (labeled as total_paid)

-- k) the descriptions of the top 3 items (labeled as item) in number of times they were purchased, showing that quantity as well (labeled as total)

-- l) the name of the customers who never made a purchase 