/* Show the tables in our database */
show tables;

/* SELECT from multiple tables using a WHERE condition to return rows where the two values match */

SELECT * 
FROM orders, customers
WHERE orders.customer_id = customers.id;

/* Join orders and its associated order details with an INNER JOIN */
SELECT *
FROM orders
INNER JOIN order_details
ON orders.id = order_details.order_id;

/* The same join with aliases, both explicit AS and implied */
SELECT *
FROM orders AS o
INNER JOIN order_details d
ON o.id = d.order_id;

/* The LEFT JOIN so all orders are returned */
SELECT *
FROM orders AS o
LEFT JOIN order_details d
ON o.id = d.order_id;

/* RIGHT JOIN so no details are excluded */
SELECT *
FROM orders AS o
RIGHT JOIN order_details d
ON o.id = d.order_id;


/* Join the orders with details and customers*/
SELECT o.id, o.status, c.last_name, d.product_id, o.notes
FROM orders AS o
LEFT JOIN order_details d ON o.id = d.order_id
LEFT JOIN customers c on o.customer_id = c.id;

/* Do an INNER JOIN on order details and products and then LEFT JOIN that to orders */
SELECT o.id, o.status, d.product_name, d.discount
FROM orders o
LEFT JOIN (
    SELECT od.order_id, od.discount, p.product_name 
    FROM order_details od 
    INNER JOIN products p 
    ON od.product_id = p.id
    ) d
ON o.id = d.order_id;

/* Calculate orders per customer, then join with each customer */
SELECT * 
FROM customers c 
LEFT JOIN (
    SELECT customer_id, COUNT(id) AS orders_per_customer 
    FROM orders 
    GROUP BY customer_id
    ) o
ON c.id = o.customer_id;