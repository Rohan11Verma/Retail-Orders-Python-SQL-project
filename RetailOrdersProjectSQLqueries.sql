#find the total sales
select sum(sale_price) as sales from ret;


#compare the sales for the years 2022 and 2023
select year(order_date) as order_year, sum(sale_price) from ret group by order_year;


#find the total profit made
select sum(profit) as profit_gen from ret;


#compare the profits for the years 2022 and 2023
select year(order_date) as order_year, sum(profit) from ret group by order_year;


#find the average price of products
select avg(sale_price) as average_price from ret;


#which ship mode is used to transfer the maximum quantity
select ship_mode,sum(quantity) as total_quantity_shipped from ret group by ship_mode order by total_quantity_shipped desc limit 1;


#which category is the most profitable
select category, sum(profit) as profit_gen from ret group by category order by profit_gen desc limit 1;


#find the top 5 cities where the maximum profit occurs
select city,sum(profit) as profit_gen from ret group by city order by profit_gen desc limit 5;


#find the segment which generates most revenue
select segment,sum(sale_price) as sales from ret group by segment order by sales desc limit 1;


#find the most profitable product
select product_id, sum(profit) as profit_gen from ret group by product_id order by profit_gen desc limit 1;


#find the most saleable state
select state,sum(sale_price) as sales from ret group by state order by sales desc limit 1;


#find the most profitable state
select state,sum(profit) as profit_gen from ret group by state order by profit_gen desc limit 1;


#find the least profitable product
select product_id, sum(profit) as profit_gen from ret group by product_id order by profit_gen limit 1;


#find top 10 highest profit generating sub-categories
select sub_category,sum(profit) as profit_gen from ret group by sub_category order by profit_gen desc limit 10;

 
#find top 10 highest revenue generating products
select product_id, sum(sale_price) as revenue from ret group by product_id order by revenue desc limit 10;


#find top 5 highest selling products in each region by quantity
select region, product_id, sum(quantity) as units_sold from ret group by region, product_id order by units_sold desc limit 5;


#find top 5 highest revenue generating products in each region
with cte as 
(select region, product_id, sum(sale_price) as revenue_gen from ret group by region, product_id)
select * from (select *, row_number() over (partition by region order by revenue_gen desc) as rn from cte) a where rn<=5
;


#for each category which month has highest sales
with cte as 
(select category, year(order_date) as order_year, month(order_date) as order_month, sum(sale_price) as sales from ret group by order_year,order_month, category) 
select * from 
(select *, row_number() over(partition by category order by sales desc) as rn 
from cte) 
a where rn=1;