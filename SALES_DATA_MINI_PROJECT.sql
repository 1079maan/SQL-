CREATE TABLE sales_data 
(Order_ID int primary key,
Customer_Name varchar(50) not null,
Product_Category varchar(50),
Product_Name varchar(50) not null,
Quantity numeric,
Price numeric,
Order_Date date,
Region varchar(30)
)

INSERT INTO sales_data
(Order_ID, Customer_Name, Product_Category, Product_Name, Quantity, Price, Order_Date, Region)
VALUES
(101, 'Rajesh Kumar','Beverages','Coke 500ml',2,40.00,'2024-12-20','North'),
(102,'Neha Sharma','Snacks','Lays 50g',5,20.00	,'2025-01-02'	,'West'),
(103,'Amit Patel','Dairy','Amul Milk 1L',3,30.00	,'2025-01-03'	,'West'),
(104,'Priya Mehta','Beverages','Pepsi 1L',1,45.00	,'2025-02-01'	,'East'),
(105,'Sunil Joshi','Snacks','Bingo 90g',4,25.00	,'2025-02-05'	,'South'),
(106,'Anjali Singh','Dairy','Cheese 200g',2,80.00	,'2025-02-15'	,'North'),
(107,'Karan Verma','Snacks','Kurkure 100g',6,15.00	,'2025-03-01','West');

SELECT * FROM sales_data

-- Extract only the first name and last name of customer from Customer_Name.
SELECT Customer_Name, SPLIT_PART(Customer_Name,' ',1) AS First_name, SPLIT_PART(Customer_Name,' ',2) AS last_name FROM sales_data


-- Calculate total sales (Quantity * Price) across all records.
SELECT SUM(Quantity * price) AS total FROM sales_data


-- Show total sales per Product_Category, but only for categories with sales above ₹200.
SELECT Product_Category, SUM(Quantity * price) AS total FROM sales_data
GROUP BY Product_Category
Having SUM(Quantity * price) > 200

-- Extract month from Order_Date and calculate total sales per month.
SELECT EXTRACT(MONTH FROM order_date) AS Months, SUM(Quantity * price) FROM sales_data
GROUP BY EXTRACT(MONTH FROM order_date)
ORDER BY Months


-- Find the Region with the highest total sales.
SELECT SUM(Quantity * price) AS Total,Region from sales_data
group by Region
order by Total DESC
LIMIT 1

