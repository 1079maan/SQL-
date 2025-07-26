-- Create the table 
CREATE TABLE employee_reviews (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    department VARCHAR(50),
    joining_year INT,
    salary INT,
    performance_score INT,
    leave_days_taken INT,
    region VARCHAR(50)
);

-- Insert the data
INSERT INTO employee_reviews 
VALUES 
(101, 'Arjun Mehta', 'HR', 2018, 540000, 9, 5, 'North'),
(102, 'Priya Shah', 'IT', 2020, 800000, 8, 8, 'West'),
(103, 'Ravi Desai', 'Finance', 2017, 620000, 6, 15, 'East'),
(104, 'Komal Patel', 'IT', 2022, 520000, 5, 12, 'South'),
(105, 'Aman Singh', 'HR', 2019, 480000, 4, 10, 'North'),
(106, 'Meena Rathi', 'Marketing', 2021, 460000, 7, 6, 'West'),
(107, 'Rohit Verma', 'Finance', 2016, 730000, 3, 20, 'East'),
(108, 'Simran Kaur', 'IT', 2018, 670000, 9, 4, 'North'),
(109, 'Neha Joshi', 'HR', 2020, 550000, 6, 14, 'South'),
(110, 'Harsh Sharma', 'Marketing', 2023, 400000, 5, 9, 'East'),
(111, 'Deepak Jain', 'Finance', 2017, 610000, 8, 7, 'West'),
(112, 'Anjali Nair', 'IT', 2021, 720000, 10, 3, 'South'),
(113, 'Suresh Pawar', 'Marketing', 2019, 440000, 4, 17, 'North'),
(114, 'Tanvi Khanna', 'HR', 2022, 500000, 5, 11, 'West'),
(115, 'Rajat Bansal', 'Finance', 2016, 750000, 7, 6, 'East'),
(116, 'Kavita Kapoor', 'IT', 2020, 690000, 9, 4, 'South'),
(117, 'Tarun Yadav', 'Marketing', 2021, 460000, 6, 13, 'North'),
(118, 'Pooja Mishra', 'HR', 2018, 480000, 3, 18, 'East'),
(119, 'Vishal Rana', 'Finance', 2019, 700000, 8, 5, 'South'),
(120, 'Shruti Jain', 'IT', 2023, 560000, 5, 9, 'West'),
(121, 'Rohan Thakur', 'Marketing', 2017, 430000, 6, 10, 'North'),
(122, 'Ankit Rawal', 'HR', 2021, 510000, 7, 5, 'East'),
(123, 'Isha Agarwal', 'Finance', 2016, 740000, 4, 19, 'West'),
(124, 'Rahul Iyer', 'IT', 2019, 660000, 8, 7, 'North'),
(125, 'Sneha Kapoor', 'Marketing', 2020, 470000, 6, 6, 'South'),
(126, 'Kunal Malhotra', 'HR', 2018, 490000, 9, 4, 'West'),
(127, 'Aarti Joshi', 'Finance', 2021, 690000, 5, 13, 'East'),
(128, 'Varun Mehra', 'IT', 2017, 710000, 10, 3, 'North'),
(129, 'Divya Menon', 'Marketing', 2022, 420000, 4, 16, 'South'),
(130, 'Manav Sethi', 'HR', 2023, 520000, 7, 5, 'West');

SELECT * FROM employee_reviews

-- Case stetement

-- 1. Categorize Employees Based on Performance
SELECT employee_name, performance_score,
	CASE
	WHEN performance_score >= 9 THEN 'Excellent'
	WHEN performance_score >= 7 THEN 'Good'
	WHEN performance_score >= 5 THEN 'Average'
	ELSE 'Poor'
	END AS performance_category
FROM employee_reviews

-- 2. Check Leave Status
SELECT employee_name,leave_days_taken,
	CASE
	when leave_days_taken > 15 then 'Excessive Leave'
	when leave_days_taken BETWEEN 6 AND 15 then 'Moderate Leave'
	else 'Law Leave'
	end AS leave_state
FROM employee_reviews

-- 3. Calculate Bonus Eligibility Using CASE Expression
SELECT employee_name, department, salary, performance_score,salary*
	CASE
	when performance_score >= 9 then 0.20 --Bouns : 20% 
	when performance_score >= 7 then 0.10 --Bouns : 10% 
	when performance_score >= 5 then 0.05 --Bouns : 5%  
	else 0
	end AS bouns_amount
FROM employee_reviews 

-- 4. Region-Wise Performance Summary
select region, 
	COUNT(*) AS total_employee,
	SUM(case 
		when performance_score >= 8 then 1
		else 0
		end) AS top_performers
from employee_reviews
group by region

-- 5. Tag Employees Based on Year of Joining
SELECT employee_name, joining_year,
	case 
	when joining_year <=2017 then 'Veteran'
	when joining_year between 2018 and 2020 then 'Mid-Level'
	else 'new'
	end AS experience_level
FROM employee_reviews


-- Case Expression

-- 1. Simple CASE Expression (matches a specific value)
SELECT employee_name,department,
	case department
	when 'HR' then 'Human Resource'
	when 'IT' then 'Tecnical Team'
	when 'Finance' then 'Account'
	else 'Other Dept'
	end AS departmant_full_name
FROM employee_reviews


