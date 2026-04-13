CREATE DATABASE ecommerce_db;

USE ecommerce_db;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    city VARCHAR(50)
);

SHOW TABLES;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

SHOW TABLES;

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2)
);

SHOW TABLES;

CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

SHOW TABLES;

INSERT INTO customers VALUES
(1, 'Riya', 'riya@email.com', 'Bangalore'),
(2, 'Amit', 'amit@email.com', 'Delhi'),
(3, 'Neha', 'neha@email.com', 'Mumbai');

INSERT INTO products VALUES
(1, 'Laptop', 'Electronics', 60000),
(2, 'Phone', 'Electronics', 20000),
(3, 'Shoes', 'Fashion', 3000);

INSERT INTO orders VALUES
(1, 1, '2024-01-10'),
(2, 2, '2024-02-15');

INSERT INTO order_details VALUES
(1, 1, 1, 1),
(2, 1, 3, 2),
(3, 2, 2, 1);

SELECT * FROM customers;

SELECT * FROM products WHERE price > 10000;

SELECT * FROM products ORDER BY price DESC;

SELECT o.order_id, c.name, o.order_date
FROM orders o
INNER JOIN customers c ON o.customer_id = c.customer_id;

SELECT o.order_id, c.name, p.product_name, od.quantity
FROM order_details od
JOIN orders o ON od.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
JOIN products p ON od.product_id = p.product_id;

SELECT p.product_name, SUM(od.quantity * p.price) AS total_sales
FROM order_details od
JOIN products p ON od.product_id = p.product_id
GROUP BY p.product_name;

SELECT AVG(price) AS avg_price FROM products;

SELECT name
FROM customers
WHERE customer_id IN (SELECT customer_id FROM orders);

SELECT product_name
FROM products
WHERE price = (SELECT MAX(price) FROM products);

CREATE VIEW sales_summary AS
SELECT c.name, SUM(od.quantity * p.price) AS total_spent
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_details od ON o.order_id = od.order_id
JOIN products p ON od.product_id = p.product_id
GROUP BY c.name;

SELECT * FROM sales_summary;

CREATE INDEX idx_customer_id ON orders(customer_id);

CREATE INDEX idx_product_id ON order_details(product_id);