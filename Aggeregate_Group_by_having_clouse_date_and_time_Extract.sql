CREATE TABLE transactions(
Cust_id int primary key,
amount decimal not null,
mode varchar(50)
)

INSERT INTO  transactions
(Cust_id,amount,mode)
VALUES
(101,500.00,'Cash'),
(102,1200.50,'UPI'),
(103,300.00	,'Credit'),
(104,450.75	,'Debit'),
(105,980.00	,'UPI'),
(106,1500.00,'Cash'),
(107,700.25,'Credit'),
(108,100.00,'UPI'),
(109,875.00,'Debit'),
(110,650.50,'NetBanking');

-- Aggregate funcrion

SELECT ROUND(AVG(amount),2) FROM transactions

SELECT COUNT(amount) FROM transactions

SELECT MAX(amount) FROM transactions

SELECT MIN(amount) FROM transactions

SELECT SUM(amount) FROM transactions

SELECT AVG(amount) FROM transactions

-- group by and having clause  

SELECT mode, round(avg(amount),2) as total FROM transactions
group by mode
having round(avg(amount),2)  > 500
order by total

SELECT * FROM transactions

SHOW TIMEZONE
SELECT NOW()
SELECT TIMEOFDAY()
SELECT CURRENT_DATE
SELECT CURRENT_TIME
	
ALTER TABLE transactions
ADD COLUMN date date

Update transactions
set date = '2025-07-12'

SELECT EXTRACT(MONTH FROM date),date FROM transactions