# Challenge questions
For these challenges as with Episode 1, use the `northwind_small` database. This database is already included in our `start_db.sh` script so simply connect to the Docker container as usual using VSCode's extension or `connect_db.sh` and running:

```sql
use northwind_small;
```

With the database up and running, create SQL scripts to complete the following challenges.

## Sub queries
1. Find all `customers` with an order placed after April, 2006 using a sub query on `orders` to return the `customer_id` and a `WHERE id IN` query on `customers`.
1. Using a sub query, find all of the `orders` handled by employee "Nancy Freehafer" and "Andrew Cencini".

## String manipulation
1. Find all `shippers` in states starting with N.
1. Find all `employees` whose notes say they are fluent in a language.

## Date manipulations
1. Find all orders placed on the weekends using `WEEKDAY` or `DAYNAME`.
1. Using `DATEDIFF`, find all orders with more than 3 days between being placed and being shipped.
