-- Create the employee_sales table
CREATE TABLE employee_sales (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    region VARCHAR(50),
    joining_date DATE,
    sales_month DATE,
    sales_amount DECIMAL(10, 2)
);


-- Insert data into employee_sales
INSERT INTO employee_sales 
(emp_id, emp_name, department, region, joining_date, sales_month, sales_amount) 
VALUES
(1, 'Alice', 'Electronics', 'North', '2022-01-10', '2023-01-01', 50000),
(1, 'Alice', 'Electronics', 'North', '2022-01-10', '2023-02-01', 52000),
(1, 'Alice', 'Electronics', 'North', '2022-01-10', '2023-03-01', 53000),
(2, 'Bob', 'Electronics', 'South', '2021-03-15', '2023-01-01', 60000),
(2, 'Bob', 'Electronics', 'South', '2021-03-15', '2023-02-01', 55000),
(2, 'Bob', 'Electronics', 'South', '2021-03-15', '2023-03-01', 58000),
(3, 'Charlie', 'Home Appliances', 'North', '2021-06-20', '2023-01-01', 40000),
(3, 'Charlie', 'Home Appliances', 'North', '2021-06-20', '2023-02-01', 45000),
(3, 'Charlie', 'Home Appliances', 'North', '2021-06-20', '2023-03-01', 42000),
(4, 'David', 'Home Appliances', 'West', '2020-05-30', '2023-01-01', 70000),
(4, 'David', 'Home Appliances', 'West', '2020-05-30', '2023-02-01', 68000),
(4, 'David', 'Home Appliances', 'West', '2020-05-30', '2023-03-01', 72000),
(5, 'Eva', 'Furniture', 'East', '2022-08-25', '2023-01-01', 30000),
(5, 'Eva', 'Furniture', 'East', '2022-08-25', '2023-02-01', 35000),
(5, 'Eva', 'Furniture', 'East', '2022-08-25', '2023-03-01', 37000),
(6, 'Farhan', 'Furniture', 'West', '2021-11-12', '2023-01-01', 32000),
(6, 'Farhan', 'Furniture', 'West', '2021-11-12', '2023-02-01', 33000),
(6, 'Farhan', 'Furniture', 'West', '2021-11-12', '2023-03-01', 34000),
(7, 'Grace', 'Electronics', 'East', '2020-10-18', '2023-01-01', 45000),
(7, 'Grace', 'Electronics', 'East', '2020-10-18', '2023-02-01', 47000),
(7, 'Grace', 'Electronics', 'East', '2020-10-18', '2023-03-01', 49000);


SELECT * FROM employee_sales

-- 1.Show each employee's sales difference compared to the previous month.
SELECT emp_id,emp_name, sales_amount,sales_month,
	LAG(sales_amount) OVER(PARTITION BY emp_id ORDER BY sales_month) previous_month_sales,
	sales_amount - LAG(sales_amount) OVER(PARTITION BY emp_id ORDER BY sales_month) sales_difference
FROM employee_sales
ORDER BY emp_id,emp_name

-- 2.Rank employees within each department for each sales month based on their sales.
SELECT emp_id,emp_name, department, sales_month,sales_amount,
	RANK() OVER(PARTITION BY department,sales_month ORDER BY sales_amount DESC) dept_month_rank
FROM employee_sales
ORDER BY department, sales_month, dept_month_rank

-- 3.Get the top 2 performers by sales in every region for each month.
SELECT * FROM (
	SELECT emp_id,emp_name,region,sales_month, sales_amount,
		RANK() OVER(PARTITION BY region, sales_month ORDER BY sales_amount DESC) AS region_rank
	FROM employee_sales
) AS ranked
where region_rank <=2
ORDER BY region, sales_month, region_rank 

-- 4.Assign each employee to a performance quartile (1 to 4) based on their sales for February 2023.
SELECT emp_id,emp_name,sales_amount, sales_month,
	NTILE(4) OVER(ORDER BY sales_amount DESC) AS performance_quartile
FROM employee_sales 
where sales_month = '2023-02-01'
ORDER BY performance_quartile, sales_amount DESC

-- 5.Calculate the 3-month moving average of sales for each employee.
SELECT emp_name, sales_month, sales_amount,
	ROUND(AVG(sales_amount) OVER(PARTITION BY emp_name ORDER BY sales_month 
		ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2
		)AS moving_avg_3_months
FROM employee_sales
ORDER BY emp_id,sales_month

-- 6.Find the cumulative total sales for each employee over time.
SELECT emp_id,emp_name,sales_amount,
	SUM(sales_amount) OVER(PARTITION BY emp_id ORDER BY sales_month) AS cumulative_total
FROM employee_sales

-- 7.Compare each employee’s monthly sales to the average sales of their department for that month.
SELECT emp_id,emp_name,department,sales_month,sales_amount,
	AVG(sales_amount) OVER(PARTITION BY department,sales_month) AS daprtment_avg_sales,
	sales_amount - AVG(sales_amount) OVER(PARTITION BY department,sales_month) AS comare_emp_month
FROM employee_sales

-- 8.Calculate the percent rank of each employee’s sales within their region for January 2023.
SELECT emp_id,emp_name,region,sales_month,sales_amount,
	PERCENT_RANK() OVER(PARTITION BY region ORDER BY sales_amount)
FROM employee_sales
where sales_month = '2023-01-01'

-- 9.Identify employees whose sales improved continuously month over month.
SELECT emp_id, emp_name, sales_month, sales_amount,
	LAG(sales_amount, 1) OVER(PARTITION BY emp_id ORDER BY sales_month) AS prev_month_sales,
	sales_amount > LAG(sales_amount, 1) OVER(PARTITION BY emp_id ORDER BY sales_month) 
FROM employee_sales

-- 10.Show the highest sales amount in the last two months for each employee using ROWS BETWEEN.
SELECT emp_id,emp_name,sales_month,sales_amount,
	MAX(sales_amount) OVER (PARTITION BY emp_id ORDER BY sales_month
	ROWS BETWEEN 1 PRECEDING AND CURRENT ROW) highest_last_2_months
FROM employee_sales
where sales_month BETWEEN '2023-02-01' AND '2023-03-01'
ORDER BY emp_id, sales_month

-- 11.Use LEAD() to find each employee’s next month's sales amount.
SELECT emp_id,emp_name,sales_month,sales_amount,
	LEAD(sales_amount) OVER(PARTITION BY emp_id ORDER BY sales_month)
FROM employee_sales

-- 12.For each department, find the employee who had the largest increase in sales between two months.
with sales_diff AS(
	SELECT emp_id,emp_name,department, sales_month,sales_amount,
	LAG(sales_amount) OVER(PARTITION BY emp_id ORDER BY sales_month) AS prev_sales
FROM employee_sales
),

diff_calc as (
SELECT emp_id,emp_name,department, sales_month,sales_amount,prev_sales,
	(sales_amount - prev_sales) AS sales_diff
FROM sales_diff
WHERE prev_sales IS NOT NULL
),

max_increase_per_emp AS (
SELECT emp_id,emp_name,department,
	MAX(sales_diff) AS max_increase
FROM diff_calc
GROUP BY emp_id, emp_name, department
),

ranks_emps AS (
SELECT *, 
	ROW_NUMBER() OVER(PARTITION BY department ORDER BY max_increase DESC) AS rn
FROM max_increase_per_emp
)
SELECT emp_id,emp_name,department,max_increase FROM ranks_emps
WHERE rn = 1

-- 13.Calculate the cumulative distribution of employee sales for each department.
SELECT emp_id,emp_name,department, sales_month,sales_amount,
	CUME_DIST() OVER (PARTITION BY department ORDER BY sales_amount) AS cumulative_distribution
FROM employee_sales

-- 14.Find the difference between each employee’s sales and the max sales in their department (per month).
SELECT emp_id,emp_name,department, sales_month,sales_amount,
	MAX(sales_amount) OVER(PARTITION BY department, sales_month) AS max_dep_sale,
	MAX(sales_amount) OVER(PARTITION BY department, sales_month) - sales_amount AS diff_from_max
FROM employee_sales
ORDER BY department, sales_month, emp_name

-- 15.Flag employees who had a drop in sales compared to the previous month using LAG().
SELECT emp_id,emp_name, department, sales_month, sales_amount,
	LAG(sales_amount) OVER(PARTITION BY emp_id ORDER BY sales_month) AS prev_month_sales,
	CASE 
        WHEN sales_amount < LAG(sales_amount) OVER (PARTITION BY emp_id ORDER BY sales_month)   
		THEN '↓ Dropped'
        ELSE '✓ No Drop'
    END AS sales_trend
FROM employee_sales
ORDER BY emp_id, sales_month