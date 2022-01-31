# Challenge questions
For these challenges, use the `northwind_small` database. This database is already included in our `start_db.sh` script so simply connect to the Docker container as usual using VSCode's extension or `connect_db.sh` and running:

```sql
use northwind_small;
```

With the database up and running, create SQL scripts to complete the following challenges.

## `SELECT` challenges
1. Select all "Purchasing Manager" from `customers`. 
1. Select the employee id and last name of all "Sales Representative" in `employees`
1. Select all "New" `orders` with `order_date` after March, 2006 and order them by date shipped.

## DML challenges
1. Insert a new order:
    1. With existing customers, employees, etc. Query the respective tables for real values, then add a new row to `orders` and `order_details`.
    1. Insert a new customer _and_ their first order.
1. Update the all status 'Shipped' orders to 'Closed'.
1. Update all `orders` with status "New" and a shipping date to "Shipped".

## DDL challenges
1. Create a new database named `southwind`.
1. Replicate the tables in `northwind_small` as  _empty_ tables with the _same_ schema in `southwind`.
1. Create an `owners` table in `southwind` that includes _only_ the customers whose job title is "Owner".