select * from city;
select * from products;
select * from sales;
select * from customers;

-- Q.1 Coffee Consumers Count
-- How many people in each city are estimated to consume coffee, given that 25% of the population does?

select 
	city_name,
	ROUND ((population * 0.25)/1000000,
	2) as coffee_consumer_in_millions,
	city_rank  
from city
order by 2 desc;

-- -- Q.2
-- Total Revenue from Coffee Sales
-- What is the total revenue generated from coffee sales across all cities in the last quarter of 2023?
select * from sales;
select * from products;


SELECT 
	
    SUM(total)/1000000 AS total_sales_in_millions
FROM 
    sales
WHERE 
    sale_date BETWEEN '2023-10-01' AND '2023-12-31';


-- each city revenue
SELECT 
	ci.city_name,
	SUM(s.total) as total_revenue
FROM sales as s
JOIN customers as c
ON s.customer_id = c.customer_id
JOIN city as ci
ON ci.city_id = c.city_id
WHERE 
	EXTRACT(YEAR FROM s.sale_date)  = 2023
	AND
	EXTRACT(quarter FROM s.sale_date) = 4
GROUP BY 1
ORDER BY 2 DESC;


-- Q.3
-- Sales Count for Each Product
-- How many units of each coffee product have been sold?

select * from products;
select * from sales;
SELECT 
    sales.product_id,
    products.product_name,
    EXTRACT(YEAR FROM sale_date) AS year,
    COUNT(sales.sale_id) AS total_units
FROM 
    sales
JOIN 
    products
ON 
    sales.product_id = products.product_id
GROUP BY 
    sales.product_id,
    products.product_name,
    EXTRACT(YEAR FROM sale_date)
ORDER BY 
    year,
    products.product_name;



SELECT 
	p.product_name,
	COUNT(s.sale_id) as total_orders
FROM products as p
LEFT JOIN
sales as s
ON s.product_id = p.product_id
GROUP BY 1
ORDER BY 2 DESC



-- Q.4
-- Average Sales Amount per City
-- What is the average sales amount per customer in each city?

-- city abd total sale
-- no cx in each these city
