/* Show the tables in our database */
show tables;


/* Count the total number of orders */
SELECT COUNT(*) FROM orders;


/* Count the total orders filled by employee 9 */
SELECT COUNT(employee_id) FROM orders WHERE employee_id = 9;


/* Shwoing the difference between counting all and counting distinct */
SELECT COUNT(employee_id), COUNT(DISTINCT employee_id) FROM orders;


/* Find the total list price of our products */
SELECT SUM(list_price) FROM products;


/* Find the total list price of our products if they cost us less than 10 dollars*/
SELECT SUM(list_price) FROM products WHERE standard_cost < 10;


/* Find our most expensive and cheapest products */
SELECT MAX(list_price), MIN(list_price) FROM products;


/* Find the average list price of our products */
SELECT AVG(list_price) FROM products;


/* Group our orders by customer, find the total number of orders per customer */
SELECT customer_id, COUNT(id) FROM orders GROUP BY customer_id;


/* Find the total shipping fees for each state */
SELECT ship_state_province, SUM(shipping_fee) FROM orders GROUP BY ship_state_province;


/* For each customer and empolyee pair, find the number of orders and the average shipping fee */
SELECT customer_id, employee_id, COUNT(*), AVG(shipping_fee) FROM orders GROUP BY customer_id, employee_id;


/* Group our orders by customer, find the total number of paid orders per customer */
SELECT customer_id, COUNT(id) FROM orders WHERE paid_date IS NOT NULL GROUP BY customer_id;

/* Group our orders by customer, find the total number of paid orders per customer 
then return those with more than 2 paid orders*/
SELECT customer_id, COUNT(id) order_count 
FROM orders 
WHERE paid_date IS NOT NULL 
GROUP BY customer_id 
HAVING order_count >2;