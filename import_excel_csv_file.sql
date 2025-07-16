CREATE TABLE coustmer
(
customer_id	int primary key,
first_name varchar(50) not null, 
last_name varchar(50) not null,
email varchar(100),
address_id int8
)


select * from coustmer

copy coustmer(customer_id,first_name,last_name,email,address_id)
FROM 'I:\SQL\SQL Pgadmin\customer.csv'
DELIMITER ','
CSV HEADER;

