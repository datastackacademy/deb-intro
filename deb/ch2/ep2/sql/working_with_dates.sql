-- ----------------------------------------------------------
-- DATES
-- ----------------------------------------------------------

-- switch to using the northwind database which has date columns
use northwind;

-- there are columns with dates AS their data type
-- you can use date functions to manipulate these values 
-- for complete list of date functions see: https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html

-- extract a portion of the date
-- here we extract the year, month, and day portion
SELECT order_date, YEAR(order_date) AS year, MONTH(order_date) AS month, DAY(order_date) AS day FROM orders;

-- more complex example to extract the day of the week and week of the year
SELECT 
    order_date, 
    WEEKDAY(order_date) AS weekday, 
    DAYNAME(order_date) AS weekday_name,
    MONTHNAME(order_date) AS monthname,
    WEEKOFYEAR(order_date) AS weekofyear
FROM orders;

-- add or subtract to dates
SELECT 
    order_date, 
    DATE_ADD(order_date, INTERVAL 2 DAY) AS plus_2_days,
    DATE_ADD(order_date, INTERVAL 2 WEEK) AS plus_2_weeks
FROM orders;

-- you can use negative values
SELECT 
    order_date, 
    DATE_ADD(order_date, INTERVAL -2 DAY) AS minus_2_days,
    DATE_ADD(order_date, INTERVAL -2 WEEK) AS minus_2_weeks
FROM orders;

-- there are also function to return the current date/time
SELECT 
    order_date, 
    CURRENT_DATE() AS cur_date,
    CURRENT_TIME() AS cur_time
FROM orders;

-- or simply
SELECT CURRENT_DATE() AS cur_date, CURRENT_TIME() AS cur_time;


-- use DATEDIFF and TIMEDIFF to get the difference between two dates
-- DATEDIFF returns number of days
-- TIMEDIFF returns a time difference (hour, minute, second)
SELECT 
    order_date,
    shipped_date,
    DATEDIFF(shipped_date, order_date) AS num_days_to_ship,
    TIMEDIFF(shipped_date, order_date) AS time_to_ship
FROM orders;
