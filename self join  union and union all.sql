-- SELF JOIN
CREATE TABLE emp
(empid int primary key,
empname varchar(50) not null,
manager_id numeric
)

INSERT INTO emp
(empid, empname, manager_id)
VALUES
(1, 'Maan', 3),
(2, 'Radhey', 1),
(3, 'Harsh', 4),
(4, 'Rishi',1);

SELECT E1.empname AS emp_name, E2.empname AS Manager_name 
FROM emp AS E1
JOIN emp AS E2
ON E2.empid = E1.manager_id

-- UNION and UNION ALL
Create table custA
(
cust_name varchar(50) not null,
cust_amount numeric
)

Create table custB
(
cust_name varchar(50) not null,
cust_amount numeric
)

INSERT INTO custA
(cust_name, cust_amount)
VALUES
('maan patel', 2100),
('rishi ladani', 1200),
('radhey makadia', 2400)

INSERT INTO custB
(cust_name, cust_amount)
VALUES
('Harsh Bhalodia', 7500),
('rishi ladani', 1200)

SELECT cust_name, cust_amount FROM custA
UNION 
SELECT cust_name, cust_amount FROM custB

SELECT cust_name, cust_amount FROM custA
UNION ALL
SELECT cust_name, cust_amount FROM custB
