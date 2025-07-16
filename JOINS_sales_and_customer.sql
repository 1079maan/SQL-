CREATE TABLE Customers
(customer_id int primary key,
customer_name varchar(50) not null,
city varchar(50)
)

CREATE TABLE Orders
(
order_id int primary key,
customer_id	int not null, 
order_date	date,
total_amount numeric
)

CREATE TABLE Payments
(
payment_id int primary key,
order_id int not null,
payment_mode char(30),
payment_status varchar(50)
)

INSERT INTO Customers
(customer_id, customer_name, city)
VALUES
(1,'Ravi','Mumbai'),
(2,'Neha','Delhi'),
(3,'Amit','Pune'),
(4,'Sneha','Surat')

INSERT INTO Orders
(order_id, customer_id, order_date, total_amount)
VALUES
(101, 1, '2024-12-01', 1500.00),
(102, 2, '2024-12-02', 2200.00),
(103, 1, '2025-01-10', 1800.00),
(104, 5, '2025-02-15', 2000.00)

INSERT INTO Payments
(payment_id, order_id, payment_mode, payment_status)
VALUES
(9001, 101, 'UPI', 'Completed'),
(9002, 102, 'Card', 'Failed'),
(9003, 104, 'Cash', 'Completed')

SELECT * FROM Customers

SELECT * FROM Orders 

SELECT * FROM Payments


-- Task 1: Show all orders with customer names using .
-- Only show orders where the customer exists in the customer table.
SELECT c.customer_name,
	   c.city,
	   o.order_id,
	   o.order_date,
	   o.total_amount
FROM Customers AS c
INNER JOIN Orders As o
ON c.customer_id = o.customer_id

-- Task 2: List all customers and their orders using .
-- Include customers who haven’t placed any orders.
SELECT c.customer_id, 
	   c.customer_name, 
	   c.city, 
	   o.order_id,
	   o.order_date,
	   o.total_amount
FROM Customers AS c
LEFT JOIN Orders As o
ON c.customer_id = o.customer_id

--  Task 3: List all orders and customer names using .
-- Include orders where the customer is not found in the customer table
SELECT c.customer_name, 
	   c.city, o.*
FROM Customers AS c
RIGHT JOIN Orders As o
ON c.customer_id = o.customer_id

-- Task 4: Show all customer and order information using .
-- Include customers without orders and orders without matching customers.
SELECT c.*,o.order_id,o.order_date,o.total_amount
FROM Customers AS c
FULL OUTER JOIN Orders As o
ON c.customer_id = o.customer_id

-- Task 5: Show order and payment details using .
-- Display order_id, total_amount, payment_mode, and payment_status.
SELECT o.order_id,o.total_amount, p.payment_mode, p.payment_status 
FROM Orders As o
LEFT JOIN Payments AS p
ON o.order_id = p.order_id

--  Task 6: Show customers who haven’t made any payments.
--  (Use a join between Customers → Orders → Payments, filter where payment is NULL.)
SELECT c.customer_id,
       c.customer_name,
       c.city,
       o.order_id,
       o.order_date,
       o.total_amount
FROM Customers AS c
INNER JOIN Orders As o
ON c.customer_id = o.customer_id
LEFT JOIN Payments AS p 
ON o.order_id = p.order_id
where p.payment_id IS NULL

--  Task 7: Show all successfully paid orders.
--  List order_id, customer_name, and payment_status = 'Completed'.
SELECT c.customer_name,
       o.order_id,
       p.payment_status
FROM Customers AS c
INNER JOIN Orders As o
ON c.customer_id = o.customer_id
INNER JOIN Payments AS p 
ON o.order_id = p.order_id
where p.payment_status = 'Completed'

-- Task 8: List all orders with customer name and payment status.
SELECT c.customer_name, o.order_id,o.total_amount, p.payment_status
FROM Customers AS c
RIGHT JOIN Orders AS o
ON c.customer_id = o.customer_id
LEFT JOIN Payments AS P
ON o.order_id = p.order_id

-- Task 9: Show all customers and their payments — even if they didn’t place any order or make a payment.
SELECT c.customer_id, c.customer_name, o.order_id, o.order_date, p.payment_id, p.payment_status
FROM Customers AS c
LEFT JOIN Orders AS o
ON c.customer_id = o.customer_id
LEFT JOIN Payments AS P
ON o.order_id = p.order_id

-- Task 10: Find orders that have no corresponding payment (i.e. payment is missing).
SELECT o.order_id,o.total_amount,p.payment_status
FROM Orders AS o
LEFT JOIN Payments AS P
ON o.order_id = p.order_id
where p.payment_status is NULL

-- Task 11: Show only orders with successful payments.
SELECT *
FROM Orders AS o
LEFT JOIN Payments AS p
ON o.order_id = p.order_id
where p.payment_status = 'Completed'

-- Task 12: Count how many orders each customer has placed, and the total amount they spent.
SELECT c.customer_id, c.customer_name, COALESCE(SUM(o.total_amount), 0) AS total_spent, COUNT(order_id) AS total_orders
FROM Customers  AS c
LEFT JOIN Orders AS o
ON c.customer_id = o.customer_id
group by c.customer_id
order by c.customer_id 


