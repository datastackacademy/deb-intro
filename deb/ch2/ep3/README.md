# Aggregating and grouping data
Often when we have data, we want to know facts about multiple rows in a table. This can be as simple as wanting to know the the total number of orders we've received or knowing the highest price item in our inventory. The functions that apply across rows are known as **aggregation functions**. We will learn how to use these on our table to explore and understand our data. 

Sometimes, in addition to wanting to know facts about multiple rows, we want to know facts about specific groups of our data. For example, what if we want to know how many orders *each* customer has made? Or the total number of flights from each airport? All of these involve an aggregation like before but there is also a step were we group the data by a specific column first. We will tackle these after we learn the aggregation functions.

To get started, run the `start_db.sh` script. We can then connect to it using the VSCode extension or your preferred method. Once the connection is made, select the `northwind_small` database. In VSCode you can click on it and then run the following query to see the tables:

```sql
SHOW tables;
```

We are now ready to learn about our aggregation functions

## Aggregation functions
As noted, if we want to know a fact about multiple rows in a table, we turn to the SQL aggregation functions. They calculate a value across all the rows in the query and return a single value back. Let's start with the simplest aggregation function.

### `COUNT`
The most basic aggregation function is `COUNT()`. It simply counts the number of rows in the query. For example, if we want to know the total number of orders, we can simply a simple query:

```sql
SELECT COUNT(*) FROM orders;
```

Since we are simply counting rows, we can apply our function using the wildcard: `COUNT(*)` or apply it to a specific column name. As an aggregation function, we get a single value back; this `COUNT` is simply acting on the entire table and counting rows which returns this single value. This tells us there are 48 rows in the orders table, which means we have 48 total orders in the `northwind_small` data set. 

We can also combine this aggregation function with a `WHERE` clause. This `WHERE` functions exactly as we've seen before; it filters the `SELECT` to just the rows where the condition is true. *Then* the aggregation function is applied to just those rows. For example, if we want to know how many orders employee number 9 has filled, we can run the following query:

```sql
SELECT COUNT(employee_id) FROM orders WHERE employee_id = 9;
```

And we see employee 9 has pulled 10 orders! 

We can also tell `COUNT` to only count the number of unique values within the rows, not just the total number of rows. To do this, we simply add the word `DISTINCT` before the column name in our `COUNT` function. Let's `COUNT` `employee_id` and `DISTINCT` `employee_id` to see the difference (this also shows how you can combine multiple aggregation functions in a single query):

```sql
SELECT COUNT(employee_id), COUNT(DISTINCT employee_id) FROM orders;
```

### `SUM`

The next aggregation function we will look at is `SUM`. This functions does what it sounds like on, it adds all the values in the specified column across the rows in the query. For example, if we want to know the total listed prices of our products, we would run:

```sql
SELECT SUM(list_price) FROM products;
```

As with `COUNT`, we can add a filter on the rows we're adding using a `WHERE` statement. Say we want the total list price for products that cost us less than 10 dollars:

```sql
SELECT SUM(list_price) FROM products WHERE standard_cost < 10;
```

`SUM` can also take the `DISTINCT` argument if we desire.

### `MIN` and `MAX`

The next pair of aggregation functions we will look at is `MIN` and `MAX`. As you would expect, they return the smallest value and the largest value in the query for the specified columns. Let's find our most expensive products and cheapest products:

```sql
SELECT MAX(list_price), MIN(list_price) FROM products;
```

### `AVG`
The final aggregation function we will learn is `AVG`. This calculates the average value of the specified column by summing the values and dividing by the total number of values. For example, we can see the average list price of our products like this:

```sql
SELECT AVG(list_price) FROM products;
```

We can use `WHERE` to filter our rows and `DISTINCT` to average only unique values.

With this understanding of the SQL Aggregation functions, let's turn to grouping our data.

# `GROUP BY`
Often we don't want to know values for an entire table, we instead want to know values for specific groups within that table. This is where the `GROUP BY` statement comes into play. It follows the `FROM` statement and is a list of columns. The rows are then grouped by the unique values within those columns. Once we have our data grouped, we can then apply one of the same SQL functions we have been using to each group to get a single value for that entire group. For example, if we want to know how many orders each customer has placed, we can `GROUP` our `orders` table `BY` `customer_id` and then simply `COUNT` the rows within each group. The following query does just that:

```sql
SELECT customer_id, COUNT(id) FROM orders GROUP BY customer_id;
```

We note that within the `SELECT`, we want to include only the columns we are grouping by *or* aggregated values; otherwise we have multiple values for each group. Depending on the flavor of our database, this will either give us errors or simply choose one of the values to return without giving us any control.

Another grouping example could be to calculate the total shipping fees to each state. For this, we want to `GROUP BY ship_state_province` and then `SUM(shipping_fee)`:

```sql
SELECT ship_state_province, SUM(shipping_fee) FROM orders GROUP BY ship_state_province;
```

## Multiple columns
Our `GROUP BY` statement can be more than one column; we can simply provide a comma separated list of column names and our data is grouped by the unique value combinations within those columns. For example, if we wanted to know the total number of orders and average shipping fee for each customer and employee pair, we could query the following:

```sql
SELECT customer_id, employee_id, COUNT(*), AVG(shipping_fee) FROM orders GROUP BY customer_id, employee_id;
```

As we can see in the output, we get aggregation values for each pair of employee and customer as we wanted! There is no limit to the number of columns we can `GROUP BY` though there may be diminishing returns for aggregated values on small groups. 


## `WHERE` vs `HAVING`

In our base aggregation functions, we used `WHERE` to filter our values before aggregating. We can do the same for a `GROUP BY`. For example, if we want to count only orders that *have already been paid for* for each customer, we can just add a `WHERE paid_date IS NOT NULL` to our existing query following the `FROM` statement:

```sql
SELECT customer_id, COUNT(id) FROM orders WHERE paid_date IS NOT NULL GROUP BY customer_id;
```
The important detail here is that the `WHERE` filters our table *before* any grouping happens. If we want to filter our rows *after* the grouping and aggregation, we need to use a `HAVING` statement. For example, if we want to know what customers have more than 2 orders, we would add a column alias for our order count and add a `HAVING` filter to the end of our query:

```sql
SELECT customer_id, COUNT(id) order_count 
FROM orders 
WHERE paid_date IS NOT NULL 
GROUP BY customer_id 
HAVING order_count >2;
```

As we can see, the `HAVING` statement is what allows us to filter the output from our `GROUP BY` and aggregation.
