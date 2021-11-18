# Comments

- the notebooks are old Jen's notebooks
- they need to be renamed and updated to match miro
- use `northwind_small` database for consistency with pervious episodes
    - `northwind` database can more relations and can be used for harder practice projects
    - or use it if you want to show more complex joins!
- use start/stop/ shell scripts for database usage

# `FROM` multiple tables
Often we have data stored in multiple tables that we would like to combine in query. The formal way to do this is a `JOIN` statement which will be the focus of this chapter but let's first see a quick way to do this using just a `SELECT` and `WHERE` statment. As usual, start up the database using the `start_db.sh` script. We can then connect to it using the VSCode extension or your preferred method. Once the connection is made, select the `northwind_small` database. In VSCode you can click on it and then run the following query to see the tables:

```sql
SHOW tables;
```

Now that we have our data, we can quickly see how to get data from multiple tables with a `SELECT`:

```sql
SELECT * 
FROM orders, customers
WHERE orders.customer_id = customers.id;
```

We have our usual `SELECT *` returning all columns. However, in the `FROM` statement, we have a list of comma separated table names. The `WHERE` clause then lets us filter the rows as usual except our condition is now those where the `customer_id` from `orders`, noted in `table_name.column_name` format is equal to the `customers.id`. This means we will be only getting rows where that condition holds and excluding all others (similar to the `INNER JOIN` later). This is a quick way to get data from multiple tables which is great for simple conditions but usually we will be using the powerful SQL `JOIN` statment.

# Joining in SQL
In the first chapter, we saw how to join two DataFrames. We can do the same thing with SQL tables! Joining two (or more) tables together allows us to combine information from those tables into a single table based on the joining condition. This flexibility allows us to create tables that are well suited for storing specific information but still have a mechanism to combine it with information stored in other tables. For example, if we were running a database for a small business and to track orders in one table and customer information in another, we would still be able to join these two sources together. A formal `JOIN` also gives us more syntax to control the output than our above joinless-join. Let's review the syntax of a `JOIN`

# Anatomy of  a SQL `JOIN`
A basic SQL `JOIN` will look something like this:

```sql
SELECT <Column names>
FROM <Table name>
JOIN <Table name(s)>
ON <Joining condition>
WHERE <Filter condition>
```

The `SELECT`, `FROM`, and `WHERE` are the same as we've seen before in SQL, `SELECT` tell us what columns we will be seeing in the output. A new wrinkle here is we can now access columns in all joined tables in this `SELECT`. The `FROM` tells us what table is our starting point that we are joining new tables to. The table listed in the `FROM` statement are considered the `LEFT` side of the join. If you think of lining two tables up with each other, this would put the table(s) mentioned in the `FROM` statement as the left side. This matters for the type of `JOIN` which we will explore in more detail next. The `WHERE` clause filters the output data as it would in a non-join `SELECT` statement.

## `JOIN`
As we saw in Pandas, there are multiple ways to join our data. These `JOIN` types tell us what rows to include in our output joined table. While joining, the `ON` condition is check between all the rows in both tables. The rows where the `ON` condition is true are considered matching. The type of `JOIN` then tells us what rows we will be returning. They are:
- `INNER`: Only the matching rows (those present in both tables) are returned.
- `LEFT`: All the rows in the left table (the one in the `FROM` statement) are returned. For matching rows, the information in the right table are returned and those without matches are NAN filled.
- `RIGHT`: The same as `LEFT` except all the rows from the right table are returned instead of the left table. They are also NAN filled when there is now match.


## `ON`
Gives us a condition to join our tables on. Rows for which the condition in the `ON` statement evaluate as true are joined together.

The syntax for an `ON` clause is: `ON column1 = column2` or `ON table.column1 = table.column2` if there is ambiguity about which column is supposed to come from which table (this is the case when tables share column names).


### Multiple condition using `AND` or `OR`
If there isn't a single matching column between the two tables, we can combine conditions using `AND` or `OR`. These logical operators combine the Boolean values of the individual conditions. For example, we can say: `ON order_id = order_number OR customer_id = id" if we wanted all rows with matching order numbers or matching customer numbers.

Now that we know the components of an SQL `JOIN` statement, let's start exploring it with our Northwind data.

# `JOIN` examples

## Parent-Child joins
One simple type of join is a Parent-Child join. In our data set, we have an **orders** table and its child **order_details**. Each has a **primary key** called `id` that uniquely identifies each row. Additionally, `order_details` also has the column `order_id` which stores the id of the associated order. Not only does this make joining simple,[ this is an example of a **foreign key** column](https://www.geeksforgeeks.org/difference-between-primary-key-and-foreign-key/) in the `order_details` table. This is not required to be unique per row of `order_details` but it is a reference to the unique primary key of `orders`. If we want all the orders with details, we can do the following `INNER JOIN`:

```sql
SELECT *
FROM orders
INNER JOIN order_details
ON orders.id = order_details.order_id;
```

When designing tables, all need a primary key. As we can see from this dataset, if we include the primary keys as foreign keys in our other tables, it allows us to do very simple joins. When designing a database, making sure to include foreign keys tables will save you a lot of hassle in creating complex joins in the future.

## Aliasing
We have seen aliasing when naming columns but the same can be done to the tables in a `JOIN` statement. Because we often need to reference the table names in the `SELECT` or `ON` clauses, aliasing cleans those statements up so they are more readable. We can explicitly alias a table using `AS`, e.g. `FROM orders AS o` or we can simply follow the table name with the alias we want to use: `INNER JOIN order_details d`. With the tables alias to `o` and `d`, we can rewrite our query as:

```sql
SELECT *
FROM orders AS o
INNER JOIN order_details d
ON o.id = d.order_id;
```

If we wanted all rows from `orders`, regardless of whether there were details or not, we could instead use a `LEFT JOIN`:

```sql
SELECT *
FROM orders AS o
LEFT JOIN order_details d
ON o.id = d.order_id;
```

For this example, an `RIGHT JOIN` isn't going to give us much information because the `order_details` relate to `orders` but we can always use it to make sure any orphaned details aren't excluded:

```sql
SELECT *
FROM orders AS o
RIGHT JOIN order_details d
ON o.id = d.order_id;
```

## Multiple table joins

In SQL, you can always chain together operations so long as the output from one is the correct format for the other. This applies to `JOINS` as well. If we want to `LEFT JOIN` our order details to our order and then LEFT JOIN in some of our customer information, we just need to add a second `LEFT JOIN` clause; the first one returned a table to which we're now just joining another table:

```sql
SELECT o.id, o.status, c.last_name, d.product_id, o.notes
FROM orders AS o
LEFT JOIN order_details d ON o.id = d.order_id
LEFT JOIN customers c on o.customer_id = c.id;
```

and so forth, adding more `JOIN` clauses as needed.

Another order we can chain `JOIN`s together is to join to tables, then use that output in another join statement. Let's say we want to `INNER JOIN` our `order_details` and `products` tables to get the `order_id`, `discount`, and `product_name`. We could do this with the following join:

```sql
SELECT od.order_id, od.discount, p.product_name 
FROM order_details od 
INNER JOIN products p 
ON od.product_id = p.id) d;
```

Let's say we want to join that back into our `order` to get the `status` as well. We can use the above pattern to do this sort of join:

```sql
SELECT o.id, o.status, d.product_name, d.discount
FROM orders o
LEFT JOIN (
    SELECT od.order_id, od.discount, p.product_name 
    FROM order_details od 
    INNER JOIN products p 
    ON od.product_id = p.id) d
ON o.id = d.order_id;
```

Look how our first `INNER JOIN` lives entirely within the `LEFT JOIN` clause.


We can use the same pattern if we want to calculate an aggregate statistic and add it to our data. As we learned last episode, we can use `GROUP BY` to calculate these aggregate statistic. For example, we can count the number of orders for each customer:

```sql
SELECT customer_id, COUNT(id) AS orders_per_customer 
FROM orders 
GROUP BY customer_id;
```

If we wanted to combine this count with the rest of our customer information, we can join this aggregate table into our `customers` table. We can use either a `LEFT` or an `INNER` join depending on how we want to handle customers without any orders. Let's keep them included by using a `LEFT JOIN`:

```sql
SELECT * 
FROM customers c 
LEFT JOIN (
    SELECT customer_id, COUNT(id) AS orders_per_customer 
    FROM orders 
    GROUP BY customer_id
    ) o
ON c.id = o.customer_id;
```

This also gives us a chance to revisit our `WHERE` statement to filter our data. If we want only our repeat customers, we can add a quick `WHERE` to the end of our query:

```sql
SELECT * 
FROM customers c 
LEFT JOIN (
    SELECT customer_id, COUNT(id) AS orders_per_customer 
    FROM orders 
    GROUP BY customer_id
    ) o
ON c.id = o.customer_id
WHERE o.orders_per_customer > 1;
```

By putting the clause at the end of our query, we filter the final results. If we want to filter just our subquery, we can use the `HAVING` clause we learned about last episode. If we want to return all `customers` but only include order count if they have more than 2 orders, we can do the following:

```sql
SELECT * 
FROM customers c 
LEFT JOIN (
    SELECT customer_id, COUNT(id) AS orders_per_customer 
    FROM orders 
    GROUP BY customer_id
    HAVING orders_per_customer > 2
    ) o
ON c.id = o.customer_id;
```


Similarly, if we want to calculate the average cost of shipping per state and then make a report for our `shippers` to tell them what costs to expect, we could do the following using an `INNER JOIN` so we don't bother shippers for whom we have no estimate:

```sql
SELECT *
FROM shippers s
INNER JOIN (
    SELECT ship_state_province, AVG(shipping_fee) AS state_avg 
    FROM orders 
    GROUP BY ship_state_province
    ) t
on s.state_province = t.ship_state_province;
```

And that concludes our discussion of `JOIN`s! As you can see, the basic syntax allows for straightforward data combining while the flexibility allows us to cleverly chain our `JOIN` statements to calculate complex relations within our data.

## Normalization
**PARHAM**: I touched on this concept above in our first join but I'm not sure what else needs to be said or how to frame it as it's a discussion about the table creation not the joining. Can you write a quick paragraph for this section?
Normalization: parent/child with ids
primary/foreign key
How to design 1:1, 1:many, and many:many tables
