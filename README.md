# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  
**Level**: Beginner  
**Database**: `p1_retail_db`

This project is designed to demonstrate SQL skills and techniques typically used by data analysts to explore, clean, and analyze retail sales data. The project involves setting up a retail sales database, performing exploratory data analysis (EDA), and answering specific business questions through SQL queries. This project is ideal for those who are starting their journey in data analysis and want to build a solid foundation in SQL.

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM Test_data;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM Test_data;

SELECT * FROM Test_data
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;

DELETE FROM Test_data
WHERE 
    sale_date IS NULL OR sale_time IS NULL OR customer_id IS NULL OR 
    gender IS NULL OR age IS NULL OR category IS NULL OR 
    quantity IS NULL OR price_per_unit IS NULL OR cogs IS NULL;
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM Test_data
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
select * from Test_data 
where 
	category = 'clothing'
    and
	year(sale_date)= 2022
    and
    MONTH(sale_date) = 11
    and
    quantiy >=4;
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM Test_data 
GROUP BY category
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
    SELECT category,AVG(age) as Average_Age from test_data where category = 'Beauty';
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT transactions_id, total_sale as sale_more_than_1000 FROM test_data WHERE total_sale > 1000 GROUP BY transactions_id;
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
SELECT category, gender, COUNT(*) as total_transactions
FROM test_data  GROUP BY category,gender;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
WIth Avg_sale_by_month as
(
SELECT AVG(total_Sale) AS AVG_Sale, YEAR(Sale_date) AS Yearly_sale, MONTH(sale_date) AS Month_number FROM test_data
group by MONTH(sale_date),YEAR(Sale_date) ORDER BY YEAR(Sale_date),MONTH(sale_date)
)

SELECT MAX(AVG_Sale), Yearly_sale, Month_number FROM Avg_sale_by_month GROUP BY Yearly_sale,Month_number ORDER BY  MAX(AVG_Sale) DESC;
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT SUM(total_sale) AS sum_total_sale ,customer_id  FROM test_data GROUP BY customer_id  ORDER BY sum(total_sale) DESC LIMIT 5;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT DISTINCT(customer_id) AS Unique_customer, Category, COUNT(*) as Unique_Transactions FROM test_data GROUP BY Customer_id,Category;
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
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
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.

