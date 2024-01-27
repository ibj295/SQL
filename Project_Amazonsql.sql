------------------------------------
/*--Create Database Amazon--*/
CREATE DATABASE IF NOT EXISTS amazon;

-------------------------------------
/*--Use database Amazon--*/
USE  amazon;

-------------------------------------
/*--Create Table amazonsalesreport--*/

CREATE TABLE IF NOT EXISTS`amazon_sales_report` 
(
    `Order ID`	INT,
    `Date`	VARCHAR(12),
    `Status`	VARCHAR(50),
    `Fulfilment`	VARCHAR(50),
    `ship-service-level`	VARCHAR(50),
    `Style`	VARCHAR(50),
    `Category`	VARCHAR(50),
    `Size`	VARCHAR(50),
    `Courier Status`	VARCHAR(50),
    `Qty`	VARCHAR(50),
    `Amount`	INT,
    `ship-city`	VARCHAR(50),
    `ship-state`	VARCHAR(50),
    `B2B`	VARCHAR(50)
);

/* --Insert into table --*/

INSERT INTO amazon_sales_report VALUES
('1', '12/4/22', 'Shipped', 'Amazon', 'Expedited', 'J0080', 'Top', 'XS', 'Shipped', '1', '531', 'AHMEDABAD', 'Gujarat', 'FALSE'),
('2', '12/4/22', 'Shipped', 'Amazon', 'Expedited', 'J0122', 'Top', '3XL', 'Shipped', '1', '329', 'Mumbai', 'MAHARASHTRA', 'FALSE');

/*--Inserted 1000 records in table--*/

/*--Describe table to check Table details--*/
DESCRIBE amazon_sales_report;

/*--Check 1st five record--*/
SELECT * FROM amazon_sales_report
LIMIT 5;

/*---ORDER ANALYSIS---*/
/*---Total Order---*/
SELECT COUNT(Order_id) AS Total_Orders
FROM amazon_sales_report;

/* ---Total_Sales---*/
SELECT Round(Sum(amount))
FROM   amazon_sales_report; 

/*---Total Category---*/
SELECT Count(DISTINCT( category )) AS Category_count
FROM   amazon_sales_report; 

/*---Average Order value ---*/
SELECT Round(Avg(amount)) AS Average_Order_Amt
FROM   amazon_sales_report;

/*Sales by Category*/
SELECT category,
       Sum(amount) AS Total_Sales
FROM   amazon_sales_report
GROUP  BY category
ORDER  BY total_sales DESC; 

/*To selling state*/

SELECT state,
       Round(Sum(amount)) AS Total_Sales
FROM   amazon_sales_report
GROUP  BY state
ORDER  BY total_sales DESC
LIMIT  1; 

/*Order by date*/

SELECT date,
       Count(order_id)
FROM   amazon_sales_report
GROUP  BY date; 

/*Total Sales By Date*/

SELECT date,
       round(Sum(amount)) AS Total_Sales
FROM   amazon_sales_report
GROUP  BY date
ORDER  BY total_sales DESC; 

/*Total Order count by status*/

SELECT status,
       Count(order_id) AS Total_Orders
FROM   amazon_sales_report
GROUP  BY status
ORDER  BY total_orders DESC; 

/*Day wise shipped and cancelled order count*/

select date,
count(case when status = 'Shipped' then order_id end) as 'Total_Shipped_orders',
count(Case when status =  'Cancelled' then order_id end) as 'Total_Cancelled_Orders'
from amazon_sales_report
group by date;

/* Fulfilment sales Amazon or Merchant*/

select date,
sum(case when Fulfilment = 'Amazon' then amount end ) as "Amazon sales",
sum(case when Fulfilment = 'Merchant' then amount end ) as "Merchant Sales"
from amazon_sales_report
group by date;

/*Sales Wise Top Five City  */

select ship_city, sum(amount) as Total_Sales
from amazon_sales_report
group by ship_city
order by Total_Sales desc
limit 5 ;

/* state having Sales less than Avg sales */

select state, sum(amount) as Total_Sales
from amazon_sales_report
group by state
having Total_Sales < (select avg(amount) from amazon_sales_report)
order by Total_Sales desc;

/*Category wise top sales*/

select category,max(amount) as Max_amount
from amazon_sales_report
group by category; 

/*state wise higest and lowest sales*/

(select state, sum(amount) Total_Sales
from amazon_sales_report
group by state
order by Total_Sales desc
limit 1)
union
(select state, sum(amount) as Total_Sales
from amazon_sales_report
group by state
order by Total_Sales Asc
limit 1); 

/*Size wise Total quantity and amount*/

SELECT size,
       Count(order_id) AS Total_Orders,
       Sum(amount)     AS Total_Sales
FROM   amazon_sales_report
GROUP  BY size
ORDER  BY total_sales DESC;

/*Category and size wise quantity sold*/ 

select category,
count(case when size = 'L' then order_id end ) as L_Size_Count,
count(case when size = 'S' then order_id end ) as S_Size_count,
count(case when size = 'M' then order_id end ) as M_Size_count,
count(case when size = 'XS' then order_id end ) as XS_Size_count,
count(case when size = '3XL' then order_id end ) as 3XL_Size_count,
count(case when size = 'XL' then order_id end ) as XL_Size_count
from amazon_sales_report
group by category;
