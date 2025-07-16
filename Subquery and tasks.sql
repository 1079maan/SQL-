CREATE TABLE Sub_query_Payments (
    customer_id BIGINT PRIMARY KEY,
    amount BIGINT,
    mode VARCHAR(50),
    payment_date DATE
);

INSERT INTO Sub_query_Payments (customer_id, amount, mode, payment_date) VALUES (1, 60, 'Cash', '2020-09-24');
INSERT INTO Sub_query_Payments (customer_id, amount, mode, payment_date) VALUES (8, 110, 'Cash', '2021-01-26');
INSERT INTO Sub_query_Payments (customer_id, amount, mode, payment_date) VALUES (10, 70, 'mobile Payment', '2021-02-28');
INSERT INTO Sub_query_Payments (customer_id, amount, mode, payment_date) VALUES (11, 80, 'Cash', '2021-03-01');
INSERT INTO Sub_query_Payments (customer_id, amount, mode, payment_date) VALUES (2, 500, 'Credit Card', '2020-04-27');


-- 1.Find the details of customers, whose payment amount is more than the average of total amount paid by all customers.

SELECT * FROM Sub_query_Payments
WHERE amount > (SELECT AVG(amount) FROM Sub_query_Payments)

--
SELECT customer_id, amount, mode 
FROM Sub_query_Payments
WHERE customer_id IN (SELECT customer_id FROM customers)

SELECT customer_id,customer_name,city FROM customers AS c
where EXISTS (SELECT customer_id,amount FROM Sub_query_Payments AS p
              where c.customer_id = p.customer_id
			  AND amount > 100)

-- 2.Show customer names and cities who paid more than ₹100 using 'Cash'.

SELECT customer_id,customer_name, city FROM customers AS c
where EXISTS (SELECT * FROM Sub_query_Payments AS p
              where c.customer_id = p.customer_id AND
			  mode = 'Cash' AND amount > 100)


-- 3.List the customer(s) who made the maximum payment.
SELECT * FROM Sub_query_Payments
where amount = (SELECT MAX(amount) FROM Sub_query_Payments)

-- 4.Find all payments made using ‘Cash’ where the amount is greater than the minimum amount of any mode.
SELECT * FROM Sub_query_Payments
where amount > (SELECT MIN(amount) FROM Sub_query_Payments) AND mode = 'Cash'

-- 5.Show all customers who paid using a method that was also used by customer_id = 2.
SELECT * FROM Sub_query_Payments
WHERE mode IN (SELECT mode
               FROM Sub_query_Payments
               WHERE customer_id = 2)

-- 6.Display all payment records where the amount is not the highest.
SELECT * FROM Sub_query_Payments
WHERE amount < (SELECT MAX(amount) from Sub_query_Payments)


-- 7.Find all payments made on the latest payment date.
SELECT * FROM Sub_query_Payments
where payment_date = (SELECT MAX(payment_date) from Sub_query_Payments)

-- 8.Find all customers who made payments less than the average amount of ‘Cash’ payments.
SELECT * FROM Sub_query_Payments
WHERE amount < (SELECT AVG(amount) FROM Sub_query_Payments) AND mode = 'Cash'

-- 9.Show payment details where the payment mode was used by more than one customer.
SELECT * FROM Sub_query_Payments
where mode in (SELECT mode FROM Sub_query_Payments
               group by mode
               HAVING COUNT(DISTINCT customer_id) > 1)


-- 10.List customer IDs who made a payment amount equal to another customer's payment (self-matching).
-- using Self join
SELECT DISTINCT P1.customer_id FROM Sub_query_Payments AS P1
JOIN Sub_query_Payments AS P2
ON P1.amount = P2.amount
where P1.customer_id != P2.customer_id

-- using subquery
select amount from Sub_query_Payments
group by amount
having COUNT(DISTINCT customer_id) > 1

-- 11.Find customers who did not use 'Credit Card' or 'mobile Payment' as a mode.
select customer_id from Sub_query_Payments
where mode NOT IN ('mobile Payment','Credit Card')

-- Using subquery
SELECT customer_id FROM Sub_query_Payments
WHERE customer_id not in (select customer_id from Sub_query_Payments
                   where mode IN ('mobile Payment','Credit Card'))


