Create database SQLp1;

USE SQLp1;

create table Test_data
(

    transactions_id INT PRIMARY KEY,
            sale_date	DATE,
            sale_time	TIME,
            customer_id	INT,
            gender	VARCHAR(15),
            age	INT,
            category VARCHAR(15),	
            quantiy	INT,
            price_per_unit int,	
            cogs	FLOAT,
            total_sale FLOAT
            );
            
select * from Test_data;

select distinct category from Test_data;

select * from Test_data
where sale_date = '2022-11-05';

-- write sql query to retrive all the transaction where category is clothihg and quantity is >10  for month of nov,

select * from Test_data 
where 
	category = 'clothing'
    and
	year(sale_date)= 2022
    and
    MONTH(sale_date) = 11
    and
    quantiy >=4;
    
    -- write a query to calculate total sales for each quantity.
    
    select category,sum(total_sale) as Total_sale_by_category from test_data group by category;
    
    -- write query to find avg age of the customer who purchased product bueaty.
    
    Select category,AVG(age) as Average_Age from test_data where category = 'Beauty';
    
    -- Find the transactions where total_sales >1000
	
select transactions_id, total_sale as sale_more_than_1000 from test_data where total_sale > 1000 group by transactions_id;

-- total no of transactions made by each geneder by category.

select category, gender, count(*) as total_transactions
from test_data  group by category,gender;

-- calculate avg sale for each month and find best selling minth for each year.

WIth Avg_sale_by_month as
(
select AVG(total_Sale) as AVG_Sale, YEAR(Sale_date) as Yearly_sale, MONTH(sale_date) as Month_number from test_data
group by MONTH(sale_date),YEAR(Sale_date) order by YEAR(Sale_date),MONTH(sale_date)
)

select MAX(AVG_Sale), Yearly_sale, Month_number from Avg_sale_by_month group by Yearly_sale,Month_number order by  MAX(AVG_Sale) DESC;


-- top 5 customers based on highest total sales

select sum(total_sale) as sum_total_sale ,customer_id  from test_data group by customer_id  order by sum(total_sale) DESC LIMIT 5;

-- no of unique customers who purchased items from each category.

SELECT DISTINCT(customer_id) AS Unique_customer, Category, COUNT(*) as Unique_Transactions FROM test_data GROUP BY Customer_id,Category;

-- sql query for no of orders by each shift (morning <12, afternoon 12 to 17 and evening >17)

WITH Shift_sales AS (
SELECT *,
CASE
	WHEN HOUR(sale_time) <12 THEN 'Morning'
    WHEN HOUR(sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
    ELSE 'Night'
    
END AS 'Shift_sale'
from  test_data
)

SELECT shift_sale, 
COUNT(*) AS total_orders
FROM Shift_sales
GROUP BY shift_sale;

