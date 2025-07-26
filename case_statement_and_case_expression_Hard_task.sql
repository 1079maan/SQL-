CREATE TABLE employee_performance (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    position VARCHAR(30),
    experience_years DECIMAL(3,1),
    rating DECIMAL(2,1),
    salary DECIMAL(10,2),
    bonus DECIMAL(10,2),
    project_count INT,
    location VARCHAR(30)
);

INSERT INTO employee_performance VALUES
(101, 'Priya Patel', 'HR', 'Executive', 2.0, 3.2, 35000.00, 2000.00, 1, 'Ahmedabad'),
(102, 'Rakesh Shah', 'IT', 'Manager', 7.0, 4.5, 85000.00, 15000.00, 5, 'Pune'),
(103, 'Meena Joshi', 'Sales', 'Lead', 5.0, 4.0, 60000.00, 8000.00, 4, 'Mumbai'),
(104, 'Ankit Desai', 'IT', 'Developer', 3.0, 3.7, 48000.00, 4000.00, 2, 'Pune'),
(105, 'Ritu Sharma', 'Marketing', 'Analyst', 1.0, 2.9, 30000.00, 1000.00, 1, 'Delhi'),
(106, 'Jay Soni', 'Sales', 'Executive', 4.0, 4.8, 52000.00, 9000.00, 3, 'Mumbai'),
(107, 'Komal Rathi', 'HR', 'Manager', 6.0, 4.4, 78000.00, 12000.00, 3, 'Ahmedabad'),
(108, 'Aman Mehta', 'IT', 'Developer', 2.0, 3.5, 46000.00, 3000.00, 2, 'Pune'),
(109, 'Nisha Bhatia', 'Marketing', 'Lead', 5.0, 4.1, 62000.00, 8500.00, 4, 'Delhi'),
(110, 'Ravi Kumar', 'Sales', 'Manager', 8.0, 4.9, 90000.00, 16000.00, 6, 'Mumbai'),
(111, 'Shweta Tiwari', 'IT', 'Intern', 0.5, 3.0, 18000.00, 500.00, 0, 'Pune'),
(112, 'Dhruv Nair', 'Finance', 'Executive', 3.0, 3.9, 45000.00, 3000.00, 1, 'Chennai'),
(113, 'Neha Gupta', 'Finance', 'Analyst', 4.0, 4.3, 56000.00, 7000.00, 3, 'Chennai'),
(114, 'Harsh Trivedi', 'IT', 'Developer', 6.0, 4.7, 75000.00, 14000.00, 5, 'Pune'),
(115, 'Swati Desai', 'HR', 'Executive', 2.0, 3.1, 36000.00, 2500.00, 1, 'Ahmedabad'),
(116, 'Vivek Verma', 'Sales', 'Intern', 1.0, 2.8, 20000.00, 1000.00, 0, 'Mumbai'),
(117, 'Kiran Thakkar', 'Marketing', 'Manager', 6.0, 4.6, 80000.00, 13000.00, 5, 'Delhi');


SELECT rating, experience_years FROM employee_performance
GROUP BY rating,experience_years
order by rating

-- 1.Create a column that labels employees as "High Performer", "Average Performer", or "Low Performer" based on their rating and experience_years.
SELECT emp_name, experience_years,rating,
	CASE 
	WHEN experience_years >=6 AND rating >=4.5 THEN 'High Performer'
	WHEN experience_years >=4 AND rating >=3.0 THEN 'Average Performer'
	ELSE 'Low Performer'
	END as Performer_leval
FROM employee_performance

-- 2.Assign bonus tiers like "Gold", "Silver", "Bronze", or "No Bonus" based on the combination of bonus amount and project_count.
SELECT emp_name, bonus, project_count,
	CASE 
	WHEN bonus >= 12000 AND project_count >= 5 THEN 'Gold'
	WHEN bonus >= 8000 AND project_count >= 3 THEN 'Silver'
	WHEN bonus >= 3000 AND project_count >= 1	 THEN 'Bronze'
	ELSE 'No Bonus'
	END AS bonus_tiers
FROM employee_performance 


-- 3.Create a custom salary hike percentage based on the following: Department = 'IT' and experience > 5 → 20% hike, Department = 'Sales' and rating > 4.5 → 25% hike, Department = 'Marketing' and project_count >= 4 → 15% hike, Otherwise, 10% hike
SELECT emp_id,emp_name, department,salary,experience_years, rating, project_count,salary*
	CASE 
	WHEN department = 'IT' AND experience_years > 5 THEN 0.02
	WHEN department = 'Sales' AND rating > 4.5 THEN 0.25
	WHEN department = 'Marketing' AND project_count > 4 THEN 0.15
	ELSE 0.01
	END AS custom_salary_hike_percentage
FROM employee_performance

-- 4.Categorize employees based on multiple fields: If experience < 1 and position = 'Intern' → "Trainee", If rating >= 4.5 and bonus >= 12000 → "Star Employee", If salary < 30000 and rating < 3 → "Under Review",Else → "Regular"
SELECT emp_name, position, experience_years, salary, rating, bonus,
	CASE 
	WHEN experience_years < 1 AND position = 'intern' THEN 'Trainee'
	WHEN rating >= 4.5 AND bonus >= 1200 THEN 'Star Employee'
	WHEN salary < 30000 AND rating < 3 THEN 'Under Review'
	ELSE 'Regular'
	END AS fields
from employee_performance

-- 5.Create a custom column for promotion_eligibility : "Eligible Now" if experience > 5 and rating > 4.3, "Eligible Next Year" if experience between 3-5 and rating > 4.0, "Not Eligible" otherwise
select emp_id,emp_name, experience_years, rating,
	CASE 
	WHEN experience_years > 5 AND rating > 4.3 THEN 'Eligible Now'
	WHEN experience_years between 3 and 5 AND rating > 4.0 THEN 'Eligible Next Year'
	else 'Not eligible'
	END AS promotion_eligibility
from employee_performance

-- 6.Create a location_zone: "West" for Ahmedabad and Mumbai, "North" for Delhi, "South" for Chennai, "Central" for Pune
SELECT emp_id,emp_name, location,
	CASE location
	WHEN 'Delhi' THEN 'North'
	WHEN 'Chennai' THEN 'South'
	WHEN 'Pune' THEN 'Chennai'
	else 'west'
	END AS region
FROM employee_performance

-- 7.Assign performance bonuses based on a mix of: Department, Rating, Project count, Experience(You must decide the logic using nested CASE)
SELECT emp_name, department, rating, experience_years, project_count,
	CASE 
		When department = 'IT' THEN 
			CASE 
				WHEN rating >= 4.5 AND experience_years >= 5 THEN 15000
				WHEN rating >= 4.0 AND experience_years >= 3 THEN 10000
				ELSE 5000
			END 
		WHEN department = 'Sales' THEN 
			CASE 
				WHEN rating >= 4.8 AND project_count >= 5 THEN 16000
				WHEN experience_years >= 4 AND rating >= 4.2 THEN 12000
				ELSE 6000
			END
		WHEN department = 'Marketing' THEN
			CASE 
				WHEN project_count >=4 AND rating >=4.5 THEN 13000
				WHEN experience_years  >= 2 AND rating >=4.0 THEN 9000
				ELSE 4000
			END 
		WHEN department IN ('HR', 'Finance') THEN 
			CASE 
				WHEN experience_years >= 5 AND rating >= 4.2 THEN 11000
				ELSE 5000
			END
		ELSE 3000
	END AS performance_bonus
FROM employee_performance