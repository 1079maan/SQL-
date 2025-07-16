-- Create all 4 tables with proper data types and foreign keys

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    brand VARCHAR(50),
    price DECIMAL(10, 2),
    stock_level DECIMAL(5, 2),
    is_available BOOLEAN,
    expiry_date DATE
);

CREATE TABLE suppliers (
    supplier_id INT PRIMARY KEY,
    supplier_name VARCHAR(100),
    contact_person VARCHAR(100),
    phone_number VARCHAR(15),
    email VARCHAR(100),
    city VARCHAR(50)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    supplier_id INT,
    order_date DATE,
    quantity INT,
    total_amount DECIMAL(10, 2),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (supplier_id) REFERENCES suppliers(supplier_id)
);

CREATE TABLE stock_logs (
    log_id INT PRIMARY KEY,
    product_id INT,
    change_type VARCHAR(10),
    quantity_changed INT,
    log_date DATE,
    remarks TEXT,
    FOREIGN KEY (product_id) REFERENCES products(product_id)
);

-- Insert the data

INSERT INTO products 
(product_id, product_name, brand, price, stock_level, is_available, expiry_date) 
VALUES
(1, 'Milk 1L', 'Amul', 52.00, 80.00, TRUE, '2025-08-01'),
(2, 'Shampoo 200ml', 'Dove', 120.00, 45.00, TRUE, '2026-03-15'),
(3, 'Wheat Flour 5kg', 'Aashirvaad', 250.00, 60.00, TRUE, '2026-12-01'),
(4, 'Biscuits 100g', 'Parle-G', 10.00, 0.00, FALSE, '2024-11-10'),
(5, 'Cold Drink 1L', 'Pepsi', 70.00, 35.00, TRUE, '2026-07-20');

SELECT * FROM Products

INSERT INTO suppliers
(supplier_id, supplier_name, contact_person, phone_number, email, city) 
VALUES
(1, 'FreshDairy Ltd.', 'Anil Mehta', '9876543210', 'anil@freshdairy.com', 'Ahmedabad'),
(2, 'BeautyMart Pvt.', 'Kavita Shah', '9988776655', 'kavita@beautymart.in', 'Mumbai'),
(3, 'GrainCorp', 'Rajiv Verma', '9123456780', 'rajiv@graincorp.com', 'Delhi'),
(4, 'SnackBox Inc.', 'Pooja Patel', '9867543210', 'pooja@snackbox.co', 'Surat'),
(5, 'CoolDrinks LLP', 'Manish Rana', '9012345678', 'manish@cooldrinks.co.in', 'Pune');

SELECT * FROM suppliers


INSERT INTO orders 
(order_id, product_id, supplier_id, order_date, quantity, total_amount) 
VALUES
(101, 1, 1, '2025-07-01', 200, 10400.00),
(102, 2, 2, '2025-07-02', 150, 18000.00),
(103, 3, 3, '2025-07-03', 100, 25000.00),
(104, 4, 4, '2025-07-04', 0, 0.00),
(105, 5, 5, '2025-07-05', 90, 6300.00);

SELECT * FROM orders

INSERT INTO stock_logs
(log_id, product_id, change_type, quantity_changed, log_date, remarks)
VALUES
(1, 1, 'IN', 200, '2025-07-01', 'New stock from supplier'),
(2, 2, 'IN', 150, '2025-07-02', 'Monthly restock'),
(3, 3, 'IN', 100, '2025-07-03', 'Bulk order'),
(4, 4, 'OUT', 100, '2025-07-04', 'Expired stock removed'),
(5, 5, 'IN', 90, '2025-07-05', 'Seasonal demand');

SELECT * FROM stock_logs

-- INSERT a new product and order

INSERT INTO products 
(product_id, product_name, brand, price, stock_level, is_available, expiry_date) 
VALUES
(6, 'Milk 1L', 'Amul', 52.00, 80.00, TRUE, '2025-08-01');


INSERT INTO orders 
(order_id, product_id, supplier_id, order_date, quantity, total_amount) 
VALUES
(106, 1, 1, '2025-07-01', 200, 10400.00);

-- UPDATE price of a product and stock level

UPDATE Products
SET price = 90,stock_level=95
where product_id in (1,3)

SELECT * FROM Products
ORDER BY product_id

-- DELETE a product that is out of stock and expired

DELETE FROM orders
where product_id IN(
select product_id from Products
where expiry_date < '2025-07-09'
)

DELETE FROM stock_logs
where product_id IN(
select product_id from Products
where expiry_date < '2025-07-09'
)

DELETE FROM Products
where expiry_date < '2025-07-09'

-- ALTER products table to add category

ALTER TABLE Products
ADD COLUMN category varchar(50)

UPDATE Products
SET category = 'ABC'

ALTER TABLE Products
DROP COLUMN category

-- TRUNCATE stock_logs table before audit
TRUNCATE stock_logs

-- DROP a test table like stock_logs
DROP TABLE stock_logs