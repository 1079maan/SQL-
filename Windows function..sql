CREATE TABLE win (
new_id INT,
new_cat VARCHAR(50)
)

INSERT INTO win (new_id, new_cat) VALUES (100, 'Agni');
INSERT INTO win (new_id, new_cat) VALUES (200, 'Agni');
INSERT INTO win (new_id, new_cat) VALUES (500, 'Dharti');
INSERT INTO win (new_id, new_cat) VALUES (700, 'Dharti');
INSERT INTO win (new_id, new_cat) VALUES (200, 'Vayu');
INSERT INTO win (new_id, new_cat) VALUES (300, 'Vayu');
INSERT INTO win (new_id, new_cat) VALUES (500, 'Vayu');


SELECT * FROM win

-- Windows Function Useing Aggregate Function
SELECT new_id, new_cat, 
    SUM(new_id) OVER (PARTITION BY new_cat) AS Total,
    AVG(new_id) OVER (PARTITION BY new_cat) AS Average,
    COUNT(new_id) OVER (PARTITION BY new_cat) AS Counts,
    MIN(new_id) OVER (PARTITION BY new_cat) AS Minmum,
    MAX(new_id) OVER (PARTITION BY new_cat) AS Maxmum
FROM win
ORDER BY new_id

-- Windows Function Useing Aggregate Function
SELECT new_id, new_cat, 
    SUM(new_id) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Total,
    AVG(new_id) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Average,
    COUNT(new_id) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Counts,
    MIN(new_id) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Minmum,
    MAX(new_id) OVER (ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS Maxmum
FROM win
ORDER BY new_id

-- Windows Function Useing Rank Function 
SELECT new_id,
	ROW_NUMBER() OVER(ORDER BY new_id) AS Row_numbers,
	RANK() OVER(ORDER BY new_id) AS Ranks,
	DENSE_RANK() OVER(ORDER BY new_id) AS Dense_ranks,
	PERCENT_RANK() OVER(ORDER BY new_id) AS percent_ranks
FROM win

-- Windows Function Useing Analytic Function
SELECT new_id,
	FIRST_VALUE(new_id) OVER(order by new_id) AS First_values,
	LAST_VALUE(new_id) OVER(order by new_id) AS Last_Values,
	LEAD(new_id) OVER(order by new_id ) AS Leads,
	LAG(new_id) OVER(order by new_id ) AS Lags
FROM win



-- 1.For each new_cat, show the total sum of new_id using SUM() window function.
SELECT new_id,new_cat,
	SUM(new_id) OVER(Partition by new_cat) 
FROM win

-- 2:Add a running total of new_id for each new_cat using ORDER BY new_id.
SELECT new_id,new_cat,
	SUM(new_id)
	OVER(PARTITION BY new_cat 
	ORDER BY new_id 
	) AS Total_sum
FROM win

-- 3:Show rank of each row within its category (new_cat) based on new_id using RANK().
SELECT new_id,new_cat,
	RANK() 
	OVER(PARTITION By new_cat 
	ORDER BY new_id) 
FROM win

-- 4:Use ROW_NUMBER() to assign a unique row number to each record within each new_cat.
SELECT new_id,new_cat,
	ROW_NUMBER() OVER(
	PARTITION BY new_cat
	ORDER BY new_id)
FROM win

-- 5:Find the difference between the current and previous new_id within each new_cat using LAG().
SELECT new_id,new_cat,
	LAG(new_id) OVER(
	ORDER BY new_id)
FROM win
-- 6:Find the difference between the current and next new_id using LEAD().
SELECT new_id,new_cat,
	LEAD(new_id) OVER(PARTITION BY new_cat ORDER BY new_id),
	LEAD(new_id) OVER(PARTITION BY new_cat ORDER BY new_id) - new_id AS difference
FROM win

-- 7:Display the maximum new_id in each category (new_cat) using a window function.
SELECT new_id,new_cat,
	MAX(new_id) OVER(PARTITION BY new_cat)
FROM win

-- 8:Add a column that shows the percentage each new_id contributes to the total of its category.
SELECT new_id, new_cat,
	ROUND(new_id*100.00, 2) / SUM(new_id) OVER(PARTITION BY new_cat) AS percentage_contribution
FROM win

-- 9:Find the average of new_id in each new_cat, and compare it with the current new_id.
SELECT new_id,new_cat,
	AVG(new_id) OVER(PARTITION BY new_cat) AS avg_new_id,
	new_id - AVG(new_id) OVER(PARTITION BY new_cat) AS difference_from_avg
FROM win

-- 10:Get top 2 new_id values per new_cat using ROW_NUMBER() or RANK().
SELECT new_id,new_cat,
	ROW_NUMBER() OVER(ORDER BY new_id) ROW_NUMBERS,
	RANK() OVER(ORDER BY new_id) RANKS
FROM win

