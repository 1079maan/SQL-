CREATE TABLE cust
(
customer_id	int primary key,
first_name varchar(50) not null, 
last_name varchar(50) not null,
email varchar(100),
address_id int8
)

copy cust(customer_id, first_name, last_name, email, address_id)
FROM 'I:\SQL\SQL Pgadmin\customer.csv'
DELIMITER ','
CSV HEADER;

SELECT * FROM cust

SELECT UPPER(first_name) FROM cust

SELECT LOWER(first_name) FROM cust

SELECT LENGTH(first_name), first_name FROM cust

SELECT CONCAT(first_name, last_name), first_name,last_name FROM cust

SELECT SUBSTRING(first_name, 1, 3),first_name FROM cust

SELECT LENGTH(first_name), first_name FROM cust

SELECT NOW()

SELECT REPLACE(first_name,'Mary','Maan'),first_name,last_name from cust

SELECT length(trim('  Maan'))