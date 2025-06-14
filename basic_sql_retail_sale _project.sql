--creating an table to import data from excel
drop table if exists retail_sale;
create table retail_sales 
(
transactions_id int primary key ,
sale_date date	,
sale_time TIME ,
customer_id	int,
gender varchar(15),	
age	 int ,
category varchar(15) ,	
quantity int,
price_per_unit float	,
cogs float	,
total_sale float
);

select * from retail_sales

--importing data (without code)

-- deleting null value rows
select * from retail_sales
where transactions_id is null 
	or 
	sale_date is null
	or 
	sale_time is null
	or 
	customer_id is null
	or 
	gender is null
	or
	age is null
	or 
	category is null 
	or 
	quantity is null
	or 
	price_per_unit is null
	or 
	cogs is null
	or
	total_sale is null

--changing quantity column name
alter table retail_sales
rename column quantiy to quantity

--deleting null value rows
delete from retail_sales
where transactions_id is null 
	or 
	sale_date is null
	or 
	sale_time is null
	or 
	customer_id is null
	or 
	gender is null
	or
	age is null
	or 
	category is null 
	or 
	quantity is null
	or 
	price_per_unit is null
	or 
	cogs is null
	or
	total_sale is null

--data exploration

-- My Analysis & Findings

-- Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'

-- Q2. Write a SQL query to retrieve all transactions where the category is 'Clothing' 
--     and the quantity is >2 in the month of Nov-2022

-- Q3. Write a SQL query to calculate the total sales (total_sale) for each category

-- Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category

-- Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000

-- Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category

-- Q7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year

-- Q8. Write a SQL query to find the top 5 customers based on the highest total sales

-- Q9. Write a SQL query to find the number of unique customers who purchased items from each category

-- Q10. Write a SQL query to create each shift and number of orders 
--       (Example: Morning <12, Afternoon Between 12 & 17, Evening >17)


--ques1
select count(distinct customer_id) as unique_customer from retail_sales
--number of unique category
select count(distinct category) as no_of_category from retail_sales
select * from retail_sales
--sales on date 2022-11-05
select * from retail_sales
where sale_date= '2022-11-05'

--ques-2
--selecting all transaction in november whose quantity is greater than 4 and category is clothing 
select * from retail_sales
where category= 'Clothing'
and 
quantity >= 4
and
To_char(sale_date,'YYYY-MM')='2022-11'

--ques3
select sum(total_sale) as total_sales ,category from retail_sales
group by category

--ques-4
select round(avg(age),2) , category from retail_sales
group by category
having category='Beauty' 

--ques5
select * from retail_sales
where total_sale>1000

--ques-6
select category ,gender, count(*) as total_trans
from retail_sales
group by category,gender 
order by 1

--ques7
select extract(year from sale_date) as year,
	extract(month from sale_date) as month,
	avg(total_sale) as avg_sale
from retail_sales
group by 1,2
order by 1,2

--ques8
select customer_id , sum(total_sale) as total_sales
from retail_sales
group by customer_id
order by total_sales desc

--ques9
select category, count(customer_id) as numberofuniquecustomer
from retail_sales
group by category
order by numberofuniquecustomer desc 

--ques10

with hourly_sale
as(SELECT *,
    CASE
        WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
    END AS shift
FROM retail_sales
)
select shift , count(*)
from hourly_sale
group by shift 






